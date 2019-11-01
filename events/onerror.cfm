<cfsilent>
	<cfset model("Error").processException(arguments.exception)>
	<cfif isDevelopment()>
		<cfsetting showdebugoutput="true" />
	</cfif>
</cfsilent>

<cfif isStaging() || arrayFind(get("approvedIPAddresses"), cgi.remote_addr)>
	<cfoutput>#model("Error").convertExceptionToHTML(arguments.exception)#</cfoutput>
<cfelse>
	<!--- TODO: a nice html error page.. --->
	<h1>Error!</h1>
	<p>
		Sorry, that caused an unexpected error.<br />
		Please try again later.
	</p>
	<cfif isDevelopment()>
		<cfoutput>#model("Error").convertExceptionToHTML(arguments.exception)#</cfoutput>
	</cfif>
</cfif>

