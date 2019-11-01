<cfscript>
// app settings
set(appName = "Braavos");
set(appKey = lCase(get("appName")));
set(domain = "developerrealestateview.com.au");
set(URLRewriting = "On");
set(ipExceptions = "127.0.0.1,43.247.127.186"); // bypass onmaintenance.cfm when in maintence mode (for deploying & dbmigrate)
set(flashStorage = "cookie");
set(approvedIPAddresses = ["202.161.73.158"]); // the office ip address;
set(braavosHost = cgi.server_name);
set(crunchHost = cgi.server_name);
set(reloadPassword = "braavos");
// migrator settings
set(autoMigrateDatabase = true);
set(allowexplicittimestamps = true);
// email settings
set(fromEmailAddress = "#get("appName")# <no-reply@#get("domain")#>");
set(revEmailAddress = "contactus@realestateview.com.au");
set(errorEmailAddress = "developers@developerrealestateview.com.au");
set(errorEmailSubject = "#get("appName")# error occured");
set(defaultEmailLayout = "/email/layouts/braavos");
set(sendEmailOnError = false);
set(useExpandedColumnAliases = false);
// // don't cache (TBA)
set(cacheActions = false);
set(cachePages = false);
set(cachePartials = false);
set(cacheQueries = false);
set(assetQueryString = false);
// plugin settings. plugins will be deployed unpacked
set(overwritePlugins = false);
set(deletePluginDirectories = false);
// csrf
set(csrfStore = "cookie");
set(csrfCookieEncryptionSecretKey = env("CSRF_KEY"));
// encoding.. // these should be true at some point
set(encodeURLs = false);
set(encodeHtmlTags = false);
set(encodeHtmlAttributes = false);

timeselect = [];
// start from 5:00am
loop from="5" to="11" index="idx" {
	loop list="00,05,10,15,20,25,30,35,40,45,50,55" index="idy" {
		timeselect.append("#idx#:#idy#am");
	}
}
timeselectNoon = [
	"12:00pm",
	"12:05pm",
	"12:10pm",
	"12:15pm",
	"12:20pm",
	"12:25pm",
	"12:30pm",
	"12:35pm",
	"12:40pm",
	"12:45pm",
	"12:50pm",
	"12:55pm"
];
timeselect = arrayMerge(timeselect, timeselectNoon);
loop from="1" to="10" index="idx" {
	// ends/last appointment 10:45am
	loop list="00,05,10,15,20,25,30,35,40,45,50,55" index="idy" {
		timeselect.append("#idx#:#idy#pm");
	}
}
set(timeselect = timeselect);
set(contactTitleSelect = "Mr,Mrs,Ms,Miss,Dr");
set(
	streetTypes = "Avenue,Court,Corner,Drive,Place,Road,Street,Alley,Arcade,Bend,Boulevard,Chase,Circle,Circuit,Close,Concourse,Crescent,Dale,Entrance,Esplanade,Freeway,Gardens,Glade,Glen,Grove,Heights,Highway,Hill,Key,Lane,Loop,Mall,Mews,Parade,Promenade,Quay,Quays,Retreat,Rise,Row,Square,Terrace,Track,Trail,Walk,Way,Wynd"
);

set(
	landMeasurements = [
		{value = "acre", text = "Acres"},
		{value = "squareMeter", text = "Square Metres"},
		{value = "hectare", text = "Hectares"}
	]
);

set(yesNoSelectOptions = [{value = true, text = "Yes"}, {value = false, text = "No"}]);
// Elasticsearch
set(useGNAF = true);
set(gnafElasticsearch = "https://search-gnaf20181102-nf3uum6zzyk4evft42qgi3w7za.ap-southeast-2.es.amazonaws.com:443/");
set(gnafAddressIndex = "gnaf");

set(assetsCDN = "https://assets.westeros.com.au/");
set(flashAppend = false);
set(excludeFromErrorEmail = "password,passwordConfirmation,passwordHash,passwordResetToken");
// TODO: exclude environment variable values

// =====================================================================
// = 	Bootstrap 4 form settings
// =====================================================================
// Submit Tag
set(functionName = "submitTag", class = "btn btn-primary", value = "Save Changes");

// Checkboxes and Radio Buttons
set(
	functionName = "hasManyCheckBox,checkBox,checkBoxTag",
	labelPlacement = "aroundRight",
	uncheckedValue = "0",
	encode = "attributes",
	class = "rev__check"
);
set(
	functionName = "radioButton,radioButtonTag",
	labelPlacement = "aroundRight",
	class="rev__radio"
);

// Text/select/password/file Fields
set(
	functionName = "textField,textFieldTag,select,selectTag,passwordField,passwordFieldTag,textArea,textAreaTag,fileFieldTag,fileField",
	labelPlacement = "before",
	encode = "attributes"
);
// prependToLabel="<div class='form-group'>",
// prepend="<div class=''>",
// append="</div></div>",
// class="form-control",
// labelClass="control-label",

// Date Pickers
set(
	functionName = "dateTimeSelect,dateSelect",
	prepend = "<div class='form-group'>",
	append = "</div>",
	timeSeparator = "",
	minuteStep = "5",
	secondStep = "10",
	dateOrder = "day,month,year",
	dateSeparator = "",
	separator = ""
);

// Pagination
set(
	functionName = "paginationLinks",
	prepend = '<div class="rev__border-top rev__pad-lg-v rev__width-100 rev__bg-white rev__pos _fixed _bottom"><div class="rev__container"><div class="rev__pagination">',
	append = '</div></div></div>',
	prependToPage = "",
	appendToPage = "",
	linkToCurrentPage = true,
	classForCurrent = "rev__btn-reverse-sm",
	class = "rev__btn-sm",
	anchorDivider = "<span class='rev__btn-sm-disabled'>...</span>",
	encode = "attributes"
);

// Error Messagss
set(functionName = "errorMessagesFor", class = "alert alert-dismissable alert-danger");
set(functionName = "errorMessageOn", wrapperElement = "div", class = "alert alert-danger");

// function defaults
set(functionName = "startFormTag", autocomplete="off");
set(functionName = "sendEmail", from = get("fromEmailAddress")); // , layout=get("defaultEmailLayout")
set(functionName = "findAll", perPage = 20);
set(functionName = "datePicker", dateFormat = "dd/mm/yy", head = true);
set(functionName = "datePickerTag", dateFormat = "dd/mm/yy", head = true);
set(functionName = "select", includeBlank = "-- Please select --");
set(functionName = "selectTag", includeBlank = "-- Please select --");

// include stage specific config
try {
	include template="settings/#get("stage")#.cfm";
} catch (MissingInclude e) {
	throw(type = "Application", message = "Invalid stage '#get("stage")#'");
}
</cfscript>
