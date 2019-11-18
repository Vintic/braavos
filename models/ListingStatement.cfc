component extends="Model" output="false" {

	// these are dates selected by the user via the form
	variables.datesRequiringUtcConversion = ["suburbMedianStartAt", "suburbMedianEndAt"];

	public function config() {
		super.config();
		// Associations
		belongsTo("Listing");
		// hasMany(name = "ListingStatementComparisons", dependent = "deleteAll")
	}


}

