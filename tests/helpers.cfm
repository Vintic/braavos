<cfscript>
public void function assertEqual(required any actual, required any expected) {
	if (isDevelopment() && !equalize(actual, expected)) {
		debug("actual", true);
		debug("expected", true);
	}
	assert("equalize(actual, expected)", "actual", "expected");
}

/**
* Mocks a Contact session so that isAuthenticated() will return true
*
* [section: Application]
* [category: Testing]
*
* @key The key of the Contact to mock
* @kill If true, the session will be treated as not existing and isAuthenticated() will be returned as false
*/
public object function mockCurrentContact(required numeric key = 1, boolean kill = false) {
	// TODO: this will need to match the getSession object
	local.returnValue = model("Contact").findByKey(key = arguments.key, reload = true);
	request.currentUser = local.returnValue; // notify getCurrentUser function that I have mocked a session
	structDelete(request, "killCurrentUser");
	if (arguments.kill) {
		request.killCurrentUser = true;
	}
	return local.returnValue;
}

/**
* Mocks an Agent session so that isAgentAuthenticated() will return true
*
* [section: Application]
* [category: Testing]
*
* @key The key of the Agent to mock
* @kill If true, the session will be treated as not existing and isAgentAuthenticated() will be returned as false
*/
public object function mockCurrentAgent(required numeric key = 1, boolean kill = false) {
	// TODO: this will need to match the getSession object
	local.returnValue = model("Agent").findByKey(key = arguments.key, reload = true);
	request.currentAgent = local.returnValue; // notify getCurrentUser function that I have mocked a session
	structDelete(request, "killCurrentAgent");
	if (arguments.kill) {
		request.killCurrentAgent = true;
	}
	return local.returnValue;
}

/**
* Mocks an administrator session so that isAdministratorAuthenticated() will return true
*
* [section: Application]
* [category: Testing]
*
* @key The key of the administrator to mock
* @kill If true, the session will be treated as not existing and isAdministratorAuthenticated() will be returned as false
*/
public object function mockCurrentAdministrator(required numeric key = 1, boolean kill = false) {
	// TODO: this will need to match the getAdministratorSession object
	local.returnValue = model("Administrator").findByKey(key = arguments.key, reload = true);
	request.currentAdministrator = local.returnValue; // notify getCurrentUser function that I have mocked a session
	structDelete(request, "killCurrentAdministrator");
	if (arguments.kill) {
		request.killCurrentAdministrator = true;
	}
	return local.returnValue;
}

function sanitiseString(required string string) {
	var loc = {};
	loc.rv = stripCRLF(arguments.string);
	while (find("  ", loc.rv) gt 0) {
		loc.rv = replace(loc.rv, "  ", " ", "all")
	}
	loc.rv = replace(loc.rv, " <", "<", "all");
	loc.rv = replace(loc.rv, chr(9), "", "all");
	return trim(loc.rv);
}

function sanitiseSqlString(required string string) {
	var loc = {};
	loc.rv = reReplace(arguments.string, "\t", " ", "ALL")
	loc.rv = removeRepeats(stripCRLF(stripNonKeyboardCharacters(loc.rv)));
	return trim(loc.rv);
}

function debugStrings() {
	local.diffs = stringSimilarity(actual, expected, 10);
	echo("<h4>Actual</h4>");
	echo(local.diffs.s1);
	echo("<hr>");
	echo("<h4>Expected</h4>");
	echo(local.diffs.s2);
	abort;
}

function debugXml() {
	if (isStruct(actual ?: "")) {
		actual = toString(actual);
	}
	if (isStruct(expected ?: "")) {
		expected = toString(expected);
	}
	fileWrite(expandPath("temp/actual.xml"), actual);
	fileWrite(expandPath("temp/expected.xml"), expected);

	debugStrings();
}

