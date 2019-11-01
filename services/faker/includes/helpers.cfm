<cffunction name="randomNumber" access="public" output="false" returntype="numeric">
  <cfargument name="end" type="numeric" required="false" default="100000" />
  <cfreturn randRange(1, arguments.end, "SHA1PRNG") />
</cffunction>

<cffunction name="arrayRandomize" access="public" output="false" returntype="any">
  <cfargument name="array" type="array" required="true" />
  <cfscript>
    var item = ceiling(rand("SHA1PRNG") * arrayLen(arguments.array));
  </cfscript>
  <cfreturn arguments.array[item] />
</cffunction>

<cffunction name="replaceSymbolWithNumber" access="public" output="false" returntype="string">
  <cfargument name="string" type="string" required="true" />
  <cfargument name="symbol" type="string" required="false" default="?" />
  <cfscript>
    var loc = { string = "" };

    for (loc.i = 1; loc.i lte len(arguments.string); loc.i++)
    {
      if (mid(arguments.string, loc.i, 1) == arguments.symbol)
        loc.string &= randRange(0, 9, "SHA1PRNG");
      else
        loc.string &= mid(arguments.string, loc.i, 1);
    }
  </cfscript>
  <cfreturn loc.string />
</cffunction>

<cffunction name="shuffle" access="public" output="false" returntype="array">
  <cfargument name="array" type="array" required="true" />
  <cfset CreateObject("java", "java.util.Collections").Shuffle(arguments.array) />
  <cfreturn arguments.array />
</cffunction>

<cffunction name="token" access="public" output="false" returntype="string">
  <cfargument name="length" type="numeric" required="false" default="32" />
  <cfscript>
    var loc = { string = "" };

    for (loc.i = 1; loc.i lte arguments.length; loc.i++)
    {
      loc.random = ceiling(rand("SHA1PRNG") * arrayLen(_tokens()));
      loc.string &= _tokens()[loc.random]; 
    }
  </cfscript>
  <cfreturn loc.string />
</cffunction>

<cffunction name="generate" access="public" output="false" returntype="string">
  <cfargument name="length" type="numeric" required="false" default="32" />
  <cfscript>
    var loc = { string = "" };

    for (loc.i = 1; loc.i lte arguments.length; loc.i++)
    {
      loc.random = ceiling(rand("SHA1PRNG") * arrayLen(_chars()));
      loc.string &= _chars()[loc.random]; 
    }
  </cfscript>
  <cfreturn loc.string />
</cffunction>

<cffunction name="capitalize" access="public" output="false" returntype="string">
  <cfargument name="text" type="string" required="true" />
  <cfif !Len(arguments.text)>
    <cfreturn arguments.text />
  </cfif>
  <cfreturn UCase(Left(arguments.text, 1)) & Mid(arguments.text, 2, Len(arguments.text)-1) />
</cffunction>

<cffunction name="createCard" access="public" output="false" returntype="struct">
  <cfreturn {
      "name" = faker.name.findName()
    , "username" = faker.internet.userName()
    , "email" = faker.internet.email()
    , "address" = {
        "streetA" = faker.address.streetName()
      , "streetB" = faker.address.streetAddress()
      , "streetC" = faker.address.streetAddress(true)
      , "streetD" = faker.address.secondaryAddress()
      , "city" = faker.address.city()
      , "ukCounty" = faker.address.ukCounty()
      , "ukCountry" = faker.address.ukCountry()
      , "zipcode" = faker.address.zipCode()
      , "zipcodeFormat" = faker.address.zipCodeFormat(2)
      , "usState" = faker.address.usState()
      , "usStateAbbr" = faker.address.usState(true)
      , "brState" = faker.address.brState()
      , "brStateAbbr" = faker.address.brState(true)
    }
    , "phone" = faker.phonenumber.phonenumber()
    , "website" = faker.internet.domainName()
    , "ipaddress" = faker.internet.ipaddress()
    , "token" = faker.token()
    , "token10" = faker.token(10)
    , "password" = faker.generate(9)
    , "number" = faker.randomNumber(1000)
    , "company" = {
        "name" = faker.company.companyName()
      , "catchPhrase" = faker.company.catchPhrase()
      , "bs" = faker.company.bs()
    }
    , "creditcard" = {
        "ccnumber" = faker.creditcard.creditCardNumber()
      , "ccnumberFormat" = faker.creditcard.creditCardNumber(format=true)
      , "expDate" = faker.creditcard.expirationDate()
      , "cvvCode" = faker.creditcard.cvvCode()
      , "visa" = faker.creditcard.creditCardNumber("visa")
      , "visaFormat" = faker.creditcard.creditCardNumber("visa", true)
      , "mastercard" = faker.creditcard.creditCardNumber("mastercard")
      , "mastercardFormat" = faker.creditcard.creditCardNumber("mastercard", true)
      , "amex" = faker.creditcard.creditCardNumber("amex")
      , "amexFormat" = faker.creditcard.creditCardNumber("amex", true)
      , "diners" = faker.creditcard.creditCardNumber("diners")
      , "dinersFormat" = faker.creditcard.creditCardNumber("diners", true)
      , "discover" = faker.creditcard.creditCardNumber("discover")
      , "discoverFormat" = faker.creditcard.creditCardNumber("discover", true)
      , "enroute" = faker.creditcard.creditCardNumber("enroute")
      , "enrouteFormat" = faker.creditcard.creditCardNumber("enroute", true)
      , "jcb" = faker.creditcard.creditCardNumber("jcb")
      , "jcbFormat" = faker.creditcard.creditCardNumber("jcb", true)
      , "jcbfifteen" = faker.creditcard.creditCardNumber("jcbfifteen")
      , "jcbfifteenFormat" = faker.creditcard.creditCardNumber("jcbfifteen", true)
      , "name" = faker.creditcard.nameForCardNumber(faker.creditcard.creditCardNumber())
    }
    , "posts" = [
      {
          "words" = faker.lorem.words()
        , "sentence" = faker.lorem.sentence()
        , "sentences" = faker.lorem.sentences()
        , "paragraph" = faker.lorem.paragraph()
        , "paragraphs" = faker.lorem.paragraphs()
      }
      , {
          "words" = faker.lorem.words()
        , "sentence" = faker.lorem.sentence()
        , "sentences" = faker.lorem.sentences()
        , "paragraph" = faker.lorem.paragraph()
        , "paragraphs" = faker.lorem.paragraphs()
      }
      , {
          "words" = faker.lorem.words()
        , "sentence" = faker.lorem.sentence()
        , "sentences" = faker.lorem.sentences()
        , "paragraph" = faker.lorem.paragraph()
        , "paragraphs" = faker.lorem.paragraphs()
      }
    ]
  } />
</cffunction>