component extends="wheels.Model" {

	public any function init() {
		faker = new services.faker.faker();
		return this;
	}

	public object function getAdministrator(required numeric key = 1) {
		return model("Administrator").findByKey(key = arguments.key, reload = true);
	}

	public object function getOffice(required numeric key = 1) {
		return model("Office").findByKey(key = arguments.key, reload = true);
	}

	public object function getAgent(required numeric key = 1) {
		return model("Agent").findByKey(key = arguments.key, reload = true);
	}

	public object function getListing(required numeric key = 1) {
		return model("Listing").findByKey(key = arguments.key, reload = true);
	}

	public object function getGroup(required numeric key = 1) {
		return model("Group").findByKey(key = arguments.key, reload = true);
	}

	public object function createAdministrator(struct properties = {}) {
		local.administrator = model("Administrator").new(
			firstname = faker.name.firstName(),
			lastname = faker.name.lastName(),
			email = faker.internet.email(),
			mobile = faker.phoneNumber.mobilePhoneNumber(),
			dutyid = 1,
			password = CreateUUID(),
			rememberToken = CreateUUID(),
			multiFactorAuthKey = CreateUUID()
		);
		local.administrator.setProperties(properties = arguments.properties);
		local.administrator.save(reload = true, transaction = false);
		if (!local.administrator.valid()) {
			throw message = Serialize(errorMessageArray(local.administrator.allErrors()));
		}
		return local.administrator;
	}

	public object function createOffice(struct properties = {}, boolean callbacks = false) {
		local.office = model("Office").new(
			officename = faker.company.companyName(),
			defaultcategory = "Residential",
			addressline1 = faker.address.streetAddress(),
			suburbid = 1,
			phone = faker.phoneNumber.phoneNumber(),
			email = faker.internet.email(),
			createChange = false
		);
		local.office.setProperties(properties = arguments.properties);
		local.office.save(reload = true, transaction = false, callbacks = arguments.callbacks);
		if (!local.office.valid()) {
			throw message = Serialize(errorMessageArray(local.office.allErrors()));
		}
		return local.office;
	}

	public object function createAgent(required string officeKeys, struct properties = {}) {
		local.role = model("Role").findOne(
			select = "id",
			where = "officeid = #ListFirst(arguments.officeKeys)# AND roleName = 'Salesperson'"
		);
		local.agent = model("Agent").new(
			firstname = faker.name.firstName(),
			lastname = faker.name.lastName(),
			email = faker.internet.email(),
			mobile = faker.phoneNumber.mobilePhoneNumber(),
			password = faker.generate(16) & "666",
			createChange = false
		);
		local.agent.setProperties(properties = arguments.properties);
		local.agent.roleid = local.role.id; // cant be mass assigned?
		local.agent.save(reload = true, transaction = false);
		if (!local.agent.valid()) {
			throw message = Serialize(errorMessageArray(local.Agent.allErrors()));
		}
		local.i = 0;
		for (local.key in arguments.officeKeys) {
			local.i++;
			model("AgentOffice").create(agentid = local.agent.key(), officeid = local.key, isPrimaryOffice = local.i == 1);
		}
		return local.agent;
	}

	public object function createContact(required numeric officeKey, struct properties = {}, args = {}) {
		local.contact = model("Contact").new(
			office_id = arguments.officeKey,
			contact_type = "Test",
			first_name = faker.name.firstName(),
			surname = faker.name.lastName(),
			mobile = faker.phoneNumber.mobilePhoneNumber(),
			email_address = faker.internet.email(),
			createChange = false
		);
		local.contact.setProperties(properties = arguments.properties);
		local.contact.save(reload = true, argumentCollection = arguments.args, transaction = false);
		if (arguments.args.validate ?: true && !local.contact.valid()) {
			throw message = Serialize(errorMessageArray(local.contact.allErrors()));
		}
		return local.contact;
	}

	// TODO: allow validate and callback args for listing.save
	public object function createListing(
		required numeric officeKey,
		required numeric AgentKey,
		boolean callbacks = true,
		struct properties = {}
	) {
		local.listing = model("Listing").new(
			officeid = arguments.officeKey,
			agentId = arguments.agentKey,
			suburbId = 1, // melbourne
			propertyTypeId = "1,5,10",
			category = "Residential",
			saleMethod = "Sale",
			status = "Sneak Preview",
			webStatus = "Sneak Preview",
			streetNumber = RandRange(1, 999),
			streetName = faker.address.streetName(),
			priceFrom = RandRange(100000, 9999999),
			heading = faker.lorem.sentence(10),
			description = faker.lorem.paragraphs(3),
			propertyType = "House",
			priceText = "One MILLION Dollars!",
			dateListed = Now(),
			createChange = false
		);
		local.listing.setProperties(properties = arguments.properties);
		local.listing.save(
			reload = true,
			callbacks = arguments.callbacks,
			validate = false,
			transaction = false
		);
		if (!local.listing.valid()) {
			throw message = Serialize(errorMessageArray(local.listing.allErrors()));
		}
		return local.listing;
	}

	public object function createRichListing(struct properties = {}, boolean callbacks = true) {
		var office = this.getOffice();
		var agent = this.getAgent();
		var listing = this.createListing(
			officeKey = office.key(),
			agentKey = agent.key(),
			properties = arguments.properties,
			callbacks = arguments.callbacks
		);
		model("ListingAgent").create(listingid = listing.key(), agentId = 2);
		model("ListingImage").create(
			listingId = listing.key(),
			fileName = generateUniqueFileName("jpg"),
			isPublic = true,
			sequence = 1
		);
		model("ListingImage").create(
			listingId = listing.key(),
			fileName = generateUniqueFileName("jpg"),
			isPublic = true,
			sequence = 1
		);
		model("ListingFloorplan").create(
			listingId = listing.key(),
			fileName = generateUniqueFileName("jpg"),
			isPublic = true,
			sequence = 1
		);
		model("ListingFloorplan").create(
			listingId = listing.key(),
			fileName = generateUniqueFileName("jpg"),
			isPublic = true,
			sequence = 1
		);
		model("Open").create(
			officeId = office.key(),
			listingId = listing.key(),
			openStart = Now(),
			openEnd = DateAdd("h", 1, Now())
		);
		return listing;
	}


	public object function createOfficePortal(
		required numeric officeKey,
		required numeric portalKey,
		required string portalUsername,
		struct properties = {}
	) {
		local.officePortal = model("OfficePortal").new(
			office_id = arguments.officeKey,
			portal_id = arguments.portalKey,
			office_portal_username = arguments.portalUsername,
			office_portal_password = CreateUUID(),
			days_delay = 0,
			office_portal_status = "live"
		);
		local.officePortal.setProperties(properties = arguments.properties);
		local.officePortal.save(reload = true, callbacks = false, transaction = false);
		if (!local.officePortal.valid()) {
			throw message = Serialize(errorMessageArray(local.officePortal.allErrors()));
		}
		return local.officePortal;
	}

	public object function createGroup(required string officeKeys, struct properties = {}) {
		local.group = model("Group").new(
			groupName = faker.company.companyName(),
			isWeb = true,
			isOfficeShare = true,
			officeid = arguments.officeKeys,
			createChange = false
		);
		local.group.setProperties(properties = arguments.properties);
		local.group.save(reload = true, transaction = false);
		if (!local.group.valid()) {
			throw message = Serialize(errorMessageArray(local.group.allErrors()));
		}
		return model("Group").findByKey(local.group.key());
	}

}
