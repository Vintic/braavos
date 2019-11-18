<cfoutput>
#pageHeader(title="#viewedListings.recordcount# recently viewed properties")#

<div class="rev__border-top">
	<div class="rev__container">
		<cfloop query="viewedListings">
			<div class="row">
				<div class="col-1-1">
					<cfset local.shortListQry = viewedListings.shortListQuery>
					#viewedListings.fullAddress#<br>
					Bed: #viewedListings.bedrooms#<br>
					Bath: #viewedListings.bathrooms#<br>
					Car: #viewedListings.totalCarSpaces#<br>
					Price: #viewedListings.priceText#<br>
					Is shortlist? #local.shortListQry.recordCount ? 'Yes' : 'No'#<br>
					<cfif local.shortListQry.recordCount>
						<!--- option to remove --->
						#postButton(
							route = "shortList",
							method = "delete",
							keys = {key=local.shortListQry.id},
							params = "pageFrom=viewedListings",
							text = "<i class='fas fa-times'></i>",
							class = "rev__btn-circle rev__marg-sm-h-right",
							confirm = "Are you sure you want to remove this listing from your shortlist?"
						)#
					<cfelse>
						<!--- add to shortlist --->
						#postButton(
							route = "shortLists",
							method = "post",
							keys= {},
							params = "listingId=#viewedListings.listingId#&pageFrom=viewedListings",
							text = "<i class='fas fa-plus'></i>",
							class = "rev__btn-circle rev__marg-sm-h-right",
							confirm = "Are you sure you want to add this listing to your shortlist?"
						)#
					</cfif>
				</div>
			</div>
			<br>
		</cfloop>
	</div>
</div>


</cfoutput>
