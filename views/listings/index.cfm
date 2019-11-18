<div id="search-results-page" class="listing-page">

	<section id="search-banner">
		<div class="container">
			<div class="wrapper">
					<div class="search-banner-nav">
				<div class="filter-header flex _justify-space-between">
	        		<a class="toggle-mobile-search-banner"><i class="fas fa-arrow-left"></i>Select Filters</a>
	          		<a class="reset-search-banner"><i class="fas fa-redo-alt"></i>Reset</a>
		        </div>
	      	</div>

			<div class="form-container">
				<ul class="search-options top-links flex _wrap">
					<li class="search-type"><a class="active" href="#">BUY</a></li>
					<li class="search-type"><a href="#">RENT</a></li>
					<li class="search-type"><a href="#">SOLD</a></li>
				</ul>
				<form>
					<ul class="search-options flex _align-center _wrap">

						<li class="search-address flex-grow">
							<div class="search-input flex _justify-space-between _align-center _wrap">
								<span><i class="fas fa-search"></i></span>
								<span class="location-wrap"><input id="location" class="form-control placeholder-loading" data-role="tagsinput" autocomplete="off" placeholder="Search by suburb, postcode or area" name="location" type="text"></span>
							</div>
						</li>

						<li class="search-item search-option dropdown-option property-price">
							<div class="dropdown-heading">
								<label class="chevron">Price</label>
								<span class="value" data-select-value="target2">Any</span>
								<span class="value" data-select-value="target3"></span>
							</div>
							<ul class="dropdown-container flex">
								<ol class="property-price-min price-select">
									<div class="selected-option">Any</div>
									<div class="option-container" data-select data-select-target="target2">
										<li>
											<input type="radio" id="min_price_any" name="home_search_min_price" value="Any" checked>
										  <label for="min_price_any">Any</label>
										</li>
										<li>
											<input type="radio" id="min_price_50" name="home_search_min_price" value="$50k">
										  <label for="min_price_50">$50k</label>
										</li>
										<li>
											<input type="radio" id="min_price_150" name="home_search_min_price" value="$100k">
										  <label for="min_price_150">$100k</label>
										</li>
										<li>
											<input type="radio" id="min_price_100" name="home_search_min_price" value="$150k">
										  <label for="min_price_100">$150k</label>
										</li>
										<li>
											<input type="radio" id="min_price_200" name="home_search_min_price" value="$200k">
										  <label for="min_price_200">$200k</label>
										</li>
										<li>
											<input type="radio" id="min_price_250" name="home_search_min_price" value="$250k">
										  <label for="min_price_250">$250k</label>
										</li>
										<li>
											<input type="radio" id="min_price_300" name="home_search_min_price" value="$300k">
										  <label for="min_price_300">$300k</label>
										</li>
									</div>
								</ol>
								<ol class="property-price-max price-select">
									<div class="selected-option">Any</div>
									<div class="option-container" data-select data-select-target="target3">
										<li>
											<input type="radio" id="max_price_any" name="home_search_max_price" value="" checked>
										  <label for="max_price_any">Any</label>
										</li>
										<li>
											<input type="radio" id="max_price_50" name="home_search_max_price" value="$50k">
										  <label for="max_price_50">$50k</label>
										</li>
										<li>
											<input type="radio" id="max_price_150" name="home_search_max_price" value="$100k">
										  <label for="max_price_150">$100k</label>
										</li>
										<li>
											<input type="radio" id="max_price_100" name="home_search_max_price" value="$150k">
										  <label for="max_price_100">$150k</label>
										</li>
										<li>
											<input type="radio" id="max_price_200" name="home_search_max_price" value="$200k">
										  <label for="max_price_200">$200k</label>
										</li>
										<li>
											<input type="radio" id="max_price_250" name="home_search_max_price" value="$250k">
										  <label for="max_price_250">$250k</label>
										</li>
										<li>
											<input type="radio" id="max_price_300" name="home_search_max_price" value="$300k">
										  <label for="max_price_300">$300k</label>
										</li>
									</div>
								</ol>
							</ul>
						</li>

						<li class="search-item search-option dropdown-option property-bed">
							<div class="dropdown-heading">
								<label class="chevron">Bedrooms</label>
								<span class="value" data-select-value="target4">Any</span>
							</div>
							<ul class="dropdown-container" data-select data-select-target="target4">
								<li>
									<input type="radio" id="bed_any" name="home_search_bed" value="Any" checked>
								  <label for="bed_any">Any</label>
								</li>
								<li>
									<input type="radio" id="bed_1" name="home_search_bed" value="1">
								  <label for="bed_1">1+</label>
								</li>
								<li>
									<input type="radio" id="bed_2" name="home_search_bed" value="2">
								  <label for="bed_2">2+</label>
								</li>
								<li>
									<input type="radio" id="bed_3" name="home_search_bed" value="3">
								  <label for="bed_3">3+</label>
								</li>
								<li>
									<input type="radio" id="bed_4" name="home_search_bed" value="4">
								  <label for="bed_4">4+</label>
								</li>
								<li>
									<input type="radio" id="bed_5" name="home_search_bed" value="5">
								  <label for="bed_5">5+</label>
								</li>
							</ul>
						</li>

						<li class="search-item toggle-btn-wrap">
							<div class="dropdown-heading toggle-search-options mobile-hide">
								<label class="chevron">More Filters</label>
								
							</div>
							<ul class="hidden-options search-page-dropdown">
								<li class="search-option un-responcive dropdown-option property-bath">
									<div class="dropdown-heading">
										<label>Bathrooms</label>
										<span class="value" data-select-value="target5">Any</span>
									</div>
									<ul class="dropdown-container" data-select data-select-target="target5">
										<li>
											<input type="radio" id="bath_any" name="home_search_bath" value="Any" checked>
										  	<label for="bath_any">Any</label>
										</li>
										<li>
											<input type="radio" id="bath_1" name="home_search_bath" value="1">
										  <label for="bath_1">1+</label>
										</li>
										<li>
											<input type="radio" id="bath_2" name="home_search_bath" value="2">
										  <label for="bath_2">2+</label>
										</li>
										<li>
											<input type="radio" id="bath_3" name="home_search_bath" value="3">
										  <label for="bath_3">3+</label>
										</li>
										<li>
											<input type="radio" id="bath_4" name="home_search_bath" value="4">
										  <label for="bath_4">4+</label>
										</li>
										<li>
											<input type="radio" id="bath_5" name="home_search_bath" value="5">
										  <label for="bath_5">5+</label>
										</li>
									</ul>
								</li>
								<li class="search-option un-responcive dropdown-option property-car">
									<div class="dropdown-heading">
										<label>Car Parks</label>
										<span class="value" data-select-value="target6">Any</span>
									</div>
									<ul class="dropdown-container" data-select data-select-target="target6">
										<li>
											<input type="radio" id="car_any" name="home_search_car" value="Any" checked>
										  	<label for="car_any">Any</label>
										</li>
										<li>
											<input type="radio" id="car_1" name="home_search_car" value="1">
										  <label for="car_1">1+</label>
										</li>
										<li>
											<input type="radio" id="car_2" name="home_search_car" value="2">
										  <label for="car_2">2+</label>
										</li>
										<li>
											<input type="radio" id="car_3" name="home_search_car" value="3">
										  <label for="car_3">3+</label>
										</li>
										<li>
											<input type="radio" id="car_4" name="home_search_car" value="4">
										  <label for="car_4">4+</label>
										</li>
										<li>
											<input type="radio" id="car_5" name="home_search_car" value="5">
										  <label for="car_5">5+</label>
										</li>
									</ul>
								</li>
								<li class="search-option un-responcive dropdown-option property-options">
									<div class="dropdown-heading">
										<label>Property Type</label>
										<span class="value" data-select-value="target1">All</span>
									</div>
									<ul class="dropdown-container" data-select data-select-target="target1">
										<li>
											<input type="checkbox" name="home_search_all" value="All" id="home_search_all" checked="checked">
											<label for="home_search_all">All</label>
										</li>
										<li>
											<input type="checkbox" name="home_search_house" value="House" id="home_search_house">
											<label for="home_search_house">House</label>
										</li>
										<li>
											<input type="checkbox" name="home_search_unit" value="Unit" id="home_search_unit">
											<label for="home_search_unit">Unit</label>
										</li>
										<li>
											<input type="checkbox" name="home_search_apartment" value="Apartment" id="home_search_apartment">
											<label for="home_search_apartment">Apartment</label>
										</li>
										<li>
											<input type="checkbox" name="home_search_studio" value="Studio" id="home_search_studio">
											<label for="home_search_studio">Studio</label>
										</li>
										<li>
											<input type="checkbox" name="home_search_townhouse" value="Townhouse" id="home_search_townhouse">
											<label for="home_search_townhouse">Townhouse</label>
										</li>
										<li>
											<input type="checkbox" name="home_search_land" value="Land" id="home_search_land">
											<label for="home_search_land">Land</label>
										</li>
										<li>
											<input type="checkbox" name="home_search_villa" value="Villa" id="home_search_villa">
											<label for="home_search_villa">Villa</label>
										</li>
									</ul>
								</li>
								<li class="search-option un-responcive checkbox-option property-surrounding-suburbs">
									<input type="checkbox" name="" id="home_search_include_surrounding_suburbs" checked>
									<label for="home_search_include_surrounding_suburbs">Include surrounding suburbs</label>
								</li>
							</ul>
						</li>

						<button type="button" class="btn-submit" data-hook="btn-submit-search-filters" data-loading-text="Searching..." autocomplete="off">Update Search</button>
					</ul>
				</form>
			</div>
			</div>
		
		</div>
	</section>

	<section class="page-content">
		<div class="container">
			<div class="toolbar row _align-start">
				<div class="listing-heading col-1-1 col-tablet-1-2 col-desktop-2-3 flex-align-self-center">
					<span>Showing <strong>1 - 20 of 207</strong> for sale in 1 location</span>
				</div>

				<div class="result-nav col-1-1 col-tablet-1-2 col-desktop-1-3">
					<ul class="result-pager flex">
						<li class="previous-page inactive"><a href="#"><i class="fas fa-chevron-left"></i></a></li>
						<li class="active"><a href="#">1</a></li>
						<li><a href="#">2</a></li>
						<li><a href="#">3</a></li>
						<li><a href="#">4</a></li>
						<li><a href="#">5</a></li>
						<li class="next-page"><a href="#"><i class="fas fa-chevron-right"></i></a></li>
					</ul>
				</div>
			
				<div class="page-options col-1-1 col-desktop-2-3">
					<ul class="results-options flex">
						<li class="view-list active mobile-hide"><a href="#"><i class="fas fa-list"></i> List</a></li>
						<li class="view-map mobile-hide"><a href="#"><i class="fas fa-map"></i> Map</a></li>
						<li class="view-inspections mobile-hide"><a href="#"><i class="far fa-clock"></i> Inspections</a></li>
						<li class="view-auctions mobile-hide"><a href="#"><i class="fab fa-font-awesome-flag"></i> Auctions</a></li>
						<li class="save-search"><a href="#"><i class="fas fa-heart"></i> Save this Search</a></li>
						<li class="sort-listings search-option dropdown-option">
							<div class="dropdown-heading">
								<label class="mobile-hide-inline">Sort By <span class="value" data-select-value="target14">Recommended</span></label>
								
							</div>
							<ul class="dropdown-container" data-select data-select-target="target14">
								<li>
									<input type="radio" id="sort-recommended" name="sort-results" value="Recommended" checked>
								  <label for="sort-recommended">Recommended</label>
								</li>
								<li>
									<input type="radio" id="sort-price-ace" name="sort-results" value="Price (Low-High)">
								  <label for="sort-price-ace">
								  	<span class="sort-label">Price</span>
								  	<span class="sort-value">(Low-High)</span>
									</label>
								</li>
								<li>
									<input type="radio" id="sort-price-desc" name="sort-results" value="Price (High-Low)">
								  <label for="sort-price-desc">
									  <span class="sort-label">Price</span>
									  <span class="sort-value">(High-Low)</span>
									</label>
								</li>
								<li>
									<input type="radio" id="sort-date" name="sort-results" value="Date Created">
								  <label for="sort-date">
								  	<span class="sort-label">Date</span>
								  	<span class="sort-value">Created</span>
								  </label>
								</li>
								<li>
									<input type="radio" id="sort-suburb-ace" name="sort-results" value="Suburb A-Z">
								  <label for="sort-suburb-ace">
								  	<span class="sort-label">Suburb</span>
								  	<span class="sort-value">A-Z</span>
								  </label>
								</li>
								<li>
									<input type="radio" id="sort-suburb-desc" name="sort-results" value="Suburb Z-A">
								  <label for="sor-suburb-desc">
								  	<span class="sort-label">Suburb</span>
								  	<span class="sort-value">Z-A</span>
								  </label>
								</li>
								<li>
									<input type="radio" id="sort-bed-desc" name="sort-results" value="Bedrooms Most-Least">
								  <label for="sort-bed-desc">
								  	<span class="sort-label">Bedrooms</span>
								  	<span class="sort-value">Most-Least</span>
								  </label>
								</li>
								<li>
									<input type="radio" id="sort-bed-ace" name="sort-results" value="Bedrooms Least-Most">
								  <label for="sort-bed-ace">
								  	<span class="sort-label">Bedrooms</span>
								  	<span class="sort-value">Least-Most</span>
								  </label>
								</li>
							</ul>
						</li>
					</ul>
				</div>

				<div class="suburb-auction-results col-1-1 col-desktop-1-3">
					<i class="fas fa-gavel"></i>
					<span>Get Murrumbeena Auction Results</span>
				</div>
			</div>

			<div class="property-listing row _align-start">
				<div class="search-results  col-1-1 col-desktop-2-3">

					<article class="featured listing-item" data-hook="listing-item" data-id="12812056">							<div class="featured-top-bar" style="background-color: #011B36">
							<img src="https://www.realestateview.com.au/logos/results/Woodards.gif" alt="Woodards" width="160" height="30">
						</div>
				
						<div class="gallery featured flex">
			
							<div class="image-large">
								<a class="item image-wrap" href="/real-estate/1c-braemar-street-mont-albert-north-vic/property-details-buy-residential-12812056/">
									<img class="image" src="assets/images/placholder-house.jpg" alt="1C Braemar Street, Mont Albert North VIC 3129">
								</a>
								<a class="item image-wrap" href="/real-estate/1c-braemar-street-mont-albert-north-vic/property-details-buy-residential-12812056/">
									<img class="image" src="assets/images/placholder-house.jpg" alt="1C Braemar Street, Mont Albert North VIC 3129">
								</a>
								<a class="item image-wrap" href="/real-estate/1c-braemar-street-mont-albert-north-vic/property-details-buy-residential-12812056/">
									<img class="image" src="assets/images/placholder-house.jpg" alt="1C Braemar Street, Mont Albert North VIC 3129">
								</a>
							</div>
						</div>

						<div class="agent-details" style="background-color: #011B36; color: #ffffff;">
							<div class="agency-logo">
								<img src="https://www.realestateview.com.au/logos/results/Woodards.gif" alt="Woodards" width="160" height="30">
							</div>
							<div class="agent-photo-name-wrap">
								<div class="agent-name">Bill Chung</div>
								<div class="agent-photo image-wrap">
									<img class="image" title="Bill Chung" alt="Profile photo of Bill Chung" src="assets/images/agent01.jpg">
								</div>
							</div>
							<div class="agency-address">277 Camberwell Rd, Camberwell</div>
							<div class="contact-agency-email" data-hook="contact-agency-email">
								<i class="fas fa-envelope"></i>
								<span>Contact Agent</span>
							</div>
						</div>

						<div class="content">
							<div class="listing-price">Contact Agent</div>
							<div class="listing-address">
								<h3 class="listing-street">
									<a href="/real-estate/1c-braemar-street-mont-albert-north-vic/property-details-buy-residential-12812056/" class="street-address">1C Braemar Street</a>
								</h3 >
								<div class="listing-suburb">Mont Albert North VIC 3129 | House</div>
							</div>
							<div class="property-details">
								<div class="bbc">
									<div class="bedrooms"><i class="fas fa-bed"></i><span>4</span></div>
									<div class="bathrooms"><i class="fas fa-bath"></i><span>2</span></div>
									<div class="carparks"><i class="fas fa-car"></i><span>4</span></div>
								</div>
								<div class="additional-info">
									<a href="#" class="virtual-tour" data-hook="open-virtual-tour" target="_blank">
										<i class="fas fa-vr-cardboard"></i>
										<span class="mobile-hide-inline">VR Inspect</span>
									</a>
									<a href="#" class="virtual-tour" data-hook="open-virtual-tour" target="_blank">
										<i class="far fa-play-circle"></i>
										<span class="mobile-hide-inline">Video</span>
									</a>
									<!-- this can be Updated or UNDER OFFER -->
									<span class="flag-status flag-updated">Updated</span>
									<span class="flag-status flag-new">New</span>
								</div>
							</div>
						</div>
					</article>

					<article class="standard listing-item" data-hook="listing-item" data-id="12812056">

						<div class="shortlist-btn" data-hook="listing-shortlist" data-id="12812056">
							<button class="toggle-shortlist" data-hook="toggle-shortlist" data-id="12812056">
								<div class="favorite"><i class="fas fa-heart"></i></div>
							</button>
						</div>

						<div class="gallery featured">
							<div class="image-large">
								<a class="item image-wrap" href="/real-estate/1c-braemar-street-mont-albert-north-vic/property-details-buy-residential-12812056/">
									<img class="image" src="assets/images/placholder-house.jpg" alt="1C Braemar Street, Mont Albert North VIC 3129">
								</a>
								<a class="item image-wrap" href="/real-estate/1c-braemar-street-mont-albert-north-vic/property-details-buy-residential-12812056/">
									<img class="image" src="assets/images/placholder-house.jpg" alt="1C Braemar Street, Mont Albert North VIC 3129">
								</a>
								<a class="item image-wrap" href="/real-estate/1c-braemar-street-mont-albert-north-vic/property-details-buy-residential-12812056/">
									<img class="image" src="assets/images/placholder-house.jpg" alt="1C Braemar Street, Mont Albert North VIC 3129">
								</a>
							</div>
						</div>

						<div class="agent-details" style="background-color: #011B36; color: #ffffff">
							<div class="agency-logo">
								<img src="https://www.realestateview.com.au/logos/results/Woodards.gif" alt="Woodards" width="160" height="30">
							</div>
							<div class="agent-photo-name-wrap">
								<div class="agent-name">Bill Chung Swalovski</div>
								<div class="agent-photo image-wrap">
									<img class="image" title="Bill Chung" alt="Profile photo of Bill Chung" src="assets/images/agent01.jpg">
								</div>
							</div>
							<div class="contact-agency-email" data-hook="contact-agency-email">
								<i class="fas fa-envelope"></i>
								<span>Contact Agent</span>
							</div>
						</div>

						<div class="content">
							<div class="listing-price">Contact Agent</div>
							<div class="listing-address">
								<h3 class="listing-street">
									<a href="/real-estate/1c-braemar-street-mont-albert-north-vic/property-details-buy-residential-12812056/" class="street-address">1C Braemar Street</a>
								</h3 >
								<div class="listing-suburb">Mont Albert North VIC 3129 | House</div>
							</div>
							<div class="property-details">
								<div class="bbc">
									<div class="bedrooms"><i class="fas fa-bed"></i><span>4</span></div>
									<div class="bathrooms"><i class="fas fa-bath"></i><span>2</span></div>
									<div class="carparks"><i class="fas fa-car"></i><span>4</span></div>
								</div>
								<div class="additional-info">
									<a href="#" class="virtual-tour" data-hook="open-virtual-tour" target="_blank">
										<i class="fas fa-vr-cardboard"></i>
										<span class="mobile-hide-inline">VR Inspect</span>
									</a>
									<a href="#" class="virtual-tour" data-hook="open-virtual-tour" target="_blank">
										<i class="far fa-play-circle"></i>
										<span class="mobile-hide-inline">Video</span>
									</a>
									<!-- this can be Updated or UNDER OFFER -->
									<span class="flag-status flag-updated">Updated</span>
								</div>
							</div>
						</div>

					</article>

					<article class="standard listing-item" data-hook="listing-item" data-id="12812056">

						<div class="shortlist-btn" data-hook="listing-shortlist" data-id="12812056">
							<button class="toggle-shortlist" data-hook="toggle-shortlist" data-id="12812056">
								<div class="favorite"><i class="fas fa-heart"></i></div>
							</button>
						</div>

						<div class="gallery featured">
							<div class="image-large">
								<a class="item image-wrap" href="/real-estate/1c-braemar-street-mont-albert-north-vic/property-details-buy-residential-12812056/">
									<img class="image" src="assets/images/placholder-house.jpg" alt="1C Braemar Street, Mont Albert North VIC 3129">
								</a>
								<a class="item image-wrap" href="/real-estate/1c-braemar-street-mont-albert-north-vic/property-details-buy-residential-12812056/">
									<img class="image" src="assets/images/placholder-house.jpg" alt="1C Braemar Street, Mont Albert North VIC 3129">
								</a>
								<a class="item image-wrap" href="/real-estate/1c-braemar-street-mont-albert-north-vic/property-details-buy-residential-12812056/">
									<img class="image" src="assets/images/placholder-house.jpg" alt="1C Braemar Street, Mont Albert North VIC 3129">
								</a>
							</div>
						</div>

						<div class="agent-details" style="background-color: #011B36; color: #ffffff">
							<div class="agency-logo">
								<img src="https://www.realestateview.com.au/logos/results/Woodards.gif" alt="Woodards" width="160" height="30">
							</div>
							<div class="agent-photo-name-wrap">
								<div class="agent-name">Bill Chung Swalovski</div>
								<div class="agent-photo image-wrap">
									<img class="image" title="Bill Chung" alt="Profile photo of Bill Chung" src="assets/images/agent01.jpg">
								</div>
							</div>
							<div class="contact-agency-email" data-hook="contact-agency-email">
								<i class="fas fa-envelope"></i>
								<span>Contact Agent</span>
							</div>
						</div>

						<div class="content">
							<div class="listing-price">Contact Agent</div>
							<div class="listing-address">
								<h3 class="listing-street">
									<a href="/real-estate/1c-braemar-street-mont-albert-north-vic/property-details-buy-residential-12812056/" class="street-address">1C Braemar Street</a>
								</h3 >
								<div class="listing-suburb">Mont Albert North VIC 3129 | House</div>
							</div>
							<div class="property-details">
								<div class="bbc">
									<div class="bedrooms"><i class="fas fa-bed"></i><span>4</span></div>
									<div class="bathrooms"><i class="fas fa-bath"></i><span>2</span></div>
									<div class="carparks"><i class="fas fa-car"></i><span>4</span></div>
								</div>
								<div class="additional-info">
									<a href="#" class="virtual-tour" data-hook="open-virtual-tour" target="_blank">
										<i class="fas fa-vr-cardboard"></i>
										<span class="mobile-hide-inline">VR Inspect</span>
									</a>
									<a href="#" class="virtual-tour" data-hook="open-virtual-tour" target="_blank">
										<i class="far fa-play-circle"></i>
										<span class="mobile-hide-inline">Video</span>
									</a>
									<!-- this can be Updated or UNDER OFFER -->
									<span class="flag-status flag-new">NEW</span>
								</div>
							</div>
					
						</div>

					</article>
				</div>

				<div class="side-otions col-1-1 col-desktop-1-3">
			
					<div class="side-wrapper">
						<div class="slide-show-wrap">
							<ul class="side-listings">
								<li class="simple listing-item">

									<div class="agency-details agency-top" style="background-color: #011B36; color: #ffffff;">
										<div class="agency-moto">
											<span>Local Expert</span>
										</div>
										<div class="agency-logo">
											<img src="https://www.realestateview.com.au/logos/results/Woodards.gif" alt="Woodards" width="160" height="30">
										</div>
									</div>

									<div class="gallery featured">
										<div class="image-large">
											<a class="item image-wrap" href="/real-estate/1c-braemar-street-mont-albert-north-vic/property-details-buy-residential-12812056/">
												<img class="image" src="assets/images/placholder-house.jpg" alt="1C Braemar Street, Mont Albert North VIC 3129">
											</a>
											<a class="item image-wrap" href="/real-estate/1c-braemar-street-mont-albert-north-vic/property-details-buy-residential-12812056/">
												<img class="image" src="assets/images/placholder-house.jpg" alt="1C Braemar Street, Mont Albert North VIC 3129">
											</a>
											<a class="item image-wrap" href="/real-estate/1c-braemar-street-mont-albert-north-vic/property-details-buy-residential-12812056/">
												<img class="image" src="assets/images/placholder-house.jpg" alt="1C Braemar Street, Mont Albert North VIC 3129">
											</a>
										</div>
									</div>

									<div class="agent-details">
										<div class="agent-photo image-wrap">
											<img class="image" title="Bill Chung" alt="Profile photo of Bill Chung" src="assets/images/agent01.jpg">
										</div>
									</div>
									<div class="content">
										<div class="listing-address">
											<div class="listing-street">
												<a href="/real-estate/1c-braemar-street-mont-albert-north-vic/property-details-buy-residential-12812056/">
													<div class="listing-suburb">Mont Albert North | House</div>
												</a>
											</div >
										</div>
										<div class="property-details">
											<div class="bbc">
												<div class="bedrooms"><i class="fas fa-bed"></i><span>4</span></div>
												<div class="bathrooms"><i class="fas fa-bath"></i><span>2</span></div>
												<div class="carparks"><i class="fas fa-car"></i><span>4</span></div>
											</div>
										</div>
									</div>
								</li>
								<li class="simple listing-item">

									<div class="agency-details agency-top"  style="background-color: #ffffff; color: #0F1324;">
										<div class="agency-moto">
											<span>Local Expert</span>
										</div>
										<div class="agency-logo">
											<img src="https://www.realestateview.com.au/logos/results/Barry-Plant-160x30.png" alt="Barry Plant" width="160" height="30">
										</div>
									</div>

									<div class="gallery featured">
										<div class="image-large">
											<a class="item image-wrap" href="/real-estate/1c-braemar-street-mont-albert-north-vic/property-details-buy-residential-12812056/">
												<img class="image" src="assets/images/placholder-house.jpg" alt="1C Braemar Street, Mont Albert North VIC 3129">
											</a>
											<a class="item image-wrap" href="/real-estate/1c-braemar-street-mont-albert-north-vic/property-details-buy-residential-12812056/">
												<img class="image" src="assets/images/placholder-house.jpg" alt="1C Braemar Street, Mont Albert North VIC 3129">
											</a>
											<a class="item image-wrap" href="/real-estate/1c-braemar-street-mont-albert-north-vic/property-details-buy-residential-12812056/">
												<img class="image" src="assets/images/placholder-house.jpg" alt="1C Braemar Street, Mont Albert North VIC 3129">
											</a>
										</div>
									</div>

									<div class="agent-details">
										<div class="agent-photo image-wrap">
											<img class="image" title="Bill Chung" alt="Profile photo of Bill Chung" src="assets/images/agent01.jpg">
										</div>
									</div>
									<div class="content">
										<div class="listing-address">
											<div class="listing-street">
												<a href="/real-estate/1c-braemar-street-mont-albert-north-vic/property-details-buy-residential-12812056/">
													<div class="listing-suburb">Mont Albert North | House</div>
												</a>
											</div >
										</div>
										<div class="property-details">
											<div class="bbc">
												<div class="bedrooms"><i class="fas fa-bed"></i><span>4</span></div>
												<div class="bathrooms"><i class="fas fa-bath"></i><span>2</span></div>
												<div class="carparks"><i class="fas fa-car"></i><span>4</span></div>
											</div>
										</div>
									</div>
								</li>
								<li class="simple listing-item">

									<div class="agency-details agency-top">
										<div class="agency-moto">
											<span>Local Expert</span>
										</div>
										<div class="agency-logo">
											<img src="https://www.realestateview.com.au/logos/results/Woodards.gif" alt="Woodards" width="160" height="30">
										</div>
									</div>

									<div class="gallery featured">
										<div class="image-large">
											<a class="item image-wrap" href="/real-estate/1c-braemar-street-mont-albert-north-vic/property-details-buy-residential-12812056/">
												<img class="image" src="assets/images/placholder-house.jpg" alt="1C Braemar Street, Mont Albert North VIC 3129">
											</a>
											<a class="item image-wrap" href="/real-estate/1c-braemar-street-mont-albert-north-vic/property-details-buy-residential-12812056/">
												<img class="image" src="assets/images/placholder-house.jpg" alt="1C Braemar Street, Mont Albert North VIC 3129">
											</a>
											<a class="item image-wrap" href="/real-estate/1c-braemar-street-mont-albert-north-vic/property-details-buy-residential-12812056/">
												<img class="image" src="assets/images/placholder-house.jpg" alt="1C Braemar Street, Mont Albert North VIC 3129">
											</a>
										</div>
									</div>

									<div class="agent-details">
										<div class="agent-photo image-wrap">
											<img class="image" title="Bill Chung" alt="Profile photo of Bill Chung" src="assets/images/agent01.jpg">
										</div>
									</div>
									<div class="content">
										<div class="listing-address">
											<div class="listing-street">
												<a href="/real-estate/1c-braemar-street-mont-albert-north-vic/property-details-buy-residential-12812056/">
													<div class="listing-suburb">Mont Albert North | House</div>
												</a>
											</div >
										</div>
										<div class="property-details">
											<div class="bbc">
												<div class="bedrooms"><i class="fas fa-bed"></i><span>4</span></div>
												<div class="bathrooms"><i class="fas fa-bath"></i><span>2</span></div>
												<div class="carparks"><i class="fas fa-car"></i><span>4</span></div>
											</div>
										</div>
									</div>
								</li>
								<li class="simple listing-item">

									<div class="agency-details agency-top">
										<div class="agency-moto">
											<span>Local Expert</span>
										</div>
										<div class="agency-logo">
											<img src="https://www.realestateview.com.au/logos/results/Woodards.gif" alt="Woodards" width="160" height="30">
										</div>
									</div>

									<div class="gallery featured">
										<div class="image-large">
											<a class="item image-wrap" href="/real-estate/1c-braemar-street-mont-albert-north-vic/property-details-buy-residential-12812056/">
												<img class="image" src="assets/images/placholder-house.jpg" alt="1C Braemar Street, Mont Albert North VIC 3129">
											</a>
											<a class="item image-wrap" href="/real-estate/1c-braemar-street-mont-albert-north-vic/property-details-buy-residential-12812056/">
												<img class="image" src="assets/images/placholder-house.jpg" alt="1C Braemar Street, Mont Albert North VIC 3129">
											</a>
											<a class="item image-wrap" href="/real-estate/1c-braemar-street-mont-albert-north-vic/property-details-buy-residential-12812056/">
												<img class="image" src="assets/images/placholder-house.jpg" alt="1C Braemar Street, Mont Albert North VIC 3129">
											</a>
										</div>
									</div>

									<div class="agent-details">
										<div class="agent-photo image-wrap">
											<img class="image" title="Bill Chung" alt="Profile photo of Bill Chung" src="assets/images/agent01.jpg">
										</div>
									</div>
									<div class="content">
										<div class="listing-address">
											<div class="listing-street">
												<a href="/real-estate/1c-braemar-street-mont-albert-north-vic/property-details-buy-residential-12812056/">
													<div class="listing-suburb">Mont Albert North | House</div>
												</a>
											</div >
										</div>
										<div class="property-details">
											<div class="bbc">
												<div class="bedrooms"><i class="fas fa-bed"></i><span>4</span></div>
												<div class="bathrooms"><i class="fas fa-bath"></i><span>2</span></div>
												<div class="carparks"><i class="fas fa-car"></i><span>4</span></div>
											</div>
										</div>
									</div>
								</li>
							</ul>
						</div>
					</div>
				
				</div>
			</div>
		</div>
	</section>
</div>