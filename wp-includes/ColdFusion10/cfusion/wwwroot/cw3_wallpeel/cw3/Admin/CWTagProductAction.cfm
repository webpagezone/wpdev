<cfsilent>
<!--- 
================================================================
Application Info: Cartweaver© 2002 - 2007, All Rights Reserved.
Developer Info: Application Dynamics Inc.
                1560 NE 10th
                East Wenatchee, WA 98802
Support Info: http://www.cartweaver.com/go/cfhelp
				
Cartweaver Version: 3.0.12  -  Date: 5/25/2008
================================================================
Name: CWTagProductAction.cfm
Description: All actions for the Product Form page are handled here.
================================================================
--->
<cfif Not IsDefined("cwAltRows") OR Not IsCustomFunction(cwAltRows)>
	<cfinclude template="../CWTags/CWIncFunctions.cfm" />
</cfif>
<cfparam name="form.nextpage" default="1">
<!--- =====  ADD PRODUCT and / or SKU  ===== --->
<!--- [ START ] Add new Product --->
<cfif IsDefined("FORM.Action") and Form.Action EQ "AddProduct">

  <cfparam name="AddProductError" default="">
	<cfquery name="rsCheckProductID" datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
	SELECT product_MerchantProductID FROM tbl_products WHERE product_MerchantProductID = '#FORM.product_MerchantProductID#'
	</cfquery>
	<cfif rsCheckProductID.RecordCount NEQ 0>
		<cfset request.AddProductError = "Product already exists, please enter a new Product ID">
	<cfelse>
		<!--- Set Default Values for form fields for insert --->
		<cfparam name="FORM.product_MerchantProductID" default="NULL">
		<cfparam name="FORM.product_Name" default="NULL">
		<cfparam name="FORM.product_Description" default="NULL">
		<cfparam name="FORM.product_ShortDescription" default="NULL">
		<cfparam name="FORM.product_Sort" default="0">
		<cfparam name="FORM.product_OnWeb" default="NULL">
		<cfparam name="FORM.product_Archive" default="0">
		<cfparam name="FORM.product_shipchrg" default="1">
		<cfquery datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
		INSERT INTO 
			tbl_products 
				(product_MerchantProductID, 
				product_Name, 
				product_Description, 
				product_ShortDescription,
				product_Sort, 
				product_OnWeb, 
				product_Archive, 
				product_shipchrg,
				product_taxgroupid
				)
		VALUES (
				'#FORM.product_MerchantProductID#',
				'#FORM.product_Name#',
				'#FORM.product_Description#',
				'#FORM.product_ShortDescription#',
				#FORM.product_Sort#,
				#FORM.product_OnWeb#,
				'#FORM.product_Archive#',
				'#FORM.product_shipchrg#',
				#FORM.product_taxgroupid#
				)
		</cfquery>
		
		<!--- Get our new autonumber ID for further inserts --->
		<cfquery name="rsGetNewProdID" datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
		SELECT product_ID FROM tbl_products WHERE product_MerchantProductID = '#FORM.product_MerchantProductID#'
		</cfquery>

		<!--- Add Category/s --->
		<cfparam name="FORM.product_Category_ID" default="">
		<cfloop index="I" list="#FORM.product_Category_ID#">
			<cfquery datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
			INSERT INTO tbl_prdtcat_rel (prdt_cat_rel_Product_ID, prdt_cat_rel_Cat_ID)
			VALUES (#rsGetNewProdID.product_ID#, #I# )
			</cfquery>
		</cfloop>
		
		<!--- Add Secondary Category/s --->
		<cfparam name="FORM.scndctgry_ID" default="">
		<cfloop index="I" list="#FORM.scndctgry_ID#">
			<cfquery name="updtScndCats" datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
				INSERT INTO tbl_prdtscndcat_rel
				(prdt_scnd_rel_Product_ID, prdt_scnd_rel_ScndCat_ID )
				VALUES (#rsGetNewProdID.product_ID#, #I# )
			</cfquery>
		</cfloop>
		
		<!--- Add Selected Product Options --->
		<cfparam name="FORM.product_options" default="">
		<cfloop index="I" list="#FORM.product_options#">
			<cfquery name="updtProductOptions" datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
				INSERT INTO tbl_prdtoption_rel
				(optn_rel_Prod_ID, optn_rel_OptionType_ID)
				VALUES (#rsGetNewProdID.product_ID#, #I# )
			</cfquery>
		</cfloop>
		<!--- Add Image URLs --->
		<cfloop from="1" to="#FORM.ImageCount#" index="i">
			<cfif FORM["Image#i#"] NEQ "">
			<cfquery datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
				INSERT INTO tbl_prdtimages (
					prdctImage_ProductID,
					prdctImage_ImgTypeID,
					prdctImage_FileName,
					prdctImage_SortOrder
				) VALUES (
					<cfqueryparam cfsqltype="cf_sql_integer" value="#rsGetNewProdID.product_ID#" />
					, <cfqueryparam cfsqltype="cf_sql_integer" value="#FORM["ImageType#i#"]#" />
					, <cfqueryparam cfsqltype="cf_sql_varchar" value="#FORM["Image#i#"]#" />
					, 1)
			</cfquery>
			</cfif>
		</cfloop>
		<cflocation url="#request.ThisPage#?Product_ID=#rsGetNewProdID.product_ID#&nextpage=4&ADDSKU=ADD##addsku" addtoken="no">
 	</cfif><!--- END IF rsCheckProductID.RecordCount NEQ 0 --->
</cfif><!--- END IF - IsDefined("FORM.Action") and Form.Action EQ "AddProduct"--->
 
<!--- [ START ] Add new SKU  --->
<cfif IsDefined("FORM.AddSKU")>
	<!--- Check to make sure the SKU_ID is unique --->
  <cfquery name="rsCheckUniqueSKU" datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
	SELECT SKU_MerchSKUID FROM tbl_skus WHERE SKU_MerchSKUID = '#FORM.SKU_MerchSKUID#'
	</cfquery>
	<cfif rsCheckUniqueSKU.RecordCount NEQ 0>
		<cfset Request.AddSKUError = "SKU ID already exists. Please choose a different SKU ID.">
	<cfelse>
		<!--- Set Default Form Values --->
		<cfparam name="FORM.SKU_MerchSKUID" default="NULL">
		<cfparam name="FORM.product_ID" default="NULL">
		<cfparam name="FORM.SKU_Price" default="NULL">
		<cfparam name="FORM.SKU_Weight" default="0">
		<cfparam name="FORM.SKU_Stock" default="0">
		<cfparam name="FORM.SKU_ShowWeb" default="NULL">
		<cfparam name="FORM.SKU_Sort" default="0">
		
		<cfquery datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
			INSERT INTO tbl_skus (SKU_MerchSKUID, SKU_ProductID, SKU_Price, SKU_Weight, SKU_Stock,
			SKU_ShowWeb, SKU_Sort) VALUES (
				'#FORM.SKU_MerchSKUID#',
				'#FORM.product_ID#',
				#makeSQLSafeNumber(FORM.SKU_Price)#,
				#FORM.SKU_Weight#,
				#FORM.SKU_Stock#,
				#FORM.SKU_ShowWeb#,
				#FORM.SKU_Sort#
		)
		</cfquery>
		
		<!--- Get the autonumber to use for all further inserts --->
		<cfquery name="rsNewSKUID" datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
		SELECT SKU_ID FROM tbl_skus WHERE SKU_MerchSKUID = '#FORM.SKU_MerchSKUID#'
		</cfquery>
		<cfset newSKUID = rsNewSKUID.SKU_ID>
		<!--- Add SKU Options --->
		<!--- Loop through the form collection and grab all of the chosen options --->
		<cfset strOptions = "">
		<cfloop collection="#FORM#" item="FieldName"> 
			<cfif Left(FieldName,9) EQ "selOption" AND FORM[FieldName] NEQ "choose">
				<cfset strOptions = ListAppend(strOptions, FORM[FieldName], ",")>
			</cfif>
		</cfloop>
		<cfloop index="I" list="#strOptions#">
			<cfquery name="updtProductOptions" datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
				INSERT INTO tbl_skuoption_rel
				(optn_rel_sku_id, optn_rel_Option_ID)
				VALUES (#newSKUID#, #I# )
			</cfquery>
		</cfloop>
		<cflocation url="#request.ThisPage#?Product_ID=#URL.Product_ID#&nextpage=#form.nextpage#&ADDSKU=ADD##addsku" addtoken="no">
	</cfif><!--- END IF - rsCheckUniqueSKU.RecordCount EQ 0 --->
</cfif><!--- END IF -  IsDefined("FORM.UpdateSKU") --->
<!--- [ END ] Add new SKU  --->

<!--- =====  DELETE PRODUCT and associated SKUs ===== --->
 
<!--- [ START ] Delete PRODUCT --->

<cfif IsDefined ('FORM.DeleteProduct')>
	
	<!--- Get any product SKUs --->
	<cfquery name="getSKUs" datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
	SELECT SKU_ID
	FROM tbl_skus
	WHERE SKU_ProductID = #FORM.product_ID#
	</cfquery>	

	<!--- If we have skus, delete them --->
	<cfif getSKUS.recordcount NEQ 0>
		<cfset SKUList = ValueList(getSKUS.SKU_ID)>
		<!--- Delete all related product skus --->
		<!--- Delete options --->
		<cfquery datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
			DELETE FROM tbl_skuoption_rel 
			WHERE optn_rel_sku_id IN (#SKUList#)
		</cfquery>
		<!--- Delete SKU --->
		<cfquery datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
			DELETE FROM tbl_skus 
			WHERE SKU_ID IN (#SKUList#)
		</cfquery>
		<!--- Delete sku discounts --->
		<cfquery datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
		DELETE FROM 
		tbl_discounts_skus_rel
		WHERE discounts_skus_rel_sku_id IN (#SKUList#)
		</cfquery>
		
	</cfif>
	
	<!--- Delete Product Option Information --->
	<cfquery datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
	DELETE FROM tbl_prdtoption_rel
	WHERE optn_rel_Prod_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#FORM.product_ID#" />
	</cfquery>

	<!--- Delete Product Category Information --->	
	<cfquery datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
	DELETE FROM tbl_prdtcat_rel
	WHERE prdt_cat_rel_Product_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#FORM.product_ID#" />
	</cfquery>
	
	<!--- Delete Product Secondary Category Information --->	
	<cfquery datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
	DELETE FROM tbl_prdtscndcat_rel
	WHERE prdt_scnd_rel_Product_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#FORM.product_ID#" />
	</cfquery>
	
	<!--- Delete Product Image Information --->	
	<cfquery datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
	DELETE FROM tbl_prdtimages
	WHERE prdctImage_ProductID = <cfqueryparam cfsqltype="cf_sql_integer" value="#FORM.product_ID#" />
	</cfquery>
	
	<!--- Delete Product Up-sell Records--->
	<cfquery datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
	DELETE FROM  tbl_prdtupsell
	WHERE upsell_ProdID = <cfqueryparam cfsqltype="cf_sql_integer" value="#FORM.product_ID#" />
	OR upsell_RelProdID = <cfqueryparam cfsqltype="cf_sql_integer" value="#FORM.product_ID#" />
	</cfquery>	

	<!--- Delete Product Discount records--->
	<cfquery datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
	DELETE FROM 
	tbl_discounts_products_rel
	WHERE discounts_products_rel_prod_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#form.product_ID#">
	</cfquery>
	
	<!--- Delete Product --->
	<cfquery datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
	DELETE FROM tbl_products 
	WHERE product_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#FORM.product_ID#" />
	</cfquery>
	
	<!--- Go to Product List --->
	<cflocation url="ProductActive.cfm?nextpage=#form.nextpage#" addtoken="no">
	
</cfif><!--- [ END ] Delete PRODUCT --->

<!--- =====  DELETE SKU  ===== --->
 
 <!--- [ START ] Delete SKU  --->
<cfif IsDefined ('URL.delete_sku_id')>
	<!--- First, see if it is in use --->
	<cfquery name="checkSKUuse" datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
		SELECT orderSKU_SKU
		FROM tbl_orderskus
		WHERE orderSKU_SKU = #URL.delete_sku_id#
	</cfquery>
	<!--- If NOT - Delete it, If it IS - Set Error Message --->
	<cfif checkSKUuse.RecordCount IS "0">
		<!--- Delete Size and color --->
		<cfquery datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
			DELETE FROM tbl_skuoption_rel 
			WHERE optn_rel_sku_id=#URL.delete_sku_id#
		</cfquery>
		<!--- Delete SKU --->
		<cfquery datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
			DELETE FROM tbl_skus 
			WHERE SKU_ID=#URL.delete_sku_id#
		</cfquery>
		<cflocation url="ProductForm.cfm?Product_ID=#URL.product_ID#&nextpage=#form.nextpage#" addtoken="no">
	<cfelse>
		<cfset request.CantDeleteSKU = "Cannot delete this SKU. It is included in order records. You may set it to NOT appear on the web if you wish.">
	</cfif>
</cfif>
<!--- [ END ] Delete SKU  --->



<!--- ===== UPDATE PRODUCT ===== --->
<!--- [ START ] Update Existing Product --->
<cfif IsDefined ('FORM.Action') AND Form.Action EQ 'UpdateProduct'>
	<!--- Set Default FORM values --->
	<cfparam name="FORM.product_Description" default="NULL">
	<cfparam name="FORM.product_ShortDescription" default="NULL">
	<cfparam name="FORM.product_Sort" default="0">
	<cfparam name="FORM.product_OnWeb" default="NULL">
	<cfparam name="FORM.product_Archive" default="0">
	<cfparam name="FORM.product_shipchrg" default="1">
  <cfquery datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
		UPDATE tbl_products 
		SET 
			product_Name='#FORM.product_Name#', 
			product_Description = '#FORM.product_Description#',
			product_ShortDescription = '#FORM.product_ShortDescription#', 
			product_Sort = #FORM.product_Sort#, 
			product_OnWeb = #FORM.product_OnWeb#, 
			product_Archive = '#FORM.product_Archive#', 
			product_shipchrg = '#FORM.product_shipchrg#', 
			product_taxgroupid = #FORM.product_taxgroupid#
		WHERE product_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#FORM.product_ID#" />
  </cfquery>

	<!--- Update Images --->
	<cfloop from="1" to="#FORM.ImageCount#" index="i">
		<cfset FORMImageName = FORM["Image#i#"] />
		<cfset FORMImageID = FORM["ImageID#i#"] />
		<cfif FORMImageName EQ "" AND FORMImageID NEQ "">
			<cfquery datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
			DELETE FROM tbl_prdtimages WHERE prdctImage_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#FORMImageID#" />
			</cfquery>
		<cfelseif FORMImageName NEQ "" AND FORMImageID NEQ "">
			<cfquery datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
			UPDATE tbl_prdtimages
			SET prdctImage_FileName = <cfqueryparam cfsqltype="cf_sql_varchar" value="#FORMImageName#" /> 
			WHERE prdctImage_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#FORMImageID#" />
			</cfquery>
		<cfelseif FORMImageName NEQ "" AND FORMImageID EQ "">
			<cfquery datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
			INSERT INTO tbl_prdtimages (
				prdctImage_ProductID,
				prdctImage_ImgTypeID,
				prdctImage_FileName,
				prdctImage_SortOrder
			) VALUES (
				<cfqueryparam cfsqltype="cf_sql_integer" value="#FORM.product_ID#" />
				, <cfqueryparam cfsqltype="cf_sql_integer" value="#FORM["ImageType#i#"]#" />
				, <cfqueryparam cfsqltype="cf_sql_varchar" value="#FORMImageName#" />
				, 1
			)
			</cfquery>
			
		</cfif>
	</cfloop>

	<!--- Add Category/s --->  
	<!--- Delete current Category Relationships --->
	<cfquery datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
		DELETE FROM tbl_prdtcat_rel 
		WHERE prdt_cat_rel_Product_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#FORM.product_ID#" />
	</cfquery>
	
	<!---  INSERT the new ones  --->
	<cfparam name="FORM.product_Category_ID" default="">
	<cfloop index="I" list="#FORM.product_Category_ID#">
		 <cfquery datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
			INSERT INTO tbl_prdtcat_rel
				(prdt_cat_rel_Product_ID, prdt_cat_rel_Cat_ID )
				VALUES (#FORM.product_ID#, #I# )
		 </cfquery>
	</cfloop>

	<!--- Add Secondary Category/s --->  
	<!--- Delete current Subcategory Relationships --->
	<cfquery datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
		DELETE FROM tbl_prdtscndcat_rel 
		WHERE prdt_scnd_rel_Product_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#FORM.product_ID#" />
	</cfquery>
	
	<!---  INSERT the new ones  --->
	<cfparam name="FORM.scndctgry_ID" default="">
	<cfloop index="I" list="#FORM.scndctgry_ID#">
		 <cfquery name="updtScndCats" datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
			INSERT INTO tbl_prdtscndcat_rel
				(prdt_scnd_rel_Product_ID, prdt_scnd_rel_ScndCat_ID )
				VALUES (#FORM.product_ID#, #I# )
		 </cfquery>
	</cfloop>
	
 <cfif FORM.HasOrders NEQ 1>
	<cfif IsDefined('FORM.product_options')>
		<cfset productOptions = form.product_options>
	<cfelse>
		<cfset productOptions = "0">
	</cfif>

	<!--- If we've removed a product option, remove the related sku options --->
	<cfquery name="rsSQGetOptnRelIDs" datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
	  SELECT r.optn_rel_ID 
		FROM (tbl_skus s
		INNER JOIN tbl_skuoption_rel r
		ON s.SKU_ID = r.optn_rel_SKU_ID) 
		INNER JOIN tbl_skuoptions so
		ON so.option_ID = r.optn_rel_Option_ID
		WHERE s.SKU_ProductID = #FORM.product_ID#
		AND so.option_Type_ID IN (#productOptions#)
	</cfquery>
	<cfquery name="rsSQGetSKUIDs" datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
	  SELECT SKU_ID
		FROM tbl_skus
		WHERE SKU_ProductID = #FORM.product_ID#
	</cfquery> 
	<cfif (rsSQGetOptnRelIDs.RecordCount NEQ 0) AND (rsSQGetSKUIDs.RecordCount NEQ 0)  >
		<cfquery datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
		DELETE FROM tbl_skuoption_rel
		WHERE optn_rel_ID NOT IN (#ValueList(rsSQGetOptnRelIDs.optn_rel_ID)#)
		AND optn_rel_SKU_ID IN (#ValueList(rsSQGetSKUIDs.SKU_ID)#)
		</cfquery>
	</cfif>

	<!--- Delete Product Option Information --->
	<cfquery datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
	DELETE FROM tbl_prdtoption_rel
	WHERE optn_rel_Prod_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#FORM.product_ID#" />
	</cfquery>
	<cfif isdefined("form.product_options")>
		<!--- Add Selected Product Options --->
		<cfloop index="I" list="#FORM.product_options#">
			<cfquery name="updtProductOptions" datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
				INSERT INTO tbl_prdtoption_rel
				(optn_rel_Prod_ID, optn_rel_OptionType_ID)
				VALUES (#FORM.product_ID#, #I# )
			</cfquery>
		</cfloop>
	</cfif>
	
	</cfif> <!--- END IF - FORM.HasOrders NEQ 1 --->	
	<cflocation url="#request.ThisPageQS#&nextpage=#form.nextpage#" addtoken="no">
</cfif>
<!--- [ END ] Update Existing Product --->

<!--- =====  UPDATE SKU ===== --->
<!--- [ START ] Update SKU --->
<cfif IsDefined("FORM.UpdateSKU")>
	<!--- Set Default FORM values --->
	<cfparam name="FORM.SKU_Stock" default="0">
	<cfparam name="FORM.SKU_ShowWeb" default="NULL">
	<cfparam name="FORM.SKU_Sort" default="0">
  <cfquery datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
		UPDATE tbl_skus 
		SET 
			SKU_ProductID='#FORM.SKU_ProductID#', 
			SKU_Price=#makeSQLSafeNumber(FORM.SKU_Price)#, 
			SKU_Weight=#val(FORM.SKU_Weight)#, 
			SKU_Stock= #val(FORM.SKU_Stock)#, 
			SKU_ShowWeb= #val(FORM.SKU_ShowWeb)#, 
			SKU_Sort= #val(FORM.SKU_Sort)#
		WHERE SKU_ID=#val(FORM.sku_id)#
  </cfquery>
	<!--- DELETE current options ---> 
	<cfquery datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
		DELETE FROM tbl_skuoption_rel 
		WHERE optn_rel_sku_id=#FORM.sku_id#
	</cfquery>
	<!---  INSERT the new relationships  --->
	<!--- Loop throught the form collection and grab all of the chosen options --->
	<cfset strOptions = "">
	<cfloop collection="#FORM#" item="FieldName"> 
		<cfif Left(FieldName,9) EQ "selOption" AND FORM[FieldName] NEQ "choose">
			<cfset strOptions = ListAppend(strOptions, FORM[FieldName], ",")>
		</cfif>
	</cfloop>
	<cfloop index="I" list="#strOptions#">
		<cfquery name="updtSKUOptions" datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
			INSERT INTO tbl_skuoption_rel
			(optn_rel_sku_id, optn_rel_Option_ID)
			VALUES (#FORM.sku_id#, #I# )
		</cfquery>
	</cfloop>
	
	<cflocation url="#request.ThisPageQS#&nextpage=#form.nextpage#" addtoken="no">
</cfif>
<!--- [ END ] Update SKU --->

<!--- ===== ARCHIVE PRODUCT ===== --->
<!--- [ START ] Archive Product --->

<cfif IsDefined("FORM.ArchiveProduct")>
	<cfset Archive = "1">
	<cfquery name="archiveProduct" datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
	 UPDATE tbl_products
		SET product_Archive = '#Archive#'
		WHERE product_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#FORM.product_ID#" />
	</cfquery>
	<cflocation url="ProductArchive.cfm?nextpage=#form.nextpage#" addtoken="no">
</cfif>



<!--- Up-sell - Queries and actions for Cross Selling Produts --->
<!--- ADD Up-sell Action --->
<cfif IsDefined ('FORM.ADDUpSell')>
	<!--- Check for duplicate records --->
	<cfquery name="checkfordupes" datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
	SELECT upsell_id
	FROM tbl_prdtupsell
	WHERE upsell_ProdID = #FORM.product_ID#
	AND upsell_relProdID = #FORM.UpSellProduct_ID#
	</cfquery>
	<!--- If no duplicates, proceed --->
	<cfif checkfordupes.RecordCount EQ 0>
		<cfquery datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
		INSERT INTO tbl_prdtupsell (upsell_ProdID, upsell_relProdID) 
		VALUES (#FORM.product_ID#,#FORM.UpSellProduct_ID#)
		</cfquery>
		<cflocation url="#request.ThisPageQS#&nextpage=#form.nextpage#" addtoken="no">
		<cfelse>
		<!--- If a duplicate throw an error --->
		<cfquery name="checkfordupes" datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
		SELECT product_Name
		FROM tbl_products
		WHERE product_ID = #FORM.UpSellProduct_ID#
		</cfquery>
		<cfset variables.upsellProductIDError = "<strong>- #checkfordupes.product_Name# -</strong> is allready associated <br />with this Product. Record not added.">
	</cfif>  
</cfif>

<!--- DELETE Cross Sell Record --->
<cfif IsDefined("URL.delupsell_id")>
  <cfquery datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
  DELETE FROM tbl_prdtupsell WHERE upsell_id=#URL.delupsell_id#
  </cfquery>
</cfif>

<cfif IsDefined ('FORM.product_ID')>
  <cfset URL.product_ID = FORM.product_ID>
</cfif>

<!--- ===== END ===== --->
</cfsilent>