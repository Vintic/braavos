<!------------ SITE CONTENT START ------------>

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
					<li class="search-type"><a class="active" href="#">BUY</a></li>
					<li class="search-type"><a href="#">RENT</a></li>
					<li class="search-type"><a href="#">SOLD</a></li>
					<li class="search-type tablet-hide"><a href="#">HOME VALUE</a></li>
					<li class="search-type tablet-hide"><a href="#">FIND AN AGENT</a></li>
					<li class="search-type-heading">Search Properties for Sale in Australia</li>
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

	<section class="top-add-container">
			<div class="container">
				<div class="add-item">
					Adds go here
				</div>
			</div>
	</section>

	<section id="featured-propertys">
		<div class="container">
			<h2>Featured Houses and Apartments For Sale</h2>
			<div class="featured-listings-wrap">
				<div class="row home-featured-listings">

				<div class="property-item col-1-3 col-tablet-1-3">
					<div class="content flex _wrap">
						<div class="photo-box">
							<a class="image-wrap" href="/real-estate/11-wadham-parade-mount-waverley-vic/property-details-buy-residential-12770665/">
								<img class="image" src="https://images.realestateview.com.au/pics/665/11-wadham-parade-mount-waverley-vic-3149-real-estate-photo-1-medium-12770665.jpg" alt="17 rayleigh avenue queenscliff vic 3225">
							</a>
						</div>
						<div class="property-info-box">
							<div class="price">Contact Agent</div>
							<div class="address" title="11 Wadham Parade, Mount Waverley VIC 3149">11 Wadham Parade, Mount Waverley</div>
						</div>
						<div class="bed-bath-car">
							<span><span class="number">3</span>Beds</span>
							<span><span class="number">2</span>Bath</span>
							<span><span class="number">2</span>Car</span>
						</div>
					</div>
				</div>

				<div class="property-item col-1-3 col-tablet-1-3">
					<div class="content flex _wrap">
						<div class="photo-box">
							<a class="image-wrap" href="/real-estate/53-bosun-parade-ashmore-qld/property-details-buy-residential-12744179/">
								<img class="image" src="https://images.realestateview.com.au/pics/179/53-bosun-parade-ashmore-qld-4214-real-estate-photo-1-medium-12744179.jpg" alt="17 rayleigh avenue queenscliff vic 3225">
							</a>
						</div>
						<div class="property-info-box">
							<div class="price">UNDER CONTRACT</div>
							<div class="address" title="53 Bosun Parade, Ashmore QLD 4214">53 Bosun Parade, Ashmore</div>
						</div>
						<div class="bed-bath-car">
							<span><span class="number">5</span>Beds</span>
							<span><span class="number">2</span>Bath</span>
							<span><span class="number">2</span>Car</span>
						</div>
					</div>
				</div>

				<div class="property-item col-1-3 col-tablet-1-3">
					<div class="content flex _wrap">
						<div class="photo-box">
							<a class="image-wrap" href="/real-estate/17-rayleigh-avenue-queenscliff-vic/property-details-buy-residential-12755865/">
								<img class="image" src="https://images.realestateview.com.au/pics/865/17-rayleigh-avenue-queenscliff-vic-3225-real-estate-photo-1-medium-12755865.jpg" alt="17 rayleigh avenue queenscliff vic 3225">
							</a>
						</div>
						<div class="property-info-box">
							<div class="price">$700,000 - $770,000</div>
							<div class="address" title="17 Rayleigh Avenue, Queenscliff VIC 3225">17 Rayleigh Avenue, Queenscliff</div>
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

	<section class="top-add-container">
			<div class="container">
				<div class="add-item">
					More Adds go here
				</div>
			</div>
	</section>

	<section id="blogs">
		<div class="container">
			<div class="blog-heading">
				<h2>Australian Home Buyer News</h2>
				<div class="toggle-btn-wrap">
					<a class="toggle-btn active" data="news">News</a>
					<a class="toggle-btn" data="advice">Advice</a>
				</div>
			</div>
			<div class="news-wrap">
				<div class="news-items" data="news">
					<div class="article-container row">
            <article class="col-1-1 col-tablet-1-2 col-desktop-1-4">
              <a class="image-wrap" href="https://www.realestateview.com.au/blog/2019/08/shop-melbourne-spots/" rel="nofollow">
                <img class="image" src="https://s3-ap-southeast-2.amazonaws.com/rev-blog/wp-content/uploads/heidi-sandstrom-2TLREZi7BUg-unsplash1-e1565587289314-300x158.jpg" alt="Love to shop? These are the Melbourne spots for you">
              </a>
              <a class="blog-title" href="https://www.realestateview.com.au/blog/2019/08/shop-melbourne-spots/" rel="nofollow">
                <h3>Love to shop? These are the Melbourne spots for you</h3>
              </a>
              <p class="blog-content">The traditional Australian shopping strip is experiencing many changes, with online shopping&nbsp;shifting how we shop and what we look for...</p>
            </article>
            <article class="col-1-1 col-tablet-1-2 col-desktop-1-4">
              <a class="image-wrap" href="https://www.realestateview.com.au/blog/2019/08/top-melbourne-homes-sold-2019/" rel="nofollow">
                <img class="image" src="https://s3-ap-southeast-2.amazonaws.com/rev-blog/wp-content/uploads/2a-roslyn-street-brighton-vic-3186-real-estate-photo-10-xlarge-12234897-e1565658131484-300x158.jpg" alt="What are the top Melbourne homes sold in 2019 so far?">
              </a>
              <a class="blog-title" href="https://www.realestateview.com.au/blog/2019/08/top-melbourne-homes-sold-2019/" rel="nofollow">
                <h3>What are the top Melbourne homes sold in 2019 so far?</h3>
              </a>
              <p class="blog-content">March this year saw the bulk of Melbourne's top properties being sold,&nbsp;as those down on the pointy end of Mornington...</p>
            </article>
            <article class="col-1-1 col-tablet-1-2 col-desktop-1-4">
                <a class="image-wrap" href="https://www.realestateview.com.au/blog/2019/08/launceston-property-market-catching-hobart/" rel="nofollow">
                  <img class="image" src="https://s3-ap-southeast-2.amazonaws.com/rev-blog/wp-content/uploads/launceston3-e1566385684571-300x157.jpg" alt="Is the Launceston property market catching up to Hobart?">
                </a>
                <a class="blog-title" href="https://www.realestateview.com.au/blog/2019/08/launceston-property-market-catching-hobart/" rel="nofollow">
                  <h3>Is the Launceston property market catching up to Hobart?</h3>
                </a>
                <p class="blog-content">When the country's biggest property markets have seen considerable downturns over the past 12 months, there have been a few...</p>
            </article>
            <article class="col-1-1 col-tablet-1-2 col-desktop-1-4">
              <a class="image-wrap" href="https://www.realestateview.com.au/blog/2019/08/biggest-challenge-working-real-estate/" rel="nofollow">
                <img class="image" src="https://s3-ap-southeast-2.amazonaws.com/rev-blog/wp-content/uploads/house-300x158.png" alt="What's the biggest challenge to working in real estate? Q&amp;A with Michael Gibson of Kay &amp; Burton">
              </a>
              <a class="blog-title" href="https://www.realestateview.com.au/blog/2019/08/biggest-challenge-working-real-estate/" rel="nofollow">
                  <h3>What's the biggest challenge to working in real estate? Q&amp;A with Michael Gibson of Kay &amp; Burton</h3>
              </a>
              <p class="blog-content">Michael Gibson is of Kay &amp; Burton and has worked within the real estate industry for nearly 40 years. Real...</p>
            </article>
					</div>
					<a href="/blog/" class="view-button" target="_blank" rel="nofollow">More Real Estate News</a>
				</div>
				<div class="news-items" data="advice" style="display: none;">							
					<div class="article-container row">
            <article class="col-1-1 col-tablet-1-2 col-desktop-1-4">
              <a class="image-wrap" href="https://www.realestateview.com.au/advice/investing/planning-zone-property/" rel="nofollow">
                <img class="image" src="https://s3-ap-southeast-2.amazonaws.com/rev-advice/wp-content/uploads/2019/08/landchecker-315x165.png" alt="Why do I need to know what planning zone my property is in?">
              </a>
              <a class="blog-title" href="https://www.realestateview.com.au/advice/investing/planning-zone-property/" rel="nofollow">
                  <h3>Why do I need to know what planning zone my property is in?</h3>
              </a>
              <p class="blog-content">You may have heard the saying 'location, location, location' when it comes to property. But what about zoning, zoning, zoning?...</p>
            </article>
            <article class="col-1-1 col-tablet-1-2 col-desktop-1-4">
                <a class="image-wrap" href="https://www.realestateview.com.au/advice/buying/home-tech/" rel="nofollow">
                  <img class="image" src="https://s3-ap-southeast-2.amazonaws.com/rev-advice/wp-content/uploads/2019/08/Tech-315x165.png" alt="Home tech for your redesign project">
                </a>
                <a class="blog-title" href="https://www.realestateview.com.au/advice/buying/home-tech/" rel="nofollow">
                  <h3>Home tech for your redesign project</h3>
                </a>
                <p class="blog-content">We live&nbsp;in the&nbsp;digital era&nbsp;which&nbsp;has come to be thanks largely (if not entirely) to our ever-expanding curiosity. As human beings, we...</p>
            </article>
            <article class="col-1-1 col-tablet-1-2 col-desktop-1-4">
                <a class="image-wrap" href="https://www.realestateview.com.au/advice/buying/knowing-investing/" rel="nofollow">
                  <img class="image" src="https://s3-ap-southeast-2.amazonaws.com/rev-advice/wp-content/uploads/2019/08/house-315x165.png" alt="Knowing before investing in property">
                </a>
                <a class="blog-title" href="https://www.realestateview.com.au/advice/buying/knowing-investing/" rel="nofollow">
                  <h3>Knowing before investing in property</h3>
                </a>
                <p class="blog-content">When it comes to investing in property, there is nothing more important than knowing, wholeheartedly and without exception, what your...</p>
            </article>
            <article class="col-1-1 col-tablet-1-2 col-desktop-1-4">
                <a class="image-wrap" href="https://www.realestateview.com.au/advice/buying/buy-starter-home/" rel="nofollow">
                  <img class="image" src="https://s3-ap-southeast-2.amazonaws.com/rev-advice/wp-content/uploads/2019/08/architectural-design-architecture-daylight-1974596-e1566300871198-315x166.jpg" alt="Should you buy a &amp;#8216;starter' home before your &amp;#8216;dream' home?">
                </a>
                <a class="blog-title" href="https://www.realestateview.com.au/advice/buying/buy-starter-home/" rel="nofollow">
                  <h3>Should you buy a 'starter' home before your 'dream' home?</h3>
                </a>
                <p class="blog-content">For many first home buyers, the idea of buying a 'starter' home before their 'dream' not only makes sense but...</p>
            </article>
					</div>
					<a href="/advice/" class="view-button" target="_blank" rel="nofollow">More Real Estate Advice</a>
				</div>
			</div>
		</div>
	</section>

	<div id="homepage-content" class="container row">
		<div class="item-left col-1-1 col-tablet-6-8">
			<section class="homepage-more padding-lrg-vert">
				<h2>More Ways to Research Properties for Sale</h2>
				<article class="item">
			    <a class="row flex _align-center" href="/property-360/">
			      <div class="image-wrap col-1-1 col-tablet-1-9"><img class="image" src="assets/images/HomePriceEstimateIcon.png" height="64"></div>
			      <div class="homepage-content col-1-1 col-tablet-8-9">
			        <h3>Price estimate</h3>
			        <p>See how much your home is worth based on the latest market data <i class="fas fa-arrow-right"></i></p>
			      </div>
			    </a>
				</article>
				<article class="item">
			    <a class="row flex _align-center" href="/mobile/">
			      <div class="image-wrap col-1-1 col-tablet-1-9"><img class="image" src="assets/images/HomeAppsIcon.png" height="64"></div>
			      <div class="homepage-content col-1-1 col-tablet-8-9">
			        <h3>Download the app</h3>
			        <p>Download the new View apps on iOS &amp; Android <i class="fas fa-arrow-right"></i></p>
			      </div>
			    </a>
				</article>
				<article class="item">
			    <a class="row flex _align-center" href="#!" onclick="Rev.Views.LoanQuotesView.openModal()">
			      <div class="image-wrap col-1-1 col-tablet-1-9"><img class="image" src="assets/images/HomeLoanIcon.png" height="64"></div>
			      <div class="homepage-content col-1-1 col-tablet-8-9">
			        <h3>Home Loans</h3>
			        <p>Speak to a home loan specialist <i class="fas fa-arrow-right"></i></p>
			      </div>
			    </a>
				</article>
			</section>

			<section class="homepage-company-description padding-lrg-vert">
        <h2>Search Real Estate for Sale</h2>
				<div class="description">
	        <p>Founded in 2001, realestateVIEW.com.au is now one of Australia's leading national real estate portals.</p>
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

			<section class="homepage-seo-links padding-lrg-vert">
			  <h2 class="seo-links-toggle-btn">Search Real Estate for Sale by City or State in Australia</h2>
				<div id="collapsehomepageseo" class="row" style="display: none;">
			    <article class="item col-1-1 col-tablet-1-2">
			        <h3>Real estate for sale</h3>
			        <ul>
			        <li><a href="/real-estate/vic/homes-for-sale/">Properties for sale in VIC</a></li>
			        <li><a href="/real-estate/nsw/homes-for-sale/">Properties for sale in NSW</a></li>
			        <li><a href="/real-estate/sa/homes-for-sale/">Properties for sale in SA</a></li>
			        <li><a href="/real-estate/nt/homes-for-sale/">Properties for sale in NT</a></li>
			        <li><a href="/real-estate/tas/homes-for-sale/">Properties for sale in TAS</a></li>
			        <li><a href="/real-estate/qld/homes-for-sale/">Properties for sale in QLD</a></li>
			        <li><a href="/real-estate/wa/homes-for-sale/">Properties for sale in WA</a></li>
			        <li><a href="/real-estate/act/homes-for-sale/">Properties for sale in ACT</a></li>
			      </ul>
			    </article>
			    <article class="item col-1-1 col-tablet-1-2">
			      <h3>Real estate for sale</h3>
			      <ul>
			        <li><a href="/real-estate/melbourne/homes-for-sale/">Properties for sale in Melbourne</a></li>
			        <li><a href="/real-estate/sydney/homes-for-sale/">Properties for sale in Sydney</a></li>
			        <li><a href="/real-estate/adelaide/homes-for-sale/">Properties for sale in Adelaide</a></li>
			        <li><a href="/real-estate/darwin/homes-for-sale/">Properties for sale in Darwin</a></li>
			        <li><a href="/real-estate/hobart/homes-for-sale/">Properties for sale in Hobart</a></li>
			        <li><a href="/real-estate/brisbane/homes-for-sale/">Properties for sale in Brisbane</a></li>
			        <li><a href="/real-estate/perth/homes-for-sale/">Properties for sale in Perth</a></li>
			        <li><a href="/real-estate/canberra/homes-for-sale/">Properties for sale in Canberra</a></li>
			      </ul>
			    </article>
			    <article class="item col-1-1 col-tablet-1-2">
			      <h3>Houses for sale</h3>
			      <ul>
			        <li><a href="/real-estate/melbourne/houses-for-sale/">Houses for sale in Melbourne</a></li>
			        <li><a href="/real-estate/sydney/houses-for-sale/">Houses for sale in Sydney</a></li>
			        <li><a href="/real-estate/adelaide/houses-for-sale/">Houses for sale in Adelaide</a></li>
			        <li><a href="/real-estate/darwin/houses-for-sale/">Houses for sale in Darwin</a></li>
			        <li><a href="/real-estate/hobart/houses-for-sale/">Houses for sale in Hobart</a></li>
			        <li><a href="/real-estate/brisbane/houses-for-sale/">Houses for sale in Brisbane</a></li>
			        <li><a href="/real-estate/perth/houses-for-sale/">Houses for sale in Perth</a></li>
			        <li><a href="/real-estate/canberra/houses-for-sale/">Houses for sale in Canberra</a></li>
			      </ul>
			    </article>
			    <article class="item col-1-1 col-tablet-1-2">
			      <h3>Apartments for sale</h3>
			      <ul>
				      <li><a href="/real-estate/melbourne/apartments-for-sale/">Apartments for sale in Melbourne</a></li>
				      <li><a href="/real-estate/sydney/apartments-for-sale/">Apartments for sale in Sydney</a></li>
				      <li><a href="/real-estate/adelaide/apartments-for-sale/">Apartments for sale in Adelaide</a></li>
				      <li><a href="/real-estate/darwin/apartments-for-sale/">Apartments for sale in Darwin</a></li>
				      <li><a href="/real-estate/hobart/apartments-for-sale/">Apartments for sale in Hobart</a></li>
				      <li><a href="/real-estate/brisbane/apartments-for-sale/">Apartments for sale in Brisbane</a></li>
				      <li><a href="/real-estate/perth/apartments-for-sale/">Apartments for sale in Perth</a></li>
				      <li><a href="/real-estate/canberra/apartments-for-sale/">Apartments for sale in Canberra</a></li>
			      </ul>
			    </article>
		  	</div>
			</section>

			<section class="homepage-partner-links padding-lrg-vert">
				<h2>View Network</h2>
				<div class="row">
			    <article class="partner-business col-tablet-1-4">
			    	<a class="logo" href="https://www.businessesview.com.au">
		        	<img class="image" src="assets/images/realestateview_logo_hero_rgb.svg">
		      	</a>
		        <h3><a href="https://www.businessesview.com.au">Businesses For Sale</a></h3>
		        <p>Retail, industrial, construction &amp; more businesses.</p>
			    </article>
			    <article class="partner-holiday col-tablet-1-4">
			    	<a class="logo" href="https://www.holidayview.com.au/">
		        	<img class="image" src="assets/images/realestateview_logo_hero_rgb.svg">
		      	</a>
		        <h3><a href="https://www.holidayview.com.au/">Holiday Rentals</a></h3>
		        <p>Holiday rental accommodation to suit your needs.</p>
			    </article>
			    <article class="partner-rural col-tablet-1-4">
			    	<a class="logo" href="https://www.ruralview.com.au/">
		        	<img class="image" src="assets/images/realestateview_logo_hero_rgb.svg">
		      	</a>
		        <h3><a href="https://www.ruralview.com.au/">Rural Properties for Sale</a></h3>
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