component extends="app.controllers.Controller" {

	function config(boolean protectFromForgery = true) {
		// We can skip CSRF from a sub controller if required
		if (arguments.protectFromForgery) {
			protectsFromForgery();
		}
		filters(through = "writeToHtmlHead", type = "after");
		usesLayout("/layouts/public/layout")
	}

	// Include controller wide shared functions
	include template="../user/functions/auth.cfm";
	include template="../user/functions/filters.cfm";

}
