<cfscript>
public string function isInteger(required string string) {
	return len(arguments.string) && len(reReplaceNoCase(arguments.string, "[0-9]", "", "all")) == 0;
}

/** Returns a number given a string, could return an empty string, eg: "$"*/
public string function numberParse(required string number) {
	return reReplaceNoCase(
		arguments.number,
		"[^0-9.-]",
		"",
		"all"
	);
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

public string function formatNumber(required string string, string default = "", string mask = "9999999.99") {
	var loc = {};
	loc.returnValue = arguments.string;
	if (len(loc.returnValue)) {
		if (!isNumeric(loc.returnValue)) {
			loc.returnValue = arguments.default;
		} else if ((find(".", loc.returnValue) && listLast(loc.returnValue, ".") == 0) OR find(".", loc.returnValue) eq 0) {
			// i.e. 12.00 -> 12
			loc.returnValue = int(loc.returnValue);
		} else {
			loc.returnValue = numberFormat(loc.returnValue, arguments.mask);
			if (find(".", loc.returnValue) && right(listLast(loc.returnValue, "."), 1) == 0) {
				// remove trailing zero from decimal; i.e. 12.1200 -> 12.12
				loc.returnValue = reReplace(reReplace(loc.returnValue, "0+$", "", "ALL"), "\.+$", "");
			}
		}
	}
	return trim(loc.returnValue);
}

/**
* @hint Calculates the percentage of a value, given a maximum. Deals with division by zero
* @value : The value to be calculated
* @maximum : The number that the value is a percentage of
* @returnAs : [integer,decimal,original]
*/
public numeric function calculatePercentage(
	required numeric value,
	required numeric maximum,
	string returnAs = "integer"
) {
	var loc = {};
	// Deal with division by zero
	if (arguments.maximum == 0) {
		return 0;
	}
	loc.rv = (arguments.value / arguments.maximum) * 100;

	if (arguments.returnAs == "integer") {
		return ceiling(loc.rv);
	} else if (arguments.returnAs == "decimal") {
		return decimalFormat(loc.rv);
	} else {
		return loc.rv;
	}
}

/**
* @hint Given a number, I return 2 numbers that are x% either side
* @number int
* @percentage int
*/
public array function medianRange(required numeric number, required numeric percentage) {
	local.multiplier = arguments.percentage / 100;
	local.portion = arguments.number * local.multiplier;
	local.rv = [arguments.number - local.portion, arguments.number + local.portion];
	return local.rv;
}

/**
* Rounds a number up or down to the nearest specified multiple.
*
* @param number      Number you want to round. (Required)
* @param multiple      Multiple by which to round.  Default is 5. (Optional)
* @param direction      Direction to round.  Options are Up or Down.  Default is Up (Optional)
* @return Returns a numberic value
* @author Casey Broich (cab@pagex.com)
* @version 1, June 27, 2002
*/
function roundNumber(required numeric number, numeric multiple = 5, string direction = "up") {
	var roundval = arguments.multiple;
	var direction = arguments.direction;
	var result = 0;

	if (roundval == 0) {
		roundval = 1;
	}

	if ((arguments.number MOD roundval) != 0) {
		if ((direction == 1) || (direction == "Up")) {
			result = arguments.number + (roundval - (arguments.number MOD roundval));
		} else {
			result = arguments.number - (arguments.number MOD roundval);
		}
	} else {
		result = arguments.number;
	}
	return result;
}
</cfscript>
