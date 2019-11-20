component extends="Controller" {

	function config() {
		super.config();
		verifies(post = true, only = "create");
		filters(through = "checkRememberMeCookie", only = "new,create");
		filters(through = "redirectAuthenticatedUsers", only = "new,create");
	}

	/**
	 * Login user form: uses tableless model for validation
	 *
	 */
	function new() {
		auth = model("auth.Contact").new();
	}

	/**
	 * Login a user: create an instance of the tableless Auth model, runs its validation, and if ok,
	 * Creates the session
	 *
	 */
	function create() {
		auth = model("auth.Contact").new(params.auth);
		if (!auth.hasErrors() && auth.login()) {
			createAuditEvent(
				type = "auth",
				severity = "info",
				contactId = getSession().id,
				message = "User #getSession().email# successfully logged in"
			);
			redirectTo(route = "account");
		} else {
			createAuditEvent(
				type = "auth",
				severity = "danger",
				message = "Failed Login",
				data = auth.allErrors()
			);
			// TO DO : add brute force attack mitigation
			renderView(action = "new");
		}
	}

	/**
	 * Logs out a user
	 *
	 */
	function delete() {
		// Grab this before killing getSession()
		var nameofLogginOutUser = getSession().email;
		// Kill session
		forcelogout();
		// Add Log
		createAuditEvent(type = "auth", severity = "info", message = "User #nameofLogginOutUser# logged out");
		// does this insertFlash ever work?
		redirectTo(route = "login", success = "You have been logged out");
	}

	/**
	 * Forgets a users remember me cookie
	 *
	 */
	function forget() {
		deleteCookieRememberEmail();
		redirectTo(route = "login");
	}

	/**
	 * Looks for remember me cookie
	 */
	private function checkRememberMeCookie() {
		usingRememberMeCookie = StructKeyExists(cookie, "REMEMBERME") && Len(cookie.rememberme) ? true : false;
		savedEmail = usingRememberMeCookie ? decryptString(cookie.rememberme) : "";
	}

}
