<cfscript>
/**
* Deserialises a string if it is valid JSON, otherwise returns a fallback value
*
* [section: Application]
* [category: JSON]
*
*/
public any function deserialiseIfJSON(required string string, any default = false) {
	if (isJSON(arguments.string)) {
		return deserializeJSON(arguments.string);
	}
	return arguments.default;
}
</cfscript>
