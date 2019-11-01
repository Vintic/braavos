<cfscript>
/**
 *	Returns true if any elements from array1 are contained in array2
 *
 * [section: Application]
 * [category: Array Functions]
 *
 */
public boolean function arraysShareValues(required array array1, required array array2) {
	for (local.i in arguments.array1) {
		if (ArrayFindNoCase(arguments.array2, local.i)) {
			return true;
		}
	}
	return false;
}
</cfscript>
