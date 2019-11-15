<cfcomponent output="false" mixin="model">

	<cffunction name="init" returntype="any" access="public" output="false">
		<cfset this.version = "1.1.7,1.1.8,1.4.3,2.0">
		<cfreturn this />
	</cffunction>

	<cffunction name="simplePropertiesVersion" returntype="string" access="public" output="false">
		<cfreturn "1.0.1" />
	</cffunction>

	<!--- return only object properties (and nested properties') that are simple values  --->
	<cffunction name="simpleProperties" returntype="struct" access="public" output="false" hint="Returns a structure of all the simple properties with their names as keys and the values of the property as values."
		examples=
		'
			<!--- Get a structure of all the simple properties for an object --->
			<cfset user = model("user").findByKey(1)>
			<cfset props = user.simpleProperties()>
		'
		categories="model-object,miscellaneous" chapters="" functions="setProperties">
		<cfscript>
			var loc = {};
			loc.returnValue = {};

			// loop through all properties and functions in the this scope
			for (loc.key in this)
			{
				// we return anything that is not a function
				if (!IsCustomFunction(this[loc.key]))
				{
					// try to get the property name from the list set on the object, this is just to avoid returning everything in ugly upper case which Adobe ColdFusion does by default
					if (ListFindNoCase(propertyNames(), loc.key))
						loc.key = ListGetAt(propertyNames(), ListFindNoCase(propertyNames(), loc.key));

					// if it's a nested property, apply this function recursively
					if (isObject(this[loc.key]))
					{
						loc.returnValue[loc.key] = this[loc.key].simpleProperties();
					}
					// loop thru the array and apply this function to each index
					else if (isArray(this[loc.key]))
					{
						loc.returnValue[loc.key] = [];
						for (loc.i=1; loc.i <= ArrayLen(this[loc.key]); loc.i++)
						{
							loc.returnValue[loc.key][loc.i] = this[loc.key][loc.i].simpleProperties();
						}
					}
					// set property from the this scope in the struct that we will return
					else
					{
						loc.returnValue[loc.key] = this[loc.key];
					}
				}
			}
		</cfscript>
		<cfreturn loc.returnValue>
	</cffunction>

	<cfscript>
	// short alias
	public struct function sp() {
		return this.simpleProperties();
	}
	</cfscript>

</cfcomponent>
