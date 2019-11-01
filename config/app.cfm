<cfscript>
if (cgi.server_name == "www.braavos.dv" && (cgi.path_info == "/wheels/tests/app" || cgi.path_info == "/junify/app")) {
	this.name = hash(getCurrentTemplatePath() & "wheels-tests")
} else {
	this.name = hash(getCurrentTemplatePath())
}

// regional
// default locale used for formating dates, numbers ...
this.locale = "en_AU"
// default timezone used
this.timezone = "UTC"

// scope handling
// lifespan of a untouched application scope
this.applicationTimeout = createTimespan(365, 0, 0, 0)

// session handling enabled or not
this.sessionManagement = false
// client scope enabled or not
this.clientManagement = false
// using domain cookies or not
this.setDomainCookies = false
this.setClientCookies = false

// prefer the local scope at unscoped write
this.localMode = "classic"

// buffer the output of a tag/function body to output in case of a exception
this.bufferOutput = true
this.compression = false
this.suppressRemoteComponentContent = false

// If set to false Railo ignores type defintions with function arguments and return values
this.typeChecking = true

// request
// max lifespan of a running request
this.requestTimeout = createTimespan(0, 0, 0, 30);

// charset
this.charset.web = "UTF-8";
this.charset.resource = "UTF-8";

this.scopeCascading = "strict";

// ////////////////////////////////////////////
// DATASOURCES                //
// ////////////////////////////////////////////

private string function getConnectionString(required string host, required string database, numeric port = 3306) {
	var p = {
		"useUnicode" = true,
		"characterEncoding" = "UTF-8",
		"allowMultiQueries" = true,
		"useLegacyDatetimeCode" = false,
		"serverTimezone" = "UTC",
		"useLocalSessionState" = true
	};
	var a = [];
	for (var k in p) {
		a.Append(k & "=" & p[k]);
	}
	var s = "jdbc:mysql://" & arguments.host & ":" & arguments.port & "/" & arguments.database;
	return s & "?" & arrayToList(a, "&");
}

private struct function getDatasourceSettings(
	required string host,
	required string database,
	required string username,
	required string password,
	numeric port = 3306
) {
	return {
		"class" = "org.gjt.mm.mysql.Driver",
		"bundleName" = "com.mysql.jdbc",
		"bundleVersion" = "5.1.40",
		"connectionString" = getConnectionString(
			host = arguments.host,
			database = arguments.database,
			port = arguments.port
		),
		"database" = arguments.database,
		"username" = arguments.username,
		"password" = arguments.password,
		"timezone" = "UTC",
		"connectionLimit" = -1, // -1 == infiniti
		"connectionTimeout" = 1 // 0 == connection is released after usage, smaller than 0 is infiniti
	};
}

this.datasources["westeros-development"] = getDatasourceSettings(
	host = "db.westeros.dv",
	database = "westeros_development",
	username = "root",
	password = ""
);

this.datasources["westeros-testing"] = getDatasourceSettings(
	host = "db.westeros.dv",
	database = "westeros_testing",
	username = "root",
	password = ""
);

this.datasources["westeros-ci"] = getDatasourceSettings(
	host = "area51.dagobah.zenu.com.au",
	database = "westeros_ci",
	username = "westeros",
	password = "encrypted:43488222d329ba21aac46425cb8e992eaba1bacbadaf807cbde9e48de743f068b33d5b09c07e5606"
);

this.datasources["westeros-migration"] = getDatasourceSettings(
	host = "rev-staging-aurora-instance-1.cpwxcucug8rw.ap-southeast-2.rds.amazonaws.com",
	database = "westeros_migration",
	username = "westeros",
	password = "encrypted:43488222d329ba21aac46425cb8e992eaba1bacbadaf807cbde9e48de743f068b33d5b09c07e5606"
);

this.datasources["westeros-staging"] = getDatasourceSettings(
	host = "rev-staging-aurora-instance-1.cpwxcucug8rw.ap-southeast-2.rds.amazonaws.com",
	database = "westeros_staging",
	username = "westeros",
	password = "encrypted:43488222d329ba21aac46425cb8e992eaba1bacbadaf807cbde9e48de743f068b33d5b09c07e5606"
);

// this.datasources["westeros-production"] = getDatasourceSettings(
// host = "prod.db.westeros.com.au",
// database = "westeros_production",
// username = "lucee",
// password = ""
// );

// ////////////////////////////////////////////
// MAPPINGS                   //
// ////////////////////////////////////////////
this.mappings["/plugins"] = "plugins";
this.mappings["/tests"] = "tests";
this.customtagpaths = "views/customtags";
this.javasettings = {loadPaths = ["/lib/aws-java-sdk/", "/lib/"]};

// ////////////////////////////////////////////
// DEFAULTS                   //
// ////////////////////////////////////////////
this.tag.dump.format = "simple";
this.tag.file.charset = "utf-8";
this.tag.component.output = false;

function getMemcachedConfig(required string servers) {
	return {
		class = "org.lucee.extension.io.cache.memcache.MemCacheRaw",
		bundleName = "memcached.extension",
		bundleVersion = "3.0.2.29",
		storage = false,
		custom = {
			storage_format = "binary",
			alive_check = true,
			buffer_size = 1,
			socket_connect_to = 3,
			socket_timeout = 30,
			initial_connections = 1,
			min_spare_connections = 1,
			max_spare_connections = 32,
			maint_thread_sleep = 5,
			failback = true,
			max_idle_time = 600,
			max_busy_time = 30,
			nagle_alg = true,
			failover = true,
			servers = arguments.servers
		},
		default = "object"
	};
}

// get these from environment variables
local.system = CreateObject("java", "java.lang.System");

// load secrets... pity I have to do this every request!
local.secrets = FileRead("/usr/.secrets");
request.secrets = {};
for (local.pair in ListToArray(local.secrets, Chr(10))) {
	request.secrets[ListFirst(local.pair, "=")] = ListRest(local.pair, "=");
}

this.s3.accessKeyId = request.secrets["AWS_ACCESS_KEY_ID"];
this.s3.awsSecretKey = request.secrets["AWS_SECRET_ACCESS_KEY"];
 // cfmail tag defaults
this.tag.mail.server = "email-smtp.#request.secrets["AWS_SES_DEFAULT_REGION"]#.amazonaws.com";
this.tag.mail.username = request.secrets["AWS_SES_ACCESS_KEY_ID"];
this.tag.mail.password = request.secrets["AWS_SES_SECRET_ACCESS_KEY"];
this.tag.mail.port = 465;
this.tag.mail.usetls = true;
this.tag.mail.usessl = true;
</cfscript>
