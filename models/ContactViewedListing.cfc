component extends="Model" output="false" {

	public void function config() {
		super.config();
		// Associations
		belongsTo("Contact");
		belongsTo("Listing");
		// Callbacks
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

