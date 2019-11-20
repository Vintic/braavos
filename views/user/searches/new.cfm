<cfoutput>
#pageHeader(
	title = "New Search"
)#


#startFormTag(route="searches",class="rev__form")#
	<div class="rev__border-top">
		<div class="rev__container">
			#errorMessageTag("criteria")#

			#includePartial("fields")#
		</div>
	</div>
	<div class="rev__form-footer rev__border-top rev__pad-v rev__width-100 rev__bg-white rev__pos _fixed _bottom">
		<div class="rev__container">
			<div class="row">
				<div class="hidden-mobile col-tablet-2-4 col-desktop-4-6"></div>
				<div class="col-1-2 col-tablet-1-4 col-desktop-1-6">
					#linkTo(
						route = "searches",
						text = "Cancel",
						class = "rev__btn-dark",
						encode = "attributes"
					)#
				</div>
				<div class="col-1-2 col-tablet-1-4 col-desktop-1-6">
					#submitTag(value="Create", class="_reverse")#
				</div>
			</div>
		</div>
	</div>

#endFormTag()#
</cfoutput>

