
<cfscript>
mapper(mapFormat = false)
	.namespace("restful")
		.resources(name = "Suburbs", only = "index")
	.end()
.end()
</cfscript>
