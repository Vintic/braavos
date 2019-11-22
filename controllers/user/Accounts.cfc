component extends="app.controllers.user.Controller" {

	function config() {
		super.config(restrictAccess = true);
		filters(through = "getCurrentlyLoggedInUser");
	}

	/**
	 * PARTIAL DATA
	 */

	private struct function fields() {
		states = model("State").findAll(select = "id,state,code", cache = true);
		if (Val(user.suburbId)) {
			suburbs = model("Suburb").findAll(select = "id,suburbNameAndPostcode,state", where = "id = #user.suburbId#");
			params.state = suburbs.state;
		} else {
			suburbs = QueryNew("id,suburbName")
		}
		contactSituations = model("ContactSituation").findAll(select = "id,situationName");
		return {};
	}

	/**
	 * The Users account page
	 *
	 */
	function show() {
		local.addressStruct = {};
		local.addressStruct.addressLine1 = user.addressLine1;
		local.addressStruct.addressLine2 = user.addressLine2;
		if (Val(user.suburbId)) {
			local.suburbs = model("Suburb").findAll(
				select = "id,suburbName,state,postcode",
				where = "id = #user.suburbId#",
				parametized = 1
			);
			local.addressStruct.suburbName = local.suburbs.suburbName;
			local.addressStruct.state = local.suburbs.state;
			local.addressStruct.postcode = local.suburbs.postcode;
		}
		user.fullAddress = lineAddressFormat(local.addressStruct);
		if (Val(user.situationId)) {
			local.contactSituation = model("ContactSituation").findByKey(user.situationId);
			user.contactSituation = local.contactSituation.situationName;
		}
	}

	/**
	 * Load User account update form
	 */
	function edit() {
	}

	/**
	 * Save user account details
	 * We're being more explicit in what properties the user can update on their own account here
	 */
	function update() {
		if (user.update(params.user)) {
			flashInsert(message = "Account successfully updated", messageType = "success");
			redirectTo(action = "show");
		} else {
			flashInsert(message = "There was a problem updating your account.", messageType = "error");
			renderView(action = "edit");
		}
	}

	/**
	 * The Reset Password Form
	 */
	function resetPassword() {
	}

	/**
	 * Reset password action
	 */
	function updatePassword() {
		// Check old password
		if (!user.checkPassword(params.user.oldpassword)) {
			flashInsert(message = "Your old password was incorrect.", messageType = "error");
			redirectTo(back = true);
		}
		// Carry on
		user.password = params.user.password;
		user.passwordConfirmation = params.user.passwordConfirmation;
		if (user.save()) {
			// If this has been completed as part of a forced password change, reset all the flags; don't do this until
			// the password change has been successful.
			if (hasPasswordResetBlock()) {
				user.isPasswordChangeRequired = 0;
				user.save();
				clearPasswordResetBlock();
			}
			flashInsert(message = "Password successfully updated", messageType = "success");
			redirectTo(action = "show");
		} else {
			flashInsert(message = "There was a problem updating your password.", messageType = "error");
			renderView(action = "resetPassword");
		}
	}

	/**
	 * Gets the currently logged in user via their session ID (NOT via url params!)
	 *
	 */
	private function getCurrentlyLoggedInUser() {
		user = model("Contact").findOneByID(value = getSession().id, parameterize = 1);
		if (!IsObject(user)) {
			objectNotFound();
		}
	};

	/**
	 * Redirect away if object can't be found
	 *
	 */
	private function objectNotFound() {
		redirectTo(action = "index", error = "Sorry, your account can't be retrieved");
	}

}
