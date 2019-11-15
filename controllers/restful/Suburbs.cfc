component extends="Controller" output=false {

	public void function config() {
		super.config();
		provides("json");
		filters("$$setup");
		// filters("$$authoriseRequest");
	}

	private void function $$setup() {
		setting showdebugoutput="false";
		params.format = "json";
	}

	public any function index() {
		local.where = [];
		local.numberOfParameters = 0;
		if (Len(params.state)) {
			ArrayAppend(local.where, "state = '#params.state#'");
			local.numberOfParameters++;
		}
		if (Len(getParam("q", ""))) {
			if (Val(params.q)) {
				ArrayAppend(local.where, "postcode LIKE '#params.q#%'");
			} else {
				ArrayAppend(local.where, "suburbName LIKE '#params.q#%'");
			}
			local.numberOfParameters++;
		}

		local.arguments = {
			select = "id, suburbName, postcode, state, suburbNameAndPostcode, text",
			where = whereify(local.where),
			order = "suburbName",
			returnAs = "structs",
			parameterize = local.numberOfParameters
		};
		if (Val(getParam("maxrows", "100"))) {
			local.arguments.maxrows = params.maxrows;
		}
		var suburb = model("Suburb").findAll(argumentCollection = local.arguments);

		return renderText(formatAjaxResponse(success = true, data = suburb));
	}

}
