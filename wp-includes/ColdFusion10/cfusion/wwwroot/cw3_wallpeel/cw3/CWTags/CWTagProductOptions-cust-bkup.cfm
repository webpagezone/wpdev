<cfprocessingdirective suppresswhitespace="yes">
	<!---
		================================================================
		Application Info: Cartweaver© 2002 - 2007, All Rights Reserved.
		Developer Info: Application Dynamics Inc.
		1560 NE 10th
		East Wenatchee, WA 98802
		Support Info: http://www.cartweaver.com/go/cfhelp
		Cartweaver Version: 3.0.13  -  Date: 7/25/2008
		================================================================
		Name: CWTagProductOptions
		Description:
		Use the CWTagProductOptions custom tag to add cross tab tables
		or list menus for individual product options. If DetailsDisplay
		is set to "Tables", a crosstab table is displayed with
		every possible combination of options, making it easy for a
		customer to find what they're looking for. If 2 or more options are
		available, and you've set the Advanced Display option, then
		the list menus will be dependent on one other, making
		sure the user can't select an invalid combination. If you are
		using the "Simple" Display, then the list menus will not be
		dependent on each other, and all checking will be handled once
		the page is submitted. If there	is only one option, then just
		the prices are displayed.
		The custom tag takes 2 arguments.
		product_id: The product ID to display.
		product_id = "#request.Product_ID#"
		fielderror: Any errors passed from the calling page.
		fielderror = "#FieldError#"
		<cfmodule
		template="CWTags/CWTagProductOptions.cfm"
		product_id = "#request.Product_ID#"
		fielderror = "#FieldError#"
		>
		================================================================
		--->
	<cfif Not IsDefined("cwAltRows") OR Not IsCustomFunction(cwAltRows)>
		<cfinclude template="CWIncFunctions.cfm" />
	</cfif>
	<cfif Not IsDefined("cwGetDiscountObject") OR Not IsCustomFunction(cwGetDiscountObject)>
		<cfinclude template="CWIncDiscountFunctions.cfm">
	</cfif>
	<cfparam name="fielderror" default="">
	<cfparam name="NumOptions" default="0">
	<cfparam name="TaxRate" default="" />


	<cfquery name="rsGetProductOptions" datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
		SELECT
        tbl_prdtoption_rel.optn_rel_OptionType_ID,
        tbl_list_optiontypes.optiontype_Name

        FROM tbl_prdtoption_rel
        Inner join tbl_list_optiontypes
        ON tbl_list_optiontypes.optiontype_ID = tbl_prdtoption_rel.optn_rel_OptionType_ID

        WHERE optn_rel_Prod_ID = #attributes.Product_ID#

	</cfquery>



    <cfif rsGetProductOptions.recordcount GT 0>

<!--- get discount information currently available --->
		<cfset discount = cwGetDiscountObject()>
		<cfset cwGetDiscounts()>

	    <cfset intOptionCount = rsGetProductOptions.recordcount>


	<cfparam  name ="option_type"  default="">


	<cfloop query="rsGetProductOptions">

		<cfset option_type = #rsGetProductOptions.optn_rel_OptionType_ID#>


