<cfoutput>
	<div class="row">
		<div class="col-xs-12 col-title">
			<h3><span>More properties from </span><a href="##">#titleise(listing.findAnAgentName)#</a></h3>
			<a href="##"><span>See all</span></a>
		</div>
	</div>
	<div class="row">
		<cfloop from="1" to="3" index="i">
			<div class="col-xs-12 col-sm-6 col-md-4 col-property">
				<div class="col-property-wrapper">
					<a href="##">
						<span class="col-property-wrapper__image">
							<img class="image" title="Property title" alt="Property title" src="../assets/images/placeholder-house.jpg">
						</span>
						<span class="col-property-wrapper__price">
							<span>From $780,000</span>
						</span>
						<span class="col-property-wrapper__address">
							<span>7 Tulip Grove, Cheltenham</span>
						</span>
						<span class="col-property-wrapper__bbc">
							<cfif getBrand() != 'bus'>
								<span class="bedrooms"><strong>3</strong> Beds</span>
								<span class="bathrooms"><strong>2</strong> Bath</span>
							</cfif>
							<span class="car"><strong>2</strong> Car</span>
						</span>
					</a>
				</div>
			</div>
		</cfloop>
	</div>
</cfoutput>