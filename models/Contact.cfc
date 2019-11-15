component extends="Model" {

	public void function config() {
		super.config();

		// calculated properties
		property(name = "contactName", sql = "CONCAT_WS(' ', TRIM(contacts.firstName), TRIM(contacts.lastName))");
		property(name = "createdMonth", sql = "MONTH(agents.createdAt)", select = false);
		property(name = "createdYear", sql = "YEAR(agents.createdAt)", select = false);

		// Associations

		// More Password Checks
		validate("additionalPasswordValidation");
		// custom validation

		// Callbacks
		// beforeValidation("sanitize");
		beforeUpdate("setPasswordLastChanged");
		afterCreate("setIgnoreLogProperties,storeCreate");
		afterUpdate("setIgnoreLogProperties,storeUpdate");
		afterDelete("setIgnoreLogProperties,storeDelete");

		// Authenticate This Plugin
		// Handles passwordHash and passwordConfirmations
		authenticateThis();
	}


	/**
	 * Check Password doesn't exist within Email
	 */
	function additionalPasswordValidation() {
		if (
			StructKeyExists(this, "password")
			 && StructKeyExists(this, "email")
			 && this.email CONTAINS this.password
		)
			this.addError(property = "password", message = "Your password should not be part of your email address");
	}

	/**
	 * Generates a verification token on register
	 */
	function generateVerificationToken() {
		this.verificationToken = $generateToken();
	}

	/**
	 * Generates a password reset token and sets the time token was created
	 */
	function generatePasswordResetToken() {
		this.passwordResetToken = $generateToken();
		this.passwordResetTokenAt = Now();
	}

	// Generates a remember token
	function generateRememberToken() {
		this.rememberToken = randomString("urlsafe", 64);
	}

	/**
	 * Runs on successful password update via passwordresettoken
	 * Will also get cleared on successful login
	 */
	function clearPasswordResetToken() {
		this.passwordResetToken = "";
		this.passwordResetTokenAt = "";
	}

	/**
	 * Update the passwordReset timestamp when the password changes: done as a call back so we don't have to duplicate
	 * ourselves in password resets vs account resets
	 *
	 */
	function setPasswordLastChanged() {
		if (StructKeyExists(this, "passwordHash") && this.hasChanged("passwordHash")) this.passwordResetAt = Now();
	}

	/**
	 * Internal: Generate a token for use in password reset emails
	 *
	 */
	function $generateToken() {
		return Replace(LCase(CreateUUID()), "-", "", "all");
	}

	/**
	 * LOGGING
	 */

	private void function setIgnoreLogProperties() {
		this.ignoreLogProperties = "password,passwordHash,passwordResetToken,rememberToken,passwordResetTokenAt,passwordResetAt,multiFactorAuthKey,loggedinat";
	}

	private void function storeCreate() {
		super.storeChanges(type = "create");
	}

	private void function storeUpdate() {
		super.storeChanges(type = "update");
	}

	private void function storeDelete() {
		super.storeChanges(type = "delete");
	}

}
