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


	function test_public_controller_passwordresets_update_invalid() {
		transaction {
			contact = model("Contact").findOne();
			props = Duplicate(contact.properties());
			props.password = "password*123"; // test this was updated
			props.passwordConfirmation = "password*123";

			actual = processRequest(
				params = {
					route = "updatePasswordreset",
					controller = "public.passwordresets",
					action = "update",
					method = "put",
					token = "1234567890",
					user = props
				},
				returnAs = "struct"
			);
			transaction action="rollback";
		}
		assert("actual.flash.messageType == 'error'")
		assert("actual.status == 302");
		assert("actual.redirect == '/password/forgot'");
	}

	function test_public_controller_passwordresets_update_valid() {
		transaction {
			contact = model("Contact").findOne();
			contact.passwordResetToken = "1234567890";
			contact.passwordResetTokenAt = Now();
			contact.update()

			props = Duplicate(contact.properties());
			props.password = "password*123"; // test this was updated
			props.passwordConfirmation = "password*123";

			actual = processRequest(
				params = {
					route = "updatePasswordreset",
					controller = "public.passwordresets",
					action = "update",
					method = "put",
					token = "1234567890",
					user = props
				},
				returnAs = "struct"
			);
			transaction action="rollback";
		}
		assert("actual.flash.messageType == 'success'")
		assert("actual.status == 302");
		assert("actual.redirect == '/login'");
	}

}