/*
  StringSimilarity
  Brad Wood
  brad@bradwood.com
  May 2007
  http://www.codersrevolution.com/blog/ColdFusion-Levenshtein-Distance-String-comparison-and-highlighting
  Code adopted from Siderite Zackwehdex's Blog
  http://siderite.blogspot.com/2007/04/super-fast-and-accurate-string-distance.html
  Parameters:
  s1:			First string to be compared
  s2:			Second string to be compared
  maxOffset:	Average number of characters that s1 will deviate from s2 at any given point.
  This is used to control how far ahead the function looks to try and find the
  end of a piece of inserted text.  Play with it to suit.
  2016-50-20 James Moberg SunStarMedia.com
  - Added VAR scope to 15 variables. (Increased performance from 15-32 to 0-15ms.)
  - Added generateHTML flag (optional). If disabled, will return empty s1 & s2 strings.
*/
function stringSimilarity(s1, s2, maxOffset) {
	var c = 0;
	var offset1 = 0;
	var offset2 = 0;
	var lcs = 0;
	var _s1 = "";
	var _s2 = "";
	var h1 = "";
	var h2 = "";
	// default response = empty strings
	var return_struct = {
		lcs = 0,
		similarity = 1,
		distance = len(trim(s1)),
		s1 = "",
		s2 = ""
	};
	/* 15 params VARed */
	var next_s1 = 0;
	var next_s2 = 0;
	var old_offset1 = 0;
	var old_offset2 = 0;
	var _s1_deviation = 0;
	var _s2_deviation = 0;
	var len_next_s1 = 0;
	var len_next_s2 = 0;
	var bookmarked_s1 = 0;
	var bookmarked_s2 = 0;
	var added_offset1 = 0;
	var added_offset2 = 0;
	var distance = 0;
	var similarity = 0;
	// Add option to toggle HTML generation. If disabled, will return empty s1 & s2 strings.
	var generateHTML = 1;
	if (arrayLen(arguments) gte 4 AND isValid("boolean", arguments[4])) {
		generateHTML = yesNoFormat(arguments[4]);
	}
	if (generateHTML) {
		// These two strings will contain the "highlighted" version
		_s1 = createObject("java", "java.lang.StringBuffer").init(javacast("int", len(s1) * 3));
		_s2 = createObject("java", "java.lang.StringBuffer").init(javacast("int", len(s2) * 3));
		// These characters will surround differences in the strings
		// (Inserted into _s1 and _s2)
		h1 = "<span style=""background:yellow;"">";
		h2 = "</span>";
	}
	// If both strings are empty
	if (not len(trim(s1)) and not len(trim(s2))) {
		return return_struct;
	}
	// If s2 is empty, but s1 isn't
	else if (len(trim(s1)) and not len(trim(s2))) {
		return_struct.similarity = 0;
		return_struct.distance = len(s1);
		return_struct.s1 = h1 & s1 & h2;
		return return_struct;
	}
	// If s1 is empty, but s2 isn't
	else if (len(trim(s2)) and not len(trim(s1))) {
		return_struct.similarity = 0;
		return_struct.distance = len(s2);
		return_struct.s2 = h1 & s2 & h2;
		return return_struct;
	}
	// Examine the strings, one character at a time, anding at the shortest string
	// The offset adjusts for extra characters in either string.
	while ((c + offset1 lt len(s1)) and (c + offset2 lt len(s2))) {
		// Pull the next charactes out of s1 anbd s2
		next_s1 = mid(s1, c + offset1 + 1, iIf(not c, 3, 1)); // First time through check the first three
		next_s2 = mid(s2, c + offset2 + 1, iIf(not c, 3, 1)); // First time through check the first three
		// If they are equal
		if (compare(next_s1, next_s2) eq 0) {
			// Our longeset Common String just got one bigger
			lcs = lcs + 1;
			// Append the characters onto the "highlighted" version
			if (generateHTML) {
				_s1.append(left(next_s1, 1));
				_s2.append(left(next_s2, 1));
			}
		}
		// The next two charactes did not match
		// Now we will go into a sub-loop while we attempt to
		// find our place again.  We will only search as long as
		// our maxOffset allows us to.
		else {
			// Don't reset the offsets, just back them up so you
			// have a point of reference
			old_offset1 = offset1;
			old_offset2 = offset2;
			_s1_deviation = "";
			_s2_deviation = "";
			// Loop for as long as allowed by our offset
			// to see if we can match up again
			for (i = 0; i lt maxOffset; i = i + 1) {
				next_s1 = mid(s1, c + offset1 + i + 1, 3); // Increments each time through.
				len_next_s1 = len(next_s1);
				bookmarked_s1 = mid(s1, c + offset1 + 1, 3); // stays the same
				next_s2 = mid(s2, c + offset2 + i + 1, 3); // Increments each time through.
				len_next_s2 = len(next_s2);
				bookmarked_s2 = mid(s2, c + offset2 + 1, 3); // stays the same
				// If we reached the end of both of the strings
				if (not len_next_s1 and not len_next_s2) {
					// Quit
					break;
				}
				// These variables keep track of how far we have deviated in the
				// string while trying to find our match again.
				_s1_deviation = _s1_deviation & left(next_s1, 1);
				_s2_deviation = _s2_deviation & left(next_s2, 1);
				// It looks like s1 has a match down the line which fits
				// where we left off in s2
				if (compare(next_s1, bookmarked_s2) eq 0) {
					// s1 is now offset THIS far from s2
					offset1 = offset1 + i;
					// Our longeset Common String just got bigger
					lcs = lcs + 1;
					// Now that we match again, break to the main loop
					break;
				}
				// It looks like s2 has a match down the line which fits
				// where we left off in s1
				if (compare(next_s2, bookmarked_s1) eq 0) {
					// s2 is now offset THIS far from s1
					offset2 = offset2 + i;
					// Our longeset Common String just got bigger
					lcs = lcs + 1;
					// Now that we match again, break to the main loop
					break;
				}
			}
			// This is the number of inserted characters were found
			added_offset1 = offset1 - old_offset1;
			added_offset2 = offset2 - old_offset2;
			// We reached our maxoffset and couldn't match up the strings
			if (generateHTML) {
				if (added_offset1 eq 0 and added_offset2 eq 0) {
					_s1.append(h1 & left(_s1_deviation, added_offset1 + 1) & h2);
					_s2.append(h1 & left(_s2_deviation, added_offset2 + 1) & h2);
				}
				// s2 had extra characters
				else if (added_offset1 eq 0 and added_offset2 gt 0) {
					_s1.append(left(_s1_deviation, 1));
					_s2.append(h1 & left(_s2_deviation, added_offset2) & h2 & right(_s2_deviation, 1));
				}
				// s1 had extra characters
				else if (added_offset1 gt 0 and added_offset2 eq 0) {
					_s1.append(h1 & left(_s1_deviation, added_offset1) & h2 & right(_s1_deviation, 1));
					_s2.append(left(_s2_deviation, 1));
				}
			}
		}
		c = c + 1;
	}
	// Anything left at the end of s1 is extra
	if (generateHTML) {
		if (c + offset1 lt len(s1)) {
			_s1.append(h1 & right(s1, len(s1) - (c + offset1)) & h2);
		}
		// Anything left at the end of s2 is extra
		if (c + offset2 lt len(s2)) {
			_s2.append(h1 & right(s2, len(s2) - (c + offset2)) & h2);
		}
	}
	// Distance is the average string length minus the longest common string
	distance = (len(s1) + len(s2)) / 2 - lcs;
	// Whcih string was longest?
	maxLen = iIf(len(s1) gt len(s2), de(len(s1)), de(len(s2)));
	// Similarity is the distance divided by the max length
	similarity = iIf(maxLen eq 0, 1, 1 - (distance / maxLen));
	// Return what we found.
	return_struct.lcs = lcs;
	return_struct.similarity = similarity;
	return_struct.distance = distance;
	return_struct.s1 = _s1.toString(); // "highlighted" version
	return_struct.s2 = _s2.toString(); // "highlighted" version
	return return_struct;
}

