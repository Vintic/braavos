<cfscript>
/**
 * Returns the value of a params scope key. If it's not found, will return the specified default.
 *
 * [section: Application]
 * [category: Misc]
 *
 * @key The key in the params scope being checked
 * @default The value to return if the parm does not exist
 * @set Set the param if it doesn't exist. This should be deprecated and set to false
 */
public string function getParam(
	required string key,
	string default = "",
	boolean set = true // TODO: set this to false..
) {
	if (paramExists(arguments.key)) {
		return params[arguments.key];
	}
	if (arguments.set && Len(arguments.default)) {
		params[arguments.key] = arguments.default;
	}
	return params[arguments.key] ?: arguments.default;
}

/**
 * Returns true if a param exists and has a length (Just wraps structKeyIsPresent)
 *
 * [section: Application]
 * [category: Misc]
 *
 */
public boolean function paramIsPresent(required string key) {
	return structKeyIsPresent(params ?: {}, arguments.key);
}

/**
 * Returns true if variable exists in the param scope (Just wraps StructKeyExists)
 *
 * [section: Application]
 * [category: Misc]
 *
 */
public boolean function paramExists(required string key) {
	return structKeyExists(params ?: {}, arguments.key);
}


/**
* Returns param string to pass into pagination links.
*/
public string function buildSearchParams(
	string except = "controller,action,route,page,perpg,reload,password,_method"
) {
	local.rv = "";
	local.vars = listToArray(cgi.QUERY_STRING, "&");
	for (local.i in local.vars) {
		local.key = listFirst(local.i, "=")
		if (!listFindNoCase(arguments.except, local.key)) {
			local.rv = listAppend(local.rv, urlDecode(local.i), "&");
		}
	}
	return local.rv;
}
</cfscript>

<cffunction name="constant" output="false">
	<cfargument name="name" type="string" required="true">
	<cfset var loc = {}/>
	<cfset loc.securityString = "megatron"><!--- this key must match that in subzero --->
	<cfset loc.tomorrow = dateAdd("d", 1, now())>
	<cfset loc.midnight = createDateTime(
		year(loc.tomorrow),
		month(loc.tomorrow),
		day(loc.tomorrow),
		0,
		0,
		0,
		0
	)>
	<cfset loc.unauthorisedAccessMessage = "Sorry, but your role doesn't allow you to do this">
	<cfreturn loc[arguments.name]>
</cffunction>

<cffunction
	name="service"
	returntype="any"
	output="false"
	hint="I am the method used to access any service layer object from within any controller"
>
	<cfargument name="service" type="string" required="true"/>
	<cfset var return = ""/>
	<cfif structKeyExists(application.services, arguments.service)>
		<cfset return = application.services[arguments.service]/>
	</cfif>
	<cfreturn return/>
</cffunction>

<cfscript>
/**
* I surround each array element in brackets and return delimited by an operator
* Used to construct more complex where clauses for findall etc
*
* [section: Application]
* [category: Utils]
*
* @array The array of conditions
* @operator Either AND or OR
*/
public string function whereify(required array array, string operator = "AND") {
	arguments.operator = trim(uCase(arguments.operator));
	local.array = [];
	for (local.i = 1; local.i <= arrayLen(arguments.array); local.i++) {
		local.sql = trim(arguments.array[local.i]);
		local.sql = replace(local.sql, chr(9), " ", "all");
		local.sql = replace(local.sql, chr(10), " ", "all");
		local.sql = replace(local.sql, chr(13), " ", "all");
		local.sql = removeRepeats(local.sql);
		if (local.sql contains " OR ") {
			local.sql = "(#local.sql#)";
		}
		local.array[local.i] = local.sql;
	}
	local.returnValue = arrayToList(local.array, " #arguments.operator# ");
	if (arguments.operator == "OR") {
		return "(#local.returnValue#)";
	}
	return local.returnValue;
}
</cfscript>

