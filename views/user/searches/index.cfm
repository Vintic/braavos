<cfoutput>
<cfsilent>
	<cf_head>
		<script>
			$(function() {
				$(".frequency").change(function(){
					var urlToUse = $(this).attr("urlToUse");
					var thisData = {};
					thisData.sendFrequency = $(this).val();
					thisData.contactId = #currentUser.id#;
					thisData.authenticityToken = '#authenticityToken()#';
				  $.ajax({
				    url: urlToUse + "?format=json",
				    data: thisData,
            type: "PUT",
            dataType: "json"
          }).done(function (response) {
          	// TODO
		      });
				});
			});
		</script>
	</cf_head>
</cfsilent>

#pageHeader(title="Saved Searches and Email Subscriptions")#;
<!--- #pageHeader(
	title="Saved Searches and Email Subscriptions",
	btn=linkTo(
		route="newSearch",
		text="New Search <i class='fa fa-plus'></i>",
		class="rev__btn-add",
		encode="attributes"
	)
)# --->

<div class="rev__border-top">
	<div class="rev__container">

		<ul class="rev__list">
			<li class="_list-heading row rev__text _txt-default _txt-dark _txt-xs rev__border rev__pad-sm-v rev__bg-light">
				<div class="col-3-13 rev__pad-sm-h-left">Location <i class="fal fa-map-marker-alt"></i></div>
				<div class="col-2-13">Price Range </div>
				<div class="col-2-13">Type</div>
				<div class="col-1-13"><i class="fal fa-bed"></i></div>
				<div class="col-1-13"><i class="fal fa-bath"></i></div>
				<div class="col-1-13"><i class="fal fa-car-garage"></i></div>
				<div class="col-2-13">Email Frequence</div>
				<div class="col-1-13"></div>
			</li>
			<cfloop query="criteria">
				<li class="row _v-center rev__text _txt-default _txt-dark rev__border-bottom rev__pad-sm-v">
					<div class="rev__text _txt-default _lh-22 _txt-dark _txt-ellipsis-mobile col-3-13">
						<span class="rev__text _txt-bold _txt-uppercase">#criteria.saleMethod#: </span>
						<cfset local.regionQuery = criteria.regionQuery>
						<cfset local.suburbQuery = criteria.suburbQuery>
						<cfif !local.regionQuery.recordCount && !local.suburbQuery.recordCount>
							Any
						<cfelse>
							<cfloop query="local.regionQuery">
								#local.regionQuery.regionName#<br>
							</cfloop>
							<cfloop query="local.suburbQuery">
								#local.suburbQuery.suburbName#<br>
							</cfloop>
						</cfif>
					</div>
					<div class="rev__text _txt-default _lh-22 _txt-dark _txt-ellipsis-mobile col-2-13">
						<cfif Len(criteria.priceFrom) && Len(criteria.priceTo)>
						#formatDollar(criteria.priceFrom)# - #formatDollar(criteria.priceTo)#
						</cfif>
					</div>
					<div class="rev__text _txt-default _lh-22 _txt-dark _txt-ellipsis-mobile col-2-13">
						<cfset local.propertyTypeQuery = criteria.propertyTypeQuery>
						<cfif !local.propertyTypeQuery.recordCount>
							Any
						<cfelse>
							<cfloop query="local.propertyTypeQuery">
								#local.propertyTypeQuery.propertyType#<br>
							</cfloop>
						</cfif>
					</div>
					<div class="rev__text _txt-default _lh-22 _txt-dark _txt-ellipsis-mobile col-1-13">#criteria.bedrooms#</div>
					<div class="rev__text _txt-default _lh-22 _txt-dark _txt-ellipsis-mobile col-1-13">#criteria.bathrooms#</div>
					<div class="rev__text _txt-default _lh-22 _txt-dark _txt-ellipsis-mobile col-1-13">#criteria.carSpaces#</div>
					<div class="rev__text _txt-default _lh-22 _txt-dark _txt-ellipsis-mobile col-2-13">
						#input(
							inputType="selectTag",
							name="frequence_#criteria.id#",
							class="frequency",
							urlToUse=urlFor(route="restfulCriterium", key=criteria.id),
							options=["Never","Daily","Weekly"],
							includeBlank=false,
							selected=criteria.sendFrequency,
							label=""
						)#
					</div>
					<div class="rev__text _txt-default _lh-22 _txt-dark _txt-ellipsis-mobile col-1-13">
						#postButton(
							route="search",
							method="delete",
							keys={"key":criteria.id},
							text="<i class='fas fa-times'></i>",
							class="rev__btn-circle rev__marg-sm-h-right",
							confirm="Are you sure you wish delete this search?"
						)#
					</div>
				</li>
			</cfloop>
	</div>
</div>


</cfoutput>
