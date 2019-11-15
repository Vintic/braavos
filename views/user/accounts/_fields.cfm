<cfoutput>
	<cfsilent>
		<cf_head>
			<script>
				var suburbFields = '##suburbId';

				$(function() {

					var thisState = $("##state").val();

					initSuburbSelects(thisState);

					$("##state").change(function(){
						thisState = $(this).val();
						destroySuburbSelects();
						initSuburbSelects(thisState);
					});

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
					    // Additional AJAX parameters go here; see the end of this chapter for the full code of this example
					  }
					});
				}

				function destroySuburbSelects(){
					$(suburbFields).val('');
					$(suburbFields).select2('destroy');
				}

			</script>
		</cf_head>
	</cfsilent>


	#fieldset(title="Your Account Details")#
		<div class="row _pad-lg rev__pad-v-bottom">
			#input(
				inputType="textField",
				objectName="user",
				property="firstname",
				label="First Name",
				labelClass="rev__pad-sm-v-bottom"
			)#
			#input(
				inputType="textField",
				objectName="user",
				property="lastname",
				label="Last Name",
				labelClass="rev__pad-sm-v-bottom"
			)#
			#input(
				inputType="textField",
				objectName="user",
				property="email",
				label="Email Address",
				labelClass="rev__pad-sm-v-bottom",
				disabled=true
			)#
			#input(
				inputType="textField",
				objectName="user",
				property="mobile",
				label="Mobile",
				labelClass="rev__pad-sm-v-bottom"
			)#
		</div>
		<div class="row _pad-lg rev__pad-v-bottom">
			#input(inputType="textField", objectName="user", property="addressLine1", label="Address Line1")#
			#input(inputType="textField", objectName="user", property="addressLine2", label="Address Line2")#
			#input(inputType="selectTag", name="state", id="state", label="State", options=states, selected=getParam("state","VIC"), valueField="code", textField="state", class="styledSelect")#
			#input(inputType="select", objectName="user", property="suburbId", label="Suburb", id="suburbId", options=suburbs)#
		</div>
	#fieldsetEnd()#

	#fieldset(title="Which best describes you?")#
		<div class="row _pad-lg rev__pad-v-bottom">
			<cfloop query="contactSituations">
				<div class="col-1-1 col-tablet-1-1 col-desktop-1-1 rev__pad-lg-v-top">
					#radioButton(objectName="user", property="situationId", tagValue=contactSituations.id, label=contactSituations.situationName, labelPlacement="after")#
				</div>
			</cfloop>
		</div>
	#fieldsetEnd()#
</cfoutput>
