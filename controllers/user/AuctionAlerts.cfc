component extends="app.controllers.user.Controller" {

	function config() {
		super.config();
		filters(through = "getAuctionAlert", only = "delete");
	}


	/**
	 * FILTERS
	 */

	private any function getAuctionAlert() {
		auctionAlert = model("ContactAuctionAlert").findByKey(params.key);
		if (!IsObject(auctionAlert)) {
			redirectTo(route = "auctionAlerts", error = "That record wasn't found");
		}
	}


	/**
	 * CRUD
	 */

	public void function index() {
		local.where = ["contactid = #currentUser.id#"];
		auctionAlerts = model("ContactAuctionAlert").findAll(
			select = "id,contactId,lastSentAt,createdAt,suburbId",
			include = "ContactAuctionAlertSuburbs",
			where = whereify(local.where),
			order = "id DESC",
			parametized = 1
		);
		if (auctionAlerts.recordCount) {
			params.suburbIdList = listEnsure(sanitiseList(ListRemoveDuplicates(ValueList(auctionAlerts.suburbId))));
			suburbs = model("Suburb").findAll(
				select = "id, suburbNameAndPostcode",
				where = splitQueryParamList(column = "id", list = params.suburbIdList)
			);
		} else {
			suburbs = [];
		}
	}

	public any function create() {
		auctionAlert = model("ContactAuctionAlert").findOne(
			where = "contactid = #currentUser.id#"
		);
		if (!IsObject(auctionAlert)) {
			auctionAlert = model("ContactAuctionAlert").new(
				contactId = currentUser.id
			);
			auctionAlert.save();
		}
		// delete all suburbs before inserting
		model("ContactAuctionAlertSuburb").deleteAll(where="contactAuctionAlertId = #auctionAlert.key()#");
		for (local.suburbId in params.suburbIdList) {
			auctionAlertSuburb = model("ContactAuctionAlertSuburb").new(
				contactAuctionAlertId = auctionAlert.key(),
				suburbId = local.suburbId
			).save();
		}
		flashInsert(message = "The Auction Alert has been saved successfully.", messageType = "success");
		return redirectTo(route = "auctionAlerts");
	}

	public any function delete() {
		if (auctionAlert.delete()) {
			flashInsert(message = "Auction Alert has been removed.", messageType = "success");
		} else {
			flashInsert(message = "There was a problem removing the Auction Alert.", messageType = "error");
		}
		return redirectTo(route = "auctionAlerts");
	}

}
