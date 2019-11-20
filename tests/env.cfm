<cfscript>
request.isWheelsTestFrameworkRunning = true;
request.tickCountStart = getTickCount();
if (isTrue(url.debug ?: false)) {
	setting showdebugoutput="true";
}
;
set(cacheQueriesDuringRequest = false);
set(functionName = "datePicker", head = false);
set(functionName = "datePickerTag", head = false);
set(functionName = "redirectTo", delay = true); // TODO: this will be done by wheels test runner. remove
loc = {};
loc.trustApiKey = "B9UfLzccrpg=";

try {
	application.newRelic.setRequest(transactionName = lCase(url.package ?: ""));
} catch (any e) {
}
mocker = new tests.mocker.Mocker();
</cfscript>
