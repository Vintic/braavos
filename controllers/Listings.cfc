component extends="Controller" output=false {

	public void function index() {

		listings = model("Listing").search(params);

	}

}
