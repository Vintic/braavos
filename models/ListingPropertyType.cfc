component extends="Model" {

	public void function config() {
		super.config();
		belongsTo(name = "Listing", joinType = "inner");
		belongsTo(name = "PropertyType", joinType = "inner");
	}

}