function compressHTMLForAssert(required string string, boolean removeSpaces = true) {
	local.returnValue = arguments.string;
	local.returnValue = htmlCompressFormat(string = local.returnValue, level = 3);
	if (arguments.removeSpaces) {
		local.returnValue = stripSpaces(local.returnValue);
	}
	local.returnValue = replace(local.returnValue, crlf(), "", "all");
	local.returnValue = replace(local.returnValue, chr(13), "", "all");
	local.returnValue = replace(local.returnValue, chr(10), "", "all");
	// fix asset domains
	local.returnValue = replace(
		local.returnValue,
		"cf.zenu",
		get("westerosHost"),
		"all"
	);
	return local.returnValue;
}

/**
* Accepts a specifically formatted chunk of text, and returns it as a query object.
* v2 rewrite by Jamie Jackson
* https://cflib.org/udf/querysim
*
*  people = querySim('
*    id , name , mail, phone
*    1 | weed | weed@theflowerpot.not | 0412 345 678
*    2 | bill | bill@theflowerpot.not | -
*    3 | ben | ben@theflowerpot.not | -
*  ');
*
* @param queryData      Specifically format chunk of text to convert to a query. (Required)
* @return Returns a query object.
* @author Bert Dawson (bert@redbanner.com)
* @version 2, December 18, 2007
*/
function querySim(queryData) {
	var fieldsDelimiter = "|";
	var colnamesDelimiter = ",";
	var listOfColumns = "";
	var tmpQuery = "";
	var numLines = "";
	var cellValue = "";
	var cellValues = "";
	var colName = "";
	var lineDelimiter = chr(13) & chr(10);
	var lineNum = 0;
	var colPosition = 0;

	// the first line is the column list, eg "column1,column2,column3"
	listOfColumns = trim(listGetAt(queryData, 1, lineDelimiter));

	// create a temporary Query
	tmpQuery = queryNew(listOfColumns);

	// the number of lines in the queryData
	numLines = listLen(queryData, lineDelimiter);

	// loop though the queryData starting at the second line
	for (lineNum = 2; lineNum LTE numLines; lineNum = lineNum + 1) {
		cellValues = listGetAt(queryData, lineNum, lineDelimiter);
		if (listLen(cellValues, fieldsDelimiter) IS listLen(listOfColumns, ",")) {
			queryAddRow(tmpQuery);
			for (colPosition = 1; colPosition LTE listLen(listOfColumns); colPosition = colPosition + 1) {
				cellValue = trim(listGetAt(cellValues, colPosition, fieldsDelimiter));
				colName = trim(listGetAt(listOfColumns, colPosition));
				querySetCell(tmpQuery, colName, cellValue == "-" ? "" : cellValue);
			}
		}
	}

	return (tmpQuery);
}

