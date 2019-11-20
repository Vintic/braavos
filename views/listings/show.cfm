<cfoutput>

	<cfsilent>
		<cfset local.addressStruct = {} />
		<cfset local.addressStruct.lotNumber = listing.lotNumber />
		<cfset local.addressStruct.unitNumber = listing.unitNumber />
		<cfset local.addressStruct.streetNumber = listing.streetNumber />
		<cfset local.addressStruct.streetName = listing.streetName />
	</cfsilent>
<!--- 		#addressFormat(local.addressStruct)#<br>
		#titleise(listing.suburbName)# #listing.state# #listing.postcode# --->


	<div class="property-page" id="property-layout-page">
		<div id="breadcrumbs">
			<div class="container">
				<ul>
					<li class="first"><a href="/">Home</a></li>
					<li class="first"><a href="##">Buy</a></li>
					<li class="first"><a href="##">VIC</a></li>
					<li class="first"><a href="##">#listing.fullAddress#</a></li>
				</ul>
			</div>
		</div>
		<div class="page-content">
			<div class="page-top-content">
				<div class="container">
					<div class="row _align-start">
						<div class="col-1-1 col-tablet-1-2 col-desktop-2-3">
							<h1 class="page-title">#listing.fullAddress#</h1>
							<div class="property-bbc">
								<cfif getBrand() != 'bus'>
									<cfif Val(listing.bedrooms)><div class="bedrooms"><span>#listing.bedrooms# </span>beds</div></cfif>
									<cfif Val(listing.bathrooms)><div class="bathrooms"><span>#listing.bathrooms# </span>baths</div></cfif>
								</cfif>
								<cfif Val(listing.totalCarSpaces)><div class="carparks"><span>#listing.totalCarSpaces# </span>cars</div></cfif>
							</div>
							<cfif Len(listing.landsize)>
								<div class="property-land-size">
									<span>#listing.landsize# </span> sqm
								</div>
							</cfif>

							<div class="property-type">
								<span>#listing.name#</span>
								<span>for #listing.saleMethod#</span>
							</div>
						</div>
						<div class="col-1-1 col-tablet-1-2 col-desktop-1-3">
							<h2 class="property-price">
								#!isTrue(listing.isPriceHidden) ? listing.priceText : "Contact Agent"#
							</h2>
							<a href="##" class="property-quote-link">Can I afford this home?</a>
						</div>
					</div>  <!--  .page-top-content 1st row end     -->

					<div class="row">
						<div class="col-1-1 col-tablet-1-2 col-desktop-2-3">
							#listing.auctionAt#
						</div>
						<div class="col-1-1 col-tablet-1-2 col-desktop-1-3">
							<div class="property-share-buttons">
								<div class="property-share-button">
									<button class="btn btn-favorite" data-hook="toggle-shortlist" data-id="#listing.id#">Save</button>
								</div>
								<div class="property-share-button">
									<button class="btn btn-prite" data-hook="btn-print">Print</button>
								</div>
								<div class="property-share-button">
									<button class="btn btn-prite" data-hook="btn-share" data-toggle="popup">Share</button>
									<div class="share-popup">
										<span>Share Via ...</span>
										<ul>
											<li class="share-fb" data-hook="share-fb">
												<i class="fab fa-facebook-f"></i>
											</li>
											<li class="share-tw" data-hook="share-tw">
												<i class="fab fa-twitter"></i>
											</li>
											<li class="share-friend" data-hook="share-friend">
												<i class="fas fa-envelope"></i>
											</li>
										</ul>
									</div>
								
								</div>
							</div>
						</div>
					</div> <!--  .page-top-content 2nd row end     -->
				</div>
			</div> <!--  .page-top-content end     -->		

			<div class="property-media">
				<div class="property-hero-image">							
					<cfloop query="images" endrow="1">
						<img src="#getImageURL(images.fileName, 800)#" border="0" />
					</cfloop>
				</div>
				<div class="container">
					<div class="row">
						<div class="col">
							<ul class="property-actions">
								<cfif images.RecordCount GT 0>
									<li data-hook="open-full-photo-viewer">
										<a href="##">
											<span>#images.RecordCount#</span> photos							
										</a>
									</li>	
								</cfif>
								<li data-hook="open-full-photo-viewer-to-floorplans">
									<a href="##"><span>1</span>Floorplans</a>
								</li>
								<li>
									<li><a href="##" data-hook="open-virtual-tour">3D Tour</a></li>
								</li>
								<li class="statement-information">
									<a href="##" target="_blank">Statement of Information</a>
								</li>	
							</ul>
						</div>		
						<div class="agency-logo">
							<img src="#getImageURL(listing.fileName, 160)#"  />
						</div>
					</div>
				</div>

			</div>	<!--  .property-media end     -->

		
		</div> <!--  .page-content end     -->
	</div>
<cfdump var="#listing#"/>
</cfoutput>