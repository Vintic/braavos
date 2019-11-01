<cffunction name="httpRequest" output="false" hint="looks for http variables in cgi scope and reverse proxy headers">
	<cfset var loc = {returnValue = {}}>
	<cfset loc.headers = getHTTPRequestData().headers>
	<!--- host / server_name --->
	<cfset loc.returnValue.host = cgi.server_name>
	<cfset loc.returnValue.host = loc.headers["X-Host"] ?: loc.returnValue.host><!--- nginx --->
	<cfset loc.returnValue.host = loc.headers["X-Forwarded-Host"] ?: loc.returnValue.host><!--- apache --->
	<cfset loc.returnValue.server_name = loc.returnValue.host>
	<!--- port / server_port --->
	<cfset loc.returnValue.port = cgi.server_port>
	<cfset loc.returnValue.port = loc.headers["X-Server-Port"] ?: loc.returnValue.port><!--- nginx --->
	<cfset loc.returnValue.server_port = loc.returnValue.port>
	<!--- remote_addr / ip --->
	<cfset loc.returnValue.ip = cgi.remote_addr>
	<cfset loc.returnValue.ip = loc.headers["X-Real-IP"] ?: loc.returnValue.ip><!--- nginx --->
	<cfset loc.returnValue.ip = listFirst(loc.headers["X-Forwarded-For"] ?: loc.returnValue.ip)><!--- apache --->
	<cfset loc.returnValue.remote_addr = loc.returnValue.ip>
	<!--- uri / request_uri --->
	<cfset loc.returnValue.uri = cgi.request_url>
	<cfset loc.returnValue.uri = loc.headers["X-Request-URI"] ?: loc.returnValue.uri><!--- nginx --->
	<cfset loc.returnValue.request_uri = loc.returnValue.uri>
	<!--- TODO: referer --->

	<!--- more... --->
	<cfset loc.returnValue.user_agent = cgi.http_user_agent>
	<cfset loc.returnValue.path_info = cgi.path_info>
	<cfreturn loc.returnValue>
</cffunction>

<cfscript>
/*
  Based on code by Ben Nadel:
  http://www.bennadel.com/blog/154-ColdFusion-Session-Management-Revisited-User-vs-Spider-III.htm
*/
public boolean function isBot(string userAgent = "#cgi.http_user_agent#") 
	output=false
{
	// Real users have user-agent strings
	local.UserAgent = lCase(arguments.UserAgent);
	if (!len(local.UserAgent)) {
		return true;
	}
	/*
	  High-probability checks
	  If the user agent has bot or spider in it, it is a bot
	  Some specific high-volume spiders listed individually
	*/
	if (
		reFind("bot\b", local.UserAgent)
		 || find("spider", local.UserAgent)
		 || reFind("search\b", local.UserAgent)
		 || local.UserAgent == "cfschedule"
	) {
		return true;
	}
	// If we don't know yet, only figure spiders from a known list of a few
	if (
		reFind("\brss", local.UserAgent)
		 || find("slurp", local.UserAgent)
		 || find("xenu", local.UserAgent)
		 || find("mediapartners-google", local.UserAgent)
		 || find("zyborg", local.UserAgent)
		 || find("emonitor", local.UserAgent)
		 || find("jeeves", local.UserAgent)
		 || find("sbider", local.UserAgent)
		 || find("findlinks", local.UserAgent)
		 || find("yahooseeker", local.UserAgent)
		 || find("mmcrawler", local.UserAgent)
		 || find("jbrowser", local.UserAgent)
		 || find("java", local.UserAgent)
		 || find("pmafind", local.UserAgent)
		 || find("blogbeat", local.UserAgent)
		 || find("converacrawler", local.UserAgent)
		 || find("ocelli", local.UserAgent)
		 || find("labhoo", local.UserAgent)
		 || find("validator", local.UserAgent)
		 || find("sproose", local.UserAgent)
		 || find("ia_archiver", local.UserAgent)
		 || find("larbin", local.UserAgent)
		 || find("psycheclone", local.UserAgent)
		 || find("arachmo", local.UserAgent)
		 || find("google", local.UserAgent)
	) {
		return true;
	}
	if (local.UserAgent contains "Windows" || local.UserAgent contains "Macintosh" || local.UserAgent contains "Linux") {
		return false;
	}
	return false;
}

