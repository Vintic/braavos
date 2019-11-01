<cfcomponent extends="base" output="false">

  <cffunction name="findName" access="public" output="false" returntype="string">
    <cfscript>
      switch (randomNumber(20))
      {
        case 1:
          return arrayRandomize(_namePrefix()) & " " & firstName() & " " & lastName() & " " & arrayRandomize(_nameSuffix());
          break;

        case 2:
          return firstName() & " " & lastName() & " " & arrayRandomize(_nameSuffix());
          break;

        case 3: case 4: case 5:
          return arrayRandomize(_namePrefix()) & " " & firstName() & " " & lastName();
          break;

        default:
          return firstName() & " " & lastName();
          break;
      }
    </cfscript>
  </cffunction>

  <cffunction name="firstName" access="public" output="false" returntype="string">
    <cfreturn arrayRandomize(_firstName()) />
  </cffunction>

  <cffunction name="lastName" access="public" output="false" returntype="string">
    <cfreturn arrayRandomize(_lastName()) />
  </cffunction>
  
</cfcomponent>
