<cfsilent>
<!--- 
================================================================
Application Info: Cartweaver© 2002 - 2007, All Rights Reserved.
Developer Info: Application Dynamics Inc.
                1560 NE 10th
                East Wenatchee, WA 98802
Support Info: http://www.cartweaver.com/go/cfhelp
				
Cartweaver Version: 3.0.0  -  Date: 4/21/2007
================================================================
Name: ListScndCategories.cfm
Description: List secondary categories
================================================================
--->
<!--- Set location for highlighting in Nav Menu --->
<cfset strSelectNav = "Categories">

<!--- Set Page Archive Status --->
<cfparam name="URL.ScndCategoryView" default="0">

<!--- Set local variable for currently viewed status to limit hits to Client scope --->
<cfparam name="CurrentStatus" default="Active">
<cfif URL.ScndCategoryView NEQ 0>
	<cfset CurrentStatus = "Archived">
</cfif>

<!--- ADD Record --->
<cfif IsDefined("FORM.AddRecord")>
	<cfquery name="rsCheckScndCategory" datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
	SELECT * FROM tbl_prdtscndcats WHERE scndctgry_Name ='#FORM.scndctgry_Name#'
	</cfquery>
	<cfif rsCheckScndCategory.RecordCount EQ 0>
		<cfquery datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
		INSERT INTO tbl_prdtscndcats (scndctgry_Name, scndctgry_Sort) VALUES ('#FORM.scndctgry_Name#', #FORM.scndctgry_Sort#)
		</cfquery>
		<cflocation url="#request.ThisPage#" addtoken="no">
		<cfelse>
		<cfset adderror="Secondary Category *" & #FORM.scndctgry_Name# & "* already exists in the database.">
	</cfif>
</cfif>

<cfif IsDefined("FORM.UpdateCategories")>
	<cfloop from="1" to="#FORM.categoryCounter#" index="id">
		<cfparam name="FORM.deleteCategory" default="">
		<cfif ListFind(FORM.deleteCategory,Evaluate("FORM.scndctgry_ID#id#"))>
			<!--- Delete Record --->
			<cfquery datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
			DELETE FROM tbl_prdtscndcats WHERE scndctgry_ID = #Evaluate("FORM.scndctgry_ID#id#")#
			</cfquery>
			
			<cfelse>
			<!--- Update Record --->
			<cfparam name="FORM.scndctgry_Archive#ID#" default="#URL.ScndCategoryView#">
			<cfquery datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
			UPDATE tbl_prdtscndcats SET
			scndctgry_Name = '#FORM["scndctgry_Name#id#"]#',
			scndctgry_Sort = #FORM["scndctgry_Sort#id#"]#,
			scndctgry_Archive = #FORM["scndctgry_Archive#id#"]#
			WHERE scndctgry_ID = #FORM["scndctgry_ID#id#"]#
			</cfquery>
			
		</cfif>
	</cfloop>
	<cflocation url="#Request.ThisPageQS#" addtoken="no">
</cfif>

<!--- Get Record --->
<cfquery name="rsScndCategoryList" datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
SELECT * FROM tbl_prdtscndcats WHERE scndctgry_Archive = #URL.ScndCategoryView#
ORDER BY scndctgry_Sort, scndctgry_Name
</cfquery>
</cfsilent>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>CW Admin: Secondary Categories</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="assets/admin.css" rel="stylesheet" type="text/css">
</head>
<body> 
<!--- Include Admin Navigation Menu---> 
<cfinclude template="CWIncNav.cfm"> 
<div id="divMainContent"> 
	<h1>Secondary Categories</h1> 
	<p> 
		<cfif CurrentStatus EQ "Active"> 
			<a href="<cfoutput>#request.ThisPage#</cfoutput>?ScndCategoryView=1">View
			Archived</a> 
			<cfelse> 
			<a href="<cfoutput>#request.ThisPage#</cfoutput>?ScndCategoryView=0">View
			Active</a> 
		</cfif> 
	</p> 
	<cfif CurrentStatus EQ "Active"> 
		<cfform name="Add" method="POST" action="#request.ThisPage#"> 
			<cfif IsDefined('adderror')> 
				<cfoutput>#adderror#</cfoutput> 
			</cfif> 
			<table> 
				<caption>
 				Add Secondary Category
				</caption> 
				<tr align="center"> 
					<th>Secondary Category</th> 
					<th>Sort</th>
					<th>Add</th> 
				</tr> 
				<tr align="center" class="altRowEven"> 
					<td><cfinput name="scndctgry_Name" type="text" size="25" required="yes" message="Secondary Category Name Required"> </td> 
					<td><cfinput name="scndctgry_Sort" type="text" size="3" required="yes" message="Secondary Category Sort is required and must be numeric" validate="float" value="0"></td>
					<td> <input name="AddRecord" type="submit" class="formButton" id="AddRecord" value="Add"> </td> 
				</tr> 
			</table> 
		</cfform> 
	</cfif> 
	<!--- END IF - CurrentStatus EQ "Active" ---> 
	<cfif rsScndCategoryList.RecordCount NEQ 0> 
<cfform action="#Request.ThisPageQS#" method="post" name="frmSecondary">
		<table> 
			<caption>
 			Current Secondary Categories
			</caption> 
			<tr> 
				<th align="center">Secondary Category</th> 
				<th align="center">Sort</th>
				<th align="center">Delete</th> 
				<th align="center"><cfif URL.ScndCategoryView EQ 0>Archive<cfelse>Activate</cfif></th> 
			</tr> 
			<cfset CurrentRow = 0> 
			<cfoutput query="rsScndCategoryList"> 
				<!--- Check to see if the Category is associated with any Products. ---> 
				<cfquery name="rsProductScndCategories" datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
 				SELECT DISTINCT tbl_prdtscndcats.scndctgry_ID FROM tbl_products INNER
 				JOIN (tbl_prdtscndcats INNER JOIN tbl_prdtscndcat_rel ON tbl_prdtscndcats.scndctgry_ID
 				= tbl_prdtscndcat_rel.prdt_scnd_rel_ScndCat_ID) ON tbl_products.product_ID
 				= tbl_prdtscndcat_rel.prdt_scnd_rel_Product_ID WHERE tbl_prdtscndcats.scndctgry_ID
 				= #rsScndCategoryList.scndctgry_ID# 
				</cfquery> 
				<tr class="#IIF(CurrentRow MOD 2, DE('altRowEven'), DE('altRowOdd'))#"> 
					<td>#CurrentRow#. <input type="hidden" name="scndctgry_ID#CurrentRow#" value="#scndctgry_ID#"><cfinput name="scndctgry_Name#CurrentRow#" type="text" size="25" required="yes" message="Secondary Category Name is required for category #CurrentRow#" value="#scndctgry_Name#"> </td> 
					<td><cfinput name="scndctgry_Sort#CurrentRow#" type="text" size="3" required="yes" message="Secondary Category Sort is required and must be numeric for category #CurrentRow#" validate="float" value="#scndctgry_Sort#"></td>
					<td align="center"><input type="checkbox" class="formCheckbox" name="deleteCategory" value="#scndctgry_ID#"<cfif rsProductScndCategories.RecordCount NEQ 0> disabled</cfif>></td> 
					<td align="center"><input type="checkbox" class="formCheckbox" name="scndctgry_Archive#CurrentRow#" value="<cfif URL.ScndCategoryView EQ 0>1<cfelse>0</cfif>"></td> 
				</tr> 
			</cfoutput> 
		</table> 
		<input type="hidden" name="categoryCounter" value="<cfoutput>#rsScndCategoryList.RecordCount#</cfoutput>">
		<input type="submit" name="UpdateCategories" value="Update Categories" class="formButton">
		</cfform>
		<cfelse> 
		<p>There are no records to display</p>
	</cfif> 
	<!--- END IF - rsScndCategoryList.RecordCount NEQ 0 ---> 
</div> 
</body>
</html>