public string function currentURL(string url = cgi.request_url, boolean urlEncode = false) {
	local.rv = replaceNoCase(arguments.url, "/rewrite.cfm", "");
	if (arguments.urlEncode) {
		local.rv = encodeForURL(local.rv);
	}
	return local.rv;
}
</cfscript>

<cffunction name="getOS" output="false">
	<cfargument name="returnAs" type="string" required="false" default="string" hint="[string|struct]">
	<cfargument name="userAgent" type="string" required="false" default="#CGI.HTTP_USER_AGENT#">

	<cfset var loc = {}>
	<cfset loc.returnStruct = {os = "Unknown", version = "Unknown"}>

	<cfset loc.OSArray = []>
	<cfset loc.OSArray.append({regex = "windows nt 6.3", os = "Windows", version = "8.1"})>
	<cfset loc.OSArray.append({regex = "windows nt 6.2", os = "Windows", version = "8"})>
	<cfset loc.OSArray.append({regex = "windows nt 6.1", os = "Windows", version = "7"})>
	<cfset loc.OSArray.append({regex = "windows nt 6.0", os = "Windows", version = "Vista"})>
	<cfset loc.OSArray.append({regex = "windows nt 5.2", os = "Windows", version = "Server 2003/XP x64"})>
	<cfset loc.OSArray.append({regex = "windows nt 5.1", os = "Windows", version = "XP"})>
	<cfset loc.OSArray.append({regex = "windows xp/", os = "Windows", version = "XP"})>
	<cfset loc.OSArray.append({regex = "windows nt 5.0", os = "Windows", version = "2000"})>
	<cfset loc.OSArray.append({regex = "windows me", os = "Windows", version = "ME"})>
	<cfset loc.OSArray.append({regex = "win98", os = "Windows", version = "98"})>
	<cfset loc.OSArray.append({regex = "win95", os = "Windows", version = "95"})>
	<cfset loc.OSArray.append({regex = "win16", os = "Windows", version = "3.11"})>
	<cfset loc.OSArray.append({regex = "macintosh|mac os x", os = "Mac", version = "OSX"})>
	<cfset loc.OSArray.append({regex = "mac_powerpc", os = "Mac", version = "OS9"})>
	<cfset loc.OSArray.append({regex = "linux", os = "Linux", version = ""})>
	<cfset loc.OSArray.append({regex = "ubuntu", os = "Ubuntu", version = ""})>
	<cfset loc.OSArray.append({regex = "iphone", os = "iPhone", version = ""})>
	<cfset loc.OSArray.append({regex = "ipod", os = "iPod", version = ""})>
	<cfset loc.OSArray.append({regex = "ipad", os = "iPad", version = ""})>
	<cfset loc.OSArray.append({regex = "android", os = "Android", version = ""})>
	<cfset loc.OSArray.append({regex = "blackberry", os = "BlackBerry", version = ""})>
	<cfset loc.OSArray.append({regex = "webos", os = "Mobile", version = ""})>

	<cfloop array="#loc.OSArray#" index="loc.i">
		<cfif reFindNoCase(loc.i.regex, arguments.userAgent)>
			<cfset loc.returnStruct.os = loc.i.os>
			<cfset loc.returnStruct.version = loc.i.version>
			<cfbreaK>
		</cfif>
	</cfloop>

	<cfif arguments.returnAs == "string">
		<cfreturn trim(loc.returnStruct.os & " " & loc.returnStruct.version)>
    <cfelse>
		<cfreturn loc.returnStruct>
	</cfif>
</cffunction>