<cfscript>
/**
* Returns an array of possible intended search types
*/
public array function guessSearchTypes(required string string) {
	var loc = {};
	loc.str = arguments.string;
	loc.split = listToArray(arguments.string, " ");
	loc.words = loc.split.Len();
	loc.sanitised = replace(loc.str, " ", "", "all");
	loc.returnValue = [];

	// TODO: deal with searches for -1

	// phone beginning with zero
	if (left(loc.sanitised, 1) == "0" && isInteger(replace(loc.sanitised, "0", "", "all"))) {
		loc.returnValue.Append("phone");
	} else if (isInteger(loc.sanitised)) {
		// 2 spaced numbers
		if (loc.words == 2) {
			loc.returnValue.Append("phone");
			loc.returnValue.Append("address");
			// more than 2 spaced numbers
		} else if (loc.words gt 2) {
			loc.returnValue.Append("phone");
			// large number
		} else if (len(loc.sanitised) gt 4 && len(loc.sanitised) lte 9) {
			loc.returnValue.Append("id");
			loc.returnValue.Append("phone");
			// small number
		} else if (len(loc.sanitised) == 4) {
			loc.returnValue.Append("phone");
			loc.returnValue.Append("postcode");
			loc.returnValue.Append("streetnumber");
			loc.returnValue.Append("unitnumber");
			loc.returnValue.Append("lotnumber");
		} else if (len(loc.sanitised) lt 4) {
			loc.returnValue.Append("phone");
			loc.returnValue.Append("streetnumber");
			loc.returnValue.Append("unitnumber");
			loc.returnValue.Append("lotnumber");
		} else if (left(loc.sanitised, 1) == "0") {
			loc.returnValue.Append("phone");
		} else if (len(loc.sanitised) gte 10) {
			loc.returnValue.Append("phone");
		}
		// email
	} else if (loc.str contains "@") {
		loc.returnValue.Append("email");
		// name
	} else if (
		loc.words == 2
		 && reFindNoCase("[0-9]", loc.split[1]) == 0
		 && reFindNoCase("[0-9]", loc.split[2]) == 0
	) {
		loc.returnValue.Append("name");
		loc.returnValue.Append("address");
		// chinese names like: Tat Fai CHAN (with 2 syllables first name)
		// or surnames with 2 syllables (i.e Alfred VON KRUMM)
	} else if (
		loc.words == 3
		 && reFindNoCase("[0-9]", loc.split[1]) == 0
		 && reFindNoCase("[0-9]", loc.split[2]) == 0
		 && reFindNoCase("[0-9]", loc.split[3]) == 0
	) {
		loc.returnValue.Append("name");
		loc.returnValue.Append("address");
		// double ampersand
	} else if (
		loc.words >= 2
		 && countSubstring(loc.str, "&") >= 1
	) {
		loc.returnValue.Append("name");
		loc.returnValue.Append("address");
		// address
	} else if (loc.words gt 2) {
		loc.returnValue.Append("fulladdress");
	} else if (loc.words gt 1 && len(parseStreetAddress(loc.str).streetname)) {
		loc.returnValue.Append("address");
	} else if (loc.words gt 1 && loc.split[1] == "Unit") {
		loc.returnValue.Append("unitnumber");
	} else if (loc.words gt 1 && loc.split[1] == "Lot") {
		loc.returnValue.Append("lotnumber");
	} else if (listLen(loc.split[1], "/") gt 1) {
		loc.returnValue.Append("unitnumber");
		loc.returnValue.Append("lotnumber");
		loc.returnValue.Append("streetnumber");
	} else if (loc.str contains "/") {
		loc.returnValue.Append("address");
		// keyword
	} else if (len(loc.sanitised)) {
		loc.returnValue.Append("keyword");
	}

	return loc.returnValue;
}

