<cfscript>
/**
* Returns true if a date string is a valid date
*
* [section: Application]
* [category: Date Functions]
*
*/
public boolean function isValidDate(required string date) {
	var dt = arguments.date;
	if (find("/", dt)) {
		// Convert d/m/yyyy to yyyy-m-d
		var a = listToArray(dt, "/");
		if (arrayLen(a) == 3) {
			dt = a[3] & "-" & a[2] & "-" & a[1];
		}
	}
	// Accept only yyyy-m-d format
	if (find("-", dt)) {
		if (isDate(dt)) {
			var y = year(dt);
			// Values for smalldatetime data types earlier than January 1, 1753 are not permitted in SQL Server.
			// SQL Server rejects all values that do not fall within the range from 1753 to 2079.
			if (y >= 1753 && y <= 2079) {
				return true;
			}
		}
	}
	return false;
}

/**
* Parses a date string to a date object (Also see parseDateString)
*
* [section: Application]
* [category: Date Functions]
*
*/
function parseDate(required string date) {
	var loc = {};
	loc.a = listToArray(arguments.date, "/-");
	if (arrayLen(loc.a) == 3) {
		if (
			isValidDate(arguments.date) &&
			len(loc.a[1]) <= 2 &&
			len(loc.a[2]) <= 2 &&
			(len(loc.a[3]) == 4 || len(loc.a[3]) == 2)
		) {
			// cater for dd/mm/yyyy OR dd/mm/yy
			return createDate(loc.a[3], loc.a[2], loc.a[1]);
		}
	}
	throw(type = "InvalidDateError", message = "#arguments.date# is not a valid date string");
}

/**
* Parses a date string to a date object (Also see parseDate)
*
* [section: Application]
* [category: Date Functions]
*
*/
function parseDateString(required string date, string delimiter = "/") {
	var loc = {};
	if (isEmpty(arguments.date)) {
		return "";
	}
	if (!isValidDate(date)) {
		throw(type = "InvalidDateError", "#arguments.date# is not a valid date string");
	} else if (arguments.delimiter == "/") {
		// dd/mm/yyyy
		loc.a = listToArray(arguments.date, "/");
		if (arrayLen(loc.a) == 3) {
			return createDate(loc.a[3], loc.a[2], loc.a[1]);
		}
	} else if (arguments.delimiter == "-") {
		// yyyy-mm-dd
		loc.a = listToArray(arguments.date, "-");
		if (arrayLen(loc.a) == 3) {
			return createDate(loc.a[1], loc.a[2], loc.a[3]);
		}
	} else if (len(arguments.date) == 8) {
		// yyyymmdd
		loc.year = left(arguments.date, 4);
		loc.month = mid(arguments.date, 5, 2);
		loc.day = mid(arguments.date, 7, 2);
		return createDate(loc.year, loc.month, loc.day);
	} else {
		throw(type = "InvalidDateError", "#arguments.date# is not a valid date string");
	}
}

/**
* Given a time string, returns a date
*
* [section: Application]
* [category: Date Functions]
*
*/
public any function parseTimeString(required string time) {
	var loc = {};
	if (isEmpty(arguments.time)) {
		return "";
	}
	// hh:mmtt OR hh:mm tt
	try {
		loc.time = arguments.time;
		loc.h = listFirst(loc.time, ":")
		loc.m = left(listGetAt(loc.time, 2, ": "), 2);
		loc.ampm = right(loc.time, 2);
		if (loc.ampm is "AM" AND loc.h == 12) {
			loc.h = 0;
		} else if (loc.ampm is "PM" AND loc.h LT 12) {
			loc.h = loc.h + 12;
		}
		return createDateTime(1900, 1, 1, loc.h, loc.m, 0);
	} catch (any e) {
		throw(type = "InvalidTimeError", "#arguments.time# is not a valid time string");
	}
}
;

