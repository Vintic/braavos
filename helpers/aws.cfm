<cfscript>
public string function awsCliPackage() {
	if (server.os.name contains "windows") {
		return "c:\aws\aws.exe";
	} else if (server.os.name contains "linux") {
		return "aws";
	} else if (server.os.name contains "mac") {
		return "aws";
		// return "/usr/local/bin/aws";
	}
}

public binary function awsSign(required string message, required string key) {
	return binaryEncode(
		binaryDecode(
			hmac(
				arguments.message,
				arguments.key,
				"hmacSHA1",
				"utf-8"
			),
			"hex"
		),
		"base64"
	);
}

public struct function getAWSUploaderPolicy() {
	var expiration = dateConvert("local2utc", dateAdd("d", 1, now()));
	var policy = {
		"expiration" = dateFormat(expiration, "yyyy-mm-dd") & "T" & timeFormat(expiration, "HH:mm:ss") & "Z",
		"conditions" = [
			{"bucket" = get("plupload").chunkingBucketName},
			{"acl" = "private"},
			{"success_action_status" = "2xx"},
			["starts-with", "$key", ""],
			[
				// https://docs.aws.amazon.com/AmazonS3/latest/API/sigv4-HTTPPOSTConstructPolicy.html
				// This condition supports exact matching and starts-with condition match type.
				"starts-with",
				"$Content-Type",
				""
			],
			[
				"content-length-range",
				0,
				50 * 1024 * 1024 // 50MB
			],
			["starts-with", "$Filename", ""],
			["starts-with", "$name", ""],
			["starts-with", "$chunk", ""],
			["starts-with", "$chunks", ""]
		]
	};
	var serializedPolicy = serializeJSON(policy);
	var serializedPolicy = replace(serializedPolicy, "2xx", "201"); // string
	var serializedPolicy = reReplace(serializedPolicy, "[\r\n]+", "", "all");
	var encodedPolicy = binaryEncode(charsetDecode(serializedPolicy, "utf-8"), "base64");
	var encodedSignature = _hmacSha1(encodedPolicy, env("AWS_SECRET_ACCESS_KEY"), "base64");
	return {"policy" = encodedPolicy, "signature" = encodedSignature}
}

function _hmacSha1(required string message, required string key, required string encoding) {
	var secretkeySpec = createObject("java", "javax.crypto.spec.SecretKeySpec").init(
		charsetDecode(arguments.key, "utf-8"),
		javacast("string", "HmacSHA1")
	);
	var mac = createObject("java", "javax.crypto.Mac").getInstance(javacast("string", "HmacSHA1"));
	mac.init(secretkeySpec);
	var hashedBytes = mac.doFinal(charsetDecode(arguments.message, "utf-8"));
	if (arguments.encoding == "base64") {
		return binaryEncode(hashedBytes, "base64");
	} else if (arguments.encoding == "hex") {
		return uCase(binaryEncode(hashedBytes, "hex"));
	}
	throw("Unknown encoding.");
}

public string function getAWSUploadId(required string destinationKey) {
	var v4 = new services.aws.v4sig(
		accessKeyId = env("AWS_ACCESS_KEY_ID"),
		secretAccessKey = env("AWS_SECRET_ACCESS_KEY")
	);
	var resource = arguments.destinationKey & "?uploads";
	var signature = v4.generateSignatureData(
		regionName = get("plupload").region,
		serviceName = "s3",
		requestMethod = "POST",
		hostName = get("plupload").endpoint,
		requestURI = arguments.destinationKey,
		requestHeaders = {
			"x-amz-content-sha256" = "STREAMING-AWS4-HMAC-SHA256-PAYLOAD",
			"Content-Encoding" = "aws-chunked",
			"Content-Length" = 0
		},
		requestParams = {"uploads" = ""}
	);
	var h = new http(method = "post", url = "https://" & get("plupload").endpoint & resource);
	h.addParam(type = "header", name = "Authorization", value = signature.authorizationHeader);
	for (var i in signature.requestHeaders) {
		h.addParam(type = "header", name = i, value = signature.requestHeaders[i]);
	}
	var rsp = h.send().getPrefix();
	if (!find("200", rsp.statusCode) || !isXML(rsp.fileContent)) {
		return "";
	}
	var response = xmlParse(rsp.fileContent);
	var uploadId = xmlSearch(response, "string(//*[local-name()='UploadId'])");
	return uploadId;
}

public array function getAWSETags(
	required string destinationKey,
	required string uploadId,
	required string sourceKey,
	required numeric uploadedChunks
) {
	var v4 = new services.aws.v4sig(
		accessKeyId = env("AWS_ACCESS_KEY_ID"),
		secretAccessKey = env("AWS_SECRET_ACCESS_KEY")
	);
	var etags = [];
	for (var chunk = 0; chunk < arguments.uploadedChunks; chunk++) {
		var resource = arguments.destinationKey & "?partNumber=#int(chunk + 1)#&uploadId=#arguments.uploadId#";
		var signature = v4.generateSignatureData(
			regionName = get("plupload").region,
			serviceName = "s3",
			requestMethod = "PUT",
			hostName = get("plupload").endpoint,
			requestURI = arguments.destinationKey,
			requestHeaders = {"x-amz-copy-source" = arguments.sourceKey & "." & chunk},
			requestParams = {"partNumber" = int(chunk + 1), "uploadId" = arguments.uploadId}
		);
		var h = new http(method = "put", url = "https://" & get("plupload").endpoint & resource);
		h.addParam(type = "header", name = "Authorization", value = signature.authorizationHeader);
		for (var i in signature.requestHeaders) {
			h.addParam(type = "header", name = i, value = signature.requestHeaders[i]);
		}
		var rsp = h.send().getPrefix();
		if (!find("200", rsp.statusCode) || !isXML(rsp.fileContent)) {
			return [];
		}
		var response = xmlParse(rsp.fileContent);
		var etag = xmlSearch(response, "string(//*[local-name()='ETag'])");
		arrayAppend(etags, etag);
	}
	return etags;
}

