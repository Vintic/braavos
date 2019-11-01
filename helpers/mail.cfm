<cffunction name="unsubscribeMarkup" output="false">
	<cfargument
		name="style"
		type="string"
		required="false"
		default="font-size:10px; color:##999; line-height:12px; margin-top:0px; text-align:center; font-family:Arial, Helvetica, sans-serif;"
	>
	<cfargument name="text" type="string" required="false" default="If you'd rather not receive emails, please">
	<cfset var loc = {}>
	<cfoutput>
		<cfsavecontent variable="loc.returnValue">
			<cfif isDefined("contact") && (isObject(contact) OR isQuery(contact) OR isStruct(contact))>
				<p style="#arguments.style#" align="center">#arguments.text##linkTo(
						text = "unsubscribe",
						host = get("westerosHost"),
						route = "unsubscribe",
						key = securify(contact.id),
						style = "color: inherit;",
						onlyPath = "false"
					)# here.</p>
            <cfelseif isDefined("selectedContact") && (
					isObject(selectedContact) OR isQuery(selectedContact) OR isStruct(selectedContact)
				)>
				<p style="#arguments.style#" align="center">#arguments.text##linkTo(
						text = "unsubscribe",
						host = get("westerosHost"),
						route = "unsubscribe",
						key = securify(selectedContact.id),
						style = "color: inherit;",
						onlyPath = "false"
					)# here.</p>
            <cfelseif structKeyExists(variables, "contact_id") && val(contact_id)>
				<p style="#arguments.style#" align="center">#arguments.text##linkTo(
						text = "unsubscribe",
						host = get("westerosHost"),
						route = "unsubscribe",
						key = securify(contact_id),
						style = "color: inherit;",
						onlyPath = "false"
					)# here.</p>
			</cfif>
		</cfsavecontent>
	</cfoutput>
	<cfreturn loc.returnValue>
</cffunction>

<cffunction name="crossClientEmailButton" output="false">
	<cfargument name="text" type="string" required="true">
	<cfargument name="url" type="string" required="true">
	<cfargument name="bg_color" type="string" required="false" default="##666666">
	<cfargument name="txt_color" type="string" required="false" default="##ffffff">
	<cfargument name="additional_styles" type="string" required="false" default="">
	<cfargument name="align" type="string" required="false" default="right">
	<cfargument name="width" type="numeric" required="false"/>
	<cfset var loc = {}>
	<cfoutput>
		<cfsavecontent variable="loc.returnValue">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td align="#arguments.align#">
						<table border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td align="center" style="border-radius: 3px;" bgcolor="#arguments.bg_color#">
									<a
										href="#arguments.url#"
										target="_blank" style="#val(arguments.width) GT 0 ? "width: #arguments.width#px;" : "min-width: 104px;"# font-size: 13px; font-family: Arial, sans-serif;color:#arguments.txt_color#; text-decoration: none ;border-radius: 3px; padding: 8px 18px; border: 1px solid#arguments.bg_color#; display: inline-block; font-weight: bold;#additional_styles#"
									>#arguments.text#</a>
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</cfsavecontent>
	</cfoutput>
	<cfreturn loc.returnValue>
</cffunction>

<cfscript>
public string function emailCampaignAssetUrl(required string filename) {
	return "http://#get("westerosHost")#/assets/user/email-campaigns/#arguments.filename#";
}
</cfscript>