/**
* Given a string, returns a date
*
* [section: Application]
* [category: Date Functions]
*
*/
public any function parseDateTimeString(required string date, string delimiter = "/") {
	var loc = {};
	if (isEmpty(arguments.date)) {
		return "";
	}
	if (arguments.delimiter == "/") {
		// dd/mm/yyyy hh:mmtt OR dd/mm/yyyy hh:mm tt
		loc.d = listToArray(listFirst(arguments.date, " "), "/");
		loc.t = listRest(arguments.date, " ");
		loc.h = listFirst(loc.t, ":");
		loc.m = left(listGetAt(loc.t, 2, ": "), 2);
		loc.ampm = right(loc.t, 2);
		if (loc.ampm == "PM" && loc.h < 12) {
			loc.h = loc.h + 12;
		}
		return createDateTime(
			loc.d[3],
			loc.d[2],
			loc.d[1],
			loc.h,
			loc.m,
			0
		);
	} else if (arguments.delimiter == "-") {
		// yyyy-mm-dd-hh:mm:ss
		loc.year = listFirst(arguments.date, "-");
		loc.month = listGetAt(arguments.date, 2, "-");
		loc.day = listGetAt(arguments.date, 3, "-");
		loc.time = listLast(arguments.date, "-");
		loc.hour = listFirst(loc.time, ":");
		loc.minute = listGetAt(loc.time, 2, ":");
		return createDateTime(
			loc.year,
			loc.month,
			loc.day,
			loc.hour,
			loc.minute,
			0
		);
	} else if (len(arguments.date) == 14) {
		// 20140618150107
		loc.year = left(arguments.date, 4);
		loc.month = mid(arguments.date, 5, 2);
		loc.day = mid(arguments.date, 7, 2);
		loc.hour = mid(arguments.date, 9, 2);
		loc.minute = mid(arguments.date, 11, 2);
		loc.second = mid(arguments.date, 13, 2);
		return createDateTime(
			loc.year,
			loc.month,
			loc.day,
			loc.hour,
			loc.minute,
			loc.second
		);
	} else {
		throw(type = "InvalidDateTimeError", "#arguments.date# is not a valid date time string");
	}
}

/**
* Formats a date for display
*
* [section: Application]
* [category: Date Functions]
*
* @pronoun If true, will return  "today", "tomorrow", "yesterday" (if applicable)
*/
public string function formatDate(
	required date date,
	date nowdate = now(),
	boolean pronoun = false
) {
	var loc = {};
	loc.diff = dateDiff("d", startOfDay(arguments.date), startOfDay(arguments.nowdate));
	if (listFind("-1,0,1", loc.diff) && arguments.pronoun) {
		if (loc.diff == 0) {
			return "Today";
		} else if (loc.diff == -1) {
			return "Tomorrow";
		} else if (loc.diff == 1) {
			return "Yesterday";
		}
	} else {
		return dateFormat(arguments.date, "ddd, ") & th(day(arguments.date)) & dateFormat(arguments.date, " mmm yy");
	}
}

/**
* 	Formats a time for display
*
* [section: Application]
* [category: Date Functions]
*
*/
public string function formatTime(required date date) {
	return lCase(timeFormat(arguments.date, "h:mmtt"));
}

/**
* Formats a date & time for display (See formatDate() and formatTime())
*
* [section: Application]
* [category: Date Functions]
*
*/
public string function formatDateTime(required date date) {
	return formatDate(argumentCollection = arguments) & " " & formatTime(arguments.date);
}

/**
* Formats a date object to a standard dd/mm/yyyy format
*
* [section: Application]
* [category: Date Functions]
*
*/
package function humaniseDate(required string string) {
	return left(arguments.string, 1) == "{" && right(arguments.string, 1) == "}" ? dateFormat(
		arguments.string,
		"dd/mm/yyyy"
	) : "";
}

/**
* Returns midnight (morning) for a given date
*
* [section: Application]
* [category: Date Functions]
*
*/
public string function startOfDay(required date date) {
	return createDateTime(
		year(arguments.date),
		month(arguments.date),
		day(arguments.date),
		0,
		0,
		0
	);
}

/**
* Returns midnight (night) for a given date
*
* [section: Application]
* [category: Date Functions]
*
*/
public string function endOfDay(required date date) {
	return createDateTime(
		year(arguments.date),
		month(arguments.date),
		day(arguments.date),
		23,
		59,
		59
	);
}

/**
* Returns midnight (night) for the last day of a month
*
* [section: Application]
* [category: Date Functions]
*
*/
public string function endOfMonth(required date date) {
	return createDateTime(
		year(arguments.date),
		month(arguments.date),
		daysInMonth(arguments.date),
		23,
		59,
		59
	);
}

/**
* Returns first day of the month for a given date
*
* [section: Application]
* [category: Date Functions]
*
*/
public string function startOfMonth(required date date) {
	return createDateTime(
		year(arguments.date),
		month(arguments.date),
		1,
		0,
		0,
		0
	);
}

