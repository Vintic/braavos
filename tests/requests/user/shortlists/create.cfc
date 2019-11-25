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

	function test_user_controller_shortlists_create() {
		transaction {
			actual = processRequest(
				params = {
					route = "shortLists",
					controller = "user.shortLists",
					action = "create",
					method = "post",
					listingId = 1
				},
				returnAs = "struct"
			);
			shortList = model("ContactShortlistListing").findOne(
				where = "contactId = #request.currentUser.key()#",
				reload = true
			);
			transaction action="rollback";
		}

		assert("shortList.listingId == 1");
		assert("actual.status == 302");
		assert("actual.redirect == '/short-lists'");
	}

}

