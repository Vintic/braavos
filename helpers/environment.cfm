<cfscript>
public boolean function isDev() {
	return get("stage") == "dev";
}

public boolean function isDevelopment() {
	return isDev();
}

public boolean function isCI() {
	return get("stage") == "ci";
}

public boolean function isStaging() {
	return get("stage") == "staging";
}

public boolean function isProd() {
	return get("stage") == "prod";
}

public boolean function isProduction() {
	return isProd();
}

public string function getBrand() {
	return getParam('brand',request.brand);
}

/**
* Checks if this environment is allowed to perform database seeding
*
* [section: Application]
* [category: Development Functions]
*
* @stage The application environment (Defined in config/environment.cfm)
* @dataSourceName The database connection name (Defined in config/app.cfm)
*/
public boolean function isSeedableEnvironment(required string stage, required string dataSourceName) {
	local.datasources = getApplicationMetadata().datasources;
	if (structKeyExists(local.datasources, arguments.dataSourceName)) {
		local.connectionString = local.datasources[arguments.dataSourceName]["connectionString"];
		if (
			arguments.stage == "dev" && left(local.connectionString, 50) == "jdbc:mysql://db.westeros.dv:3306/westeros_testing?"
		) {
			return true;
		} else if (
			arguments.stage == "ci" && left(local.connectionString, 57) == "jdbc:mysql://area51.dagobah.zenu.com.au:3306/westeros_ci?"
		) {
			return true;
		}
	}
	return false;
}

/**
* Given a key, will return an environment variable with that name
*
* [section: Application]
* [category: String Functions]
*
* @key
*/
public string function env(required string key) {
	if (structKeyExists(request.secrets, arguments.key)) {
		return Trim(request.secrets[arguments.key]);
	} else if (structKeyExists(server.system.environment, arguments.key)) {
		return Trim(server.system.environment[arguments.key]);
	} else if (structKeyExists(server.system.properties, arguments.key)) {
		return Trim(server.system.properties[arguments.key]);
	}
	throw(type = "MissingEnvironmentVariable", message = "#arguments.key# was not found");
}
</cfscript>
