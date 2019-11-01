<cfscript>
/**
* Returns a thumbnail filename in a standard format
*
* [section: Application]
* [category: File Functions]
*
*/
public function thumbnail(required string filename, string width, string height) {
	if (isNumeric(arguments.width) && isNumeric(arguments.height)) {
		// 800x600/foo.jpg
		return arguments.width & "x" & arguments.height & "/" & arguments.filename;
	} else if (isNumeric(arguments.width)) {
		// 800-min/foo.jpg
		return arguments.width & "-min" & "/" & arguments.filename;
	} else if (isNumeric(arguments.height)) {
		// 800-max/foo.jpg
		return arguments.height & "-max" & "/" & arguments.filename;
	}
	return arguments.filename;
}

/**
* Appends a string to a filename: foo.jpg > foo-bar.jpg
*
* [section: Application]
* [category: File Functions]
*
*/
public string function appendToFileName(required string filename, required string string, string separator = "-") {
	var loc = {};
	if (left(arguments.filename, 1) == ".") {
		return "#arguments.filename##arguments.separator##arguments.string#";
	} else {
		loc.ext = listLast(arguments.filename, ".");
		loc.name = listDeleteAt(arguments.filename, listLen(arguments.filename, "."), ".");
		return "#loc.name##arguments.separator##arguments.string#.#loc.ext#";
	}
}

/**
* Generates a globally unique filename
*
* [section: Application]
* [category: File Functions]
*
* @extension File extension to use
* @length Length of generated filename not including extension
*
*/
public string function generateUniqueFileName(required string extension, numeric length = 32) {
	if (arguments.length lt 32) {
		throw(type = "InsufficientLengthError", messsage = "Length must be a mininum of 32");
	}
	local.fileName = reReplaceNoCase(createUUID(), "[^a-z0-9]", "", "all") & randomString(length = arguments.length);
	return lCase("#left(local.fileName, arguments.length)#.#arguments.extension#");
}
</cfscript>

<cffunction name="deleteFile" hint="deletes files if they exist">
	<cfargument name="files" type="string" required="true" hint="a list of file paths">
	<cfset var loc = {}>
	<cfloop list="#arguments.files#" index="loc.i">
		<cfif fileExists(loc.i)>
			<cftry>
				<cffile action="delete" file="#loc.i#">
				<cfcatch type="Any"><!--- TODO: what to do here??! ---></cfcatch>
			</cftry>
		</cfif>
	</cfloop>
</cffunction>

<cffunction name="monthToDirectory" output="false" hint="returns a path formatted as {rootPath}/yyyy/mm/">
	<cfargument name="date" type="date" required="true">
	<cfargument name="rootPath" type="string" required="false">
	<cfset var loc = {}>
	<cfset loc.ret = "#year(arguments.date)#/#month(arguments.date)#/">
	<cfif structKeyExists(arguments, "rootPath") AND arguments.rootPath neq "">
		<cfset loc.ret = arguments.rootPath & loc.ret>
	</cfif>
	<cfreturn loc.ret>
</cffunction>

<cfscript>
public any function getByteArray(required numeric size) {
	var emptyByteArray = createObject("java", "java.io.ByteArrayOutputStream").init().toByteArray();
	var byteClass = emptyByteArray.getClass().getComponentType();
	var byteArray = createObject("java", "java.lang.reflect.Array").newInstance(byteClass, arguments.size);
	return byteArray;
}

public void function downloadFileFromURL(required string url, required string path) {
	var uri = createObject("java", "java.net.URL").init(arguments.url);
	var uis = uri.openStream();
	var bis = createObject("java", "java.io.BufferedInputStream").init(uis);
	var fos = createObject("java", "java.io.FileOutputStream").init(arguments.path);
	var bos = createObject("java", "java.io.BufferedOutputStream").init(fos);
	var buffer = getByteArray(1024);
	var len = bis.read(buffer);
	while (len > 0) {
		bos.write(buffer, 0, len);
		len = bis.read(buffer);
	}
	bos.close();
	bis.close();
	fos.close();
	uis.close();
}

/* checks if the directory exist, if not create it */
public void function checkAndCreateDirectory(required string directory) {
	if (!directoryExists(arguments.directory)) {
		directory action="create" directory="#arguments.directory#" {
		}
	}
}

