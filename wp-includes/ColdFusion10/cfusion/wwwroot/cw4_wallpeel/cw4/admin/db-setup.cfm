<cfsilent>
<!---
==========================================================
Application: Cartweaver 4 ColdFusion
Copyright 2002 - 2013, All Rights Reserved
Developer: Application Dynamics, Inc. | Cartweaver.com
Licensing: http://www.cartweaver.com/eula
Support: http://www.cartweaver.com/support
File Date: 2013-01-17
Description: Creates Cartweaver database, removes this file after running once
Note: Execute with caution! All operations are permanent!
==========================================================
--->
<!--- time out the page if it takes too long  --->
<cfsetting requesttimeout="9000">
<!--- defaults --->
<cfparam name="getTables.columnList" default="">	
<cfparam name="application.cw.appDbType" default="">
<cfif isDefined('url.dbtype')>
	<cfset form.dbtype = url.dbtype>
</cfif>
<cfif isDefined('form.dbtype') 
	and (trim(form.dbtype) is '' or trim(form.dbtype) is 'mySQL' or trim(form.dbtype) is 'MSSQLServer')>
	<cfset application.cw.appDbType = trim(form.dbtype)>
</cfif>
<cfset dbSetupErrors = ''>
<cfset dbOK = true>
<cfset anyError = 0>
<!--- include global CW database / DSN settings --->
<cfinclude template="../cwconfig/cw-config.cfm">
<!--- check for db type --->
<cfif application.cw.appDbType is 'MSSQLServer'>
	<cfset sqlFile = 'db-mssql.sql'>
	<cfset sqlFileExtra = 'db-mysql.sql'>
<cfelse>
	<cfset sqlFile = 'db-mysql.sql'>
	<cfset sqlFileExtra = 'db-mssql.sql'>
</cfif>

<!--- db type selection --->
<cfif isDefined('form.dbtype')>
	<cfset application.cw.appDbType = form.dbtype>
</cfif>