public boolean function completeAWSUpload(
	required string destinationKey,
	required string uploadId,
	required numeric uploadedChunks,
	required array eTags
) {
	var v4 = new services.aws.v4sig(
		accessKeyId = env("AWS_ACCESS_KEY_ID"),
		secretAccessKey = env("AWS_SECRET_ACCESS_KEY")
	);
	var xml = ["<CompleteMultipartUpload>"];
	for (var chunk = 0; chunk < arguments.uploadedChunks; chunk++) {
		arrayAppend(
			xml,
			"<Part>" &
			"<PartNumber>#int(chunk + 1)#</PartNumber>" &
			"<ETag>#arguments.eTags[chunk + 1]#</ETag>" &
			"</Part>"
		);
	}
	arrayAppend(xml, "</CompleteMultipartUpload>");
	var body = arrayToList(xml, chr(10));
	var resource = arguments.destinationKey & "?uploadId=#arguments.uploadId#";
	var signature = v4.generateSignatureData(
		regionName = get("plupload").region,
		serviceName = "s3",
		requestMethod = "POST",
		hostName = get("plupload").endpoint,
		requestURI = arguments.destinationKey,
		requestBody = body,
		requestHeaders = {"Content-Length" = len(body)},
		requestParams = {"uploadId" = arguments.uploadId}
	);
	var h = new http(method = "post", url = "https://" & get("plupload").endpoint & resource);
	h.addParam(type = "header", name = "Authorization", value = signature.authorizationHeader);
	h.addParam(type = "body", value = body);
	for (var i in signature.requestHeaders) {
		h.addParam(type = "header", name = i, value = signature.requestHeaders[i]);
	}
	var rsp = h.send().getPrefix();
	if (!find("200", rsp.statusCode) || !isXML(rsp.fileContent)) {
		return false;
	}
	var response = xmlParse(rsp.fileContent);
	// var file = xmlSearch(response, "string(//*[local-name()='Location'])");
	return true;
}

public boolean function moveAWSUpload(required string destinationKey, required string sourceKey) {
	var v4 = new services.aws.v4sig(
		accessKeyId = env("AWS_ACCESS_KEY_ID"),
		secretAccessKey = env("AWS_SECRET_ACCESS_KEY")
	);
	var resource = arguments.destinationKey;
	var signature = v4.generateSignatureData(
		regionName = get("plupload").region,
		serviceName = "s3",
		requestMethod = "PUT",
		hostName = get("plupload").endpoint,
		requestURI = arguments.destinationKey,
		requestHeaders = {"x-amz-copy-source" = arguments.sourceKey}
	);
	var h = new http(method = "put", url = "https://" & get("plupload").endpoint & resource);
	h.addParam(type = "header", name = "Authorization", value = signature.authorizationHeader);
	for (var i in signature.requestHeaders) {
		h.addParam(type = "header", name = i, value = signature.requestHeaders[i]);
	}
	var rsp = h.send().getPrefix();
	if (!find("200", rsp.statusCode) || !isXML(rsp.fileContent)) {
		return false;
	}
	var response = xmlParse(rsp.fileContent);
	// var etag = xmlSearch(response, "string(//*[local-name()='ETag'])");
	return true;
}

public boolean function cleanupAWSUpload(required string s3Key, required numeric uploadedChunks) {
	var v4 = new services.aws.v4sig(
		accessKeyId = env("AWS_ACCESS_KEY_ID"),
		secretAccessKey = env("AWS_SECRET_ACCESS_KEY")
	);
	var xml = ["<Delete>"];
	arrayAppend(xml, "<Quiet>true</Quiet>");
	if (arguments.uploadedChunks == 0) {
		arrayAppend(
			xml,
			"<Object>" &
			"<Key>#arguments.s3Key#</Key>" &
			"</Object>"
		);
	} else {
		for (var chunk = 0; chunk < arguments.uploadedChunks; chunk++) {
			arrayAppend(
				xml,
				"<Object>" &
				"<Key>#arguments.s3Key#.#chunk#</Key>" &
				"</Object>"
			);
		}
	}
	arrayAppend(xml, "</Delete>");
	var body = arrayToList(xml, chr(10));
	var signature = v4.generateSignatureData(
		regionName = get("plupload").region,
		serviceName = "s3",
		requestMethod = "POST",
		hostName = get("plupload").endpoint,
		requestURI = "/" & get("plupload").chunkingBucketName & "/",
		requestBody = body,
		requestHeaders = {"Content-Length" = len(body), "Content-MD5" = v4.getMd5Hash(body)},
		requestParams = {"delete" = ""}
	);
	var h = new http(
		method = "post",
		url = "https://" & get("plupload").endpoint & "/" & get("plupload").chunkingBucketName & "/?delete"
	);
	h.addParam(type = "header", name = "Authorization", value = signature.authorizationHeader);
	h.addParam(type = "body", value = body);
	for (var i in signature.requestHeaders) {
		h.addParam(type = "header", name = i, value = signature.requestHeaders[i]);
	}
	var rsp = h.send().getPrefix();
	if (!find("200", rsp.statusCode) || !isXML(rsp.fileContent)) {
		return false;
	}
	var response = xmlParse(rsp.fileContent);
	return true;
}
</cfscript>
