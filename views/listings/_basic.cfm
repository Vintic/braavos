<cfoutput>

	<cfset local.addressStruct = {} />
	<cfset local.addressStruct.lotNumber = listings.lotNumber />
	<cfset local.addressStruct.unitNumber = listings.unitNumber />
	<cfset local.addressStruct.streetNumber = listings.streetNumber />
	<cfset local.addressStruct.streetName = listings.streetName />

	<article class="basic listing-item" data-hook="listing-item" data-id="12812056">

		<div class="shortlist-btn" data-hook="listing-shortlist" data-id="12812056">
			<button class="toggle-shortlist" data-hook="toggle-shortlist" data-id="12812056">
				<div class="favorite"><i class="fas fa-heart"></i></div>
			</button>
		</div>

		<div class="gallery featured">
			<div class="image-large">
				<cfif Len(Trim(listings.fileName))>
					<a class="item image-wrap" href="##">
						<img class="image" src="#getImageURL(listings.fileName, 300)#" alt="1C Braemar Street, Mont Albert North VIC 3129">
					</a>
				<cfelse>
					<!--- needs placeholder --->
					<a class="item image-wrap" href="##" style="background: ##eaeaea;"></a>
				</cfif>
			</div>
		</div>

		<div class="content">
			<div class="listing-price">#!isTrue(isPriceHidden) ? listings.priceText : "Contact Agent"#</div>
			<div class="listing-address">
				<h3 class="listing-street">
					<a href="##" class="street-address">#addressFormat(local.addressStruct)#</a>
				</h3 >
				<div class="listing-suburb">#titleise(listings.suburbName)# #listings.state# #listings.postcode# | House</div>
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
				</div>
			</div>
		</div>
	</article>

</cfoutput>