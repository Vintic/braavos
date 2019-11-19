component extends="app.controllers.Controller" {

	function config(
		boolean protectFromForgery = true,
		boolean restrictAccess = true,
		boolean redirectAuthenticatedUsers = false,
		boolean logFlash = false
	) {
		// We can skip CSRF from a sub controller if required
		if (arguments.protectFromForgery) {
			protectsFromForgery();
		}
		// Require a permission to access this controller?
		if (arguments.restrictAccess) {
			filters(through = "checkPermissionAndRedirect");
		}
		// Redirect Authenticated Users away from this controller?
		// Example would be to not allow registration or password resets to logged in users
		if (arguments.redirectAuthenticatedUsers) {
			filters(through = "redirectAuthenticatedUsers");
		}
		// Log the flash in audit log?
		if (arguments.logFlash) {
			filters(through = "logFlash", type = "after");
		}
		filters(through = "setupRequest");
		// Check for password blocks
		filters(through = "checkForPasswordBlock");
		// sets 'currentUser' variable
		filters(through = "setCurrentUser");
		filters(through = "writeToHtmlHead", type = "after");
		// user specific layout
		usesLayout("/layouts/user/layout")
	}

	// Include controller wide shared functions
	include template="functions/auth.cfm";
	include template="functions/filters.cfm";

}
