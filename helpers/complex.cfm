<cffunction
	name="arrayOfStructFindKeyValue"
	access="public"
	output="No"
	returntype="numeric"
	hint="I return the position of the matching key/value pair found in an array of structures"
>
	<cfargument name="array" required="Yes" type="array"/>
	<cfargument name="key" required="Yes" type="string"/>
	<cfargument name="value" required="Yes" type="string"/>
	<cfset var loc = {}/>
	<cfset loc.return = 0/>
	<cfloop from="1" to="#arrayLen(arguments.array)#" index="loc.i">
		<cfif structKeyExists(arguments.array[loc.i], arguments.key) AND compareNoCase(
			arguments.array[loc.i][arguments.key],
			arguments.value
		) eq 0>
			<cfset loc.return = loc.i/>
			<cfbreak/>
		</cfif>
	</cfloop>
	<cfreturn loc.return/>
</cffunction>

<cffunction
	name="arrayOfStructFindByKeyName"
	access="public"
	output="No"
	returntype="struct"
	hint="I return the first value of the matching key name found in an array of structures"
>
	<cfargument name="array" required="Yes" type="array"/>
	<cfargument name="key" required="Yes" type="string"/>
	<cfargument name="value" required="Yes" type="string"/>
	<cfset var keyName = arguments.key>
	<cfset var keyValue = arguments.value>

	<cfset local.returnValue = arguments.array.filter(function(i) {
		return (arguments.i[keyName] ?: "") == keyValue;
	})>
	<cfif isEmpty(local.returnValue)>
		<cfreturn {}>
	</cfif>

	<cfreturn local.returnValue[1]/>
</cffunction>

<cffunction name="mergeObjectProperties" output="false">
	<!--- any number of objects can be passed in as arguments --->
	<cfset var loc = {}>
	<cfset loc.args = arguments>
	<cfset loc.ret = {}>
	<cfset loc.reversed = arrayReverse(loc.args)>

	<!--- look backwards through array of objects to keep overwriting consistent --->
	<cfloop array="#loc.reversed#" index="loc.i">
		<cfloop collection="#loc.i.properties()#" index="loc.k">
			<cfif isSimpleValue(loc.i[loc.k])>
				<cfset loc.ret[loc.k] = loc.i[loc.k]>
			</cfif>
		</cfloop>
	</cfloop>

	<cfreturn loc.ret>
</cffunction>

<cffunction name="structToQueryString" access="public" output="No" returntype="string">
	<cfargument name="struct" type="struct" required="true">
	<cfargument name="ignoreEmpty" type="boolean" required="false" default="false"><!--- ignore vars with empty values (makes for shorter query strings) --->
	<cfargument name="convertToLcase" type="boolean" required="false" default="true">
	<!---
		/*
		* Convert struct to a query string for use in url
		*
		* @param struct                          The structure to convert.
		* @param exclude                         The list of variables to exclude.
		* @return Returns a string.
		* @author Adam Chapman (adam.p.chapman@gmail.com)
		* @version 1, 13 May 2011
		*/
	--->
	<cfset var loc = {}>
	<cfset loc.struct = duplicate(arguments.struct)>
	<cfset loc.return = "">
	<!--- loop over appended struct and build string --->
	<cfloop list="#structKeyList(loc.struct)#" index="loc.i">
		<cfif arguments.ignoreEmpty AND len(loc.struct[loc.i]) eq 0>
			<cfelseif isSimpleValue(struct[loc.i])>
			<cfif arguments.convertToLcase>
				<cfset loc.return = listAppend(loc.return, "#lCase(loc.i)#=#loc.struct[loc.i]#", "&")>
            <cfelse>
				<cfset loc.return = listAppend(loc.return, "#loc.i#=#loc.struct[loc.i]#", "&")>
			</cfif>
		</cfif>
	</cfloop>
	<cfreturn loc.return>
</cffunction>

<cffunction name="structValueList" access="public" output="No" returntype="string">
	<cfargument name="struct" required="true" type="struct">
	<cfargument name="delimiter" required="false" type="string" default=",">
	<cfset var loc = {}>
	<cfset loc.returnValue = "">
	<cfloop list="#structKeyList(arguments.struct)#" index="loc.i">
		<cfset loc.val = arguments.struct[loc.i]>
		<cfif isSimpleValue(loc.val)>
			<cfset loc.returnValue = listAppend(loc.returnValue, loc.val, arguments.delimiter)>
		</cfif>
	</cfloop>
	<cfreturn loc.returnValue>
</cffunction>

<cfscript>
/**
* Builds and returns a query string from the params scope.
*
* [section: Application]
* [category: Complex Functions]
*
* @exclude A list of params to exclude from the query string.
* @insert A struct of key/pair values to add to the query string.
* @pages Include or exclude the pagination params.
* @ignoreEmpty Excludes empty valued params from the query string.
*/
public string function paramsToQueryString(
	string exclude = "",
	struct insert = {},
	boolean pages = false,
	boolean ignoreEmpty = true,
	struct params = params
) {
	local.params = duplicate(arguments.params);
	local.exclude = listToArray(
		listAppend(
			arguments.exclude,
			"controller,action,route,httpRequestDataContent,authenticityToken,_method,authorization"
		)
	);
	if (!arguments.pages) {
		arrayAppend(local.exclude, "pg");
		arrayAppend(local.exclude, "perpg");
	}
	for (local.i in local.exclude) {
		structDelete(local.params, local.i)
	}
	for (local.i in structKeyArray(arguments.insert)) {
		local.params[local.i] = arguments.insert[local.i];
	}
	return structToQueryString(struct = local.params, ignoreEmpty = arguments.ignoreEmpty);
}

