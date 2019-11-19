<cfoutput>

	<cfset local.addressStruct = {} />
	<cfset local.addressStruct.lotNumber = listings.lotNumber />
	<cfset local.addressStruct.unitNumber = listings.unitNumber />
	<cfset local.addressStruct.streetNumber = listings.streetNumber />
	<cfset local.addressStruct.streetName = listings.streetName />

	<cfset local.brandColour = Len(Trim(listings.brandColour)) ? listings.brandColour : 'ffffff' />
	<cfset local.brandContrastColour = Len(Trim(listings.brandContrastColour)) ? listings.brandContrastColour : '000000' />

	<article class="featured listing-item" data-hook="listing-item" data-id="12812056">
		<div class="featured-top-bar" style="background-color: ###brandColour#">
			<img src="#getImageURL(listings.OfficeImagefileName)#" alt="#listings.officeName#">
		</div>

		<div class="gallery featured flex">
			<div class="image-large">
				<cfif Len(Trim(listings.fileName))>
					<a class="item image-wrap" href="#urlFor(route='listingShow', key=listings.id)#">
						<img class="image" src="#getImageURL(listings.fileName, 800)#" alt="1C Braemar Street, Mont Albert North VIC 3129">
					</a>
				<cfelse>
					<!--- needs placeholder --->
					<a class="item image-wrap" href="#urlFor(route='listingShow', key=listings.id)#" style="background: ##eaeaea;"></a>
				</cfif>
			</div>
		</div>
		<div class="content">
			<div class="listing-price">#!isTrue(isPriceHidden) ? listings.priceText : "Contact Agent"#</div>
			<div class="listing-address">
				<h3 class="listing-street">
					<a href="#urlFor(route='listingShow', key=listings.id)#" class="street-address">#addressFormat(local.addressStruct)#</a>
				</h3 >
				<div class="listing-suburb">#titleise(listings.suburbName)# #listings.state# #listings.postcode# | #name#</div>
			</div>
			<div class="property-details">
				<div class="bbc">
					<cfif getBrand() != 'bus'>
						<cfif Val(listings.bedrooms)><div class="bedrooms"><i class="fas fa-bed"></i><span>#listings.bedrooms#</span></div></cfif>
						<cfif Val(listings.bathrooms)><div class="bathrooms"><i class="fas fa-bath"></i><span>#listings.bathrooms#</span></div></cfif>
					</cfif>
					<cfif Val(listings.totalCarSpaces)><div class="carparks"><i class="fas fa-car"></i><span>#listings.totalCarSpaces#</span></div></cfif>
				</div>
				<div class="additional-info">
					<cfif Len(Trim(listings.virtualTourURL))>
						<a href="#listings.virtualTourURL#" class="virtual-tour" data-hook="open-virtual-tour" target="_blank">
							<i class="fas fa-vr-cardboard"></i>
							<span class="mobile-hide-inline">VR Inspect</span>
						</a>
					</cfif>
					<cfif Len(Trim(listings.videoURL))>
						<a href="#listings.videoURL#" class="virtual-tour" data-hook="open-virtual-tour" target="_blank">
							<i class="far fa-play-circle"></i>
							<span class="mobile-hide-inline">Video</span>
						</a>
					</cfif>
					<!-- this can be Updated or UNDER OFFER -->
					<span class="flag-status flag-updated">Updated</span>
					<span class="flag-status flag-new">New</span>
				</div>
			</div>
		</div>

		<div class="agent-details" style="background-color: ###brandColour#; color: ###brandContrastColour#;">
			<div class="agency-logo">
				<img src="#getImageURL(listings.OfficeImagefileName)#" alt="#listings.officeName#" >
			</div>
			<div class="agent-photo-name-wrap">
				<div class="agent-name">Bill Chung</div>
				<div class="agent-photo image-wrap">
					<img class="image" title="Bill Chung" alt="Profile photo of Bill Chung" src="assets/images/agent01.jpg">
				</div>
			</div>
			<div class="agency-address">#listings.addressLine1##Len(Trim(listings.addressLine2)) ? ", #listings.addressLine2#" : ''#, Camberwell</div>
			<div class="contact-agency-email" data-hook="contact-agency-email">
				<i class="fas fa-envelope"></i>
				<span>Contact Agent</span>
			</div>
		</div>
	</article>

</cfoutput>