/**
* Returns midnight (night) for the last day of a year
*
* [section: Application]
* [category: Date Functions]
*
*/
public string function endOfYear(required date date) {
	return createDateTime(
		year(arguments.date),
		12,
		31,
		23,
		59,
		59
	);
}

/**
* Returns first day of the year given a date
*
* [section: Application]
* [category: Date Functions]
*
* @arg1
* @arg2
*/
public string function startOfYear(required date date) {
	return createDateTime(year(arguments.date), 1, 1, 0, 0, 0);
}

/**
* Returns the start date of a given date's financial year
*
* [section: Application]
* [category: Date Functions]
*
*/
public string function financialYearStart(required date date) {
	if (month(arguments.date) gt 6) {
		return createDate(year(arguments.date), 7, 1);
	} else {
		return createDate(year(arguments.date) - 1, 7, 1);
	}
}

/**
* Given a timezone, I will return the local datetime
*
* [section: Application]
* [category: Date Functions]
*
* @date Only used for unit testing
*/
public date function localNow(required string timezone, date date = now()) {
	return UTCToLocalDate(timezone = arguments.timezone, date = arguments.date);
}

/**
* Given a timezone and a local date, I will return the datetime on the server
*
* [section: Application]
* [category: Date Functions]
*
*/
public date function localToUTCDate(required date date, required string timezone) {
	local.mins = localToUTCDiffMinutes(timezone = arguments.timezone, date = arguments.date);
	return dateAdd("n", -local.mins, arguments.date)
}

/**
* Given a timezone and a UTC date, I will return the date in the given timezone
*
* [section: Application]
* [category: Date Functions]
*
*/
public date function UTCToLocalDate(required date date, required string timezone) {
	local.mins = localToUTCDiffMinutes(timezone = arguments.timezone, date = arguments.date);
	return dateAdd("n", local.mins, arguments.date)
}

public string function epochTime(date date = now()) {
	return dateDiff("s", createDateTime(1970, 1, 1, 0, 0, 0), arguments.date);
}

public string function epochTimeToDate(required date epoch) {
	return dateAdd("s", arguments.epoch, createDateTime(1970, 1, 1, 0, 0, 0));
}

/**
* Converts an ISO 8601 date/time stamp with optional dashes to a ColdFusion date/time stamp.
* http://www.bennadel.com/blog/811-converting-iso-date-time-to-coldfusion-date-time.htm
*
* [section: Application]
* [category: Date Functions]
*
*/
public string function ISOToDateTime(required string date) {
	// When returning the converted date/time stamp, allow for optional dashes.
	return arguments.date
		.toString()
		.ReplaceFirst("^.*?(\d{4})-?(\d{2})-?(\d{2})T([\d:]+).*$", "$1-$2-$3 $4");
}

/**
* Convert date to 2014-10-30T11:36:27
* http://www.bennadel.com/blog/2501-Converting-ColdFusion-Date-Time-Values-Into-ISO-8601-Time-Strings.htm
*
* [section: Application]
* [category: Date Functions]
*
*/
public string function getISO8601(
	required date date,
	boolean convertToUTC = "false",
	boolean includeTimezone = "false"
) {
	var date = arguments.date;
	if (arguments.convertToUTC) {
		local.date = dateConvert("local2utc", local.date);
	}
	local.date = dateFormat(local.date, "yyyy-mm-dd") & "T" & timeFormat(local.date, "HH:mm:ss");
	if (arguments.includeTimezone) {
		local.date = local.date & "+#abs(getTimezoneInfo().utcHourOffset)#";
	}
	if (arguments.convertToUTC) {
		local.date = local.date & "Z";
	}
	return local.date;
}

/**
* Creates an array of incremented minutes
*
* [section: Application]
* [category: Date Functions]
*
*/
public array function arrayOfMinutes(numeric increment = 5) {
	var loc = {};
	loc.i = 0;
	loc.returnValue = [];
	while (loc.i lt 60) {
		loc.returnValue.Append(loc.i);
		loc.i += arguments.increment;
	}
	return loc.returnValue;
}


