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

	function test_user_controller_auctionalerts_delete() {
		transaction {
			auctionAlert = model("ContactAuctionAlert").create(contactId = request.currentUser.key(),createdAt = Now());
			auctionAlertSuburb = model("ContactAuctionAlertSuburb").create(
				contactAuctionAlertId = auctionAlert.key(),
				suburbId = 1
			);
			actual = processRequest(
				params = {
					route = "auctionAlert",
					controller = "user.auctionAlerts",
					action = "delete",
					method = "delete",
					key = auctionAlert.key()
				},
				returnAs = "struct"
			);
			auctionExists = model("ContactAuctionAlert").findByKey(key = auctionAlert.key(), reload = true);
			transaction action="rollback";
		}

		assert("auctionExists == false");
		assert("actual.status == 302");
		assert("actual.redirect == '/auction-alerts'");
	}

}

