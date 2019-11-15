<!---
	Agent Login Form:
	Runs through the validation on the tableless model in /models/Auth/Local.cfc
	You can change authentication methods via the app settings and build new Auth models to select
--->
<cfparam name="auth">
<cfparam name="usingRememberMeCookie">
<cfparam name="savedEmail">
<cfoutput>


<div class="row _v-center">

	<div class="col-1-1">

	<div class="rev__border-top">
		<div class="rev__container rev__pad-xxl-v-top">

			#errorMessagesFor("auth")#

			#startFormTag(route="authenticate", class="rev__form")#

				<div class="row">
					<div class="hidden-mobile col-tablet-1-4 col-desktop-1-3"></div>
					<div class="col-1-1 col-tablet-2-4 col-desktop-1-3">
						<div class="row _pad-lg rev__pad-v-bottom">
							#input(inputType="textField", objectname="auth", property="email", label="Email Address", markupClass="col-1-1 rev__pad-lg-v-top")#
							#input(inputType="passwordField", objectname="auth", property="password", label="Password", markupClass="col-1-1 rev__pad-lg-v-top")#
						</div>
					</div>
					<div class="hidden-mobile col-tablet-1-4 col-desktop-1-3"></div>
				</div>
				<div class="row _v-center">
					<div class="hidden-mobile col-tablet-1-4 col-desktop-2-6"></div>
					<div class="col-1-2 col-tablet-1-4 col-desktop-1-6">
						<cfif auth.allowPasswordReset>
							#linkTo(route="passwordreset", text="I forgot my password", class="rev__plain-text-link")#</p>
						</cfif>
					</div>
					<div class="col-1-2 col-tablet-1-4 col-desktop-1-6">
						#submitTag(value="Login", class="_reverse")#
					</div>
					<div class="hidden-mobile col-tablet-1-4 col-desktop-2-6"></div>
				</div>
			#endFormTag()#

		</div>
	</div>
	</div>

</div>
</cfoutput>
