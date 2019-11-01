<cffunction name="shortURL" returntype="string" access="public">
	<cfargument name="string" required="true" type="string">
	<cfset var loc = {}>
	<cfset loc.return = arguments.string>
	<cfset loc.return = replaceNoCase(loc.return, "http://", "", "one")>
	<cfset loc.return = replaceNoCase(loc.return, "https://", "", "one")>
	<cfreturn loc.return>
</cffunction>

<cffunction name="ifEmpty" access="public" output="false" returntype="string" hint="returns a string if value is empty">
	<cfargument name="string1" type="string" required="true" hint="string to test">
	<cfargument
		name="string2"
		type="string"
		required="false"
		default="#arguments.string1#"
		hint="string to display if not empty (defaults to string 1)"
	>
	<cfargument name="string3" type="string" required="false" default="--" hint="string to display if empty">
	<cfreturn trim(arguments.string1) eq "" ? arguments.string3 : arguments.string2>
</cffunction>

<cffunction name="ifZero" access="public" output="false" returntype="string" hint="formats a time for display">
	<cfargument name="value" type="numeric" required="true" hint="number to test">
	<cfargument name="string" type="string" required="false" default="" hint="string to display if value is zero">
	<cfreturn arguments.value eq 0 ? arguments.string : arguments.value>
</cffunction>

<cffunction
	name="hyphenify"
	access="public"
	output="false"
	returntype="string"
	hint="hyphenates a string for SES/slug purposes"
>
	<cfargument name="string" type="string" required="true">
	<cfargument name="ignore" type="string" required="false" default="">
	<cfreturn slugify(argumentCollection = arguments)>
</cffunction>

<cffunction
	name="slugify"
	access="public"
	output="false"
	returntype="string"
	hint="replaces spaces and non alphanumeric a string"
>
	<cfargument name="string" type="string" required="true">
	<cfargument name="with" type="string" required="false" default="-">
	<cfargument name="ignore" type="string" required="false" default="">
	<cfset var loc = {string = arguments.string, with = arguments.with}/>
	<cfset loc.double = loc.with & loc.with>
	<cfset loc.string = lCase(loc.string)>
	<cfset loc.string = reReplace(loc.string, "[ /]", loc.with, "all")>
	<cfset loc.string = reReplace(
		loc.string,
		"[^a-z0-9#arguments.ignore#]",
		loc.with,
		"all"
	)>
	<!--- strip any double occurences.. but not if we are replacing with empty string --->
	<cfif len(loc.with)>
		<cfloop condition="#find(loc.double, loc.string) gt 0#">
			<cfset loc.string = replace(
				loc.string,
				loc.double,
				loc.with,
				"all"
			)>
		</cfloop>
	</cfif>
	<!--- strip leading & trailing --->
	<cfif left(loc.string, 1) == loc.with>
		<cfset loc.string = right(loc.string, loc.string.Len() - 1)>
	</cfif>
	<cfif right(loc.string, 1) == loc.with>
		<cfset loc.string = left(loc.string, loc.string.Len() - 1)>
	</cfif>
	<cfreturn loc.string>
</cffunction>

<cfscript>
/**
* Store an array object in an element attribute
*/
public string function attributifyArray(required array array) {
	return swapQuotes(serializeJSON(arguments.array ?: []));
}

/**
* Given a string, I will replace underscores and hyphens with spaces
*
* @string A string to modify
*/
public string function deslugify(required string string) {
	return trim(reReplace(arguments.string, "[-_]", " ", "all"));
}

public any function securify(required numeric value, string salt = constant("securityString"), numeric minLength = 32) {
	local.hashids = new services.hashids(arguments.salt, arguments.minLength);
	return hashids.encode(arguments.value);
}

public any function desecurify(required string value, string salt = constant("securityString"), numeric minLength = 32) {
	local.hashids = new services.hashids(arguments.salt, arguments.minLength);
	local.decoded = hashids.decode(arguments.value);
	if (arrayLen(local.decoded) == 0) {
		return 0;
	} else if (arrayLen(local.decoded) == 1) {
		return local.decoded[1];
	} else {
		return local.decoded;
	}
}
</cfscript>

<cffunction name="possessify" output="false">
	<cfargument name="value" type="string" required="true" hint="the name of the possessor">
	<cfargument
		name="special"
		type="boolean"
		required="false"
		default="false"
		hint="set to true if it's either a plural or a name (proper noun)"
	>
	<cfset var loc = {}>
	<cfif arguments.special && right(arguments.value, 1) == "s">
		<cfreturn arguments.value & "'">
    <cfelse>
		<cfreturn arguments.value & "'s">
	</cfif>
</cffunction>

<cffunction name="crlf" access="public" output="false" returntype="string">
	<cfreturn server.os.name == "Linux" OR server.os.name == "Mac OS X" ? chr(10) : "#chr(13)##chr(10)#">
</cffunction>

<cffunction name="randomString" returntype="string" output="false">
	<cfargument
		name="type"
		type="string"
		required="false"
		default="alphanumeric"
		hint="[numeric|alpha|alphanumeric|secure|urlsafe]"
	/>
	<cfargument name="length" type="numeric" required="false" default="32">
	<cfargument name="mixedCase" type="boolean" required="false" default="false">
	<cfset var loc = {}>
	<cfset loc.return = "">
	<!--- define the characters available --->
	<cfset loc.numbers = "0,1,2,3,4,5,6,7,8,9">
	<cfset loc.letters = "a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z">
	<cfif arguments.mixedCase>
		<cfset loc.letters = listAppend(loc.letters, uCase(loc.letters))>
	</cfif>
	<cfset loc.symbols = "!,@,$,%,*,-,_,=,+,?,~">

	<!--- build a list of available characters --->
	<cfif arguments.type eq "numeric">
		<cfset loc.source = loc.numbers>
    <cfelseif arguments.type eq "alpha">
		<cfset loc.source = loc.letters>
    <cfelseif arguments.type eq "alphanumeric">
		<cfset loc.source = "#loc.letters#,#loc.numbers#">
    <cfelseif arguments.type eq "secure">
		<cfset loc.source = "#loc.letters#,#loc.numbers#,#loc.symbols#">
    <cfelseif arguments.type eq "urlsafe">
		<cfset loc.source = "#loc.letters#,#loc.numbers#,_,-">
    <cfelse>
		<cfthrow message="invalid type argument (#arguments.type#)">
	</cfif>
	<cfset loc.source = listToArray(loc.source)>

	<!--- build the string to the required length --->
	<cfloop from="1" to="#arguments.length#" index="loc.i">
		<cfset loc.return = loc.return & loc.source[randRange(1, loc.source.Len())]>
	</cfloop>
	<cfreturn loc.return>
