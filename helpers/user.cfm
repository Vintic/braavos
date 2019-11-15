<cfscript>
// =====================================================================
// = 	Global Authentication Functions
// =====================================================================

/**
* Gets the users session; if we're running tests, we switch out the session to the request scope
* As running the test from the CLI means we can't easily test against a session.
*
* [section: Application]
* [category: Authentication]
*/
function getSession() {
	if (isMockUserSessionPresent()) {
		if (isMockSessionAllowed()) {
			if (structKeyExists(request, "killCurrentUser")) {
				return {};
			}
			return request.currentUser;
		}
		throw(
			type = "IllegalEnvironment",
			message = "This environment does not support currentUser in request scope",
			errorcode = 418
		);
	}
	// TODO: decide what we want in this getSession object
	local.returnValue = model("Contact").findOne(where = "rememberToken = '#getRememberToken()#'");
	if (isObject(local.returnValue)) {
		return local.returnValue;
	}
	return {};
}

/**
* Returns the value of the 'session' cookie
*
* [section: Application]
* [category: Authentication]
*/
function getRememberToken() {
	return cookie["braavostoken"];
}

/**
* Checks for existence of a valid session, and whether the auth object exists
*
* [section: Application]
* [category: Authentication]
*/
function isAuthenticated() {
	if (isMockUserSessionPresent()) {
		if (isMockSessionAllowed()) {
			if (structKeyExists(request, "killCurrentUser")) {
				return false;
			}
			return true;
		}
		throw(
			type = "IllegalEnvironment",
			message = "This environment does not support currentUser in request scope",
			errorcode = 418
		);
	}
	return structKeyExists(cookie, "braavostoken") && structKeyExists(getSession(), "id");
}

/**
* Returns true if a mock session is present
*
* [section: Application]
* [category: Authentication]
*
*/
public boolean function isMockUserSessionPresent() {
	return structKeyExists(request, "currentUser") && isObject(request.currentUser);
}

/**
* Logs a user out deleting and invalidating session
*
* [section: Application]
* [category: Authentication]
*/
function forcelogout() {
	deleteRememberTokenCookie();
	// TODO:  change remember token
}
/**
* Set a session flag for an authenticated user which prevents them from further progress
* until they change their password
*
* [section: Application]
* [category: Authentication]
*/
function createPasswordResetBlock() {
	getSession()["blockedByPassword"] = now();
}

/**
* Clear the session flag for an authenticated user which prevents them from further progress
* until they change their password
*
* [section: Application]
* [category: Authentication]
*/
function clearPasswordResetBlock() {
	structDelete(getSession(), "blockedByPassword");
}
/**
* Test for the session flag for an authenticated user which prevents them from further progress
* until they change their password
*
* [section: Application]
* [category: Authentication]
*/
function hasPasswordResetBlock() {
	return structKeyExists(getSession(), "blockedByPassword");
}

/**
* Returns true if a mock session is present
*
* [section: Application]
* [category: Authentication]
*
*/
public boolean function isMockUserSessionPresent() {
	return structKeyExists(request, "currentUser") && isObject(request.currentUser);
}

// =====================================================================
// =     Remember me cookie functions
// =====================================================================

/**
* Sets a cookie which remembers the login
*
* [section: Application]
* [category: Authentication]
*
* @rememberToken The users cookie rememberToken value
*/
function setRememberTokenCookie(required string rememberToken, string expires = "never") {
	// Try and work out if we're using HTTPS and if so, set secure flag;
	// NB you'll need to set this.sessioncookie.secure for cfml sessions in config/app.cfm if using SSL
	local.useSecure = (cgi.https eq "on") ? true : false;
	cfcookie(
		expires=arguments.expires
		name="braavostoken"
		value=arguments.rememberToken
		httponly=false
		secure=local.useSecure
	);
	createAuditEvent(message = "Remember Token Cookie Set", severity = "info", type = "auth");
}

/**
* Remove the remember token cookie
*
* [section: Application]
* [category: Authentication]
*
*/
function deleteRememberTokenCookie() {
	cfcookie(expires=now() name="braavostoken");
	createAuditEvent(message = "Remember Token Cookie removed", severity = "info", type = "auth");
}
</cfscript>
