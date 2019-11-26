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

	function test_public_controller_agent_show() {
		transaction {
			agent = mocker.getAgent();
			actual = processRequest(
				params = {
					route = "agent",
					controller = "agent",
					action = "show",
					key = agent.key(),
					officeId = 1
				},
				returnAs = "struct"
			);
			transaction action="rollback";
		}
		assert("actual.status == 200");
		assert("Len(actual.redirect) == 0", "actual.redirect");
		assert("actual.body contains '#agent.agentName#'");
		// assertAdminLayout(actual.body);
	}

}

