<cfcomponent extends="base" output="false">

  <cffunction name="companyName" access="public" output="false" returntype="string">
    <cfargument name="format" type="numeric" required="false" default="0" />
    <cfscript>
      switch ((format) ? format : randomNumber(5))
      {
        case 1:
          return arrayRandomize(_lastName()) & "-" & arrayRandomize(_lastName());
          break;

        case 2:
          return arrayRandomize(_lastName()) & ", " & arrayRandomize(_lastName()) & " and " & arrayRandomize(_lastName());
          break;

        default:
          return arrayRandomize(_lastName()) & " " & companySuffix();
          break;
      }
    </cfscript>
  </cffunction>

  <cffunction name="companySuffix" access="public" output="false" returntype="string">
    <cfreturn arrayRandomize(["Inc.", "and Sons", "LLC", "Group", "and Daughters"]) />
  </cffunction>

  <cffunction name="catchPhrase" access="public" output="false" returntype="string">
    <cfreturn arrayRandomize(_catchPhraseAdjective()) & " " & arrayRandomize(_catchPhraseDescriptor()) & " " & arrayRandomize(_catchPhraseNoun()) />
  </cffunction>

  <cffunction name="bs" access="public" output="false" returntype="string">
    <cfreturn arrayRandomize(_bsAdjective()) & " " & arrayRandomize(_bsBuzz()) & " " & arrayRandomize(_bsNoun()) />
  </cffunction>
  
</cfcomponent>
