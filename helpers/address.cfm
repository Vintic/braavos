<cfscript>
// TODO: move all (or most) of these functions into an address service component

/**
* formats a street number for display
*
* [section: Application]
* [category: Address Functions]
*
*/
public string function streetNumberFormat(required struct struct) {
	local.struct = arguments.struct;
	if (structKeyExists(local.struct, "unitNumber") && local.struct.unitNumber != "") {
		if (len(local.struct.unitNumber) gt 0) {
			local.returnValue = listPrepend(local.struct.streetNumber, local.struct.unitNumber, "/");
		} else {
			local.returnValue = local.struct.streetNumber;
		}
	} else {
		local.returnValue = local.struct.streetNumber;
	}
	if (structKeyExists(local.struct, "lotNumber") && local.struct.lotNumber != "") {
		local.returnValue = listPrepend(local.returnValue, local.struct.lotNumber, " ");
	}
	return local.returnValue;
}

/**
* formats a street address for display
*
* [section: Application]
* [category: Address Functions]
*
*/
public string function addressFormat(required struct struct) {
	local.struct = arguments.struct;
	local.struct.streetNumber = streetNumberFormat(arguments.struct);
	local.returnValue = trim(local.struct.streetName);
	if (local.struct.streetNumber != "") {
		local.returnValue = listPrepend(local.returnValue, local.struct.streetNumber, " ");
	}
	if (structKeyExists(local.struct, "suburbName")) {
		local.returnValue = local.returnValue & ", " & titleise(local.struct.suburbName);
	}
	if (structKeyExists(local.struct, "state")) {
		local.returnValue = local.returnValue & ", " & local.struct.state;
	}
	if (structKeyExists(local.struct, "postcode")) {
		local.returnValue = local.returnValue & " " & local.struct.postcode;
	}
	return local.returnValue;
}

/**
* formats a street address for display, struct contains address line 1 and line 2
*
* [section: Application]
* [category: Address Functions]
*
*/
public string function lineAddressFormat(required struct struct) {
	local.struct = arguments.struct;
	if (structKeyExists(local.struct, "address_line_1")) {
		local.returnValue = trim(local.struct.address_line_1);
	} else if (structKeyExists(local.struct, "address_line1") && local.struct.address_line1 != "") {
		local.returnValue = trim(local.struct.address_line1);
	} else {
		local.returnValue = "";
	}
	if (structKeyExists(local.struct, "address_line_2") && local.struct.address_line_2 != "") {
		local.returnValue = local.returnValue & ", " & local.struct.address_line_2;
	} else if (structKeyExists(local.struct, "address_line2") && local.struct.address_line2 != "") {
		local.returnValue = local.returnValue & ", " & local.struct.address_line2;
	}
	if (structKeyExists(local.struct, "suburb_name")) {
		local.returnValue = local.returnValue & ", " & titleise(local.struct.suburb_name);
	} else if (structKeyExists(local.struct, "suburb")) {
		if (local.returnValue == "") {
			local.returnValue = titleise(local.struct.suburb);
		} else {
			local.returnValue = local.returnValue & ", " & titleise(local.struct.suburb);
		}
	}
	if (structKeyExists(local.struct, "state")) {
		local.returnValue = local.returnValue & ", " & local.struct.state;
	}
	if (structKeyExists(local.struct, "postcode")) {
		local.returnValue = local.returnValue & " " & local.struct.postcode;
	} else if (structKeyExists(local.struct, "pcode")) {
		local.returnValue = local.returnValue & " " & local.struct.pcode;
	}
	return local.returnValue;
}

/**
* formats a street address for project
*
* [section: Application]
* [category: Address Functions]
*
*/
public string function projectAddressFormat(required struct struct, string returnType = "project") {
	local.struct = arguments.struct;
	if (arguments.returnType == "display") {
		local.returnValue = local.struct.display_street_number & " " & local.struct.display_street_name;
		if (structKeyExists(local.struct, "displaySuburb") && structKeyExists(local.struct.displaySuburb, "suburb_name")) {
			local.returnValue = local.returnValue & ", " & titleise(local.struct.displaySuburb.suburb_name);
		}
	} else if (arguments.returnType == "twoLines") {
		local.returnValue = local.struct.street_number & " " & local.struct.street_name;
		if (structKeyExists(local.struct, "suburb_name")) {
			local.returnValue = local.returnValue & "<br>" & titleise(local.struct.suburb_name);
		} else if (structKeyExists(local.struct, "suburb") && structKeyExists(local.struct.suburb, "suburb_name")) {
			local.returnValue = local.returnValue & "<br>" & titleise(local.struct.suburb.suburb_name);
		}
	} else {
		local.returnValue = local.struct.street_number & " " & local.struct.street_name;
		if (structKeyExists(local.struct, "suburb_name")) {
			local.returnValue = local.returnValue & ", " & titleise(local.struct.suburb_name);
		} else if (structKeyExists(local.struct, "suburb") && structKeyExists(local.struct.suburb, "suburb_name")) {
			local.returnValue = local.returnValue & ", " & titleise(local.struct.suburb.suburb_name);
		}
	}
	return local.returnValue;
}

/**
* formats a street address to 2 lines (1 Smith Street, Melbourne, VIC 3000 -> 1 Smith Street<br>Melbourne, VIC 3000)
*
* [section: Application]
* [category: Address Functions]
*
*/
public string function splitAddress2Lines(required string address) {
	local.commaPos = Find(',', arguments.address);
	if (Val(local.commaPos)) {
		local.returnValue = Left(arguments.address, local.commaPos);
		local.returnValue &= "<br>";
		local.returnValue &= Mid(arguments.address, local.commaPos+2, Len(arguments.address));
		return local.returnValue;
	} else {
		return arguments.address;
	}

	local.struct = arguments.struct;
	if (arguments.returnType == "display") {
		local.returnValue = local.struct.display_street_number & " " & local.struct.display_street_name;
		if (structKeyExists(local.struct, "displaySuburb") && structKeyExists(local.struct.displaySuburb, "suburb_name")) {
			local.returnValue = local.returnValue & ", " & titleise(local.struct.displaySuburb.suburb_name);
		}
	} else if (arguments.returnType == "twoLines") {
		local.returnValue = local.struct.street_number & " " & local.struct.street_name;
		if (structKeyExists(local.struct, "suburb_name")) {
			local.returnValue = local.returnValue & "<br>" & titleise(local.struct.suburb_name);
		} else if (structKeyExists(local.struct, "suburb") && structKeyExists(local.struct.suburb, "suburb_name")) {
			local.returnValue = local.returnValue & "<br>" & titleise(local.struct.suburb.suburb_name);
		}
	} else {
		local.returnValue = local.struct.street_number & " " & local.struct.street_name;
		if (structKeyExists(local.struct, "suburb_name")) {
			local.returnValue = local.returnValue & ", " & titleise(local.struct.suburb_name);
		} else if (structKeyExists(local.struct, "suburb") && structKeyExists(local.struct.suburb, "suburb_name")) {
			local.returnValue = local.returnValue & ", " & titleise(local.struct.suburb.suburb_name);
		}
	}
	return local.returnValue;
}

