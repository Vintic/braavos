component extends="tests.Test" {

	function setup() {
		super.setup();
	}

	function teardown() {
		super.teardown();
	}

	function test_public_session_new() {
		super.mockCurrentContact(kill = true);
		params = {controller = "public.sessions", action = "new"};
		actual = processRequest(params = params, returnAs = "struct");

		assert("actual.status == 200");
		assert("Len(actual.redirect) == 0", "actual.redirect");
		assert("actual.body contains '<form action=""/authenticate""'");
	}

	/**
	 * This is tricky bacause the mocked session is not set after successful login...
	 *
	 * function test_public_session_create_redirects_after_login(){
	 * params= {
	 * controller="public.sessions", action="create",
	 * auth = {
	 * "email" = "tom@rev.com.au",
	 * "password" = "password123"
	 * }
	 * };
	 * actual = processRequest(params=params, returnAs="struct", method="POST");
	 * assert("actual.redirect == '/admin'");
	 * assert("actual.status == 302");
	 * }
	 */

	function test_public_session_create_invalid_rerenders_login_form() {
		super.mockCurrentContact(kill = true);
		params = {
			controller = "public.sessions",
			action = "create",
			auth = {"email" = "badstuff", "password" = "wrongstuff"}
		};
		actual = processRequest(params = params, returnAs = "struct", method = "POST");

		assert("actual.body contains 'Email is invalid'");
		assert(
			"actual.body contains 'Password must be at least 8 characters long and contain a mixture of numbers and letters'"
		);
		assert("actual.status == 200");
	}

}
