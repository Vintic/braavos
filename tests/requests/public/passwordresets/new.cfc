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

	function test_public_controller_passwordresets_new() {
		actual = processRequest(
			params = {route = "Passwordreset", controller = "public.PasswordResets", action = "new"},
			returnAs = "struct"
		);
		assert("actual.status == 200");
		assert("Len(actual.redirect) == 0", "actual.redirect");
		assert("actual.body contains 'Reset Password'");
		// assertAdminLayout(actual.body);
	}

}