/**
* formats a street type
*
* [section: Application]
* [category: Address Functions]
*
*/
public string function parseStreetType(required string string) {
	local.streetTypes = listToArray(application.wheels.streetTypes);
	local.streetType = arguments.string;

	if (arrayFindNoCase(local.streetTypes, local.streetType)) {
		return local.streetType;
	} else if (local.streetType == "accs") {
		local.streetType = "Access";
	} else if (local.streetType == "ally") {
		local.streetType = "Alley";
	} else if (local.streetType == "alwy") {
		local.streetType = "Alleyway";
	} else if (local.streetType == "ambl") {
		local.streetType = "Amble";
	} else if (local.streetType == "app") {
		local.streetType = "Approach";
	} else if (local.streetType == "arc") {
		local.streetType = "Arcade";
	} else if (local.streetType == "art") {
		local.streetType = "Artery";
	} else if (local.streetType == "av" || local.streetType == "ave") {
		local.streetType = "Avenue";
	} else if (local.streetType == "basn") {
		local.streetType = "Basin";
	} else if (local.streetType == "bch") {
		local.streetType = "Beach";
	} else if (local.streetType == "blk") {
		local.streetType = "Block";
	} else if (local.streetType == "blf") {
		local.streetType = "Bluff";
	} else if (local.streetType == "bwlk") {
		local.streetType = "Boardwalk";
	} else if (local.streetType == "bvd" || local.streetType == "blvd" || local.streetType == "bld") {
		local.streetType = "Boulevard";
	} else if (local.streetType == "brce") {
		local.streetType = "Brace";
	} else if (local.streetType == "br") {
		local.streetType = "Branch";
	} else if (local.streetType == "brk") {
		local.streetType = "Break";
	} else if (local.streetType == "bdge") {
		local.streetType = "Bridge";
	} else if (local.streetType == "bdwy") {
		local.streetType = "Broadway";
	} else if (local.streetType == "bypa") {
		local.streetType = "Bypass";
	} else if (local.streetType == "bywy") {
		local.streetType = "Byway";
	} else if (local.streetType == "cyn") {
		local.streetType = "Canyon";
	} else if (local.streetType == "caus") {
		local.streetType = "Causeway";
	} else if (local.streetType == "ch") {
		local.streetType = "Chase";
	} else if (local.streetType == "cir") {
		local.streetType = "Circle";
	} else if (local.streetType == "clt") {
		local.streetType = "Circlet";
	} else if (local.streetType == "cct") {
		local.streetType = "Circuit";
	} else if (local.streetType == "crcs") {
		local.streetType = "Circus";
	} else if (local.streetType == "cl") {
		local.streetType = "Close";
	} else if (local.streetType == "clde") {
		local.streetType = "Colonnade";
	} else if (local.streetType == "cmmn") {
		local.streetType = "Common";
	} else if (local.streetType == "con") {
		local.streetType = "Concourse";
	} else if (local.streetType == "cps") {
		local.streetType = "Copse";
	} else if (local.streetType == "cnr") {
		local.streetType = "Corner";
	} else if (local.streetType == "cso") {
		local.streetType = "Corso";
	} else if (local.streetType == "crse") {
		local.streetType = "Course";
	} else if (local.streetType == "ct" || local.streetType == "crt") {
		local.streetType = "Court";
	} else if (local.streetType == "ctyd") {
		local.streetType = "Courtyard";
	} else if (local.streetType == "crk") {
		local.streetType = "Creek";
	} else if (local.streetType == "cr" || local.streetType == "cres" || local.streetType == "cresc") {
		local.streetType = "Crescent";
	} else if (local.streetType == "crst") {
		local.streetType = "Crest";
	} else if (local.streetType == "crsg") {
		local.streetType = "Crossing";
	} else if (local.streetType == "crd") {
		local.streetType = "Crossroad";
	} else if (local.streetType == "cowy") {
		local.streetType = "Crossway";
	} else if (local.streetType == "cuwy") {
		local.streetType = "Cruiseway";
	} else if (local.streetType == "cds") {
		local.streetType = "Cul-De-Sac";
	} else if (local.streetType == "cttg") {
		local.streetType = "Cutting";
	} else if (local.streetType == "devn") {
		local.streetType = "Deviation";
	} else if (local.streetType == "dstr") {
		local.streetType = "Distributor";
	} else if (local.streetType == "dv") {
		local.streetType = "Divide";
	} else if (local.streetType == "dr" || local.streetType == "drv") {
		local.streetType = "Drive";
	} else if (local.streetType == "drwy") {
		local.streetType = "Driveway";
	} else if (local.streetType == "ent") {
		local.streetType = "Entrance";
	} else if (local.streetType == "esp") {
		local.streetType = "Esplanade";
	} else if (local.streetType == "est") {
		local.streetType = "Estate";
	} else if (local.streetType == "exp") {
		local.streetType = "Expressway";
	} else if (local.streetType == "extn") {
		local.streetType = "Extension";
	} else if (local.streetType == "fawy") {
		local.streetType = "Fairway";
	} else if (local.streetType == "ftrk") {
		local.streetType = "Fire Track";
	} else if (local.streetType == "ftrl") {
		local.streetType = "Firetrail";
	} else if (local.streetType == "folw") {
		local.streetType = "Follow";
	} else if (local.streetType == "ftwy") {
		local.streetType = "Footway";
	} else if (local.streetType == "fshr") {
		local.streetType = "Foreshore";
	} else if (local.streetType == "form") {
		local.streetType = "Formation";
	} else if (local.streetType == "fwy") {
		local.streetType = "Freeway";
	} else if (local.streetType == "frnt") {
		local.streetType = "Front";
	} else if (local.streetType == "frtg") {
		local.streetType = "Frontage";
	} else if (local.streetType == "gdn") {
		local.streetType = "Garden";
	} else if (local.streetType == "gdns") {
		local.streetType = "Gardens";
	} else if (local.streetType == "gte") {
		local.streetType = "Gate";
	} else if (local.streetType == "gtes") {
		local.streetType = "Gates";
	} else if (local.streetType == "gld") {
		local.streetType = "Glade";
	} else if (local.streetType == "gra") {
		local.streetType = "Grange";
	} else if (local.streetType == "grn") {
		local.streetType = "Green";
	} else if (local.streetType == "grnd") {
		local.streetType = "Ground";
	} else if (local.streetType == "gr") {
		local.streetType = "Grove";
	} else if (local.streetType == "gly") {
		local.streetType = "Gully";
	} else if (local.streetType == "hts") {
		local.streetType = "Heights";
	} else if (local.streetType == "hrd") {
		local.streetType = "Highroad";
	} else if (local.streetType == "hwy") {
		local.streetType = "Highway";
	} else if (local.streetType == "intg") {
		local.streetType = "Interchange";
	} else if (local.streetType == "intn") {
		local.streetType = "Intersection";
	} else if (local.streetType == "jnc") {
		local.streetType = "Junction";
	} else if (local.streetType == "ldg") {
		local.streetType = "Landing";
	} else if (local.streetType == "lane" || local.streetType == "ln") {
		local.streetType = "Lane";
	} else if (local.streetType == "lnwy") {
		local.streetType = "Laneway";
	} else if (local.streetType == "lt") {
		local.streetType = "Little";
	} else if (local.streetType == "lkt") {
		local.streetType = "Lookout";
	} else if (local.streetType == "loop") {
		local.streetType = "Loop";
	} else if (local.streetType == "lwr") {
		local.streetType = "Lower";
	} else if (local.streetType == "mall") {
		local.streetType = "Mall";
	} else if (local.streetType == "mdw") {
		local.streetType = "Meadow";
	} else if (local.streetType == "mndr") {
		local.streetType = "Meander";
	} else if (local.streetType == "mews") {
		local.streetType = "Mews";
	} else if (local.streetType == "mwy") {
		local.streetType = "Motorway";
	} else if (local.streetType == "mt") {
		local.streetType = "Mount";
	} else if (local.streetType == "mtn") {
		local.streetType = "Mountain";
	} else if (local.streetType == "otlk") {
		local.streetType = "Outlook";
	} else if (local.streetType == "opas") {
		local.streetType = "Overpass";
	} else if (local.streetType == "pde") {
		local.streetType = "Parade";
	} else if (local.streetType == "park" || local.streetType == "pk") {
		local.streetType = "Park";
	} else if (local.streetType == "pkld") {
		local.streetType = "Parklands";
	} else if (local.streetType == "pwy" || local.streetType == "pkwy") {
		local.streetType = "Parkway";
	} else if (local.streetType == "psge") {
		local.streetType = "Passage";
	} else if (local.streetType == "path") {
		local.streetType = "Path";
	} else if (local.streetType == "piaz") {
		local.streetType = "Piazza";
	} else if (local.streetType == "pl") {
		local.streetType = "Place";
	} else if (local.streetType == "pln") {
		local.streetType = "Plain";
	} else if (local.streetType == "plat") {
		local.streetType = "Plateau";
	} else if (local.streetType == "plza") {
		local.streetType = "Plaza";
	} else if (local.streetType == "pnt") {
		local.streetType = "Point";
	} else if (local.streetType == "prom") {
		local.streetType = "Promenade";
	} else if (local.streetType == "qy") {
		local.streetType = "Quay";
	} else if (local.streetType == "qys") {
		local.streetType = "Quays";
	} else if (local.streetType == "rmbl") {
		local.streetType = "Ramble";
	} else if (local.streetType == "ramp") {
		local.streetType = "Ramp";
	} else if (local.streetType == "rnge") {
		local.streetType = "Range";
	} else if (local.streetType == "rch") {
		local.streetType = "Reach";
	} else if (local.streetType == "res") {
		local.streetType = "Reserve";
	} else if (local.streetType == "rtt") {
		local.streetType = "Retreat";
	} else if (local.streetType == "rdge") {
		local.streetType = "Ridge";
	} else if (local.streetType == "rgwy") {
		local.streetType = "Ridgeway";
	} else if (local.streetType == "rowy") {
		local.streetType = "Right Of Way";
	} else if (local.streetType == "rise") {
		local.streetType = "Rise";
	} else if (local.streetType == "rvr") {
		local.streetType = "River";
	} else if (local.streetType == "rvwy") {
		local.streetType = "Riverway";
	} else if (local.streetType == "rvra") {
		local.streetType = "Riviera";
	} else if (local.streetType == "rd") {
		local.streetType = "Road";
	} else if (local.streetType == "rnde") {
		local.streetType = "Ronde";
	} else if (local.streetType == "rnd") {
		local.streetType = "Round";
	} else if (local.streetType == "rte") {
		local.streetType = "Route";
	} else if (local.streetType == "swy") {
		local.streetType = "Service Way";
	} else if (local.streetType == "sdng") {
		local.streetType = "Siding";
	} else if (local.streetType == "slpe") {
		local.streetType = "Slope";
	} else if (local.streetType == "snd") {
		local.streetType = "Sound";
	} else if (local.streetType == "sq" || local.streetType == "sqr") {
		local.streetType = "Square";
	} else if (local.streetType == "strs") {
		local.streetType = "Stairs";
	} else if (local.streetType == "sta") {
		local.streetType = "Station";
	} else if (local.streetType == "sh") {
		local.streetType = "State Highway";
	} else if (local.streetType == "stps") {
		local.streetType = "Steps";
	} else if (local.streetType == "stra") {
		local.streetType = "Strand";
	} else if (local.streetType == "st") {
		local.streetType = "Street";
	} else if (local.streetType == "sbwy") {
		local.streetType = "Subway";
	} else if (local.streetType == "smt") {
		local.streetType = "Summit";
	} else if (local.streetType == "tce") {
		local.streetType = "Terrace";
	} else if (local.streetType == "thor") {
		local.streetType = "Thoroughfare";
	} else if (local.streetType == "thwy") {
		local.streetType = "Throughway";
	} else if (local.streetType == "tlwy") {
		local.streetType = "Tollway";
	} else if (local.streetType == "twrs") {
		local.streetType = "Towers";
	} else if (local.streetType == "trk") {
		local.streetType = "Track";
	} else if (local.streetType == "trfy") {
		local.streetType = "Trafficway";
	} else if (local.streetType == "trl") {
		local.streetType = "Trail";
	} else if (local.streetType == "trlr") {
		local.streetType = "Trailer";
	} else if (local.streetType == "tri") {
		local.streetType = "Triangle";
	} else if (local.streetType == "tkwy") {
		local.streetType = "Trunkway";
	} else if (local.streetType == "tunl") {
		local.streetType = "Tunnel";
	} else if (local.streetType == "tpk") {
		local.streetType = "Turnpike";
	} else if (local.streetType == "upas") {
		local.streetType = "Underpass";
	} else if (local.streetType == "upr") {
		local.streetType = "Upper";
	} else if (local.streetType == "vly") {
		local.streetType = "Valley";
	} else if (local.streetType == "vdct") {
		local.streetType = "Viaduct";
	} else if (local.streetType == "view") {
		local.streetType = "View";
	} else if (local.streetType == "vll") {
		local.streetType = "Villa";
	} else if (local.streetType == "vlg") {
		local.streetType = "Village";
	} else if (local.streetType == "vlls") {
		local.streetType = "Villas";
	} else if (local.streetType == "vsta") {
		local.streetType = "Vista";
	} else if (local.streetType == "walk") {
		local.streetType = "Walk";
	} else if (local.streetType == "wkwy") {
		local.streetType = "Walkway";
	} else if (local.streetType == "wtr") {
		local.streetType = "Water";
	} else if (local.streetType == "way") {
		local.streetType = "Way";
	} else if (local.streetType == "whrf") {
		local.streetType = "Wharf";
	}
	return local.streetType;
}

