<!---
	Request a Password Reset Form
--->
<cfoutput>

#flashMessageTag(messageType='error', includeContainer=true)#

<div class="row _v-center">

	<div class="col-1-1">

		<div class="rev__border-top">
			<div class="rev__container rev__pad-xxl-v-top">

				#startFormTag(route="PasswordReset", class="rev__form")#

					<div class="row">
						<div class="hidden-mobile col-tablet-1-4 col-desktop-1-3"></div>
						<div class="col-1-1 col-tablet-2-4 col-desktop-1-3">
							#fieldset(title="Reset Password")#
								<div class="row _pad-lg rev__pad-v-bottom">
									#input(inputType="textFieldTag", name="email", label="Email", label="Email Address", markupClass="col-1-1 rev__pad-lg-v-top")#
								</div>
							#fieldsetEnd()#
						</div>
						<div class="hidden-mobile col-tablet-1-4 col-desktop-1-3"></div>
					</div>
					<div class="row _v-center">
						<div class="hidden-mobile col-tablet-1-4 col-desktop-2-6"></div>
						<div class="col-1-2 col-tablet-1-4 col-desktop-1-6">
							#linkTo(route="root", text="Cancel", class="rev__plain-text-link")#
						</div>
						<div class="col-1-2 col-tablet-1-4 col-desktop-1-6">
							#submitTag(value="Send Email", class="_reverse")#
						</div>
						<div class="hidden-mobile col-tablet-1-4 col-desktop-2-6"></div>
					</div>
				#endFormTag()#

			</div>
		</div>
	</div>

</div>

</cfoutput>
