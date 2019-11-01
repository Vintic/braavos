<cfscript>
/**
* Dump and die (abort)
*
* [section: Application]
* [category: Development Functions]
*
* @var The variable to be dumped
* @args Any additional cfdump arguments can be passed in
*/
public void function dd(required any var) {
	if (!isDevelopment()) {
		throw(type = "FunctionNotAllowed", message = "The dd() function is not allowed outside of development");
	}
	dump(argumentCollection = arguments);
	abort;
}
</cfscript>