function parseAddress(required string string) {
	local.returnValue = {
		subNumber = "",
		streetNumber = "",
		streetName = "",
		suburb = "",
		postcode = "",
		state = ""
	};
	local.string = arguments.string;
	// replace the multi-word state names with their respective codes
	for (
		local.i in [
			"New South Wales",
			"South Australia",
			"Western Australia",
			"Australian Capital Territory",
			"Northern Territory"
		]
	) {
		local.string = replaceNoCase(local.string, local.i, sanitiseState(local.i));
	}
	local.delims = ", ";
	// check the string length
	local.parts = listToArray(local.string, local.delims);
	local.partsLength = arrayLen(local.parts);
	// loop thru and extract state and postcode
	local.state = "";
	local.postcode = "";
	local.streetSuburb = local.string;
	// start at 4 so i dont confuse a large street number with a postcode, || a street name with a state.. Eg: Victoria Street
	loop from="4" to="#local.partsLength#" index="local.i" {
		local.str = local.parts[local.i];
		if (isState(local.str)) {
			local.streetSuburb = listDeleteValue(local.streetSuburb, local.str, " ");
			local.state = sanitiseState(local.str);
		}
		if (isPostcode(local.str)) {
			local.streetSuburb = listDeleteValue(local.streetSuburb, local.str, " ");
			local.postcode = local.str;
		}
	}
	local.separatedStreetNameAndSuburb = separateStreetNameFromSuburb(local.streetSuburb);
	// build the return value
	local.returnValue = parseStreetAddress(local.separatedStreetNameAndSuburb.street);
	local.returnValue.suburb = trim(local.separatedStreetNameAndSuburb.suburb);
	local.returnValue.postcode = local.postcode;
	local.returnValue.state = local.state;
	return local.returnValue;
}

