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

	function test_user_controller_accounts_update_wrong_password() {
		transaction {
			props = Duplicate(request.currentUser.properties());
			props.oldpassword = "old_password";
			props.password = "new_password";
			props.passwordConfirmation = "new_password";

			actual = processRequest(
				params = {
					route = "accountPassword",
					controller = "user.accounts",
					action = "updatePassword",
					method = "put",
					user = props
				},
				returnAs = "struct"
			);
			transaction action="rollback";
		}
		assert("actual.flash.messageType == 'error'");
		assert("actual.flash.message == 'There was a problem updating your password.'");
		assert("actual.status == 302");
	}

	function test_user_controller_accounts_update_invalid_new() {
		transaction {
			props = Duplicate(request.currentUser.properties());
			props.oldpassword = "password123";
			props.password = "short";
			props.passwordConfirmation = "short";

			actual = processRequest(
				params = {
					route = "accountPassword",
					controller = "user.accounts",
					action = "updatePassword",
					method = "put",
					user = props
				},
				returnAs = "struct"
			);
			transaction action="rollback";
		}
		assert("actual.flash.message contains 'There was a problem updating your password'");
		assert("actual.flash.messageType == 'error'");
	}

	function test_user_controller_accounts_update_mismatch_new() {
		transaction {
			props = Duplicate(request.currentUser.properties());
			props.oldpassword = "password123";
			props.password = "short*1234";
			props.passwordConfirmation = "long*1234";

			actual = processRequest(
				params = {
					route = "accountPassword",
					controller = "user.accounts",
					action = "updatePassword",
					method = "put",
					user = props
				},
				returnAs = "struct"
			);
			transaction action="rollback";
		}
		assert("actual.flash.message contains 'There was a problem updating your password'");
		assert("actual.flash.messageType == 'error'");
	}

/*
	function test_user_controller_accounts_update_success() {
		transaction {
			props = Duplicate(request.currentUser.properties());
			props.oldpassword = "password123";
			props.password = "newPw*1234";
			props.passwordConfirmation = "newPw*1234";

			actual = processRequest(
				params = {
					route = "accountPassword",
					controller = "user.accounts",
					action = "updatePassword",
					method = "put",
					user = props
				},
				returnAs = "struct"
			);
			transaction action="rollback";
		}
		debug("actual")
		assert("actual.flash.message == 'Password successfully updated'");
		assert("actual.status == 302");
		assert("actual.redirect == '/account'");
	}
	*/

}

