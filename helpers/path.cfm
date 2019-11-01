<cfscript>
/**
 * Given a type and filename, will return a path to a file on S3
 *
 * [section: Application]
 * [category: Path]
 *
 * @type Accepts [change,changes,image,images]
 * @url Used internally. Do not use this argument.
 */
public string function getPath(
	required string type,
	required string fileName,
	required string url = false // not for public use
) {
	local.acceptedTypes = "change,changes,image,images,soi";
	switch (arguments.type) {
		case "image": case "images":
			local.objectPath = arguments.fileName;
			local.host = get("imagesBucketName");
			break;
		case "change": case "changes":
			local.objectPath = "changes/#arguments.fileName#";
			local.host = "#get("bucketName")#.s3-ap-southeast-2.amazonaws.com";
			break;
		case "push": case "pushes":
			local.objectPath = "pushes/#arguments.fileName#";
			local.host = "#get("bucketName")#.s3-ap-southeast-2.amazonaws.com";
			break;
		case "soi":
			local.objectPath = "soi/#arguments.fileName#";
			local.host = "#get("bucketName")#.s3-ap-southeast-2.amazonaws.com";
			break;
		default:
			throw(
				type="InvalidTypeError",
				message="#arguments.type# is not a valid argument for the getPath function's type argument. Accepted values are [#local.acceptedTypes#]"
			);
	}
	if (arguments.url == true) {
		return "https://#local.host#/#local.objectPath#";
	}
	return local.objectPath;
}

/**
 * An alias of getPath() that only returns urls. See getPath for documentation.
 *
 * [section: Application]
 * [category: Path]
 *
 */
public string function getURL(
	required string type,
	required string fileName
) {
	return getPath(arguments.type, arguments.fileName, true);
}

/**
* Returns a url to the specified file in the images bucket. If width and height are ommitted, it will return the original image.
*
* [section: Application]
* [category: Path]
*
*/
public string function getImageURL(required string fileName, numeric width, numeric height) {
	return getURL("image", thumbnail(argumentCollection = arguments));
}
</cfscript>
