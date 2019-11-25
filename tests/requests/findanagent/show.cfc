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

	function test_public_controller_findAnAgent_show() {
		transaction {
			office = mocker.getOffice();
			officeImage = model("OfficeImage").create(
				officeId = office.id,
				fileName = "abc.jpg",
				imageType = "logo",
				createdAt = Now(),
				sequence = 1
			);
			officeRelatedSuburb = model("OfficeRelatedSuburb").create(
				officeId = office.id,
				suburbId = 1,
				type = "findAnAgent"
			);

			actual = processRequest(
				params = {
					route = "findAnAgent",
					controller = "findAnAgent",
					action = "show",
					key = "1"
				},
				returnAs = "struct"
			);
			transaction action="rollback";
		}
		assert("actual.status == 200");
		assert("Len(actual.redirect) == 0", "actual.redirect");
		assert("actual.body contains '#office.findAnAgentName#'");
		// assertAdminLayout(actual.body);
	}

}

