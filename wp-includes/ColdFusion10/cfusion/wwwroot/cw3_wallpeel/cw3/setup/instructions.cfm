<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Quickstart Instructions</title>
<link href="../assets/css/cartweaver.css" rel="stylesheet" type="text/css" />
</head>

<body>
<h3 class="errorMessage">Make sure your site supports ColdFusion and one of our supported databases and make sure they are working together  before attempting to install Cartweaver</h3>
<h1>Cartweaver 3 ColdFusion Quickstart Steps for Dreamweaver</h1>
<ol>
	<li>Double-click the .mxp file to install Cartweaver into Dreamweaver.  If DW is open while installing, close and re-open it.</li>
	<li>Open the Cartweaver menu and click Cartweaver 3 ColdFusion &gt; Install Cartweaver 3 </li>
	<li>Fill in required fields and click OK.</li>
	<li>Set up your database. You can use the Access database that ships with Cartweaver, or use one of the downloadable scripts to create a SQL Server or MySQL database. </li>
	<li>Set up your ColdFusion data source name using your ColdFusion administrator. </li>
	<li>Once the above steps are completed, open Application.cfm and either 
		double-click on Cartweaver 3 Setup in the Server Behaviors panel (Window &gt; 
		Server Behaviors) and complete the dialog, or manually enter the appropriate
	settings according to the PDF documentation. Be sure to fill in required fields using your new data source name.</li>
</ol>
<p>You should now be able to test CW 3. Browse to http://[yoursite]/index.cfm to access the sample home page. There is an admin link on this page to enter the CW admin. </p>
<p>To access the new Configuration groups in the Cartweaver admin, add the debug variable to the url:</p>
<blockquote>
	<p>http://[yoursite]/cw3/admin/index.cfm?debug=YourDebugPassword </p>
</blockquote>
<p>This will show the Store Settings &gt; Config Groups section in the menu. This is a new feature of CW 3 and allows you to set various variables and settings from within the admin rather than hard-coding them in one of your files. The help files should give you a better understanding of the Config groups </p>
<h1>Cartweaver 3 ColdFusion Quickstart Steps for Other Code Editors</h1>
<ol>
	<li>Copy the files from the Cartweaver3CF folder to a folder in your site, or at the root of your site. </li>
	<li>Set up your database. You can use the Access database that ships with Cartweaver, or use one of the downloadable scripts to create a SQL Server or MySQL database. </li>
	<li>Set up your ColdFusion data source name using your ColdFusion administrator. </li>
	<li>Once the above steps are completed, open Application.cfm and  manually enter the appropriate
		settings according to the PDF documentation. Be sure to fill in required fields using your new data source name. </li>
</ol>
<p>You should now be able to test CW 3. Browse to http://[yoursite]/index.cfm to access the sample home page. There is an admin link on this page to enter the CW admin. </p>
<p>To access the new Configuration groups in the Cartweaver admin, add the debug variable to the url:</p>
<blockquote>
	<p>http://[yoursite]/cw3/admin/index.cfm?debug=YourDebugPassword </p>
</blockquote>
<p>This will show the Store Settings &gt; Config Groups section in the menu. This is a new feature of CW 3 and allows you to set various variables and settings from within the admin rather than hard-coding them in one of your files. The help files should give you a better understanding of the Config groups </p>
<h1>Cartweaver 3 ColdFusion Upgrade from Cartweaver 2 Quickstart Steps</h1>
<ol>
	<li>Double-click the .mxp file to install Cartweaver into Dreamweaver.  If DW is open while installing, close and re-open it.</li>
	<li>Delete or rename your existing Application.cfm and index.cfm files</li>
	<li>Open the Cartweaver menu and click Cartweaver 3 ColdFusion &gt; Install Cartweaver 3 </li>
	<li>Fill in required fields and click OK. Note: This step will OVERWRITE existing presentation pages (results, details, confirmation, etc) if not careful. Uncheck the options to overwrite your presentation files except for index.cfm. These will have to be manually updated. Your existing CW2 include files will not be deleted or overwritten. The new files will go into a /cw3 directory.</li>
	<li>Download the update scripts from www.cartweaver.com. Install the setup folder into your site, or anywhere on your server.</li>
	<li>Browse to http://[yoursite]/setup/index.cfm </li>
	<li>Click the &quot;Update Cartweaver Database&quot; link to update your existing CW2  database, and add the Cartweaver 3 tables and data 
		to the  database. </li>
	<li>Once the above steps are completed, open Application.cfm and either 
		double-click on Cartweaver 3 Setup in the Server Behaviors panel (Window &gt; 
		Server Behaviors) and complete the dialog, or manually enter the appropriate
		settings according to the PDF documentation. Be sure to fill in required fields using your  database, username, and password.</li>
	<li>You will have to open each presentation file and change your includes from /cw2/ to /cw3/. In addition, any CW2 search or cart links will need to use new syntax. Check the manual for more details. Images stored in the /cw2 folder will have to be moved to /cw3. </li>
</ol>
<p>You should now be able to test CW 3. Browse to http://[yoursite]/index.cfm to access the sample home page. There is an admin link on this page to enter the CW admin. </p>
<p>To access the new Configuration groups in the Cartweaver admin, add the debug variable to the url:</p>
<blockquote>
	<p>http://[yoursite]/cw3/admin/index.cfm?debug=YourDebugPassword </p>
</blockquote>
<p>This will show the Store Settings &gt; Config Groups section in the menu. This is a new feature of CW 3 and allows you to set various variables and settings from within the admin rather than hard-coding them in one of your files. The help files should give you a better understanding of the Config groups </p>
<h1>Cartweaver 3 ColdFusion Remote Setup Steps</h1>
<ol>
	<li>Upload your Cartweaver store to the server</li>
	<li>Upload your Cartweaver database to your server. If this is an Access database, you can upload the *.mdb file. If using SQL Server or MySQL, you will have to use the appropriate administrative tools supplied by your host to upload the database.</li>
	<li>Set up your remote data source name, or in some cases, have your host do this for you.</li>
	<li>Once the above steps are completed, open Application.cfm and either 
  double-click on Cartweaver 3 Setup in the Server Behaviors panel (Window &gt; 
  Server Behaviors) and complete the dialog, or manually enter the appropriate
  settings according to the PDF documentation.</li>
</ol>
<p><strong><em>Note: local and remote versions of Application.cfm will usually be different and require different settings.</em></strong></p>
<p></p>
</body>
</html>
