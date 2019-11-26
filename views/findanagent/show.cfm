<cfoutput>
	<div class="rev__border-top">
		<div class="rev__container">
			<div class="row">
				<div class="col-1-1">
					Backgrond image: #findAnImage.fileName#
					<cfif Len(findAnImage.fileName)>
						<br><img src="#getImageURL(findAnImage.fileName, 300)#">
					</cfif>
				</div>
			</div>
			<div class="row">
				<div class="col-1-1">
					Office Logo: #officeLogos.fileName#
					<cfif Len(officeLogos.fileName)>
						<br><img src="#getImageURL(officeLogos.fileName, 300)#">
					</cfif>
				</div>
			</div>
			<div class="row">
				<div class="col-1-1">
					Office Name: #office.officeName#<br>
					FindAnAgent Name: #office.findAnAgentName#<br>
					Suburb: #office.suburb.suburbName#<br>
					<cfset local.addressStruct = {}>
					<cfset local.addressStruct.addressLine1 = office.addressLine1>
					<cfset local.addressStruct.addressLine2 = office.addressLine2>
					Address: #lineAddressFormat(local.addressStruct)#<br>
					Phone: #office.phone#<br>
					www: #office.website#<br>
					Facebook: #office.facebook#<br>
					Twitter: #office.twitter#<br>
					LinkedIn: #office.linkedin#<br>
					For Sale count: #onmarketSale#<br>
					For Rent count: #onmarketLease#<br>
					Sold count: #onmarketSold#<br>
				</div>
			</div>
			<br>
			<div class="row">
				<div class="col-1-1">
					About our agency:<br>
					#htmlify(office.profile)#
				</div>
			</div>
			<br>
			<div class="row">
				<div class="col-1-1">
					Specialties:<br><br>
					Listing Type:<br>
					<cfloop query="officeListingTypes">
						#officeListingTypes.listingCategory# #officeListingTypes.name#<br>
					</cfloop>
					<br>
					Property Type:<br>
					<cfloop query="officeSpecialtyPropertyTypes" group="listingCategory">
						#officeSpecialtyPropertyTypes.listingCategory#<br>
						<cfloop>
						#officeSpecialtyPropertyTypes.name#<br>
						</cfloop>
					</cfloop>
				</div>
			</div>
			<br>
			<div class="row">
				<div class="col-1-1">
					Our people (#agents.recordCount#):<br>
					<cfloop query="agents">
						Agent Image: #agents.fileName#
						<cfif Len(agents.fileName)>
							<br><img src="#getImageURL(agents.fileName, 300)#">
						</cfif>
						<br>
						#linkTo(route="agent", key=agents.id, text=agents.agentName, params="officeId=#params.key#")#<br>
						#agents.position#<br>
						<br>
					</cfloop>
				</div>
			</div>
		</div>
	</div>

</cfoutput>