/**
* returns an area code given a state
*/
public string function getStateAreaCode(required string state) {
	var loc = {};
	loc.str = arguments.state;
	loc.returnValue = "";
	if (left(loc.str, 3) == "vic" OR left(loc.str, 3) == "tas") {
		loc.returnValue = "03";
	} else if (loc.str == "nsw" OR left(loc.str, 3) == "new") {
		loc.returnValue = "02";
	} else if (loc.str == "act" OR loc.str contains "capital") {
		loc.returnValue = "02";
	} else if (loc.str == "qld" OR left(loc.str, 3) == "que") {
		loc.returnValue = "07";
	} else if (loc.str == "wa" OR left(loc.str, 4) == "west") {
		loc.returnValue = "08";
	} else if (loc.str == "sa" OR left(loc.str, 5) == "south") {
		loc.returnValue = "08";
	} else if (loc.str == "nt" OR left(loc.str, 5) == "north") {
		loc.returnValue = "08";
	}
	return loc.returnValue;
}

public void function newRelicSetRequest() {
	try {
		if (isCI() || isArea51() || isStaging() || isProduction()) {
			application.newRelic.setRequest(transactionName = lCase("#params.controller####params.action#"));
		}
	} catch (any e) {
		// do nothing.. for now.
	}
}

/**
* Creates newrelic customparameter
*/
public boolean function newRelicTickCount(required string parameterName) {
	var loc = {};
	loc.tick = getTickCount();
	if (!request.KeyExists("newRelicTickCounter")) {
		request.newRelicTickCounter = 0;
		request.newRelicPreviousTickCount = loc.tick;
		request.newRelicTickCountOutput = [];
	}
	if (!request.KeyExists("tickCountStart")) {
		request.tickCountStart = getTickCount();
	}
	request.newRelicTickCounter++;
	loc.paddedCounter = request.newRelicTickCounter lt 10 ? "0#request.newRelicTickCounter#" : request.newRelicTickCounter;
	loc.totalTimeToHere = loc.tick - request.tickCountStart;
	loc.timeSincePrevious = loc.tick - request.newRelicPreviousTickCount;
	loc.parameterValue = "@#loc.totalTimeToHere#ms";
	// if (loc.timeSincePrevious gt 0) {
	loc.parameterValue &= " (#loc.timeSincePrevious#ms)";
	// }
	request.newRelicPreviousTickCount = loc.tick;
	request.newRelicTickCountOutput.Append(
		"#loc.paddedCounter#-#arguments.parameterName# = #loc.parameterValue#"
	);

	try {
		application.newRelic.addCustomParameter(
			"#loc.paddedCounter#-#arguments.parameterName#",
			loc.parameterValue
		);
	} catch (any e) {
		return false;
	}
	return true;
}

/**
* Hint: 		Checks for the existence of a portal in the current user's office
* Returns:	boolean
*/
public boolean function hasPortal(required query query, required any portal) {
	var loc = {};
	// i can lookup the portal id or slug
	if (isNumeric(arguments.portal)) {
		loc.column = "portal_id";
	} else {
		loc.column = "portal_slug";
	}
	return arrayFindNoCase(queryColumnData(arguments.query, loc.column), arguments.portal);
}


/**
* Returns true if the wheels test framework is running
*/
public boolean function isUnitTest() {
	return request.isWheelsTestFrameworkRunning ?: false;
}

public boolean function isPortalPush() {
	return request.isPortalPushRunning ?: false;
}

private array function $lowerArrayKeys(required array arr) {
	var rv = [];
	for (var i in arguments.arr) {
		if (isArray(i)) {
			arrayAppend(rv, $lowerArrayKeys(i));
		} else if (isStruct(i)) {
			arrayAppend(rv, $lowerStructKeys(i));
		} else {
			arrayAppend(rv, i);
		}
	}
	return rv;
}

