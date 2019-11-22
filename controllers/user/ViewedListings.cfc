component extends="app.controllers.user.Controller" {

	function config() {
		super.config();
	}

	/**
	 * CRUD
	 */

	public void function index() {
		local.where = ["contactid = #currentUser.id#"];
		viewedListings = model("ContactViewedListing").findAll(
			select = "id,contactId,listingId,createdAt,fullAddress,priceText,bedrooms,bathrooms,totalCarSpaces,fileName",
			include = "Listing(Image)",
			where = whereify(local.where),
			handle = "query",
			perPage = 50,
			page = params.page,
			order = "id DESC",
			parametized = 1
		);

		local.viewedListingsIds = listEnsure(sanitiseList(ListRemoveDuplicates(ValueList(viewedListings.listingId))));
		local.shortListWhere = Duplicate(local.where);
		local.shortListWhere.Append(
			splitQueryParamList(column = "listingId", list = local.viewedListingsIds)
		);
		local.shortLists = model("ContactShortListListing").findAll(
			select = "id,listingId",
			where = whereify(local.shortListWhere)
		);

		shortListArray = [];
		for (local.thisRow in viewedListings) {
			local.thisListingShortList = local.shortLists.filter(function(i) {
				return arguments.i.listingId == thisRow.listingId;
			});
			shortListArray.append(local.thisListingShortList);
		}
		QueryAddColumn(viewedListings, "shortListQuery", shortListArray)
	}

}
