component extends="Model" output="false" {

	public function config() {
		super.config();
		belongsTo("Office");
		belongsTo("Suburb");
	}

}

