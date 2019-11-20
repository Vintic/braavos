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

	function test_user_controller_accounts_update() {
		transaction {
			props = Duplicate(request.currentUser.properties());
			props.firstName = "Ned";
			props.lastName = "Stark";

			actual = processRequest(
				params = {
					route = "account",
					controller = "user.accounts",
					action = "update",
					method = "put",
					user = props
				},
				returnAs = "struct"
			);
			updatedContact = model("Contact").findByKey(key = request.currentUser.key(), reload = true);
			transaction action="rollback";
		}
		expected = "Ned Stark";

		assert("updatedContact.contactName == expected");
		assert("actual.status == 302");
		assert("actual.redirect == '/account'");
	}

}

