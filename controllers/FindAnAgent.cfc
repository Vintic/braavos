component extends="Controller" output=false {

	/**
	 * CRUD
	 */

	public void function index() {
		suburbs = [];
		if (Len(getParam("suburbIdList")) || Len(getParam("agentKeyword"))) {
			local.where = [
			 	"isDraft = 0",
				"imageType = 'logo'"
			];
			if (Len(getParam("suburbIdList"))) {
				suburbs = model("Suburb").findAll(
					select = "id, suburbNameAndPostcode",
					where = splitQueryParamList(column = "id", list = params.suburbIdList)
				);
				local.whereOr = [];
				for (local.suburbId in params.suburbIdList) {
					local.whereOr.Append("officeRelatedSuburbs.suburbId = #local.suburbId#");
				}
				local.where.Append(whereify(local.whereOr, "or"));
			}
			if (Len(getParam("agentKeyword"))) {
				local.where.Append("findAnAgentName like '#params.agentKeyword#%'")
			}

			offices = model("Office").findAll(
				select = "id,officeName,findAnAgentName,addressLine1,addressLine2,suburbId,suburbName,postcode,state,fileName",
				where = whereify(local.where),
				include = "OfficeRelatedSuburbs,OfficeImages,Suburb",
				distinct = true
			);
			// TODO count of properties for each office
		}

	}

	public void function show() {


	}

}
