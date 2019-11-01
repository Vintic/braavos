<cffunction name="sanitiseList" access="public" hint="Returns a clean list">
	<cfargument name="list" type="string" required="true">
	<cfargument name="delimiter" type="string" required="false" default=",">
	<cfset var loc = {}>
	<cfset loc.return = ""/>
	<cfloop list="#arguments.list#" delimiters="#arguments.delimiter#" item="loc.i">
		<cfif trim(loc.i).Len()>
			<cfset loc.return = listAppend(loc.return, trim(loc.i), arguments.delimiter)/>
		</cfif>
	</cfloop>
	<cfreturn loc.return>
</cffunction>

<cffunction name="listFindOccurrences" access="public" returntype="numeric" output="false">
	<cfargument name="list" type="string" required="true">
	<cfargument name="string" type="string" required="true">
	<cfargument name="delimiter" type="string" required="false" default=",">
	<cfset var loc = {}>
	<cfset loc.delimiter = arguments.delimiter>
	<cfset loc.rv = 0>
	<cfloop list="#arguments.list#" index="loc.i">
		<cfif loc.i == arguments.string>
			<cfset loc.rv++/>
		</cfif>
	</cfloop>
	<cfreturn loc.rv>
</cffunction>

<cfscript>
/**
* Removes duplicate list entries
*
* @list string (Required)
* @return Returns a string.
* @author Adam Chapman (adampchapman@gmail.com)
* @version 1, May 7, 2015
*/
public function listUnique(required string list) {
	var loc = {};
	loc.rv = "";
	loc.array = listToArray(arguments.list).map(function(i) {
		return trim(arguments.i);
	});
	for (loc.i in loc.array) {
		loc.i = trim(loc.i);
		if (loc.i.Len() && !listFindNoCase(loc.rv, loc.i)) {
			loc.rv = listAppend(loc.rv, loc.i);
		}
	}
	return loc.rv;
}

/**
* removes non-numeric items from a list
*/
function listNumeric(required string list, string delimiter = ",") {
	var loc = {};
	loc.array = listToArray(arguments.list, arguments.delimiter);
	loc.rv = "";
	for (loc.i in loc.array) {
		if (isNumeric(loc.i)) {
			loc.rv = listAppend(loc.rv, loc.i, arguments.delimiter)
		}
	}
	return loc.rv;
}

/**
* removes an element from a list by value
*/
function listDeleteValue(required string list, required string value, string delimiter = ",") {
	var loc = {};
	loc.rv = arguments.list;
	loc.position = listFindNoCase(loc.rv, arguments.value, arguments.delimiter);
	if (loc.position) {
		loc.rv = listDeleteAt(loc.rv, loc.position, arguments.delimiter);
	}
	return loc.rv;
}

/**
* Returns true if all elements in list2 are found in list1
*/
public boolean function listFindAll(required string list1, required string list2) {
	var loc = {}
	loc.array1 = listToArray(arguments.list1);
	loc.array2 = listToArray(arguments.list2); // find these in list1
	loc.rv = false;
	for (loc.i in loc.array2) {
		if (arrayFindNoCase(loc.array1, loc.i)) {
			loc.rv = true;
		} else {
			loc.rv = false;
			break;
		}
	}
	return loc.rv;
}

/**
* Returns a list of items from list2 that exist in list1 (common delimiter used in all operations)
*/
public function listInCommon(required string list1, required string list2, string delimiter = ",") {
	var loc = {}
	loc.rv = [];
	loc.delim = arguments.delimiter;
	loc.array1 = listToArray(arguments.list1, loc.delim);
	loc.array2 = listToArray(arguments.list2, loc.delim); // find these in list1
	for (loc.i in loc.array2) {
		if (arrayFindNoCase(loc.array1, loc.i)) {
			loc.rv.Append(loc.i);
		}
	}
	return arrayToList(loc.rv, loc.delim);
}

/**
* Returns a list of items from list2 that DO NOT exist in list1 (common delimiter used in all operations)
*/
public function listNotInCommon(required string list1, required string list2, string delimiter = ",") {
	var loc = {}
	loc.rv = [];
	loc.delim = arguments.delimiter;
	loc.array1 = listToArray(arguments.list1, loc.delim);
	loc.array2 = listToArray(arguments.list2, loc.delim); // find these in list1
	for (loc.i in loc.array2) {
		if (!arrayFindNoCase(loc.array1, loc.i)) {
			loc.rv.Append(loc.i);
		}
	}
	return arrayToList(loc.rv, loc.delim);
}

/**
* Returns the sum of numeric list elements
*/
public numeric function listSum(required string list, string delimiter = ",") {
	var loc = {};
	loc.array = listToArray(arguments.list, arguments.delimiter & " ");
	loc.list = listNumeric(arrayToList(loc.array));
	return arraySum(listToArray(loc.list));
	;
}

/**
* removes the last list element
*/
public string function listDeleteLast(required string list, string delimiter = ",") {
	var loc = {};
	loc.length = listLen(arguments.list, arguments.delimiter);
	if (loc.length) {
		return listDeleteAt(arguments.list, loc.length, arguments.delimiter);
	}
	return arguments.list;
}

/**
* Returns a human readable list. Eg: "Red, white &amp; blue"
*/
public string function listHumanise(required string list, string andValue = "&amp;") {
	if (!len(arguments.list)) {
		return "";
	} else if (listLen(arguments.list) == 1) {
		return arguments.list;
	}
	local.allButLastElements = listDeleteLast(arguments.list);
	local.lastElement = listLast(arguments.list);
	local.humanisedList = "";
	for (local.i in local.allButLastElements) {
		local.humanisedList = listAppend(local.humanisedList, local.i);
	}
	local.humanisedList &= " #arguments.andValue# #local.lastElement#";
	local.humanisedList = listChangeDelims(local.humanisedList, ", ");
	return local.humanisedList;
}

// just a nicely named wrapper for !ListFindNoCase
public boolean function isNotFoundInList(required string list, required string value, string delimiters = ",") {
	return listFindNoCase(arguments.list, arguments.value, arguments.delimiters) == 0;
}

// ensures a non-empty list is returned
public string function listEnsure(required string list, string default = "-1") {
	if (len(arguments.list)) {
		return arguments.list;
	}
	return arguments.default;
}

public string function uniqueNumericList(required string list, string default = "") {
	return listEnsure(listNumeric(listUnique(arguments.list)), arguments.default);
}

// a list version of ArraySlice
public string function listSlice(required string list, required numeric offset, required numeric length) {
	local.array = listToArray(arguments.list);
	// lazy...
	try {
		local.slicedArray = arraySlice(local.array, arguments.offset, arguments.length);
		return arrayToList(local.slicedArray);
	} catch (any e) {
		return arguments.list;
	}
}

public array function listToArrayWithTrim(required string str) {
	var a = [];
	for (var i in arguments.str) {
		a.Append(trim(i));
	}
	return a;
}
</cfscript>
