<cfscript>
mapper(mapFormat = false)
	.scope(package = "user", name = "", path = "")
		.resource(name = "account", only = "show,edit,update")
		.get(name = "accountPassword", pattern = "/account/password", to = "accounts##resetPassword")
		.put(name = "accountPassword", pattern = "/account/password", to = "accounts##updatePassword")
		.resources(name = "shortLists", only = "index,create,delete")
		.resources(name = "viewedListings", only = "index,update")
		.resources(name = "searches", only = "index,new,create,edit,update,delete")
		.resources(name = "auctionAlerts", only = "index,create,delete")
	.end()
.end()
</cfscript>
