<!---
	Password Reset Form
--->
<cfparam name="user">
<cfoutput>
#errorMessagesFor(objectName="user", includeContainer=true)#

<div class="row _v-center">

	<div class="col-1-1">

		<div class="rev__border-top">
			<div class="rev__container rev__pad-xxl-v-top">

				#startFormTag(route="updatePasswordreset", method="put", token=params.token, class="rev__form")#

					<div class="row">
						<div class="hidden-mobile col-tablet-1-4 col-desktop-1-3"></div>
						<div class="col-1-1 col-tablet-2-4 col-desktop-1-3">
							#fieldset(title="Reset Password")#
								<div class="row _pad-lg rev__pad-v-bottom">
									#input(inputType="passwordField", objectname="user", property="password", label="Password *", required="true", markupClass="col-1-1 rev__pad-lg-v-top")#
	      					#input(inputType="passwordField", objectname="user", property="passwordConfirmation", label="Confirm Password *", required="true", markupClass="col-1-1 rev__pad-lg-v-top")#
								</div>
							#fieldsetEnd()#
						</div>
						<div class="hidden-mobile col-tablet-1-4 col-desktop-1-3"></div>
					</div>
					<div class="row _v-center">
						<div class="hidden-mobile col-tablet-1-4 col-desktop-2-6"></div>
						<div class="col-1-2 col-tablet-1-4 col-desktop-1-6"></div>
						<div class="col-1-2 col-tablet-1-4 col-desktop-1-6">
							#submitTag(value="Update Password", class="_reverse")#
						</div>
						<div class="hidden-mobile col-tablet-1-4 col-desktop-2-6"></div>
					</div>
				#endFormTag()#

			</div>
		</div>
	</div>

</div>

</cfoutput>
