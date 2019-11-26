<div id="homepage-container" class="main">
	<section class="property-360-banner">
    <a href="/property-360/" target="" rel="">
      <span>How much is my home worth?</span><i class="fas fa-chevron-right"></i>
    </a>
	</section>

	<!------------ SUBBANNER ------------>
	<section id="search-banner">
		<div class="container">
			<div class="form-container">
				<ul class="search-options top-links flex _wrap">
					<li class="search-type"><a class="active" href="#">BUY</a></li>
					<li class="search-type tablet-hide"><a href="#">FIND AN AGENT</a></li>
					<li class="search-type-heading">Search Rual for Sale in Australia</li>
				</ul>
				<form>
					<div class="center-options search-address">
						<div class="search-input flex _justify-space-between _align-center _wrap">
							<span class="mobile-hide"><i class="fas fa-search"></i></span>
							<span class="location-wrap"><input id="location" class="form-control placeholder-loading" placeholder="Search by suburb, postcode or area" name="location" type="text"></span>
							<span class="mobile-hide">
								<button type="button" class="button btn-submit" data-hook="btn-submit-search-filters"> Search <span>0</span> Properties </button>
							</span>
						</div>
						<div class="toggle-search-options padding-sml-vert flex _align-center _justify-space-between">
							<span>Search Options</span>
							<i class="fas fa-chevron-down"></i>
						</div>
					</div>
					<div class="bottom-options hidden-options" style="display: none;">
						<ul class="search-options flex _wrap">
							<li class="search-option dropdown-option property-options">
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
										<input type="checkbox" name="home_search_ruralfarmacreage" value="Rural/Farm/Acreage" id="home_search_ruralfarmacreage">
										<label for="home_search_ruralfarmacreage">Rural/Farm/Acreage</label>
									</li>
									<li>
										<input type="checkbox" name="home_search_livestock" value="Livestock" id="home_search_livestock">
										<label for="home_search_livestock">Livestock</label>
									</li>
									<li>
										<input type="checkbox" name="home_search_cropping_grazing" value="Cropping/Grazing" id="home_search_cropping_grazing">
										<label for="home_search_cropping_grazing">Cropping/Grazing</label>
									</li>
									<li>
										<input type="checkbox" name="home_search_dairy" value="Dairy" id="home_search_dairy">
										<label for="home_search_dairy">Dairy</label>
									</li>
									<li>
										<input type="checkbox" name="home_search_farmlet" value="Farmlet" id="home_search_farmlet">
										<label for="home_search_farmlet">Farmlet</label>
									</li>
									<li>
										<input type="checkbox" name="home_search_lifestyle" value="Lifestyle" id="home_search_lifestyle">
										<label for="home_search_lifestyle">Lifestyle</label>
									</li>
									<li>
										<input type="checkbox" name="home_search_horticulture" value="Horticulture" id="home_search_horticulture">
										<label for="home_search_horticulture">Horticulture</label>
									</li>
									<li>
										<input type="checkbox" name="home_search_viticulture" value="Viticulture" id="home_search_viticulture">
										<label for="home_search_viticulture">Viticulture</label>
									</li>
									<li>
										<input type="checkbox" name="home_search_produce_farm" value="Produce Farm" id="home_search_produce_farm">
										<label for="home_search_produce_farm">Produce Farm</label>
									</li>
									<li>
										<input type="checkbox" name="home_search_speciality" value="Speciality" id="home_search_speciality">
										<label for="home_search_speciality">Speciality</label>
									</li>
									<li>
										<input type="checkbox" name="home_search_mixed_farming" value="Mixed Farming" id="home_search_mixed_farming">
										<label for="home_search_mixed_farming">Mixed Farming</label>
									</li>
									<li>
										<input type="checkbox" name="home_search_vacant_land_rural" value="Vacant Land (Rural)" id="home_search_vacant_land_rural">
										<label for="home_search_vacant_land_rural">Vacant Land (Rural)</label>
									</li>
									<li>
										<input type="checkbox" name="home_search_clearing_sale" value="Clearing Sale" id="home_search_clearing_sale">
										<label for="home_search_clearing_sale">Clearing Sale</label>
									</li>
									<li>
										<input type="checkbox" name="home_search_other" value="Other" id="home_search_other">
										<label for="home_search_other">Other</label>
									</li>
								</ul>
							</li>
							<li class="search-option dropdown-option property-price">
								<div class="dropdown-heading">
									<label>Price</label>
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
							<li class="search-option dropdown-option property-price">
								<div class="dropdown-heading">
									<label>Land Area</label>
									<span class="value" data-select-value="target4">Any</span>
									<span class="value" data-select-value="target5"></span>
								</div>
								<ul class="dropdown-container flex">
									<ol class="property-price-min price-select">
										<div class="selected-option">Any</div>
										<div class="option-container" data-select data-select-target="target4">
											<li>
												<input type="radio" id="min_land_size_any" name="home_search_min_land_size" value="Any" checked>
											  <label for="min_land_size_any">Any</label>
											</li>
											<li>
												<input type="radio" id="min_land_size_300_sqm" name="home_search_min_land_size" value="300 sqm">
											  <label for="min_land_size_300_sqm">300 sqm </label>
											</li>
											<li>
												<input type="radio" id="min_land_size_150" name="home_search_min_land_size" value="500 sqm ">
											  <label for="min_land_size_150">500 sqm </label>
											</li>
											<li>
												<input type="radio" id="min_land_size_100" name="home_search_min_land_size" value="$150k">
											  <label for="min_land_size_100">$150k</label>
											</li>
											<li>
												<input type="radio" id="min_land_size_200" name="home_search_min_land_size" value="$200k">
											  <label for="min_land_size_200">$200k</label>
											</li>
											<li>
												<input type="radio" id="min_land_size_250" name="home_search_min_land_size" value="$250k">
											  <label for="min_land_size_250">$250k</label>
											</li>
											<li>
												<input type="radio" id="min_land_size_300" name="home_search_min_land_size" value="$300k">
											  <label for="min_land_size_300">$300k</label>
											</li>
										</div>
									</ol>
									<ol class="property-price-max price-select">
										<div class="selected-option">Any</div>
										<div class="option-container" data-select data-select-target="target5">
											<li>
												<input type="radio" id="max_price_any" name="home_search_max_land_size" value="" checked>
											  <label for="max_land_size_any">Any</label>
											</li>
											<li>
												<input type="radio" id="max_land_size_50" name="home_search_max_land_size" value="$50k">
											  <label for="max_land_size_50">$50k</label>
											</li>
											<li>
												<input type="radio" id="max_land_size_150" name="home_search_max_land_size" value="$100k">
											  <label for="max_land_size_150">$100k</label>
											</li>
											<li>
												<input type="radio" id="max_land_size_100" name="home_search_max_land_size" value="$150k">
											  <label for="max_land_size_100">$150k</label>
											</li>
											<li>
												<input type="radio" id="max_land_size_200" name="home_search_max_land_size" value="$200k">
											  <label for="max_land_size_200">$200k</label>
											</li>
											<li>
												<input type="radio" id="max_land_size_250" name="home_search_max_land_size" value="$250k">
											  <label for="max_land_size_250">$250k</label>
											</li>
											<li>
												<input type="radio" id="max_land_size_300" name="home_search_max_land_size" value="$300k">
											  <label for="max_land_size_300">$300k</label>
											</li>
										</div>
									</ol>
								</ul>
							</li>
							<li class="search-option checkbox-option property-surrounding-suburbs">
								<input type="checkbox" name="" id="home_search_include_surrounding_suburbs" checked>
								<label for="home_search_include_surrounding_suburbs">Include surrounding suburbs</label>
							</li>
						</ul>
					</div>

					<span class="mobile-search-btn">
						<button type="button" class="btn-submit"> Search <span>0</span> Properties </button>
					</span>
				</form>
			</div>
		</div>
	</section>

	<section class="hp-section top-add-container">
			<div class="container">
				<div class="add-item">
					Adds go here
				</div>
			</div>
	</section>

	<section id="featured-propertys" class="hp-section">
		<div class="container">
			<h2>Featured Houses and Apartments For Sale</h2>
			<div class="featured-listings-wrap">
				<div class="row home-featured-listings">

				<div class="property-item col-1-3 col-tablet-1-3">
					<div class="content flex _wrap">
						<div class="photo-box">
							<a class="image-wrap" href="#">
								<img class="image" src="/assets/images/paddock.png" alt="paddock">
							</a>
						</div>
						<div class="property-info-box">
							<div class="price">For Sale $180,000</div>
							<div class="address" title="Croydon, Victoria">Croydon, Victoria</div>
							<div class="business-type">Cafe / Take Away</div>
						</div>
					</div>
				</div>

				<div class="property-item col-1-3 col-tablet-1-3">
					<div class="content flex _wrap">
						<div class="photo-box">
							<a class="image-wrap" href="#">
								<img class="image" src="/assets/images/paddock.png" alt="paddock">
							</a>
						</div>
						<div class="property-info-box">
							<div class="price">For Sale $180,000</div>
							<div class="address" title="Croydon, Victoria">Croydon, Victoria</div>
							<div class="business-type">Cafe / Take Away</div>
						</div>
					</div>
				</div>

				<div class="property-item col-1-3 col-tablet-1-3">
					<div class="content flex _wrap">
						<div class="photo-box">
							<a class="image-wrap" href="#">
								<img class="image" src="/assets/images/paddock.png" alt="paddock">
							</a>
						</div>
						<div class="property-info-box">
							<div class="price">For Sale $180,000</div>
							<div class="address" title="Croydon, Victoria">Croydon, Victoria</div>
							<div class="business-type">Cafe / Take Away</div>
						</div>
					</div>
				</div>

			</div>
		</div>
	</section>

	<section class="hp-section top-add-container">
			<div class="container">
				<div class="add-item">
					More Adds go here
				</div>
			</div>
	</section>

	<div id="homepage-content" class="container row">
		<div class="item-left col-1-1 col-desktop-6-8">

			<section class="home-content-section homepage-company-description">
        		<h2>Search Real Estate for Sale</h2>
				<div class="description">
			        <h4>Founded in 2001, realestateVIEW.com.au is now one of Australia's leading national real estate portals.</h4>
			        <p>Our number one priority is to make house-hunting, selling, and renting easy and fast. We do this by listing thousands of rental properties and homes for sale from Australia's most prestigious real estate agents.</p>
			        <p>To help you conduct property research and plan your house-hunting days, realestateVIEW.com.au offers a suite of essential tools including free property alerts for homes both for sale and rent. You can also access all the latest sales and Auction results, get historical property data like sale and rental history plus access property value estimates for every address in Australia.</p>
			        <p>
			            View properties from <a href="/find-agent/">real estate agents</a> such as:
			            <a href="/real-estate-agencies/ray-white/">Ray White</a>,
			            <a href="/real-estate-agencies/lj-hooker/">LJ Hooker</a>,
			            <a href="/real-estate-agencies/century-21/">Century 21</a>,
			            <a href="/real-estate-agencies/barry-plant/">Barry Plant</a>,
			            <a href="/real-estate-agencies/raine-and-horne/">Raine &amp; Horne</a>,
			            <a href="/real-estate-agencies/harcourts/">Harcourts</a>,
			            <a href="/real-estate-agencies/professionals/">Professionals</a>,
			            <a href="/real-estate-agencies/marshall-white/">Marshall White</a>,
			            <a href="/real-estate-agencies/jellis-craig/">Jellis Craig</a>,
			            <a href="/real-estate-agencies/woodards/">Woodards</a>,
			            <a href="/real-estate-agencies/fletchers/">Fletchers</a>,
			            and <a href="/real-estate-agencies/belle-property/">Belle property</a>
			        </p>
				</div>
			</section>

			<section class="home-content-section homepage-seo-links">
			  	<h2 class="seo-links-toggle-btn">Rural Properties Links</h2>
				<div id="collapsehomepageseo" class="row" style="display: none;">
					<article class="item col-1-1 col-tablet-1-2">
					<h3>RURAL PROPERTIES FOR SALE BY STATE</h3>
						<ul>
							<li><a href="#">Rural Properties in VIC</a></li>
							<li><a href="#">Rural Properties in NSW</a></li>
							<li><a href="#">Rural Properties in SA</a></li>
							<li><a href="#">Rural Properties in NT</a></li>
							<li><a href="#">Rural Properties in TAS</a></li>
							<li><a href="#">Rural Properties in QLD</a></li>
							<li><a href="#">Rural Properties in WA</a></li>
							<li><a href="#">Rural Properties in ACT</a></li>
						</ul>
					</article>
					
					<article class="item col-1-1 col-tablet-1-2">
						<h3>RURAL PROPERTIES FOR SALE BY TYPE</h3>
						<ul>
							<li><a href="#">Livestock Properties</a></li>
							<li><a href="#">Cropping Grazing Properties</a></li>
							<li><a href="#">Farmlet Properties</a></li>
							<li><a href="#">Viticulture Properties</a></li>
							<li><a href="#">Horticulture Properties</a></li>
							<li><a href="#">Lifestyle Properties</a></li>
							<li><a href="#">Dairy Properties</a></li>
							<li><a href="#">Specialty Properties</a></li>
						</ul>
					</article>
			    
		  		</div>
			</section>

			<section class="home-content-section partner-links">
				<h2>View Network</h2>
				<div class="row">
				    <article class="partner-holiday col-tablet-1-3">
				    	<a class="logo" href="/">
				        	<img class="image" src="assets/images/realestateview_logo_hero_rgb.svg">
				      	</a>
			        	<h3><a href="/">Residential Properties</a></h3>
			        	<p>Houses, townhouses and land for sale and rent.</p>
				    </article>
				    <article class="partner-business col-tablet-1-3">
				    	<a class="logo" href="/?brand=bus">
				        	<img class="image" src="assets/images/realestateview_logo_hero_rgb.svg">
				      	</a>
			        	<h3><a href="/?brand=bus">Businesses For Sale</a></h3>
			        	<p>Retail, industrial, construction &amp; more businesses.</p>
				    </article>
				    <article class="partner-holiday col-tablet-1-3">
				    	<a class="logo" href="/?brand=hol">
				        	<img class="image" src="assets/images/realestateview_logo_hero_rgb.svg">
				      	</a>
			        	<h3><a href="/?brand=hol">Holiday Rentals</a></h3>
			        	<p>Holiday rental accommodation to suit your needs.</p>
				    </article>
				</div>
			</section>
		</div>

		<div class="item-right col-1-1 col-desktop-2-8">
			<div class="side-add-container">
				<div class="add-item">
					Even More Adds go here
				</div>
			</div>
		</div>

	</div>
</div>