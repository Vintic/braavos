<!---
	"My Account" Display
--->
<cfparam name="user">
<cfoutput>
#pageHeader(
	title="My Account",
	btn="
		#linkTo(
			route="accountPassword",
			text="<i class='fa fa-key'></i> Change Password",
			encode="attributes",
			class="rev__btn-add"
		)# &nbsp;
		#linkTo(
			route="editAccount",
			text="<i class='fa fa-edit'></i> Edit Details",
			encode="attributes",
			class="rev__btn-add rev__pad-lg-v"
		)#
	"
)#

<div class="rev__border-top">
	<div class="rev__container">
	#startFormTag(id="administratorEditForm", route=params.route, method="patch", class="rev__form")#
		#fieldset(title="Your Account Details")#
			<div class="row _pad-lg rev__pad-v-bottom">
				<div class="col-1-1">
					<ul class="rev__list">
						<li class="_list-heading row rev__text _txt-default _txt-dark rev__pad-sm-v rev__bg-light">
							<div class="col-1-3 rev__text _txt-bold">First Name</div>
							<div class="col-2-3">#e(user.firstname)#</div>
						</li>
						<li class="_list-heading row rev__text _txt-default _txt-dark rev__pad-sm-v rev__bg-light">
							<div class="col-1-3 rev__text _txt-bold">Last Name</div>
							<div class="col-2-3">#e(user.lastname)#</div>
						</li>
						<li class="_list-heading row rev__text _txt-default _txt-dark rev__pad-sm-v rev__bg-light">
							<div class="col-1-3 rev__text _txt-bold">Email</div>
							<div class="col-2-3"><a href="mailto:#e(user.email)#">#e(user.email)#</a></div>
						</li>
						<li class="_list-heading row rev__text _txt-default _txt-dark rev__pad-sm-v rev__bg-light">
							<div class="col-1-3 rev__text _txt-bold">Mobile</div>
							<div class="col-2-3">#e(user.mobile)#</div>
						</li>
						<li class="_list-heading row rev__text _txt-default _txt-dark rev__pad-sm-v rev__bg-light">
							<div class="col-1-3 rev__text _txt-bold">Address</div>
							<div class="col-2-3">#e(user.fullAddress)#</div>
						</li>
						<li class="_list-heading row rev__text _txt-default _txt-dark rev__pad-sm-v rev__bg-light">
							<div class="col-1-3 rev__text _txt-bold">Last Logged In</div>
							<div class="col-2-3">#IsDate(user.loggedInAt) ? formatdate(user.loggedInAt) : "Never"#</div>
						</li>
						<li class="_list-heading row rev__text _txt-default _txt-dark rev__pad-sm-v rev__bg-light">
							<div class="col-1-3 rev__text _txt-bold">Password Last Updated</div>
							<div class="col-2-3"><cfif isDate(user.passwordResetAt)>#timeAgoInWords(user.passwordResetAt)# ago<cfelse>Never</cfif></div>
						</li>
					</ul>
				</div>
			</div>
		#fieldsetEnd()#

		#fieldset(title="Current Situation")#
			<div class="row _pad-lg rev__pad-v-bottom">
				<div class="col-1-1">
					<ul class="rev__list">
						<li class="_list-heading row rev__text _txt-default _txt-dark rev__pad-sm-v rev__bg-light">
							<div class="col-1-1">
								#StructKeyExists(user,'contactSituation') && Len(user.contactSituation) ? user.contactSituation : "N/A"#
							</div>
						</li>
					</ul>
				</div>
			</div>
		#fieldsetEnd()#

	#endFormTag()#
	</div>
</div>


</cfoutput>
