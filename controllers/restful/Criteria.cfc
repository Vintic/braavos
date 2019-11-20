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

	public any function update() {
		local.rsp = {data = {}, messages = [], success = false};
		local.where = [
			"id = #params.key#",
			"contactId = #params.contactId#"
		];
		local.numberOfParameters = 2;
		local.criteria = model("Criteria").findOne(
			where = whereify(local.where),
			parameterize = local.numberOfParameters
		);
		if (IsObject(local.criteria)) {
			if (Len(getParam("sendFrequency"))) {
				local.criteria.sendFrequency = params.sendFrequency;
			}
			if (local.criteria.update()) {
				local.rsp.success = true;

				local.rsp.messages.append(["Criteria has been updated.", "success"]);
				local.rsp.data.id = criteria.key();
			} else {
				if (!local.criteria.valid()) {
					local.rsp.messages.append(errorMessageArray(local.criteria.allErrors()));
				} else {
					local.rsp.messages.append([
						"There was a problem updating the criteria.",
						"error"
					]);
				}
			}
		} else {
			local.rsp.messages.append(["Criteria #params.key# was not found", "error"]);
		}
		return renderText(formatAjaxResponse(argumentCollection = local.rsp));

	}

}
