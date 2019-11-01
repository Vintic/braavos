<cfcomponent extends="base" output="false">

  <cffunction name="phoneNumber" access="public" output="false" returntype="string">
    <cfreturn replaceSymbolWithNumber(arrayRandomize(_phoneFormats())) />
  </cffunction>

  <cffunction name="mobilePhoneNumber" access="public" output="false" returntype="string">
    <cfreturn replaceSymbolWithNumber("04?? ??? ???") />
  </cffunction>

  <cffunction name="phoneNumberFormat" access="public" output="false" returntype="string">
    <cfargument name="format" type="numeric" required="false" default="1" />
    <cfreturn replaceSymbolWithNumber(_phoneFormats()[arguments.format]) />
  </cffunction>

</cfcomponent>
