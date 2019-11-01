<cfcomponent output="false">
  
  <cffunction name="init" access="public" output="false" returntype="any">
    <cfargument name="faker" type="any" required="true" />
    <cfset this.faker = arguments.faker />
    <cfreturn this />
  </cffunction>

  <cfinclude template="includes/definitions.cfm" />
  <cfinclude template="includes/helpers.cfm" />

</cfcomponent>