</cffunction>

<cffunction
	name="titleise"
	access="public"
	output="No"
	displayname="Titleise"
	description="I capitalise the first letter of each word"
>
	<cfargument name="input" type="string" required="yes"/>
	<cfscript>
	var Words = "";
	var j = 1;
	var m = 1;
	var doCap = "";
	var thisWord = "";
	var excludeWords = [];
	var outputString = "";
	var temp = "";
	var initText = lCase(arguments.input);

	// Words to never capitalize
	excludeWords[1] = "an";
	excludeWords[2] = "the";
	excludeWords[3] = "at";
	excludeWords[4] = "by";
	excludeWords[5] = "for";
	excludeWords[6] = "of";
	excludeWords[7] = "in";
	excludeWords[8] = "up";
	excludeWords[9] = "on";
	excludeWords[10] = "to";
	excludeWords[11] = "and";
	excludeWords[12] = "as";
	excludeWords[13] = "but";
	excludeWords[14] = "if";
	excludeWords[15] = "or";
	excludeWords[16] = "nor";
	excludeWords[17] = "a";

	// Make each word in text an array variable
	Words = listToArray(initText, " ");

	// Check words against exclude list
	for (j = 1; j LTE (arrayLen(Words)); j = j + 1) {
		doCap = true;

		// Word must be less that four characters to be in the list of excluded words
		if (len(Words[j]) LT 4) {
			if (listFind(arrayToList(excludeWords, ","), Words[j])) {
				doCap = false;
			}
		}

		// Capitalize hyphenated words
		if (listLen(Words[j], "-") GT 1) {
			for (m = 2; m LTE listLen(Words[j], "-"); m = m + 1) {
				thisWord = listGetAt(Words[j], m, "-");
				thisWord = uCase(mid(thisWord, 1, 1)) & mid(thisWord, 2, len(thisWord) - 1);
				Words[j] = listSetAt(Words[j], m, thisWord, "-");
			}
		}

		// Automatically capitalize first and last words
		if (j eq 1 or j eq arrayLen(Words)) {
			doCap = true;
		}

		// perform specific capitalisations (O'Grady)
		if (compareNoCase(left(Words[j], 2), "o'") eq 0 AND len(Words[j]) gt 2) {
			Words[j] = uCase(left(Words[j], 3)) & mid(Words[j], 4, len(Words[j]) - 3);
			doCap = false;
		}

		// perform specific capitalisations (McDonald)
		if (compareNoCase(left(Words[j], 2), "mc") eq 0 AND len(Words[j]) gt 2) {
			Words[j] = uCase(left(Words[j], 1)) & lCase(mid(Words[j], 2, 1)) & uCase(mid(Words[j], 3, 1)) & mid(
				Words[j],
				4,
				len(Words[j]) - 3
			);
			doCap = false;
		}

		// perform specific capitalisations ('Text' or "Text")
		if (listFindNoCase("'," & """", left(Words[j], 1)) AND len(Words[j]) gt 2) {
			Words[j] = uCase(left(Words[j], 2)) & mid(Words[j], 3, len(Words[j]) - 2);
			doCap = false;
		}

		// Capitalize qualifying words
		if (doCap) {
			Words[j] = uCase(mid(Words[j], 1, 1)) & mid(Words[j], 2, len(Words[j]) - 1);
		}
	}

	outputString = arrayToList(Words, " ");
	</cfscript>

	<cfreturn outputString/>
</cffunction>

<cfscript>
/**
* replaces crlf with html br tags
*/
public string function htmlify(required string string, string br = "<br/>") {
	local.returnValue = arguments.string;
	local.returnValue = replace(
		local.returnValue,
		chr(10),
		arguments.br,
		"all"
	); // LINE FEED
	local.returnValue = replace(local.returnValue, chr(13), "", "all"); // CARRIAGE RETURN
	local.returnValue = replace(local.returnValue, chr(09), "", "all"); // HORIZONTAL TAB
	return local.returnValue;
}

public string function htmlifyIfPlainText(required string string) {
	local.substrings = ["<p>", "<br />", "<br/>", "<br>"];
	if (containsAnySubstring(arguments.string, local.substrings)) {
		return arguments.string;
	} else {
		return htmlify(arguments.string);
	}
}
</cfscript>

<!--- DO NOT MODIFY THIS FUNCTION.. IT IS USED TO IDENTIFY EXISTING OFFICE ASSETS --->
<cffunction
	name="letterify"
	access="public"
	returntype="string"
	output="No"
	hint="substitutes number/s for their position in the alphabet"
>
	<cfargument name="value" type="numeric" required="Yes"/>
	<cfset var loc = {}>
	<cfset loc.alphabet = "abcdefghijklmnopqrstuvwxyz">
	<cfset loc.chars = arguments.value.toString().toCharArray()>
	<cfset loc.returnValue = "">
	<cfloop array="#loc.chars#" index="loc.i">
		<!--- because there is no letter with an index of zero, replace zero with z (for Zenu!) --->
		<cfset loc.returnValue = loc.returnValue & (loc.i == 0 ? "z" : loc.alphabet[loc.i])>
	</cfloop>
	<cfreturn loc.returnValue>
</cffunction>

<cffunction
	name="isPhone"
	access="public"
	returntype="boolean"
	output="No"
	hint="determines if the string pass is a phone or not"
>
	<cfargument name="string" type="string" required="Yes"/>
	<cfargument name="type" type="string" required="No" default="" hint="Mobile | Home"/>
	<!--- NOTE: not catering for international code for landline, i.e. +61398001000 --->

	<!--- remove spaces --->
	<cfset var st = replace(arguments.string, " ", "", "all")>
	<cfset var ret = false>
	<cfif isNumeric(st)>
		<cfif len(st) EQ 10 AND left(st, 2) EQ "04">
			<!--- e.g. 0411222333 --->
			<cfif arguments.type EQ "Mobile" OR arguments.type EQ "">
				<!--- <cfset ret = "Mobile"> --->
				<cfset ret = true>
			</cfif>
        <cfelseif len(st) EQ 11 AND left(st, 3) EQ "+64">
			<!--- e.g. +6411222333 --->
			<cfif arguments.type EQ "Mobile" OR arguments.type EQ "">
				<cfset ret = true>
			</cfif>
        <cfelseif len(st) EQ 10 AND (
				left(st, 2) EQ "02" OR left(st, 2) EQ "03" OR left(st, 2) EQ "07" OR left(st, 2) EQ "08"
			)>
			<!---
				home phone with state code, e.g 0398001000, 0291112222
				02	New South Wales, Australian Capital Territory
				03	Victoria, Tasmania
				07	Queensland
				08	South Australia, Northern Territory
			--->
			<cfif arguments.type EQ "Home" OR arguments.type EQ "">
				<!--- <cfset ret = "Home Phone"> --->
				<cfset ret = true>
			</cfif>
        <cfelseif len(st) EQ 8 AND left(st, 1) GT 1>
			<!---
				no state code, e.g. 98001000
				02	9XXX, 8XXX, 7XXX XXXX	Sydney
				02	4XXX XXXX	Newcastle, Wollongong
				02	5XXX, 6XXX XXXX	Canberra
				02	5XXX XXXX	Bathurst, Coffs Harbour, Lismore, Orange
				02	5XXX XXXX	Albury, Wodonga
				03	9XXX, 8XXX, 7XXX XXXX	Melbourne
				03	4XXX, 5XXX XXXX	Ballarat, Bendigo, Mildura, Warrnambool
				03	6XXX XXXX	Hobart, Devonport, Launceston
				04	XX XXX XXX	Mobile Phones (Australia wide)
				07	3XXX, 2XXX XXXX	Brisbane
				07	5XXX XXXX	Gold Coast, Sunshine Coast
				07	4XXX XXXX	Cairns, Townsville, Toowoomba
				08	8XXX, 7XXX XXXX	Adelaide
				08	8XXX, 7XXX XXXX	Darwin, Alice Springs
				08	9XXX, 6XXX, 5XXX XXXX	Perth
			--->
			<cfif arguments.type EQ "Home" OR arguments.type EQ "">
				<!--- <cfset ret = "Home Phone"> --->
				<cfset ret = true>
			</cfif>
        <cfelseif reFind("^1(3\d{4}|[38]00\d{6})$", st)>
			<!---
				13, 1300 and 1800 numbers are virtual numbers that are routed to an answering point that can either be a landline or a mobile number.
				13, 1300 and 1800 numbers can only be used for receiving calls and that's why they are called inbound numbers.
				---
				13 numbers are six-digit numbers
				1300 numbers are 10-digit numbers
				1800 numbers are also 10-digit numbers
			--->
			<cfif arguments.type eq "Home" or !len(arguments.type)>
				<cfreturn true/>
			</cfif>
        <cfelse>
			<!--- https://github.com/googlei18n/libphonenumber --->
			<cfif !reFind("^\+", st)>
				<cfset st = "+" & st/>
			</cfif>
			<cfset local.phoneNumberUtil = createObject("java", "com.google.i18n.phonenumbers.PhoneNumberUtil").getInstance()/>
			<cftry>
				<cfset local.phoneNumber = local.phoneNumberUtil.parse(st.toString(), "")/>
				<cfcatch>
					<cfreturn false/>
				</cfcatch>
			</cftry>
			<cfreturn local.phoneNumberUtil.isValidNumber(local.phoneNumber)/>
		</cfif>
	</cfif>

	<cfreturn ret/>
</cffunction>

<cfscript>
/**
* A nicely named wrapper for the overloaded isPhone function
*
* @string A string to be checked for a valid mobile phone number
*/
public boolean function isValidMobilePhoneNumber(required string string) {
	return isPhone(arguments.string, "mobile");
}

/**
* A nicely named wrapper for the overloaded isPhone function
*
* @string A string to be checked for a valid landline phone number
*/
public boolean function isValidLandlineNumber(required string string) {
	return isPhone(arguments.string, "home");
}


/**
* formats a phone number for display
*/
/**
* Formats a phone number for display
*
* @phone A phone number to be formatted
*/
public string function formatPhone(required string phone) output=false {
	local.phone = reReplaceNoCase(
		trim(arguments.phone),
		"[^+0123456789]",
		"",
		"ALL"
	);
	if (len(local.phone) == 9 && left(local.phone, 1) == "4") {
		// mobile: 411222333 -> 0411 222 333
		local.returnValue = "0#left(local.phone, 3)# #mid(local.phone, 4, 3)# #right(local.phone, 3)#";
	} else if (len(local.phone) >= 8 && left(local.phone, 2) == "04") {
		// mobile: 0411222333 -> 0411 222 333
		local.returnValue = "#left(local.phone, 4)# #mid(local.phone, 5, 3)# #mid(local.phone, 8, len(local.phone) - 7)#";
	} else if (len(local.phone) >= 12 && left(local.phone, 4) == "+614") {
		// mobile: +61411222333 -> +61 411 222 333
		local.returnValue = "#left(local.phone, 3)# #mid(local.phone, 4, 3)# #mid(local.phone, 7, 3)# #mid(local.phone, 10, len(local.phone) - 7)#";
	} else if (len(local.phone) >= 10 && left(local.phone, 1) == "0") {
		// land line: 0398001234 -> 03 9800 1234
		local.returnValue = "#left(local.phone, 2)# #mid(local.phone, 3, 4)# #mid(local.phone, 7, len(local.phone) - 4)#";
	} else if (len(local.phone) >= 10 && left(local.phone, 3) == "+60") {
		// land line: +60398001234
		local.returnValue = "#left(local.phone, 4)# #mid(local.phone, 5, 4)# #mid(local.phone, 9, len(local.phone) - 8)#";
	} else if (len(local.phone) == 8) {
		// land line: 98001234
		local.returnValue = "#left(local.phone, 4)# #mid(local.phone, 5, len(local.phone) - 4)#";
	} else {
		local.returnValue = arguments.phone; // changed from local.phone to arguments.phone
	}
	return local.returnValue;
}
</cfscript>

<!---
	Converts Byte values to the shortest human-readable format
	03-mar-2010 minor change to the way units variable was created
	@param bytes 	 size in bytes to format (Required)
	@param maxreduction 	 limit on reduction (Optional)
	@return returns a string
	@author Joerg Zimmer (joerg@zimmer-se.de)
	@version 0, March 3, 2010
--->
<cffunction name="byteAutoConvert" access="public" returntype="string" output="false">
	<cfargument name="bytes" type="numeric" required="true">
	<cfargument name="maxreduction" type="numeric" required="false" default="9">
	<cfset var units = listToArray("B,KB,MB,GB,TB,PB,EB,ZB,YB", ",")>>
<cfset var conv = 0>
	<cfset var exp = 0>

	<cfif arguments.maxreduction gte 9>
		<cfset arguments.maxreduction = arrayLen(units) - 1>
	</cfif>

	<cfif arguments.bytes gt 0>
		<cfset exp = fix(log(arguments.bytes) / log(1024))>
		<cfif exp gt arguments.maxreduction>
			<cfset exp = arguments.maxreduction>
		</cfif>
		<cfset conv = arguments.bytes / (1024^exp)>
	</cfif>

	<cfreturn "#trim(lsNumberFormat(conv, "_____.00"))# #units[exp + 1]#"/>
</cffunction>

<cfscript>
function term(required string term, string condition = "") {
	var loc = {};
	local.returnValue = $_typeCase(arguments.term, arguments.term);
	switch (arguments.term) {
		case "staff":
			local.returnValue = titleise($_typeCase("team member", arguments.term));
			break;
		case "sneak preview":
			local.returnValue = titleise($_typeCase("sneak preview", arguments.term));
			break;
		case "opposition":
			local.returnValue = titleise($_typeCase("opposition", arguments.term));
			break;
		case "property":
			local.returnValue = titleise($_typeCase("prospect", arguments.term));
			break;
		case "private sale":
			local.returnValue = titleise($_typeCase("For Sale", arguments.term));
			break;
		case "forsale":
			local.returnValue = titleise($_typeCase("For Sale", arguments.term));
			break;
		case "lease":
			local.returnValue = titleise($_typeCase("Lease", arguments.term));
			break;
		case "eoi":
			local.returnValue = titleise($_typeCase("Expressions of Interest", arguments.term));
			break;
		case "sms":
			local.returnValue = titleise($_typeCase("text", arguments.term));
			break;
		case "contract holders":
			if (listFindNoCase("commercial,business", arguments.condition)) {
				local.returnValue = titleise($_typeCase("document holders", arguments.term));
			} else {
				local.returnValue = titleise($_typeCase(arguments.term, arguments.term));
			}
			break;
		case "fixed date sale":
			loc.fixedDateTermSwapGroups = "92,181";
			if (len(listInCommon(loc.fixedDateTermSwapGroups, arguments.office.groupList ?: "")) > 0) {
				local.returnValue = titleise($_typeCase("Set Date Sale", arguments.term));
			}
			break;
		case "listing_date_listed":
			local.returnValue = "Date Listed";
			break;
		case "appraisal_date":
			local.returnValue = "Appraisal Date";
			break;
		case "rentals_date_leased":
			local.returnValue = "Date Leased";
			break;
		case "off_market_date":
			local.returnValue = "Off Market Date";
			break;
		case "on_market_date":
			local.returnValue = "On Market Date";
			break;
		case "prelisting_date":
			local.returnValue = "Pre-Listing Date";
			break;
		case "pre_sold_date":
			local.returnValue = "Pre-Sold Date";
			break;
		case "property_date":
			local.returnValue = "Property Date";
			break;
		case "listing_settlement_date":
			local.returnValue = "Settlement Date";
			break;
		case "sneak_preview_date":
			local.returnValue = "Sneak Preview Date";
			break;
		case "listing_unconditional_date":
			local.returnValue = "Unconditional Date";
			break;
		case "listing_settlement_date":
			local.returnValue = "Settlement Date";
			break;
		case "listing_contract_date":
			local.returnValue = "Contract Date";
			break;
		case "under_offer_date":
			local.returnValue = "Under Offer Date";
			break;
		case "listing_withdrawn_date":
			local.returnValue = "Withdrawn Date";
			break;
		case "under offer":
			if (arguments.condition == "project") {
				local.returnValue = "Reserved";
			}
			break;
		case "pre-listing":
			if (arguments.condition == "project") {
				local.returnValue = "Not Released";
			}
			break;
		case "off market":
			if (arguments.condition == "project") {
				local.returnValue = "For Sale";
			}
			break;
		case "on market":
			if (arguments.condition == "project") {
				local.returnValue = "For Sale Advertised";
			}
			break;
		case "realestate.com.au":
			local.returnValue = "REALESTATE.COM.AU";
			if (listFindNoCase("commercial,business", arguments.condition)) {
				local.returnValue = "REALCOMMERCIAL.COM.AU";
			}
			break;
		case "realestate.com.au (secondary)":
			local.portalName = "REALESTATE.COM.AU";
			if (listFindNoCase("commercial,business", arguments.condition)) {
				local.portalName = "REALCOMMERCIAL.COM.AU";
			}
			local.returnValue = "#local.portalName# (SECONDARY)";
			// phillip webb
			if (len(listInCommon("128", arguments.office.groupList ?: "")) > 0) {
				local.returnValue = "#local.portalName# (UPGRADE)";
				// belle
			} else if (len(listInCommon("181", arguments.office.groupList ?: "")) > 0) {
				local.returnValue = "#local.portalName# (PREMIUM)";
			}
			break;
		case "domain.com.au":
			local.returnValue = "DOMAIN.COM.AU";
			if (listFindNoCase("commercial,business", arguments.condition)) {
				local.returnValue = "COMMERCIALREALESTATE.COM.AU";
			}
			break;
		case "domain.com.au (secondary)":
			local.portalName = "DOMAIN.COM.AU";
			if (listFindNoCase("commercial,business", arguments.condition)) {
				local.portalName = "COMMERCIALREALESTATE";
			}
			local.returnValue = "#local.portalName# (SECONDARY)";
			// belle
			if (len(listInCommon("181", arguments.office.groupList ?: "")) > 0) {
				local.returnValue = "#local.portalName# (PREMIUM)";
			}
			break;
	}
	return local.returnValue;
}
</cfscript>

<cffunction name="$_typeCase" access="private" output="false" hint="attempts to return string in same case">
	<cfargument name="type" type="string" required="true" hint="the string to change">
	<cfargument name="typeCase" type="string" required="true" hint="the string to base casing on">
	<cfif reFind("[abcdefghijklmnopqrstuvwxyz]", arguments.typeCase) eq 0>
		<!--- no lowercase letters --->
		<cfreturn uCase(arguments.type)>
    <cfelseif reFind("[ABCDEFGHIJKLMNOPQRSTUVWXYZ]", arguments.typeCase) eq 0><!--- no uppercase letters --->
		<cfreturn lCase(arguments.type)>
    <cfelse>
		<cfreturn capitalize(arguments.type)>
	</cfif>
</cffunction>

<cffunction
	name="ratePassword"
	displayname="Rate Password"
	output="No"
	returntype="struct"
	hint="Returns a struct containing a score % and a rating string"
>
	<cfargument name="password" type="string" required="Yes"/>

	<cfset var score = 0/><!--- will be out of 100 --->
	<cfset var rating = ""/><!--- [empty|very weak|weak|mediocre|strong|very strong] --->

	<cfset var containsLetters = false/>
	<cfset var containsUpper = false/>
	<cfset var containsLower = false/>
	<cfset var containsNumbers = false/>
	<cfset var containsSpecialChars = false/>

	<cfset var return = {}/>

	<!--- test password length --->
	<cfif len(arguments.password) eq 0>
		<cfset score = -1/>
    <cfelseif len(arguments.password) gt 0 && len(arguments.password) lt 5>
		<cfset score = score + 3/>
    <cfelseif len(arguments.password) gt 4 && len(arguments.password) lt 8>
		<cfset score = score + 6/>
    <cfelseif len(arguments.password) gt 7 && len(arguments.password) lt 12>
		<cfset score = score + 12/>
    <cfelseif len(arguments.password) gt 11>
		<cfset score = score + 18/>
	</cfif>

	<!--- alpha --->
	<cfif reFind("[a-z]", arguments.password) gt 0>
		<!--- at least one lower case letter --->
		<cfset score = score + 1/>
		<cfset containsLetters = true/>
		<cfset containsLower = true/>
	</cfif>
	<cfif reFind("[A-Z]", arguments.password) gt 0>
		<!--- at least one upper case letter --->
		<cfset score = score + 5/>
		<cfset containsLetters = true/>
		<cfset containsUpper = true/>
	</cfif>

	<!--- numeric --->
	<cfif reFind("[0-9]", arguments.password) gt 0>
		<!--- at least one number --->
		<cfset score = score + 5/>
		<cfset containsNumbers = true/>
	</cfif>
	<cfif reFind("(.*[0-9].*[0-9].*[0-9])", arguments.password) gt 0>
		<!--- at least three numbers --->
		<cfset score = score + 5/>
	</cfif>

	<!--- special characters --->
	<cfif reFind(".[!,@,##,$,%,^,&,*,?,_,~]", arguments.password) gt 0>
		<!--- at least one special character --->
		<cfset score = score + 5/>
		<cfset containsSpecialChars = true/>
	</cfif>
	<cfif reFind("(.*[!,@,##,$,%,^,&,*,?,_,~].*[!,@,##,$,%,^,&,*,?,_,~])", arguments.password) gt 0>
		<!--- at least two special characters --->
		<cfset score = score + 5/>
	</cfif>

	<!--- combos --->
	<cfif containsUpper && containsLower>
		<!--- both upper and lower case --->
		<cfset score = score + 2/>
	</cfif>
	<cfif containsLetters && containsNumbers>
		<!--- both letters and numbers --->
		<cfset score = score + 2/>
	</cfif>
	<cfif containsLetters && containsNumbers && containsSpecialChars>
		<!--- letters, numbers, and special characters --->
		<cfset score = score + 2/>
	</cfif>

	<cfset return.score = score * 2/>

	<!--- get rating string --->
	<cfif score eq -1>
		<cfset return.rating = ""/>
    <cfelseif score gt -1 && score lt 16>
		<cfset return.rating = "Very Weak"/>
    <cfelseif score gt 15 && score lt 25>
		<cfset return.rating = "Weak"/>
    <cfelseif score gt 24 && score lt 35>
		<cfset return.rating = "Fair"/>
    <cfelseif score gt 34 && score lt 45>
		<cfset return.rating = "Strong"/>
    <cfelse>
		<cfset return.rating = "Very Strong"/>
	</cfif>
	<cfreturn return/>
</cffunction>

<cfscript>
// a better named wrapper
public string function compressHTML(required string string, numeric level = 2) {
	return htmlCompressFormat(argumentCollection = arguments);
}

function htmlCompressFormat(required string string, numeric level = 2) {
	local.returnValue = trim(arguments.string);
	switch (arguments.level) {
		case "3": {
			// extra compression can screw up a few little pieces of HTML, doh
			local.returnValue = reReplace(
				local.returnValue,
				"[[:space:]]{2,}",
				" ",
				"all"
			);
			local.returnValue = replace(local.returnValue, "> <", "><", "all");
			local.returnValue = reReplace(
				local.returnValue,
				"<!--[^>]+>",
				"",
				"all"
			);
			local.returnValue = replace(local.returnValue, crlf(), "", "all");
			break;
		}
		case "2": {
			local.returnValue = reReplace(
				local.returnValue,
				"[[:space:]]{2,}",
				crlf(),
				"all"
			);
			break;
		}
		case "1": {
			// only compresses after a line break
			local.returnValue = reReplace(
				local.returnValue,
				"(" & crlf() & ")+[[:space:]]{2,}",
				crlf(),
				"all"
			);
			break;
		}
	}
	return local.returnValue;
}

/**
* Strips surplus line breaks from between angle brackets
*
* [section: Application]
* [category: String Functions]
*
* @string String to remove surplus line breaks from
*/
public string function stripSurplusLineBreaksFromXml(required string string) {
	return reReplaceNoCase(
		arguments.string,
		">\s+<",
		">#crlf()#<",
		"all"
	);
}

/**
* Abbreviates a given string to roughly the given length, stripping any tags, making sure the ending doesn't chop a word in two, and adding an ellipsis character at the end.
* Fix by Patrick McElhaney
* v3 by Ken Fricklas kenf@accessnet.net, takes care of too many spaces in text.
*
* @param string	  String to use. (Required)
* @param len	  Length to use. (Required)
* @return Returns a string.
* @author Gyrus (kenf@accessnet.netgyrus@norlonto.net)
* @version 3, September 6, 2005
*/
public string function abbreviate(string, len) {
	var newString = reReplace(string, "<[^>]*>", " ", "ALL");
	var lastSpace = 0;
	newString = reReplace(newString, " \s*", " ", "ALL");
	if (len(newString) gt len) {
		newString = left(newString, len - 2);
		lastSpace = find(" ", reverse(newString));
		lastSpace = len(newString) - lastSpace;
		newString = left(newString, lastSpace) & "  &##8230;";
	}
	return newString;
}

/**
* Removes HTML from the string.
* v2 - Mod by Steve Bryant to find trailing, half done HTML.
* v4 mod by James Moberg - empties out script/style blocks
*
* @param string 	 String to be modified. (Required)
* @return Returns a string.
* @author Raymond Camden (ray@camdenfamily.com)
* @version 4, October 4, 2010
*/
public string function stripHTML(str) {
	str = reReplaceNoCase(
		str,
		"<*style.*?>(.*?)</style>",
		"",
		"ALL"
	);
	str = reReplaceNoCase(
		str,
		"<*script.*?>(.*?)</script>",
		"",
		"ALL"
	);

	str = reReplaceNoCase(str, "<.*?>", "", "ALL");
	// get partial html in front
	str = reReplaceNoCase(str, "^.*?>", "");
	// get partial html at end
	str = reReplaceNoCase(str, "<.*$", "");
	return trim(str);
}

public string function replaceSpecialCharacters(required string string) {
	var loc = {};
	var loc.string = arguments.string;

	if (loc.string.Len() && reFind(loc.whiteList, loc.string) gt 0) {
		// Double Quotes
		loc.string = replaceNoCase(
			loc.string,
			"#chr(8220)#",
			"&ldquo;",
			"ALL"
		);
		loc.string = replaceNoCase(
			loc.string,
			"#chr(8221)#",
			"&rdquo;",
			"ALL"
		);
		// Single Quotes
		loc.string = replaceNoCase(loc.string, "#chr(8216)#", "'", "ALL");
		loc.string = replaceNoCase(loc.string, "#chr(8217)#", "'", "ALL");
		loc.string = replaceNoCase(loc.string, "#chr(8218)#", "'", "ALL");
		loc.string = replaceNoCase(loc.string, "’", "'", "ALL");
		// Bullet points
		loc.string = replaceNoCase(loc.string, "#chr(8211)#", "-", "ALL");
		loc.string = replaceNoCase(loc.string, "#chr(8212)#", "-", "ALL");
		loc.string = replaceNoCase(loc.string, "#chr(8226)#", "-", "ALL");
		loc.string = replaceNoCase(loc.string, "#chr(0183)#", "-", "ALL");
		loc.string = replaceNoCase(loc.string, "#chr(61544)#", "-", "ALL");
		loc.string = replaceNoCase(loc.string, "#chr(61548)#", "-", "ALL");
		loc.string = replaceNoCase(loc.string, "#chr(61623)#", "-", "ALL");
		// Other
		loc.string = replaceNoCase(loc.string, "#chr(166)#", "|", "ALL");
		loc.string = replaceNoCase(
			loc.string,
			"#chr(169)#",
			"&copy;",
			"ALL"
		);
		loc.string = replaceNoCase(loc.string, "#chr(178)#", "2", "ALL");
		loc.string = replaceNoCase(loc.string, "#chr(188)#", "1/4", "ALL");
		loc.string = replaceNoCase(loc.string, "#chr(189)#", "1/2", "ALL");
		loc.string = replaceNoCase(loc.string, "#chr(190)#", "3/4", "ALL");
		loc.string = replaceNoCase(loc.string, "#chr(200)#", "E", "ALL");
		loc.string = replaceNoCase(loc.string, "#chr(231)#", "c", "ALL");
		loc.string = replaceNoCase(loc.string, "#chr(233)#", "e", "ALL");
		loc.string = replaceNoCase(
			loc.string,
			"#chr(8230)#",
			"...",
			"ALL"
		);
		loc.string = replaceNoCase(loc.string, "#chr(8252)#", "!!", "ALL");
		loc.string = replaceNoCase(
			loc.string,
			"#chr(8364)#",
			"&euro;",
			"ALL"
		);
		loc.string = replaceNoCase(loc.string, "#chr(11)#", "  ", "ALL");

		// remove any remaining ASCII 128-159 characters
		loop from=128 to=159 index="loc.i" {
			loc.string = replace(loc.string, chr(loc.i), "", "All");
		}
		// encode ASCII 160-255 using ? format
		loop from=160 to=255 index="loc.i" {
			loc.string = reReplace(
				string,
				chr(loc.i),
				"&###loc.i#;",
				"All"
			);
		}
	}
	return loc.string;
}

// removes repeats of strings.. eg replace "  " with " "
public string function removeRepeats(required string string, string substring = " ") {
	var loc = {};
	loc.returnValue = arguments.string;
	loc.repeat = repeatString(arguments.substring, 2);
	while (find(loc.repeat, loc.returnValue)) {
		loc.returnValue = replace(
			loc.returnValue,
			loc.repeat,
			arguments.substring,
			"all"
		);
	}
	return loc.returnValue;
}

public string function stripNonKeyboardCharacters(required string string) {
	return reReplaceNoCase(
		arguments.string,
		"[^a-zA-Z0-9\.\?\*\^\&\*\[\]\\""-_`~,;:@!$%'<>(){}+|/\###chr(13)##chr(10)#\t ]",
		"",
		"ALL"
	);
}

public string function stripSpaces(required string string) {
	return replace(arguments.string, " ", "", "all");
}

public string function stripCRLF(required string string) {
	var loc = {};
	loc.rv = arguments.string;
	loc.rv = replace(loc.rv, chr(10), "", "all");
	loc.rv = replace(loc.rv, chr(13), "", "all");
	return loc.rv;
}

public string function stripTabs(required string string) {
	return reReplace(arguments.string, "\t", "", "all");
}

public string function stripSingleQuotes(required string string) {
	return replace(arguments.string, "'", "", "all");
}

public string function stripDoubleQuotes(required string string) {
	return replace(arguments.string, """", "", "all");
}

public string function stripQuotes(required string string) {
	arguments.string = stripSingleQuotes(arguments.string);
	arguments.string = stripDoubleQuotes(arguments.string);
	return arguments.string;
}

public string function swapQuotes(required string string) {
	if (arguments.string contains """") {
		return replace(arguments.string, """", "'", "all");
	} else {
		return replace(arguments.string, "'", """", "all");
	}
}

public string function javaScriptSafeQuotes(required string string) {
	return replace(arguments.string, "'", "&quot;", "all");
}

public string function escapeQuotes(required string string) {
	arguments.string = replace(arguments.string, "'", "\'", "all");
	arguments.string = replace(arguments.string, """", "\""", "all");
	return arguments.string;
}

public string function stripEmojis(required string string) {
	// Match Emoticons
	var regexEmoticons = "[\x{1F600}-\x{1F64F}]";
	// Match Miscellaneous Symbols and Pictographs
	var regexSymbols = "[\x{1F300}-\x{1F5FF}]";
	// Match Transport And Map Symbols
	var regexTransport = "[\x{1F680}-\x{1F6FF}]";
	// Supplemental Symbols and Pictographs
	var regexSupplemental = "[\x{1F900}-\x{1F9FF}]";

	// Return cleaned and trimmed string
	return arguments.string
		.replaceAll(local.regexEmoticons, "")
		.replaceAll(local.regexSymbols, "")
		.replaceAll(local.regexTransport, "")
		.replaceAll(local.regexSupplemental, "")
		.trim();
}

/**
* Hint
* Displays a number in contracted ordinal format. 1st, 2nd, 3rd 4th etc
*/
public string function th(required numeric number) {
	var loc = {};
	loc.num = arguments.number;
	loc.lastTwoDigits = right(arguments.number, loc.num lt 10 ? 1 : 2);
	loc.lastDigit = right(arguments.number, 1);
	if (loc.num lt 1) {
		return loc.num;
	} else if (listFind("11,12,13,14", loc.lastTwoDigits)) {
		return "#loc.num#th";
	} else if (loc.lastDigit == 1) {
		return "#loc.num#st";
	} else if (loc.lastDigit == 2) {
		return "#loc.num#nd";
	} else if (loc.lastDigit == 3) {
		return "#loc.num#rd";
	} else {
		return "#loc.num#th";
	}
}

public string function emailFromFormat(required string email, string name = "") {
	if (len(arguments.name)) {
		return "#arguments.name# <#arguments.email#>";
	} else {
		return arguments.email;
	}
}

public string function uniqueParamKey() {
	return "sla#randomString("urlsafe", 26)#yer";
}

/*
  if letter name is Mr Smith & Mrs Smith, re-populate to Mr & Mrs Smith
  * OR Mrs Smith & Mr Smith, re-populate to Mrs & Mr Smith
  * OR Dr Smith & Mrs Smith, re-populate to Dr & Mrs Smith
  * OR Mr Smith & Mr Smith, re-populate to Mr & Mr Smith
*/
public string function letterNameFormat(required string letter_name) {
	var letterName = arguments.letter_name;
	if (
		listLen(letterName, " ") == 5
		 && listGetAt(letterName, 3, " ") == "&"
		 && listGetAt(letterName, 2, " ") == listGetAt(letterName, 5, " ")
	) {
		letterName = "#listGetAt(letterName, 1, " ")# & #listGetAt(letterName, 4, " ")# #listGetAt(letterName, 2, " ")#";
	}
	return letterName;
}

public string function sanitiseURL(required string string) {
	var loc = {};
	if (len(arguments.string) && left(arguments.string, 4) != "http") {
		return "https://" & arguments.string;
	}
	return arguments.string;
}

public string function getDomainNameFromEmailAddress(required string email) {
	local.returnValue = getEmailAddressesFromString(arguments.email);
	local.returnValue = listLast(local.returnValue, "@");
	return lCase(local.returnValue);
}

/**
* Searches a string for email addresses.
*/
public string function getEmailAddressesFromString(str) {
	var email = "(['_a-z0-9-]+(\.['_a-z0-9-]+)*@[a-z0-9-]+(\.[a-z0-9-]+)*\.((aero|coop|info|museum|name|jobs|travel)|([a-z]{2,16})))";
	var res = "";
	var marker = 1;
	var matches = "";

	matches = reFindNoCase(email, str, marker, marker);

	while (matches.len[1] gt 0) {
		res = listAppend(res, mid(str, matches.pos[1], matches.len[1]));
		marker = matches.pos[1] + matches.len[1];
		matches = reFindNoCase(email, str, marker, marker);
	}
	return res;
}

/**
* string the leading slash from a string
*/
public string function stripLeadingSlash(required string string) {
	local.rv = arguments.string;
	if (listFind("/,\", left(local.rv, 1))) {
		local.rv = right(local.rv, len(local.rv) - 1);
	}
	return local.rv;
}

public string function stripLeadingString(required string string, required string substring) {
	local.rv = arguments.string;
	if (!len(arguments.substring)) {
		return local.rv;
	}
	if (left(arguments.string, len(arguments.substring)) == arguments.substring) {
		local.rv = replaceNoCase(
			arguments.string,
			arguments.substring,
			"",
			"one"
		);
	}
	return local.rv;
}

public string function stripTrailingString(required string string, required string substring) {
	local.rv = arguments.string;
	if (!len(arguments.substring)) {
		return local.rv;
	}
	if (right(arguments.string, len(arguments.substring)) == arguments.substring) {
		local.rv = mid(arguments.string, 1, len(arguments.string) - len(arguments.substring));
	}
	return local.rv;
}

/**
* The Lionel Richie function: given a number, returns a string like 'once', 'twice', 'n times'
*/
public string function howManyTimes(required numeric number) {
	if (arguments.number == 0) {
		return "none";
	} else if (arguments.number == 1) {
		return "once";
	} else if (arguments.number == 2) {
		return "twice";
	} else {
		return "#arguments.number# times";
	}
}

/* format number to dollar format but without cents */
public string function formatDollar(required string string) {
	if (arguments.string < 0) {
		return "($#numberFormat(replace(arguments.string, "-", ""))#)";
	} else {
		return "$" & numberFormat(arguments.string);
	}
}

/**
* Replaces double slashes with javascript style string concatenation eg: "/" + "/"
*/
public string function escapeDoubleSlashesForJavascript(required string string, string quote = "'") {
	local.rv = replace(
		arguments.string,
		"//",
		"/~ + ~/",
		"all"
	);
	local.rv = replace(local.rv, "~", arguments.quote, "all");
	return local.rv;
}

/* checks if a string contains non-ascii character */
public string function containsNonAscii(required string string) {
	// return ReFind("[^\x20-\x7E]", arguments.string);
	return reFindNoCase("[^a-zA-Z0-9\s\.\?\*\^\&\*\[\]\\""-_`~,;:@!$%'<>(){}+|/\###chr(13)##chr(10)#]", arguments.string);
}

public boolean function containsAnySubstring(required string string, required array substrings) {
	for (local.i in arguments.substrings) {
		if (lCase(arguments.string) contains lCase(local.i)) {
			return true;
		}
	}
	;
	return false;
}

/**
* Given a number of seconds, I return m:ss
*
* @seconds The number of seconds to be converted
*/
public string function secondsToMinutes(required numeric seconds) {
	// TODO: remaining seconds
	if (arguments.seconds lt 60) {
		return "0:#arguments.seconds#";
	} else {
		local.mins = int(arguments.seconds / 60);
		local.sec = arguments.seconds - (60 * local.mins);
		return "#local.mins#:#local.sec lt 10 ? "0" : ""##local.sec#";
	}
}

/**
* Given a string, I return a boolean indicating whether it contains unmerged merge fields using pattern {foo.bar}
*
* @string The string to be checked
*/
public boolean function containsUnmergedFields(required string string) {
	local.pattern = "[a-z0-9_]+";
	return reMatchNoCase("{#local.pattern#\.#local.pattern#}", arguments.string).Len() gt 0;
}

/**
* Given a string, I return a boolean indicating whether it contains unicode
*
* @string The string to be checked
*/
public boolean function containsUnicode(required string string) {
	return !createObject("java", "java.nio.charset.Charset")
		.forName("ISO-8859-1")
		.newEncoder()
		.canEncode(arguments.string);
}


public string function shortenFilename(required string fileName, numeric maxLength = 32) {
	local.name = arguments.fileName;
	local.limit = arguments.maxLength;
	if (len(local.name) > local.limit) {
		if (find(".", arguments.fileName)) {
			local.ext = listLast(arguments.fileName, ".");
			local.name = left(arguments.fileName, len(arguments.fileName) - len(local.ext) - 1);
			local.limit -= len(local.ext) + 1;
		} else {
			local.ext = "";
		}
		local.su = createObject("java", "org.apache.commons.lang3.StringUtils");
		local.name = local.su.abbreviateMiddle(local.name, "...", local.limit);
		if (len(local.ext)) {
			local.name &= "." & local.ext;
		}
	}
	return local.name;
}

public string function stripAWSKeys(required string string) {
	local.returnValue = arguments.string;
	local.returnValue = replaceNoCase(
		local.returnValue,
		env("AWS_ACCESS_KEY_ID"),
		"[AWS_ACCESS_KEY_ID]",
		"all"
	);
	local.returnValue = replaceNoCase(
		local.returnValue,
		env("AWS_SECRET_ACCESS_KEY"),
		"[AWS_SECRET_ACCESS_KEY]",
		"all"
	);
	return local.returnValue;
}

public numeric function countSubstring(required string str, required string sub) {
	var count = 0;
	var len = len(arguments.sub);
	var pos = find(arguments.sub, arguments.str, 1);
	while (pos) {
		count += 1;
		pos = find(arguments.sub, arguments.str, pos + len);
	}
	return count;
}

public string function arrayToString(
	required array words,
	string concat = " ",
	numeric from = 1,
	numeric to = -1
) {
	if (arguments.to == -1) {
		arguments.to = arrayLen(arguments.words);
	}
	var selectedWords = [];
	for (var i = arguments.from; i <= arguments.to; i++) {
		arrayAppend(selectedWords, arguments.words[i]);
	}
	return arrayToList(selectedWords, arguments.concat);
}

public string function formatOfficeName(required string officeName) {
	if (listFirst(arguments.officeName, " ") == "Belle" && listGetAt(arguments.officeName, 2, " ") == "Property") {
		return replaceNoCase(arguments.officeName, "Belle Property ", "");
	} else {
		return arguments.officeName;
	}
}

/**
* Pass in a set of words to only display its acronym.
*
* @param string	  String to modify. (Required)
* @return Returns a string.
* @author Jordan Clark (JordanClark@Telus.net)
* @version 1, July 18, 2013
*/
public string function acronym(required string string) {
	return trim(
		reReplaceNoCase(
			" " & arguments.string & " ",
			"(\w)\w+\s",
			"\1",
			"all"
		)
	);
}

public string function stripTagChars(required string stringToStrip) {
	return replaceNoCase(
		replaceNoCase(stringToStrip, ">", "", "ALL"),
		"<",
		"",
		"ALL"
	)
}

/**
* Returns the number of times a pattern exists within a string.
* Modified by Raymond Camden
* Rewritten based on original UDF by Cory Aiken (corya@fusedsolutions.com)
*
* @param string	  The string to check.
* @param subString	  The string to look for.
* @return Returns the number of occurrences.
* @author Shawn Seley (shawnse@aol.com)
* @version 3, March 20, 2002
*/
public numeric function findOccurrences(required string string, required string subString) {
	if (!len(arguments.string) || !len(arguments.subString)) {
		return 0;
	}
	// delete all occurences of string
	// and then calculate the number of occurences by comparing string sizes
	return (
		(
			len(arguments.string) - len(
				replaceNoCase(
					arguments.string,
					arguments.subString,
					"",
					"ALL"
				)
			)
		) / len(arguments.subString)
	);
}

/**
* Returns true if a date string is a valid date
*
* [section: Application]
* [category: String Functions]
*
*/
function camelToSpace(str) {
	var rtnStr=lcase(reReplace(arguments.str,"([A-Z])([a-z])","&nbsp;\1\2","ALL"));
	if (arrayLen(arguments) GT 1 AND arguments[2] EQ true) {
		rtnStr=reReplace(arguments.str,"([a-z])([A-Z])","\1&nbsp;\2","ALL");
		rtnStr=uCase(left(rtnStr,1)) & right(rtnStr,len(rtnStr)-1);
	}
	return trim(rtnStr);
}
</cfscript>

<cffunction name="parseContactName" access="public" hint="Returns a firstname and surname given a string">
	<cfargument name="string" type="string" required="true">
	<cfset var loc = {}>
	<cfset loc.str = arguments.string>
	<cfset loc.returnValue = {surname = ""}>
	<cfset loc.returnValue.firstname = listFirst(loc.str, " ")>
	<cfif listLen(loc.str, " ") gt 1>
		<cfset loc.returnValue.surname = listRest(loc.str, " ")>
	</cfif>
	<cfreturn loc.returnValue>
</cffunction>
