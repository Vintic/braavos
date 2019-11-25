component extends="tests.Test" {

	function packageSetup() {
		super.packageSetup();
		super.mockCurrentContact();
	}

	function setup() {
		super.setup();
	}

	function teardown() {
		super.teardown();
	}

	function test_user_controller_auctionAlerts_index_no_record() {
		transaction {
			actual = processRequest(
				params = {route = "auctionAlerts", controller = "user.auctionAlerts", action = "index"},
				returnAs = "struct"
			);
			transaction action="rollback";
		}
		assert("actual.status == 200");
		assert("Len(actual.redirect) == 0", "actual.redirect");
		assert("actual.body contains 'Auction results in your inbox'");
		assert("actual.body does not contain 'Stop sending'");
	}

	function test_user_controller_auctionAlerts_index_with_record() {
		transaction {
			auctionAlert = model("ContactAuctionAlert").create(contactId = request.currentUser.key(), createdAt = Now());
			auctionAlertSuburb = model("ContactAuctionAlertSuburb").create(
				contactAuctionAlertId = auctionAlert.key(),
				suburbId = 1
			);
			actual = processRequest(
				params = {route = "auctionAlerts", controller = "user.auctionAlerts", action = "index"},
				returnAs = "struct"
			);
			transaction action="rollback";
		}
		assert("actual.status == 200");
		assert("Len(actual.redirect) == 0", "actual.redirect");
		assert("actual.body contains 'Auction results in your inbox'");
		assert("actual.body contains 'MELBOURNE (3000)'");
		assert("actual.body contains 'Stop sending'");
	}

}

