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

	function test_user_controller_accounts_edit() {
		transaction {
			actual = processRequest(
				params = {route = "editAccount", controller = "user.accounts", action = "edit"},
				returnAs = "struct"
			);
			transaction action="rollback";
		}

		assert("actual.status == 200");
		assert("Len(actual.redirect) == 0", "actual.redirect");
		assert("actual.body contains 'Your Account Details'");
		assert("actual.body contains request.currentUser.firstName")
	}

}

