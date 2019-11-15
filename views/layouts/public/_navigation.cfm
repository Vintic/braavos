<!---
	The Main Header + Navigation
--->

<cfsilent>
	<cf_head>
		<script>

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
					<div class="col-2-8 col-desktop-1-5">

						#linkTo(
							route=isAuthenticated() ? "root" : "login",
							text='<img src="/assets/icons/logo.png" border="0" height="38" title="RealEstateView" alt="RealEstateView logo" />'
						)#

					</div>
				</div>

			</div>
		</nav>
	</header>
</cfoutput>
