<cfoutput>

	<cfsilent>
		<cfset local.addressStruct = {} />
		<cfset local.addressStruct.lotNumber = listing.lotNumber />
		<cfset local.addressStruct.unitNumber = listing.unitNumber />
		<cfset local.addressStruct.streetNumber = listing.streetNumber />
		<cfset local.addressStruct.streetName = listing.streetName />
	</cfsilent>

	<div class="container">
		
		<br>

		#addressFormat(local.addressStruct)#<br>
		#titleise(listing.suburbName)# #listing.state# #listing.postcode#
		<br><br>


		Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.

		<br><br><hr><br>

		<cfdump var="#listing#"/>
		<cfloop query="images">
			<img src="#getImageURL(images.fileName, 800)#" border="0" width="800" />
		</cfloop>

	</div>

</cfoutput>