public boolean function equalize(any expected, any actual) {
	// Null values
	if (isNull(arguments.expected) && isNull(arguments.actual)) {
		return true;
	}

	if (isNull(arguments.expected) || isNull(arguments.actual)) {
		return false;
	}

	// Numerics
	if (
		isNumeric(arguments.actual) && isNumeric(arguments.expected) && toString(arguments.actual) eq toString(
			arguments.expected
		)
	) {
		return true;
	}

	// Simple values
	if (isSimpleValue(arguments.actual) && isSimpleValue(arguments.expected) && arguments.actual eq arguments.expected) {
		return true;
	}

	// Queries
	if (isQuery(arguments.actual) && isQuery(arguments.expected)) {
		// Check number of records
		if (arguments.actual.recordCount != arguments.expected.recordCount) {
			return false;
		}

		// Get both column lists and sort them the same
		var actualColumnList = listSort(arguments.actual.columnList, "textNoCase");
		var expectedColumnList = listSort(arguments.expected.columnList, "textNoCase");

		// Check column lists
		if (actualColumnList != expectedColumnList) {
			return false;
		}

		// Loop over each row
		var i = 0;
		while (++i <= arguments.actual.recordCount) {
			// Loop over each column
			for (var column in listToArray(actualColumnList)) {
				// Compare each value
				if (arguments.actual[column][i] != arguments.expected[column][i]) {
					// At the first sign of trouble, bail!
					return false;
				}
			}
		}

		// We made it here so nothing looked wrong
		return true;
	}

	// UDFs
	if (
		isCustomFunction(arguments.actual) && isCustomFunction(arguments.expected) &&
		arguments.actual.toString() eq arguments.expected.toString()
	) {
		return true;
	}

	// XML
	if (
		isXMLDoc(arguments.actual) && isXMLDoc(arguments.expected) &&
		toString(arguments.actual) eq toString(arguments.expected)
	) {
		return true;
	}

	// Arrays
	if (isArray(arguments.actual) && isArray(arguments.expected)) {
		// Confirm both arrays are the same length
		if (arrayLen(arguments.actual) neq arrayLen(arguments.expected)) {
			return false;
		}

		for (var i = 1; i lte arrayLen(arguments.actual); i++) {
			// check for both being defined
			if (arrayIsDefined(arguments.actual, i) and arrayIsDefined(arguments.expected, i)) {
				// check for both nulls
				if (isNull(arguments.actual[i]) and isNull(arguments.expected[i])) {
					continue;
				}
				// check if one is null mismatch
				if (isNull(arguments.actual[i]) OR isNull(arguments.expected[i])) {
					return false;
				}
				// And make sure they match
				if (!equalize(arguments.actual[i], arguments.expected[i])) {
					return false;
				}
				continue;
			}
			// check if both not defined, then continue to next element
			if (!arrayIsDefined(arguments.actual, i) and !arrayIsDefined(arguments.expected, i)) {
				continue;
			} else {
				return false;
			}
		}

		// If we made it here, we couldn't find anything different
		return true;
	}

	// Structs / Object
	if (isStruct(arguments.actual) && isStruct(arguments.expected)) {
		var actualKeys = listSort(structKeyList(arguments.actual), "textNoCase");
		var expectedKeys = listSort(structKeyList(arguments.expected), "textNoCase");
		var key = "";

		// Confirm both structs have the same keys
		if (actualKeys neq expectedKeys) {
			return false;
		}

		// Loop over each key
		for (key in arguments.actual) {
			// check for both nulls
			if (isNull(arguments.actual[key]) and isNull(arguments.expected[key])) {
				continue;
			}
			// check if one is null mismatch
			if (isNull(arguments.actual[key]) OR isNull(arguments.expected[key])) {
				return false;
			}
			// And make sure they match when actual values exist
			if (!equalize(arguments.actual[key], arguments.expected[key])) {
				return false;
			}
		}

		// If we made it here, we couldn't find anything different
		return true;
	}

	return false;
}
</cfscript>