public struct function separateStreetNameFromSuburb(required string string) {
	local.returnValue = {street = "", suburb = ""};
	if (isEmpty(arguments.string)) {
		return local.returnValue;
	}
	// see if the address can be comma separated (1 Smith Street, Collingwood)
	if (listLen(arguments.string) == 2 && listLen(listRest(arguments.string), " ") lte 2) {
		local.returnValue.street = sanitiseStreetAddress(listFirst(arguments.string));
		local.returnValue.suburb = sanitiseList(listRest(arguments.string));
	} else {
		// now start from the end, and stop when i find a street type.. everything after this must be the suburb
		local.parts = listToArray(arguments.string, ", ");
		local.streetAddress = "";
		local.foundStreetType = false;
		// loop thru each part until I pass a street type, until I find another part which is not.. eg: High Street Road _Red_ Hill
		for (local.part in local.parts) {
			if (isStreetType(local.part)) {
				local.foundStreetType = true;
			}
			if (local.foundStreetType && isFalse(isStreetType(local.part))) {
				break;
			}
			local.streetAddress = listAppend(local.streetAddress, local.part, " ");
		}
		local.returnValue.street = local.streetAddress;
		// whatever is left over must be the suburb..
		local.returnValue.suburb = trim(
			replaceNoCase(
				arguments.string,
				local.streetAddress,
				"",
				"one"
			)
		);
	}
	return local.returnValue;
}

public boolean function isStreetType(required string string) {
	return listFindNoCase(get("streetTypes"), arguments.string) || listFindNoCase(
		get("streetTypes"),
		parseStreetType(arguments.string)
	);
}

/*
  * Replaces full address to only show street and suburb (i.e. 34 Smith Street, Melbourne, VIC 3000 -> 34 Smith Street, Melbourne)
*/
function shortenFullAddress(required string string) {
	if (listLen(arguments.string) GTE 2) {
		return "#listFirst(arguments.string)#, #listGetAt(arguments.string, 2)#";
	} else {
		return arguments.string;
	}
}

function isPostcode(required string string) {
	local.string = reReplaceNoCase(arguments.string, "[^0-9]", "", "all");
	return len(local.string) == 4 && listFind("0,2,3,4,5,6,7", left(local.string, 1));
}

function isState(required string string) {
	return listFindNoCase(
		"VIC,NSW,QLD,TAS,SA,WA,ACT,NT,Victoria,New South Wales,Queensland,Tasmania,South Australia,Western Australia,Australian Capital Territory,Northern Territory",
		arguments.string
	);
}

function sanitiseState(required string string) {
	local.str = arguments.string;
	local.returnValue = uCase(arguments.string);
	if (local.str == "Victoria") {
		local.returnValue = "VIC"
	} else if (local.str == "New South Wales") {
		local.returnValue = "NSW"
	} else if (local.str == "Queensland") {
		local.returnValue = "QLD"
	} else if (local.str == "Tasmania") {
		local.returnValue = "TAS"
	} else if (local.str == "South Australia") {
		local.returnValue = "SA"
	} else if (local.str == "Western Australia") {
		local.returnValue = "WA"
	} else if (local.str == "Australian Capital Territory") {
		local.returnValue = "ACT"
	} else if (local.str == "Northern Territory") {
		local.returnValue = "NT"
	}
	return local.returnValue;
}

/**
* Replaces street type abbereviations (only the last.. Eg: 1 St Helens Rd becomes 1 St Helens Road)
*/
function sanitiseStreetAddress(required string string) {
	local.slices = listToArray(arguments.string, " ");
	local.last = local.slices[local.slices.Len()];
	local.slices[local.slices.Len()] = parseStreetType(local.last);
	return arrayToList(local.slices, " ");
}

function isValidAddress(required string address) {
	local.thisAddress = parseAddress(arguments.address);
	if (
		!(
			len(local.thisAddress.streetNumber) && len(local.thisAddress.streetName) && len(local.thisAddress.suburb) && len(
				local.thisAddress.postcode
			) && len(local.thisAddress.state)
		)
	) {
		return false;
	} else {
		return true;
	}
}