/* download an image file via http */
public struct function getHttpImage(required string url, required string destination) {
	var loc = {};
	loc.rv = {}
	loc.rv.success = false;
	loc.rv.errors = [];
	http method="get"
		url="#arguments.url#"
		timeout="30"
		throwonerror="false"
		getasbinary="true"
		useragent="Mozilla/5.0 (Windows NT 6.1; WOW64; rv:39.0) Gecko/20100101 Firefox/39.0"
		result="loc.http" {
	}
	if (loc.http.status_code == 404) {
		loc.rv.errors = ["#arguments.url# was not found"];
	} else if (loc.http.status_code != 200) {
		loc.rv.errors = ["Invalid statusCode (#loc.http.status_code#)"];
	} else if (loc.http.status_code == 200) {
		if (arguments.destination contains "s3://") {
			loc.bucketFolderName = replaceNoCase(
				getDirectoryFromPath(arguments.destination),
				get("bucketPath"),
				"",
				"one"
			);
			s3CreateDirectory(loc.bucketFolderName);
		} else {
			checkAndCreateDirectory(getDirectoryFromPath(arguments.destination));
		}
		file action="write" output=loc.http.fileContent file=arguments.destination {
		}
		if (isImageFile(arguments.destination)) {
			loc.rv.success = true;
		} else {
			file action="delete" file=arguments.destination {
			}
			loc.rv.errors = ["#arguments.url# is not a valid image"];
		}
	} else {
		loc.rv.errors = ["#arguments.url# was not found"];
	}
	return loc.rv;
}

public void function serveFile(
	string path required,
	string mimetype required,
	string filename = "",
	boolean deletefile = false
) {
	var loc = {};
	loc.path = arguments.path;
	if (arguments.mimetype == "pdf") {
		loc.type = "application/pdf";
	} else {
		loc.type = arguments.mimetype;
	}
	loc.filename = arguments.filename.Len() ? arguments.filename : getFileFromPath(loc.path);
	header name="Content-disposition" value="inline; filename=#loc.filename#" {
	}
	;
	content file="#arguments.path#" type=loc.type deletefile="#arguments.deletefile#" {
	}
	;
}

/**
* Will take a number returned from a File.Filesize, calculate the number in terms of Bytes/Kilobytes/Megabytes and return the result.
* v2 by Haikal Saadh
* v3 by Michael Smith, cleaned up and added Gigabytes
*
* @param number 	 Size in bytes of the file. (Required)
* @return Returns a string.
* @author Kyle Morgan (admin@kylemorgan.com)
* @version 3, February 3, 2009
*/
public string function fileSize(required numeric size) {
	if (size lt 1000) return "#size# b";
	if (size lt 1024^2) return "#round(size / 1024)# Kb";
	if (size lt 1024^3) return "#decimalFormat(size / 1024^2)# Mb";
	return "#decimalFormat(size / 1024^3)# Gb";
}
</cfscript>

<cffunction name="mergePdf" output="false" returnType="any">
	<cfargument name="source" type="string" required="true">
	<cfargument name="destination" type="string" required="true">
	<cfpdf action="merge" source="#arguments.source#" destination="#arguments.destination#" overwrite="yes"/>;
</cffunction>

<cfscript>
public string function binaryPath(required string name, required string os = server.os.name) {
	local.returnValue = ""
	if (arguments.os contains "windows") {
		/* this is for WINDOWS */
		local.returnValue = "c:\#arguments.name#\#arguments.name#.exe";
	} else if (arguments.os contains "linux") {
		/* this is for LINUX */
		local.returnValue = "#arguments.name#";
	} else if (arguments.os contains "mac") {
		/* TODO this is for MAC */
		local.returnValue = "#arguments.name#";
	} else {
		local.returnValue = "";
	}
	return trim(local.returnValue);
}

public string function sanitiseFileName(required string filename) {
	if (!find(".", arguments.filename)) {
		var fileNameBody = arguments.filename;
		var fileExtension = "";
	} else {
		var fileNameBody = ListDeleteLast(arguments.filename, ".");
		var fileExtension = listLast(arguments.filename, ".");
	}
	fileNameBody = replace(fileNameBody, "&", "and", "all");
	fileNameBody = slugify(string = fileNameBody, ignore = "_");
	if (len(fileExtension)) {
		return fileNameBody & "." & lCase(fileExtension);
	} else {
		return fileNameBody;
	}
}

