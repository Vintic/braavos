<cfscript>
set(reloadPassword = "");
if (cgi.server_name == "www.braavos.dv" && (cgi.path_info == "/wheels/tests/app" || cgi.path_info == "/junify/app")) {
	set(dataSourceName = "westeros-testing");
} else {
	set(dataSourceName = "westeros-development");
}
set(writeMigratorSQLFiles = true);
set(bucketName = "realestateview-dev");
set(bucketPath = "s3://#get("bucketName")#/");
set(bucketURL = "https://#get("bucketName")#.#env("AWS_DEFAULT_REGION")#.amazonaws.com/");
set(imagesBucketName = "images.dev.developerrealestateview.com.au");
set(
	plupload = {
		region = env("AWS_DEFAULT_REGION"),
		endpoint = "s3-#env("AWS_DEFAULT_REGION")#.amazonaws.com",
		chunkingBucketName = "holding.realestateview-dev",
		destinationBucketName = get("imagesBucketName")
	}
);
set(braavosHost = "www.braavos.dv");
set(validateTestPackageMetaData = false);
</cfscript>
