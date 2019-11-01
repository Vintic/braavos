<cfcomponent extends="base" output="false">

  <cffunction name="creditCardNumber" access="public" output="false" returntype="string">
    <cfargument name="type" type="string" required="false" default="" hint="Can be 'visa', 'mastercard', 'amex', 'discover', 'diners', 'enroute', 'jcb', 'jcbFifteen', or  'voyager'." />
    <cfargument name="format" type="boolean" required="false" default="false" />
    <cfscript>
      var loc = {};

      arguments.type = (len(arguments.type)) ? arguments.type : arrayRandomize(_creditCardTypes());

      if (!arrayFindNoCase(_creditCardTypes(), arguments.type))
        throw "credit card type not found.";

      loc.ccData = _creditCardData()[arguments.type];

      loc.ccnumber = _generateCreditCard(arrayRandomize(loc.ccData.prefixes), arrayRandomize(loc.ccData.lengths))

      if (arguments.format)
        return _formatCreditCard(loc.ccnumber);
    </cfscript>
    <cfreturn loc.ccnumber />
  </cffunction>

  <cffunction name="nameForCardNumber" access="public" output="false" returntype="string">
    <cfargument name="ccnumber" type="string" required="true" />
    <cfscript>
      var loc = {};

      arguments.ccnumber = reReplace(arguments.ccnumber, "[^0-9]+", "", "all");

      for (loc.item in _creditCardData())
        for (loc.prefix in _creditCardData()[loc.item].prefixes)
          if (reFind("^#loc.prefix#", arguments.ccnumber))
            return _creditCardData()[loc.item].name;

      throw "invalid credit card number";
    </cfscript>
  </cffunction>

  <cffunction name="expirationDate" access="public" output="false" returntype="string">
    <cfreturn createDate(randRange(year(now()) + 1, year(now()) + 4, "SHA1PRNG"), randRange(1, 12, "SHA1PRNG"), 1) />
  </cffunction>

  <cffunction name="cvvCode" access="public" output="false" returntype="string">
    <cfreturn replaceSymbolWithNumber(arrayRandomize(["???", "????"])) />
  </cffunction>

  <cffunction name="_formatCreditCard" access="private" output="false" returntype="string">
    <cfargument name="ccnumber" type="string" required="true" />
    <cfscript>
      var loc = { length = len(arguments.ccnumber), pos = 1, fPos = 1, string = "" };

      if (loc.length < 12 or loc.length > 17)
        throw "invalid lengh of the credit card number";

      loc.format = _creditCardFormats()[loc.length];

      while (loc.pos lte loc.length)
      {
        if (mid(loc.format, loc.fPos, 1) == "?")
        {
          loc.string &= mid(arguments.ccnumber, loc.pos, 1);
          loc.pos++;
        }
        else
        {
          loc.string &= mid(loc.format, loc.fPos, 1);
        }
        
        loc.fPos++;
      }
    </cfscript>
    <cfreturn loc.string />
  </cffunction>

  <cffunction name="_generateCreditCard" access="private" output="false" returntype="string">
    <cfargument name="prefix" type="string" required="true" />
    <cfargument name="length" type="numeric" required="true" />
    <cfscript>
      var loc = { pos = 1, sum = 0, odd = 0 };

      loc.ccnumber = arguments.prefix;

      // generate the card number except for the checkdigit
      while (len(loc.ccnumber) lt (arguments.length - 1))
        loc.ccnumber &= randRange(0, 9, "SHA1PRNG");

      loc.reverse = [];

      // reverse the ccnumber into the array
      for (loc.i = len(loc.ccnumber); loc.i gte 1; loc.i--)
        loc.reverse[len(loc.ccnumber) - loc.i + 1] = mid(loc.ccnumber, loc.i, 1);

      // get the sum of the generated number
      while (loc.pos lt arguments.length)
      {
        loc.odd = loc.reverse[loc.pos] * 2;

        if (loc.odd > 9)
          loc.odd -= 9;

        loc.sum += loc.odd;

        if (loc.pos != (arguments.length - 1))
          loc.sum += loc.reverse[loc.pos + 1];

        loc.pos += 2;
      }

      loc.checkdigit = ((fix(loc.sum / 10) + 1) * 10 - loc.sum) % 10;
      loc.ccnumber &= loc.checkdigit;
    </cfscript>
    <cfreturn loc.ccnumber />
  </cffunction>

</cfcomponent>
