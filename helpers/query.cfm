<!--- DEPRECATED.. use lucee inbuilt QueryRowData function --->
<cffunction
	name="queryRowToStruct"
	returntype="struct"
	output="false"
	hint="I take a query and a row number and convert it to a struct"
>
	<cfargument name="query" type="query" required="true">
	<cfargument name="row" type="numeric" default="1">
	<cfreturn queryRowData(arguments.query, arguments.row)>
</cffunction>

<!--- DO NOT USE - performance issue
<cffunction name="queryOfQuery" output="false">
	<cfargument name="query" type="any" hint="can be passed in as the query name OR the query object itself">
	<cfargument name="where" type="string" default="">
	<cfargument name="select" type="string" default="*">
	<cfargument name="order" type="string" default="">
	<cfargument name="distinct" type="boolean" default="false">
	<cfargument name="maxrows" type="numeric" default="-1" hint="seems to return all..">
	<cfargument name="group" type="string" default="">

	<cfset var loc = {}>

	<cfif isQuery(arguments.query)>
		<cfif !arguments.query.recordCount>
			<cfreturn arguments.query/>
		</cfif>
		<cfset var qry = arguments.query>
		<cfset var qryName = "query">
    <cfelse>
		<cfset var qry = arguments.query>
		<cfset var qryName = arguments.query>
	</cfif>
	<cfquery dbtype="query" name="loc.return" maxrows="#arguments.maxrows#">
	SELECT <cfif arguments.distinct>DISTINCT</cfif>
	 #arguments.select# FROM #qryName#
		<cfif len(arguments.where)>WHERE #preserveSingleQuotes(replace(arguments.where, """", "'", "ALL"))#</cfif>
		<cfif len(arguments.group)>GROUP BY #arguments.group#</cfif>
		<cfif len(arguments.order)>ORDER BY #arguments.order#</cfif>
	</cfquery>

	<cfreturn loc.return>
</cffunction> --->

<cffunction name="queryMerge" returntype="query" output="false">
	<cfargument name="q1" type="query" required="true">
	<cfargument name="q2" type="query" required="true">
	<cfscript>
	var row = "";
	var col = "";
	var query1 = duplicate(arguments.q1);
	var query2 = duplicate(arguments.q2);

	if (query1.columnList NEQ query2.columnList) {
		return query1;
	}

	for (row = 1; row LTE query2.recordCount; row = row + 1) {
		queryAddRow(query1);
		for (col = 1; col LTE listLen(query1.columnList); col = col + 1) {
			querySetCell(query1, listGetAt(query1.columnList, col), query2[listGetAt(query1.columnList, col)][row]);
		}
	}
	return query1;
	</cfscript>
</cffunction>

<cffunction name="csvToQuery" access="public" output="No" returntype="query">
	<cfargument name="file" type="string" required="true">
	<cfargument name="delimiter" type="string" required="false" default=",">
	<cfscript>
	var loc = {}
	loc.fileReader = createObject("java", "java.io.FileReader")
	loc.fileReader.init(arguments.file)
	loc.CSVReader = createObject("java", "com.opencsv.CSVReader");
	loc.CSVReader.init(loc.fileReader, arguments.delimiter);
	loc.ArrData = loc.CSVReader.readAll();
	loc.CSVReader.close();
	loc.fileReader.close();

	loc.rv = queryNew(arrayToList(loc.ArrData[1]));
	loc.Rows = arrayLen(loc.ArrData);
	loc.Fields = arrayLen(loc.ArrData[1]);

	for (loc.thisRow = 2; loc.thisRow lte loc.Rows; loc.thisRow = loc.thisRow + 1) {
		queryAddRow(loc.rv);
		for (loc.thisField = 1; loc.thisField lte loc.Fields; loc.thisField = loc.thisField + 1) {
			querySetCell(loc.rv, loc.ArrData[1][loc.thisfield], loc.ArrData[loc.thisRow][loc.thisfield]);
		}
	}
	</cfscript>
	<cfreturn loc.rv>
</cffunction>

<cffunction
	name="queryToCSV"
	access="public"
	returntype="string"
	output="false"
	hint="I take a query and convert it to a comma separated value string."
