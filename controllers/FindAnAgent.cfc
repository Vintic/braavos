component extends="Controller" output=false {

	/**
	 * CRUD
	 */

	public void function index() {
		suburbs = [];
		if (Len(getParam("suburbIdList")) || Len(getParam("agentKeyword"))) {
			local.where = [
			 	"isDraft = 0",
				"imageType = 'logo'",
				"type = 'findAnAgent'"
			];
			local.numberOfParameters = 3;
			if (Len(getParam("suburbIdList"))) {
				suburbs = model("Suburb").findAll(
					select = "id, suburbNameAndPostcode",
					where = splitQueryParamList(column = "id", list = params.suburbIdList)
				);
				local.whereOr = [];
				for (local.suburbId in params.suburbIdList) {
					local.whereOr.Append("officeRelatedSuburbs.suburbId = #local.suburbId#");
					local.numberOfParameters ++;
				}
				local.where.Append(whereify(local.whereOr, "or"));
			}
			if (Len(getParam("agentKeyword"))) {
				local.where.Append("findAnAgentName like '#params.agentKeyword#%'")
				local.numberOfParameters ++;
			}

			offices = model("Office").findAll(
				select = "id,officeName,findAnAgentName,addressLine1,addressLine2,suburbId,suburbName,postcode,state,fileName",
				where = whereify(local.where),
				include = "OfficeRelatedSuburbs,OfficeImages,Suburb",
				distinct = true,
				parametized = local.numberOfParameters
			);
			// TODO count of properties for each office
		}

	}

	public void function show() {
		office = model("Office").findOne(
			select = "id,officeName,findAnAgentName,addressLine1,addressLine2,suburbId,suburbName,postcode,state,phone,profile,website,facebook",
			where = "id = #params.key#",
			include = "Suburb",
			parametized = 1
		);
		local.images = model("OfficeImage").findAll(
			select = "id,fileName,imageType,sequence",
			where = "officeId = #params.key#",
			parametized = 1
		);
		officeLogos = local.images.filter(function(i) {
			return i.imageType == "logo";
		});
		findAnImage = local.images.filter(function(i) {
			return i.imageType == "findAnAgent";
		});
		officeListingTypes = model("OfficeListingType").findAll(
			select = "listingCategory,name",
			where = "officeId = #params.key#",
			include = "ListingType",
			order = "listingCategory DESC, id",
			parametized = 1
		);
		officeSpecialtyPropertyTypes = model("OfficeSpecialtyPropertyType").findAll(
			select = "listingCategory,name",
			where = "officeId = #params.key#",
			include = "SpecialtyPropertyType",
			order = "listingCategory DESC, id",
			parametized = 1
		);
		local.agentWhere = [
			"isWebHidden = 0",
			"officeId = #params.key#"
		];
		agents = model("Agent").findAll(
			select = "id,agentName,position,fileName",
			where = whereify(local.agentWhere),
			include = "AgentOffices,Images",
			parametized = 2
		)
	}

}