/**
* Creates an array of formatted incremented times
*
* [section: Application]
* [category: Date Functions]
*
*/
public array function arrayOfTimes(numeric increment = 5) {
	// TODO: start and end hours
	var loc = {};
	loc.returnvalue = [];
	// morning (start from 5:00am)
	for (loc.hour in [5, 6, 7, 8, 9, 10, 11]) {
		for (loc.min in arrayOfMinutes(increment = arguments.increment)) {
			loc.returnvalue.Append("#loc.hour#:#loc.min lt 10 ? "0#loc.min#" : loc.min#am");
		}
	}
	// arvo & evening (finish at 10:00pm)
	for (loc.hour in [12, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10]) {
		for (loc.min in arrayOfMinutes(increment = arguments.increment)) {
			loc.returnvalue.Append("#loc.hour#:#loc.min lt 10 ? "0#loc.min#" : loc.min#pm");
		}
	}
	return loc.returnvalue;
}

/**
* Returns the current date as a numeric value
*
* [section: Application]
* [category: Date Functions]
*
*/
public numeric function dts(date date = now()) {
	return dateFormat(arguments.date, "yyyymmdd") & timeFormat(arguments.date, "HHmmss");
}

/**
* Parse a datetime stamp as formatted by dts()
*
* [section: Application]
* [category: Date Functions]
*
*/
public any function parseDts(required numeric dts) {
	var loc = {};
	loc.rv = false;
	if (len(arguments.dts) == 14) {
		loc.struct = {};
		loc.y = left(arguments.dts, 4);
		loc.m = mid(arguments.dts, 5, 2);
		loc.d = mid(arguments.dts, 7, 2);
		loc.h = mid(arguments.dts, 9, 2);
		loc.n = mid(arguments.dts, 11, 2);
		loc.s = mid(arguments.dts, 13, 2);
		loc.rv = createDateTime(
			loc.y,
			loc.m,
			loc.d,
			loc.h,
			loc.n,
			loc.s
		);
	}
	return loc.rv;
}

/**
* Returns tomorrow's date object
*
* [section: Application]
* [category: Date Functions]
*
*/
public date function tomorrow() {
	return dateAdd("d", 1, now());
}

/**
* Returns yesterday's date object
*
* [section: Application]
* [category: Date Functions]
*
*/
public date function yesterday() {
	return dateAdd("d", -1, now());
}

/**
* Given a timezone, I will return the difference between it and the server timezone
*
* [section: Application]
* [category: Date Functions]
*
*/
public date function localToUTCDiffMinutes(required string timezone, date date = now()) {
	local.timezoneClass = createObject("java", "java.util.TimeZone");
	local.timezoneObj = local.timezoneClass.getTimeZone(javacast("string", arguments.timezone));
	if (local.timezoneObj.getId() != "gmt") {
		// return offset in hours
		local.tYear = javacast("int", year(arguments.date));
		local.tMonth = javacast("int", month(arguments.date) - 1);
		local.tDay = javacast("int", day(arguments.date));
		local.tDOW = javacast("int", dayOfWeek(arguments.date));
		local.minOffset = local.timezoneObj.getOffset(
			1,
			local.tYear,
			local.tMonth,
			local.tDay,
			local.tDOW,
			0
		) / 60000;
		// server time zone info
		local.serverTimeZone = getTimezoneInfo();
		local.serverMinOffSet = local.serverTimeZone.utcHourOffset * 60 + local.serverTimeZone.utcMinuteOffset;
		// get difference (in minutes) between local and server
		return local.serverMinOffSet + local.minOffset;
	} else {
		// unable to find timezone
		return 0;
	}
}

/**
* Coverts an ISO date to server date
*
* [section: Application]
* [category: Date Functions]
*
*/
public date function convertISODateToServerDate(required string date) {
	return dateConvert("utc2Local", ISOToDateTime(arguments.date));
}

/**
* Finds the date first instance of a specific week day in a month
*
* [section: Application]
* [category: Date Functions]
*
*/
public function firstInstanceOfWeekDayInMonth(required date testDate, required numeric findDay) {
	// Find the first day of the month
	var dtMonthStart = createDate(year(arguments.testDate), month(arguments.testDate), 1);
	// Find the weekday number of first day of the month
	var firstWeekDayOfMonth = dayOfWeek(dtMonthStart);
	var firstDate = "";
	var difference = 0;
	/*
	  As a quick sanity check throw an error if the weekday being
	  searched for is not in the range 1-7
	*/
	if (arguments.findDay < 1 || arguments.findDay > 7) {
		throw(message = "Target day to search on is not in the range 1-7");
	}
	// If the first day of the month is also the day we want
	if (firstWeekDayOfMonth == arguments.findDay) {
		firstDate = dtMonthStart;
		// If the first day of the month is later in the week
	} else if (firstWeekDayOfMonth > arguments.findDay) {
		difference = firstWeekDayOfMonth - arguments.findDay;
		firstDate = dateAdd("d", (7 - difference), dtMonthStart);
		// If the first day of the month is earlier in the week
	} else {
		firstDate = dateAdd("d", (arguments.findDay - firstWeekDayOfMonth), dtMonthStart);
	}
	return firstDate;
}

public function monthDateArray(required date startDate, required date endDate, ) {
	local.returnArray = [];
	local.thisStartDate = arguments.startDate;
	while (local.thisStartDate LT arguments.endDate) {
		local.thisMonthStruct = {};
		local.thisMonthStruct.from = local.thisStartDate;
		local.thisMonthStruct.from = createDate(year(local.thisStartDate), month(local.thisStartDate), 1);
		local.thisMonthStruct.to = createDateTime(
			year(local.thisStartDate),
			month(local.thisStartDate),
			daysInMonth(local.thisStartDate),
			23,
			59,
			59
		);
		local.returnArray.Append(local.thisMonthStruct);
		local.thisStartDate = dateAdd("m", 1, local.thisStartDate);
	}
	return local.returnArray;
}

/**
* Returns a date time in mysql supported format
*
* [section: Application]
* [category: Date Functions]
*
*/
public string function mySQLDateTime(required string date) {
	return dateTimeFormat(arguments.date, "yyyy-mm-dd HH:nn:ss");
}

/**
* Returns a date in mysql supported format
*
* [section: Application]
* [category: Date Functions]
*
*/
public string function mySQLDate(required string date) {
	return dateFormat(arguments.date, "yyyy-mm-dd");
}
</cfscript>

<cffunction name="recurDate" access="package" output="No" returntype="any">
	<cfargument name="start" type="date" required="Yes"/>
	<cfargument name="pattern" type="string" required="Yes" hint="[daily|weekly|monthly|yearly]"/>
	<cfargument
		name="dailyRecurrence"
		type="string"
		required="No"
		default=""
		hint="(applies only to pattern=day) [everyday|weekend|weekday|daysofweek]"
	/>
	<cfargument
		name="includeStart"
		type="boolean"
		required="No"
		default="true"
		hint="specifies if the start day of recurrence should be included"
	/>
	<cfargument name="daysOfWeek" type="string" required="No" default="" hint="days of week to occur (1-7)"/>
	<cfargument name="daysOfMonth" type="string" required="No" default="" hint="days of month to occur (1-31)"/>
	<cfargument
		name="monthOfYear"
		type="string"
		required="No"
		default=""
		hint="(applies only to pattern=year) month of year to occur (1-12)"
	/>
	<cfargument
		name="dayOfMonth"
		type="string"
		required="No"
		default=""
		hint="(applies only to pattern=year) day of month to occur (1-12). NOTE: not to be confused with daysOfMonth"
	/>
	<cfargument name="recurCycle" type="numeric" required="No" default="1" hint="occur every x periods (every 2 weeks)"/>
	<cfargument
		name="occurences"
		type="string"
		required="No"
		default=""
		hint="occur x times. NOTE: either accept this argument or the following two"
	/>
	<cfargument
		name="durationPeriod"
		type="string"
		required="No"
		default=""
		hint="[day|week|month|year] occur for this unit of time. NOTE: use in conjunction with durationPeriodCount"
	/>
	<cfargument
		name="durationPeriodCount"
		type="string"
		required="No"
		default=""
		hint="occure for this period of time. NOTE: use in conjunction with durationPeriod"
	/>

	<!---
		USE
		----------------------------------
		Returns an array of datetimes
		SYNTAX:
		-----------------
		daily recurrence
		-----------------
		* every day for 5 days
		recurDate(start=now(),pattern="daily",occurences=5,dailyRecurrence="everyday")
		* every weekday for 4 weeks
		recurDate(start=now(),pattern="daily",durationPeriod="week",durationPeriodCount=4,dailyRecurrence="weekday")
		* every monday and friday a maximum of 5 occurences
		recurDate(start=now(),pattern="daily",occurences=5,dailyRecurrence="daysofweek",daysOfWeek="2,6")
		* every tuesday and thursday for 1 month
		recurDate(start=now(),pattern="daily",durationPeriod="month",durationPeriodCount=1,dailyRecurrence="daysofweek",daysOfWeek="3,5")
		* every weekend (saturday and sunday) for 4 weeks
		recurDate(start=now(),pattern="daily",durationPeriod="week",durationPeriodCount=4,dailyRecurrence="weekend")
		-----------------
		weekly recurrence
		-----------------
		* every monday and thursday a maximum of 5 times
		recurDate(start=now(),pattern="weekly",occurences=5,daysOfWeek="2,5")
		* every 2nd week for 4 weeks on the same day of week as the source event
		recurDate(start=now(),pattern="weekly",durationPeriod="week",durationPeriodCount=4,recurCycle=2)
		* every 3rd week for 5 months on the same day of week as the source event EXCLUDING the actual date of the event (first occurence will be in 3 weeks)
		recurDate(start=now(),pattern="weekly",durationPeriod="month",durationPeriodCount=5,recurCycle=3,includeStart=false)
		-----------------
		monthly recurrence
		-----------------
		* every 1st, 15th & 31st of the month a maximum of 7 times
		recurDate(start=now(),pattern="monthly",occurences=7,daysOfMonth="1,15,31")
		* every 6 months on the same day of month as the source event for 3 years
		recurDate(start=now(),pattern="monthly",durationPeriod="year",durationPeriodCount=3,recurCycle=6)
		-----------------
		yearly recurrence
		-----------------
		* every year on christmas day a maximum of 5 times
		recurDate(start=now(),pattern="yearly",occurences=5,dayOfMonth="25",monthOfYear="12")
		* every anzac day for the next 10 years EXCLUDING the actual date of the event (first occurence will be in 1 year)
		recurDate(start=now(),pattern="yearly",durationPeriod="year",durationPeriodCount=10,dayOfMonth="25",monthOfYear="4",includeStart=false)
		* every 2nd year on the event day for 10 years
		recurDate(start=now(),pattern="yearly",durationPeriod="year",durationPeriodCount=10,recurCycle=2)
		notes:
		-----------------
		* If a day of month falls on a day that does not exist in the month, the last day of the month will be substituted.
		* If includeStart=true but the event day of week does not fall on specified daysOfWeek OR dailyRecurrence is one of [weekdays|weekend]
		the event day will not be returned.
		* To prevent the possibility of infinite loops occurring, conditions will only be evaluated a finite number of times times
		* number of occurences is defined as the number of dates retutned.. not sets of the same groups of dates (in the event of multiple daysOfMonth/daysOfWeek)
		* Identical results can be achieved using different patterns
	--->
	<cfset var loc = {}>
	<cfset loc.return = []/>
	<cfset loc.day = 0/><!--- day counter --->
	<cfset loc.week = 0/><!--- week counter --->
	<cfset loc.month = 0/><!--- month counter --->
	<cfset loc.year = 1/><!--- year counter (treat this year as year 1) --->
	<cfset loc.loopBreaker = 0/>
	<cfset loc.condition = ""/>
	<cfset loc.durationDatePart = ""/>
	<cfset loc.jobDurationStartDatetime = arguments.start/>
	<cfset loc.jobDurationEndDatetime = ""/>
	<cfset loc.jobDaysOfWeek = listSort(arguments.daysOfWeek, "numeric")/>
	<cfset loc.jobDaysOfMonth = listSort(arguments.daysOfMonth, "numeric")/>
	<cfset loc.jobMonthOfYear = arguments.monthOfYear/>
	<cfset loc.jobDayOfMonth = arguments.dayOfMonth/>
	<cfset loc.iterationDatetime = arguments.start/><!--- this date will be 'incremented' --->

	<!--- if occur_at_event is true.. append event time to the array --->
	<cfif arguments.includeStart>
		<cfset arrayAppend(loc.return, arguments.start)/>
	</cfif>

	<!--- determine recur interval --->
	<cfif len(arguments.durationPeriod) gt 0 AND len(arguments.durationPeriodCount) gt 0>
		<cfif compareNoCase(trim(arguments.durationPeriod), "hour") eq 0>
			<cfset loc.durationDatePart = "h"/>
        <cfelseif compareNoCase(trim(arguments.durationPeriod), "day") eq 0>
			<cfset loc.durationDatePart = "d"/>
        <cfelseif compareNoCase(trim(arguments.durationPeriod), "week") eq 0>
			<cfset loc.durationDatePart = "ww"/>
        <cfelseif compareNoCase(trim(arguments.durationPeriod), "month") eq 0>
			<cfset loc.durationDatePart = "m"/>
        <cfelseif compareNoCase(trim(arguments.durationPeriod), "year") eq 0>
			<cfset loc.durationDatePart = "yyyy"/>
		</cfif>

		<cfset loc.jobDurationEndDatetime = dateAdd(loc.durationDatePart, arguments.durationPeriodCount, arguments.start)/>

		<cfset loc.condition = "DateCompare(loc.iterationDatetime, loc.jobDurationEndDatetime) eq -1"/>
    <cfelseif len(arguments.occurences) gt 0>
		<cfset loc.condition = "ArrayLen(loc.return) LT arguments.occurences"/>
	</cfif>

	<cfif listFindNoCase("daily,day", arguments.pattern) gt 0>
		<!--- define days of week to occur --->
		<cfif compareNoCase(arguments.dailyRecurrence, "everyday") eq 0>
			<cfset loc.jobDaysOfWeek = "1,2,3,4,5,6,7"/>
        <cfelseif compareNoCase(arguments.dailyRecurrence, "weekday") eq 0>
			<cfset loc.jobDaysOfWeek = "2,3,4,5,6"/>
        <cfelseif compareNoCase(arguments.dailyRecurrence, "weekend") eq 0>
			<cfset loc.jobDaysOfWeek = "1,7"/>
        <cfelseif compareNoCase(arguments.dailyRecurrence, "daysofweek") eq 0>
			<!--- this is set at declaration --->
		</cfif>
		<!---
			if the event day is not on one of the days specified, delete it from the array (if occur_at_event is set to true)
		--->
		<cfif arguments.includeStart AND listFind(loc.jobDaysOfWeek, dayOfWeek(arguments.start)) eq 0>
			<cfset arrayDeleteAt(loc.return, 1)/>
		</cfif>

		<cfloop condition="#evaluate(loc.condition)#">
			<cfif val(arguments.recurCycle)>
				<cfset loc.recurCycle = arguments.recurCycle>
            <cfelse>
				<cfset loc.recurCycle = 1>
			</cfif>
			<cfset loc.iterationDatetime = dateAdd("d", loc.recurCycle, loc.iterationDatetime)/>
			<cfif listFind(loc.jobDaysOfWeek, dayOfWeek(loc.iterationDatetime)) gt 0>
				<!--- run only on the days specified --->
				<cfset arrayAppend(loc.return, loc.iterationDatetime)/>
			</cfif>
			<cfset loc.loopBreaker = loc.loopBreaker + 1/>
			<cfif loc.loopBreaker eq 1825>
				<!--- 5 years --->
				<cfbreak/>
			</cfif>
		</cfloop>
    <cfelseif listFindNoCase("weekly,week", arguments.pattern) gt 0>

		<!--- if no daysOfWeek argument is present, use the day of the event --->
		<cfif len(arguments.daysOfWeek) eq 0>
			<cfset loc.jobDaysOfWeek = dayOfWeek(arguments.start)/>
		</cfif>

		<!---
			if the event day is not on one of the days specified, delete it from the array (if occur_at_event is set to true)
		--->
		<cfif arguments.includeStart AND listFind(loc.jobDaysOfWeek, dayOfWeek(arguments.start)) eq 0>
			<cfset arrayDeleteAt(loc.return, 1)/>
		</cfif>

		<cfloop condition="#evaluate(loc.condition)#">
			<cfset loc.iterationDatetime = dateAdd("d", 1, loc.iterationDatetime)/>

			<!--- if dayofweek is same as event dayofweek, increment the week counter --->
			<cfif dayOfWeek(loc.iterationDatetime) EQ dayOfWeek(arguments.start) AND dateCompare(
				loc.iterationDatetime,
				arguments.start
			) NEQ 0>
				<cfset loc.week = loc.week + 1/>
			</cfif>

			<!---
				append if its the right day of the week and is the right week (if applicable). i start on week zero.. but dont want to add this unless it recurs every week
			--->
			<cfif listFind(loc.jobDaysOfWeek, dayOfWeek(loc.iterationDatetime)) gt 0 AND (loc.week MOD arguments.recurCycle) EQ 0 AND (
				loc.week GT 0 OR val(arguments.recurCycle) lte 1
			)>
				<cfset arrayAppend(loc.return, loc.iterationDatetime)/>
			</cfif>
			<cfset loc.loopBreaker = loc.loopBreaker + 1/>
			<cfif loc.loopBreaker eq 1825>
				<!--- 5 years --->
				<cfbreak/>
			</cfif>
		</cfloop>
    <cfelseif listFindNoCase("monthly,month", arguments.pattern) gt 0>

		<!--- if no daysOfMonth argument is present, use the day of the event --->
		<cfif len(arguments.daysOfMonth) eq 0>
			<cfset loc.jobDaysOfMonth = day(arguments.start)/>
		</cfif>

		<!---
			if the event day is not on one of the days specified, delete it from the array (if occur_at_event is set to true)
		--->
		<cfif arguments.includeStart AND listFind(loc.jobDaysOfMonth, day(arguments.start)) eq 0>
			<cfset arrayDeleteAt(loc.return, 1)/>
		</cfif>

		<cfloop condition="#evaluate(loc.condition)#">
			<cfset loc.iterationDatetime = dateAdd("d", 1, loc.iterationDatetime)/>
			<!--- if 1st, increment the month --->
			<cfif day(loc.iterationDatetime) EQ 1>
				<cfset loc.month = loc.month + 1/>
			</cfif>
			<!--- append if its the right day of the month and is the right month (if applicable) --->
			<cfif loc.month MOD arguments.recurCycle EQ 0>
				<cfloop list="#loc.jobDaysOfMonth#" index="loc.i">
					<cfif loc.i eq day(loc.iterationDatetime)>
						<cfset arrayAppend(loc.return, loc.iterationDatetime)/>
						<!--- this was using the 30th (or daysinmonth) if 31st was specified, buy daysinmonth was less --->
						<!---
							<cfelseif loc.i gt DaysInMonth(loc.iterationDatetime) AND Day(loc.iterationDatetime) eq DaysInMonth(loc.iterationDatetime)>
							<cfset ArrayAppend(loc.return, CreateDate(Year(loc.iterationDatetime), Month(loc.iterationDatetime), DaysInMonth(loc.iterationDatetime))) />
						--->
					</cfif>
				</cfloop>
			</cfif>
			<cfset loc.loopBreaker = loc.loopBreaker + 1/>
			<cfif loc.loopBreaker eq 1825>
				<!--- 5 years --->
				<cfbreak/>
			</cfif>
		</cfloop>
    <cfelseif listFindNoCase("yearly,year,annual,annually", arguments.pattern) gt 0>

		<!--- if no monthOfYear OR dayOfMonthOfYear arguments present, use the day/month of the event --->
		<cfif len(arguments.monthOfYear) eq 0 OR len(arguments.dayOfMonth) eq 0>
			<cfset loc.jobMonthOfYear = month(arguments.start)/>
			<cfset loc.jobDayOfMonth = day(arguments.start)/>
		</cfif>

		<!--- remove the event date if its not the day/month requested --->
		<cfif loc.jobMonthOfYear eq month(arguments.start) AND loc.jobDayOfMonth eq day(arguments.start) AND arguments.includeStart>
			<cfelseif arrayLen(loc.return) gt 0>
			<cfset arrayDeleteAt(loc.return, 1)/>
		</cfif>

		<!---
			If a day of month falls on a day that does not exist in the month, the last day of the month will be substituted.
		--->
		<cfif loc.jobDayOfMonth GT daysInMonth(createDate(year(arguments.start), loc.jobMonthOfYear, 1))>
			<cfset loc.iterationDatetime = createDate(
				year(arguments.start),
				loc.jobMonthOfYear,
				daysInMonth(createDate(year(arguments.start), loc.jobMonthOfYear, 1))
			)/>
        <cfelse>
			<cfset loc.iterationDatetime = createDate(year(arguments.start), loc.jobMonthOfYear, loc.jobDayOfMonth)/>
		</cfif>

		<cfloop condition="#evaluate(loc.condition)#">
			<cfset loc.iterationDatetime = dateAdd("yyyy", 1, loc.iterationDatetime)/>
			<!--- append if is the right year --->
			<cfif loc.year MOD arguments.recurCycle EQ 0>
				<cfset arrayAppend(loc.return, loc.iterationDatetime)/>
			</cfif>
			<cfset loc.year = loc.year + 1/>
			<cfset loc.loopBreaker = loc.loopBreaker/>
			<cfif loc.loopBreaker eq 10>
				<!--- 10 years --->
				<cfbreak/>
			</cfif>
		</cfloop>
	</cfif>

	<cfreturn loc.return/>
</cffunction>
