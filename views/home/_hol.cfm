<div id="homepage-container">
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
					<li class="search-type"><a class="active" href="#">RENT</a></li>
					<li class="search-type tablet-hide"><a href="#">FIND AN AGENT</a></li>
					<li class="search-type-heading">Search Rual for Sale in Australia</li>
				</ul>
				<form>
					<div class="center-options search-address">
						<div class="search-input flex _justify-space-between _align-center _wrap">
							<span class="mobile-hide"><i class="fas fa-search"></i></span>
							<span class="location-wrap"><input id="location" class="form-control placeholder-loading" placeholder="Search by suburb, postcode or area" name="location" type="text"></span>
							<span class="mobile-hide">
								<button type="button" class="btn-submit" data-hook="btn-submit-search-filters"> Search <span>0</span> Properties </button>
							</span>
						</div>
						<div class="toggle-search-options padding-sml-vert flex _align-center _justify-space-between">
							<span>Search Options</span>
							<i class="fas fa-chevron-down"></i>
						</div>
					</div>
					<div class="bottom-options hidden-options" style="display: none;">
						<ul class="search-options flex _wrap">
							<li class="search-option dropdown-option">
								<div class="dropdown-heading">
									<label>Search Within</label>
									<span class="value" data-select-value="target1">Location only</span>
								</div>
								<ul class="dropdown-container" data-select data-select-target="target1">
									<li>
										<input type="radio" name="home_search_loaction" value="Location only" id="home_search_all" checked="checked">
										<label for="home_search_all">Location only</label>
									</li>
									<li>
										<input type="radio" name="home_search_loaction" value="Bordering Suburbs" id="home_search_bordering_suburbs">
										<label for="home_search_bordering_suburbs">Bordering Suburbs</label>
									</li>
									<li>
										<input type="radio" name="home_search_loaction" value="Suburbs Within 4 km" id="home_search_within_4km">
										<label for="home_search_within_4km">Suburbs Within 4 km</label>
									</li>
									<li>
										<input type="radio" name="home_search_loaction" value="Suburbs Within 6 km" id="home_search_within_6km">
										<label for="home_search_within_6km">Suburbs Within 6 km</label>
									</li>
								</ul>
							</li>
							<li class="search-option dropdown-option property-price">
								<div class="dropdown-heading">
									<label>Rental Price</label>
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
												<input type="radio" id="min_price_50" name="home_search_min_price" value="$50">
											  <label for="min_price_50">$50</label>
											</li>
											<li>
												<input type="radio" id="min_price_150" name="home_search_min_price" value="$100">
											  <label for="min_price_150">$100</label>
											</li>
											<li>
												<input type="radio" id="min_price_100" name="home_search_min_price" value="$150">
											  <label for="min_price_100">$150</label>
											</li>
											<li>
												<input type="radio" id="min_price_200" name="home_search_min_price" value="$200">
											  <label for="min_price_200">$200</label>
											</li>
											<li>
												<input type="radio" id="min_price_250" name="home_search_min_price" value="$250">
											  <label for="min_price_250">$250</label>
											</li>
											<li>
												<input type="radio" id="min_price_300" name="home_search_min_price" value="$300">
											  <label for="min_price_300">$300</label>
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
												<input type="radio" id="max_price_50" name="home_search_max_price" value="$50">
											  <label for="max_price_50">$50</label>
											</li>
											<li>
												<input type="radio" id="max_price_150" name="home_search_max_price" value="$100">
											  <label for="max_price_150">$100</label>
											</li>
											<li>
												<input type="radio" id="max_price_100" name="home_search_max_price" value="$150">
											  <label for="max_price_100">$150</label>
											</li>
											<li>
												<input type="radio" id="max_price_200" name="home_search_max_price" value="$200">
											  <label for="max_price_200">$200</label>
											</li>
											<li>
												<input type="radio" id="max_price_250" name="home_search_max_price" value="$250">
											  <label for="max_price_250">$250</label>
											</li>
											<li>
												<input type="radio" id="max_price_300" name="home_search_max_price" value="$300">
											  <label for="max_price_300">$300</label>
											</li>
										</div>
									</ol>
								</ul>
							</li>
							<li class="search-option dropdown-option property-bed">
								<div class="dropdown-heading">
									<label>Bedrooms</label>
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
							<li class="search-option dropdown-option property-bath">
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
								</ul>
							</li>
							<li class="search-option dropdown-option property-car">
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
								</ul>
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
								<img class="image" src="/assets/images/beachhouse.png" alt="beach house">
							</a>
						</div>
						<div class="property-info-box">
							<div class="price">$160 per week</div>
							<div class="address" title="Croydon, Victoria">Croydon, Victoria</div>
						</div>
						<div class="bed-bath-car">
							<span><span class="number">4</span>Beds</span>
							<span><span class="number">2</span>Bath</span>
							<span><span class="number">1</span>Car</span>
						</div>
					</div>
				</div>

				<div class="property-item col-1-3 col-tablet-1-3">
					<div class="content flex _wrap">
						<div class="photo-box">
							<a class="image-wrap" href="#">
								<img class="image" src="/assets/images/beachhouse.png" alt="beach house">
							</a>
						</div>
						<div class="property-info-box">
							<div class="price">$160 per week</div>
							<div class="address" title="Croydon, Victoria">Croydon, Victoria</div>
						</div>
						<div class="bed-bath-car">
							<span><span class="number">4</span>Beds</span>
							<span><span class="number">2</span>Bath</span>
							<span><span class="number">1</span>Car</span>
						</div>
					</div>
				</div>

				<div class="property-item col-1-3 col-tablet-1-3">
					<div class="content flex _wrap">
						<div class="photo-box">
							<a class="image-wrap" href="#">
								<img class="image" src="/assets/images/beachhouse.png" alt="beach house">
							</a>
						</div>
						<div class="property-info-box">
							<div class="price">$160 per week</div>
							<div class="address" title="Croydon, Victoria">Croydon, Victoria</div>
						</div>
						<div class="bed-bath-car">
							<span><span class="number">4</span>Beds</span>
							<span><span class="number">2</span>Bath</span>
							<span><span class="number">1</span>Car</span>
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
		<div class="item-left col-1-1 col-tablet-6-8">

			<section class="home-content-section homepage-company-description">
				<h2>Search Holiday Properties For Rent</h2>
				<div class="description">
					<h4>Lorem ipsum dolor sit amet, consectetur adipiscing elit.</h4>
					<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras elit turpis, dignissim et aliquet ut, imperdiet vel diam. Vestibulum accumsan id odio in fermentum. Nunc egestas sem lacus, id consectetur nisi interdum sed. Ut tincidunt tellus vehicula risus auctor convallis. Proin non tortor vel elit eleifend hendrerit. Etiam sed pellentesque erat, sed tincidunt elit. Etiam id faucibus magna. Vivamus ut pulvinar mauris.</p>
				</div>
			</section>

			<section class="home-content-section homepage-seo-links">
			  <h2 class="seo-links-toggle-btn">Holiday Rental Properties Quick Links</h2>
				<div id="collapsehomepageseo" class="row" style="display: none;">
					<article class="item col-1-1 col-tablet-1-2">
					<h3>HOLIDAY RENTALS BY STATE</h3>
						<ul>
							<li><a href="#">Holiday Properties in VIC</a></li>
							<li><a href="#">Holiday Properties in NSW</a></li>
							<li><a href="#">Holiday Properties in SA</a></li>
							<li><a href="#">Holiday Properties in NT</a></li>
							<li><a href="#">Holiday Properties in TAS</a></li>
							<li><a href="#">Holiday Properties in QLD</a></li>
							<li><a href="#">Holiday Properties in WA</a></li>
							<li><a href="#">Holiday Properties in ACT</a></li>
						</ul>
					</article>
					
					<article class="item col-1-1 col-tablet-1-2">
						<h3>BUSINESSES FOR SALE BY CITY</h3>
						<ul>
							<li><a href="#">Mornington Penninsula</a></li>
							<li><a href="#">Sunshine Coast</a></li>
							<li><a href="#">Central Queensland</a></li>
							<li><a href="#">Townsville and Mackay</a></li>
							<li><a href="#">Great Ocean Road</a></li>
							<li><a href="#">Hamilton Island</a></li>
							<li><a href="#">Bellarine Penninsula</a></li>
							<li><a href="#">Margaret River</a></li>
						</ul>
					</article>

		  		</div>
			</section>

			<section class="home-content-section homepage-partner-links ">
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
			    <article class="partner-rural col-tablet-1-3">
			    	<a class="logo" href="/?brand=rur">
		        	<img class="image" src="assets/images/realestateview_logo_hero_rgb.svg">
		      	</a>
		        <h3><a href="/?brand=rur">Rural Properties for Sale</a></h3>
		        <p>Farmland, rural land and lifestyle properties.</p>
			    </article>
				</div>
			</section>
		</div>

		<div class="item-right col-1-1 col-tablet-2-8 padding-lrg-vert">
			<div class="side-add-container">
				<div class="add-item">
					Even More Adds go here
				</div>
			</div>
		</div>

	</div>
</div>