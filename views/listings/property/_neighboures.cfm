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
			<div class="map">
				<img class="image" src="../assets/images/neighboure.png" alt="#addressFormat(local.addressStruct)#">
			</div>
			<div class="median">
				<h3 class="subtitle">Median</h3>
				<div class="row">
				    <div class="col-xs-6 col-sm-4 big-number-wrapper">
                        <span class="big-number">$4,071</span>
                        <span class="sub">Monthly Personal Income</span>
                    </div>
                    <div class="col-xs-6 col-sm-4 big-number-wrapper">
                        <span class="big-number">$9,217</span>
                        <span class="sub">Monthly Household Income</span>
                    </div>
                    <div class="col-xs-6 col-sm-4 big-number-wrapper">
                        <span class="big-number">$2,167</span>
                        <span class="sub">Monthly Mortgage Repayments</span>
                    </div>
				</div>
			</div>
			<div class="charts">
				<div class="row">
					<div class="col-xs-12 col-sm-6">
						<h3>Age (%)</h3>
						<div class="chart chart-age">
						</div>
					</div>	
					<div class="col-xs-12 col-sm-6">
						<h3>Households</h3>
						<div class="chart chart-households">
						</div>
					</div>	
					<div class="col-xs-12 col-sm-6">
						<h3>Occupancy (%)</h3>
						<div class="chart chart-occupancy">
						</div>
					</div>	
				</div>
			</div>
		</div>
	</div>
</cfoutput>
