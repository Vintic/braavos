component extends="Model" {

	public void function config() {
		super.config();

		// calculated properties
		property(name = "agentName", sql = "CONCAT_WS(' ', TRIM(agents.firstName), TRIM(agents.lastName))");

		// Associations
		// belongsTo("Role");
		hasMany(name = "Images", modelName = "AgentImage"); // should this be name=AgentImages?
		hasMany(name = "AgentOffices", shortcut = "Offices");
	}

	/**
	 * Sanitizes the user object
	 */
	function sanitize() {
		if (StructKeyExists(this, "firstName")) this.firstName = sanitizeInput(this.firstName);
		if (StructKeyExists(this, "lastName")) this.lastName = sanitizeInput(this.lastName);
		if (StructKeyExists(this, "email")) this.email = sanitizeInput(this.email);
	}

}