<div id="option-types">
<table>
		<cfif option_type eq 5 >
			<!--- we have tshirt comfort colors --->
			<cfquery name="rsTshirtCBuild" datasource="#request.dsn#" username="#request.dsnusername#" password="#request.dsnpassword#">
            SELECT option_ID,option_Name,option_FileName,option_Hex,option_FileName,option_Sort,option_Archive, option_Type_ID
            FROM tbl_skuoptions
            WHERE option_Type_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#option_type#" />
            AND option_Archive = 0

			</cfquery>




            <!---<tr>
                <td>

                </td>
                <td>
                    <select name="TeeColor" id="TeeColor">
                        <option value="0">
                            Choose...
                        </option>
                        <cfoutput query="rsTshirtCBuild" >
                            <option value="#option_ID#">
                                #option_Name#
                            </option>
                        </cfoutput>
                    </select>
                </td>
            </tr>--->


                            <!---<option value="#option_ID#">
                                #option_Name#
                            </option>--->

              <div class="form-group required">
                <label class="control-label"><cfoutput>#rsGetProductOptions.optiontype_Name#</cfoutput></label>

                <cfoutput query="rsTshirtCBuild" >

                <div id="input-option238">
                   <div class="radio texture">
                    <!---<label>
                      <input type="radio"
                      optionid="#option_ID#"
                      style="background-color:#option_Hex#"
                      imagelink="http://localhost/wallpeel2101/image/cache/catalog/oracal631/white-50x50.png"
                      name="option[238]"
                      src="http://localhost/wallpeel2101/image/cache/catalog/oracal631/white-228x228.png"
                      src-colorbox="http://localhost/wallpeel2101/image/cache/catalog/oracal631/white-500x500.png"
                      value="504">
                      <img src="http://localhost/wallpeel2101/image/cache/catalog/oracal631/white-50x50.png"
                      alt="#option_Name#"
                      class="img-thumbnail">
                      <span>#option_Name#</span>
                     </label>--->

					<!---
					<cfoutput query="rsSelectBuild" group="optiontype_Name">
						<tr>
							<td>
								#optiontype_Name#:
							</td>
							<td>
								<select name="sel" id="sel#i#">
									<option value="0">
										Choose #optiontype_Name#...
									</option>
									<cfoutput>
										<option value="#option_id#">
											#option_Name#
										</option>
									</cfoutput>
								</select>
							</td>
						</tr>
						<cfset i = i + 1 />
					</cfoutput> --->


                     <label style="width:50px;height:50px; background:#option_Hex#">
                      <input type="radio"
                      optionid="#option_ID#"

                       name="#option_ID#"
                       value="#option_ID#">

                      <span>#option_Name#</span>
                     </label>
                  </div>

               </div>
               </cfoutput>

			<input type="hidden" name="" value="">
           </div>

		</cfif>
<<></>></<></>>
		<cfif option_type eq 1 >
			<!--- we have tshirt comfort colors --->
			we have size

            <!--- we have tshirt comfort colors --->
			<cfquery name="rsSizeBuild" datasource="#request.dsn#" username="#request.dsnusername#" password="#request.dsnpassword#">
            SELECT option_ID,option_Name,option_FileName,option_Hex,option_FileName,option_Sort,option_Archive, option_Type_ID
            FROM tbl_skuoptions
            WHERE option_Type_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#option_type#" />
            AND option_Archive = 0

			</cfquery>
            <tr>
                <td>
                    <cfoutput>#rsGetProductOptions.optiontype_Name#</cfoutput>
                </td>
                <td>
                    <select name="Size" id="Size">
                        <option value="0">
                            Choose...
                        </option>
                        <cfoutput query="rsSizeBuild" >
                            <option value="#option_ID#">
                                #option_Name#
                            </option>
                        </cfoutput>
                    </select>
                </td>
            </tr>

		</cfif>

	</cfloop>



				<cfif attributes.FieldError NEQ "">
					<cfset intQuantity = FORM.qty>
				<cfelse>
					<cfset intQuantity = 1>
				</cfif>

					<tr>
						<td>
							Qty:
						</td>
						<td>
							<input name="qty" type="text" value="<cfoutput>#intQuantity#</cfoutput>" size="2">
						</td>
					</tr>
				</table>
</div>
	</cfif>
</cfprocessingdirective>
<script type="text/javascript"><!--
			$("a.color-option").click(function(event)
			{
				$this = $(this);

				// highlight current color box
				$this.parent().find('a.color-option').removeClass('color-active');
				$this.addClass('color-active');

				$('#' + $this.attr('option-text-id')).html($this.attr('title'));

				// trigger selection event on hidden select
				$select = $this.parent().find('select');

				$select.val($this.attr('optval'));
				$select.trigger('change');

				//option redux
				if(typeof updatePx == 'function') {
					updatePx();
				}

				//option boost
				if(typeof obUpdate == 'function') {
					obUpdate($($this.parent().find('select option:selected')), useSwatch);
				}

				if(typeof myocLivePriceUpdate == 'function') {
					myocLivePriceUpdate();
				}

				event.preventDefault();
			});

			$("a.color-option").parent('.option').find('.hidden select').change(function()
			{
				$this = $(this);
				var optionValueId = $this.val();
				$colorOption = $('a#color-option-' + optionValueId);
				if(!$colorOption.hasClass('color-active'))
					$colorOption.trigger('click');
			});
			//--></script>