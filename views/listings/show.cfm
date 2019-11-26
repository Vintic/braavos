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
					<li><a href="/">Home</a></li>
					<li><a href="##">Buy</a></li>
					<li><a href="##">VIC</a></li>
					<li><a href="##">#titleise(listing.fullAddress)#</a></li>
				</ul>
			</div>
		</div>
		<div class="page-content">
			<div class="page-top-content">
				<div class="container">
					<div class="row row-top">
						<div class="col-1-1 col-tablet-1-2 col-desktop-2-3">
							<h1 class="page-title">#titleise(listing.fullAddress)#</h1>
							<div class="property-attributes">
								<div class="property-attribute property-attribute__bbc">
									<cfif getBrand() != 'bus'>
										<cfif Val(listing.bedrooms)><span class="bedrooms"><span>#listing.bedrooms# </span>beds</span></cfif>
										<cfif Val(listing.bathrooms)><span class="bathrooms"><span>#listing.bathrooms# </span>baths</span></cfif>
									</cfif>
									<cfif Val(listing.totalCarSpaces)><span class="carparks"><span>#listing.totalCarSpaces# </span>cars</span></cfif>
								</div>
								<cfif Len(listing.landsize)>
									<div class="property-attribute property-attribute__size">
										<span>#listing.landsize# </span> sqm
									</div>
								</cfif>

								<div class="property-attribute property-attribute__method">
									<span>#listing.name#</span>
									<span>for #listing.saleMethod#</span>
								</div>
							</div>
						</div>
						<div class="col-1-1 col-tablet-1-2 col-desktop-1-3 ">
							<h2 class="property-price">
								#!isTrue(listing.isPriceHidden) ? listing.priceText : "Contact Agent"#
							</h2>
							<a href="##" class="property-quote-link">Can I afford this home?</a>
						</div>
					</div>  <!--  .page-top-content 1st row end     -->

					<div class="row row-bottom">
						<div class="col-1-1 col-tablet-1-2 col-desktop-2-3">
							<span><strong>Auction </strong>Saturday, November 16, 2019, 12:30 PM</span>
							<button class="btn auction-btn" data-hook="save-auction"><span>Add to Calendar </span></button>
						</div>
						<div class="col-1-1 col-tablet-1-2 col-desktop-1-3">
							<div class="property-share-actions">
								<div class="property-share-action">
									<button class="btn btn-favorite" data-hook="toggle-shortlist" data-id="#listing.id#">Save</button>
								</div>
								<div class="property-share-action">
									<button class="btn btn-print" data-hook="btn-print">Print</button>
								</div>
								<div class="property-share-action">
									<button class="btn btn-share" data-hook="btn-share" data-toggle="popup">Share</button>
									<div class="share-popup">
										<span>Share Via ...</span>
										<ul>
											<li class="share-fb" data-hook="share-fb">
												<a href="##" target="_blank"><i class="fab fa-facebook-f"></i></a>
											</li>
											<li class="share-tw" data-hook="share-tw">
												<a href="##" target="_blank"><i class="fab fa-twitter"></i></a>
											</li>
											<li class="share-friend" data-hook="share-friend">
												<a href="##" target="_blank"><i class="fas fa-envelope"></i></a>
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
				<div class="property-actions">
					<div class="container">
						<div class="row">
							<div class="col">
								<ul>
									<cfif images.RecordCount GT 0>
										<li data-hook="open-full-photo-viewer">
											<a href="##">
												<span>#images.RecordCount#</span> Photos							
											</a>
										</li>	
									</cfif>
									<li data-hook="open-full-photo-viewer-to-floorplans">
										<a href="##"><span>1</span>Floorplans</a>
									</li>
									<li>
										<a href="##" data-hook="open-virtual-tour">3D Tour</a>
									</li>
									<li class="statement-information">
										<a href="##" target="_blank">Statement of Information</a>
									</li>	
								</ul>
							</div>		
						</div>
					</div>
				</div>
			</div>	<!--  .property-media end     -->
			<div class="property-details">
				<div class="container">	
					<div class="row">
						<div class="col-1-1 col-tablet-1-2 col-desktop-2-3">
							<div class="property-info property-intro">
								<h2 class="property-intro__title">
									<span>#listing.heading#</span>
								</h2>
								<div class="brief property-intro__saletype">
									<span>#addressFormat(local.addressStruct)#</span> for <span>#listing.saleMethod#</span>
								</div>
								<div class="description property-intro__description">
									<article>#htmlify(listing.description)#</article>	
									<a href="##" id ="description-toggle"><span>READ MORE</span></a>
								</div>
							</div>   <!--  .property-intro end     -->
			

							<div class="property-info property-map">
								<div class="static-map">
									<img class="image" title="Bill Chung" alt="Static Map" src="../assets/images/map.png">
								</div>
								<div class="brief property-magigraph">
									<p>5 Calembeena Avenue, Hughesdale is for sale through an agent from Woodards Carnegie. It has 3 bedrooms, 2 bathrooms and 1 parking spots. Don't forget to favourite it by clicking the heart icon at the top of the page contact the agent via phone or email form.</p>
								</div>
							</div> <!--  .property-map end     -->

							<cfif getBrand() == 'res'>
								<div class="property-info property-inspection">
									<h2 class="title">Inspection Times</h2>
									<ul>
										<li itemprop="events" itemscope="" itemtype="https://schema.org/Event">
					                        <meta itemprop="startDate" content="2019-11-23T10:00:00+00:00">
					                        <meta itemprop="endDate" content="2019-11-23T10:30:00+00:00">
					                        <meta itemprop="location" content="2/21 Heather Grove, Cheltenham VIC 3192">
					                        <meta itemprop="name" content="Inspection">
					                        <h3>Saturday</h3>
					                        <span>23 November</span>
					                        <span>10:00 AM - 10:30 AM</span>
											<button data-hook="save-inspection" data-inspection-number="0"><span>Add to Calendar</span></button>
					                    </li>
					                    <li itemprop="events" itemscope="" itemtype="https://schema.org/Event">
					                        <meta itemprop="startDate" content="2019-11-23T10:00:00+00:00">
					                        <meta itemprop="endDate" content="2019-11-23T10:30:00+00:00">
					                        <meta itemprop="location" content="2/21 Heather Grove, Cheltenham VIC 3192">
					                        <meta itemprop="name" content="Inspection">
					                        <h3>Saturday</h3>
					                        <span>23 November</span>
					                        <span>10:00 AM - 10:30 AM</span>
											<button data-hook="save-inspection" data-inspection-number="0"><span>Add to Calendar</span></button>
					                    </li>
					                    <li itemprop="events" itemscope="" itemtype="https://schema.org/Event">
					                        <meta itemprop="startDate" content="2019-11-23T10:00:00+00:00">
					                        <meta itemprop="endDate" content="2019-11-23T10:30:00+00:00">
					                        <meta itemprop="location" content="2/21 Heather Grove, Cheltenham VIC 3192">
					                        <meta itemprop="name" content="Inspection">
					                        <h3>Saturday</h3>
					                        <span>23 November</span>
					                        <span>10:00 AM - 10:30 AM</span>
											<button data-hook="save-inspection" data-inspection-number="0"><span>Add to Calendar</span></button>
					                    </li>
					                    <li itemprop="events" itemscope="" itemtype="https://schema.org/Event">
					                        <meta itemprop="startDate" content="2019-11-23T10:00:00+00:00">
					                        <meta itemprop="endDate" content="2019-11-23T10:30:00+00:00">
					                        <meta itemprop="location" content="2/21 Heather Grove, Cheltenham VIC 3192">
					                        <meta itemprop="name" content="Inspection">
					                        <h3>Saturday</h3>
					                        <span>23 November</span>
					                        <span class="auction-time">Auction - 12:30PM</span>
											<button data-hook="save-inspection" data-inspection-number="0"><span>Add to Calendar</span></button>
					                    </li>
									</ul>

									<div class="web-inspection-cta">
										<span>Times don't suit? </span><a href="##" data-hook="contact-inspection-email">Email Agent</a><span> to make an appointment</span>
									</div>
								</div> <!--  .property-inspection end     -->
							</cfif>

							<cfif getBrand() == 'res'>
								<div class="property-info property-schools">
									#includePartial("property/_schools")#
								</div> <!--  .property-schools end     -->
							</cfif>

							<div class="property-info property-recent-sales">
								#includePartial("property/_recents")#
							</div> <!--  .property-recent-sales end     -->

							<div class="property-info pocket-insights">
								#includePartial("property/_neighboures")#
							</div> <!--  .property-recent-sales end     -->

							<div class="property-info property-trends">
								#includePartial("property/_trends")#
							</div> <!--  .property-trends end     -->
						</div>  <!--  .col-desktop-2-3 end     -->

						<div class="col-1-1 col-tablet-1-2 col-desktop-1-3">
							<div class="sidebar property-sidebar">
								<div class="agency-logo" style="background-color: ##272727">
									<img src="#getImageURL(listing.fileName, 30)#" />
								</div>   <!--  .agentcy-logo end     -->
								<div class="sidebar-wrapper">	
									<div class="sidebar-content agency-wrapper">
										<div class="agency-contact">
											<div class="agents">
												<div class="agent">
													<div class="agent-photo">
														<img class="image" title="Bill Chung" alt="Profile photo of Bill Chung" src="../assets/images/agent02.jpg">
													</div>									
													<div class="agent-detail">
														<span class="agent-detail__name">Clare Adams</span>
														<a class="agent-detail__profile" href="##">View Profile</a>
													</div>
													<div class="agent-phone">
														<a href="tel:0412345678">0432 640 789</a>
													</div>
												</div>

												<div class="agent">
													<div class="agent-photo">
														<img class="image" title="Bill Chung" alt="Profile photo of Bill Chung" src="../assets/images/agent02.jpg">
													</div>									
													<div class="agent-detail">
														<span class="agent-detail__name">Clare Adams</span>
														<a class="agent-detail__profile" href="##">View Profile</a>
													</div>
													<div class="agent-phone">
														<a href="tel:0412345678">0432 640 789</a>
													</div>
												</div>
											</div>
										</div>  <!--  .agentcy-contact end     -->
										<div class="agency-enquiry-form">
											<form action="##" id="agency-enquiry-form" class="form enquiry-form">
												<input type="hidden" name="property" id="property" value=""  />
												<h4>Your Detail</h4>
												<fieldset>
													<div class="field">
														<input type="text" name="name" class="input-field" id="name" placeholder="Name" value="" required />
													</div>
													<div class="field">
														<input type="tel" name="phone" class="input-field" id="phone" placeholder="Phone" value="" required />
													</div>
													<div class="field">
														<input type="email" name="email" class="input-field" id="email" placeholder="Email" value="" required />
													</div>
													<div class="field">
														<textarea name="message" class="input-field" id="message" placeholder="Message (optional)" value=""></textarea>	
													</div>
												</fieldset>	
												<button type="submit" class="button btn-submit"><span>Email Agent</span></button>
											</form>
										</div>  <!--  .agentcy-enquiry-form end     -->
										<ul class="property-share-buttons">
											<li class="share-button">
												<button class="btn btn-favorte" data-hook="toggle-shortlist" data-id="12345678">
													<span>Save</span>
												</button>
											
											</li>
											<li class="share-button">
												<button class="btn btn-favorte" data-hook="btn-print" data-id="12345678">
													<span>Print</span>
												</button>
											</li>
											<li>
												<button class="btn btn-favorte" data-hook="btn-share" data-id="12345678">
													<span>Share</span>
												</button>
											</li>
										</ul>	
									</div> <!--  .sidebar-content end     -->
									<div class="sidebar-footer">
										<p>By submitting your details, you acknowledge that you accept our Privacy Collection Statement</p>
									</div>
								</div>
							</div>
						</div>  <!--  .col-desktop-1-3 end     -->
					</div>	<!--  .property-details row 1 end     -->

					<!--  .property-more-property start    -->
					#includePartial("property/_moreproperties")#
					<!--  .property-more-propert end     -->
					
					<section class="property-parter-links partner-links">
						<h2>View Network</h2>
						<div class="row">
						    <article class="partner-business col-tablet-1-3">
						    	<a class="logo" href="/?brand=bus">
						        	<img class="image" src="../assets/images/realestateview_logo_hero_rgb.svg">
						      	</a>
						        <h3><a href="/?brand=bus">Businesses For Sale</a></h3>
						        <p>Retail, industrial, construction &amp; more businesses.</p>
						    </article>
						    <article class="partner-holiday col-tablet-1-3">
						    	<a class="logo" href="/?brand=hol">
						        	<img class="image" src="../assets/images/realestateview_logo_hero_rgb.svg">
						      	</a>
						        <h3><a href="/?brand=hol">Holiday Rentals</a></h3>
						        <p>Holiday rental accommodation to suit your needs.</p>
						    </article>
						    <article class="partner-rural col-tablet-1-3">
						    	<a class="logo" href="/?brand=rur">
						        	<img class="image" src="../assets/images/realestateview_logo_hero_rgb.svg">
						      	</a>
						        <h3><a href="/?brand=rur">Rural Properties for Sale</a></h3>
						        <p>Farmland, rural land and lifestyle properties.</p>
						    </article>
						</div>
					</section>
					
				</div> <!--  .property-details container end     -->
			</div> <!--  .property-details end     -->

		</div> <!--  .page-content end     -->

		<cfif getBrand() == 'res1'>
			<div class="map-modal-popup">
				<div class="modal-overlay"></div>
				<div class="modal-wrapper">
					<div class="modal-close"></div>
					<div class="modal-inner-wrapper">
						<iframe src="https://www.google.com/maps/embed?pb=!1m16!1m12!1m3!1d50432.36385702506!2d144.9629285353186!3d-37.8129363164936!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!2m1!1s1%20Bourke%20Street%2C%20Melbourne%20University%2C%20VIC%203052!5e0!3m2!1sen!2sau!4v1574292145486!5m2!1sen!2sau" width="800" height="600" frameborder="0" style="border:0;" allowfullscreen=""></iframe>
					</div>
				</div>
			</div>
		</cfif>

	</div> <!--  .property-page end     -->
</cfoutput>