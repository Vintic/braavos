component extends="tests.Test" {

	function packageSetup() {
		super.packageSetup();
		super.mockCurrentContact();
	}

	function setup() {
		super.setup();
	}

	function teardown() {
		super.teardown();
	}

	function test_user_controller_viewedListings_index() {
		transaction {
			viewedListing = model("ContactViewedListing").create(
				contactId = request.currentUser.key(),
				listingId = 1,
				createdAt = Now()
			);
			actual = processRequest(
				params = {route = "viewedListings", controller = "user.viewedListings", action = "index"},
				returnAs = "struct"
			);
			transaction action="rollback";
		}

		assert("actual.status == 200");
		assert("Len(actual.redirect) == 0", "actual.redirect");
		assert("actual.body contains '1 recently viewed properties'");
	}

}

