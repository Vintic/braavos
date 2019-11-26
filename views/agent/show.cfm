<cfoutput>
	<div class="rev__border-top">
		<div class="rev__container">
			<div class="row">
				<div class="col-1-1">
					#agent.agentName#
					<cfif Len(agent.images[1].fileName)>
						<br><img src="#getImageURL(agent.images[1].fileName, 300)#">
					</cfif>
					<cfif Len(officeLogos.fileName)>
						<br><img src="#getImageURL(officeLogos.fileName, 300)#">
					</cfif>
					<br>#agent.position#
					<br>#office.officeName#
					<br>Currently working as a #agent.position# at #office.officeName#
					<br>Email: #agent.email#
					<br>Mobile: #agent.mobile#
				</div>
			</div>
			<hr>
			<div class="row">
				<div class="col-1-1">
					About #agent.firstName#
					<br>#htmlify(agent.profile)#
				</div>
			</div>
			<hr>
			<div class="row">
				<div class="col-1-1">
					Contact #agent.firstName#
					<cfset local.officeAddressStruct = {}>
					<cfset local.officeAddressStruct.addressLine1 = office.addressLine1>
					<cfset local.officeAddressStruct.addressLine2 = office.addressLine2>
					<cfset local.officeAddressStruct.suburbName = office.suburb.suburbName>
					<cfset local.officeAddressStruct.state = office.suburb.state>
					<br>#lineAddressFormat(local.officeAddressStruct)#
				</div>
			</div>
			<hr>
			<div class="row">
				<div class="col-1-1">
					#agent.agentName# #agent.position# - #agent.firstName# is based at #lineAddressFormat(local.officeAddressStruct)#
				</div>
			</div>
		</div>
	</div>

</cfoutput>
