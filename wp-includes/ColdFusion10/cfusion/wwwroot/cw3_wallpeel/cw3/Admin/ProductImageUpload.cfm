<!--- 
================================================================
Application Info: Cartweaver© 2002 - 2007, All Rights Reserved.
Developer Info: Application Dynamics Inc.
                1560 NE 10th
                East Wenatchee, WA 98802
Support Info: http://www.cartweaver.com/go/cfhelp
				
Cartweaver Version: 3.0.9  -  Date: 2/18/2008
================================================================
Name: ProductImageUpload.cfm
Description: Uploads images to the appropriate folders and sets 
the name of the image in the records of the selected product.

Important Note: Some hosts choose to disable CFFILE functions. 
If this is the case this upload page will not function and 
images will have to be uploaded by other means.
================================================================
--->
<cfset imageType = 1>
<cfparam name="URL.result" default="">
<cfparam name="FORM.action" default="">
<cfset uploadError = "">

<cfif IsDefined("URL.type")>
	<cfset imageType = URL.type>
</cfif>

<cfif IsDefined("FORM.type")>
	<cfset imageType = FORM.type>
</cfif>

<!--- Set the proper values for the selected image type --->
<cfquery name="rsSelectedImageType" datasource="#Request.DSN#" username="#Request.DSNUsername#" password="#Request.DSNPassword#">
SELECT * FROM tbl_list_imagetypes
WHERE imgType_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#imageType#" />
</cfquery>

<cfset SiteFolderName = Application.SiteRoot & rsSelectedImageType.imgType_Folder />
<cfset DiskFolderPath = ExpandPath(SiteFolderName) />
<!--- Expand path not working locally --->
<cfset thisPath=ExpandPath("*.*")>
<cfset thisDirectory=GetDirectoryFromPath(thisPath)>
<cfset thisDirectory = ReplaceNoCase(thisDirectory, "\cw3\admin", "")>
<cfset thisDirectory = ReplaceNoCase(thisDirectory, "/cw3/admin", "")>
<cfset DiskFolderPath = thisDirectory & rsSelectedImageType.imgType_Folder>
<cfset ImageTextField = "Image" & ImageType />
<cfset CurrentImageName = rsSelectedImageType.imgType_Name />

<!--- Get all image types --->
<cfquery name="rsAllImageTypes" datasource="#Request.DSN#" username="#Request.DSNUsername#" password="#Request.DSNPassword#">
SELECT * FROM tbl_list_imagetypes
ORDER BY imgType_SortOrder, imgType_Name
</cfquery>

