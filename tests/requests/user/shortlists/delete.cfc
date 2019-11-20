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

	function test_user_controller_shortlists_delete() {
		transaction {
			shortList = model("ContactShortlistListing").create(contactId = request.currentUser.key(),listingId = 1, createdAt = Now());
			actual = processRequest(
				params = {
					route = "shortList",
					controller = "user.shortLists",
					action = "delete",
					method = "delete",
					key = shortList.key()
				},
				returnAs = "struct"
			);
			shortListExists = model("ContactShortlistListing").findByKey(key = shortList.key(), reload = true);
			transaction action="rollback";
		}

		assert("shortListExists == false");
		assert("actual.status == 302");
		assert("actual.redirect == '/short-lists'");
	}

}

