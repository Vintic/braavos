<cfoutput>
<div class="property-mores">
	<div class="property-mores__title">
		<h2><span>More properties from </span><a href="##">#titleise(listing.findAnAgentName)#</a></h2>
		<a href="##"><span>See all</span></a>
	</div>
	<div class="row">
		<cfloop from="1" to="3" index="i">
			<div class="col-1-1 col-tablet-1-3 property-more">
				<a class="property-more-wrapper" href="##">
					<span class="property-more-wrapper__image">
						<img class="image" title="Property title" alt="Property title" src="../assets/images/placholder-house.jpg">
					</span>
					<div class="property-more-wrapper__detail">
						<span class="property-more-wrapper__detail-price">
							<span>From $780,000</span>
						</span>
						<span class="property-more-wrapper__detail-address">
							<span>7 Tulip Grove, Cheltenham</span>
						</span>
						<span class="property-more-wrapper__detail-bbc">
							<cfif getBrand() != 'bus'>
								<span class="bedrooms"><strong>3</strong> Beds</span>
								<span class="bathrooms"><strong>2</strong> Bath</span>
							</cfif>
							<span class="car"><strong>2</strong> Car</span>
						</span>
					</div>
				</a>
			</div>
		</cfloop>
	</div>
</div>
</cfoutput>