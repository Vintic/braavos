component {

	public struct function open(
		required string server,
		required string username,
		required string password,
		string port = 21,
		boolean passive = true,
		string proxyserver = "",
		string timeout = 30,
		string connection = "ftp_conn",
		string result = "result"
	) {
		try {
			cfftp(
				server=arguments.server
				proxyserver=arguments.proxyserver
				password=arguments.password
				port=arguments.port
				timeout=arguments.timeout
				action="OPEN"
				connection=arguments.connection
				secure=arguments.port == 22
				stoponerror=true
				result="local.result"
				username=arguments.username
				passive=arguments.passive
			);
			local.returnValue[arguments.result] = local.result;
			local.returnValue.success = local.result.succeeded;
		} catch (Any e) {
			local.returnValue.error = "#e.message# : #e.detail#";
			local.returnValue.success = false;
			local.returnValue.args = arguments;
		}
		return local.returnValue;
	}

	public struct function cd(
		required string directory,
		numeric timeout = 30,
		string connection = "ftp_conn",
		string result = "result"
	) {
		try {
			cfftp(
				directory=arguments.directory
				timeout=arguments.timeout
				action="CHANGEDIR"
				connection=arguments.connection
				stoponerror=true
				result="local.result"
			);
			local.returnValue[arguments.result] = local.result;
			local.returnValue.success = local.result.succeeded;
		} catch (Any e) {
			local.returnValue.error = "#e.message# : #e.detail#";
			local.returnValue.success = false;
			local.returnValue.args = arguments;
		}
		return local.returnValue;
	}

	public struct function list(
		string directory = "./",
		numeric timeout = 30,
		boolean passive = true,
		string connection = "ftp_conn",
		string result = "result"
	) {
		try {
			cfftp(
				directory=arguments.directory
				name="local.listDir"
				action="listdir"
				connection=arguments.connection
				result="local.result"
				passive=arguments.passive
			);
			local.returnValue[arguments.result] = local.result;
			local.returnValue.success = local.result.succeeded;
			local.returnValue.query = local.listDir;
		} catch (Any e) {
			local.returnValue.error = "#e.message# : #e.detail#";
			local.returnValue.success = false;
			local.returnValue.args = arguments;
		}
		return local.returnValue;
	}

	public struct function get(
		required string localfile,
		required string remotefile,
		numeric timeout = 600,
		boolean passive = true,
		string connection = "ftp_conn",
		string result = "result"
	) {
		try {
			cfftp(
				remotefile=arguments.remotefile
				failifexists=false
				localfile=arguments.localfile
				timeout=arguments.timeout
				action="GETFILE"
				connection=arguments.connection
				stoponerror=true
				result="local.result"
				passive=arguments.passive
			);
			local.returnValue[arguments.result] = local.result;
			local.returnValue.success = local.result.succeeded;
		} catch (Any e) {
			local.returnValue.error = "#e.message# : #e.detail#";
			local.returnValue.success = false;
			local.returnValue.args = arguments;
		}
		return local.returnValue;
	}

	public struct function put(
		required string localfile,
		string remotedirectory = "",
		string remotefile = "#arguments.remotedirectory##getFileFromPath(arguments.localfile)#",
		string transfermode = "auto",
		numeric retrycount = 2,
		numeric timeout = 600,
		string passive = true,
		string connection = "ftp_conn",
		string result = "result"
	) {
		try {
			cfftp(
				remotefile="#arguments.remotedirectory##arguments.remotefile#"
				retrycount=arguments.retrycount
				localfile=arguments.localfile
				transfermode=arguments.transfermode
				timeout=arguments.timeout
				action="PUTFILE"
				result="local.result"
				stoponerror=true
				connection=arguments.connection
				passive=arguments.passive
			);
			local.returnValue[arguments.result] = local.result;
			local.returnValue.success = local.result.succeeded;
		} catch (Any e) {
			local.returnValue.error = "#e.message# : #e.detail#";
			local.returnValue.success = false;
			local.returnValue.args = arguments;
		}
		return local.returnValue;
	}

	public struct function remove(
		required string item,
		numeric timeout = 600,
		boolean passive = true,
		string connection = "ftp_conn",
		string result = "result"
	) {
		try {
			cfftp(
				item=arguments.item
				timeout=arguments.timeout
				action="remove"
				connection=arguments.connection
				stoponerror=true
				result="local.result"
				passive=arguments.passive
			);
			local.returnValue[arguments.result] = local.result;
			local.returnValue.success = local.result.succeeded;
		} catch (Any e) {
			local.returnValue.error = "#e.message# : #e.detail#";
			local.returnValue.success = false;
			local.returnValue.args = arguments;
		}
		return local.returnValue;
	}

	public struct function close(string connection = "ftp_conn", string result = "result") {
		try {
			cfftp(action="CLOSE" connection=arguments.connection stoponerror=true result="local.result");
			local.returnValue[arguments.result] = local.result;
			local.returnValue.success = local.result.succeeded;
		} catch (Any e) {
			local.returnValue.error = "#e.message# : #e.detail#";
			local.returnValue.success = false;
			local.returnValue.args = arguments;
		}
		return local.returnValue;
	}

}
