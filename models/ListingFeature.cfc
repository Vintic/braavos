component extends="Model" output="false" {

	public void function config() {
		super.config();
		// Associations
		belongsTo("Listing");
		belongsTo("Feature");
	}

}

