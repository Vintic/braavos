<!---
	"My Account" Password Reset Form
	Also used for when a user has a password block and needs to reset their password
--->
<cfparam name="user">
<cfoutput>
<cfif hasPasswordResetBlock()>
	#pageHeader(title="Password Update Required")#
<cfelse>
	#pageHeader(title="Update Password")#
</cfif>

#startFormTag(id="accountUpdateForm", route="accountPassword", method="put", class="rev__form")#
	<div class="rev__border-top">
		<div class="rev__container">
			#errorMessagesFor("user")#

			#fieldset(title="Update Your Password")#
				<div class="row _pad-lg rev__pad-v">
					<div class="col-1-3">
						#passwordField(objectName="user", property="oldpassword", label="Old Password")#
					</div>
					<div class="col-1-3">
						#passwordField(objectName="user", property="password", label="New Password")#
					</div>
					<div class="col-1-3">
						#passwordField(objectName="user", property="passwordConfirmation", label="Confirm New Password")#
					</div>
				</div>
			#fieldsetEnd()#
		</div>
	</div>
	<div class="rev__form-footer rev__border-top rev__pad-v rev__width-100 rev__bg-white rev__pos _fixed _bottom">
		<div class="rev__container">
			<div class="row">
				<div class="hidden-mobile col-tablet-2-4 col-desktop-4-6"></div>
				<div class="col-1-2 col-tablet-1-4 col-desktop-1-6">
					#linkTo(
						route = "account",
						text = "Cancel",
						class = "rev__btn-dark",
						encode = "attributes"
					)#
				</div>
				<div class="col-1-2 col-tablet-1-4 col-desktop-1-6">
					#submitTag(value="Update", class="_reverse")#
				</div>
			</div>

		</div>
	</div>
#endFormTag()#

</cfoutput>
