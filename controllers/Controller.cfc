component extends="wheels.Controller" {

	function config() {
	}

	/**
	 * Confirms that the current request is being done via Ajax
	 *
	 * [section: Application]
	 * [category: Filters]
	 */
	private function isAjaxRequest() {
		if (!isAjax()) {
			WriteOutput("Invalid Request");
			abort;
		}
	}

	/**
	 * Filter to setup JSON responses
	 *
	 * [section: Application]
	 * [category:Filters]
	 */
	private void function setupJSONResponse() {
		header name="content-type", value = "text/json", charset = "utf-8";
		provides(formats = "json");
		params.format = "json";
		hideDebug();
	}

	/**
	 *	I provide a standardised wrapper to format a JSON response
	 *
	 * [section: Application]
	 * [category: Controller]
	 *
	 */
	public any function formatJSONResponse(struct data = {}, boolean success = true, array messages = []) {
		return renderWith(
			"data" = {
				"success" = isTrue(arguments.success) ? true : false,
				"messages" = arguments.messages,
				"data" = lowerCaseStructKeys(arguments.data)
			},
			hideDebugInformation = true
		);
	}

	/**
	 * Filter to force hiding of debug output
	 *
	 * [section: Application]
	 * [category:Filters]
	 */
	private void function hideDebug() {
		setting showdebugoutput=false;
	}

	/**
	 * Appends content to the document's <head> element. Only for use by base controllers.
	 *
	 * [section: Application]
	 * [category: Filter]
	 *
	 */
	private function writeToHtmlHead() {
		if (IsDefined("HTMLHead")) {
			cfhtmlhead(text="#HTMLHead#");
		}
	}

	/**
	 * Extends a request's timout value. Looks for a url param named requesttimeout otherwise defaults to 5 minutes
	 *
	 * [section: Application]
	 * [category: Filters]
	 *
	 */
	private void function extendRequestTimeout() {
		setting requestTimeout="#url.requesttimeout ?: 300#";
	}

}
