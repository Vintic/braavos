<cfscript>
mapper(mapFormat = false)
	.scope(package = "public", name = "", path = "")
		// authentication
		.get(name = "login", to = "sessions##new")
		.get(name = "logout", to = "sessions##delete")
		.post(name = "authenticate", to = "sessions##create")
		.get(name = "forgetme", to = "sessions##forget")
		// password reset
		.scope(controller = "passwordresets", path = "password")
			.get(name = "Passwordreset", pattern = "forgot", action = "new")
			.post(name = "Passwordreset", pattern = "forgot", action = "create")
			.get(name = "editPasswordreset", pattern = "recover/[token]", action = "edit")
			.put(name = "updatePasswordreset", pattern = "reset/[token]", action = "update")
		.end()
	.end()
.end();
</cfscript>
