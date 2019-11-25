component extends="Controller" output=false {

	public void function index() {
		listings = model("Listing").search(params);
	}

	public void function show() {
		listing = model("Listing").findByKey(
			key = params.key,
			include = "Suburb,ListingPropertyTypes(PropertyType),Office(Suburb,OfficeImages)",
			returnAs = "Query"
		);
		images = model("ListingImage").findAll(
			where = "listingId = #params.key# AND
				isPublic = 1",
			order = "sequence"
		);
	}

}
