component extends="Model" output="false" {

	public function config() {
		super.config();
		hasMany("OfficeListingTypes");
	}

}