>
	<!--- Define arguments. --->
	<cfargument name="Query" type="query" required="true" hint="I am the query being converted to CSV."/>

	<cfargument
		name="Fields"
		type="string"
		required="false"
		default="#arguments.Query.columnList#"
		hint="I am the list of query fields to be used when creating the CSV value."
	/>

	<cfargument
		name="CreateHeaderRow"
		type="boolean"
		required="false"
		default="true"
		hint="I flag whether or not to create a row of header values."
	/>

	<cfargument
		name="HeaderList"
		type="string"
		required="false"
		default=""
		hint="I am the header list, if this field is passed, will use this as the header rather than from the query."
	/>

	<cfargument
		name="ConvertHeaderListUCase"
		type="boolean"
		required="false"
		default="true"
		hint="If set to true, all header will be converted to upper case."
	/>

	<cfargument
		name="Delimiter"
		type="string"
		required="false"
		default=","
		hint="I am the field delimiter in the CSV value."
	/>
	<!--- Define the local scope. --->
	<cfset var local = {}/>

	<!---
		First, we want to set up a column index so that we can
		iterate over the column names faster than if we used a
		standard list loop on the passed-in list.
	--->
	<cfset local.ColumnNames = []/>

	<!---
		Loop over column names and index them numerically. We
		are going to be treating this struct almost as if it
		were an array. The reason we are doing this is that
		look-up times on a table are a bit faster than look
		up times on an array (or so I have been told).
	--->
	<cfif !arguments.ConvertHeaderListUCase>
		<cfset local.headerFields = arguments.Query.getColumnList(false)>
    <cfelse>
		<cfset local.headerFields = arguments.Fields>
	</cfif>

	<cfloop index="local.ColumnName" list="#local.headerFields#" delimiters=",">
		<!--- Store the current column name. --->
		<cfset arrayAppend(local.ColumnNames, trim(local.ColumnName))/>
	</cfloop>

	<!--- Store the column count. --->
	<cfset local.ColumnCount = arrayLen(local.ColumnNames)/>

	<!--- Create a short hand for the new line characters. --->
	<cfset local.NewLine = (chr(13) & chr(10))/>

	<!--- Create an array to hold the set of row data. --->
	<cfset local.Rows = []/>

	<!--- Check to see if we need to add a header row. --->
	<cfif arguments.CreateHeaderRow>
		<!--- Create array to hold row data. --->
		<cfset local.RowData = []/>

		<cfif len(arguments.HeaderList)>
			<cfset local.loopcounter = 1>
			<cfloop list="#arguments.HeaderList#" index="local.ColumnIndex">
				<!--- Add the field name to the row data. --->
				<cfset local.RowData[local.loopcounter] = """#local.ColumnIndex#"""/>
				<cfset local.loopcounter++>
			</cfloop>
        <cfelse>
			<!--- Loop over the column names. --->
			<cfloop index="local.ColumnIndex" from="1" to="#local.ColumnCount#" step="1">
				<!--- Add the field name to the row data. --->
				<cfset local.RowData[local.ColumnIndex] = """#local.ColumnNames[local.ColumnIndex]#"""/>
			</cfloop>
		</cfif>

		<!--- Append the row data to the string buffer. --->
		<cfset arrayAppend(local.Rows, arrayToList(local.RowData, arguments.Delimiter))/>
	</cfif>

	<!---
		Now that we have dealt with any header value, let's
		convert the query body to CSV. When doing this, we are
		going to qualify each field value. This is done be
		default since it will be much faster than actually
		checking to see if a field needs to be qualified.
	--->

	<!--- Loop over the query. --->
	<cfloop query="arguments.Query">
		<!--- Create array to hold row data. --->
		<cfset local.RowData = []/>

		<!--- Loop over the columns. --->
		<cfloop index="local.ColumnIndex" from="1" to="#local.ColumnCount#" step="1">
			<!--- Add the field to the row data. --->
			<cfset local.RowData[local.ColumnIndex] = """#replace(
				arguments.Query[local.ColumnNames[local.ColumnIndex]][arguments.Query.CurrentRow],
				"""",
				"""""",
				"all"
			)#"""/>
		</cfloop>

		<!--- Append the row data to the string buffer. --->
		<cfset arrayAppend(local.Rows, arrayToList(local.RowData, arguments.Delimiter))/>
	</cfloop>

	<!---
		Return the CSV value by joining all the rows together
		into one string.
	--->
	<cfreturn arrayToList(local.Rows, local.NewLine)/>
