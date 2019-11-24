<cfoutput>
<!--- 	<cfsilent>
		<cf_head> --->
			<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-modal/0.9.1/jquery.modal.min.css" />
			#stylesheetLinkTag("rev")#
			<script type="text/javascript" src="https://cdn.jsdelivr.net/jquery/latest/jquery.min.js"></script>
			#javascriptIncludeTag("jquery/jquery-ui-1.12.1/jquery-ui.min.js")#
			<script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.7/js/select2.min.js"></script>


			<script>
				var suburbFields = '##suburbIdList';
				$(function() {
					initSuburbSelects();
				});

				function initSuburbSelects(){
					$(suburbFields).select2({
					  ajax: {
					    url:"#urlFor(route='restfulSuburbs', params='format=json')#&maxrows=10&state=",
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
<!--- 		</cf_head>
	</cfsilent> --->


	#startFormTag(route=params.route, method="get", class="rev__form")#
		<div class="rev__border-top">
			<div class="rev__container">
				#fieldset(title="")#
					<div class="row">
						#input(inputType="selectTag", name="suburbIdList", label="Enter suburb(s):", id="suburbIdList", options=suburbs, multiple=true, markupClass="col-1-2", selected=getParam("suburbIdList"))#
						#input(inputType="textFieldTag", name="agentKeyword", label="Agency Name:", id="agentKeyword", value=getParam("agentKeyword"), markupClass="col-1-2")#
					</div>
				#fieldsetEnd()#

				<cfif (Len(getParam("suburbIdList")) || Len(getParam("agentKeyword"))) && offices.recordCount>
					<div class="row">
						<cfloop query="offices">
							<div class="col-1-1 col-tablet-1-2 col-desktop-1-3">
								<cfif Len(offices.fileName)>
									<img src="#getImageURL(offices.fileName, 300)#">
								</cfif>
								#offices.findAnAgentName#<br>
								#offices.suburbName#<br>
								<cfset local.addressStruct = {}>
								<cfset local.addressStruct.addressLine1 = offices.addressLine1>
								<cfset local.addressStruct.addressLine2 = offices.addressLine2>
								#lineAddressFormat(local.addressStruct)#<br>
								Number of properties: TODO<br>
							</div>
						</cfloop>
					</div>
				</cfif>
			</div>
		</div>
		<div class="rev__form-footer rev__border-top rev__pad-v rev__width-100 rev__bg-white rev__pos _fixed _bottom">
			<div class="rev__container">
				<div class="row">
					<div class="hidden-mobile col-tablet-2-4 col-desktop-4-6"></div>
					<div class="col-1-2 col-tablet-1-4 col-desktop-1-6">
					</div>
					<div class="col-1-2 col-tablet-1-4 col-desktop-1-6">
						#submitTag(value="Search", class="_reverse")#
					</div>
				</div>
			</div>
		</div>
	#endFormTag()#


</cfoutput>
