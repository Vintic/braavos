<cfoutput>
	<cfsilent>
		<cf_head>
			<script>
				var suburbFields = '##suburbIdList';
				$(function() {
					var thisState = 'VIC';
					initSuburbSelects(thisState);
				});

				function initSuburbSelects(state){
					$(suburbFields).select2({
					  ajax: {
					    url:"#urlFor(route='restfulSuburbs', params='format=json')#&maxrows=10&state=" + state,
					    dataType: 'json',
					    processResults: function (data) {
								// Transforms the top-level key of the response object from 'items' to 'results'
								return {
									results: data.data
								};
							}
					  }
					});
				}

			</script>
		</cf_head>
	</cfsilent>

	#pageHeader(title="Auction results in your inbox every Saturday")#

	#startFormTag(route="auctionAlerts",class="rev__form")#
		<div class="rev__border-top">
			<div class="rev__container">
				#fieldset(title="")#
					<div class="row">
						<div class="col-1-1">
							If you are interested in <span class="rev__text _txt-bold">Victorian auction results</span>, we have access to the best auction result information on the market, courtesy of our parent company, REIV.
						</div>
					</div>
					<br>
					<div class="row">
						#input(inputType="selectTag", name="suburbIdList", label="Enter suburb(s):", id="suburbIdList", options=suburbs, multiple=true, markupClass="col-1-1", required=true, selected=getParam("suburbIdList"))#
					</div>
				#fieldsetEnd()#
			</div>
		</div>
		<div class="rev__form-footer rev__border-top rev__pad-v rev__width-100 rev__bg-white rev__pos _fixed _bottom">
			<div class="rev__container">
				<div class="row">
					<div class="hidden-mobile col-tablet-2-4 col-desktop-4-6"></div>
					<div class="col-1-2 col-tablet-1-4 col-desktop-1-6">
					</div>
					<div class="col-1-2 col-tablet-1-4 col-desktop-1-6">
						#submitTag(value="Save", class="_reverse")#
					</div>
				</div>
			</div>
		</div>
	#endFormTag()#

	<cfif auctionAlerts.recordCount>
		<!--- delete button needs to be outside of the form --->
		<div class="rev__container">
			<div class="row">
				<div class="col-1-3 col-tablet-1-4 col-desktop-1-6">
					#postButton(
						text='Stop sending',
						route='auctionAlert',
						method="delete",
						keys={"key":auctionAlerts.id},
						class="rev__btn",
						confirm='Are you sure you want to delete this Auction Alert?'
					)#
				</div>
			</div>
		</div>
	</cfif>

</cfoutput>