<cfswitch expression="#FORM.action#">

	<cfcase value="upload">
		<cfif IsDefined("FORM.VIEWIMAGES")>
			<!--- The user just wants to switch image categories --->
			<cflocation url="#Request.ThisPage#?type=#FORM.type#" addtoken="no" />
		
		<cfelse>
			<!--- Upload the image --->
			<cfset MaxSizeKB = "50">
			<cfset MaxSize = MaxSizeKB * 1024>
			<!--- Check for file size as reported by the HTTP header--->
			<cfif Val(CGI.CONTENT_LENGTH) GT MaxSize OR CGI.CONTENT_LENGTH EQ "">
				<cfif CGI.CONTENT_LENGTH EQ "">
					<cfset UploadError = "Your browser reported a badly-formed HTTP header. This could be caused by an error, a bug in your browser or the settings on your proxy/firewall">
				<cfelse>
					<cfset UploadError = "The selected file's size is greater than " & #MaxSizeKB# & " kilobytes which is the maximum size allowed, please select another image and try again.">
				</cfif>
			<cfelse>
				<cftry>
					<cffile action="upload" filefield="file" destination="#DiskFolderPath#" nameconflict="MakeUnique" accept="image/*">
					<!--- Get the file name --->
					<cfset fileName = cffile.clientFile>
					<cfif fileName NEQ cffile.serverFile>
						<cfset UploadError = "Duplicate">
					<cfelse>
						<cflocation url="#Request.Thispage#?result=The file #fileName# has been successfully uploaded.&file=#fileName#&type=#imageType#" addtoken="no">
					</cfif>
					<!--- If the file upload failed --->
					<cfcatch type="Any">
						<cfset UploadError = "<p>An error occurred during the file upload process. This is likely due to one of the reasons below:</p><ol><li>The MIME type of the uploaded file was not accepted by the server. Please verify that you are uploading a file of the appropriate type.</li><li>The folder specified for the image type doesn't exist on the server.</li><li>The application doesn't have the correct permissions on the server.</li></ol><p>If the problem persist, please contact the website's administrator.</p>">
					</cfcatch>
				</cftry>
			</cfif>
		</cfif>
	</cfcase>

	<cfcase value="confirmOverwrite">
	<cfif FORM.choose EQ "Yes">
		<!--- Overwrite the older file --->
		<!--- First, delete the old file --->
		<cffile action="delete" file="#DiskFolderPath##FORM.file#">
		<!--- Rename the new file --->
		<cffile action="rename" source="#DiskFolderPath##FORM.tempfile#" destination="#DiskFolderPath##FORM.file#">
		<cfset fileName = FORM.file>
		<cfset UploadError = "">
		<cflocation url="#Request.ThisPage#?result=The file #FORM.file# has been successfully uploaded.&file=#FORM.file#&type=#imageType#" addtoken="no">
	<cfelse>
		<!--- Delete the new file --->
		<cffile action="delete" file="#DiskFolderPath##FORM.tempfile#">
		<cfset UploadError = "">
		<cflocation url="#Request.ThisPage#?type=#imageType#" addtoken="no">
	</cfif>
	</cfcase>

	<cfcase value="delete">
	<!--- User has selected to delete an image --->
	<cfset deleteName = "">
	<cfset imageList = "">
	<cfset deleteImage = "">
	<cfif IsDefined("Form.confirmdelete")>
		<cfset deleteImage = True>
		<cfset deleteName = Form.image>
	<cfelse>
		<cfset deleteName = FORM.ImageList />
		<!--- Check to see if this image is currently associated with any products --->
		<cfquery name="rsCWCheckImage" datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
		SELECT tbl_products.product_Name, tbl_products.product_MerchantProductID 
		FROM tbl_products INNER JOIN tbl_prdtimages ON tbl_products.product_ID = tbl_prdtimages.prdctImage_ProductID 
		WHERE 
			tbl_prdtimages.prdctImage_FileName = <cfqueryparam cfsqltype="cf_sql_varchar" value="#deleteName#" />
			AND tbl_prdtimages.prdctImage_ImgTypeID = <cfqueryparam cfsqltype="cf_sql_integer" value="#imageType#" />
		</cfquery>
		<cfif rsCWCheckImage.RecordCount NEQ 0>
			<!--- There are products associated with this image --->
			<cfset productList = "<ul>">
			<cfoutput query="rsCWCheckImage">
				<cfset productList = productList & "<li>" & rsCWCheckImage.product_Name & " (" & rsCWCheckImage.product_MerchantProductID & ")</li>">
			</cfoutput>
			<cfset productList = productList & "</ul>">
			<cfset deleteImage = False>
		<cfelse>
			<!--- No products, delete the image --->
			<cfset deleteImage = True>
		</cfif>
	</cfif>

	<cfif deleteImage>
		<!--- Remove the entry from the database first to prevent a potential broken image --->
		<cfquery datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
		DELETE FROM tbl_prdtimages WHERE prdctImage_FileName = '#deleteName#' AND prdctImage_ImgTypeID = #imageType#
		</cfquery>
		<!--- Delete the file --->
		<cffile action="delete" file="#DiskFolderPath##deleteName#">
		<cflocation url="#Request.ThisPage#?type=#imageType#&result=The file #deleteName# has been deleted.&deletedfile=#deleteName#" addtoken="no">
	</cfif>
	</cfcase>
</cfswitch>
<!--- [ END IF ] IsDefined("FORM.file") AND FORM.file NEQ "" --->

<!--- Get a list of files from the image folders --->
<cfdirectory action="list" directory="#DiskFolderPath#" name="ImageList">
<cfset ImageOptions = "">
<cfoutput query="ImageList">
	<cfif type EQ "File">
		<cfset ImageOptions = ImageOptions & "<option value=""#Name#"">#Name#</option>">
	</cfif>
</cfoutput>

<!--- Set necessary onload events --->
<cfset onloadEvents = "">

<cfif IsDefined("URL.file")>
	<cfset onloadEvents = onloadEvents & "updateImages('#imageType#','#SiteFolderName#/#URL.file#','#imageTextField#','#URL.file#');">
</cfif>

<cfif IsDefined("URL.deletedfile")>
	<cfset onloadEvents = onloadEvents & "checkDeletedImage('#imageType#','#SiteFolderName#','#imageTextField#','#URL.deletedfile#');">
</cfif>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>CW Admin: Product Image Upload</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="assets/admin.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="assets/global.js"></script>
<script language="JavaScript" type="text/JavaScript">
<!--
function updateImages(imgType,imageSRC,txtField,imageName) {
  eval("self.opener.document.productform." + txtField + ".value='"+imageName+"'");
	var obj = eval("self.opener.document.productform.image"+imgType);
	obj.src = imageSRC;
	obj.alt = 'Image path: '+imageSRC;
	obj.style.display = 'inline';
}

function updateExisting(imgType, imgSelect, imageSRC, txtField){
	var sel = MM_findObj(imgSelect);
	if(sel.selectedIndex!=-1){
		var imageName = sel.options[sel.selectedIndex].value;
		updatePreview(imageName, imageSRC, imgType);
		updateImages(imgType,imageSRC+imageName,txtField,imageName);
		MM_findObj('selectImage').value='Image Set'
	}else{
		alert("Please select an image.")
	}
}

function updatePreview(imageName,imageSRC){
	MM_findObj('imagePreview').src=imageSRC+"/"+imageName;
	MM_findObj('selectImage').value="Select Image";
}

function tmt_confirm(msg){
	document.MM_returnValue=(confirm(unescape(msg)));
}

