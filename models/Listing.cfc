component extends="Model" output="false" {

	// these are dates selected by the user via the form
	variables.datesRequiringUtcConversion = [
		"availableAt",
		"leasedAt",
		"listedAt",
		"auctionAt",
		"contractAt",
		"soldAt"
	];

	public void function config() {
		super.config();
		property(name = "createdMonth", sql = "MONTH(listings.createdAt)", select = false);
		property(name = "createdYear", sql = "YEAR(listings.createdAt)", select = false);
		belongsTo(name = "Office");
		belongsTo(name = "Suburb");
		// belongsTo(name = "Project");
		hasMany(name = "ListingAgents", shortcut = "Agents", joinType = "outer");
		hasMany(name = "ListingPropertyTypes", shortcut = "PropertyTypes", joinType = "outer");
		// hasMany(name = "ListingRanks", shortcut = "Ranks", joinType = "outer");
		hasMany(name = "Images", modelName = "ListingImage");
		hasOne(name="Image", modelName = "ListingImage", joinKey="heroImageId", foreignKey="id");
		hasMany(name = "Floorplans", modelName = "ListingFloorplan");
		hasMany(name = "ListingFeatures", shortcut = "Features");
		// hasOne(name = "ListingBusiness", joinType = "outer");
		// nestedProperties(associations = "ListingFeatures,ListingBusiness", allowDelete = true);
	}

	/**
	 * Returns a list of agent keys for the listing instance
	 *
	 * [section: Application]
	 * [category: models.Listing]
	 *
	 */
	public string function getAgents(string returnAs = "list") {
		// currently only returns a list
		local.agents = model("ListingAgent").findAllByListingId(select = "agentId", value = this.key())
		return ValueList(local.agents.agentId);
	}

	/**
	 * Returns a list of propertytype keys for the listing instance
	 *
	 * [section: Application]
	 * [category: models.Listing]
	 *
	 */
	public string function getPropertyTypes(string returnAs = "list") {
		// currently only returns a list
		local.listingPropertyTypes = model("ListingPropertyTypes").findAllByListingId(
			select = "propertyTypeId",
			value = this.key()
		)
		return ValueList(local.listingPropertyTypes.propertyTypeId);
	}

	/**
	 * Returns a list of subpropertytype keys for the listing instance
	 *
	 * [section: Application]
	 * [category: models.Listing]
	 *
	 */
	// public string function getSubPropertyTypes(string returnAs = "list") {
	// 	// currently only returns a list
	// 	local.listingSubPropertyTypes = model("ListingSubPropertyTypes").findAllByListingId(
	// 		select = "subPropertyTypeId",
	// 		value = this.key()
	// 	)
	// 	return ValueList(local.listingSubPropertyTypes.subPropertyTypeId);
	// }

	public query function search() {

		return model("Listing").findAll(
			// select="Todo",
			where="category = 'residential'",
			include="Images,Suburb,ListingPropertyTypes(PropertyType),ListingAgents,Office(Suburb,OfficeImage)", //features
			handle="listingsQuery",
			page=arguments.page ?: 1,
			perPage=6,
			order="rank,suburbName",
			argumentCollection = arguments
		);

	}

}