function returnStreetTypeAliases(required string streetType) {
	local.streetType = arguments.streetType;
	local.typeArray = [];
	if (local.streetType == "accs" || local.streetType == "Access") {
		local.typeArray.Append("accs");
		local.typeArray.Append("Access");
	} else if (local.streetType == "ally" || local.streetType == "Alley") {
		local.typeArray.Append("ally");
		local.typeArray.Append("Alley");
	} else if (local.streetType == "alwy" || local.streetType == "Alleyway") {
		local.typeArray.Append("alwy");
		local.typeArray.Append("Alleyway");
	} else if (local.streetType == "ambl" || local.streetType == "Amble") {
		local.typeArray.Append("ambl");
		local.typeArray.Append("Amble");
	} else if (local.streetType == "app" || local.streetType == "Approach") {
		local.typeArray.Append("app");
		local.typeArray.Append("Approach");
	} else if (local.streetType == "arc" || local.streetType == "Arcade") {
		local.typeArray.Append("arc");
		local.typeArray.Append("Arcade");
	} else if (local.streetType == "art" || local.streetType == "Artery") {
		local.typeArray.Append("art");
		local.typeArray.Append("Artery");
	} else if (local.streetType == "av" || local.streetType == "Avenue" || local.streetType == "ave") {
		local.typeArray.Append("av");
		local.typeArray.Append("Avenue");
		local.typeArray.Append("ave");
	} else if (local.streetType == "basn" || local.streetType == "Basin") {
		local.typeArray.Append("basn");
		local.typeArray.Append("Basin");
	} else if (local.streetType == "bch" || local.streetType == "Beach") {
		local.typeArray.Append("bch");
		local.typeArray.Append("Beach");
	} else if (local.streetType == "blk" || local.streetType == "Block") {
		local.typeArray.Append("blk");
		local.typeArray.Append("Block");
	} else if (local.streetType == "blf" || local.streetType == "Bluff") {
		local.typeArray.Append("blf");
		local.typeArray.Append("Bluff");
	} else if (local.streetType == "bwlk" || local.streetType == "Boardwalk") {
		local.typeArray.Append("bwlk");
		local.typeArray.Append("Boardwalk");
	} else if (
		local.streetType == "bvd" || local.streetType == "blvd" || local.streetType == "bld" || local.streetType == "Boulevard"
	) {
		local.typeArray.Append("bvd");
		local.typeArray.Append("blvd");
		local.typeArray.Append("bld");
		local.typeArray.Append("Boulevard");
	} else if (local.streetType == "brce" || local.streetType == "Brace") {
		local.typeArray.Append("brce");
		local.typeArray.Append("Brace");
	} else if (local.streetType == "br" || local.streetType == "Branch") {
		local.typeArray.Append("br");
		local.typeArray.Append("Branch");
	} else if (local.streetType == "brk" || local.streetType == "Break") {
		local.typeArray.Append("brk");
		local.typeArray.Append("Break");
	} else if (local.streetType == "bdge" || local.streetType == "Bridge") {
		local.typeArray.Append("bdge");
		local.typeArray.Append("Bridge");
	} else if (local.streetType == "bdwy" || local.streetType == "Broadway") {
		local.typeArray.Append("bdwy");
		local.typeArray.Append("Broadway");
	} else if (local.streetType == "bypa" || local.streetType == "Bypass") {
		local.typeArray.Append("bypa");
		local.typeArray.Append("Bypass");
	} else if (local.streetType == "bywy" || local.streetType == "Byway") {
		local.typeArray.Append("bywy");
		local.typeArray.Append("Byway");
	} else if (local.streetType == "cyn" || local.streetType == "Canyon") {
		local.typeArray.Append("cyn");
		local.typeArray.Append("Canyon");
	} else if (local.streetType == "caus" || local.streetType == "Causeway") {
		local.typeArray.Append("caus");
		local.typeArray.Append("Causeway");
	} else if (local.streetType == "ch" || local.streetType == "Chase") {
		local.typeArray.Append("ch");
		local.typeArray.Append("Chase");
	} else if (local.streetType == "cir" || local.streetType == "Circle") {
		local.typeArray.Append("cir");
		local.typeArray.Append("Circle");
	} else if (local.streetType == "clt" || local.streetType == "Circlet") {
		local.typeArray.Append("clt");
		local.typeArray.Append("Circlet");
	} else if (local.streetType == "cct" || local.streetType == "Circuit") {
		local.typeArray.Append("cct");
		local.typeArray.Append("Circuit");
	} else if (local.streetType == "crcs" || local.streetType == "Circus") {
		local.typeArray.Append("crcs");
		local.typeArray.Append("Circus");
	} else if (local.streetType == "cl" || local.streetType == "Close") {
		local.typeArray.Append("cl");
		local.typeArray.Append("Close");
	} else if (local.streetType == "clde" || local.streetType == "Colonnade") {
		local.typeArray.Append("clde");
		local.typeArray.Append("Colonnade");
	} else if (local.streetType == "cmmn" || local.streetType == "Common") {
		local.typeArray.Append("cmmn");
		local.typeArray.Append("Common");
	} else if (local.streetType == "con" || local.streetType == "Concourse") {
		local.typeArray.Append("con");
		local.typeArray.Append("Concourse");
	} else if (local.streetType == "cps" || local.streetType == "Copse") {
		local.typeArray.Append("cps");
		local.typeArray.Append("Copse");
	} else if (local.streetType == "cnr" || local.streetType == "Corner") {
		local.typeArray.Append("cnr");
		local.typeArray.Append("Corner");
	} else if (local.streetType == "cso" || local.streetType == "Corso") {
		local.typeArray.Append("cso");
		local.typeArray.Append("Corso");
	} else if (local.streetType == "crse" || local.streetType == "Course") {
		local.typeArray.Append("crse");
		local.typeArray.Append("Course");
	} else if (local.streetType == "ct" || local.streetType == "crt" || local.streetType == "Court") {
		local.typeArray.Append("ct");
		local.typeArray.Append("crt");
		local.typeArray.Append("Court");
	} else if (local.streetType == "ctyd" || local.streetType == "Courtyard") {
		local.typeArray.Append("ctyd");
		local.typeArray.Append("Courtyard");
	} else if (local.streetType == "crk" || local.streetType == "Creek") {
		local.typeArray.Append("crk");
		local.typeArray.Append("Creek");
	} else if (
		local.streetType == "cr" || local.streetType == "cres" || local.streetType == "cresc" || local.streetType == "Crescent"
	) {
		local.typeArray.Append("cr");
		local.typeArray.Append("cres");
		local.typeArray.Append("cresc");
		local.typeArray.Append("Crescent");
	} else if (local.streetType == "crst" || local.streetType == "Crest") {
		local.typeArray.Append("crst");
		local.typeArray.Append("Crest");
	} else if (local.streetType == "crsg" || local.streetType == "Crossing") {
		local.typeArray.Append("crsg");
		local.typeArray.Append("Crossing");
	} else if (local.streetType == "crd" || local.streetType == "Crossroad") {
		local.typeArray.Append("crd");
		local.typeArray.Append("Crossroad");
	} else if (local.streetType == "cowy" || local.streetType == "Crossway") {
		local.typeArray.Append("cowy");
		local.typeArray.Append("Crossway");
	} else if (local.streetType == "cuwy" || local.streetType == "Cruiseway") {
		local.typeArray.Append("cuwy");
		local.typeArray.Append("Cruiseway");
	} else if (local.streetType == "cds" || local.streetType == "Cul-De-Sac") {
		local.typeArray.Append("cds");
		local.typeArray.Append("Cul-De-Sac");
	} else if (local.streetType == "cttg" || local.streetType == "Cutting") {
		local.typeArray.Append("cttg");
		local.typeArray.Append("Cutting");
	} else if (local.streetType == "devn" || local.streetType == "Deviation") {
		local.typeArray.Append("devn");
		local.typeArray.Append("Deviation");
	} else if (local.streetType == "dstr" || local.streetType == "Distributor") {
		local.typeArray.Append("dstr");
		local.typeArray.Append("Distributor");
	} else if (local.streetType == "dv" || local.streetType == "Divide") {
		local.typeArray.Append("dv");
		local.typeArray.Append("Divide");
	} else if (local.streetType == "dr" || local.streetType == "drv" || local.streetType == "Drive") {
		local.typeArray.Append("dr");
		local.typeArray.Append("drv");
		local.typeArray.Append("Drive");
	} else if (local.streetType == "drwy" || local.streetType == "Driveway") {
		local.typeArray.Append("drwy");
		local.typeArray.Append("Driveway");
	} else if (local.streetType == "ent" || local.streetType == "Entrance") {
		local.typeArray.Append("ent");
		local.typeArray.Append("Entrance");
	} else if (local.streetType == "esp" || local.streetType == "Esplanade") {
		local.typeArray.Append("esp");
		local.typeArray.Append("Esplanade");
	} else if (local.streetType == "est" || local.streetType == "Estate") {
		local.typeArray.Append("est");
		local.typeArray.Append("Estate");
	} else if (local.streetType == "exp" || local.streetType == "Expressway") {
		local.typeArray.Append("exp");
		local.typeArray.Append("Expressway");
	} else if (local.streetType == "extn" || local.streetType == "Extension") {
		local.typeArray.Append("extn");
		local.typeArray.Append("Extension");
	} else if (local.streetType == "fawy" || local.streetType == "Fairway") {
		local.typeArray.Append("fawy");
		local.typeArray.Append("Fairway");
	} else if (local.streetType == "ftrk" || local.streetType == "Fire Track") {
		local.typeArray.Append("ftrk");
		local.typeArray.Append("Fire Track");
	} else if (local.streetType == "ftrl" || local.streetType == "Firetrail") {
		local.typeArray.Append("ftrl");
		local.typeArray.Append("Firetrail");
	} else if (local.streetType == "folw" || local.streetType == "Follow") {
		local.typeArray.Append("folw");
		local.typeArray.Append("Follow");
	} else if (local.streetType == "ftwy" || local.streetType == "Footway") {
		local.typeArray.Append("ftwy");
		local.typeArray.Append("Footway");
	} else if (local.streetType == "fshr" || local.streetType == "Foreshore") {
		local.typeArray.Append("fshr");
		local.typeArray.Append("Foreshore");
	} else if (local.streetType == "form" || local.streetType == "Formation") {
		local.typeArray.Append("form");
		local.typeArray.Append("Formation");
	} else if (local.streetType == "fwy" || local.streetType == "Freeway") {
		local.typeArray.Append("fwy");
		local.typeArray.Append("Freeway");
	} else if (local.streetType == "frnt" || local.streetType == "Front") {
		local.typeArray.Append("frnt");
		local.typeArray.Append("Front");
	} else if (local.streetType == "frtg" || local.streetType == "Frontage") {
		local.typeArray.Append("frtg");
		local.typeArray.Append("Frontage");
	} else if (local.streetType == "gdn" || local.streetType == "Garden") {
		local.typeArray.Append("gdn");
		local.typeArray.Append("Garden");
	} else if (local.streetType == "gdns" || local.streetType == "Gardens") {
		local.typeArray.Append("gdns");
		local.typeArray.Append("Gardens");
	} else if (local.streetType == "gte" || local.streetType == "Gate") {
		local.typeArray.Append("gte");
		local.typeArray.Append("Gate");
	} else if (local.streetType == "gtes" || local.streetType == "Gates") {
		local.typeArray.Append("gtes");
		local.typeArray.Append("Gates");
	} else if (local.streetType == "gld" || local.streetType == "Glade") {
		local.typeArray.Append("gld");
		local.typeArray.Append("Glade");
	} else if (local.streetType == "gra" || local.streetType == "Grange") {
		local.typeArray.Append("gra");
		local.typeArray.Append("Grange");
	} else if (local.streetType == "grn" || local.streetType == "Green") {
		local.typeArray.Append("grn");
		local.typeArray.Append("Green");
	} else if (local.streetType == "grnd" || local.streetType == "Ground") {
		local.typeArray.Append("grnd");
		local.typeArray.Append("Ground");
	} else if (local.streetType == "gr" || local.streetType == "Grove") {
		local.typeArray.Append("gr");
		local.typeArray.Append("Grove");
	} else if (local.streetType == "gly" || local.streetType == "Gully") {
		local.typeArray.Append("gly");
		local.typeArray.Append("Gully");
	} else if (local.streetType == "hts" || local.streetType == "Heights") {
		local.typeArray.Append("hts");
		local.typeArray.Append("Heights");
	} else if (local.streetType == "hrd" || local.streetType == "Highroad") {
		local.typeArray.Append("hrd");
		local.typeArray.Append("Highroad");
	} else if (local.streetType == "hwy" || local.streetType == "Highway") {
		local.typeArray.Append("hwy");
		local.typeArray.Append("Highway");
	} else if (local.streetType == "intg" || local.streetType == "Interchange") {
		local.typeArray.Append("intg");
		local.typeArray.Append("Interchange");
	} else if (local.streetType == "intn" || local.streetType == "Intersection") {
		local.typeArray.Append("intn");
		local.typeArray.Append("Intersection");
	} else if (local.streetType == "jnc" || local.streetType == "Junction") {
		local.typeArray.Append("jnc");
		local.typeArray.Append("Junction");
	} else if (local.streetType == "ldg" || local.streetType == "Landing") {
		local.typeArray.Append("ldg");
		local.typeArray.Append("Landing");
	} else if (local.streetType == "lane" || local.streetType == "ln" || local.streetType == "Lane") {
		local.typeArray.Append("lane");
		local.typeArray.Append("ln");
		local.typeArray.Append("Lane");
	} else if (local.streetType == "lnwy" || local.streetType == "Laneway") {
		local.typeArray.Append("lnwy");
		local.typeArray.Append("Laneway");
	} else if (local.streetType == "lt" || local.streetType == "Little") {
		local.typeArray.Append("lt");
		local.typeArray.Append("Little");
	} else if (local.streetType == "lkt" || local.streetType == "Lookout") {
		local.typeArray.Append("lkt");
		local.typeArray.Append("Lookout");
	} else if (local.streetType == "loop" || local.streetType == "Loop") {
		local.typeArray.Append("loop");
		local.typeArray.Append("Loop");
	} else if (local.streetType == "lwr" || local.streetType == "Lower") {
		local.typeArray.Append("lwr");
		local.typeArray.Append("Lower");
	} else if (local.streetType == "mall" || local.streetType == "Mall") {
		local.typeArray.Append("mall");
		local.typeArray.Append("Mall");
	} else if (local.streetType == "mdw" || local.streetType == "Meadow") {
		local.typeArray.Append("mdw");
		local.typeArray.Append("Meadow");
	} else if (local.streetType == "mndr" || local.streetType == "Meander") {
		local.typeArray.Append("mndr");
		local.typeArray.Append("Meander");
	} else if (local.streetType == "mews" || local.streetType == "Mews") {
		local.typeArray.Append("mews");
		local.typeArray.Append("Mews");
	} else if (local.streetType == "mwy" || local.streetType == "Motorway") {
		local.typeArray.Append("mwy");
		local.typeArray.Append("Motorway");
	} else if (local.streetType == "mt" || local.streetType == "Mount") {
		local.typeArray.Append("mt");
		local.typeArray.Append("Mount");
	} else if (local.streetType == "mtn" || local.streetType == "Mountain") {
		local.typeArray.Append("mtn");
		local.typeArray.Append("Mountain");
	} else if (local.streetType == "otlk" || local.streetType == "Outlook") {
		local.typeArray.Append("otlk");
		local.typeArray.Append("Outlook");
	} else if (local.streetType == "opas" || local.streetType == "Overpass") {
		local.typeArray.Append("opas");
		local.typeArray.Append("Overpass");
	} else if (local.streetType == "pde" || local.streetType == "Parade") {
		local.typeArray.Append("pde");
		local.typeArray.Append("Parade");
	} else if (local.streetType == "park" || local.streetType == "pk" || local.streetType == "Park") {
		local.typeArray.Append("park");
		local.typeArray.Append("pk");
		local.typeArray.Append("Park");
	} else if (local.streetType == "pkld" || local.streetType == "Parklands") {
		local.typeArray.Append("pkld");
		local.typeArray.Append("Parklands");
	} else if (local.streetType == "pwy" || local.streetType == "pkwy" || local.streetType == "Parkway") {
		local.typeArray.Append("pwy");
		local.typeArray.Append("pkwy");
		local.typeArray.Append("Parkway");
	} else if (local.streetType == "psge" || local.streetType == "Passage") {
		local.typeArray.Append("psge");
		local.typeArray.Append("Passage");
	} else if (local.streetType == "path" || local.streetType == "Path") {
		local.typeArray.Append("path");
		local.typeArray.Append("Path");
	} else if (local.streetType == "piaz" || local.streetType == "Piazza") {
		local.typeArray.Append("piaz");
		local.typeArray.Append("Piazza");
	} else if (local.streetType == "pl" || local.streetType == "Place") {
		local.typeArray.Append("pl");
		local.typeArray.Append("Place");
	} else if (local.streetType == "pln" || local.streetType == "Plain") {
		local.typeArray.Append("pln");
		local.typeArray.Append("Plain");
	} else if (local.streetType == "plat" || local.streetType == "Plateau") {
		local.typeArray.Append("plat");
		local.typeArray.Append("Plateau");
	} else if (local.streetType == "plza" || local.streetType == "Plaza") {
		local.typeArray.Append("plza");
		local.typeArray.Append("Plaza");
	} else if (local.streetType == "pnt" || local.streetType == "Point") {
		local.typeArray.Append("pnt");
		local.typeArray.Append("Point");
	} else if (local.streetType == "prom" || local.streetType == "Promenade") {
		local.typeArray.Append("prom");
		local.typeArray.Append("Promenade");
	} else if (local.streetType == "qy" || local.streetType == "Quay") {
		local.typeArray.Append("qy");
		local.typeArray.Append("Quay");
	} else if (local.streetType == "qys" || local.streetType == "Quays") {
		local.typeArray.Append("qys");
		local.typeArray.Append("Quays");
	} else if (local.streetType == "rmbl" || local.streetType == "Ramble") {
		local.typeArray.Append("rmbl");
		local.typeArray.Append("Ramble");
	} else if (local.streetType == "ramp" || local.streetType == "Ramp") {
		local.typeArray.Append("ramp");
		local.typeArray.Append("Ramp");
	} else if (local.streetType == "rnge" || local.streetType == "Range") {
		local.typeArray.Append("rnge");
		local.typeArray.Append("Range");
	} else if (local.streetType == "rch" || local.streetType == "Reach") {
		local.typeArray.Append("rch");
		local.typeArray.Append("Reach");
	} else if (local.streetType == "res" || local.streetType == "Reserve") {
		local.typeArray.Append("res");
		local.typeArray.Append("Reserve");
	} else if (local.streetType == "rtt" || local.streetType == "Retreat") {
		local.typeArray.Append("rtt");
		local.typeArray.Append("Retreat");
	} else if (local.streetType == "rdge" || local.streetType == "Ridge") {
		local.typeArray.Append("rdge");
		local.typeArray.Append("Ridge");
	} else if (local.streetType == "rgwy" || local.streetType == "Ridgeway") {
		local.typeArray.Append("rgwy");
		local.typeArray.Append("Ridgeway");
	} else if (local.streetType == "rowy" || local.streetType == "Right Of Way") {
		local.typeArray.Append("rowy");
		local.typeArray.Append("Right Of Way");
	} else if (local.streetType == "rise" || local.streetType == "Rise") {
		local.typeArray.Append("rise");
		local.typeArray.Append("Rise");
	} else if (local.streetType == "rvr" || local.streetType == "River") {
		local.typeArray.Append("rvr");
		local.typeArray.Append("River");
	} else if (local.streetType == "rvwy" || local.streetType == "Riverway") {
		local.typeArray.Append("rvwy");
		local.typeArray.Append("Riverway");
	} else if (local.streetType == "rvra" || local.streetType == "Riviera") {
		local.typeArray.Append("rvra");
		local.typeArray.Append("Riviera");
	} else if (local.streetType == "rd" || local.streetType == "Road") {
		local.typeArray.Append("rd");
		local.typeArray.Append("Road");
	} else if (local.streetType == "rnde" || local.streetType == "Ronde") {
		local.typeArray.Append("rnde");
		local.typeArray.Append("Ronde");
	} else if (local.streetType == "rnd" || local.streetType == "Round") {
		local.typeArray.Append("rnd");
		local.typeArray.Append("Round");
	} else if (local.streetType == "rte" || local.streetType == "Route") {
		local.typeArray.Append("rte");
		local.typeArray.Append("Route");
	} else if (local.streetType == "swy" || local.streetType == "Service Way") {
		local.typeArray.Append("swy");
		local.typeArray.Append("Service Way");
	} else if (local.streetType == "sdng" || local.streetType == "Siding") {
		local.typeArray.Append("sdng");
		local.typeArray.Append("Siding");
	} else if (local.streetType == "slpe" || local.streetType == "Slope") {
		local.typeArray.Append("slpe");
		local.typeArray.Append("Slope");
	} else if (local.streetType == "snd" || local.streetType == "Sound") {
		local.typeArray.Append("snd");
		local.typeArray.Append("Sound");
	} else if (local.streetType == "sq" || local.streetType == "sqr" || local.streetType == "Square") {
		local.typeArray.Append("sq");
		local.typeArray.Append("sqr");
		local.typeArray.Append("Square");
	} else if (local.streetType == "strs" || local.streetType == "Stairs") {
		local.typeArray.Append("strs");
		local.typeArray.Append("Stairs");
	} else if (local.streetType == "sta" || local.streetType == "Station") {
		local.typeArray.Append("sta");
		local.typeArray.Append("Station");
	} else if (local.streetType == "sh" || local.streetType == "State Highway") {
		local.typeArray.Append("sh");
		local.typeArray.Append("State Highway");
	} else if (local.streetType == "stps" || local.streetType == "Steps") {
		local.typeArray.Append("stps");
		local.typeArray.Append("Steps");
	} else if (local.streetType == "stra" || local.streetType == "Strand") {
		local.typeArray.Append("stra");
		local.typeArray.Append("Strand");
	} else if (local.streetType == "st" || local.streetType == "Street") {
		local.typeArray.Append("st");
		local.typeArray.Append("Street");
	} else if (local.streetType == "sbwy" || local.streetType == "Subway") {
		local.typeArray.Append("sbwy");
		local.typeArray.Append("Subway");
	} else if (local.streetType == "smt" || local.streetType == "Summit") {
		local.typeArray.Append("smt");
		local.typeArray.Append("Summit");
	} else if (local.streetType == "tce" || local.streetType == "Terrace") {
		local.typeArray.Append("tce");
		local.typeArray.Append("Terrace");
	} else if (local.streetType == "thor" || local.streetType == "Thoroughfare") {
		local.typeArray.Append("thor");
		local.typeArray.Append("Thoroughfare");
	} else if (local.streetType == "thwy" || local.streetType == "Throughway") {
		local.typeArray.Append("thwy");
		local.typeArray.Append("Throughway");
	} else if (local.streetType == "tlwy" || local.streetType == "Tollway") {
		local.typeArray.Append("tlwy");
		local.typeArray.Append("Tollway");
	} else if (local.streetType == "twrs" || local.streetType == "Towers") {
		local.typeArray.Append("twrs");
		local.typeArray.Append("Towers");
	} else if (local.streetType == "trk" || local.streetType == "Track") {
		local.typeArray.Append("trk");
		local.typeArray.Append("Track");
	} else if (local.streetType == "trfy" || local.streetType == "Trafficway") {
		local.typeArray.Append("trfy");
		local.typeArray.Append("Trafficway");
	} else if (local.streetType == "trl" || local.streetType == "Trail") {
		local.typeArray.Append("trl");
		local.typeArray.Append("Trail");
	} else if (local.streetType == "trlr" || local.streetType == "Trailer") {
		local.typeArray.Append("trlr");
		local.typeArray.Append("Trailer");
	} else if (local.streetType == "tri" || local.streetType == "Triangle") {
		local.typeArray.Append("tri");
		local.typeArray.Append("Triangle");
	} else if (local.streetType == "tkwy" || local.streetType == "Trunkway") {
		local.typeArray.Append("tkwy");
		local.typeArray.Append("Trunkway");
	} else if (local.streetType == "tunl" || local.streetType == "Tunnel") {
		local.typeArray.Append("tunl");
		local.typeArray.Append("Tunnel");
	} else if (local.streetType == "tpk" || local.streetType == "Turnpike") {
		local.typeArray.Append("tpk");
		local.typeArray.Append("Turnpike");
	} else if (local.streetType == "upas" || local.streetType == "Underpass") {
		local.typeArray.Append("upas");
		local.typeArray.Append("Underpass");
	} else if (local.streetType == "upr" || local.streetType == "Upper") {
		local.typeArray.Append("upr");
		local.typeArray.Append("Upper");
	} else if (local.streetType == "vly" || local.streetType == "Valley") {
		local.typeArray.Append("vly");
		local.typeArray.Append("Valley");
	} else if (local.streetType == "vdct" || local.streetType == "Viaduct") {
		local.typeArray.Append("vdct");
		local.typeArray.Append("Viaduct");
	} else if (local.streetType == "view" || local.streetType == "View") {
		local.typeArray.Append("view");
		local.typeArray.Append("View");
	} else if (local.streetType == "vll" || local.streetType == "Villa") {
		local.typeArray.Append("vll");
		local.typeArray.Append("Villa");
	} else if (local.streetType == "vlg" || local.streetType == "Village") {
		local.typeArray.Append("vlg");
		local.typeArray.Append("Village");
	} else if (local.streetType == "vlls" || local.streetType == "Villas") {
		local.typeArray.Append("vlls");
		local.typeArray.Append("Villas");
	} else if (local.streetType == "vsta" || local.streetType == "Vista") {
		local.typeArray.Append("vsta");
		local.typeArray.Append("Vista");
	} else if (local.streetType == "walk" || local.streetType == "Walk") {
		local.typeArray.Append("walk");
		local.typeArray.Append("Walk");
	} else if (local.streetType == "wkwy" || local.streetType == "Walkway") {
		local.typeArray.Append("wkwy");
		local.typeArray.Append("Walkway");
	} else if (local.streetType == "wtr" || local.streetType == "Water") {
		local.typeArray.Append("wtr");
		local.typeArray.Append("Water");
	} else if (local.streetType == "way" || local.streetType == "Way") {
		local.typeArray.Append("way");
		local.typeArray.Append("Way");
	} else if (local.streetType == "whrf" || local.streetType == "Wharf") {
		local.typeArray.Append("whrf");
		local.typeArray.Append("Wharf");
	} else {
		local.typeArray.Append(local.streetType);
	}
	return local.typeArray;
}