function checkDeletedImage(imgType,imageSRC,txtField,imageName){
	var parentImage = eval("self.opener.document.productform." + txtField + ".value");
	if(parentImage == imageName){
		updateImages(imgType,imageSRC,txtField,'');
	}
}
//-->
</script>
</head>
<body onload="<cfoutput>#onloadEvents#</cfoutput>">
<div id="divMainContent" style="margin-left: 10px;">
	<h1>Product Image Upload</h1>
	<cfif UploadError EQ "Duplicate">
		<form action="<cfoutput>#request.ThisPageQS#</cfoutput>" method="post" name="confirm">
			<p>Do you want to overwrite this file?</p>
			<input name="choose" type="submit" class="formButton" id="choose" value="Yes" />
			<input name="choose" type="submit" class="formButton" id="choose" value="No" />
			<input type="hidden" name="file" value="<cfoutput>#fileName#</cfoutput>" />
			<input type="hidden" name="tempFile" value="<cfoutput>#cffile.serverFile#</cfoutput>" />
			<input type="hidden" name="type" value="<cfoutput>#FORM.type#</cfoutput>" />
			<input type="hidden" name="action" value="confirmOverwrite">
		</form>
	<cfelse>
		<cfif FORM.action NEQ "confirmOverwrite">
			<cfif FORM.action NEQ "delete">
				<cfif UploadError NEQ "">
					<p><strong><cfoutput>#UploadError#</cfoutput></strong></p>
				</cfif>
				<cfif URL.result NEQ "">
					<p><cfoutput>#URL.result#</cfoutput></p>
				</cfif>
				<form action="<cfoutput>#request.ThisPage#</cfoutput>" method="post" enctype="multipart/form-data" name="FileUploader" id="FileUploader">
					<table style="width: 406px;">
						<tr>
							<th>Choose Image Type </th>
							<th>Upload Image </th>
						</tr>
						<tr>
							<td width="100%">
								<select style="width: 100%;" name="type" id="type">
									<cfoutput query="rsAllImageTypes">
										<option<cfif imageType EQ rsAllImageTypes.imgType_ID> selected="selected"</cfif> value="#rsAllImageTypes.imgType_ID#">#rsAllImageTypes.imgType_Name#</option>
									<br />
									</cfoutput>
								</select>
								<input name="viewImages" type="submit" class="formButton" value="View Images" style="margin-top: 3px;" />
							</td>
							<td align="right"><input name="file" type="file">
								<br />
								<input name="Submit" type="submit" class="formButton" value="Upload Image" style="margin-top: 3px;" />
								<input type="hidden" name="action" value="upload" /></td>
						</tr>
					</table>
				</form>
				<form action="<cfoutput>#Request.ThisPageQS#</cfoutput>" method="post" name="frmImages" id="frmImages">
					<table>
						<caption>
						Select Existing Image
						</caption>
						<tr>
							<th scope="col"><cfoutput>#CurrentImageName#</cfoutput> Images </th>
						</tr>
						<tr>
							<td align="right" scope="col"><cfif ImageOptions EQ "">
									<p>There are currently no <cfoutput>#CurrentImageName#</cfoutput> images uploaded.</p>
									<cfelse>
									<select style="width: 400px; margin-bottom: 3px;" name="ImageList" size="10" id="ImageList" onchange="updatePreview(this.value,'<cfoutput>#SiteFolderName#</cfoutput>');">
										<cfoutput>#ImageOptions#</cfoutput>
									</select>
									<br />
									<cfoutput><input name="selectImage" type="button" class="formButton" id="selectImage" onclick="updateExisting('#ImageType#', 'ImageList', '#SiteFolderName#', '#ImageTextField#');" value="Select Image" /></cfoutput>
									<input type="submit" class="formButton" onclick="tmt_confirm('Are%20you%20sure%20you%20want%20to%20delete%20this%20image?');return document.MM_returnValue" value="Delete Image" />
									<input name="action" type="hidden" id="action" value="delete">
								</cfif></td>
					</table>
					<p>Image Preview:<br />
						<img src="" alt="Choose an image to preview" id="imagePreview" /></p>
				</form>
			<cfelse>
				<p>This image is associated with the following products:</p>
				<cfoutput>#productList#</cfoutput>
				<p>Do you still want to delete this image?</p>
				<form action="<cfoutput>#Request.ThisPage#</cfoutput>" method="post" name="frmDelete" id="frmDelete">
					<input name="confirmdelete" type="submit" class="formButton" id="confirmdelete" value="Yes" />
					<input type="button" value="No" class="formButton" onclick="javascript:history.go(-1);" />
					<input name="type" type="hidden" id="type" value="<cfoutput>#imageType#</cfoutput>" />
					<input type="hidden" name="image" value="<cfoutput>#deleteName#</cfoutput>" />
					<input name="action" type="hidden" id="action" value="delete" />
				</form>
			</cfif>
		</cfif>
		<p style="text-align: right;"><a href="javascript:window.close();">Close Window</a></p>
	</cfif>
</div>
</body>
</html>
