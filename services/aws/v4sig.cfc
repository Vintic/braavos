component {

	property name="accessKeyId" type="string" default="";
	property name="secretAccessKey" type="string" default="";

	public any function init(
		required string accessKeyId,
		required string secretAccessKey
	) {
		this.accessKeyId = arguments.accessKeyId;
		this.secretAccessKey = arguments.secretAccessKey;
		return this;
	}

	public any function generateSignatureData(
		required string regionName,
		required string serviceName,
		required string requestMethod,
		required string hostName,
		required string requestUri,
		string requestBody = "",
		struct requestHeaders = {},
		struct requestParams = {},
		any ts = ""
	) {

		var st = {
			"signature" = "",
			"authorizationHeader" = "",
			"requestHeaders" = {}
		};

		if(Len(arguments.ts)) {
			var _utc = arguments.ts;
		} else {
			var _utc = dateConvert("local2utc", Now());
		}
		var dateStamp = dateFormat(_utc, "yyyymmdd");
		var amzDate = dateFormat(_utc, "yyyymmdd") & "T" & timeFormat(_utc, "HHmmss") & "Z";

		var qs = [];
		for(var i in structSort(arguments.requestParams)) {
			arrayAppend(qs, i & "=" & uriEncode(arguments.requestParams[i]));
		}
		var canonicalQuerystring = arrayToList(qs, "&");

		var allHeaders = Duplicate(arguments.requestHeaders);
		structAppend(allHeaders, {
			"host" = arguments.hostName,
			"x-amz-date" = amzDate,
			"x-amz-content-sha256" = getHash256(arguments.requestBody)
		});
		for(var i in allHeaders) {
			st.requestHeaders[i] = allHeaders[i];
		}

		var canonicalHeaders = [];
		var signedHeaders = listSort(lCase(structKeyList(allHeaders)), "text");
		for(var i in signedHeaders) {
			arrayAppend(canonicalHeaders, i & ":" & allHeaders[i]);
		}
		arrayAppend(canonicalHeaders, "");

		var algorithm = "AWS4-HMAC-SHA256";

		var credentialScope = arrayToList([
			dateStamp,
			arguments.regionName,
			arguments.serviceName,
			"aws4_request"
		], "/");

		var canonicalRequest = [
			arguments.requestMethod,
			uriEncode(arguments.requestUri),
			canonicalQuerystring
		];
		for(var i in canonicalHeaders) {
			arrayAppend(canonicalRequest, i);
		}
		arrayAppend(canonicalRequest, listChangeDelims(signedHeaders, ";"));
		arrayAppend(canonicalRequest, allHeaders["x-amz-content-sha256"]);

		var stringToSign = [
			algorithm,
			amzDate,
			credentialScope,
			getHash256(arrayToList(canonicalRequest, Chr(10)))
		];

		var signingKey = getSignatureKey(dateStamp, arguments.regionName, arguments.serviceName);

		st.signature = lCase(HMAC(charsetDecode(arrayToList(stringToSign, Chr(10)), "utf-8"), signingKey, "HMACSHA256", "utf-8"));

		st.authorizationHeader = arrayToList([
			algorithm,
			"Credential=" & this.accessKeyId & "/" & credentialScope & ",",
			"SignedHeaders=" & listChangeDelims(signedHeaders, ";") & ",",
			"Signature=" & st.signature
		], " ");

		return st;
	}

	public string function getCallRegion(
		required string callUrl
	) {
		local.a = listToArray(arguments.callUrl, "/");
		local.b = listToArray(local.a[2], ".");
		return local.b[2];
	}

	public string function getCallHost(
		required string callUrl
	) {
		local.a = listToArray(arguments.callUrl, "/");
		return listFirst(local.a[2], ":");
	}

	public string function getCallUri(
		required string callUrl
	) {
		local.a = listToArray(arguments.callUrl, "/");
		arrayDeleteAt(local.a, 2);
		arrayDeleteAt(local.a, 1);
		return "/" & arrayToList(local.a, "/");
	}

	public string function getMd5Hash(
		required string body
	) {
		return binaryEncode(binaryDecode(Hash(arguments.body), "hex"), "base64");
	}

	private string function getHash256(
		required string text
	) {
		return lCase(Hash(arguments.text, "SHA-256"));
	}

	private any function getSignatureKey(
		required string dateStamp,
		required string regionName,
		required string serviceName
	) {
		local.kSecret = charsetDecode("AWS4" & this.secretAccessKey, "utf-8");
		local.kDate = sign(arguments.dateStamp, local.kSecret);
		local.kRegion = sign(arguments.regionName, local.kDate);
		local.kService = sign(arguments.serviceName, local.kRegion);
		local.kSigning = sign("aws4_request", local.kService);
		return local.kSigning;
	}

	private binary function sign(
		required string message,
		required binary key,
		string algorithm = "HMACSHA256",
		string encoding = "utf-8"
	) {
		local.keySpec = createObject("java", "javax.crypto.spec.SecretKeySpec");
		local.keySpec = local.keySpec.init(arguments.key, arguments.algorithm);
		local.mac = createObject("java", "javax.crypto.Mac").getInstance(arguments.algorithm);
		local.mac.init(local.keySpec);
		return local.mac.doFinal(charsetDecode(arguments.message, arguments.encoding));
	}

	private string function UriEncode(
		required string input,
		boolean encodeSlash = false
	) {
		var str = Trim(arguments.input);
		var result = createObject("java", "java.lang.StringBuilder");
		for(var i = 0; i < Len(str); i++) {
			var ch = Mid(str, i+1, 1);
			if((ch >= 'A' && ch <= 'Z') || (ch >= 'a' && ch <= 'z') || (ch >= '0' && ch <= '9') || ch == '_' || ch == '-' || ch == '~' || ch == '.') {
				result.append(ch);
			} else if(ch == '/') {
				result.append(arguments.encodeSlash ? "%2F" : ch);
			} else {
				result.append(urlEncodedFormat(ch));
			}
		}
		return result.toString();
	}

}
