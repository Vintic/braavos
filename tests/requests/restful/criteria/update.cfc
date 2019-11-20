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

	function test_restful_controller_criteria_update() {
		transaction {
			criteria = model("Criteria").findOne();
			actual = processRequest(
				params = {
					route = "restfulCriterium",
					controller = "restful.Criteria",
					action = "update",
					method = "put",
					key = criteria.key(),
					contactId = criteria.contactId,
					sendFrequency = "daily"
				},
				returnAs = "struct"
			);
			checkCriteria = model("Criteria").findOne(where = "id = #criteria.key()#");
			transaction action="rollback";
		}
		actualStruct = DeserializeJSON(actual.body)
		assert("IsJson(actual.body)");
		assert("actualStruct.success == true")
		assert("actual.status == 200");
		assert("Len(actual.redirect) == 0");
		assert("checkCriteria.sendFrequency == 'daily'");
	}

}

