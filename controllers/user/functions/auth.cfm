<cfscript>
//=====================================================================
//= 	Controller Only Authentication Functions
//=====================================================================
/**
* Used as a filter, and will set the currentUser variable if logged in.
* The currentUser variable can be used in controllers and views
*
* [section: Application]
* [category: Authentication]
**/
private function setCurrentUser() {
	if (isAuthenticated()) {
		currentUser = getSession();
	}
}

/**
* Used as a filter, and will redirect to login if not auth'd
* If logged in and permission is still invalid, denies with 403.
* Typically you would not call this filter directly, but use `super.config(restrictAccess=true)` in your subcontroller
*
* [section: Application]
* [category: Authentication]
**/
private function checkPermissionAndRedirect(){
		if(!isAuthenticated()){
			redirectTo(route="login", error="Login Required");
			//redirectTo(route="login", error="Login Required", params="?referrer=#cgi.PATH_INFO#");
		}
}

/**
* Redirect user away if logged in
*
* [section: Application]
* [category: Authentication]
*/
private function redirectAuthenticatedUsers() {
	if(isAuthenticated()) {
		redirectTo(route="root", info="Sorry, you can't access that functionality right now");
	}
}
</cfscript>
