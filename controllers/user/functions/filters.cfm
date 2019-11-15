<cfscript>
//=====================================================================
//= 	Miscellaneous Filters
//=====================================================================

/**
* Logs the output of the flash scope: used as a filter
*
* [section: Application]
* [category: Filters]
*/
private function logFlash(){
	// Don't log if testing
	if(structkeyexists(cookie.flash, "error")){
		createAuditEvent(message=cookie.flash.error, type="flash", severity="danger");
	}
	if(structkeyexists(cookie.flash, "success")){
		createAuditEvent(message=cookie.flash.success, type="flash", severity="success");
	}
	if(structkeyexists(cookie.flash, "info")){
		createAuditEvent(message=cookie.flash.info, type="flash", severity="info");
	}
}

/**
* Main Filter to Test for the session flag for a required password change
* We still allow access to the main facility to update their password, and also
* to logout, but nothing else.
*
* [section: Application]
* [category:Filters]
*/
private function checkForPasswordBlock(){
	if(isAuthenticated()
		&& hasPasswordResetBlock()
		&& params.route != 'accountPassword'
		&& params.route != 'logout'
	){
		redirectTo(route="accountPassword");
	}
}

/**
* Global page setup function that runs before every request
*
* [section: Application]
* [category: Filters]
*/
private function setupRequest() {
	params.page = params.page ?: 1;
}
</cfscript>
