<cfscript>
// Place helper functions here that should be available for use in all view pages of your application.

/**
* Renders a tick or cross depending on boolean value via font awesome
*
* [section: Application]
* [category: View Helpers]
*
* @boolean The boolean
*/
public string function tickorcross(required boolean boolean) {
	if (structKeyExists(arguments, "boolean") && isBoolean(arguments.boolean) && arguments.boolean) {
		return "<i class='fa fa-check text-success'></i>";
	} else {
		return "<i class='fa fa-times text-danger'></i>";
	}
}

/**
* Shortcut to encodeForHTML, because I'm lazy
*
* [section: Application]
* [category: View Helpers]
*
* @string The string to encode
*/
string function e(string string = "") {
	return encodeForHTML(arguments.string);
}

/**
* Renders a bootstrap Card
*
* [section: Application]
* [category: View Helpers]
*
* @header Card Header
* @title Card Title
* @text Main text
* @style Additional CSS
* @footer Footer Text
* @close boolean true/false
*/
string function card(
	required string header,
	string title = "",
	string text = "",
	string class = "",
	string style = "",
	string footer = "",
	boolean close = false
) {
	savecontent variable="local.rv" {
		writeOutput("<div class=""card " & arguments.class & """ style=""" & arguments.style & """>");
		writeOutput("<div class=""card-header"">" & e(arguments.header) & "</div>");
		writeOutput("<div class=""card-body"">");
		if (len(arguments.title)) {
			writeOutput("<h5 class=""card-title"">" & e(arguments.title) & "</h5>");
		}
		if (len(arguments.text)) {
			writeOutput(" <p class=""card-text"">" & e(arguments.text) & "</p>");
		}
		writeOutput("</div>");
		if (len(arguments.footer)) {
			writeOutput("<div class=""card-footer"">" & arguments.footer & "</div>");
		}
		if (arguments.close) {
			writeOutput("</div>");
		}
	}
	return local.rv;
}

/**
* Ends a bootstrap Card: use if not self closing
*
* [section: Application]
* [category: View Helpers]
*/
string function cardEnd() {
	writeOutput("</div></div>");
}

/**
* Renders a bootstrap Card/Panel but with custom contents
*
* [section: Application]
* [category: View Helpers]
*
* @title Card Title
* @class CSS Class
* @style Additional CSS
* @btn optional btn
*/
string function panel(
	string title = "",
	string class = "",
	string style = "",
	string btn = ""
) {
	savecontent variable="local.rv" {
		writeOutput("<div class=""card " & arguments.class & """ style=""" & arguments.style & """>");
		writeOutput("<div class=""card-header"">" & e(arguments.title));
		if (len(arguments.btn)) {
			writeOutput("<span class=""float-right"">" & arguments.btn & "</span>");
		}
		writeOutput("</div><div class=""card-body"">");
	}
	return local.rv;
}

/**
* Ends a panel
*
* [section: Application]
* [category: View Helpers]
*/
string function panelEnd() {
	writeOutput("</div></div>");
}

/**
* Renders a bootstrap Card/Panel but with custom contents
*
* [section: Application]
* [category: View Helpers]
*
* @title Card Title
* @class CSS Class
* @style Additional CSS
* @btn optional btn
*/
string function fieldset(
	string title="",
	string class="rev__marg-v"
){
	savecontent variable="local.rv" {
		writeOutput('<fieldset class="#arguments.class#">');
		writeOutput('<label class="master-label">' & e(arguments.title) & '</label>');
	}
	return local.rv;
}

/**
* Ends a panel
*
* [section: Application]
* [category: View Helpers]
*/
string function fieldsetEnd(){
		writeOutput('</fieldset>');

}

/**
* Default Page Header: allows passing in some custom contents to float right
*
* [section: Application]
* [category: View Helpers]
*
* @title Title Text
* @btn BTN contents
*/
string function pageHeader(string title="", string btn=""){
	writeOutput('<div class="rev__container">');
		writeOutput('<div class="row _v-center rev__pad-lg-v">');
			if(len(arguments.btn)){
				writeOutput('<div class="col-1-2 rev__text _txt-default _txt-dark _txt-heading">' & e(arguments.title) & '</div>');
				writeOutput('<div class="col-1-2 rev__text _right">' & arguments.btn & '</div>');
			} else {
				writeOutput('<div class="col-1-1 rev__text _txt-default _txt-dark _txt-heading">' & e(arguments.title) & '</div>');
			}
		writeOutput('</div>');
	writeOutput('</div>');	
}

/**
* Log File Badges: give me a type and match it up to a bootstrap badge
*
* [section: Application]
* [category: View Helpers]
*
* @type Log file type string
*/
string function logFileBadge(string type = "", string severity = "light") {
	switch (arguments.severity) {
		// Match bootstrap classes immediately
		case "info":
		case "success":
		case "danger":
		case "warning":
			local.badgeClass = arguments.severity;
			break;
			// Make error the same as danger
		case "error":
			local.badgeClass = "danger";
			break;
			// Default everything else
		default:
			local.badgeClass = "light";
			break;
	}
	return "<span class='badge badge-#local.badgeClass#'>" & e(arguments.type) & "</span>";
}
/**
* Renders a Gravatar from gravatar.com
*
* [section: Application]
* [category: View Helpers]
*
* @email Email of user
* @size px size of image
* @rating Limit to rating
* @class Image Class, defaults to bootstrap 4 rounded image
*/
string function gravatar(
	string email,
	numeric size = 80,
	string rating = "pg",
	class = "rounded-circle mx-auto d-block"
) {
	if (len(arguments.email)) {
		local.email = lCase(hash(trim(arguments.email)));
		return "<img src='https://www.gravatar.com/avatar/#local.email#?s=#arguments.size#&amp;r=#rating#' class='#arguments.class#', alt='Users Gravatar' border='0' />";
	}
}

/**
* Flashes any avalable messages in the flash.
*/
public string function flashMessageTag(
	string messageType = "success,default,warning,info",
	boolean includeContainer = false
) {
	if (flashKeyExists("message") && listFindNoCase(arguments.messageType, flash("messageType")) gt 0) {
		local.rv = "<div id=""flash-message"" class=""alert alert-#flash("messageType")# col-1-1"" data-dismiss=""alert"">#flash("message")#</div>";
		if (arguments.includeContainer){
			local.rv = "<div class=""rev__border-top""><div class=""rev__container""><div class=""row rev__pad-v"">" & local.rv & "</div></div></div>";
		}
		return local.rv;
	} else {
		return "";
	}
}
</cfscript>

<!--- TODO: scriptify --->
<cffunction
	name="errorMessageTag"
	access="public"
	output="false"
	returnType="string"
	hint="Flashes any avalable errors messages"
>
	<cfargument name="objectNames" type="string" required="false">
	<cfset var loc = {}>
	<cfset loc.ret = "">
	<cfset loc.errors = "">
	<cfif flashKeyExists("message") AND flash("messageType") eq "error">
		<cfset loc.message = "<div class=""alert alert-danger"" rev__marg-v-top>#flash("message")#</div>">
		<cfsavecontent variable="loc.ret">
			<cfoutput>
				<cfif structKeyExists(arguments, "objectNames")>
					
					<cfloop list="#arguments.objectNames#" index="loc.i">
						<cfset loc.errors = loc.errors & errorMessagesFor(objectName = loc.i)>
					</cfloop>
					<!--- <cfset loc.errors = replaceNoCase(
						loc.errors,
						"<ul class=""errorMessages"">",
						"",
						"all"
					)>
					<cfset loc.errors = replaceNoCase(loc.errors, "</ul>", "", "all")> --->

					<div class="alert-header-danger rev__marg-v-top">#flash("message")#</div>
					#loc.errors#						

        <cfelse>
					<div class="alert alert-danger rev__marg-v-top">#flash("message")#</div>
				</cfif>
			</cfoutput>
		</cfsavecontent>
	</cfif>
	<cfreturn loc.ret>
</cffunction>

<cfscript>
/**
 * Returs an input of the (wheels input) type specified with additional logic applied.
 *
 * [section: Application]
 * [category: View Helpers]
 *
 */
</cfscript>
<cffunction
	name="input"
	access="public"
	output="false"
	returntype="string"
	hint="render form input types with containing HTML"
>
	<cfargument name="inputType" type="string" required="true">
	<cfset var loc = {}/>

	<!--- Added as a fudge to pass in VueJS v-model --->
	<cfif isDefined("vmodel")>
		<cfset arguments["v-model"] = arguments.vmodel/>
		<cfset structDelete(arguments, "vmodel")/>
	</cfif>
	<!--- pass this into the wheels helpers as argumentCollection.. use this to remove unwanted args --->
	<cfset loc.args = duplicate(arguments)>
	<cfset loc.args.errorClass = "has-error">
	<cfset structDelete(loc.args, "inputType")>

	<!--- extract the label, then set to false for actual wheels function call --->
	<cfif !structKeyExists(arguments, "label")>
		<cfset arguments.label = titleize(structKeyExists(arguments, "objectName") ? arguments.property : arguments.name)>
	</cfif>

	<!--- build an attribute structure for the controlGroup tag --->
	<cfset loc.tagAttr = {}>
	<cfif arguments.inputType == "cssCheckboxTag">
		<cfset loc.tagAttr.label = "">
    <cfelse>
		<cfset loc.tagAttr.label = arguments.label>
	</cfif>
	<cfset loc.tagAttr.for = structKeyExists(arguments, "objectName") ? "#arguments.objectName#-#arguments.property ?: ""#" : arguments.name>

	<cfif structKeyExists(arguments, "style") AND len(arguments.style)>
		<cfset loc.args.style = loc.args.style ?: "" & arguments.style>
	</cfif>
	<cfset loc.args.label = false>

	<cfif !structKeyExists(loc.args, "class") >
		<cfset loc.args.class = "rev__marg-sm-v-top" />
	</cfif>

	<cfset structDelete(loc.args, "inputType")>

	<cfswitch expression="#arguments.inputType#">
		<cfcase value="textField">
			<cfset loc.input = textField(argumentCollection = loc.args)>
		</cfcase>
		<cfcase value="textFieldTag">
			<cfset loc.input = textFieldTag(argumentCollection = loc.args)>
		</cfcase>
		<cfcase value="textArea">
			<cfset loc.input = textArea(argumentCollection = loc.args)>
		</cfcase>
		<cfcase value="textAreaTag">
			<cfset loc.input = textAreaTag(argumentCollection = loc.args)>
		</cfcase>
		<cfcase value="richTextField">
			<cfset loc.input = richTextField(
				class = "rteditor",
				editor = "ckeditor",
				includeJSLibrary = "false",
				argumentCollection = loc.args
			)>
		</cfcase>
		<cfcase value="richTextTag">
			<cfset loc.input = richTextTag(
				class = "rteditor",
				editor = "ckeditor",
				includeJSLibrary = "false",
				argumentCollection = loc.args
			)>
		</cfcase>
		<cfcase value="passwordField">
			<cfset loc.input = passwordField(argumentCollection = loc.args, autocomplete = "off")>
		</cfcase>
		<cfcase value="passwordFieldTag">
			<cfset loc.input = passwordFieldTag(argumentCollection = loc.args, autocomplete = "off")>
		</cfcase>
		<cfcase value="select">
			<cfset loc.input = select(argumentCollection = loc.args)>
		</cfcase>
		<cfcase value="selectTag">
			<cfset loc.input = selectTag(argumentCollection = loc.args)>
		</cfcase>
		<cfcase value="fileField">
			<cfset loc.input = fileField(argumentCollection = loc.args)>
		</cfcase>
		<cfcase value="fileFieldTag">
			<cfset loc.input = fileFieldTag(argumentCollection = loc.args)>
		</cfcase>
		<cfcase value="datePicker">
			<cfset loc.input = datePicker(argumentCollection = loc.args, changeMonth = true, changeYear = true)>
		</cfcase>
		<cfcase value="datePickerTag">
			<cfset loc.input = datePickerTag(argumentCollection = loc.args, changeMonth = true, changeYear = true)>
		</cfcase>
		<cfcase value="checkBox">
			<cfset loc.input = checkBox(argumentCollection = loc.args)>
		</cfcase>
		<cfcase value="checkBoxTag">
			<cfset loc.input = checkBoxTag(argumentCollection = loc.args)>
		</cfcase>
		<cfcase value="dateSelect">
			<cfset loc.input = dateSelect(argumentCollection = loc.args)>
		</cfcase>
		<cfcase value="dateSelectTags">
			<cfset loc.input = dateSelectTags(argumentCollection = loc.args)>
		</cfcase>
		<cfcase value="timeSelect">
			<cfset loc.input = timeSelect(argumentCollection = loc.args)>
		</cfcase>
		<cfcase value="timeSelectTags">
			<cfset loc.input = timeSelectTags(argumentCollection = loc.args)>
		</cfcase>
		<cfcase value="hiddenFieldTag">
			<cfset loc.input = hiddenFieldTag(argumentCollection = loc.args)>
		</cfcase>
		<cfcase value="monthSelectTag">
			<cfset loc.input = monthSelectTag(argumentCollection = loc.args)>
		</cfcase>
		<cfcase value="yearSelectTag">
			<cfset loc.input = yearSelectTag(argumentCollection = loc.args)>
		</cfcase>
		<cfcase value="hasManyCheckBox">
			<cfset loc.input = hasManyCheckBox(argumentCollection = loc.args)>
		</cfcase>
		<cfcase value="toggle">
			<cfsavecontent variable="loc.input">
				<cfoutput>
					<div class="toggleSwitch">#hiddenFieldTag(label = "", name = "#arguments.objectName#[#arguments.property#]($checkbox)", value = "0")#
						#checkBox(
							argumentCollection = loc.args,
							label = " ",
							checkedValue = "1",
							uncheckedValue = "",
							labelPlacement = "after"
						)#</div>
				</cfoutput>
			</cfsavecontent>
		</cfcase>
		<cfcase value="toggleTag">
			<cfsavecontent variable="loc.input">
				<cfoutput>
					<div class="toggleSwitch">
						<cfif !structKeyExists(arguments, "noDefault")>#hiddenFieldTag(label = "", name = "#arguments.name#($checkbox)", value = "0")#</cfif>
						#checkBoxTag(
							argumentCollection = arguments,
							label = " ",
							checkedValue = "1",
							labelPlacement = "after"
						)#
					</div>
				</cfoutput>
			</cfsavecontent>
		</cfcase>
		<cfcase value="cssCheckbox">
			<cfset arguments.showLabel = false />
			<cfsavecontent variable="loc.input">
				<cfoutput>
					#hiddenFieldTag(label = "", name = "#arguments.objectName#[#arguments.property#]($checkbox)", value = "0")#
					#checkBox(
						argumentCollection = arguments,
						checkedValue = "1",
						uncheckedValue = "",
						labelPlacement = "after"
					)#
				</cfoutput>
			</cfsavecontent>
		</cfcase>
		<cfcase value="cssCheckboxTag">
			<cfsavecontent variable="loc.input">
				<cfoutput>
					<div class="cssCheckbox#structKeyExists(arguments, "newStyle") && isTrue(arguments.newStyle) ? "New" : ""#">
						<cfif !structKeyExists(arguments, "noDefault")>#hiddenFieldTag(label = "", name = "#arguments.name#($checkbox)", value = "0")#</cfif>
						#checkBoxTag(
							argumentCollection = arguments,
							label = "#arguments.label#",
							checkedValue = "1",
							labelPlacement = "after"
						)#
					</div>
				</cfoutput>
			</cfsavecontent>
		</cfcase>
		<cfcase value="CKEditor"></cfcase>
		<cfdefaultcase>
			<cfthrow message="Unknown inputType ('#arguments.inputType#') for input() view helper">
		</cfdefaultcase>
	</cfswitch>

	<cfset loc.return = '' />

	<cfif isTrue(arguments.markup ?: true)>
		<cfset loc.return = '<div class="#StructKeyExists(arguments,"markupClass") ? arguments.markupClass : "col-1-1 col-tablet-1-2 col-desktop-1-4 rev__pad-lg-v-top" #">' & crlf()>
	</cfif>
	<cfif isTrue(arguments.labelSpacer ?: false)>
		<cfset loc.return &= '<label class="hidden-mobile">&nbsp;</label>' & crlf()>
	</cfif>

		<cfif isTrue(arguments.showLabel ?: true)>
			<cfset loc.return &= '<label>#arguments.label#' & crlf()>
		</cfif>
			<cfset loc.return &= loc.input & crlf()>
		<cfif isTrue(arguments.showLabel ?: true)>
			<cfset loc.return &= '</label>' & crlf()>
		</cfif>
	<cfif isTrue(arguments.markup ?: true)>
		<cfset loc.return &= '</div>'>
	</cfif>

	<cfreturn loc.return>
