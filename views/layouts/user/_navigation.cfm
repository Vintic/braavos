<!---
	The Main Header + Navigation
--->

<cfsilent>
	<cf_head>
		<script>
			$(function() {

				$(".rev__dropdown")
					.on('click', function() {

						var $button = $(this);
						var thisDropdown = $button.attr('target');
						var thisPosition = $button.attr('position');

						var $dropdown = $("#" + thisDropdown)
						var hAlign = $dropdown.attr('h-align')
						var vAlign = $dropdown.attr('v-align')

						var buttonOff = $button.offset();
						var buttonPos = $button.position();

						if(thisPosition == 'fixed' || thisPosition == 'absolute'){
							var buttonTop = buttonPos.top;
							var buttonBottom = buttonPos.top + $button.height();
						} else {
							var buttonTop = buttonOff.top;
							var buttonBottom = buttonOff.top + $button.height();
						}

						var buttonLeft = buttonOff.left;
						var buttonRight = buttonOff.left + $button.width();

						if( hAlign == 'left' ){
							$("#" + thisDropdown).css('left',buttonLeft);
						} else {
							$("#" + thisDropdown).css('left',buttonRight - $dropdown.width());
						}

						if( vAlign == 'top' ){
							$("#" + thisDropdown).css('top',buttonTop - $dropdown.height());
						} else {
							$("#" + thisDropdown).css('top',buttonBottom);
						}

						$("#" + thisDropdown).toggleClass("open");
					})

					.on('blur', function() {
						var thisTarget = $(this).attr('target');


						setTimeout(function(){
							$("#" + thisTarget).css('top',0).css('left',0).removeClass("open");
						},500);

					});

			});

			$(window).resize(function() {
				$(".rev__dropdown-content").css('top',0).css('left',0).removeClass("open");
			})

		</script>
	</cf_head>
</cfsilent>

<cfoutput>

	<header class="rev__pos _sticky _top rev__bg-white rev__border-bottom">

		<nav>

			<div class="rev__container rev__pad-v">

				<div class="row" style="align-items: center;">
					<div class="col-1-3">

						#linkTo(
							route=isAuthenticated() ? "root" : "login",
							text='<img src="/assets/icons/logo.png" border="0" height="38" title="RealEstateView" alt="RealEstateView logo" />'
						)#

					</div>
					<cfif isAuthenticated()>
						<div class="col-1-3 rev__form">
						</div>
						<div class="col-1-3 col-desktop-1-3  rev__text _right">
							<div style="display: flex; align-items: center; justify-content: flex-end;">
								<span class="rev__text _txt-default _txt-sm _txt-uppercase rev__marg-sm-h-left rev__marg-desktop-lg-h-left rev__dropdown _center" target="menu-dropdown" position="fixed" tabindex="0">
									<i class="fal fa-cog rev__text _txt-light _txt-xl zn__marg"></i>
									<span class="visible-desktop"><i class="fal fa-caret-down" aria-hidden="true" style="font-size: 18px;"></i></span>
								</span>

							</div>

							<div id="menu-dropdown" class="rev__dropdown-content" h-align="right" v-align="bottom">
								#linkTo(text="<i class='fal fa-user'></i> &nbsp; My Account - #e(currentUser.firstName)#", route="account", class="dropdown-item")#
								<hr>
								#linkTo(text="<i class='fal fa-heart'></i> &nbsp; Shortlist", route="shortLists", class='dropdown-item')#
								#linkTo(text="<i class='fal fa-history'></i> &nbsp; Recently Viewed", route="viewedListings", class='dropdown-item')#
								#linkTo(text="<i class='fal fa-file-search'></i> &nbsp; Saved Searches & Emails", route="searches", class='dropdown-item')#
								#linkTo(text="<i class='fal fa-gavel'></i> &nbsp; Auction Results Alerts", route="auctionAlerts", class='dropdown-item')#
								<hr>
								#linkTo(text="<i class='fal fa-sign-out'></i> &nbsp; Logout", route="logout", class="dropdown-item")#
								<cfif isDevelopment()>
									#linkTo(href="#cgi.path_info#?#cgi.query_string##params.KeyExists("reload") ? '' : '&reload=true'#", text="Reload")#
								</cfif>
							</div>

						</div>

					</cfif>

				</div>

			</div>
		</nav>

		<cfif isAuthenticated() && IsStruct(breadcrumbs ?: false)>
			<div class="rev__border-top rev__pad-sm-v">
				<div class="rev__container rev__breadcrumbs rev__text _txt-default _txt-xs rev__flex _v-center">
					<cfif Len(breadcrumbs.rest)>
						<cfif Len(breadcrumbs.rest)><span>#breadcrumbs.rest#</span></cfif>
						#breadcrumbs.separator#
						<span class="_active">#breadcrumbs.last#</span>
					<cfelse>
						<span>#breadcrumbs.all#</span>
					</cfif>

				</div>
			</div>
		</cfif>

	</header>

	<div class="smart-search-results">
		<div class="results"></div>
		<div class="overlay"></div>
	</div>

</cfoutput>
