<cfscript>
	include template="routes/user.cfm";
	include template="routes/public.cfm";
	include template="routes/restful.cfm";
	mapper()
		.get(name="listingResults", pattern="listings", to="listings##index")
		// .wildcard()
		.root(to="home##index", method="get")
	.end();

</cfscript>
