<cfscript>
	include template="routes/user.cfm";
	include template="routes/public.cfm";
	include template="routes/restful.cfm";
	mapper()
		.get(name="listingResults", pattern="listings", to="listings##index")
		.get(name="listingShow", pattern="listing-show/[key]", to="listings##show")
		// .wildcard()
		.root(to="home##index", method="get")
		.resources(name = "findAnAgent", only = "index,show")
		.resources(name = "agent", only = "show")
	.end();

</cfscript>
