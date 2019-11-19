<cfoutput>
#pageHeader(title="Shortlist #shortLists.recordcount#")#

<div class="rev__border-top">
	<div class="rev__container">
		<cfloop query="shortLists">
			<div class="row">
				<div class="col-1-1">
					#shortLists.fullAddress#<br>
					Bed: #shortLists.bedrooms#<br>
					Bath: #shortLists.bathrooms#<br>
					Car: #shortLists.totalCarSpaces#<br>
					Price: #shortLists.priceText#<br>
					#postButton(
						route = "shortList",
						method = "delete",
						keys = {key=shortLists.id},
						text = "<i class='fas fa-times'></i>",
						class = "rev__btn-circle rev__marg-sm-h-right",
						confirm = "Are you sure you want to remove this listing from your shortlist?"
					)#
				</div>
			</div>
			<br>
		</cfloop>
	</div>
</div>


</cfoutput>