</cffunction>

<cffunction name="yesNoRadioButtons">
	<cfset var loc = {}/>
	<cfset var inlinestyle = structKeyExists(arguments, "inlinestyle") && isTrue(arguments.inlinestyle) || !structKeyExists(
		arguments,
		"inlinestyle"
	)/>
	<cfoutput>
		<cfsavecontent variable="loc.return">
			<cfif StructKeyExists(arguments, "label") && Len(Trim(arguments.label))>
				<span class="psudo-label">#arguments.label#</span>
			</cfif>
			<div class="yes-no-container rev__marg-#StructKeyExists(arguments, "margTop") ? arguments.margTop : 'sm'#-v-top">
				#radioButton(
					argumentCollection = arguments,
					label = "Yes",
					tagValue = "1",
					labelPlacement = "after"
				)#
				#radioButton(
					argumentCollection = arguments,
					label = "No",
					tagValue = "0",
					labelPlacement = "after"
				)#
			</div>
		</cfsavecontent>
	</cfoutput>
	<cfreturn loc.return>
</cffunction>

<cfscript>

/**
 * Returns a button inside a form for posting that is able to use the confirm argument
 *
 * [section: Application]
 * [category: View Helpers]
 *
 * @keys A structure of key values that will be passed to the form tag's route argument. Eg: `{officeKey=1, key=2}`
 */
