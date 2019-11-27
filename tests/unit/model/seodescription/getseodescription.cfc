component extends="tests.Test" {

	function setup() {
		super.setup();
	}

	function teardown() {
		super.teardown();
	}

	function test_model_listing_getseodescription_buy_house() {
		transaction {
			actual = model("SeoDescription").getSeoDescription(
				state = "VIC",
				saleMethod = "Buy",
				propertyType = "House",
				suburbId = 1
			);
			transaction action="rollback";
		}
		assert("actual.suburbId == 1");
		assert("actual.saleMethod == 'Buy'");
		assert("actual.propertyType == 'House'");
	}

	function test_model_listing_getseodescription_buy_apartment() {
		transaction {
			actual = model("SeoDescription").getSeoDescription(
				state = "VIC",
				saleMethod = "Buy",
				propertyType = "Apartment",
				suburbId = 1
			);
			transaction action="rollback";
		}
		assert("actual.suburbId == 1");
		assert("actual.saleMethod == 'Buy'");
		assert("actual.propertyType == 'Apartment'");
	}

	function test_model_listing_getseodescription_buy_unit() {
		// unit not available in table, should use suburb default with propertyType = null
		transaction {
			actual = model("SeoDescription").getSeoDescription(
				state = "VIC",
				saleMethod = "Buy",
				propertyType = "Unit",
				suburbId = 1
			);
			transaction action="rollback";
		}
		assert("actual.suburbId == 1");
		assert("actual.saleMethod == 'Buy'");
		assert("actual.propertyType == ''");
	}

	function test_model_listing_getseodescription_rent() {
		transaction {
			actual = model("SeoDescription").getSeoDescription(
				state = "VIC",
				saleMethod = "Rent",
				propertyType = "Unit",
				suburbId = 1
			);
			transaction action="rollback";
		}
		assert("actual.suburbId == 1");
		assert("actual.saleMethod == 'Rent'");
		assert("actual.propertyType == ''");
	}

	function test_model_listing_getseodescription_sold() {
		transaction {
			actual = model("SeoDescription").getSeoDescription(
				state = "VIC",
				saleMethod = "Sold",
				propertyType = "Unit",
				suburbId = 1
			);
			transaction action="rollback";
		}
		assert("actual.suburbId == 1");
		assert("actual.saleMethod == 'Sold'");
		assert("actual.propertyType == ''");
	}

	function test_model_listing_getseodescription_suburb_not_found() {
		transaction {
			actual = model("SeoDescription").getSeoDescription(
				state = "VIC",
				saleMethod = "Buy",
				propertyType = "House",
				suburbId = 2
			);
			transaction action="rollback";
		}
		// suburb not available in table, should use state default
		assert("actual.suburbId == ''");
		assert("actual.saleMethod == ''");
		assert("actual.propertyType == ''");
		assert("actual.state == 'VIC'");
	}

	function test_model_listing_getseodescription_region() {
		transaction {
			actual = model("SeoDescription").getSeoDescription(
				state = "VIC",
				saleMethod = "Buy",
				propertyType = "House",
				suburbId = 2,
				regionId = 1
			);
			transaction action="rollback";
		}
		assert("actual.suburbId == ''");
		assert("actual.saleMethod == 'Buy'");
		assert("actual.propertyType == ''");
		assert("actual.regionId == 1");
	}

	function test_model_listing_getseodescription_region_not_found() {
		transaction {
			actual = model("SeoDescription").getSeoDescription(
				state = "VIC",
				saleMethod = "Buy",
				propertyType = "House",
				suburbId = 2,
				regionId = 2
			);
			transaction action="rollback";
		}
		// region not available in table, should use state default
		assert("actual.suburbId == ''");
		assert("actual.saleMethod == ''");
		assert("actual.propertyType == ''");
		assert("actual.state == 'VIC'");
	}

	function test_model_listing_getseodescription_region_rent() {
		transaction {
			actual = model("SeoDescription").getSeoDescription(
				state = "VIC",
				saleMethod = "Rent",
				propertyType = "House",
				suburbId = 2,
				regionId = 1
			);
			transaction action="rollback";
		}
		// rent region not available in table, should use state default
		assert("actual.suburbId == ''");
		assert("actual.saleMethod == ''");
		assert("actual.propertyType == ''");
		assert("actual.state == 'VIC'");
	}


}
