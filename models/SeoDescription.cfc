component extends="Model" output="false" {

	public function config() {
		super.config();
		belongsTo("Region");
		belongsTo("Suburb");
	}



	/**
	 * Returns a row of the SEO description
	 *
	 * [section: Application]
	 * [category: models.SeoDescription]
	 *
	 */
	public query function getSeoDescription(
			required string state,
			required string saleMethod,
			required string propertyType,
			numeric regionId,
			numeric suburbId
		) {

		local.ret.seoDesription = QueryNew("id");
		if (Val(arguments.suburbId)) {
			local.suburbWhere = [
				"suburbId = #arguments.suburbId#",
				"saleMethod = '#arguments.saleMethod#' OR saleMethod IS NULL",
				"propertyType = '#arguments.propertyType#' OR propertyType IS NULL"
			];
			local.ret.seoDesription = model("SeoDescription").findAll(
				where = whereify(local.suburbWhere),
				order = "saleMethod DESC, propertyType DESC",
				maxRows = 1
			)
		}
		if (!local.ret.seoDesription.recordCount && Val(arguments.regionId)) {
			local.regionWhere = [
				"regionId = #arguments.regionId#",
				"saleMethod = '#arguments.saleMethod#' OR saleMethod IS NULL",
				"propertyType = '#arguments.propertyType#' OR propertyType IS NULL"
			];
			local.ret.seoDesription = model("SeoDescription").findAll(
				where = whereify(local.regionWhere),
				order = "saleMethod DESC, propertyType DESC",
				maxRows = 1
			)
		}
		if (!local.ret.seoDesription.recordCount) {
			local.regionWhere = [
				"state = '#arguments.state#'",
				"saleMethod = '#arguments.saleMethod#' OR saleMethod IS NULL",
				"propertyType = '#arguments.propertyType#' OR propertyType IS NULL"
			];
			local.ret.seoDesription = model("SeoDescription").findAll(
				where = whereify(local.regionWhere),
				order = "saleMethod DESC, propertyType DESC",
				maxRows = 1
			)
		}
		return local.ret.seoDesription;
	}


}

