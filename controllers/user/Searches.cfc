component extends="app.controllers.user.Controller" {

	function config() {
		super.config();
		filters(through = "getCriteria", only = "edit,update,delete");
	}


	/**
	 * FILTERS
	 */

	private any function getCriteria() {
		criteria = model("Criteria").findByKey(params.key);
		if (!IsObject(criteria)) {
			redirectTo(route = "searches", error = "That record wasn't found");
		}
	}


	/**
	 * PARTIAL DATA
	 */

	private struct function fields() {

		return {};
	}


	/**
	 * CRUD
	 */

	public void function index() {
		local.where = ["contactid = #currentUser.id#"];
		criteria = model("Criteria").findAll(
			select = "
				id,contactId,saleMethod,listingCategory,state,priceFrom,priceTo,bedrooms,bathrooms,carSpaces,sendFrequency,createdAt
			",
			where = whereify(local.where),
			order = "saleMethod DESC, listingCategory DESC, id DESC"
		);.
		if (criteria.recordCount) {
			local.criteriaIdList = listEnsure(sanitiseList(ListRemoveDuplicates(ValueList(criteria.id))));
			local.criteriaPropertyTypes = model("CriteriaPropertyType").findAll(
				select = "criteriaId, propertyType",
				where = splitQueryParamList(column = "criteriaId", list = local.criteriaIdList)
			)
			local.criteriaRegions = model("CriteriaRegion").findAll(
				select = "criteriaId, regionId, regionName",
				include = "Region",
				where = splitQueryParamList(column = "criteriaId", list = local.criteriaIdList)
			)
			local.criteriaSuburbs = model("CriteriaSuburb").findAll(
				select = "criteriaId, suburbId, suburbName",
				include = "Suburb",
				where = splitQueryParamList(column = "criteriaId", list = local.criteriaIdList)
			)
			local.regionArray = [];
			local.suburbArray = [];
			local.propertyTypeArray = [];
			for (local.criteriaRow in criteria) {
				local.thisCriteriaPropertyTypes = local.criteriaPropertyTypes.filter(function(i) {
					return arguments.i.criteriaId == criteriaRow.id;
				});
				local.propertyTypeArray.append(local.thisCriteriaPropertyTypes);

				local.thisCriteriaRegions = local.criteriaRegions.filter(function(i) {
					return arguments.i.criteriaId == criteriaRow.id;
				});
				local.regionArray.append(local.thisCriteriaRegions);

				local.thisCriteriaSuburbs = local.criteriaSuburbs.filter(function(i) {
					return arguments.i.criteriaId == criteriaRow.id;
				});
				local.suburbArray.append(local.thisCriteriaSuburbs);
			}
			QueryAddColumn(criteria, "propertyTypeQuery", local.propertyTypeArray)
			QueryAddColumn(criteria, "regionQuery", local.regionArray)
			QueryAddColumn(criteria, "suburbQuery", local.suburbArray)
		}
	}

	public any function new() {
	}

	public any function delete() {
		if (criteria.delete()) {
			flashInsert(message = "Criteria has been removed.", messageType = "success");
		} else {
			flashInsert(message = "There was a problem removing the criteria.", messageType = "error");
		}
		return redirectTo(route = "searches");
	}

}
