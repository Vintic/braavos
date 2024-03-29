component extends="app.controllers.user.Controller" {

	function config() {
		super.config();
		filters(through = "getShortList", only = "delete");
	}


	/**
	 * FILTERS
	 */

	private any function getShortList() {
		shortList = model("ContactShortListListing").findOne(where = "id = #params.key# AND contactId = #currentUser.id#");
		if (!IsObject(shortList)) {
			flashInsert(message = "That record wasn't found", messageType = "error");
			redirectTo(route = "shortLists");
		}
	}


	/**
	 * CRUD
	 */

	public void function index() {
		local.where = ["contactid = #currentUser.id#"];
		shortLists = model("ContactShortListListing").findAll(
			select = "id,contactId,listingId,createdAt,fullAddress,priceText,bedrooms,bathrooms,totalCarSpaces,fileName",
			include = "Listing(Image)",
			where = whereify(local.where),
			handle = "query",
			perPage = 50,
			page = params.page,
			order = "id DESC",
			parametized = 1
		);
	}

	public any function create() {
		shortList = model("ContactShortListListing").new();
		shortList.contactId = currentUser.id;
		shortList.listingId = params.listingId;
		if (shortList.save()) {
			flashInsert(message = "The listing has been added to your shortlist.", messageType = "success");
			if (getParam("pageFrom") == "viewedListings") {
				return redirectTo(route = "viewedListings");
			} else {
				return redirectTo(route = "shortLists");
			}
		} else {
			flashInsert(message = "There was a problem creating the shortlist.", messageType = "error");
			renderView(action = "index");
		}
	}

	public any function delete() {
		if (shortList.delete()) {
			flashInsert(message = "Listing has been removed from your shortlist.", messageType = "success");
		} else {
			flashInsert(message = "There was a problem removing the listing from your shortlist.", messageType = "error");
		}
		if (getParam("pageFrom") == "viewedListings") {
			return redirectTo(route = "viewedListings");
		} else {
			return redirectTo(route = "shortLists");
		}
	}

}
