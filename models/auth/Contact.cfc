component
	extends="app.models.Model"
	/*
	  Authentication Tableless Model
	  All these actions need to operate outside the central permissions system
	*/
{

	function config() {
		table(false);
		property(name = "name", defaultValue = "Local Authentication Gateway");
		property(name = "rememberme", defaultValue = false);
		property(name = "allowPasswordReset", defaultValue = true);
		property(name = "allowRememberMe", defaultValue = true);
		validatesPresenceOf(properties = "email,password");
		validatesFormatOf(property = "email", allowBlank = true, type = "email");
		authenticateThis(required = false);
	}

	// Authenticates
	boolean function login() {
		if (this.valid() && this.authenticate()) {
			return true;
		} else {
			return false;
		}
	}

	function logout() {
		// Called when attempting to log a user out: it might be that an external/other authentiation method
		// Needs to do something else here. For local auth we'll just log the action probably
	}


	// Returns true is authentication is successful
	// For an external auth method, this might include LDAP/Remote stuff
	boolean function authenticate() {
		// Find the local user account
		local.user = model("Contact").findOne(where = "email = '#this.email#'", parameterize = 1);
		if (!IsObject(local.user)) {
			this.addError(property = "email", message = "Sorry, we couldn't log you in");
			return false;
		} else {
			// Check the pw
			if (local.user.checkPassword(this.password)) {
				// assignPermissions(local.user);
				postLogin(local.user);
				return true;
			} else {
				this.addError(property = "password", message = "Sorry, we couldn't log you in");
				return false;
			}
		}
	}

	/**
	 * Runs after a successful login, but before redirection
	 *
	 */
	function postLogin(user) {
		// assign session cookie
		arguments.user.generateRememberToken();
		setRememberTokenCookie(arguments.user.rememberToken);

		arguments.user.loggedInAt = Now();

		// If the user has requested a password reset email, but then managed to login normally (i.e, ignored the email),
		// then remove the Password reset token, as there's a potential 2 hour window of attack
		arguments.user.clearPasswordResetToken();
		arguments.user.save();

		// Check for password reset requirement: this might have been triggered by an admin resetting the password
		// Or perhaps some other condition such as time since last reset
		if (arguments.user.isPasswordChangeRequired) {
			createPasswordResetBlock();
		}
	}

}
