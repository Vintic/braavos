<cfscript>
public boolean function isTrue(required string value) {
	return listFindNoCase("1,true,yes,y", trim(arguments.value)) gt 0 ? 1 : 0;
}

public boolean function isFalse(required string value) {
	if (listFindNoCase("0,false,no,n", trim(arguments.value)) gt 0) {
		return 1;
	} else if (isTrue(arguments.value)) {
		return 0;
	}
	return !isBoolean(arguments.value) ? 1 : 0;
}

public boolean function oneOrZero(value) {
	return isTrue(arguments.value) ? 1 : 0;
}

public boolean function toggleBoolean(required boolean value) {
	return arguments.value ? 0 : 1;
}

public boolean function formatBoolean(required any value) {
	return isTrue(arguments.value) ? true : false;
}
</cfscript>
