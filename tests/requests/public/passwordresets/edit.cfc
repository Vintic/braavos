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

	function test_public_controller_passwordresets_edit_invalidtoken() {
		transaction {
			actual = processRequest(
				params = {
					route = "editPasswordreset",
					controller = "public.passwordresets",
					action = "edit",
					token = "invalid"
				},
				returnAs = "struct"
			);
			transaction action="rollback";
		}
		assert("actual.status == 302");
		assert("actual.flash.messageType == 'error'");
		assert("actual.redirect == '/password/forgot'");
	}

	function test_public_controller_passwordresets_edit_validtoken() {
		transaction {
			contact = model("Contact").findOne();
			contact.passwordResetToken = "1234567890";
			contact.passwordResetTokenAt = Now();
			contact.update()
			actual = processRequest(
				params = {
					route = "editPasswordreset",
					controller = "public.passwordresets",
					action = "edit",
					token = "1234567890"
				},
				returnAs = "struct"
			);
			transaction action="rollback";
		}
		assert("actual.status == 200");
		assert("Len(actual.redirect) == 0", "actual.redirect");
		assert("actual.body contains 'Reset password'");
		assert("actual.body contains 'Confirm Password'");
	}

}

