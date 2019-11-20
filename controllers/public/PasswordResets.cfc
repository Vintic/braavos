component extends="Controller" {

	function config() {
		super.config(redirectAuthenticatedUsers = true);
		// verifies(post = true, only = "create");
		verifies(
			only = "edit",
			params = "token",
			paramsTypes = "string",
			handler = "badToken"
		);
		verifies(
			only = "create",
			params = "email",
			paramsTypes = "email",
			handler = "genericError"
		);
		filters(through = "checkTokenAndGetUser", only = "edit,update");
	}

	/**
	 * New Forgot password form
	 *
	 */
	function new() {
	}

	/**
	 * New Forgot password form submission to create passwordReset
	 *
	 */
	function create() {
		user = model("Contact").findOne(where = "email = '#params.email#'", parameterize = 1);
		if (!IsObject(user)) {
			genericError();
		} else {
			// Generate and save token
			user.generatePasswordResetToken();
			if (!user.save()) {
				genericError();
			} else {
				// Send Reset Email
				sendEmail(
					to = user.email,
					subject = "REV Subscriber Password Reset Request",
					template = "/mailers/passwordReset,/mailers/passwordResetPlain",
					user = user
				);
				flashInsert(message = "A password reset email has been sent to you!", messageType = "success");
				return redirectTo(route = "login");
			}
		}
	}

	/**
	 * Requires token: when a user clicks on a reset password link in the password reset email, this is what's loaded
	 *
	 */
	function edit() {
	}

	/**
	 * Reset the Password: still requires token, but passed through as a hidden form field
	 * We're explicitedly setting values here rather than doing user.update(params) as that might enable them to update
	 * Other properties. Which would be bad.
	 *
	 */
	function update() {
		user.password = params.user.password;
		user.passwordConfirmation = params.user.passwordConfirmation;
		if (user.save()) {
			// Remove password reset token etc
			user.clearPasswordResetToken();
			// Resave
			user.save();
			flashInsert(message = "Your password has been updated and you're free to login", messageType = "success");
			redirectTo(route = "login");
		} else {
			renderView(action = "edit");
		}
	}

	/**
	 * This error is deliberately generic. If we're too detailed, we might give away whether an account exists or not,
	 * Which could help a potential attacker
	 *
	 */
	private function genericError() {
		flashInsert(message = "Sorry, we couldn't complete your request.", messageType = "error");
		return redirectTo(route = "passwordreset");
	}

	/**
	 * Additional token checks, and get the user we're dealing with
	 *
	 */
	private function checkTokenAndGetUser() {
		user = model("Contact").findOne(where = "passwordResetToken = '#params.token#'", parameterize = 1);
		// Valid User? && Token age is less than two hours?
		if (!IsObject(user) || DateDiff("h", user.passwordResetTokenAt, Now()) > 2) {
			badToken();
		}
	}

	/**
	 * This error gets thrown if the token is too old, not found, or simply malformed.
	 *
	 */
	private function badToken() {
		flashInsert(message = "You have followed an outdated or incorrect reset code", messageType = "error");
		return redirectTo(route = "passwordreset");
	}

}