<!--- if db type is defined--->
<cfif application.cw.appDbType is not ''>
	<!--- run query for tables --->
	<cftry>
		<cfif application.cw.appDbType is 'MSSQLServer'>
			<cfquery name="getTables" datasource="#request.cwapp.datasourcename#" username="#request.cwapp.datasourceusername#" password="#request.cwapp.datasourcepassword#">
			SELECT DISTINCT TABLE_NAME FROM information_schema.TABLES;
			</cfquery>
		<cfelse>
			<cfquery name="getTables" datasource="#request.cwapp.datasourcename#" username="#request.cwapp.datasourceusername#" password="#request.cwapp.datasourcepassword#">
			SHOW TABLES;
			</cfquery>
		</cfif>
	<!--- handle errors --->
	<cfcatch>
		<cfset dbSetupErrors = listAppend(dbSetupErrors,'Connection Error: #cfcatch.message#<br>Please be sure you have selected the correct <a href="#cgi.script_name#?dbtype=">database type</a>','|')>
		<cfset dbOk = false>
	</cfcatch>
	</cftry>
	<!--- if tables exist, show message --->
	<cfif not len(trim(dbsetuperrors)) and getTables.recordCount and not isDefined('form.dbCreate')>
	<!--- cfquery column name is specific to the db, get from query results --->
	<cfset colVal = getTables.columnList>
	<cfset tablesList = ''>
		<cfoutput query="getTables">
			<cfset tName = evaluate(colVal)>
			<cfif left(tName,3) is 'cw_' and not right(tName,9) is '_replaced'>
				<cfset tablesList = listAppend(tablesList,tname)>
			</cfif>
		</cfoutput>
		<cfif listLen(tablesList) gt 0>
			<!--- prevent execution if tables exist, and not logged in --->	
			<cfif not (isDefined('session.cw.loggedin') and session.cw.loggedin is 1 and isDefined('session.cw.accesslevel') and session.cw.accesslevel is 'developer')>
				<cfset dbSetupErrors = listAppend(dbSetupErrors,'Authentication Required: access restricted','|')>
				<cfset dbOk = false>
			<cfelse>	
				<cfsavecontent variable="errorMsg">
				Your database already contains the following Cartweaver tables:<br>
				<cfloop list="#tablesList#" index="i"><cfoutput>#i#<br></cfoutput></cfloop>
				<em><br><br>IMPORTANT: Create a new database and/or DSN, and update the settings in cw4/cwconfig/cw-config.cfm,
				<br>or all data in these tables will be removed from your database when you run this script!</em>
				</cfsavecontent>
				<cfset dbSetupErrors = listAppend(dbSetupErrors,errorMsg,'|')>
			</cfif>		
		</cfif>
	</cfif>
	<!--- /end if tables exist --->
	
	<!--- set flag for sql file --->
	<cfset noScript = false>
	<!--- if no errors --->
	<cfif len(trim(dbSetupErrors)) eq 0>
		<!--- set successful values into application scope --->
		<cfset application.cw.dsn = request.cwapp.datasourcename>
		<cfset application.cw.dsnUsername = request.cwapp.datasourceusername>
		<cfset application.cw.dsnPassword = request.cwapp.datasourcepassword>
		<!--- get sql file --->
		<cfset fileContents = ''>
		<cfif fileExists(expandPath(sqlFile))>
			<cfset fileContents = fileRead(expandPath(sqlFile))>
		</cfif>
		<!--- if file does not exist --->
		<cfif len(trim(fileContents)) eq 0>
			<cfset noScript = true>
			<cfsavecontent variable="errorMsg">
			The required file <cfoutput>#sqlFile#</cfoutput> does not exist or is empty. To continue, find the file in your original Cartweaver download
			<br>and upload it to this server in the cw4/admin directory.
			</cfsavecontent>
			<cfset dbSetupErrors = listAppend(dbSetupErrors,errorMsg,'|')>
		</cfif>
	</cfif>
	
	<!--- if no errors, and form has been posted, run the script --->
	<cfif len(trim(dbSetupErrors)) eq 0 and isDefined('form.dbCreate') and noScript eq false>
		<!--- split into separate queries --->
		<cfif application.cw.appDbType is 'mssqlserver'>
			<cfset fileParts = javaCast("string",fileContents).split(
					javaCast('string','GO\r'),
					javaCast( 'int', -1 )
					)>
		<cfelse>		 
			<cfset fileParts = javaCast("string",fileContents).split(
					javaCast('string',';[\r\n]'),
					javaCast( 'int', -1 )
					)>
		</cfif>
	
		<cfset sqlCommands = []>
		<!--- loop over the parts and append them to the results --->
		<cfloop array="#fileparts#" index="queryPart">
			<cfset arrayAppend(sqlCommands,queryPart)>
		</cfloop>
		
		<cfset anyError = -1>
		<cfloop array="#sqlcommands#" index="sql">
			<cfif len(trim(sql)) gt 0>
				<cftry>
				<cfquery name="runSQL" datasource="#application.cw.dsn#" username="#application.cw.dsnUsername#" password="#application.cw.dsnPassword#">
				#preserveSingleQuotes(sql)#
				</cfquery>
				<!--- handle any errors --->
				<cfcatch>
				<cfset anyError = 1>
				<cfsavecontent variable="errorMsg">
				<cfoutput>Error during setup: #cfcatch.detail#<br><br>Query SQL: #htmlEditFormat(sql)#</cfoutput>
				</cfsavecontent>
				<cfset dbSetupErrors = listAppend(dbSetupErrors,errorMsg,'|')>
				<cfbreak>
				</cfcatch>
				</cftry>
			</cfif>
		</cfloop>
	
		<!--- if no errors and deletion is selected, remove sql file and setup script --->
		<cfif (len(trim(dbSetupErrors)) eq 0 OR anyError eq -1)
				AND (isDefined('url.deletefiles') OR isDefined('form.deletefiles'))>
			<cffile action="delete" file="#expandPath(sqlFile)#">
			<!--- delete additional setup file --->
			<cfif fileExists(expandPath(sqlFileExtra))>
				<cffile action="delete" file="#expandPath(sqlFileExtra)#">
			</cfif>
			<cffile action="delete" file="#expandPath(cgi.script_name)#">
		</cfif>
		<!--- redirect to admin home page  --->
		<cfif (len(trim(dbSetupErrors)) eq 0 OR anyError eq -1)>
			<cflocation url="index.cfm?dbsetup=ok" addtoken="no">
		</cfif>
	</cfif>
	<!--- /end processing --->
