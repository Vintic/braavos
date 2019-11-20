component extends="Model" {

	public void function config() {
		super.config();
		belongsTo(name = "Criteria", joinType = "inner");
		belongsTo(name = "Region", joinType = "outer");
	}

}
