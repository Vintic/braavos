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

	function test_user_controller_searches_delete() {
		transaction {
			criteria = model("Criteria").create(contactId = request.currentUser.key(),saleMethod = 'Lease',listingCategory = 'Business', createdAt = Now());
			actual = processRequest(
				params = {
					route = "search",
					controller = "user.searches",
					action = "delete",
					method = "delete",
					key = criteria.key()
				},
				returnAs = "struct"
			);
			criteriaExists = model("Criteria").findByKey(key = criteria.key(), reload = true);
			transaction action="rollback";
		}

		assert("criteriaExists == false");
		assert("actual.status == 302");
		assert("actual.redirect == '/searches'");
	}

}

