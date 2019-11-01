<cfcomponent extends="base" output="false">

  <cffunction name="words" access="public" output="false" returntype="array">
    <cfargument name="number" type="numeric" required="false" default="3" />
    <cfreturn arraySlice(shuffle(_lorem()), 1, arguments.number) />
  </cffunction>

  <cffunction name="sentence" access="public" output="false" returntype="string">
    <cfargument name="wordCount" type="numeric" required="false" default="3" />
    <cfreturn capitalize(arrayToList(words(arguments.wordCount + randomNumber(7)), " ")) & "." />
  </cffunction>

  <cffunction name="sentences" access="public" output="false" returntype="string">
    <cfargument name="sentenceCount" type="numeric" required="false" default="3" />
    <cfscript>
      var sentences = [];

      for (arguments.sentenceCount; arguments.sentenceCount gte 1; arguments.sentenceCount--)
        arrayAppend(sentences, sentence());
    </cfscript>
    <cfreturn arrayToList(sentences, " ") />
  </cffunction>

  <cffunction name="paragraph" access="public" output="false" returntype="string">
    <cfargument name="sentenceCount" type="numeric" required="false" default="3" />
    <cfreturn sentences(arguments.sentenceCount + randomNumber(3)) />
  </cffunction>

  <cffunction name="paragraphs" access="public" output="false" returntype="string">
    <cfargument name="paragraphCount" type="numeric" required="false" default="3" />
    <cfscript>
      var paragraphs = [];

      for (arguments.paragraphCount; arguments.paragraphCount gte 1; arguments.paragraphCount--)
        arrayAppend(paragraphs, paragraph());
    </cfscript>
    <cfreturn arrayToList(paragraphs, "#chr(13)##chr(10)##chr(9)#" ) />
  </cffunction>
  
</cfcomponent>