function postButton(
	required string route,
	required string method,
	required struct keys,
	required string text,
	string class,
	string confirm
) {
	local.returnValue = startFormTag(
		route=arguments.route,
		method=arguments.method,
		argumentCollection=arguments.keys,
		encode=false,
		class="rev__inline"
	);
	local.returnValue &= buttonTag(
		content=arguments.text,
		class=arguments.class,
		confirm=arguments.confirm
	);
	local.returnValue &= endFormTag();
	return local.returnValue;
}

/**
* Returns a plupload widget
*
* ```
* #pluploadWidget(
* route = "myRoute",
* mimeTypes = [{
* title: 'Document Types',
* extensions: 'pdf,csv'
* }]
* )#
* ```
*
* [section: Application]
* [category: View Helpers]
*
* @mimeTypes An array or structs. See usage above
*/
</cfscript>
<cffunction name="pluploadWidget" access="public" output="true">
	<cfargument name="mimeTypes" default=[] required=false>
	<!--- TODO: more options... eg: multi_selection --->
	<!--- https://www.plupload.com/docs/v2/Options --->
	<cfif arrayLen(arguments.mimeTypes)>
		<script>
		window._plupload = {
			mime_types: #SerializeJSON(lowerCaseStructKeys(arguments.mimeTypes))#
		};
		</script>
	</cfif>

	<cf_head>
		<!--- #styleSheetLinkTag("load-awesome-1.1.0/line-scale.min.css,plupload.css")# --->
		#javaScriptIncludeTag("plupload-2.3.6/plupload.full.min.js,plupload.js")#
	</cf_head>

	<cfset AWSUploaderPolicy = getAWSUploaderPolicy()>

	<cfoutput>
		<cfsavecontent variable="local.returnValue">
			<div class="rev__pad-v-bottom rev__pad-h rev__border rev__bg-light rev__marg-v-top">
				<div
					id="plupload"
					data-upload="#urlFor(argumentCollection = arguments)#"
					data-endpoint="#get("plupload").endpoint#"
					data-bucket="#get("plupload").chunkingBucketName#"
					data-key="#env("AWS_ACCESS_KEY_ID")#"
					data-policy="#AWSUploaderPolicy.policy#"
					data-signature="#AWSUploaderPolicy.signature#"
				>
					<div class="warning">Your browser doesn't have Flash, Silverlight or HTML5 support.</div>
					<div class="error"></div>
					<div class="filelist"></div>
					<div class="droptext rev__pad-sm rev__marg-v rev__text _txt-default _txt-extra-light _txt-uppercase _txt-sm _center">Drag files here</div>
					<div class="controls">
						<div class="hidden-mobile col-tablet-2-4 col-desktop-4-6"></div>
						<a href="javascript:void(0);" id="selectfiles" class="rev__btn col-1-2 col-tablet-1-4 col-desktop-1-6">Select files</a>
						<a href="javascript:void(0);" id="uploadfiles" class="rev__btn col-1-2 col-tablet-1-4 col-desktop-1-6 disabled">Upload files</a>
					</div>
					
				</div>
			</div>
		</cfsavecontent>
	</cfoutput>
	<cfreturn local.returnValue />
</cffunction>