private struct function $lowerStructKeys(required struct st) {
	var rv = {};
	for (var k in arguments.st) {
		if (isArray(arguments.st[k])) {
			rv[lCase(k)] = $lowerArrayKeys(arguments.st[k]);
		} else if (isStruct(arguments.st[k])) {
			rv[lCase(k)] = $lowerStructKeys(arguments.st[k]);
		} else {
			rv[lCase(k)] = arguments.st[k];
		}
	}
	return rv;
}

public any function lowerCaseStructKeys(required any data) {
	if (isArray(arguments.data)) {
		return $lowerArrayKeys(arguments.data);
	} else if (isStruct(arguments.data)) {
		return $lowerStructKeys(arguments.data);
	} else {
		return arguments.data;
	}
}

public array function filterEmailAddressesByDomain(required array addresses, required string domain) {
	var domain = arguments.domain;
	local.returnValue = arguments.addresses.filter(function(i) {
		return getDomainNameFromEmailAddress(arguments.i) == domain;
	});
	return local.returnValue;
}

public string function getInitials(required string str) {
	var s = trim(arguments.str);
	var first = uCase(left(s, 1));
	var second = "";
	if (listLen(s, " ") > 1) {
		second = uCase(left(listGetAt(s, 2, " "), 1));
	}
	return first & second;
}

public string function humanizeSearchOperator(required string str) {
	switch (arguments.str) {
		case "equal":
			return "is";
		case "greater":
			return "is greater than";
		case "less":
			return "is less than";
	}
	return arguments.str;
}

public string function authCodeGenerator(required string code) {
	return left(listGetAt((abs(sin(val(arguments.code)) * pi()) & ".0"), 2, "."), 5);
}

public struct function parseRegionsSuburbs(required string str) {
	var rsp = {region_id = [], suburb_id = []};
	for (var i in arguments.str) {
		var data = listToArray(i, "_");
		if (arrayLen(data) == 2 && reFindNoCase("^(region|suburb)$", data[1]) && isNumeric(data[2])) {
			var k = data[1] & "_id";
			arrayAppend(rsp[k], data[2]);
		}
	}

	return {"region_id" = listUnique(arrayToList(rsp.region_id)), "suburb_id" = listUnique(arrayToList(rsp.suburb_id))};
}

public string function getUnitOfMeasurement(required string string) {
	if (arguments.string == "sqm" || arguments.string contains "metre" || arguments.string contains "meter") {
		return "squareMeter";
	} else if (arguments.string contains "acre") {
		return "acre";
	} else if (arguments.string contains "hectare") {
		return "hectare";
	} else if (arguments.string == "square" || arguments.string == "squares") {
		return "square";
	} else {
		throw(message = "Unknown unit of measurement", type = "UnknownUnitOfMeasurement");
	}
}

public numeric function convertToUnitOfMeasurement(required numeric value, required string from, required string to) {
	var fromUnit = getUnitOfMeasurement(arguments.from);
	var toUnit = getUnitOfMeasurement(arguments.to);
	if (arguments.value == 0) {
		return 0;
	}
	if (fromUnit == toUnit) {
		return arguments.value;
	} else if (fromUnit == "acre" && toUnit == "squareMeter") {
		return arguments.value * 4046.86;
	} else if (fromUnit == "hectare" && toUnit == "squareMeter") {
		return arguments.value * 10000;
	} else if (fromUnit == "square" && toUnit == "squareMeter") {
		return arguments.value * 9.290304;
	} else if (fromUnit == "squareMeter" && toUnit == "acre") {
		return arguments.value / 4046.86;
	} else if (fromUnit == "squareMeter" && toUnit == "hectare") {
		return arguments.value / 10000;
	} else if (fromUnit == "squareMeter" && toUnit == "square") {
		return arguments.value / 9.290304;
	}
	throw message = "Unknown unit of measurement";
}

public numeric function convertToSquareMetres(required numeric value, required string unit) {
	return convertToUnitOfMeasurement(arguments.value, arguments.unit, "squareMeter");
}

