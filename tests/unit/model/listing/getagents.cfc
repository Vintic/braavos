component extends="tests.Test" {

	function setup() {
		super.setup();
	}

	function teardown() {
		super.teardown();
	}

	function test_model_listing_getagents_returns_list_of_ids() {
		keyList = "1,2";
		transaction {
			listing = mocker.getListing(1);
			actual = listing.getAgents(returnAs = "list");
			transaction action="rollback";
		}
		expected = keyList;

		assert("actual == expected");
	}

}
