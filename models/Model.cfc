/**
 * This is the parent model file that all your models should extend.
 * You can add functions to this file to make them available in all your models.
 * Do not delete this file.
 */
component extends="wheels.Model" {

	function config(boolean sanitiseDates = true) {
		if (arguments.sanitiseDates) {
			beforeValidation("sanitiseDateInputs");
		}
	}

	// TODO: nested properties
	private void function sanitiseDateInputs() {
		function usesDateColumnConvention(required string key) {
			return Right(arguments.key, 4) == "date" || Right(arguments.key, 2) == "at"
		}

		local.dateProperties = this
			.properties()
			.filter(function(key, value) {
				return IsSimpleValue(value) && usesDateColumnConvention(key) && Len(value);
			})
			.filter(function(key, value) {
				return ArrayFindNoCase(["createdat", "updatedat", "deletedat"], key) == 0;
			})
			.filter(function(key, value) {
				return Left(value, 1) != "{";
			});

		local.dateProperties.each(function(key, value) {
			try {
				if (ListLen(value, "/-:") gt 3) {
					this[key] = parseDateTimeString(value)
				} else if (ListLen(value, "/-:") == 3) {
					this[key] = parseDateString(value)
				}
			} catch (any e) {
				this.addError(property = key, message = "#humanize(key)# is not a valid date");
			}
		});
	}

	/**
	 * Simple sanitization: this could probably be improved somewhat.
	 *
	 */
	private function sanitizeInput(string) {
		local.rv = ReReplaceNoCase(
			arguments.string,
			"<\ *[a-z].*?>",
			"",
			"all"
		);
		local.rv = ReReplaceNoCase(
			local.rv,
			"<\ */\ *[a-z].*?>",
			"",
			"all"
		);
		local.rv = Trim(HtmlEditFormat(local.rv));
		return local.rv;
	}

	/**
	 * Converts list of dates to utc.
	 *
	 */
	public function convertDatesToUtc(required string timezone) {
		for (local.thisDate in variables.datesRequiringUtcConversion) {
			if (this.propertyIsPresent(local.thisDate)) {
				this[local.thisDate] = localToUTCDate(timezone = arguments.timezone, date = this[local.thisDate]);
			}
		}
	}

	/**
	 * Converts list of dates to local.
	 *
	 */
	public function convertDatesToLocal(required string timezone) {
		for (local.thisDate in variables.datesRequiringUtcConversion) {
			if (this.propertyIsPresent(local.thisDate)) {
				this[local.thisDate] = utcToLocalDate(timezone = arguments.timezone, date = this[local.thisDate]);
			}
		}
	}

	/**
	 * Attempt to work out which model is calling a function
	 */
	private function getCallingModelName() {
		return Replace(
			GetMetadata(this)["fullname"],
			"wheels....models.",
			"",
			"all"
		);
	}

	/**
	 * Stores an event in the database and writes instance changes to a JSON packet on S3
	 *
	 * [section: Application]
	 * [category: Model]
	 *
	 * @type Either insert, update, delete or do
	 * @description A human readable string describing the event
	 * @changeSource The source of the event. Use for storing changes from 3rd parties
	 */
	// TODO: return a value/s that can be unit tested
	private function storeChanges(
		required string type,
		string description = "#titleize(arguments.type)# #LCase(getCallingModelName())# #this.id ?: ""#",
		string changeSource = ""
	) {
		if (isTrue(this.createChange ?: true)) {
			local["changed"] = {
				"properties" = this.allChanges(),
				"model" = getCallingModelName() // , // "key" = this.key()
			};

			this.ignoreLogProperties = ListAppend((this.ignoreLogProperties ?: ""), "updatedAt");
			// If the calling model doesn't want us to log a sensitive value, remove it.
			for (local.property in ListToArray(this.ignoreLogProperties)) {
				if (StructKeyExists(local.changed.properties, property)) {
					StructDelete(local.changed.properties, property);
				}
			}

			// sanitise input
			if (arguments.type == "update") {
				// TODO: use map()
				for (local.property in local.changed.properties) {
					local.changed.properties[local.property] = {
						"property" = LCase(local.property),
						"changedFrom" = stripNonKeyboardCharacters(local.changed.properties[local.property].changedFrom),
						"changedTo" = stripNonKeyboardCharacters(local.changed.properties[local.property].changedTo)
					};
				}
			}

			// insert parent event record
			// don't update if there are no changes..
			if (!(arguments.type == "update" && StructIsEmpty(local.changed.properties))) {
				local.event = model("Change").create(
					uuid = LCase(CreateUUID()),
					modelName = local.changed.model,
					changeType = arguments.type,
					keyValue = this.id,
					administratorId = "",
					agentId = "",
					description = stripNonKeyboardCharacters(arguments.description),
					changeSource = arguments.changeSource,
					userAgent = cgi.user_agent,
					ipAddress = getIPAddress()
				);

				if (!StructIsEmpty(local.changed.properties)) {
					local.json = SerializeJSON(local.changed);
					local.json = convertFileContentToBase64(local.json, "json");
					local.destinationFilePath = getPath("change", "#local.event.uuid#.json");
					service("s3").putObject(key = local.destinationFilePath, object = local.json); // TODO: explicit private acl
				}
			}
		}
	}

	/**
	 * Returns an array of error message strings
	 *
	 * [section: Application]
	 * [category: Error Functions]
	 *
	 */
	public array function allErrorMessages() {
		local.returnValue = []
		for (local.error in this.allErrors()) {
			local.returnValue.Append(local.error.message);
		}
		return local.returnValue;
	}

}
