component extends="Controller" output=false {

	/**
	 * CRUD
	 */

	public void function show() {
		local.agentWhere = ["isWebHidden = 0", "officeId = #params.officeId#", "id = #params.key#"];
		agent = model("Agent").findOne(
			select = "id,firstName,lastName,agentName,email,mobile,phone,position,profile,fileName",
			where = whereify(local.agentWhere),
			include = "AgentOffices,Images",
			parametized = 3
		);
		office = model("Office").findOne(
			select = "id,officeName,findAnAgentName,addressLine1,addressLine2,suburbName,postcode,state",
			where = "id = #params.officeId#",
			include = "Suburb",
			parametized = 1
		);
		local.officeImages = model("OfficeImage").findAll(
			select = "id,fileName,imageType,sequence",
			where = "officeId = #params.officeId#",
			parametized = 1
		);
		officeLogos = local.officeImages.filter(function(i) {
			return i.imageType == "logo";
		});
		findAnImage = local.officeImages.filter(function(i) {
			return i.imageType == "findAnAgent";
		});
	}

}
