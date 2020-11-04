<!--- Plug in an existing datasource --->
<cfquery name="qDatabases" datasource="YOUR_DSN_HERE">
SHOW DATABASES;
</cfquery>

<!--- Log in to the CF admin with your password --->
<cfset adminAPI = createObject( 'component', 'cfide.adminapi.administrator' ) />
<cfset adminAPI.login( 'YOUR_PASSWORD_HERE' ) />

<!--- Loop over our query and create datasources for each database in MySQL --->
<cfloop query="qDatabases">

	<cfscript>
	dsnAPI = createObject( 'component', 'cfide.adminapi.datasource' );

	// Create a struct that contains all the information for the
	// datasource. Most of the keys are self explanatory, but I
	// had trouble finding the one for the connection string setting.
	// Turns out that the key is "args"
	dsn = {
		driver = 'mysql5',
		name = '#database#',
		host = 'localhost',
		port = '3306',
		database = '#database#',
		username = 'YOUR_MYSQL_USERNAME',
		password = 'YOUR_MYSQL_PASSWORD',
		args = 'allowMultiQueries=true'
	};

	// Finally, we save the new datasource
	dsnAPI.setMySQL5( argumentCollection = dsn );
	</cfscript>

</cfloop>