</cffunction>

<cffunction
	name="queryChangeColumnName"
	access="public"
	output="false"
	returntype="query"
	hint="Changes the column name of the given query."
>
	<cfargument name="query" type="query" required="true"/>
	<cfargument name="columnName" type="string" required="true"/>
	<cfargument name="newColumnName" type="string" required="true"/>
	<cfscript>
	// Define the local scope.
	var local = structNew();

	// Get the list of column names. We have to get this
	// from the query itself as the "ColdFusion" query
	// may have had an updated column list.
	local.Columns = arguments.Query.GetColumnNames();

	// Convert to a list so we can find the column name.
	// This version of the array does not have indexOf
	// type functionality we can use.
	local.ColumnList = arrayToList(local.Columns);

	// Get the index of the column name.
	local.ColumnIndex = listFindNoCase(local.ColumnList, arguments.ColumnName);

	// Make sure we have found a column.
	if (local.ColumnIndex) {
		// Update the column name. We have to create
		// our own array based on the list since we
		// cannot directly update the array passed
		// back from the query object.
		local.Columns = listToArray(local.ColumnList);

		local.Columns[local.ColumnIndex] = arguments.NewColumnName;

		// Set the column names.
		arguments.Query.SetColumnNames(local.Columns);
	}

	// Return the query reference.
	return (arguments.Query);
	</cfscript>
</cffunction>

<cffunction name="queryToJSON" returntype="string" access="public" output="yes">
	<cfargument name="q" type="query" required="yes"/>
	<cfset var o = arrayNew(1)>
	<cfset var i = 0>
	<cfset var r = 0>
	<cfloop query="arguments.q">
		<cfset r = Currentrow>
		<cfloop index="i" list="#lCase(arguments.q.columnList)#">
			<cfset o[r][i] = evaluate(i)>
		</cfloop>
	</cfloop>
	<cfreturn serializeJSON(o)>
</cffunction>

<cfscript>
public array function queryToArray(required query query) {
	local.returnValue = [];
	loop query=arguments.query {
		arrayAppend(local.returnValue, queryRowData(arguments.query, arguments.query.currentRow));
	}
	return local.returnValue;
}

/**
* Given a query, I creates an array of structures to be used in select option arguments
*/
public array function queryToSelectOptions(
	required query query,
	required string valueColumn,
	required string textColumn
) {
	var loc = {};
	loc.returnValue = [];
	for (loc.row in arguments.query) {
		loc.returnValue.Append({value = loc.row[arguments.valueColumn], text = loc.row[arguments.textColumn]})
	}
	return loc.returnValue;
}

/** Given a serialized query, I will return a cfml query object*/
public query function JSONToQuery(required string json) {
	var loc = {};
	loc.struct = deserializeJSON(arguments.json);
	loc.rv = queryNew(arrayToList(loc.struct.columns))
	for (loc.row in loc.struct.data) {
		queryAddRow(loc.rv);
		loc.i = 0;
		for (loc.col in loc.row) {
			loc.i++;
			querySetCell(loc.rv, loc.struct.columns[loc.i], loc.col);
		}
	}
	;
	return loc.rv;
}

/**
 * Query List Capped Size
 *
 * [section: Application]
 * [category: List Functions]
 *
 * @column Column Name to match against (required)
 * @list List (required)
 */
public function splitQueryParamList(
	required string column = "",
	required string list = "",
	boolean asString = true,
	boolean sanitise = false,
	number cap = "50"
) {

	local.whereArr = [];

	if (listLen(arguments.list) > arguments.cap) {
		local.splitArray = arraysOfLength(listToArray(arguments.list), arguments.cap);
		for (local.i in local.splitArray) {
			local.whereArr.Append("#arguments.column# IN (#listEnsure(ArrayToList(local.i))#)")
		}
	}
	else {
		local.whereArr = ["#arguments.column# IN (#listEnsure(list=arguments.list,sanitise=arguments.sanitise)#)"];
	}

	return arguments.asString ? whereify(array=local.whereArr, operator="OR") : local.whereArr;
}

</cfscript>