</cfif>
<!--- /end if application.cw.appDbType defined --->	
</cfsilent>

<!--- START OUTPUT --->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN"
"http://www.w3.org/TR/html4/strict.dtd">
<html>
	<head>
		<cfoutput>
		<title>Cartweaver : Database Setup</title>
		</cfoutput>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
		<!-- admin styles -->
		<link href="css/cw-layout.css" rel="stylesheet" type="text/css">
		<link href="theme/light blue/cw-admin-theme.css" rel="stylesheet" type="text/css">
		<style type="text/css" media="screen">
			#CWadminContent p, form p{
				line-height:1.4em;
				margin-left:0;
			}
		</style>
	</head>
	<!--- body gets a class to match the filename --->
	<body class="db-setup">
		<div id="CWadminWrapper">
			<!-- Main Content Area -->
			<div id="CWadminPage">
				<!-- inside div to provide padding -->
				<div class="CWinner">
					<h1>Cartweaver Database Setup</h1>
					<h2>Set up a new database for your Cartweaver store</h2>
					<!-- Page Content Area -->
					<div id="CWadminContent">
						<!-- //// PAGE CONTENT ////  -->
						<p>&nbsp;</p>
						<!--- show errors --->
						<cfif listLen(dbSetupErrors,'|') gt 0>
							<cfloop list="#dbSetupErrors#" index="i" delimiters="|">
							<cfoutput><p class="alert">#i#</p></cfoutput>
						</cfloop>
						</cfif>
						<!--- if database type is not defined yet --->
						<cfif application.cw.appDbType is  ''>
							<!--- form for db type selection --->							
	                        <cfoutput>
							<form action="#cgi.script_name#" name="dbTypeForm" id="dbTypeForm" method="post">
	                            <p>To begin, please select your database type: </p>
	                            <p>&nbsp;</p>
								<select name="dbType" id="dbType">
								<option value="">Choose DB Server Platform...</option>
								<option value="mySQL">mySQL</option>
								<option value="MSSQLServer">MS SQL Server</option>
								</select>
	                            <p>&nbsp;</p>
								<p><input name="dbTypeSubmit" type="submit" class="submitButton" id="dbTypeSubmit" value="Select Database Type"></p>
	                        </form>
							</cfoutput>

						<!--- if database type is defined --->
						<cfelse>
							<!--- form for db creation --->
	                        <cfoutput>
	              				<cfif dbok>
									<form action="#cgi.script_name#" name="setupForm" id="setupForm" method="post">
			                            <p>This page is used to set up your database using a .sql text file.
											<br>Before running this script, please verify the following information is correct for your database. </p>
			                            <p>&nbsp;</p>
			                            <p><strong>Datasource (DSN):</strong> #request.cwapp.datasourcename#</p>
			                            <p><strong>Database Type:</strong> #application.cw.appDbType#</p>
			                            <p>&nbsp;</p>
										<p>You must have a database set up at this location with proper access permissions for the ColdFusion DSN. <br>(If not, please access the cw4/cwconfig/cw-config.cfm file to update your settings before you continue.)</p>
			                            <p>&nbsp;</p>
										<cfif noScript eq false>
			                            <p><input name="deletefiles" type="checkbox" id="deletefiles" value="deletefiles">&nbsp;&nbsp;Delete setup files (recommended for production installation)</p>
				                            <p>&nbsp;</p>
											<p><input name="dbcreate" type="submit" class="submitButton" id="dbcreate" value="Start Setup"></p>
										</cfif>
			                        </form>
								</cfif>
							</cfoutput>
						</cfif>
						<!--- end if db type defined --->
						</div>
					<!-- /end Page Content -->
				</div>
				<!-- /end CWinner -->
			</div>
			<!--- page end content / debug --->
			<cfinclude template="cwadminapp/inc/cw-inc-admin-page-end.cfm">
			<!-- /end CWadminPage-->
			<div class="clear"></div>
		</div>
		<!-- /end CWadminWrapper -->
	</body>
</html>