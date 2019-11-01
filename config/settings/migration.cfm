<cfscript>
// set(fromEmailAddress = "no-reply@developerrealestateview.com.au"); // we can only send from this domain using staging smtp server
set(fromEmailAddress = "qa@zenu.com.au"); // we can only send from this domain using staging smtp server
set(errorEmailAddress = "leroy@zenu.com.au");
set(dataSourceName = "westeros-migration");
set(bucketName = "realestateview-staging");
set(bucketPath = "s3://#get("bucketName")#/");
set(bucketURL = "https://#get("bucketName")#.#env("AWS_DEFAULT_REGION")#.amazonaws.com/");
set(braavosHost = "sites.staging.westeros.com.au");
set(westerosHost = "staging.westeros.com.au");
set(crunchHost = get("westerosHost"));
set(imagesBucketName = "images.staging.developerrealestateview.com.au");
set(
	plupload = {
		region = env("AWS_DEFAULT_REGION"),
		endpoint = "s3-#env("AWS_DEFAULT_REGION")#.amazonaws.com",
		chunkingBucketName = "holding.realestateview-staging",
		destinationBucketName = get("imagesBucketName")
	}
);
</cfscript>

