<cfscript>
set(dataSourceName = "westeros-production");
set(bucketName = "westeros");
set(bucketPath = "s3://#get("bucketName")#/");
set(bucketURL = "https://#get("bucketName")#.#env("AWS_DEFAULT_REGION")#.amazonaws.com/");
set(braavosHost = "sites.westeros.com.au");
set(westerosHost = "westeros.com.au");
set(crunchHost = "crunch.westeros.com.au");
set(adminHost = "admin.westeros.com.au");
set(imagesBucketName = "images.westeros.com.au/");
set(
	plupload = {
		region = env("AWS_DEFAULT_REGION"),
		endpoint = "s3-#env("AWS_DEFAULT_REGION")#.amazonaws.com",
		chunkingBucketName = "hold.westeros.com.au",
		destinationBucketName = get("imagesBucketName")
	}
);
</cfscript>
