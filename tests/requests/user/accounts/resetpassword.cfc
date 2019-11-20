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

	function test_user_controller_accounts_resetpassword() {
		transaction {
			actual = processRequest(
				params = {route = "accountPassword", controller = "user.accounts", action = "resetPassword"},
				returnAs = "struct"
			);
			transaction action="rollback";
		}

		assert("actual.status == 200");
		assert("Len(actual.redirect) == 0", "actual.redirect");
		assert("actual.body contains 'Update Your Password'");
		assert("actual.body contains 'New Password'")
	}

}

