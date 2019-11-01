<cfscript>
// Place code here that should be executed on the "onApplicationStart" event.	// Application Settings
application["settings"] = {};
application.encryptionKey = "XTBLnwACeKMu09kRoEE8rQ==";

createApplicationSettings();

// services
application.services = {};
application.services["s3"] = new services.aws.s3(
	account = env("AWS_ACCESS_KEY_ID"),
	secret = env("AWS_SECRET_ACCESS_KEY"),
	region = env("AWS_DEFAULT_REGION"),
	bucket = get("bucketName")
);
application.services["errorhandler"] = new services.errorhandler.rollbar();

</cfscript>
