<cfscript>
set(fromEmailAddress = "no-reply@developerrealestateview.com.au"); // we can only send from this domain using staging smtp server
set(dataSourceName = "westeros-ci");
set(bucketName = "westeros-ci");
set(bucketPath = "s3://#get("bucketName")#/");
set(bucketURL = "https://#get("bucketName")#.#env("AWS_DEFAULT_REGION")#.amazonaws.com/");
set(braavosHost = "tba.com");
set(imagesBucketName = "images.dev.developerrealestateview.com.au");
set(
	plupload = {
		region = env("AWS_DEFAULT_REGION"),
		endpoint = "s3-#env("AWS_DEFAULT_REGION")#.amazonaws.com",
		chunkingBucketName = "holding.westeros-rev-dev",
		destinationBucketName = get("imagesBucketName")
	}
);
</cfscript>
