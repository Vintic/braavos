<cfoutput>
#pageHeader(title="Shortlist #shortLists.recordcount#")#

<div class="rev__border-top">
	<div class="rev__container">
		<cfloop query="shortLists">
			<div class="row">
				<div class="col-1-1">
					#shortLists.fullAddress#<br>
					<i class="fal fa-bed"></i> #shortLists.bedrooms#<br>
					<i class="fal fa-bath"></i> #shortLists.bathrooms#<br>
					<i class="fal fa-car-garage"></i> #shortLists.totalCarSpaces#<br>
					Price: #shortLists.priceText#<br>
					#postButton(
						route = "shortList",
						method = "delete",
						keys = {key=shortLists.id},
						text = "<i class='fas fa-times'></i>",
						class = "rev__btn-circle rev__marg-sm-h-right",
						confirm = "Are you sure you want to remove this listing from your shortlist?"
					)#
					<cfif Len(shortLists.fileName)>
						<img src="#getImageURL(shortLists.fileName, 300)#">
					</cfif>
				</div>
			</div>
			<br><br>
		</cfloop>
	</div>
</div>


</cfoutput>
