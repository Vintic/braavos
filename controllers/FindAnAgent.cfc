component extends="Controller" output=false {

	/**
	 * CRUD
	 */

	public void function index() {
		suburbs = [];
		if (Len(getParam("suburbIdList")) || Len(getParam("agentKeyword"))) {
			local.where = ["isDraft = 0", "imageType = 'logo'", "type = 'findAnAgent'"];
			local.numberOfParameters = 3;
			if (Len(getParam("suburbIdList"))) {
				suburbs = model("Suburb").findAll(
					select = "id, suburbNameAndPostcode",
					where = splitQueryParamList(column = "id", list = params.suburbIdList)
				);
				local.whereOr = [];
				for (local.suburbId in params.suburbIdList) {
					local.whereOr.Append("officeRelatedSuburbs.suburbId = #local.suburbId#");
					local.numberOfParameters++;
				}
				local.where.Append(whereify(local.whereOr, "or"));
			}
			if (Len(getParam("agentKeyword"))) {
				local.where.Append("findAnAgentName like '#params.agentKeyword#%'")
				local.numberOfParameters++;
			}

			offices = model("Office").findAll(
				select = "id,officeName,findAnAgentName,addressLine1,addressLine2,suburbId,suburbName,postcode,state,fileName",
				where = whereify(local.where),
				include = "OfficeRelatedSuburbs,OfficeImages,Suburb",
				distinct = true,
				parametized = local.numberOfParameters
			);
			// count number of on market properties for each office
			local.officeIdList = listEnsure(sanitiseList(ListRemoveDuplicates(ValueList(offices.id))));

			local.onmarketWhere = [
				"status = 'On Market'",
				splitQueryParamList(column = "officeId", list = local.officeIdList)
			];
			local.onmarketListings = model("Listing").count(
				where = whereify(local.onmarketWhere),
				group = "officeId"
			);
	    local.numberOfPropertiesArray = [];
			for (local.office in offices) {
				local.numberOfProps = local.onmarketListings.filter(function(i) {
					return arguments.i.officeId == office.id
				});
				local.numberOfPropertiesArray.append(Val(local.numberOfProps.count));
			}
			QueryAddColumn(offices, "onMarketListingsCount", numberOfPropertiesArray)
		}
	}

	public void function show() {
		office = model("Office").findOne(
			select = "
				id,officeName,findAnAgentName,addressLine1,addressLine2,suburbId,suburbName,postcode,state,phone,profile,
				website,facebook,twitter,linkedin
			",
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
		local.agentWhere = ["isWebHidden = 0", "officeId = #params.key#"];
		agents = model("Agent").findAll(
			select = "id,agentName,position,fileName",
			where = whereify(local.agentWhere),
			include = "AgentOffices,Images",
			parametized = 2
		)
		onmarketSale = model("Listing").count(
			where = "officeId = #params.key# AND status = 'On Market' AND saleMethod != 'lease'"
		);
		onmarketLease = model("Listing").count(
			where = "officeId = #params.key# AND status = 'On Market' AND saleMethod = 'lease'"
		);
		onmarketSold = model("Listing").count(
			where = "officeId = #params.key# AND status = 'Sold'"
		);
	}

}
