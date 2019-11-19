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

	function test_restful_controller_suburbs_index_by_state() {
		transaction {
			actual = processRequest(
				params = {
					route = "restfulSuburbs",
					controller = "restful.Suburbs",
					action = "index",
					state = "vic"
				},
				returnAs = "struct"
			);
			numberOfSuburbs = model("Suburb").count(where = "state = 'vic'");
			transaction action="rollback";
		}
		actualStruct = DeserializeJSON(actual.body)
		assert("IsJson(actual.body)");
		assert("IsArray(actualStruct.data) && ArrayLen(actualStruct.data) == numberOfSuburbs")
		assert("actual.status == 200");
		assert("Len(actual.redirect) == 0");
	}

	function test_restful_controller_suburbs_index_byName() {
		transaction {
			actual = processRequest(
				params = {
					route = "restfulSuburbs",
					controller = "restful.Suburbs",
					action = "index",
					state = "",
					q = "melbourne"
				},
				returnAs = "struct"
			);
			numberOfSuburbs = model("Suburb").count(where = "suburbName LIKE 'melbourne%'");
			transaction action="rollback";
		}
		actualStruct = DeserializeJSON(actual.body)
		assert("IsJson(actual.body)");
		assert("IsArray(actualStruct.data) && ArrayLen(actualStruct.data) == numberOfSuburbs")
		assert("actual.status == 200");
		assert("Len(actual.redirect) == 0");
	}

	function test_restful_controller_suburbs_index_byPostcode() {
		transaction {
			actual = processRequest(
				params = {
					route = "restfulSuburbs",
					controller = "restful.Suburbs",
					action = "index",
					state = "",
					q = "3000"
				},
				returnAs = "struct"
			);
			numberOfSuburbs = model("Suburb").count(where = "postcode LIKE '3000%'");
			transaction action="rollback";
		}
		actualStruct = DeserializeJSON(actual.body)
		assert("IsJson(actual.body)");
		assert("IsArray(actualStruct.data) && ArrayLen(actualStruct.data) == numberOfSuburbs")
		assert("actual.status == 200");
		assert("Len(actual.redirect) == 0");
	}

}

