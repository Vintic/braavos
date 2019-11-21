<cfoutput>
	<div class="wrapper">
		<h2 class="title">Recent Sales</h2>
		<div class="brief">See what properties like this have been selling for</div>
		<div class="inner-wrapper">
			<ul>
				<cfloop from="1" to="3" index="i">
					<li class="card card__#i#">
						
						<div class="card-photos image-large">
							<span class="item image-wrap" >
								<img class="image" src="../assets/images/placholder-house.jpg" alt="1C Braemar Street, Mont Albert North VIC 3129">
							</span>
							<span class="item image-wrap" >
								<img class="image" src="../assets/images/placholder-house.jpg" alt="1C Braemar Street, Mont Albert North VIC 3129">
							</span>
							<span class="item image-wrap" >
								<img class="image" src="../assets/images/placholder-house.jpg" alt="1C Braemar Street, Mont Albert North VIC 3129">
							</span>
						</div>
						<div class="card-info">
							<div class="card-info__price">
								<span class="card-info__price-text">$950,000</span>
								<span class="card-info__sold-date">Sold Mar 2, 2019</span>
							</div>
							<div class="card-info__details">
								<span class="card-info__address">66 Tulip Grove, Cheltenham 3192</span>
								<span class="card-info__bbc">
									<cfif getBrand() != 'bus'>
										<span>
											<span class="card__number">3</span> Beds
										</span>
										<span>
											<span class="card__number">2</span> Baths
										</span>
									</cfif>
									<span>
										<span class="card__number">2</span> Car
									</span>
								</span>
							</div>
						</div>
					</li>  <!--  .card end     -->
				</cfloop>

			</ul>
		</div>
	</div>
</cfoutput>