function getAddressParts(required string address, string state = "") {
	var loc = {
		address = "",
		streetSuburb = "",
		separatedStreetNameAndSuburb = "",
		state = "",
		postcode = "",
		returnValue = {
			subNumber = "",
			streetNumber = "",
			streetName = "",
			suburb = "",
			postcode = "",
			state = ""
		}
	};

	/* Look for STATE accronym or POSTCODE --- NOT after 4th place! */
	local.addressArr = listToArray(arguments.address, " ");
	local.newAddressStr = addressArr[1];

	loop from="2" to="#len(local.addressArr)#" index="local.i" {
		local.addressPartStr = local.addressArr[local.i];

		if (listFindNoCase("NSW,SA,WA,ACT,NT,VIC,QLD,TAS", local.addressPartStr)) {
			loc.state = uCase(local.addressPartStr);
			continue;
		}

		if (val(local.addressPartStr)) {
			loc.postcode = val(local.addressPartStr);
			continue;
		}

		local.newAddressStr = local.newAddressStr & " " & local.addressPartStr;
	}

	/* New address string EXCLUDING state accronym */
	loc.address = local.newAddressStr;



	loc.delims = ", ";
	// check the address length
	loc.parts = listToArray(loc.address, loc.delims);
	loc.partsLength = arrayLen(loc.parts);

	// loop thru and extract state and postcode
	loc.streetSuburb = loc.address;

	// start at 4 so i dont confuse a large street number with a postcode, or a street name with a state.. Eg: Victoria Street
	loop from="4" to="#loc.partsLength#" index="loc.i" {
		loc.str = loc.parts[loc.i];
		if (isState(loc.str)) {
			loc.streetSuburb = listDeleteValue(loc.streetSuburb, loc.str, " ");
		}
		if (isPostcode(loc.str)) {
			loc.streetSuburb = listDeleteValue(loc.streetSuburb, loc.str, " ");
		}
	}

	/* Default to passed state */
	if (!len(loc.state)) loc.state = arguments.state;

	loc.separatedStreetNameAndSuburb = separateStreetNameFromSuburb(loc.streetSuburb);

	// build the return value
	loc.returnValue = parseStreetAddress(loc.separatedStreetNameAndSuburb.street);
	loc.returnValue.suburb = trim(loc.separatedStreetNameAndSuburb.suburb);
	loc.returnValue.postcode = loc.postcode;
	loc.returnValue.state = loc.state;

	// writeDump(loc.returnValue); abort;

	return loc.returnValue;
}
</cfscript>

