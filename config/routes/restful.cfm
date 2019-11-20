
<cfscript>
mapper(mapFormat = false)
	.namespace("restful")
		.resources(name = "Suburbs", only = "index")
		.resources(name = "Criteria", only = "update")
	.end()
.end()
</cfscript>
