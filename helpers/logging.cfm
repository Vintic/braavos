<cfscript>
// =====================================================================
// =     Logging
// =====================================================================

/**
* Adds a logline to the Audit Log: doesn't log anything in testing mode
*
* [section: Application]
* [category: Utils]
*
* @type Anything you want to group by: i.e, email | database | user | auth | login | flash etc.
* @message The Message
* @severity One of info | warning | danger
*/

public void function createAuditEvent(
	required string type,
	required string message,
	string severity = "info",
	numeric administratorId,
	numeric agentId
) {
		arguments.ipaddress = getIPAddress();
		arguments.userAgent = cgi.http_user_agent;
		local.auditEvent = model("AuditEvent").create(arguments);
}
</cfscript>
