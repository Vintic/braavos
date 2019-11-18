component extends="Model" output="false" {

	public void function config() {
		super.config();
		property(name = "createdMonth", sql = "MONTH(offices.createdAt)", select = false);
		property(name = "createdYear", sql = "YEAR(offices.createdAt)", select = false);
		property(
			name = "timezone",
			sql = "CASE
				WHEN suburbs.state = 'NSW' THEN 'Australia/Sydney'
				WHEN suburbs.state = 'VIC' THEN 'Australia/Melbourne'
				WHEN suburbs.state = 'QLD' THEN 'Australia/Brisbane'
				WHEN suburbs.state = 'SA' THEN 'Australia/Adelaide'
				WHEN suburbs.state = 'WA' THEN 'Australia/Perth'
				WHEN suburbs.state = 'TAS' THEN 'Australia/Hobart'
				WHEN suburbs.state = 'ACT' THEN 'Australia/Sydney'
				WHEN suburbs.state = 'NT' THEN 'Australia/Darwin'
				ELSE 'UTC'
			END",
			select = false
		);
		property(name = "text", sql = "CONCAT_WS('', offices.officeName, ' (', offices.id, ')')");
		// associations
		belongsTo(name = "Suburb");
		hasMany(name = "AgentOffices", joinType = "inner", shortcut = "agents");
		// hasMany("GroupOffices");
		// hasMany("Roles");
		// hasMany("OfficeListingTypes");
		// hasMany("OfficeSpecialtyPropertyTypes");
		// hasMany(name = "Images", modelName = "OfficeImage");
		// hasMany(name = "OfficeProducts", joinType = "outer");
		// nestedProperties(associations = "OfficeListingTypes", allowDelete = true);
		// nestedProperties(associations = "OfficeSpecialtyPropertyTypes", allowDelete = true);
	}

}