public array function sortArrayOfStructs(
	required array arr,
	required string key,
	string type = "textnocase",
	string order = "asc"
) {
	var d = "."
	var a = [];
	var c = arrayLen(arguments.arr);
	for (var i = 1; i <= c; i++) {
		a.Append(arguments.arr[i][arguments.key] & d & i);
	}
	arraySort(a, arguments.type, arguments.order);
	var rv = [];
	for (var i = 1; i <= c; i++) {
		rv[i] = arguments.arr[listLast(a[i], d)];
	}
	return rv;
}

public string function getProjectChildName(required string projectType) {
	if (arguments.projectType == "Apartment Development") {
		local.unitName = "Apartment";
	} else if (arguments.projectType == "Land Estate") {
		local.unitName = "Land Lot";
	} else if (arguments.projectType == "Townhouse Development") {
		local.unitName = "Unit";
	} else {
		local.unitName = "Lot";
	}
	return local.unitName;
}

// returns 5.00 when given a string like "5.00% pa"
public string function getNumberFromPercentageString(required string string) {
	local.returnValue = trim(listFirst(arguments.string, "%"));
	if (!isNumeric(local.returnValue)) {
		return "";
	}
	return local.returnValue;
}

public struct function getWebFonts() {
	local.returnValue = structNew("linked");
	local.returnValue["arial"] = "Arial, Helvetica, sans-serif";
	local.returnValue["times_new_roman"] = "'Times New Roman', Times, serif;";
	local.returnValue["courier_new"] = "'Courier New', Courier, monospace";
	local.returnValue["georgia"] = "Georgia, serif";
	local.returnValue["palatino_linotype"] = "'Palatino Linotype', 'Book Antiqua', Palatino, serif";
	local.returnValue["arial_black"] = "'Arial Black', Gadget, sans-serif";
	local.returnValue["impact"] = "Impact, Charcoal, sans-serif";
	local.returnValue["lucida_sans_unicode"] = "'Lucida Sans Unicode', 'Lucida Grande', sans-serif";
	local.returnValue["tahoma"] = "Tahoma, Geneva, sans-serif";
	local.returnValue["trebuchet_ms"] = "'Trebuchet MS', Helvetica, sans-serif";
	local.returnValue["verdana"] = "Verdana, Geneva, sans-serif";
	local.returnValue["lucida"] = "'Lucida Console', Monaco, monospace";
	return local.returnValue;
}

/**
* If one of the 2 value are present, then both must be present
*/
public boolean function isBothOrNeitherPresent(required string value1, required string value2) {
	if (len(arguments.value1) gt 0 && len(arguments.value2) == 0) {
		return false;
	} else if (len(arguments.value2) gt 0 && len(arguments.value1) == 0) {
		return false;
	}
	return true;
}

public any function formatAjaxResponse(
	required boolean success,
	array messages = [],
	any data = {},
	string returnAs = "json"
) {
	// check that messages are an array of arrays
	// WHY is messages an array of arrays?? -- appears to obfuscate the ease-of-access to this object, is this useful somehow?? Refactor TBD
	if (arrayLen(arguments.messages) gt 0 && !isArray(arguments.messages[1])) {
		throw(type = "MessageDataType", message = "Messages must be an array of arrays");
	}

	local.returnValue = lowerCaseStructKeys({success = isTrue(arguments.success) ? true : false, messages = arguments.messages, data = arguments.data});

	if (arguments.returnAs == "struct") {
		return local.returnValue;
	}
	return serializeJSON(local.returnValue);
}

/**
 * Creates an input for prices OR returns an array of prices
 *
 * [section: Application]
 * [category: Misc]
 *
 */
