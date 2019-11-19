component extends="Model" {

	public void function config() {
		super.config();
		hasMany(name = "ListingPropertyTypes", shortcut = "Listings");
	}

}