<cffunction name="getBrowser" output="false">
	<cfargument name="returnAs" type="string" required="false" default="string" hint="[string|struct]">
	<cfargument name="userAgent" type="string" required="false" default="#CGI.HTTP_USER_AGENT#">
	<cfscript>
	/**
	* Detects 130+ browsers.
	* v2 by Daniel Harvey, adds Flock/Chrome and Safari fix.
	* v5 fix by RCamden based on bug found by Jeff Mayer
	*
	* @param UserAgent      User agent string to parse. Defaults to cgi.http_user_agent. (Optional)
	* @return Returns a string.
	* @author John Bartlett (jbartlett@strangejourney.net)
	* @version 5, October 10, 2011
	*/
	// Default User Agent to the CGI browser string
	var UserAgent = arguments.userAgent;

	// Regex to parse out version numbers
	var VerNo = "/?v?_? ?v?[\(?]?([A-Z0-9]*\.){0,9}[A-Z0-9\-.]*(?=[^A-Z0-9])";

	// List of browser names
	var BrowserList = "";

	// Identified browser info
	var BrowserName = "";
	var BrowserVer = "";

	// Working variables
	var Browser = "";
	var tmp = "";
	var tmp2 = "";
	var x = 0;

	// Allow regex to match on EOL and instring
	UserAgent = UserAgent & " ";

	// Browser List (Allows regex - see BlackBerry for example)
	BrowserList = "1X|Amaya|Ubuntu APT-HTTP|AmigaVoyager|Android|Arachne|Amiga-AWeb|Arora|Bison|Bluefish|Browsex|Camino|Check&Get|Chimera|Chrome|Contiki|cURL|Democracy|" &
	"Dillo|DocZilla|edbrowse|ELinks|Emacs-W3|Epiphany|Galeon|Minefield|Firebird|Phoenix|Flock|IceApe|IceWeasel|IceCat|Gnuzilla|" &
	"Google|Google-Sitemaps|HTTPClient|HP Web PrintSmart|IBrowse|iCab|ICE Browser|Kazehakase|KKman|K-Meleon|Konqueror|Links|Lobo|Lynx|Mosaic|SeaMonkey|" &
	"muCommander|NetPositive|Navigator|NetSurf|OmniWeb|Acorn Browse|Oregano|Prism|retawq|Shiira Safari|Shiretoko|Sleipnir|Songbird|Strata|Sylera|" &
	"ThunderBrowse|W3CLineMode|WebCapture|WebTV|w3m|Wget|Xenu_Link_Sleuth|Oregano|xChaos_Arachne|WDG_Validator|W3C_Validator|" &
	"Jigsaw|PLAYSTATION 3|PlayStation Portable|IPD|" &
	"AvantGo|DoCoMo|UP.Browser|Vodafone|J-PHONE|PDXGW|ASTEL|EudoraWeb|Minimo|PLink|NetFront|Xiino|";
	// Mobile strings
	BrowserList = BrowserList & "iPhone|Vodafone|J-PHONE|DDIPocket|EudoraWeb|Minimo|PLink|Plucker|NetFront|PIE|Xiino|" &
	"Opera Mini|IEMobile|portalmmm|OpVer|MobileExplorer|Blazer|MobileExplorer|Opera Mobi|BlackBerry\d*[A-Za-z]?|" &
	"PPC|PalmOS|Smartphone|Netscape|Opera|Safari|Firefox|MSIE|HP iPAQ|LGE|MOT-[A-Z0-9\-]*|Nokia|";

	// No browser version given
	BrowserList = BrowserList & "AlphaServer|Charon|Fetch|Hv3|IIgs|Mothra|Netmath|OffByOne|pango-text|Avant Browser|midori|Smart Bro|Swiftfox";

	// Identify browser and version
	Browser = reMatchNoCase("(#BrowserList#)/?#VerNo#", UserAgent);

	if (arrayLen(Browser) GT 0) {
		if (arrayLen(Browser) GT 1) {
			// If multiple browsers detected, delete the common "spoofed" browsers
			if (Browser[1] EQ "MSIE 6.0" AND Browser[2] EQ "MSIE 7.0") arrayDeleteAt(Browser, 1);
			if (Browser[1] EQ "MSIE 7.0" AND Browser[2] EQ "MSIE 6.0") arrayDeleteAt(Browser, 2);
			tmp2 = Browser[arrayLen(Browser)];

			for (x = arrayLen(Browser); x GTE 1; x = x - 1) {
				tmp = reMatchNoCase("[A-Za-z0-9.]*", Browser[x]);
				if (listFindNoCase("Navigator,Netscape,Opera,Safari,Firefox,MSIE,PalmOS,PPC", tmp[1]) GT 0)
					arrayDeleteAt(Browser, x);
			}

			if (arrayLen(Browser) EQ 0) Browser[1] = tmp2;
		}

		// Seperate out browser name and version number
		tmp = reMatchNoCase("[A-Za-z0-9. _\-&]*", Browser[1]);

		Browser = tmp[1];

		if (arrayLen(tmp) EQ 2) BrowserVer = tmp[2];

		// Handle "Version" in browser string
		tmp = reMatchNoCase("Version/?#VerNo#", UserAgent);
		if (arrayLen(tmp) EQ 1) {
			tmp = reMatchNoCase("[A-Za-z0-9.]*", tmp[1]);
			// hack added by Camden to try better handle weird UAs
			if (arrayLen(tmp) eq 2) BrowserVer = tmp[2];
			else browserVer = tmp[1];
		}

		// Handle multiple BlackBerry browser strings
		if (left(Browser, 10) EQ "BlackBerry") Browser = "BlackBerry";

		// Return result
		if (arguments.returnAs == "struct") {
			return {browser = Browser, version = BrowserVer};
		} else {
			return Browser & " " & BrowserVer;
		}
	}
	// Unable to identify browser
	if (arguments.returnAs == "struct") {
		return {browser = "Unknown", version = "Unknown"};
	} else {
		return "Unknown";
	}
	</cfscript>
