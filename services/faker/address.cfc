<cfcomponent extends="base" output="false">

  <cffunction name="zipCode" access="public" output="false" returntype="string">
    <cfreturn replaceSymbolWithNumber(arrayRandomize(_zipCodeFormats())) />
  </cffunction>

  <cffunction name="zipCodeFormat" access="public" output="false" returntype="string">
    <cfargument name="format" type="numeric" required="false" default="1" />
    <cfreturn replaceSymbolWithNumber(_zipCodeFormats()[arguments.format]) />
  </cffunction>

  <cffunction name="postCode" access="public" output="false" returntype="string">
    <cfreturn replaceSymbolWithNumber("????") />
  </cffunction>

  <cffunction name="city" access="public" output="false" returntype="string">
    <cfscript>
      switch (randomNumber(4))
      {
        case 1:
          return arrayRandomize(_cityPrefix()) & " " & arrayRandomize(_firstName()) & arrayRandomize(_citySuffix());
          break;

        case 2:
          return arrayRandomize(_cityPrefix()) & " " & arrayRandomize(_firstName());
          break;

        case 3:
          return arrayRandomize(_firstName()) & arrayRandomize(_citySuffix());
          break;

        case 4:
          return arrayRandomize(_lastName()) & arrayRandomize(_citySuffix());
          break;
      }
    </cfscript>
  </cffunction>

  <cffunction name="streetAddress" access="public" output="false" returntype="string">
    <cfargument name="fullAddress" type="boolean" required="false" default="false" />
    <cfscript>
      var address = "";

      switch (randomNumber(3))
      {
        case 1:
          address = replaceSymbolWithNumber("?????") & " " & streetName();
          break;

        case 2:
          address = replaceSymbolWithNumber("????") & " " & streetName();
          break;

        case 3:
          address = replaceSymbolWithNumber("???") & " " & streetName();
          break;
      }

      address = (arguments.fullAddress) ? address & " " & secondaryAddress() : address;
    </cfscript>
    <cfreturn address />
  </cffunction>

  <cffunction name="streetName" access="public" output="false" returntype="string">
    <cfscript>
      switch (randomNumber(1))
      {
        case 1:
          return arrayRandomize(_lastName()) & " " & arrayRandomize(_streetSuffix());
          break;

        case 2:
          return arrayRandomize(_firstName()) & " " & arrayRandomize(_streetSuffix());
          break;
      }
    </cfscript>
  </cffunction>

  <cffunction name="secondaryAddress" access="public" output="false" returntype="string">
    <cfreturn replaceSymbolWithNumber(arrayRandomize(_secondaryAddressFormats())) />
  </cffunction>

  <cffunction name="usState" access="public" output="false" returntype="string">
    <cfargument name="abbr" type="boolean" required="false" default="false" />
    <cfreturn arrayRandomize(this[(arguments.abbr) ? "_usStateAbbr" : "_usState"]()) />
  </cffunction>

  <cffunction name="brState" access="public" output="false" returntype="string">
    <cfargument name="abbr" type="boolean" required="false" default="false" />
    <cfreturn arrayRandomize(this[(arguments.abbr) ? "_brStateAbbr" : "_brState"]()) />
  </cffunction>

  <cffunction name="ukCounty" access="public" output="false" returntype="string">
    <cfreturn arrayRandomize(_ukCounty()) />
  </cffunction>

  <cffunction name="ukCountry" access="public" output="false" returntype="string">
    <cfreturn arrayRandomize(_ukCountry()) />
  </cffunction>

  <cffunction name="auState" access="public" output="false" returntype="string">
    <cfargument name="abbr" type="boolean" required="false" default="false" />
    <cfreturn arrayRandomize(this[(arguments.abbr) ? "_auStateAbbr" : "_auState"]()) />
  </cffunction>

</cfcomponent>