public any function priceSelect(
	string saleMethod="sale",
	string returnMode="input",
	string category="residential",
	numeric price="0"
) {
	local.salePrices = [];
	//  increment by 25,000
	loop from="50000" to="500000" step="25000" index="local.idx" {
		local.salePrices.append({value=local.idx,text="$#NumberFormat(local.idx)#"});
	}
	//  increment by 50,000
	loop from="550000" to="1000000" step="50000" index="local.idx" {
		local.salePrices.append({value=local.idx,text="$#NumberFormat(local.idx)#"});
	}
	//  increment by 100,000
	loop from="1100000" to="2000000" step="100000" index="local.idx" {
		local.salePrices.append({value=local.idx,text="$#NumberFormat(local.idx)#"});
	}
	//  increment by 250,000
	loop from="2250000" to="3000000" step="250000" index="local.idx" {
		local.salePrices.append({value=local.idx,text="$#NumberFormat(local.idx)#"});
	}
	//  increment by 500,000
	loop from="3500000" to="5000000" step="500000" index="local.idx" {
		local.salePrices.append({value=local.idx,text="$#NumberFormat(local.idx)#"});
	}
	//  increment by 1,000,000
	loop from="6000000" to="10000000" step="1000000" index="local.idx" {
		local.salePrices.append({value=local.idx,text="$#NumberFormat(local.idx)#"});
	}
	local.salePrices.append({value=12000000,text="$#NumberFormat(12000000)#"});
	local.salePrices.append({value=15000000,text="$#NumberFormat(15000000)#"});
	if ( arguments.category == "commercial" ) {
		//  increment by 20,000,000
		loop from="20000000" to="100000000" step="20000000" index="local.idx" {
			local.salePrices.append({value=local.idx,text="$#NumberFormat(local.idx)#"});
		}
	}
	local.resLeasePrices = [];
	if ( arguments.category == "commercial" ) {
		//  commercial lease price is per annum
		//  increment by 5,000
		loop from="5000" to="50000" step="5000" index="local.idx" {
			local.resLeasePrices.append({value=local.idx,text="$#NumberFormat(local.idx)#"});
		}
		//  increment by 10,000
		loop from="50000" to="100000" step="10000" index="local.idx" {
			local.resLeasePrices.append({value=local.idx,text="$#NumberFormat(local.idx)#"});
		}
		//  increment by 50,000
		loop from="150000" to="250000" step="50000" index="local.idx" {
			local.resLeasePrices.append({value=local.idx,text="$#NumberFormat(local.idx)#"});
		}
		//  increment by 500,000
		loop from="500000" to="1000000" step="500000" index="local.idx" {
			local.resLeasePrices.append({value=local.idx,text="$#NumberFormat(local.idx)#"});
		}
		local.resLeasePrices.append({value="2000000",text="$2,000,000"});
	} else {
		loop from="1" to="60" index="local.i" {
			local.val = local.i * 50;
			local.resLeasePrices.Append({text="$#NumberFormat(local.val)#", value=local.val});
		}
	}
	if ( arguments.saleMethod == "Lease" ) {
		local.options = local.resLeasePrices;
	} else {
		local.options = local.salePrices;
	}

	StructDelete(arguments, "saleMethod");
	//  if a price has been passed in, append it
	//  TODO: only append if it's not in the array already
	//  TODO: re-order the array.. tricky!
	if ( Val(arguments.price) > 0 ) {
		local.options.Append({text="$#NumberFormat(arguments.price)#", value=arguments.price});
	}
	if ( arguments.returnMode == "input" ) {
		//  return form input type
		return input(argumentCollection=arguments, options=local.options);
	} else {
		if ( Val(arguments.price) ) {
			returnValue = 0;
			//  if price is passed in, check where it fits
			for ( local.arrayPrice in local.options ) {
				if ( local.arrayPrice.value >= arguments.price ) {
					returnValue = local.arrayPrice.value;
					break;
				}
			}
			if ( ! Val(returnValue) ) {
				returnValue = local.options[ArrayLen(local.options)].value;
			}
			return returnValue;
		} else {
			//  return the array
			return local.options;
		}
	}
}

</cfscript>