</cffunction>

<cffunction name="isMobile" returntype="boolean" output="false" hint="i check if the user_agent is a mobile browser">
	<cfargument name="http_user_agent" type="string" required="false" default="#CGI.HTTP_USER_AGENT#">
	<cfreturn reFindNoCase(
		"(android|bb\d+|meego).+mobile|avantgo|bada\/|blackberry|blazer|compal|elaine|fennec|hiptop|iemobile|ip(hone|od)|iris|kindle|lge |maemo|midp|mmp|mobile.+firefox|netfront|opera m(ob|in)i|palm( os)?|phone|p(ixi|re)\/|plucker|pocket|psp|series(4|6)0|symbian|treo|up\.(browser|link)|vodafone|wap|windows ce|xda|xiino|android|ipad|playbook|silk",
		arguments.http_user_agent
	) GT 0 OR reFindNoCase(
		"1207|6310|6590|3gso|4thp|50[1-6]i|770s|802s|a wa|abac|ac(er|oo|s\-)|ai(ko|rn)|al(av|ca|co)|amoi|an(ex|ny|yw)|aptu|ar(ch|go)|as(te|us)|attw|au(di|\-m|r |s )|avan|be(ck|ll|nq)|bi(lb|rd)|bl(ac|az)|br(e|v)w|bumb|bw\-(n|u)|c55\/|capi|ccwa|cdm\-|cell|chtm|cldc|cmd\-|co(mp|nd)|craw|da(it|ll|ng)|dbte|dc\-s|devi|dica|dmob|do(c|p)o|ds(12|\-d)|el(49|ai)|em(l2|ul)|er(ic|k0)|esl8|ez([4-7]0|os|wa|ze)|fetc|fly(\-|_)|g1 u|g560|gene|gf\-5|g\-mo|go(\.w|od)|gr(ad|un)|haie|hcit|hd\-(m|p|t)|hei\-|hi(pt|ta)|hp( i|ip)|hs\-c|ht(c(\-| |_|a|g|p|s|t)|tp)|hu(aw|tc)|i\-(20|go|ma)|i230|iac( |\-|\/)|ibro|idea|ig01|ikom|im1k|inno|ipaq|iris|ja(t|v)a|jbro|jemu|jigs|kddi|keji|kgt( |\/)|klon|kpt |kwc\-|kyo(c|k)|le(no|xi)|lg( g|\/(k|l|u)|50|54|\-[a-w])|libw|lynx|m1\-w|m3ga|m50\/|ma(te|ui|xo)|mc(01|21|ca)|m\-cr|me(rc|ri)|mi(o8|oa|ts)|mmef|mo(01|02|bi|de|do|t(\-| |o|v)|zz)|mt(50|p1|v )|mwbp|mywa|n10[0-2]|n20[2-3]|n30(0|2)|n50(0|2|5)|n7(0(0|1)|10)|ne((c|m)\-|on|tf|wf|wg|wt)|nok(6|i)|nzph|o2im|op(ti|wv)|oran|owg1|p800|pan(a|d|t)|pdxg|pg(13|\-([1-8]|c))|phil|pire|pl(ay|uc)|pn\-2|po(ck|rt|se)|prox|psio|pt\-g|qa\-a|qc(07|12|21|32|60|\-[2-7]|i\-)|qtek|r380|r600|raks|rim9|ro(ve|zo)|s55\/|sa(ge|ma|mm|ms|ny|va)|sc(01|h\-|oo|p\-)|sdk\/|se(c(\-|0|1)|47|mc|nd|ri)|sgh\-|shar|sie(\-|m)|sk\-0|sl(45|id)|sm(al|ar|b3|it|t5)|so(ft|ny)|sp(01|h\-|v\-|v )|sy(01|mb)|t2(18|50)|t6(00|10|18)|ta(gt|lk)|tcl\-|tdg\-|tel(i|m)|tim\-|t\-mo|to(pl|sh)|ts(70|m\-|m3|m5)|tx\-9|up(\.b|g1|si)|utst|v400|v750|veri|vi(rg|te)|vk(40|5[0-3]|\-v)|vm40|voda|vulc|vx(52|53|60|61|70|80|81|83|85|98)|w3c(\-| )|webc|whit|wi(g |nc|nw)|wmlb|wonu|x700|yas\-|your|zeto|zte\-",
		left(arguments.http_user_agent, 4)
	) GT 0>
