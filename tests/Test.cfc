component extends="wheels.Test" {

	public void function packageSetup() {
		mocker = this.getMocker();
	}

	public void function setup() {
		mocker = this.getMocker();
	}

	public void function teardown() {
	}

	public void function beforeAll() {
		mocker = this.getMocker();
		// warn if database has not been seeded
		if (isDevelopment() && !model("Suburb").exists()) {
			Throw(type = "EmptyDatabaseError", message = "The testing database has no seed data. Add 'seed=true' to your url");
		}
	}

	public void function afterAll() {
		if (url.debug ?: false == true) {
			setting showdebugoutput="true";
		}
	}

	public object function getMocker() {
		if (IsDefined("mocker")) {
			return mocker;
		} else {
			return new tests.mocker.Mocker();
		}
	}

	include template="helpers.cfm";

}
