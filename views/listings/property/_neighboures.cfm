<cfoutput>
	<cfsilent>
		<cfset local.addressStruct = {} />
		<cfset local.addressStruct.lotNumber = listing.lotNumber />
		<cfset local.addressStruct.unitNumber = listing.unitNumber />
		<cfset local.addressStruct.streetNumber = listing.streetNumber />
		<cfset local.addressStruct.streetName = listing.streetName />
	</cfsilent>

	<div class="wrapper">
		<div class="inner-wrapper">
			<h2 class="title">Meet the Neighboure near #addressFormat(local.addressStruct)#</h2>
			<div class="brief">See demographic, employment and income info about the people living in this part of Cheltenham</div>
			<div class="description">
				<p>Looking to buy or invest in TH2/7 Tulip Grove, Cheltenham? Our Pocket Insights goes further than just showing demographic data in a suburb, it gives you insights right down to the neighbourhood level. Do you think you will fit in here? We hope so!</p>
			</div>
			<div class="pocket-insight__map">
				<img class="image" src="../assets/images/neigbour.png" alt="#addressFormat(local.addressStruct)#">
			</div>
			<div class="pocket-insight__median">
				<h3 class="subtitle">Median</h3>
				<div class="row">
				    <div class="col-1-1 col-tablet-1-2 col-desktop-1-3 big-number-wrapper">
                        <span class="big-number">$4,071</span>
                        <span class="sub">Monthly Personal Income</span>
                    </div>
                    <div class="col-1-1 col-tablet-1-2 col-desktop-1-3 big-number-wrapper">
                        <span class="big-number">$9,217</span>
                        <span class="sub">Monthly Household Income</span>
                    </div>
                    <div class="col-1-1 col-tablet-1-2 col-desktop-1-3 big-number-wrapper">
                        <span class="big-number">$2,167</span>
                        <span class="sub">Monthly Mortgage Repayments</span>
                    </div>
				</div>
			</div>
			<div class="pocket-insight__charts">
				<div class="row">
					<div class="col-1-1 col-tablet-1-2 col-chart">
						<h3>Age (%)</h3>
						<div class="chart chart-age">
						</div>
					</div>	
					<div class="col-1-1 col-tablet-1-2 col-chart">
						<h3>Households</h3>
						<div class="chart chart-households">
						</div>
					</div>	
					<div class="col-1-1 col-tablet-1-2 col-chart">
						<h3>Occupancy (%)</h3>
						<div class="chart chart-occupancy">
						</div>
					</div>	
				</div>
			</div>

			<div class="pocket-insight__wages">
				<h3 class="subtitle">Weekly Income</h3>
				<div class="inner-wrapper">

				</div>
			</div>
			<div class="pocket-insight__occupations-interests">
				<div class="row">
					<div class="col-1-1 col-tablet-1-2 col-occupations">
						<h3>Top 5 Occupations</h3>
						<div class="inner-wrapper">
							<ul>
								<li class="occupation">Education and training</li>
								<li class="occupation">Health care and social assistance</li>
								<li class="occupation">Professional scientific and technical services</li>
								<li class="occupation">Construction</li>
								<li class="occupation">Retail trade</li>
							</ul>
						</div>
					</div>	
					<div class="col-1-1 col-tablet-1-2 col-interests">
						<h3>Pocket Profile</h3>
						<div class="inner-wrapper">
							<div class="tag-cloud-logo">
								<a href="http://www.roymorgan.com/" target="_blank" rel="nofollow">
									<img src="../assets/images/roy-morgan-logo.jpg" alt="Roy Morgan Research" width="100" height="40">
								</a>
							</div>
							<div class="content tag-cloud jqcloud">
								<span id="9x95_word_0" class="jqcloud-word w10" style="position: absolute; left: 24.5px; top: 45px;">I live a full and busy life</span><span id="9x95_word_5" class="jqcloud-word w6" style="position: absolute; left: 132.795px; top: 238.302px;">Confident</span><span id="9x95_word_14" class="jqcloud-word w3" style="position: absolute; left: 95.7074px; top: 19.0175px;">Played a sport</span><span id="9x95_word_25" class="jqcloud-word w1" style="position: absolute; left: 39.7102px; top: 261.769px;">Held a dinner party</span><span id="9x95_word_29" class="jqcloud-word w1" style="position: absolute; left: 27.2186px; top: 21.8655px;">Baby Boomers</span>
							</div>
						</div>
					</div>	
				</div>
			</div>	
		</div>
	</div>
</cfoutput>
