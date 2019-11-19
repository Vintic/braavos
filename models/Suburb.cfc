component extends="Model" {

	public void function config() {
		super.config();
		/* PROPERTIES */
		property(
			name = "suburbNameAndPostcode",
			sql = "CONCAT_WS('', suburbs.suburbName, ' (', CAST(suburbs.postcode AS CHAR(4)), ')')"
		);
		property(name = "text", sql = "CONCAT_WS('', suburbs.suburbName, ' (', CAST(suburbs.postcode AS CHAR(4)), ')')");
	}

}