</cffunction>

<cffunction name="extractHTTPHeader" access="public" output="false">
	<cfargument name="name" type="string" required="true">
	<cfset var loc = {}>
	<cfset loc.headers = getHTTPRequestData().headers>
	<cfreturn structKeyExists(loc.headers, arguments.name) ? loc.headers[arguments.name] : "">
</cffunction>

<cfscript>
/**
* Respond with a http header status and message/s
*/
public any function respondWithHeader(required numeric statusCode, required string statusText, required string text) {
	header statuscode="#arguments.statusCode#" statustext="#arguments.statusText#";
	renderText("<h1>#arguments.text#</h1>");
}

public any function protocol(string server_port_secure = cgi.SERVER_PORT_SECURE) {
	return isTrue(arguments.server_port_secure) ? "https" : "http";
}

/**
* Extracts a variable from a querystring
*/
public string function getParamFromQueryString(required string querystring, required string name) {
	var loc = {};
	loc.queryString = trim(arguments.querystring);

	loc.found = reFindNoCase(
		"(^|[\?|&])#name#=([^\&]*)",
		loc.queryString,
		1,
		"true"
	);

	if (arrayLen(loc.found.pos) gte 3) {
		if (loc.found.pos[3] GT 0) {
			return urlDecode(mid(loc.queryString, loc.found.pos[3], loc.found.len[3]));
		}
	}
	return "";
}

/**
* Changes a var in a query string. It is added if not exists
*
* @name 	 			The name of the name/value pair you want to modify. (Required)
* @value  	 		The new value for the name/value pair you want to modify. (Required)
* @querystring Query string to modify. Defaults to CGI.QUERY_STRING. (Optional)
*/
public string function changeQueryStringValue(
	required string name,
	required string value,
	string queryString = cgi.query_string
) {
	local.returnValue = "";
	local.variableExistsInQueryString = false;
	local.nameValuePairs = listToArray(arguments.queryString, "&");

	for (local.pair in local.nameValuePairs) {
		local.variableName = listFirst(local.pair, "=");
		// if this is the var, edit it to the value, otherwise, just append
		if (local.variableName == arguments.name) {
			local.returnValue = listAppend(local.returnValue, local.variableName & "=" & arguments.value, "&");
			local.variableExistsInQueryString = true;
		} else {
			local.returnValue = listAppend(local.returnValue, urlDecode(local.pair), "&");
		}
	}

	if (!variableExistsInQueryString) {
		local.returnValue = listAppend(local.returnValue, arguments.name & "=" & arguments.value, "&");
	}

	return local.returnValue;
}

public any function pingUrl(required string url) {
	var returnValue = new http(
		method = "get",
		url = arguments.url,
		timeout = 1,
		throwonerror = false
	).send();
	return local.returnValue;
}

public any function forceURLToHTTP(required string url) {
	return reReplaceNoCase(arguments.url, "^https", "http");
}

public any function forceURLToHTTPS(required string url) {
	return reReplaceNoCase(arguments.url, "^http://", "https://");
}
</cfscript>
