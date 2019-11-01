component output="false" {

	this.baseUrl = "https://api.rollbar.com/api/1";
	this.token = "5e0f5d6e29d34e5d961a9f2a1bbd6a92"; // westeros

	public component function init() {
		return this;
	}

	public string function processException(
		required struct exception,
		required string environment,
		required any userContext,
		) {

		local.exception = Duplicate(arguments.exception);
		local.httpData = getHTTPRequestData();

		local.serverRoot = "/var/lib/tomcat8/webapps/ROOT/";
		if(arguments.environment == "Development") {
			local.serverRoot = "/var/www/zenu/";
		}

		local.rollbarPayload = {
			"title": local.exception.Message,
			"environment": arguments.environment,
			"level": "error",
			"context": _getContext(),
			"language": "coldfusion",
			"framework": "cfwheels",
			"request": {
				"url": "#cgi.server_name##cgi.path_info#",
				"method": cgi.request_method,
				"user_ip": cgi.remote_addr,
				"query_string": cgi.query_string,
				"params": _cleanCredentials(request.wheels.params ?: ""),
				"headers": local.httpData.headers,
				"body": _cleanCredentials(local.httpData.content)
			},
			"server": {
				"root": local.serverRoot
			},
			"body": {
				"trace": {
					"frames": _getFrames(local.exception),
					"exception": {
						"class": local.exception.type,
						"message": local.exception.Message
					}
				}
			},
			"custom": {
				"Stacktrace": local.exception.Stacktrace,
				"BuildNumber": application.buildNumber
			}
		};

		if(isStruct(arguments.userContext)) {
			// if not logged in, this will be boolean false
			local.rollbarPayload["person"] = {
				"id": arguments.userContext.id,
				"username": arguments.userContext.firstName & " " & arguments.userContext.lastName,
				"email": arguments.userContext.email
			};

			// local.rollbarPayload["office"] = {
			// 	"id": arguments.userContext.office_id,
			// 	"name": arguments.userContext.office.office_name
			// };
		}

		return _sendToRollbar(rollbarPayload);
	}

	private string function _sendToRollbar(required struct payload){
		local.httpRequest = new http(
			method = "POST",
			url = "#this.baseUrl#/item/",
			timeout = 5,
			throwonerror = false
		);
		local.bodyObj = {
			"access_token": this.token,
			"data": arguments.payload
		};
		local.httpRequest.addParam(type="header", name="content-type", value="application/json");
		local.httpRequest.addParam(type="body", value=serializeJSON(local.bodyObj));

		local.httpResult = local.httpRequest.send().getPrefix();

		if(isJSON(local.httpResult.filecontent)){
			local.json = deserializeJSON(local.httpResult.filecontent);
			return local.json.result.uuid;
		}

		return "";
	}

	private string function _getContext() {
		if(StructKeyExists(request.wheels.params, "controller") && StructKeyExists(request.wheels.params, "action")) {
			return "#request.wheels.params.controller####request.wheels.params.action#";
		}
		return "";
	}

	private array function _getFrames(required struct exception) {
		var returnArr = [];
		if(StructKeyExists(arguments.exception, "TagContext")){
			for(var item in arguments.exception.TagContext){
				var oneItem = {};
				oneItem["filename"] = item.template;
				oneItem["lineno"] = item.line;
				//oneItem["colno"] = item.column;
				//oneItem["code"] = item.codePrintPlain;
				arrayAppend(returnArr, oneItem);
			}
		}
		return returnArr;
	}

	private any function _cleanCredentials(required any item){
		if (isStruct(arguments.item)) {
			if(arguments.item.keyExists("password"))
				arguments.item["password"] = "__redacted__";
			if(arguments.item.keyExists("passwordConfirmation"))
				arguments.item["passwordConfirmation"] = "__redacted__";
			if(arguments.item.keyExists("passwordConfirm"))
				arguments.item["passwordConfirm"] = "__redacted__";
		} else if(isSimpleValue(arguments.item)) {
			arguments.item = ReReplaceNoCase(arguments.item, "(password.*?=)([^&]*)", "\1__redacted__", "all");
		}
		return arguments.item;
	}

}