public void function downloadQueryAsCSV(required query query, required string fileName, boolean deletefile = true) {
	local.filePath = expandPath("temp/#arguments.fileName#");
	fileWrite(local.filePath, queryToCSV(arguments.query));
	sendFile(
		file = getFileFromPath(local.filePath),
		directory = getDirectoryFromPath(local.filePath),
		deletefile = false
	);
}

/**
 * Given a file path, will return the contents in base64 binary encoded format for use with S3 putObject
 *
 * [section: Application]
 * [category: File Functions]
 *
 */
public string function convertFileToS3Object(required string path) {
	return convertFileContentToBase64(
		content = FileReadBinary(arguments.path),
		type = LCase(ListLast(arguments.path, "."))
	)
}


public string function convertFileContentToBase64(required string content, required string type) {
	local.content = toBase64(arguments.content);
	if (arguments.type == "json") {
		return "data:application/json;base64,#local.content#";
	} else if (listFindNoCase("jpeg,jpg,png", arguments.type)) {
		return "data:image/#arguments.type#;base64,#local.content#";
	} else if (arguments.type == "pdf") {
		return "data:application/pdf;base64,#local.content#";
	} else if (arguments.type == "xml") {
		return "data:text/xml;base64,#local.content#";
	} else {
		return arguments.content;
	}
}

/**
* Performs a chunked file upload to an s3 bucket.
*
* Return value conforms with formatJSONResponse()
*
* [section: Application]
* [category: File Functions]
*
* @formData The complete form scope
* @type The type of file being uploaded. See `getPath()`
* @isPublic If true, the AWS ACL willbe set to PublicRead
* @fileName Explicit destination file name. Defaults to a random 32 character string
* @destinationBucketName Defaults to application setting plupload.destinationBucketName
* @chunkingBucketName The bucket where a chunked file is assembled. Defaults to application setting plupload.chunkingBucketName
* @thumbnailSize Thumnail dimensions of an successfully uploaded image
*/
public struct function uploadChunkedFile(
	required struct formData,
	required string type,
	boolean isPublic = false,
	string fileName = "",
	string destinationBucketName = get("plupload").destinationBucketName,
	string chunkingBucketName = get("plupload").chunkingBucketName,
	string thumbnailSize = "100x100"
) {
	local.s3key = arguments.formData["key"];
	local.fileExtension = lCase(listLast(local.s3key, "."));
	local.isAcceptedFileExtension = reFindNoCase("\.(jpg|jpeg|gif|png|pdf)$", local.s3key);
	local.isImageFileExtension = reFindNoCase("\.(jpg|jpeg|gif|png)$", local.s3key);
	local.uploadedChunks = arguments.formData["chunks"] ?: 0;
	local.isUploadComplete = false;
	local.filename = len(arguments.filename) ? local.filename : generateUniqueFileName(local.fileExtension);

	if (isFalse(local.isAcceptedFileExtension)) {
		return {success = false, messages = ["#local.fileExtension# file types are not accepted"]}
	}

	// TODO: catch exceptions

	local.sourceKey = "/" & arguments.chunkingBucketName & "/" & local.s3key;
	local.destinationKey = "/" & arguments.destinationBucketName & "/" & getPath(arguments.type, local.filename);
	if (local.uploadedChunks) {
		local.uploadId = getAWSUploadId(local.destinationKey);
		if (len(local.uploadId)) {
			local.eTags = getAWSETags(
				local.destinationKey,
				local.uploadId,
				local.sourceKey,
				local.uploadedChunks
			);
			if (arrayLen(local.eTags)) {
				local.isUploadComplete = completeAWSUpload(
					local.destinationKey,
					local.uploadId,
					local.uploadedChunks,
					local.eTags
				);
			}
		}
	} else {
		local.isUploadComplete = moveAWSUpload(local.destinationKey, local.sourceKey);
	}
	cleanupAWSUpload(local.s3key, local.uploadedChunks);
	local.returnValue = {data = {}, success = true};
	if (local.isUploadComplete) {
		local.returnValue.data.filename = local.filename;
		if (arguments.isPublic) {
			service("s3").setObjectAcl(bucket = arguments.destinationBucketName, key = getPath(arguments.type, local.filename), acl = "PublicRead");
			// TODO: arguments.destinationBucketName needs to be a domain pointed to a bucket of the same name eg: imgs.dev-rev.com
			if (local.isImageFileExtension) {
				local.returnValue.data.thumbnail = "https://#arguments.destinationBucketName#/#arguments.thumbnailSize#/#local.filename#";
			}
		}
	}
	return local.returnValue
}
</cfscript>
