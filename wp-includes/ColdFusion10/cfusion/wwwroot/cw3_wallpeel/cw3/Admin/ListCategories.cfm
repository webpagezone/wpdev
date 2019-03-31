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
Name: ListCategories.cfm
Description: List and administer Product Categories
================================================================
--->
<!--- Set location for highlighting in Nav Menu --->
<cfset strSelectNav = "Categories">

<!--- Set Page Archive Status --->
<cfparam name="URL.CategoryView" default="0">

<!--- Set local variable for currently viewed status to limit hits to Client scope --->
<cfparam name="CurrentStatus" default="Active">
<cfif URL.CategoryView NEQ 0>
	<cfset CurrentStatus = "Archived">
</cfif>

<!--- ADD Record --->
<cfif IsDefined("FORM.AddRecord")>
	<cfquery name="rsCheckCategory" datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
	SELECT * FROM tbl_prdtcategories WHERE category_Name ='#FORM.category_Name#'
	</cfquery>
	<cfif rsCheckCategory.RecordCount EQ 0>
		<cfquery datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
		INSERT INTO tbl_prdtcategories (category_Name,category_sortorder, category_archive) VALUES
		('#FORM.category_Name#',#FORM.category_sortorder#, 0)
		</cfquery>
		<cflocation url="#request.ThisPage#" addtoken="no">
		<cfelse>
		<cfset adderror="Category *" & #FORM.category_Name# & "* already exists in the database.">
	</cfif>
</cfif>

<!--- Update all categories --->
<cfif IsDefined("FORM.UpdateRecords")>
	<cfparam name="FORM.deleteCategory" default="">
	<cfloop from="1" to="#FORM.CatCount#" index="id">
		<cfif ListFind(FORM.deleteCategory,Evaluate("FORM.category_ID"&id))>
			<!--- Delete Record --->
			<cfquery datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
			DELETE FROM tbl_prdtcat_rel WHERE prdt_cat_rel_Cat_ID = #Evaluate("FORM.category_ID"&id)#
			</cfquery>
			<cfquery datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
			DELETE FROM tbl_prdtcategories WHERE category_ID = #Evaluate("FORM.category_ID"&id)#
			</cfquery>
		
			<cfelse>
			<!--- Update Records --->
			<cfparam name="FORM.category_Archive#id#" default="#URL.CategoryView#">
			<cfquery datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
			UPDATE tbl_prdtcategories SET 
			category_Name = '#FORM["category_name#id#"]#',
			category_sortorder = #FORM["category_sortorder#id#"]#, 
			category_Archive = #FORM["category_archive#id#"]# 
			WHERE category_ID = #FORM["category_ID#id#"]#
			</cfquery>
			
		</cfif>
	</cfloop>
	<cflocation url="#request.ThisPageQS#" addtoken="no">
</cfif>


<!--- Get Record --->
<cfquery name="rsCategoryList" datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
SELECT * FROM tbl_prdtcategories WHERE category_archive = #URL.CategoryView#
ORDER BY category_sortorder, category_Name
</cfquery>
</cfsilent>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>CW Admin: Categories</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="assets/admin.css" rel="stylesheet" type="text/css">
<script type="text/javascript">
function confirmDelete(obj,str,numberProducts){
	if(obj.checked){
		clickConfirm = confirm("There are products associated with this category, are you sure you want to delete this category?\nThere are "+numberProducts+" affected products:\n"+str);
		if(!clickConfirm){obj.checked = false;}
	}
}
</script>
</head>
<body> 
<!--- Include Admin Navigation Menu---> 
<cfinclude template="CWIncNav.cfm"> 
<div id="divMainContent"> 
	<h1>Categories</h1> 
	<p> 
		<cfif CurrentStatus EQ "Active"> 
			<a href="<cfoutput>#request.ThisPage#</cfoutput>?CategoryView=1">View Archived</a> 
			<cfelse> 
			<a href="<cfoutput>#request.ThisPage#</cfoutput>?CategoryView=0">View Active</a> 
		</cfif> 
	</p> 
	<!--- If we are viewing ACTIVE records show the ADD NEW form ---> 
	<cfif CurrentStatus EQ "Active"> 
		<cfform name="Add" method="POST" action="#request.ThisPage#"> 
			<cfif IsDefined('adderror')> 
				<cfoutput>#adderror#</cfoutput> 
			</cfif> 
			<table> 
				<caption>
 				Add Category
				</caption> 
				<tr align="center"> 
					<th>Category</th> 
					<th>Sort</th> 
					<th>Add</th> 
				</tr> 
				<tr align="center" class="altRowEven"> 
					<td><cfinput name="category_Name" type="text" size="15" required="yes" message="Category Name Required"> </td> 
					<td><cfinput name="category_SortOrder" type="text" size="2" required="yes" validate="integer" message="Sort order is required and must be numeric" value="0"> </td> 
					<td><input name="AddRecord" type="submit" class="formButton" id="AddRecord" value="Add"> </td> 
				</tr> 
			</table> 
		</cfform> 
	</cfif> 
	<cfif rsCategoryList.RecordCount NEQ 0 > 
		<cfform action="#Request.ThisPageQS#" method="post" name="frmCategories"> 
			<table> 
				<caption>
 				Current Categories 
				</caption> 
				<tr> 
					<th align="center">Category</th> 
					<th align="center">Sort</th> 
					<th align="center">Delete</th> 
					<th align="center"><cfif URL.CategoryView EQ 0>Archive<cfelse>Activate</cfif></th> 
				</tr> 
				<cfset CurrentRow = 0> 
				<cfoutput query="rsCategoryList"> 
					<!--- Check to see if the Category is associated with any Products. ---> 
					<cfquery name="rsProductCategories" datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
					SELECT product_Name FROM tbl_prdtcat_rel INNER JOIN tbl_products ON tbl_prdtcat_rel.prdt_cat_rel_Product_ID = tbl_products.product_ID 
					WHERE prdt_cat_rel_Cat_ID = #rsCategoryList.category_ID# ORDER BY product_Name
					</cfquery> 
					<cfscript>
					numLines = 10;

					//Check to see if the Category is associated with any Products.
					lstProds = ValueList(rsProductCategories.product_Name);
					lstProducts = "";
					numProducts = rsProductCategories.RecordCount;
					if(numProducts NEQ 0){ 
						if(ListLen(lstProds) LT numLines){numLines = ListLen(lstProds);}
						for(x = 1; x LTE numLines;x=x+1){
							lstProducts = ListAppend(lstProducts, JSStringFormat(Replace(ListGetAt(lstProds,x), """", "&quot;", "ALL")), "|");
						}
						if(ListLen(lstProds) GT numLines){lstProducts = ListAppend(lstProducts, "and more...", "|");}
					}
					lstProducts = ListChangeDelims(lstProducts,"\n","|");
					</cfscript>
					<tr class="#IIF(CurrentRow MOD 2, DE('altRowEven'), DE('altRowOdd'))#"> 
						<td>#CurrentRow#. <input type="hidden" name="category_id#CurrentRow#" value="#rsCategoryList.category_ID#"> 
							<cfinput name="category_name#CurrentRow#" required="yes" message="A category name is required for category #CurrentRow#" type="text" value="#rsCategoryList.category_Name#"></td> 
						<td align="center"><cfinput name="category_sortorder#CurrentRow#" required="yes" size="3" message="Sort order must be a numeric value for category #CurrentRow#." validate="integer" value="#rsCategoryList.category_sortorder#"></td> 
						<td align="center"><input type="checkbox" name="deleteCategory" value="#category_ID#" class="formCheckbox"<cfif numProducts NEQ 0> onclick="confirmDelete(this,'#lstProducts#',#numProducts#);")</cfif> /></td>
						<td align="center"><input type="checkbox" name="category_archive#CurrentRow#" class="formCheckbox" value="<cfif URL.CategoryView EQ 1>0<cfelse>1</cfif>"> </td> 
					</tr> 
				</cfoutput> 
			</table> 
			<input type="hidden" name="CatCount" id="CatCount" value="<cfoutput>#rsCategoryList.RecordCount#</cfoutput>" /> 
			<input name="UpdateRecords" type="submit" class="formButton" id="UpdateRecords" value="Update Categories" /> 
		</cfform> 
		<cfelse> 
		<p>There are no records to be displayed.</p>
	</cfif> 
	<!--- END IF - rsCategoryList.RecordCount NEQ 0 ---> 
</div> 
</body>
</html>