<!--- TODO: scriptify this --->
<cffunction
	name="parseStreetAddress"
	access="public"
	hint="Returns a street address in pieces according to localities table"
>
	<cfargument name="string" type="string" required="true">
	<!---
		** Address formats parsed **
		----------------------------
		546 Collins Street
		301/546 Collins Street
		301-546 Collins Street
		Suite 301, 546 Collins Street
		Suite 301 546 Collins Street
		1 St Kilda Road
		Suite 301, 1 St Kilda Road
	--->
	<cfset var loc = {}>
	<cfset local.return = {subnumber = ""}>
	<cfset local.string = arguments.string>
	<cfset local.streetNumberDelims = "/\, ">
	<!--- check the string length --->
	<cfset local.parts = listToArray(local.string, " ")>
	<cfset local.len = arrayLen(local.parts)>

	<!--- build a reversed list --->
	<cfset local.posList = "">
	<cfloop from="1" to="#local.len#" index="local.i">
		<cfset local.posList = listPrepend(local.posList, local.i)>
	</cfloop>

	<!--- start from the end, once i hit a string containing a number, the street name has finished --->
	<cfset local.return.streetname = "">
	<cfset local.notStreetName = "">
	<cfset local.lastPart = 0>
	<cfloop list="#local.posList#" index="local.i">
		<cfif reFind("[0-9]", local.parts[local.i]) eq 0>
			<cfset local.return.streetname = listPrepend(local.return.streetname, local.parts[local.i], " ")>
			<cfset local.lastPart = local.i>
        <cfelse>
			<cfbreak>
		</cfif>
	</cfloop>
	<!--- loop thru the remaining parts --->
	<cfloop list="#local.posList#" index="local.i">
		<cfif local.i lt local.lastPart>
			<cfset local.notStreetName = listPrepend(local.notStreetName, local.parts[local.i], " ")>
		</cfif>
	</cfloop>
	<!--- see if there's a subnumber in here --->
	<cfset local.subArray = listToArray(local.notStreetName, local.streetNumberDelims)>

	<cfif arrayLen(local.subArray)>
		<cfset local.return.streetnumber = arrayLast(local.subArray)>
    <cfelse>
		<cfset local.return.streetnumber = "">
	</cfif>

	<cfif arrayLen(local.subArray) gt 1>
		<cfset local.removeLast = listDeleteAt(
			local.notStreetName,
			listLen(local.notStreetName, local.streetNumberDelims),
			local.streetNumberDelims
		)>
		<cfset local.return.subnumber = local.removeLast>
	</cfif>

	<!--- cater for PO BOX i.e. PO BOX 1234 --->
	<cfif !len(local.return.streetname) AND findNoCase("PO BOX", arguments.string)>
		<cfset local.return.streetname = arguments.string>
	</cfif>

	<!--- ensure street type is not abbreviated --->
	<cfset local.streetType = listLast(local.return.streetname, " ")>
	<cfset local.fullStreetType = parseStreetType(local.streetType)>
	<cfif local.streetType != local.fullStreetType>
		<cfset local.return.streetname = replaceNoCase(
			local.return.streetname,
			" #local.streetType#",
			" #local.fullStreetType#",
			"all"
		)>
	</cfif>

	<cfreturn local.return>
</cffunction>
