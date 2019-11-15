component extends="Model" {

	public void function config() {
		super.config();
		/* PROPERTIES */
		property(
			name = "suburbNameAndPostcode",
			sql = "CONCAT_WS('', suburbs.suburbName, ' (', CAST(suburbs.postcode AS CHAR(4)), ')')"
		);
		property(name = "text", sql = "CONCAT_WS('', suburbs.suburbName, ' (', CAST(suburbs.postcode AS CHAR(4)), ')')");
		afterCreate("setIgnoreLogProperties,storeCreate");
		afterUpdate("setIgnoreLogProperties,storeUpdate");
		afterDelete("setIgnoreLogProperties,storeDelete");
	}

	/**
	 * LOGGING
	 */

	private void function setIgnoreLogProperties() {
		// this.ignoreLogProperties = "";
	}

	private void function storeCreate() {
		super.storeChanges(type = "create");
	}

	private void function storeUpdate() {
		super.storeChanges(type = "update");
	}

	private void function storeDelete() {
		super.storeChanges(type = "delete");
	}

}
