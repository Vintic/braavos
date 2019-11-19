component extends="tests.Test" {

	function packageSetup() {
		super.packageSetup();
	}

	function setup() {
		super.setup();
	}

	function teardown() {
		super.teardown();
	}

	function test_public_controller_passwordresets_create_invalid_email() {
		transaction {
			actual = processRequest(
				params = {
					route = "Passwordreset",
					controller = "public.PasswordResets",
					action = "create",
					method = "post",
					email = "notvalid@email.com"
				},
				returnAs = "struct"
			);
			transaction action="rollback";
		}
		assert("actual.status == 302");
		assert("actual.flash.messageType == 'error'");
		assert("actual.redirect == '/password/forgot'");
		// assertAdminLayout(actual.body);
	}

}

