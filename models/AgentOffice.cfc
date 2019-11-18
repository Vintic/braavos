component extends="Model" {

	public void function config() {
		super.config();
		belongsTo(name = "Office", joinType = "inner");
		belongsTo(name = "Agent", joinType = "inner");
	}

}