/*** Returns a struct with all all 'core' params removed. Accepts an additional list of structure keys*/
// TODO: see DRY with paramsToQueryString
public struct function rawParams(required struct struct, string keys = "") {
	var loc = {};
	loc.keys = listToArray(
		listAppend(
			"controller,action,route,httpRequestDataContent,authenticityToken,_method,authorization,pg,perpg",
			arguments.keys
		)
	);
	loc.return = duplicate(arguments.struct);
	for (loc.key in loc.keys) {
		structDelete(loc.return, loc.key);
	}
	return loc.return;
}

/**
* Hint: Returns values of one array1 not found in array2
*/
public array function arrayItemsNotFound(required array array1, required array array2) {
	var loc = {};
	loc.return = [];
	for (loc.i in arguments.array1) {
		if (!arrayFindNoCase(arguments.array2, loc.i)) {
			loc.return.Append(loc.i)
		}
	}
	return loc.return;
}

public array function arraysOfLength(required array array, required numeric length, string padding) {
	var loc = {};
	loc.returnValue = [];

	loc.sourceArray = arguments.array;
	loc.sourceLength = arrayLen(arguments.array);
	loc.subArrayLength = arguments.length;
	loc.subArrayCount = ceiling(loc.sourceLength / loc.subArrayLength);
	loc.totalLength = loc.subArrayCount * loc.subArrayLength;
	loc.diff = loc.totalLength - loc.sourceLength;

	if (arrayIsEmpty(loc.sourceArray)) {
		// return an empty array if passed one
		return loc.sourceArray;
	} else if (loc.sourceLength lte loc.subArrayLength) {
		// if the source array doesnt need splitting, return it
		// TODO: should I apply padding?
		loc.returnValue.Append(arguments.array);
		return loc.returnValue;
	}

	// pad the array if asked
	if (arguments.KeyExists("padding") && loc.diff gt 0) {
		loop from="1" to="#loc.diff#" index="loc.i" {
			loc.sourceArray.Append(arguments.padding);
		}
	}

	// split the array into sub arrays
	loc.start = 1;
	loc.count = loc.subArrayLength;
	loc.end = loc.start + loc.count - 1;

	loop from="1" to="#loc.subArrayCount#" index="loc.i" {
		loc.returnValue.Append(arraySlice(loc.sourceArray, loc.start, loc.count));
		loc.start = loc.end + 1;
		loc.end = loc.start + loc.count - 1;
		// make sure the end is not longer than the actual array length
		if (loc.end gt arrayLen(loc.sourceArray)) {
			loc.count = arrayLen(loc.sourceArray) - loc.start + 1;
		}
	}
	return loc.returnValue;
}

/**
* Deletes a list of keys from a structure
*/
public struct function structDeleteKeys(required struct struct, required string list) {
	var loc = {};
	loc.struct = duplicate(arguments.struct);
	for (loc.key in arguments.list) {
		structDelete(loc.struct, loc.key);
	}
	;
	return loc.struct;
}

public array function arrayOfStructsSort(required array array, required string key) {
	// by default we'll use an ascending sort
	var sortOrder = "asc";
	// by default, we'll use a textnocase sort
	var sortType = "textnocase";
	// by default, use ascii character 30 as the delim
	var delim = ".";
	// make an array to hold the sort stuff
	var sortArray = arrayNew(1);
	// make an array to return
	var returnArray = arrayNew(1);
	// grab the number of elements in the array (used in the loops)
	var count = arrayLen(array);
	// make a variable to use in the loop
	var ii = 1;
	// if there is a 3rd argument, set the sortOrder
	if (arrayLen(arguments) GT 2) sortOrder = arguments[3];
	// if there is a 4th argument, set the sortType
	if (arrayLen(arguments) GT 3) sortType = arguments[4];
	// if there is a 5th argument, set the delim
	if (arrayLen(arguments) GT 4) delim = arguments[5];
	// loop over the array of structs, building the sortArray
	for (ii = 1; ii lte count; ii = ii + 1) sortArray[ii] = array[ii][key] & delim & ii;
	// now sort the array
	arraySort(sortArray, sortType, sortOrder);
	// now build the return array
	for (ii = 1; ii lte count; ii = ii + 1) returnArray[ii] = array[listLast(sortArray[ii], delim)];
	// return the array
	return returnArray;
}

/** Returns true if a struct key exists and it's value has a length*/
public boolean function structKeyIsPresent(required struct structure, required string key) {
	return structKeyExists(arguments.structure, arguments.key) && len(arguments.structure[arguments.key]);
}

public array function queryToArrayOfStructs(required query query) {
	local.returnValue = [];
	for (local.row in arguments.query) {
		local.returnValue.Append(local.row);
	}
	return local.returnValue;
}
</cfscript>
