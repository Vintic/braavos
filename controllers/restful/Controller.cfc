component extends="app.controllers.controller" output=false {

	public void function config() {
		super.config();
		protectsFromForgery();
		// filters("$$forceHTTPS,$$setup");
	}

	/**
	 * FILTERS
	 */

	private void function $$setup() {
		super.$$setupJSONResponse();
	}

	private void function $$authoriseRequest() {
		if (StructKeyExists(request, "authorization") && Left(request.authorization, 5) == "Token") {
			// local.token = ListLast(request.authorization, " ");
			// local.staff = model("Staff").findOne(
			// select="id",
			// include="Office",
			// where="remember_token = '#local.token#' AND status = 'current' AND office_status NOT IN ('removed', 'suspend')",
			// returnAs="query"
			// );
			// if (local.staff.recordCount != 1) {
			// statusCode = 403;
			// errorTitle = "Incorrect input.";
			// errorDetail = "The token was not correct.";
			// return renderWith(data="", template="/restful/error", status=statusCode);
			// }
			// currentUser = model("Staff").getUser(local.staff.id);
		} else {
			statusCode = 403;
			errorTitle = "Missing input.";
			errorDetail = "The 'Authorization' header must be sent.";
			return renderWith(data = "", template = "/restful/error", status = statusCode);
		}
	}

	/**
	 * BASE ACTIONS
	 */

	/**
	 * Create resource (e.g. POST /users).
	 */
	function create(required string modelName) {
		fields = model(arguments.modelName).restFields;
		resource = model(arguments.modelName).new(getAttributes(arguments.modelName));
		if (resource.save()) {
			statusCode = 201;
			renderWith(data = resource, template = "show", status = statusCode);
		} else {
			statusCode = 500;
			errorTitle = "Create failed.";
			errorDetail = resource.allErrors()[1].message;
			renderWith(data = resource, template = "/shared/errors", status = statusCode);
		}
	}

	/**
	 *Update resource (e.g. PATCH /users/1).
	 */
	function update(required string modelName) {
		fields = model(arguments.modelName).restFields;
		resource = model(arguments.modelName).findByKey(params.key);
		if (IsObject(resource)) {
			if (resource.update(getAttributes(arguments.modelName))) {
				cfheader(statusCode=204, statusText="No Content");
				renderNothing();
			} else {
				statusCode = 500;
				errorTitle = "Update failed.";
				errorDetail = resource.allErrors()[1].message;
				renderWith(data = resource, template = "/shared/errors", status = statusCode);
			}
		} else {
			cfheader(statusCode=404, statusText="Not Found");
			renderNothing();
		}
	}

	/**
	 * List resources (e.g. GET /users).
	 */
	function index(required string modelName) {
		fields = model(arguments.modelName).restFields;
		if (!StructKeyExists(params, "sort")) {
			params.sort = "id";
		}
		local.select = this.fields(modelName = arguments.modelName, restFields = fields);
		local.order = this.sort(restFields = fields);
		local.where = this.filter(restFields = fields);
		local.args = {
			order = local.order,
			select = local.select,
			where = local.where,
			returnAs = "structs"
		};

		// Paginate if the resource is set to that in the model (large resources like comments, topics are set to this).
		// Default to page 1 with 10 records per page but override if set in URL (e.g. "?page[number]=5&page[size]=100").
		if (model(arguments.modelName).paginated) {
			if (!StructKeyExists(params, "page") || !StructKeyExists(params.page, "number")) {
				params.page.number = 1;
			}
			if (!StructKeyExists(params, "page") || !StructKeyExists(params.page, "size")) {
				params.page.size = 10;
			}
			local.args.page = params.page.number;
			local.args.perPage = params.page.size;
		}

		resources = model(arguments.modelName).findAll(argumentCollection = local.args);

		renderWith(resources);
	}

	/**
	 * Show specific resource (e.g. GET /user/1).
	 */
	function show(required string modelName) {
		fields = model(arguments.modelName).restFields;
		local.select = this.fields(restFields = fields);
		resource = model(arguments.modelName).findByKey(key = params.key, select = local.select);
		if (IsObject(resource)) {
			renderWith(resource);
		} else {
			cfheader(statusCode=404, statusText="Not Found");
			renderNothing();
		}
	}

	/**
	 * Return a select string (e.g. "views, id") based on the passed in parameter (e.g. "?fields[countries]=views,id").
	 * Make sure that only allowed fields are included so you can't select columns in the database that we don't allow.
	 */
	function fields(string modelName, struct restFields) {
		if (
			StructKeyExists(params, "fields") && IsStruct(params.fields) && StructKeyExists(
				params.fields,
				arguments.modelName
			)
		) {
			local.fields = params.fields[arguments.modelName];
			local.rv = "";
			for (local.field in local.fields) {
				if (StructKeyExists(arguments.restFields, local.field)) {
					local.rv = ListAppend(local.rv, arguments.restFields[local.field]);
				}
			}
		} else {
			local.rv = "";
			for (local.key in arguments.restFields) {
				local.rv = ListAppend(local.rv, arguments.restFields[local.key]);
			}
		}
		return local.rv;
	}

	/**
	 * Return an order by string (e.g. "views DESC, id ASC") based on the passed in parameter (e.g. "?sort=-views,id").
	 * Make sure that only allowed fields are included so you can't order by columns in the database that we don't allow.
	 */
	function sort(struct restFields) {
		local.sort = StructKeyExists(params, "sort") ? params.sort : "id";
		local.sortFields = ListToArray(local.sort);
		local.rv = "";
		for (local.sortField in local.sortFields) {
			local.field = local.sortField;
			local.order = "ASC";
			if (Left(local.field, 1) == "-") {
				local.field = Right(local.field, Len(local.field) - 1);
				local.order = "DESC";
			}
			if (StructKeyExists(arguments.restFields, local.field)) {
				local.orderField = arguments.restFields[local.field] & " " & local.order;
				local.rv = ListAppend(local.rv, local.orderField);
			}
		}
		return local.rv;
	}

	/**
	 * Return a where string (e.g. "category_id = 3") based on the passed in parameter (e.g. "?filter[category_id]=3").
	 * Make sure that only allowed fields are included so you can't order by columns in the database that we don't allow.
	 * Mutliple parameters : "?filter[category_id]=3&filter[q]=foo%"
	 */
	function filter(struct restFields) {
		local.filter = StructKeyExists(params, "filter") ? params.filter : "";
		local.rv = [];
		for (local.key in local.filter) {
			if (StructKeyExists(arguments.restFields, local.key)) {
				local.property = arguments.restFields[local.key];
				// TODO: gt, lt, date ranges?
				local.value = local.filter[local.key];
				if (ReFindNoCase("^([><=]+|BETWEEN|LIKE|IS|IN) ", local.value)) {
					ArrayAppend(local.rv, "#local.property# #local.value#");
				} else {
					local.operator = Find("%", local.value) ? "LIKE" : "=";
					ArrayAppend(local.rv, "#local.property# #local.operator# '#local.value#'");
				}
			} else if (ListLen(local.key) GT 1) {
				local.orArray = [];
				for (local.orKey in local.key) {
					if (StructKeyExists(arguments.restFields, local.orKey)) {
						local.orProperty = arguments.restFields[local.orKey];
						local.orValue = local.filter[local.key];
						if (ReFindNoCase("^([><=]+|BETWEEN|LIKE|IS|IN) ", local.orValue)) {
							ArrayAppend(local.orArray, "#local.orProperty# #sanitiseFilter(local.orValue)#");
						} else {
							local.orOperator = Find("%", local.orValue) ? "LIKE" : "=";
							ArrayAppend(local.orArray, "#local.orProperty# #local.orOperator# '#sanitiseFilter(local.orValue)#'");
						}
					}
				}

				ArrayAppend(local.rv, "(#whereify(local.orArray, "OR")#)");
			}
		}
		return whereify(local.rv);
	}

	/**
	 * Gets the POSTed attributes from the JSON body.
	 * Map the names of them to the database column names.
	 */
	function getAttributes(string name) {
		local.attributes = params.data.attributes;
		local.rv = {};
		local.fields = model(arguments.name).fields;
		for (local.field in local.fields) {
			if (StructKeyExists(local.attributes, local.field)) {
				local.rv[local.fields[local.field]] = local.attributes[local.field];
			}
		}
		return local.rv;
	}

	public any function $formatArray(required array data, required function fn, boolean expand = false) {
		newRelicTickCount("formatArray-start");
		var rsp = [];
		for (var i in arguments.data) {
			ArrayAppend(rsp, fn(i));
		}
		if (arguments.expand) {
			if (ArrayLen(rsp)) {
				return rsp[1];
			} else {
				return {};
			}
		}
		newRelicTickCount("formatArray-end");
		return rsp;
	}

	public any function $formatQuery(required query data, required function fn, boolean expand = false) {
		newRelicTickCount("formatQuery-start");
		var rsp = [];
		for (var i in arguments.data) {
			ArrayAppend(rsp, fn(i));
		}
		if (arguments.expand) {
			if (ArrayLen(rsp)) {
				return rsp[1];
			} else {
				return {};
			}
		}
		newRelicTickCount("formatQuery-end");
		return rsp;
	}

	public string function sanitiseFilter(required string string) {
		// only allow alphanumeric and _'s
		return ReReplaceNoCase(
			arguments.string,
			"[^a-zA-Z0-9_]",
			"",
			"ALL"
		);
	}

}
