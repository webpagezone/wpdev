
<!DOCTYPE html>


<html dir="ltr" lang="en">
<head>
<meta charset="UTF-8" />
<title>Products</title>
<base href="http://localhost/oc15/admin/" />
<link rel="stylesheet" type="text/css" href="view/stylesheet/stylesheet.css" />
<!--BOF Product Color Option-->
			<link rel="stylesheet" type="text/css" href="view/stylesheet/pco.css" />
			<!--EOF Product Color Option-->
<script type="text/javascript" src="view/javascript/jquery/jquery-1.7.1.min.js"></script>
<script type="text/javascript" src="view/javascript/jquery/ui/jquery-ui-1.8.16.custom.min.js"></script>
<link type="text/css" href="view/javascript/jquery/ui/themes/ui-lightness/jquery-ui-1.8.16.custom.css" rel="stylesheet" />
<script type="text/javascript" src="view/javascript/jquery/tabs.js"></script>
<script type="text/javascript" src="view/javascript/jquery/superfish/js/superfish.js"></script>
<script type="text/javascript" src="view/javascript/common.js"></script>
<script type="text/javascript">
//-----------------------------------------
// Confirm Actions (delete, uninstall)
//-----------------------------------------
$(document).ready(function(){
    // Confirm Delete
    $('#form').submit(function(){
        if ($(this).attr('action').indexOf('delete',1) != -1) {
            if (!confirm('Delete/Uninstall cannot be undone! Are you sure you want to do this?')) {
                return false;
            }
        }
    });
    // Confirm Uninstall
    $('a').click(function(){
        if ($(this).attr('href') != null && $(this).attr('href').indexOf('uninstall', 1) != -1) {
            if (!confirm('Delete/Uninstall cannot be undone! Are you sure you want to do this?')) {
                return false;
            }
        }
    });
        });
    </script>
<!--BOF PICW-->
			<link rel="stylesheet" type="text/css" href="view/stylesheet/picw.css" />
			<!--EOF PICW-->

</head>
<body>
<div id="container">

<div id="content">

    <div class="box">
    <div class="heading">
      <h1><img src="view/image/product.png" alt="" /> Products</h1>
      <div class="buttons"><a onclick="$('#form').submit();" class="button">Save</a><a href="http://localhost/oc15/admin/index.php?route=catalog/product&amp;token=c6157d95819e6b8448266a5411210929" class="button">Cancel</a></div>
    </div>
    <div class="content">
      <div id="tabs" class="htabs"><a href="#tab-general">General</a><a href="#tab-data">Data</a><a href="#tab-links">Links</a><a href="#tab-attribute">Attribute</a><a href="#tab-option">Option</a><a href="#tab-profile">Profiles</a><a href="#tab-discount">Discount</a><a href="#tab-special">Special</a><a href="#tab-image">Image</a><a href="#tab-reward">Reward Points</a><a href="#tab-design">Design</a><a href="#tab-picw">SVG</a></div>
      <form action="http://localhost/oc15/admin/index.php?route=catalog/product/update&amp;token=c6157d95819e6b8448266a5411210929&amp;product_id=50" method="post" enctype="multipart/form-data" id="form">
        <div id="tab-general">
          <div id="languages" class="htabs">
                        <a href="#language1"><img src="view/image/flags/gb.png" title="English" /> English</a>
                      </div>
                    <div id="language1">
            <table class="form">
              <tr>
                <td><span class="required">*</span> Product Name:</td>
                <td><input type="text" name="product_description[1][name]" size="100" value="butterfly" />
                  </td>
              </tr>
              <tr>
                <td>Meta Tag Description:</td>
                <td><textarea name="product_description[1][meta_description]" cols="40" rows="5">butterfly</textarea></td>
              </tr>
              <tr>
                <td>Meta Tag Keywords:</td>
                <td><textarea name="product_description[1][meta_keyword]" cols="40" rows="5">butterfly</textarea></td>
              </tr>
              <tr>
                <td>Description:</td>
                <td><textarea name="product_description[1][description]" id="description1">&lt;p&gt;&lt;span style=&quot;color: rgb(0, 0, 0); font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 10px; line-height: 17px; text-align: justify;&quot;&gt;Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat. Ut wisi enim ad minim veniam, quis nostrud exerci tation ullamcorper suscipit lobortis nisl ut aliquip ex ea commodo consequat. Duis autem vel eum iriure dolor in hendrerit in vulputate velit esse molestie consequat, vel illum dolore eu feugiat nulla facilisis at vero eros et accumsan et iusto odio dignissim qui blandit praesent luptatum zzril delenit augue duis dolore te feugait nulla facilisi. Nam liber tempor cum soluta nobis eleifend option congue nihil imperdiet doming id quod mazim placerat facer possim assum. Typi non habent claritatem insitam; est usus legentis in iis qui facit eorum claritatem. Investigationes demonstraverunt lectores legere me lius quod ii legunt saepius. Claritas est etiam processus dynamicus, qui sequitur mutationem consuetudium lectorum. Mirum est notare quam littera gothica, quam nunc putamus parum claram, anteposuerit litterarum formas humanitatis per seacula quarta decima et quinta decima. Eodem modo typi, qui nunc nobis videntur parum clari, fiant sollemnes in futurum.&lt;/span&gt;&lt;/p&gt;
</textarea></td>
              </tr>
              <tr>
                <td>Product Tags:<br /><span class="help">comma separated</span></td>
                <td><input type="text" name="product_description[1][tag]" value="" size="80" /></td>
              </tr>
            </table>
          </div>
                  </div>
        <div id="tab-data">
          <table class="form">
            <tr>
              <td><span class="required">*</span> Model:</td>
              <td><input type="text" name="model" value="12345" />
                </td>
            </tr>
            <tr>
              <td>SKU:<br/><span class="help">Stock Keeping Unit</span></td>
              <td><input type="text" name="sku" value="" /></td>
            </tr>
            <tr>
              <td>UPC:<br/><span class="help">Universal Product Code</span></td>
              <td><input type="text" name="upc" value="" /></td>
            </tr>
            <tr>
              <td>EAN:<br/><span class="help">European Article Number</span></td>
              <td><input type="text" name="ean" value="" /></td>
            </tr>
            <tr>
              <td>JAN:<br/><span class="help">Japanese Article Number</span></td>
              <td><input type="text" name="jan" value="" /></td>
            </tr>
            <tr>
              <td>ISBN:<br/><span class="help">International Standard Book Number</span></td>
              <td><input type="text" name="isbn" value="" /></td>
            </tr>
            <tr>
              <td>MPN:<br/><span class="help">Manufacturer Part Number</span></td>
              <td><input type="text" name="mpn" value="" /></td>
            </tr>
            <tr>
              <td>Location:</td>
              <td><input type="text" name="location" value="" /></td>
            </tr>
            <tr>
                <td>Price:</td>
                <td><input type="text" name="price" value="100.0000" /></td>
            </tr>
            <tr>
              <td>Tax Class:</td>
              <td><select name="tax_class_id">
                  <option value="0"> --- None --- </option>
                                                      <option value="9">Taxable Goods</option>
                                                                        <option value="10">Downloadable Products</option>
                                                    </select></td>
            </tr>
            <tr>
              <td>Quantity:</td>
              <td><input type="text" name="quantity" value="1" size="2" /></td>
            </tr>
            <tr>
              <td>Minimum Quantity:<br/><span class="help">Force a minimum ordered amount</span></td>
              <td><input type="text" name="minimum" value="1" size="2" /></td>
            </tr>
            <tr>
              <td>Subtract Stock:</td>
              <td><select name="subtract">
                                    <option value="1">Yes</option>
                  <option value="0" selected="selected">No</option>
                                  </select></td>
            </tr>
            <tr>
              <td>Out Of Stock Status:<br/><span class="help">Status shown when a product is out of stock</span></td>
              <td><select name="stock_status_id">
                                                      <option value="6">2 - 3 Days</option>
                                                                        <option value="7">In Stock</option>
                                                                        <option value="5" selected="selected">Out Of Stock</option>
                                                                        <option value="8">Pre-Order</option>
                                                    </select></td>
            </tr>
            <tr>
              <td>Requires Shipping:</td>
              <td>                <input type="radio" name="shipping" value="1" checked="checked" />
                Yes                <input type="radio" name="shipping" value="0" />
                No                </td>
            </tr>
            <tr>
              <td>SEO Keyword:<br /><span class="help">Do not use spaces instead replace spaces with - and make sure the keyword is globally unique.</span></td>
              <td><input type="text" name="keyword" value="tree" /></td>
            </tr>
            <tr>
              <td>Image:</td>
              <td><div class="image"><img src="http://localhost/oc15/image/cache/no_image-100x100.jpg" alt="" id="thumb" /><br />
                  <input type="hidden" name="image" value="" id="image" />
                  <a onclick="image_upload('image', 'thumb');">Browse</a>&nbsp;&nbsp;|&nbsp;&nbsp;<a onclick="$('#thumb').attr('src', 'http://localhost/oc15/image/cache/no_image-100x100.jpg'); $('#image').attr('value', '');">Clear</a></div></td>
            </tr>
            <tr>
              <td>Date Available:</td>
              <td><input type="text" name="date_available" value="2014-11-20" size="12" class="date" /></td>
            </tr>
            <tr>
              <td>Dimensions (L x W x H):</td>
              <td><input type="text" name="length" value="0.00000000" size="4" />
                <input type="text" name="width" value="0.00000000" size="4" />
                <input type="text" name="height" value="0.00000000" size="4" /></td>
            </tr>
            <tr>
              <td>Length Class:</td>
              <td><select name="length_class_id">
                                                      <option value="1" selected="selected">Centimeter</option>
                                                                        <option value="2">Millimeter</option>
                                                                        <option value="3">Inch</option>
                                                    </select></td>
            </tr>
            <tr>
              <td>Weight:</td>
              <td><input type="text" name="weight" value="0.00000000" /></td>
            </tr>
            <tr>
              <td>Weight Class:</td>
              <td><select name="weight_class_id">
                                                      <option value="1" selected="selected">Kilogram</option>
                                                                        <option value="2">Gram</option>
                                                                        <option value="5">Pound </option>
                                                                        <option value="6">Ounce</option>
                                                    </select></td>
            </tr>
            <tr>
              <td>Status:</td>
              <td><select name="status">
                                    <option value="1" selected="selected">Enabled</option>
                  <option value="0">Disabled</option>
                                  </select></td>
            </tr>
            <tr>
              <td>Sort Order:</td>
              <td><input type="text" name="sort_order" value="1" size="2" /></td>
            </tr>
          </table>
        </div>
        <div id="tab-links">
          <table class="form">
            <tr>
              <td>Manufacturer:<br /><span class="help">(Autocomplete)</span></td>
              <td><input type="text" name="manufacturer" value="" /><input type="hidden" name="manufacturer_id" value="0" /></td>
            </tr>
            <tr>
              <td>Categories:<br /><span class="help">(Autocomplete)</span></td>
              <td><input type="text" name="category" value="" /></td>
            </tr>
            <tr>
              <td>&nbsp;</td>
              <td><div id="product-category" class="scrollbox">
                                                                        <div id="product-category59" class="even">Trees<img src="view/image/delete.png" alt="" />
                    <input type="hidden" name="product_category[]" value="59" />
                  </div>
                                  </div></td>
            </tr>
            <tr>
              <td>Filters:<br /><span class="help">(Autocomplete)</span></td>
              <td><input type="text" name="filter" value="" /></td>
            </tr>
            <tr>
              <td>&nbsp;</td>
              <td><div id="product-filter" class="scrollbox">
                                                    </div></td>
            </tr>
            <tr>
              <td>Stores:</td>
              <td><div class="scrollbox">
                                    <div class="even">
                                        <input type="checkbox" name="product_store[]" value="0" checked="checked" />
                    Default                                      </div>
                                  </div></td>
            </tr>
            <tr>
              <td>Downloads:<br /><span class="help">(Autocomplete)</span></td>
              <td><input type="text" name="download" value="" /></td>
            </tr>
            <tr>
              <td>&nbsp;</td>
              <td><div id="product-download" class="scrollbox">
                                                    </div></td>
            </tr>
            <tr>
              <td>Related Products:<br /><span class="help">(Autocomplete)</span></td>
              <td><input type="text" name="related" value="" /></td>
            </tr>
            <tr>
              <td>&nbsp;</td>
              <td><div id="product-related" class="scrollbox">
                                                    </div></td>
            </tr>
          </table>
        </div>
        <div id="tab-attribute">
          <table id="attribute" class="list">
            <thead>
              <tr>
                <td class="left">Attribute:</td>
                <td class="left">Text:</td>
                <td></td>
              </tr>
            </thead>
                                    <tfoot>
              <tr>
                <td colspan="2"></td>
                <td class="left"><a onclick="addAttribute();" class="button">Add Attribute</a></td>
              </tr>
            </tfoot>
          </table>
        </div>
        <div id="tab-option">
          <div id="vtab-option" class="vtabs">
                        <input type="hidden" id="option-0" value="color"/>
            <a href="#tab-option-0" id="option-0">color hex bg&nbsp;<img src="view/image/delete.png" alt="" onclick="$('#option-0').remove(); $('#tab-option-0').remove(); $('#vtabs a:first').trigger('click'); return false;" /></a>
                        <input type="hidden" id="option-1" value="color"/>
            <a href="#tab-option-1" id="option-1">color box hex 2&nbsp;<img src="view/image/delete.png" alt="" onclick="$('#option-1').remove(); $('#tab-option-1').remove(); $('#vtabs a:first').trigger('click'); return false;" /></a>
                                    <span id="option-add">
            <input name="option" value="" style="width: 130px;" />
            &nbsp;<img src="view/image/add.png" alt="Add Option" title="Add Option" /></span></div>
                                        <div id="tab-option-0" class="vtabs-content">
            <input type="hidden" name="product_option[0][product_option_id]" value="227" />
            <input type="hidden" name="product_option[0][name]" value="color hex bg" />
            <input type="hidden" name="product_option[0][option_id]" value="14" />
            <input type="hidden" name="product_option[0][type]" value="color" />
            <table class="form">
              <tr>
                <td>Required:</td>
                <td><select name="product_option[0][required]">
                                        <option value="1" selected="selected">Yes</option>
                    <option value="0">No</option>
                                      </select></td>
              </tr>
                                                                                                </table>
                        <table id="option-value0" class="list">
              <thead>
                <tr>
                  <td class="left">Option Value:</td>
                  <td class="right">Quantity:</td>
                  <td class="left">Subtract Stock:</td>
                  <td class="right">Price:</td>
                  <td class="right">Points:</td>
                  <td class="right">Weight:</td>

                        <td class="right">Image:</td>
                              <td></td>
                </tr>
              </thead>
                            <tbody id="option-value-row0">
                <tr>
                  <td class="left"><select name="product_option[0][product_option_value][0][option_value_id]">
                                                                                        <option value="52">yellow</option>
                                                                                        <option value="53">red</option>
                                                                                        <option value="54" selected="selected">blue</option>
                                                                                      </select>
                    <input type="hidden" name="product_option[0][product_option_value][0][product_option_value_id]" value="19" /></td>
                  <td class="right"><input type="text" name="product_option[0][product_option_value][0][quantity]" value="0" size="3" /></td>
                  <td class="left"><select name="product_option[0][product_option_value][0][subtract]">
                                            <option value="1">Yes</option>
                      <option value="0" selected="selected">No</option>
                                          </select></td>
                  <td class="right"><select name="product_option[0][product_option_value][0][price_prefix]">
                                            <option value="+" selected="selected">+</option>
                                                                  <option value="-">-</option>
                                          </select>
                    <input type="text" name="product_option[0][product_option_value][0][price]" value="0.0000" size="5" /></td>
                  <td class="right"><select name="product_option[0][product_option_value][0][points_prefix]">
                                            <option value="+" selected="selected">+</option>
                                                                  <option value="-">-</option>
                                          </select>
                    <input type="text" name="product_option[0][product_option_value][0][points]" value="0" size="5" /></td>
                  <td class="right"><select name="product_option[0][product_option_value][0][weight_prefix]">
                                            <option value="+" selected="selected">+</option>
                                                                  <option value="-">-</option>
                                          </select>
                    <input type="text" name="product_option[0][product_option_value][0][weight]" value="0.00000000" size="5" /></td>
<!--start option image-->

                        <td><div class="image">
                        <img src="http://localhost/oc15/image/cache/no_image-100x100.jpg" id="thumb19"/>
                           </br>
                           <input type="hidden" name="product_option[0][product_option_value][0][image]" value="" id="image19" />
                            <a onclick="image_upload('image19', 'thumb19');">Browse</a>
                            &nbsp;|&nbsp;
                            <a onclick="$('#thumb19').attr('src', 'http://localhost/oc15/image/cache/no_image-100x100.jpg'); $('#image19').attr('value', '');">Clear</a>
                        </div></td>
                                                <!--end option image-->
                  <td class="left"><a onclick="$('#option-value-row0').remove();" class="button">Remove</a></td>
                </tr>
              </tbody>
                                          <tbody id="option-value-row1">
                <tr>
                  <td class="left"><select name="product_option[0][product_option_value][1][option_value_id]">
                                                                                        <option value="52" selected="selected">yellow</option>
                                                                                        <option value="53">red</option>
                                                                                        <option value="54">blue</option>
                                                                                      </select>
                    <input type="hidden" name="product_option[0][product_option_value][1][product_option_value_id]" value="17" /></td>
                  <td class="right"><input type="text" name="product_option[0][product_option_value][1][quantity]" value="0" size="3" /></td>
                  <td class="left"><select name="product_option[0][product_option_value][1][subtract]">
                                            <option value="1">Yes</option>
                      <option value="0" selected="selected">No</option>
                                          </select></td>
                  <td class="right"><select name="product_option[0][product_option_value][1][price_prefix]">
                                            <option value="+" selected="selected">+</option>
                                                                  <option value="-">-</option>
                                          </select>
                    <input type="text" name="product_option[0][product_option_value][1][price]" value="0.0000" size="5" /></td>
                  <td class="right"><select name="product_option[0][product_option_value][1][points_prefix]">
                                            <option value="+" selected="selected">+</option>
                                                                  <option value="-">-</option>
                                          </select>
                    <input type="text" name="product_option[0][product_option_value][1][points]" value="0" size="5" /></td>
                  <td class="right"><select name="product_option[0][product_option_value][1][weight_prefix]">
                                            <option value="+" selected="selected">+</option>
                                                                  <option value="-">-</option>
                                          </select>
                    <input type="text" name="product_option[0][product_option_value][1][weight]" value="0.00000000" size="5" /></td>
<!--start option image-->

                        <td><div class="image">
                        <img src="http://localhost/oc15/image/cache/no_image-100x100.jpg" id="thumb17"/>
                           </br>
                           <input type="hidden" name="product_option[0][product_option_value][1][image]" value="" id="image17" />
                            <a onclick="image_upload('image17', 'thumb17');">Browse</a>
                            &nbsp;|&nbsp;
                            <a onclick="$('#thumb17').attr('src', 'http://localhost/oc15/image/cache/no_image-100x100.jpg'); $('#image17').attr('value', '');">Clear</a>
                        </div></td>
                                                <!--end option image-->
                  <td class="left"><a onclick="$('#option-value-row1').remove();" class="button">Remove</a></td>
                </tr>
              </tbody>
                                          <tbody id="option-value-row2">
                <tr>
                  <td class="left"><select name="product_option[0][product_option_value][2][option_value_id]">
                                                                                        <option value="52">yellow</option>
                                                                                        <option value="53" selected="selected">red</option>
                                                                                        <option value="54">blue</option>
                                                                                      </select>
                    <input type="hidden" name="product_option[0][product_option_value][2][product_option_value_id]" value="18" /></td>
                  <td class="right"><input type="text" name="product_option[0][product_option_value][2][quantity]" value="0" size="3" /></td>
                  <td class="left"><select name="product_option[0][product_option_value][2][subtract]">
                                            <option value="1">Yes</option>
                      <option value="0" selected="selected">No</option>
                                          </select></td>
                  <td class="right"><select name="product_option[0][product_option_value][2][price_prefix]">
                                            <option value="+" selected="selected">+</option>
                                                                  <option value="-">-</option>
                                          </select>
                    <input type="text" name="product_option[0][product_option_value][2][price]" value="0.0000" size="5" /></td>
                  <td class="right"><select name="product_option[0][product_option_value][2][points_prefix]">
                                            <option value="+" selected="selected">+</option>
                                                                  <option value="-">-</option>
                                          </select>
                    <input type="text" name="product_option[0][product_option_value][2][points]" value="0" size="5" /></td>
                  <td class="right"><select name="product_option[0][product_option_value][2][weight_prefix]">
                                            <option value="+" selected="selected">+</option>
                                                                  <option value="-">-</option>
                                          </select>
                    <input type="text" name="product_option[0][product_option_value][2][weight]" value="0.00000000" size="5" /></td>
<!--start option image-->

                        <td><div class="image">
                        <img src="http://localhost/oc15/image/cache/no_image-100x100.jpg" id="thumb18"/>
                           </br>
                           <input type="hidden" name="product_option[0][product_option_value][2][image]" value="" id="image18" />
                            <a onclick="image_upload('image18', 'thumb18');">Browse</a>
                            &nbsp;|&nbsp;
                            <a onclick="$('#thumb18').attr('src', 'http://localhost/oc15/image/cache/no_image-100x100.jpg'); $('#image18').attr('value', '');">Clear</a>
                        </div></td>
                                                <!--end option image-->
                  <td class="left"><a onclick="$('#option-value-row2').remove();" class="button">Remove</a></td>
                </tr>
              </tbody>
                                          <tfoot>
                <tr>

            <td colspan="7"></td>
                              <td class="left"><a onclick="addOptionValue('0');" class="button">Add Option Value</a></td>
                </tr>
              </tfoot>
            </table>
            <select id="option-values0" style="display: none;">
                                          <option value="52">yellow</option>
                            <option value="53">red</option>
                            <option value="54">blue</option>
                                        </select>
                      </div>
                              <div id="tab-option-1" class="vtabs-content">
            <input type="hidden" name="product_option[1][product_option_id]" value="231" />
            <input type="hidden" name="product_option[1][name]" value="color box hex 2" />
            <input type="hidden" name="product_option[1][option_id]" value="15" />
            <input type="hidden" name="product_option[1][type]" value="color" />
            <table class="form">
              <tr>
                <td>Required:</td>
                <td><select name="product_option[1][required]">
                                        <option value="1" selected="selected">Yes</option>
                    <option value="0">No</option>
                                      </select></td>
              </tr>
                                                                                                </table>
                        <table id="option-value1" class="list">
              <thead>
                <tr>
                  <td class="left">Option Value:</td>
                  <td class="right">Quantity:</td>
                  <td class="left">Subtract Stock:</td>
                  <td class="right">Price:</td>
                  <td class="right">Points:</td>
                  <td class="right">Weight:</td>

                        <td class="right">Image:</td>
                              <td></td>
                </tr>
              </thead>
                            <tbody id="option-value-row3">
                <tr>
                  <td class="left"><select name="product_option[1][product_option_value][3][option_value_id]">
                                                                                        <option value="55">grey</option>
                                                                                        <option value="56">black</option>
                                                                                        <option value="57" selected="selected">light grey</option>
                                                                                      </select>
                    <input type="hidden" name="product_option[1][product_option_value][3][product_option_value_id]" value="31" /></td>
                  <td class="right"><input type="text" name="product_option[1][product_option_value][3][quantity]" value="0" size="3" /></td>
                  <td class="left"><select name="product_option[1][product_option_value][3][subtract]">
                                            <option value="1">Yes</option>
                      <option value="0" selected="selected">No</option>
                                          </select></td>
                  <td class="right"><select name="product_option[1][product_option_value][3][price_prefix]">
                                            <option value="+" selected="selected">+</option>
                                                                  <option value="-">-</option>
                                          </select>
                    <input type="text" name="product_option[1][product_option_value][3][price]" value="0.0000" size="5" /></td>
                  <td class="right"><select name="product_option[1][product_option_value][3][points_prefix]">
                                            <option value="+" selected="selected">+</option>
                                                                  <option value="-">-</option>
                                          </select>
                    <input type="text" name="product_option[1][product_option_value][3][points]" value="0" size="5" /></td>
                  <td class="right"><select name="product_option[1][product_option_value][3][weight_prefix]">
                                            <option value="+" selected="selected">+</option>
                                                                  <option value="-">-</option>
                                          </select>
                    <input type="text" name="product_option[1][product_option_value][3][weight]" value="0.00000000" size="5" /></td>
<!--start option image-->

                        <td><div class="image">
                        <img src="http://localhost/oc15/image/cache/no_image-100x100.jpg" id="thumb31"/>
                           </br>
                           <input type="hidden" name="product_option[1][product_option_value][3][image]" value="" id="image31" />
                            <a onclick="image_upload('image31', 'thumb31');">Browse</a>
                            &nbsp;|&nbsp;
                            <a onclick="$('#thumb31').attr('src', 'http://localhost/oc15/image/cache/no_image-100x100.jpg'); $('#image31').attr('value', '');">Clear</a>
                        </div></td>
                                                <!--end option image-->
                  <td class="left"><a onclick="$('#option-value-row3').remove();" class="button">Remove</a></td>
                </tr>
              </tbody>
                                          <tbody id="option-value-row4">
                <tr>
                  <td class="left"><select name="product_option[1][product_option_value][4][option_value_id]">
                                                                                        <option value="55" selected="selected">grey</option>
                                                                                        <option value="56">black</option>
                                                                                        <option value="57">light grey</option>
                                                                                      </select>
                    <input type="hidden" name="product_option[1][product_option_value][4][product_option_value_id]" value="30" /></td>
                  <td class="right"><input type="text" name="product_option[1][product_option_value][4][quantity]" value="0" size="3" /></td>
                  <td class="left"><select name="product_option[1][product_option_value][4][subtract]">
                                            <option value="1">Yes</option>
                      <option value="0" selected="selected">No</option>
                                          </select></td>
                  <td class="right"><select name="product_option[1][product_option_value][4][price_prefix]">
                                            <option value="+" selected="selected">+</option>
                                                                  <option value="-">-</option>
                                          </select>
                    <input type="text" name="product_option[1][product_option_value][4][price]" value="0.0000" size="5" /></td>
                  <td class="right"><select name="product_option[1][product_option_value][4][points_prefix]">
                                            <option value="+" selected="selected">+</option>
                                                                  <option value="-">-</option>
                                          </select>
                    <input type="text" name="product_option[1][product_option_value][4][points]" value="0" size="5" /></td>
                  <td class="right"><select name="product_option[1][product_option_value][4][weight_prefix]">
                                            <option value="+" selected="selected">+</option>
                                                                  <option value="-">-</option>
                                          </select>
                    <input type="text" name="product_option[1][product_option_value][4][weight]" value="0.00000000" size="5" /></td>
<!--start option image-->

                        <td><div class="image">
                        <img src="http://localhost/oc15/image/cache/no_image-100x100.jpg" id="thumb30"/>
                           </br>
                           <input type="hidden" name="product_option[1][product_option_value][4][image]" value="" id="image30" />
                            <a onclick="image_upload('image30', 'thumb30');">Browse</a>
                            &nbsp;|&nbsp;
                            <a onclick="$('#thumb30').attr('src', 'http://localhost/oc15/image/cache/no_image-100x100.jpg'); $('#image30').attr('value', '');">Clear</a>
                        </div></td>
                                                <!--end option image-->
                  <td class="left"><a onclick="$('#option-value-row4').remove();" class="button">Remove</a></td>
                </tr>
              </tbody>
                                          <tbody id="option-value-row5">
                <tr>
                  <td class="left"><select name="product_option[1][product_option_value][5][option_value_id]">
                                                                                        <option value="55">grey</option>
                                                                                        <option value="56" selected="selected">black</option>
                                                                                        <option value="57">light grey</option>
                                                                                      </select>
                    <input type="hidden" name="product_option[1][product_option_value][5][product_option_value_id]" value="29" /></td>
                  <td class="right"><input type="text" name="product_option[1][product_option_value][5][quantity]" value="0" size="3" /></td>
                  <td class="left"><select name="product_option[1][product_option_value][5][subtract]">
                                            <option value="1">Yes</option>
                      <option value="0" selected="selected">No</option>
                                          </select></td>
                  <td class="right"><select name="product_option[1][product_option_value][5][price_prefix]">
                                            <option value="+" selected="selected">+</option>
                                                                  <option value="-">-</option>
                                          </select>
                    <input type="text" name="product_option[1][product_option_value][5][price]" value="0.0000" size="5" /></td>
                  <td class="right"><select name="product_option[1][product_option_value][5][points_prefix]">
                                            <option value="+" selected="selected">+</option>
                                                                  <option value="-">-</option>
                                          </select>
                    <input type="text" name="product_option[1][product_option_value][5][points]" value="0" size="5" /></td>
                  <td class="right"><select name="product_option[1][product_option_value][5][weight_prefix]">
                                            <option value="+" selected="selected">+</option>
                                                                  <option value="-">-</option>
                                          </select>
                    <input type="text" name="product_option[1][product_option_value][5][weight]" value="0.00000000" size="5" /></td>
<!--start option image-->

                        <td><div class="image">
                        <img src="http://localhost/oc15/image/cache/no_image-100x100.jpg" id="thumb29"/>
                           </br>
                           <input type="hidden" name="product_option[1][product_option_value][5][image]" value="" id="image29" />
                            <a onclick="image_upload('image29', 'thumb29');">Browse</a>
                            &nbsp;|&nbsp;
                            <a onclick="$('#thumb29').attr('src', 'http://localhost/oc15/image/cache/no_image-100x100.jpg'); $('#image29').attr('value', '');">Clear</a>
                        </div></td>
                                                <!--end option image-->
                  <td class="left"><a onclick="$('#option-value-row5').remove();" class="button">Remove</a></td>
                </tr>
              </tbody>
                                          <tfoot>
                <tr>

            <td colspan="7"></td>
                              <td class="left"><a onclick="addOptionValue('1');" class="button">Add Option Value</a></td>
                </tr>
              </tfoot>
            </table>
            <select id="option-values1" style="display: none;">
                                          <option value="55">grey</option>
                            <option value="56">black</option>
                            <option value="57">light grey</option>
                                        </select>
                      </div>
                            </div>
        <div id="tab-profile">
            <table class="list">
                <thead>
                    <tr>
                        <td class="left">Profile:</td>
                        <td class="left">Customer Group:</td>
                        <td class="left"></td>
                    </tr>
                </thead>
                <tbody>
                                                        </tbody>
                <tfoot>
                    <tr>
                        <td colspan="2"></td>
                        <td class="left"><a onclick="addProfile()" class="button">Add Profile</a></td>
                    </tr>
                </tfoot>
            </table>
        </div>
        <div id="tab-discount">
          <table id="discount" class="list">
            <thead>
              <tr>
                <td class="left">Customer Group:</td>
                <td class="right">Quantity:</td>
                <td class="right">Priority:</td>
                <td class="right">Price:</td>
                <td class="left">Date Start:</td>
                <td class="left">Date End:</td>
                <td></td>
              </tr>
            </thead>
                                    <tfoot>
              <tr>
                <td colspan="6"></td>
                <td class="left"><a onclick="addDiscount();" class="button">Add Discount</a></td>
              </tr>
            </tfoot>
          </table>
        </div>
        <div id="tab-special">
          <table id="special" class="list">
            <thead>
              <tr>
                <td class="left">Customer Group:</td>
                <td class="right">Priority:</td>
                <td class="right">Price:</td>
                <td class="left">Date Start:</td>
                <td class="left">Date End:</td>
                <td></td>
              </tr>
            </thead>
                                    <tfoot>
              <tr>
                <td colspan="5"></td>
                <td class="left"><a onclick="addSpecial();" class="button">Add Special</a></td>
              </tr>
            </tfoot>
          </table>
        </div>
        <div id="tab-image">
          <table id="images" class="list">
            <thead>
              <tr>
                <td class="left">Image:</td>
                <td class="right">Sort Order:</td>
                <td></td>
              </tr>
            </thead>
                                    <tfoot>
              <tr>
                <td colspan="2"></td>
                <td class="left"><a onclick="addImage();" class="button">Add Image</a></td>
              </tr>
            </tfoot>
          </table>
        </div>
        <div id="tab-reward">
          <table class="form">
            <tr>
              <td>Points:<br/><span class="help">Number of points needed to buy this item. If you don't want this product to be purchased with points leave as 0.</span></td>
              <td><input type="text" name="points" value="0" /></td>
            </tr>
          </table>
          <table class="list">
            <thead>
              <tr>
                <td class="left">Customer Group:</td>
                <td class="right">Reward Points:</td>
              </tr>
            </thead>
                        <tbody>
              <tr>
                <td class="left">Default</td>
                <td class="right"><input type="text" name="product_reward[1][points]" value="0" /></td>
              </tr>
            </tbody>
                      </table>
        </div>
        <div id="tab-design">
          <table class="list">
            <thead>
              <tr>
                <td class="left">Stores:</td>
                <td class="left">Layout Override:</td>
              </tr>
            </thead>
            <tbody>
              <tr>
                <td class="left">Default</td>
                <td class="left"><select name="product_layout[0][layout_id]">
                    <option value=""></option>
                                                            <option value="6">Account</option>
                                                                                <option value="10">Affiliate</option>
                                                                                <option value="3">Category</option>
                                                                                <option value="7">Checkout</option>
                                                                                <option value="8">Contact</option>
                                                                                <option value="4">Default</option>
                                                                                <option value="1">Home</option>
                                                                                <option value="11">Information</option>
                                                                                <option value="5">Manufacturer</option>
                                                                                <option value="2">Product</option>
                                                                                <option value="9">Sitemap</option>
                                                          </select></td>
              </tr>
            </tbody>
                      </table>
        </div>
















<!--BOF PICW-->
			<div id="tab-picw">
				<table class="form">
					<tr>
						<td>SVG text:</td>
						<td>
							<textarea id="product_svg" name="product_svg"><svg
   xmlns:dc="http://purl.org/dc/elements/1.1/"
   xmlns:cc="http://creativecommons.org/ns#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
   xmlns:svg="http://www.w3.org/2000/svg"
   xmlns="http://www.w3.org/2000/svg"
   xmlns:sodipodi="http://sodipodi.sourceforge.net/DTD/sodipodi-0.dtd"
   xmlns:inkscape="http://www.inkscape.org/namespaces/inkscape"
   width="600"
   height="651.46307"
   id="svg2"
   version="1.1"
   inkscape:version="0.48.4 r9939"
   sodipodi:docname="butterfly.svg"
   inkscape:export-filename="C:\Users\Margaret\Pictures\wall_peel\vectostock\free\vectorstock_85252_butterfly\butterfly.png"
   inkscape:export-xdpi="90"
   inkscape:export-ydpi="90"><defs></defs>
  <defs
     id="defs4">
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3304">
      <path
         d="m 0,595.275 841.89,0 L 841.89,0 0,0 0,595.275 z"
         id="path3306"
         inkscape:connector-curvature="0" />
    </clipPath>
  </defs>
  <sodipodi:namedview
     id="base"
     pagecolor="#ffffff"
     bordercolor="#666666"
     borderopacity="1.0"
     inkscape:pageopacity="0.0"
     inkscape:pageshadow="2"
     inkscape:zoom="0.7"
     inkscape:cx="243.50064"
     inkscape:cy="265.83851"
     inkscape:document-units="px"
     inkscape:current-layer="g3300"
     showgrid="false"
     inkscape:window-width="1341"
     inkscape:window-height="936"
     inkscape:window-x="348"
     inkscape:window-y="64"
     inkscape:window-maximized="0"
     showborder="true"
     fit-margin-top="0"
     fit-margin-left="0"
     fit-margin-right="0"
     fit-margin-bottom="0" />
  <metadata
     id="metadata7">
    <rdf:RDF>
      <cc:Work
         rdf:about="">
        <dc:format>image/svg+xml</dc:format>
        <dc:type
           rdf:resource="http://purl.org/dc/dcmitype/StillImage" />
        <dc:title></dc:title>
      </cc:Work>
    </rdf:RDF>
  </metadata>
  <g
     inkscape:label="Layer 1"
     inkscape:groupmode="layer"
     id="layer1"
     transform="translate(-122.33866,-262.43103)">
    <g
       id="g3300"
       transform="matrix(1.25,0,0,-1.25,-331.58273,1133.8758)">
      <g
         transform="matrix(1.8078055,0,0,1.7057537,592.55851,249.98773)"
         id="g3308">
        <path
           id="path3310"
           style="fill:#00a0c6;fill-opacity:1;fill-rule:nonzero;stroke:none"
           d="m 0,0 c 0,0 -70.434,103.343 -62.93,171.464 7.504,68.123 64.082,105.072 77.365,85.438 C 26.806,238.617 -47.63,228.328 -49.076,159.341 -50.31,100.179 -22.801,36.081 0,0"
           inkscape:connector-curvature="0" />
      </g>
      <g
         transform="matrix(1.8078055,0,0,1.7057537,582.58737,277.28643)"
         id="g3312">
        <path
           id="path3314"
           style="fill:#00a0c6;fill-opacity:1;fill-rule:nonzero;stroke:none"
           d="m 0,0 c 0,0 -46.182,96.409 -36.657,151.543 9.524,55.135 49.936,70.143 66.969,54.268 17.028,-15.874 0.288,-47.05 0.288,-47.05 0,0 17.897,14.432 31.173,-1.733 13.28,-16.164 -3.752,-26.844 -3.752,-26.844 0,0 15.588,5.771 24.248,-6.353 8.658,-12.121 -3.752,-33.772 -17.898,-43.874 0,0 26.559,28.866 13.279,41.568 -13.279,12.701 -24.824,5.195 -24.824,5.195 0,0 17.029,16.454 4.329,29.732 -12.699,13.278 -30.307,-2.021 -30.307,-2.021 0,0 16.165,28.863 -2.024,47.05 C 6.642,219.666 -32.328,179.543 -30.596,129.319 -28.864,79.093 0,0 0,0"
           inkscape:connector-curvature="0" />
      </g>
      <g
         transform="matrix(1.8078055,0,0,1.7057537,535.62854,489.00884)"
         id="g3316">
        <path
           id="path3318"
           style="fill:#00a0c6;fill-opacity:1;fill-rule:nonzero;stroke:none"
           d="M 0,0 C 0,0 -4.933,43.968 18.761,51.668 41.853,59.174 53.109,32.906 41.853,8.37 c 0,0 8.373,21.075 24.536,10.682 16.165,-10.392 -2.31,-31.753 -2.31,-31.753 0,0 16.746,11.546 25.691,-3.753 8.947,-15.297 -16.164,-29.442 -16.164,-29.442 0,0 23.379,17.032 10.391,30.021 -12.99,12.987 -25.978,-2.888 -25.978,-2.888 0,0 18.183,19.917 5.195,32.907 C 50.226,27.132 39.544,3.752 39.544,3.752 c 0,0 7.796,39.546 -14.434,40.99 C -1.671,46.48 0,0 0,0"
           inkscape:connector-curvature="0" />
      </g>
      <g
         transform="matrix(1.8078055,0,0,1.7057537,572.15181,460.44991)"
         id="g3320"
         style="fill:#ff00ff">
        <path
           id="path3322"
           style="fill:#ff00ff;fill-opacity:1;fill-rule:nonzero;stroke:none"
           d="M 0,0 C 0,0 -21.646,47.626 -1.44,50.514 20.071,53.59 4.907,13.565 0,0"
           inkscape:connector-curvature="0" />
      </g>
      <g
         transform="matrix(1.8078055,0,0,1.7057537,602.94272,452.08028)"
         id="g3324">
        <path
           id="path3326"
           style="fill:#ff00ff;fill-opacity:1;fill-rule:nonzero;stroke:none"
           d="M 0,0 C 0,0 7.318,39.308 22.801,30.309 35.214,23.092 6.927,4.041 0,0"
           inkscape:connector-curvature="0" />
      </g>
      <g
         transform="matrix(1.8078055,0,0,1.7057537,638.14902,428.28213)"
         id="g3328"
         style="fill:#ff00ff">
        <path
           id="path3330"
           style="fill:#ff00ff;fill-opacity:1;fill-rule:nonzero;stroke:none"
           d="M 0,0 C 0,0 20.858,24.064 27.194,12.629 33.531,1.198 0,0 0,0"
           inkscape:connector-curvature="0" />
      </g>
      <path
         inkscape:connector-curvature="0"
         d="m 525.18774,453.55526 c 0,0 28.17648,7.88227 43.31322,-23.14198 0,0 9.05709,18.53475 28.70613,18.22086 30.77969,-0.49296 62.09271,-27.08395 38.61112,-100.44327 -15.87796,-49.61698 -32.35429,-111.27485 2.61048,-147.21849 0,0 -19.30738,13.29635 -24.00406,43.32615 -4.69848,30.03489 16.37331,112.45009 19.30194,142.29396 4.70212,47.7594 -56.3511,75.82586 -62.0963,-4.42815 0,0 3.659,59.57175 -41.74584,62.03829 l -4.69669,9.35263 z"
         style="fill:#00a0c6;fill-opacity:1;fill-rule:nonzero;stroke:none"
         id="path3334" />
      <g
         transform="matrix(1.8078055,0,0,1.7057537,616.50831,419.58688)"
         id="g3336"
         style="fill:#ff00ff">
        <path
           id="path3338"
           style="fill:#ff00ff;fill-opacity:1;fill-rule:nonzero;stroke:none"
           d="m 0,0 c 3.35,-3.35 3.35,-8.775 0,-12.125 -3.347,-3.345 -8.772,-3.345 -12.122,0.002 -3.347,3.348 -3.347,8.773 0,12.122 C -8.772,3.347 -3.347,3.347 0,0"
           inkscape:connector-curvature="0" />
      </g>
      <g
         transform="matrix(1.8078055,0,0,1.7057537,676.57195,365.55406)"
         id="g3340">
        <path
           id="path3342"
           style="fill:#00a0c6;fill-opacity:1;fill-rule:nonzero;stroke:none"
           d="M 0,0 C 0,0 12.699,30.018 29.15,27.998 45.604,25.979 49.935,4.906 49.935,4.906 c 0,0 13.858,6.926 22.514,-1.733 8.661,-8.658 4.044,-23.091 4.044,-23.091 0,0 12.413,0.866 15.299,-8.948 2.884,-9.815 -13.279,-21.938 -13.279,-21.938 0,0 11.545,13.279 4.33,20.496 -7.216,7.215 -16.743,2.885 -16.743,2.885 0,0 8.661,14.432 -1.732,23.67 -10.39,9.235 -20.492,-8.949 -20.492,-8.949 0,0 2.886,23.094 -15.012,25.403 C 10.968,15.008 0,0 0,0"
           inkscape:connector-curvature="0" />
      </g>
      <g
         transform="matrix(1.8078055,0,0,1.7057537,652.56554,212.9159)"
         id="g3344">
        <path
           id="path3346"
           style="fill:#00a0c6;fill-opacity:1;fill-rule:nonzero;stroke:none"
           d="m 0,0 c 0,0 -5.198,36.374 2.309,58.309 7.506,21.937 26.267,31.464 37.523,23.67 11.26,-7.794 0.58,-21.361 0.58,-21.361 0,0 14.718,15.876 26.265,8.948 11.548,-6.926 -3.463,-24.823 -3.463,-24.823 0,0 11.545,7.502 19.052,-1.734 7.506,-9.236 -30.6,-50.8 -78.803,-45.316 0,0 35.266,3.078 49.937,14.141 18.763,14.145 15.874,27.426 0.867,25.692 0,0 11.258,8.371 0.865,18.763 -10.393,10.39 -20.206,-1.733 -20.206,-1.733 0,0 6.349,12.703 -5.773,18.474 C 17.031,78.803 -4.907,47.628 0,0"
           inkscape:connector-curvature="0" />
      </g>
      <g
         transform="matrix(1.8078055,0,0,1.7057537,673.43666,240.48855)"
         id="g3348"
         style="fill:#ff00ff">
        <path
           id="path3350"
           style="fill:#ff00ff;fill-opacity:1;fill-rule:nonzero;stroke:none"
           d="M 0,0 C 0,0 -5.772,43.299 5.197,43.299 16.165,43.299 0,0 0,0"
           inkscape:connector-curvature="0" />
      </g>
      <g
         transform="matrix(1.8078055,0,0,1.7057537,692.74692,246.89179)"
         id="g3352"
         style="fill:#ff00ff">
        <path
           id="path3354"
           style="fill:#ff00ff;fill-opacity:1;fill-rule:nonzero;stroke:none"
           d="M 0,0 C 0,0 13.276,33.482 21.358,25.401 29.442,17.318 0,0 0,0"
           inkscape:connector-curvature="0" />
      </g>
      <g
         transform="matrix(1.8078055,0,0,1.7057537,702.51159,232.28047)"
         id="g3356"
         style="fill:#ff00ff">
        <path
           id="path3358"
           style="fill:#ff00ff;fill-opacity:1;fill-rule:nonzero;stroke:none"
           d="M 0,0 C 0,0 19.915,18.759 23.67,12.699 27.425,6.638 0,0 0,0"
           inkscape:connector-curvature="0" />
      </g>
      <g
         transform="matrix(1.8078055,0,0,1.7057537,557.53046,224.95443)"
         id="g3360"
         style="fill:#ff00ff">
        <path
           id="path3362"
           style="fill:#ff00ff;fill-opacity:1;fill-rule:nonzero;stroke:none"
           d="m 0,0 c -2.485,-5.526 -1.601,-13.499 23.217,-24.935 17.06,-7.86 54.765,-1.001 54.765,-1.001 0,0 -28.81,4.156 -43.779,15.883 C 19.23,1.671 4.846,10.801 0,0"
           inkscape:connector-curvature="0" />
      </g>
      <g
         transform="matrix(1.8078055,0,0,1.7057537,549.9039,244.79541)"
         id="g3364"
         style="fill:#ff00ff">
        <path
           id="path3366"
           style="fill:#ff00ff;fill-opacity:1;fill-rule:nonzero;stroke:none"
           d="m 0,0 c 3.138,-2.609 3.569,-7.272 0.964,-10.411 -2.609,-3.141 -7.272,-3.572 -10.415,-0.964 -3.143,2.606 -3.571,7.272 -0.964,10.413 C -7.807,2.177 -3.144,2.608 0,0"
           inkscape:connector-curvature="0" />
      </g>
      <g
         transform="matrix(1.8078055,0,0,1.7057537,510.10035,255.90277)"
         id="g3368">
        <path
           id="path3370"
           style="fill:#00a0c6;fill-opacity:1;fill-rule:nonzero;stroke:none"
           d="m 0,0 c 0,0 -62.74,35.179 -55.133,58.02 3.237,9.713 12.321,-4.271 3.263,-5.178 0,0 -0.453,-18.117 51.87,-52.842"
           inkscape:connector-curvature="0" />
      </g>
      <g
         transform="matrix(1.8078055,0,0,1.7057537,508.43898,242.13357)"
         id="g3372">
        <path
           id="path3374"
           style="fill:#00a0c6;fill-opacity:1;fill-rule:nonzero;stroke:none"
           d="m 0,0 c 0,0 -25.452,2.808 -47.104,24.456 -20.378,20.381 -23.849,35.285 -19.232,38.172 4.615,2.887 10.103,-5.485 2.021,-6.062 0,0 7.93,-38.224 64.315,-56.566"
           inkscape:connector-curvature="0" />
      </g>
      <g
         transform="matrix(1.8078055,0,0,1.7057537,557.58525,254.4302)"
         id="g3376">
        <path
           id="path3378"
           style="fill:#00a0c6;fill-opacity:1;fill-rule:nonzero;stroke:none"
           d="m 0,0 c 0,0 -82.948,60.514 -101.605,126.431 -17.32,61.194 7.792,88.039 16.452,89.77 8.661,1.732 14.144,-8.372 7.217,-18.186 -6.926,-9.815 -22.226,-62.061 5.773,-107.38 C -44.164,45.317 0,0 0,0"
           inkscape:connector-curvature="0" />
      </g>
      <g
         transform="matrix(1.8078055,0,0,1.7057537,559.15117,257.87342)"
         id="g3380">
        <path
           id="path3382"
           style="fill:#00a0c6;fill-opacity:1;fill-rule:nonzero;stroke:none"
           d="m 0,0 c 0,0 -59.75,73.031 -71.298,103.05 -11.547,30.021 -14.433,88.328 28.576,91.505 l -1.154,-4.043 c 0,0 -26.845,0.288 -30.308,-35.506 -3.463,-35.79 13.857,-65.232 22.227,-78.798 C -43.585,62.638 0,0 0,0"
           inkscape:connector-curvature="0" />
      </g>
      <g
         transform="matrix(1.8078055,0,0,1.7057537,455.08412,472.72179)"
         id="g3384"
         style="fill:#ff00ff">
        <path
           id="path3386"
           style="fill:#ff00ff;fill-opacity:1;fill-rule:nonzero;stroke:none"
           d="M 0,0 C 0,0 -21.645,47.629 -1.44,50.516 20.071,53.591 4.909,13.566 0,0"
           inkscape:connector-curvature="0" />
      </g>
    </g>
  </g>
</svg></textarea>
							<br/>
							<a id="analyse_svg" class="button">Analyse</a>
						</td>
					</tr>
					<tr>
						<td>Preview:</td>
						<td>
							<div id="product_svg_preview">
								<svg
   xmlns:dc="http://purl.org/dc/elements/1.1/"
   xmlns:cc="http://creativecommons.org/ns#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
   xmlns:svg="http://www.w3.org/2000/svg"
   xmlns="http://www.w3.org/2000/svg"
   xmlns:sodipodi="http://sodipodi.sourceforge.net/DTD/sodipodi-0.dtd"
   xmlns:inkscape="http://www.inkscape.org/namespaces/inkscape"
   width="600"
   height="651.46307"
   id="svg2"
   version="1.1"
   inkscape:version="0.48.4 r9939"
   sodipodi:docname="butterfly.svg"
   inkscape:export-filename="C:\Users\Margaret\Pictures\wall_peel\vectostock\free\vectorstock_85252_butterfly\butterfly.png"
   inkscape:export-xdpi="90"
   inkscape:export-ydpi="90"><defs></defs>
  <defs
     id="defs4">
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3304">
      <path
         d="m 0,595.275 841.89,0 L 841.89,0 0,0 0,595.275 z"
         id="path3306"
         inkscape:connector-curvature="0" />
    </clipPath>
  </defs>
  <sodipodi:namedview
     id="base"
     pagecolor="#ffffff"
     bordercolor="#666666"
     borderopacity="1.0"
     inkscape:pageopacity="0.0"
     inkscape:pageshadow="2"
     inkscape:zoom="0.7"
     inkscape:cx="243.50064"
     inkscape:cy="265.83851"
     inkscape:document-units="px"
     inkscape:current-layer="g3300"
     showgrid="false"
     inkscape:window-width="1341"
     inkscape:window-height="936"
     inkscape:window-x="348"
     inkscape:window-y="64"
     inkscape:window-maximized="0"
     showborder="true"
     fit-margin-top="0"
     fit-margin-left="0"
     fit-margin-right="0"
     fit-margin-bottom="0" />
  <metadata
     id="metadata7">
    <rdf:RDF>
      <cc:Work
         rdf:about="">
        <dc:format>image/svg+xml</dc:format>
        <dc:type
           rdf:resource="http://purl.org/dc/dcmitype/StillImage" />
        <dc:title></dc:title>
      </cc:Work>
    </rdf:RDF>
  </metadata>
  <g
     inkscape:label="Layer 1"
     inkscape:groupmode="layer"
     id="layer1"
     transform="translate(-122.33866,-262.43103)">
    <g
       id="g3300"
       transform="matrix(1.25,0,0,-1.25,-331.58273,1133.8758)">
      <g
         transform="matrix(1.8078055,0,0,1.7057537,592.55851,249.98773)"
         id="g3308">
        <path
           id="path3310"
           style="fill:#00a0c6;fill-opacity:1;fill-rule:nonzero;stroke:none"
           d="m 0,0 c 0,0 -70.434,103.343 -62.93,171.464 7.504,68.123 64.082,105.072 77.365,85.438 C 26.806,238.617 -47.63,228.328 -49.076,159.341 -50.31,100.179 -22.801,36.081 0,0"
           inkscape:connector-curvature="0" />
      </g>
      <g
         transform="matrix(1.8078055,0,0,1.7057537,582.58737,277.28643)"
         id="g3312">
        <path
           id="path3314"
           style="fill:#00a0c6;fill-opacity:1;fill-rule:nonzero;stroke:none"
           d="m 0,0 c 0,0 -46.182,96.409 -36.657,151.543 9.524,55.135 49.936,70.143 66.969,54.268 17.028,-15.874 0.288,-47.05 0.288,-47.05 0,0 17.897,14.432 31.173,-1.733 13.28,-16.164 -3.752,-26.844 -3.752,-26.844 0,0 15.588,5.771 24.248,-6.353 8.658,-12.121 -3.752,-33.772 -17.898,-43.874 0,0 26.559,28.866 13.279,41.568 -13.279,12.701 -24.824,5.195 -24.824,5.195 0,0 17.029,16.454 4.329,29.732 -12.699,13.278 -30.307,-2.021 -30.307,-2.021 0,0 16.165,28.863 -2.024,47.05 C 6.642,219.666 -32.328,179.543 -30.596,129.319 -28.864,79.093 0,0 0,0"
           inkscape:connector-curvature="0" />
      </g>
      <g
         transform="matrix(1.8078055,0,0,1.7057537,535.62854,489.00884)"
         id="g3316">
        <path
           id="path3318"
           style="fill:#00a0c6;fill-opacity:1;fill-rule:nonzero;stroke:none"
           d="M 0,0 C 0,0 -4.933,43.968 18.761,51.668 41.853,59.174 53.109,32.906 41.853,8.37 c 0,0 8.373,21.075 24.536,10.682 16.165,-10.392 -2.31,-31.753 -2.31,-31.753 0,0 16.746,11.546 25.691,-3.753 8.947,-15.297 -16.164,-29.442 -16.164,-29.442 0,0 23.379,17.032 10.391,30.021 -12.99,12.987 -25.978,-2.888 -25.978,-2.888 0,0 18.183,19.917 5.195,32.907 C 50.226,27.132 39.544,3.752 39.544,3.752 c 0,0 7.796,39.546 -14.434,40.99 C -1.671,46.48 0,0 0,0"
           inkscape:connector-curvature="0" />
      </g>
      <g
         transform="matrix(1.8078055,0,0,1.7057537,572.15181,460.44991)"
         id="g3320"
         style="fill:#ff00ff">
        <path
           id="path3322"
           style="fill:#ff00ff;fill-opacity:1;fill-rule:nonzero;stroke:none"
           d="M 0,0 C 0,0 -21.646,47.626 -1.44,50.514 20.071,53.59 4.907,13.565 0,0"
           inkscape:connector-curvature="0" />
      </g>
      <g
         transform="matrix(1.8078055,0,0,1.7057537,602.94272,452.08028)"
         id="g3324">
        <path
           id="path3326"
           style="fill:#ff00ff;fill-opacity:1;fill-rule:nonzero;stroke:none"
           d="M 0,0 C 0,0 7.318,39.308 22.801,30.309 35.214,23.092 6.927,4.041 0,0"
           inkscape:connector-curvature="0" />
      </g>
      <g
         transform="matrix(1.8078055,0,0,1.7057537,638.14902,428.28213)"
         id="g3328"
         style="fill:#ff00ff">
        <path
           id="path3330"
           style="fill:#ff00ff;fill-opacity:1;fill-rule:nonzero;stroke:none"
           d="M 0,0 C 0,0 20.858,24.064 27.194,12.629 33.531,1.198 0,0 0,0"
           inkscape:connector-curvature="0" />
      </g>
      <path
         inkscape:connector-curvature="0"
         d="m 525.18774,453.55526 c 0,0 28.17648,7.88227 43.31322,-23.14198 0,0 9.05709,18.53475 28.70613,18.22086 30.77969,-0.49296 62.09271,-27.08395 38.61112,-100.44327 -15.87796,-49.61698 -32.35429,-111.27485 2.61048,-147.21849 0,0 -19.30738,13.29635 -24.00406,43.32615 -4.69848,30.03489 16.37331,112.45009 19.30194,142.29396 4.70212,47.7594 -56.3511,75.82586 -62.0963,-4.42815 0,0 3.659,59.57175 -41.74584,62.03829 l -4.69669,9.35263 z"
         style="fill:#00a0c6;fill-opacity:1;fill-rule:nonzero;stroke:none"
         id="path3334" />
      <g
         transform="matrix(1.8078055,0,0,1.7057537,616.50831,419.58688)"
         id="g3336"
         style="fill:#ff00ff">
        <path
           id="path3338"
           style="fill:#ff00ff;fill-opacity:1;fill-rule:nonzero;stroke:none"
           d="m 0,0 c 3.35,-3.35 3.35,-8.775 0,-12.125 -3.347,-3.345 -8.772,-3.345 -12.122,0.002 -3.347,3.348 -3.347,8.773 0,12.122 C -8.772,3.347 -3.347,3.347 0,0"
           inkscape:connector-curvature="0" />
      </g>
      <g
         transform="matrix(1.8078055,0,0,1.7057537,676.57195,365.55406)"
         id="g3340">
        <path
           id="path3342"
           style="fill:#00a0c6;fill-opacity:1;fill-rule:nonzero;stroke:none"
           d="M 0,0 C 0,0 12.699,30.018 29.15,27.998 45.604,25.979 49.935,4.906 49.935,4.906 c 0,0 13.858,6.926 22.514,-1.733 8.661,-8.658 4.044,-23.091 4.044,-23.091 0,0 12.413,0.866 15.299,-8.948 2.884,-9.815 -13.279,-21.938 -13.279,-21.938 0,0 11.545,13.279 4.33,20.496 -7.216,7.215 -16.743,2.885 -16.743,2.885 0,0 8.661,14.432 -1.732,23.67 -10.39,9.235 -20.492,-8.949 -20.492,-8.949 0,0 2.886,23.094 -15.012,25.403 C 10.968,15.008 0,0 0,0"
           inkscape:connector-curvature="0" />
      </g>
      <g
         transform="matrix(1.8078055,0,0,1.7057537,652.56554,212.9159)"
         id="g3344">
        <path
           id="path3346"
           style="fill:#00a0c6;fill-opacity:1;fill-rule:nonzero;stroke:none"
           d="m 0,0 c 0,0 -5.198,36.374 2.309,58.309 7.506,21.937 26.267,31.464 37.523,23.67 11.26,-7.794 0.58,-21.361 0.58,-21.361 0,0 14.718,15.876 26.265,8.948 11.548,-6.926 -3.463,-24.823 -3.463,-24.823 0,0 11.545,7.502 19.052,-1.734 7.506,-9.236 -30.6,-50.8 -78.803,-45.316 0,0 35.266,3.078 49.937,14.141 18.763,14.145 15.874,27.426 0.867,25.692 0,0 11.258,8.371 0.865,18.763 -10.393,10.39 -20.206,-1.733 -20.206,-1.733 0,0 6.349,12.703 -5.773,18.474 C 17.031,78.803 -4.907,47.628 0,0"
           inkscape:connector-curvature="0" />
      </g>
      <g
         transform="matrix(1.8078055,0,0,1.7057537,673.43666,240.48855)"
         id="g3348"
         style="fill:#ff00ff">
        <path
           id="path3350"
           style="fill:#ff00ff;fill-opacity:1;fill-rule:nonzero;stroke:none"
           d="M 0,0 C 0,0 -5.772,43.299 5.197,43.299 16.165,43.299 0,0 0,0"
           inkscape:connector-curvature="0" />
      </g>
      <g
         transform="matrix(1.8078055,0,0,1.7057537,692.74692,246.89179)"
         id="g3352"
         style="fill:#ff00ff">
        <path
           id="path3354"
           style="fill:#ff00ff;fill-opacity:1;fill-rule:nonzero;stroke:none"
           d="M 0,0 C 0,0 13.276,33.482 21.358,25.401 29.442,17.318 0,0 0,0"
           inkscape:connector-curvature="0" />
      </g>
      <g
         transform="matrix(1.8078055,0,0,1.7057537,702.51159,232.28047)"
         id="g3356"
         style="fill:#ff00ff">
        <path
           id="path3358"
           style="fill:#ff00ff;fill-opacity:1;fill-rule:nonzero;stroke:none"
           d="M 0,0 C 0,0 19.915,18.759 23.67,12.699 27.425,6.638 0,0 0,0"
           inkscape:connector-curvature="0" />
      </g>
      <g
         transform="matrix(1.8078055,0,0,1.7057537,557.53046,224.95443)"
         id="g3360"
         style="fill:#ff00ff">
        <path
           id="path3362"
           style="fill:#ff00ff;fill-opacity:1;fill-rule:nonzero;stroke:none"
           d="m 0,0 c -2.485,-5.526 -1.601,-13.499 23.217,-24.935 17.06,-7.86 54.765,-1.001 54.765,-1.001 0,0 -28.81,4.156 -43.779,15.883 C 19.23,1.671 4.846,10.801 0,0"
           inkscape:connector-curvature="0" />
      </g>
      <g
         transform="matrix(1.8078055,0,0,1.7057537,549.9039,244.79541)"
         id="g3364"
         style="fill:#ff00ff">
        <path
           id="path3366"
           style="fill:#ff00ff;fill-opacity:1;fill-rule:nonzero;stroke:none"
           d="m 0,0 c 3.138,-2.609 3.569,-7.272 0.964,-10.411 -2.609,-3.141 -7.272,-3.572 -10.415,-0.964 -3.143,2.606 -3.571,7.272 -0.964,10.413 C -7.807,2.177 -3.144,2.608 0,0"
           inkscape:connector-curvature="0" />
      </g>
      <g
         transform="matrix(1.8078055,0,0,1.7057537,510.10035,255.90277)"
         id="g3368">
        <path
           id="path3370"
           style="fill:#00a0c6;fill-opacity:1;fill-rule:nonzero;stroke:none"
           d="m 0,0 c 0,0 -62.74,35.179 -55.133,58.02 3.237,9.713 12.321,-4.271 3.263,-5.178 0,0 -0.453,-18.117 51.87,-52.842"
           inkscape:connector-curvature="0" />
      </g>
      <g
         transform="matrix(1.8078055,0,0,1.7057537,508.43898,242.13357)"
         id="g3372">
        <path
           id="path3374"
           style="fill:#00a0c6;fill-opacity:1;fill-rule:nonzero;stroke:none"
           d="m 0,0 c 0,0 -25.452,2.808 -47.104,24.456 -20.378,20.381 -23.849,35.285 -19.232,38.172 4.615,2.887 10.103,-5.485 2.021,-6.062 0,0 7.93,-38.224 64.315,-56.566"
           inkscape:connector-curvature="0" />
      </g>
      <g
         transform="matrix(1.8078055,0,0,1.7057537,557.58525,254.4302)"
         id="g3376">
        <path
           id="path3378"
           style="fill:#00a0c6;fill-opacity:1;fill-rule:nonzero;stroke:none"
           d="m 0,0 c 0,0 -82.948,60.514 -101.605,126.431 -17.32,61.194 7.792,88.039 16.452,89.77 8.661,1.732 14.144,-8.372 7.217,-18.186 -6.926,-9.815 -22.226,-62.061 5.773,-107.38 C -44.164,45.317 0,0 0,0"
           inkscape:connector-curvature="0" />
      </g>
      <g
         transform="matrix(1.8078055,0,0,1.7057537,559.15117,257.87342)"
         id="g3380">
        <path
           id="path3382"
           style="fill:#00a0c6;fill-opacity:1;fill-rule:nonzero;stroke:none"
           d="m 0,0 c 0,0 -59.75,73.031 -71.298,103.05 -11.547,30.021 -14.433,88.328 28.576,91.505 l -1.154,-4.043 c 0,0 -26.845,0.288 -30.308,-35.506 -3.463,-35.79 13.857,-65.232 22.227,-78.798 C -43.585,62.638 0,0 0,0"
           inkscape:connector-curvature="0" />
      </g>
      <g
         transform="matrix(1.8078055,0,0,1.7057537,455.08412,472.72179)"
         id="g3384"
         style="fill:#ff00ff">
        <path
           id="path3386"
           style="fill:#ff00ff;fill-opacity:1;fill-rule:nonzero;stroke:none"
           d="M 0,0 C 0,0 -21.645,47.629 -1.44,50.516 20.071,53.591 4.909,13.566 0,0"
           inkscape:connector-curvature="0" />
      </g>
    </g>
  </g>
</svg>							</div>
						</td>
					</tr>
					<tr>
						<td>Color mappings:</td>
						<td>
							<table id="picw_mapping" class="list">
								<thead><tr>
									<td class="left">Color code</td>
									<td class="left">Color</td>
									<td class="left">Color/Image Option to link to</td>
								</tr></thead>
																									<tbody><tr>
										<td class="left">
											#ff00ff
											<input type="hidden" name="picw_mapping[0][color_code]" value="#ff00ff" />
										</td>
										<td class="left">
											<a class="color-box" style="background-color:#ff00ff"></a>
										</td>
										<td class="left">
<select name="picw_mapping[0][option_id]">
	 <option value="-1">Do not link</option>
		<option value="15">color box hex 2	</option>
		<option value="14"	selected>color hex bg</option>
		<option value="13">	color img bg</option>
</select>
										</td>
									</tr></tbody>
							<tbody><tr>
										<td class="left">
											#00a0c6
											<input type="hidden" name="picw_mapping[1][color_code]" value="#00a0c6" />
										</td>
										<td class="left">
											<a class="color-box" style="background-color:#00a0c6"></a>
										</td>
										<td class="left">
		<select name="picw_mapping[1][option_id]">
				<option value="-1">Do not link</option>
				<option value="15" selected	>color box hex 2</option>
				<option value="14">color hex bg</option>
				<option value="13">color img bg</option>
		</select>
										</td>
									</tr></tbody>
																								</table>
						</td>
					</tr>
				</table>
			</div>

			<script type="text/javascript">
			var beforeAnalysingWarning = 'Existing color mappings will be lost. Do you want to continue?';
			var picwColorOption = new Array();

			picwColorOption.push({optionId: "-1", optionName: "Do not link"});

							picwColorOption.push({optionId: "15", optionName: "color box hex 2"});
							picwColorOption.push({optionId: "14", optionName: "color hex bg"});
							picwColorOption.push({optionId: "13", optionName: "color img bg"});


			var noColorFoundMessage = 'No color found or SVG format not supported.';
			</script>
			<script type="text/javascript" src="view/javascript/picw/picw.js"></script>
			<!--EOF PICW-->

      </form>
    </div>
  </div>
</div>
<script type="text/javascript" src="view/javascript/ckeditor/ckeditor.js"></script>
<script type="text/javascript"><!--
CKEDITOR.replace('description1', {
	filebrowserBrowseUrl: 'index.php?route=common/filemanager&token=c6157d95819e6b8448266a5411210929',
	filebrowserImageBrowseUrl: 'index.php?route=common/filemanager&token=c6157d95819e6b8448266a5411210929',
	filebrowserFlashBrowseUrl: 'index.php?route=common/filemanager&token=c6157d95819e6b8448266a5411210929',
	filebrowserUploadUrl: 'index.php?route=common/filemanager&token=c6157d95819e6b8448266a5411210929',
	filebrowserImageUploadUrl: 'index.php?route=common/filemanager&token=c6157d95819e6b8448266a5411210929',
	filebrowserFlashUploadUrl: 'index.php?route=common/filemanager&token=c6157d95819e6b8448266a5411210929'
});
//--></script>
<script type="text/javascript"><!--
$.widget('custom.catcomplete', $.ui.autocomplete, {
	_renderMenu: function(ul, items) {
		var self = this, currentCategory = '';

		$.each(items, function(index, item) {
			if (item.category != currentCategory) {
				ul.append('<li class="ui-autocomplete-category">' + item.category + '</li>');

				currentCategory = item.category;
			}

			self._renderItem(ul, item);
		});
	}
});

// Manufacturer
$('input[name=\'manufacturer\']').autocomplete({
	delay: 500,
	source: function(request, response) {
		$.ajax({
			url: 'index.php?route=catalog/manufacturer/autocomplete&token=c6157d95819e6b8448266a5411210929&filter_name=' +  encodeURIComponent(request.term),
			dataType: 'json',
			success: function(json) {
				response($.map(json, function(item) {
					return {
						label: item.name,
						value: item.manufacturer_id
					}
				}));
			}
		});
	},
	select: function(event, ui) {
		$('input[name=\'manufacturer\']').attr('value', ui.item.label);
		$('input[name=\'manufacturer_id\']').attr('value', ui.item.value);

		return false;
	},
	focus: function(event, ui) {
      return false;
   }
});

// Category
$('input[name=\'category\']').autocomplete({
	delay: 500,
	source: function(request, response) {
		$.ajax({
			url: 'index.php?route=catalog/category/autocomplete&token=c6157d95819e6b8448266a5411210929&filter_name=' +  encodeURIComponent(request.term),
			dataType: 'json',
			success: function(json) {
				response($.map(json, function(item) {
					return {
						label: item.name,
						value: item.category_id
					}
				}));
			}
		});
	},
	select: function(event, ui) {
		$('#product-category' + ui.item.value).remove();

		$('#product-category').append('<div id="product-category' + ui.item.value + '">' + ui.item.label + '<img src="view/image/delete.png" alt="" /><input type="hidden" name="product_category[]" value="' + ui.item.value + '" /></div>');

		$('#product-category div:odd').attr('class', 'odd');
		$('#product-category div:even').attr('class', 'even');

		return false;
	},
	focus: function(event, ui) {
      return false;
   }
});

$('#product-category div img').live('click', function() {
	$(this).parent().remove();

	$('#product-category div:odd').attr('class', 'odd');
	$('#product-category div:even').attr('class', 'even');
});

// Filter
$('input[name=\'filter\']').autocomplete({
	delay: 500,
	source: function(request, response) {
		$.ajax({
			url: 'index.php?route=catalog/filter/autocomplete&token=c6157d95819e6b8448266a5411210929&filter_name=' +  encodeURIComponent(request.term),
			dataType: 'json',
			success: function(json) {
				response($.map(json, function(item) {
					return {
						label: item.name,
						value: item.filter_id
					}
				}));
			}
		});
	},
	select: function(event, ui) {
		$('#product-filter' + ui.item.value).remove();

		$('#product-filter').append('<div id="product-filter' + ui.item.value + '">' + ui.item.label + '<img src="view/image/delete.png" alt="" /><input type="hidden" name="product_filter[]" value="' + ui.item.value + '" /></div>');

		$('#product-filter div:odd').attr('class', 'odd');
		$('#product-filter div:even').attr('class', 'even');

		return false;
	},
	focus: function(event, ui) {
      return false;
   }
});

$('#product-filter div img').live('click', function() {
	$(this).parent().remove();

	$('#product-filter div:odd').attr('class', 'odd');
	$('#product-filter div:even').attr('class', 'even');
});

// Downloads
$('input[name=\'download\']').autocomplete({
	delay: 500,
	source: function(request, response) {
		$.ajax({
			url: 'index.php?route=catalog/download/autocomplete&token=c6157d95819e6b8448266a5411210929&filter_name=' +  encodeURIComponent(request.term),
			dataType: 'json',
			success: function(json) {
				response($.map(json, function(item) {
					return {
						label: item.name,
						value: item.download_id
					}
				}));
			}
		});
	},
	select: function(event, ui) {
		$('#product-download' + ui.item.value).remove();

		$('#product-download').append('<div id="product-download' + ui.item.value + '">' + ui.item.label + '<img src="view/image/delete.png" alt="" /><input type="hidden" name="product_download[]" value="' + ui.item.value + '" /></div>');

		$('#product-download div:odd').attr('class', 'odd');
		$('#product-download div:even').attr('class', 'even');

		return false;
	},
	focus: function(event, ui) {
      return false;
   }
});

$('#product-download div img').live('click', function() {
	$(this).parent().remove();

	$('#product-download div:odd').attr('class', 'odd');
	$('#product-download div:even').attr('class', 'even');
});

// Related
$('input[name=\'related\']').autocomplete({
	delay: 500,
	source: function(request, response) {
		$.ajax({
			url: 'index.php?route=catalog/product/autocomplete&token=c6157d95819e6b8448266a5411210929&filter_name=' +  encodeURIComponent(request.term),
			dataType: 'json',
			success: function(json) {
				response($.map(json, function(item) {
					return {
						label: item.name,
						value: item.product_id
					}
				}));
			}
		});
	},
	select: function(event, ui) {
		$('#product-related' + ui.item.value).remove();

		$('#product-related').append('<div id="product-related' + ui.item.value + '">' + ui.item.label + '<img src="view/image/delete.png" alt="" /><input type="hidden" name="product_related[]" value="' + ui.item.value + '" /></div>');

		$('#product-related div:odd').attr('class', 'odd');
		$('#product-related div:even').attr('class', 'even');

		return false;
	},
	focus: function(event, ui) {
      return false;
   }
});

$('#product-related div img').live('click', function() {
	$(this).parent().remove();

	$('#product-related div:odd').attr('class', 'odd');
	$('#product-related div:even').attr('class', 'even');
});
//--></script>
<script type="text/javascript"><!--
var attribute_row = 0;

function addAttribute() {
	html  = '<tbody id="attribute-row' + attribute_row + '">';
    html += '  <tr>';
	html += '    <td class="left"><input type="text" name="product_attribute[' + attribute_row + '][name]" value="" /><input type="hidden" name="product_attribute[' + attribute_row + '][attribute_id]" value="" /></td>';
	html += '    <td class="left">';
		html += '<textarea name="product_attribute[' + attribute_row + '][product_attribute_description][1][text]" cols="40" rows="5"></textarea><img src="view/image/flags/gb.png" title="English" align="top" /><br />';
    	html += '    </td>';
	html += '    <td class="left"><a onclick="$(\'#attribute-row' + attribute_row + '\').remove();" class="button">Remove</a></td>';
    html += '  </tr>';
    html += '</tbody>';

	$('#attribute tfoot').before(html);

	attributeautocomplete(attribute_row);

	attribute_row++;
}

function attributeautocomplete(attribute_row) {
	$('input[name=\'product_attribute[' + attribute_row + '][name]\']').catcomplete({
		delay: 500,
		source: function(request, response) {
			$.ajax({
				url: 'index.php?route=catalog/attribute/autocomplete&token=c6157d95819e6b8448266a5411210929&filter_name=' +  encodeURIComponent(request.term),
				dataType: 'json',
				success: function(json) {
					response($.map(json, function(item) {
						return {
							category: item.attribute_group,
							label: item.name,
							value: item.attribute_id
						}
					}));
				}
			});
		},
		select: function(event, ui) {
			$('input[name=\'product_attribute[' + attribute_row + '][name]\']').attr('value', ui.item.label);
			$('input[name=\'product_attribute[' + attribute_row + '][attribute_id]\']').attr('value', ui.item.value);

			return false;
		},
		focus: function(event, ui) {
      		return false;
   		}
	});
}

$('#attribute tbody').each(function(index, element) {
	attributeautocomplete(index);
});
//--></script>
<script type="text/javascript"><!--
var option_row = 2;

$('input[name=\'option\']').catcomplete({
	delay: 500,
	source: function(request, response) {
		$.ajax({
			url: 'index.php?route=catalog/option/autocomplete&token=c6157d95819e6b8448266a5411210929&filter_name=' +  encodeURIComponent(request.term),
			dataType: 'json',
			success: function(json) {
				response($.map(json, function(item) {
					return {
						category: item.category,
						label: item.name,
						value: item.option_id,
						type: item.type,
						option_value: item.option_value
					}
				}));
			}
		});
	},
	select: function(event, ui) {
		html  = '<div id="tab-option-' + option_row + '" class="vtabs-content">';
		html += '	<input type="hidden" name="product_option[' + option_row + '][product_option_id]" value="" />';
		html += '	<input type="hidden" name="product_option[' + option_row + '][name]" value="' + ui.item.label + '" />';
		html += '	<input type="hidden" name="product_option[' + option_row + '][option_id]" value="' + ui.item.value + '" />';
		html += '	<input type="hidden" name="product_option[' + option_row + '][type]" value="' + ui.item.type + '" />';
		html += '	<table class="form">';
		html += '	  <tr>';
		html += '		<td>Required:</td>';
		html += '       <td><select name="product_option[' + option_row + '][required]">';
		html += '	      <option value="1">Yes</option>';
		html += '	      <option value="0">No</option>';
		html += '	    </select></td>';
		html += '     </tr>';

		if (ui.item.type == 'text') {
			html += '     <tr>';
			html += '       <td>Option Value:</td>';
			html += '       <td><input type="text" name="product_option[' + option_row + '][option_value]" value="" /></td>';
			html += '     </tr>';
		}

		if (ui.item.type == 'textarea') {
			html += '     <tr>';
			html += '       <td>Option Value:</td>';
			html += '       <td><textarea name="product_option[' + option_row + '][option_value]" cols="40" rows="5"></textarea></td>';
			html += '     </tr>';
		}

		if (ui.item.type == 'file') {
			html += '     <tr style="display: none;">';
			html += '       <td>Option Value:</td>';
			html += '       <td><input type="text" name="product_option[' + option_row + '][option_value]" value="" /></td>';
			html += '     </tr>';
		}

		if (ui.item.type == 'date') {
			html += '     <tr>';
			html += '       <td>Option Value:</td>';
			html += '       <td><input type="text" name="product_option[' + option_row + '][option_value]" value="" class="date" /></td>';
			html += '     </tr>';
		}

		if (ui.item.type == 'datetime') {
			html += '     <tr>';
			html += '       <td>Option Value:</td>';
			html += '       <td><input type="text" name="product_option[' + option_row + '][option_value]" value="" class="datetime" /></td>';
			html += '     </tr>';
		}

		if (ui.item.type == 'time') {
			html += '     <tr>';
			html += '       <td>Option Value:</td>';
			html += '       <td><input type="text" name="product_option[' + option_row + '][option_value]" value="" class="time" /></td>';
			html += '     </tr>';
		}

		html += '  </table>';

		if (ui.item.type == 'select' || ui.item.type == 'color' || ui.item.type == 'radio' || ui.item.type == 'checkbox' || ui.item.type == 'image') {
			html += '  <table id="option-value' + option_row + '" class="list">';
			html += '  	 <thead>';
			html += '      <tr>';
			html += '        <td class="left">Option Value:</td>';
			html += '        <td class="right">Quantity:</td>';
			html += '        <td class="left">Subtract Stock:</td>';
			html += '        <td class="right">Price:</td>';
			html += '        <td class="right">Points:</td>';
			html += '        <td class="right">Weight:</td>';

            if(ui.item.type != 'checkbox'){
            html += '        <td class="right">Image:</td>';
            }
			html += '        <td></td>';
			html += '      </tr>';
			html += '  	 </thead>';
			html += '    <tfoot>';
			html += '      <tr>';

            if(ui.item.type != 'checkbox'){
            html += '        <td colspan="7"></td>';
            } else {
            html += '        <td colspan="6"></td>';
            }
			html += '        <td class="left"><a onclick="addOptionValue(' + option_row + ');" class="button">Add Option Value</a></td>';
			html += '      </tr>';
			html += '    </tfoot>';
			html += '  </table>';
            html += '  <select id="option-values' + option_row + '" style="display: none;">';

            for (i = 0; i < ui.item.option_value.length; i++) {
				html += '  <option value="' + ui.item.option_value[i]['option_value_id'] + '">' + ui.item.option_value[i]['name'] + '</option>';
            }

            html += '  </select>';
			html += '</div>';
		}

		$('#tab-option').append(html);

		$('#option-add').before('<input type="hidden" id="option-' + option_row + '" value="'+ui.item.type+'"/><a href="#tab-option-' + option_row + '" id="option-' + option_row + '">' + ui.item.label + '&nbsp;<img src="view/image/delete.png" alt="" onclick="$(\'#option-' + option_row + '\').remove(); $(\'#tab-option-' + option_row + '\').remove(); $(\'#vtab-option a:first\').trigger(\'click\'); return false;" /></a>');

		$('#vtab-option a').tabs();

		$('#option-' + option_row).trigger('click');

		$('.date').datepicker({dateFormat: 'yy-mm-dd'});
		$('.datetime').datetimepicker({
			dateFormat: 'yy-mm-dd',
			timeFormat: 'h:m'
		});

		$('.time').timepicker({timeFormat: 'h:m'});

		option_row++;

		return false;
	},
	focus: function(event, ui) {
      return false;
   }
});
//--></script>
<script type="text/javascript"><!--
var option_value_row = 6;

function addOptionValue(option_row) {
	html  = '<tbody id="option-value-row' + option_value_row + '">';
	html += '  <tr>';
	html += '    <td class="left"><select name="product_option[' + option_row + '][product_option_value][' + option_value_row + '][option_value_id]">';
	html += $('#option-values' + option_row).html();
	html += '    </select><input type="hidden" name="product_option[' + option_row + '][product_option_value][' + option_value_row + '][product_option_value_id]" value="" /></td>';
	html += '    <td class="right"><input type="text" name="product_option[' + option_row + '][product_option_value][' + option_value_row + '][quantity]" value="" size="3" /></td>';
	html += '    <td class="left"><select name="product_option[' + option_row + '][product_option_value][' + option_value_row + '][subtract]">';
	html += '      <option value="1">Yes</option>';
	html += '      <option value="0">No</option>';
	html += '    </select></td>';
	html += '    <td class="right"><select name="product_option[' + option_row + '][product_option_value][' + option_value_row + '][price_prefix]">';
	html += '      <option value="+">+</option>';
	html += '      <option value="-">-</option>';
	html += '    </select>';
	html += '    <input type="text" name="product_option[' + option_row + '][product_option_value][' + option_value_row + '][price]" value="" size="5" /></td>';
	html += '    <td class="right"><select name="product_option[' + option_row + '][product_option_value][' + option_value_row + '][points_prefix]">';
	html += '      <option value="+">+</option>';
	html += '      <option value="-">-</option>';
	html += '    </select>';
	html += '    <input type="text" name="product_option[' + option_row + '][product_option_value][' + option_value_row + '][points]" value="" size="5" /></td>';
	html += '    <td class="right"><select name="product_option[' + option_row + '][product_option_value][' + option_value_row + '][weight_prefix]">';
	html += '      <option value="+">+</option>';
	html += '      <option value="-">-</option>';
	html += '    </select>';
	html += '    <input type="text" name="product_option[' + option_row + '][pro</inputtion_value][' + option_value_row + '][weight]" value="" size="5" /></td>';

      var myElement = document.getElementById('option-'+ option_row).value;
      if(myElement != "checkbox"){
      html += '    <td><div class="image"><img src="http://localhost/oc15/image/cache/no_image-100x100.jpg" alt="" id="thumb' + option_value_row + '"/><input type="hidden" name="product_option['+ option_row +'][product_option_value][' + option_value_row + '][image]" value="" id="image' + option_value_row + '" /><br /><a onclick="image_upload(\'image' + option_value_row + '\', \'thumb' + option_value_row + '\');">Browse</a>&nbsp;&nbsp;|&nbsp;&nbsp;<a onclick="$(\'#thumb' + option_value_row + '\').attr(\'src\', \'http://localhost/oc15/image/cache/no_image-100x100.jpg\'); $(\'#image' + option_value_row + '\').attr(\'value\', \'\');">Clear</a></div></td>';
      }
	html += '    <td class="left"><a onclick="$(\'#option-value-row' + option_value_row + '\').remove();" class="button">Remove</a></td>';
	html += '  </tr>';
	html += '</tbody>';

	$('#option-value' + option_row + ' tfoot').before(html);

	option_value_row++;
}
//--></script>
<script type="text/javascript"><!--
var discount_row = 0;

function addDiscount() {
	html  = '<tbody id="discount-row' + discount_row + '">';
	html += '  <tr>';
    html += '    <td class="left"><select name="product_discount[' + discount_row + '][customer_group_id]">';
        html += '      <option value="1">Default</option>';
        html += '    </select></td>';
    html += '    <td class="right"><input type="text" name="product_discount[' + discount_row + '][quantity]" value="" size="2" /></td>';
    html += '    <td class="right"><input type="text" name="product_discount[' + discount_row + '][priority]" value="" size="2" /></td>';
	html += '    <td class="right"><input type="text" name="product_discount[' + discount_row + '][price]" value="" /></td>';
    html += '    <td class="left"><input type="text" name="product_discount[' + discount_row + '][date_start]" value="" class="date" /></td>';
	html += '    <td class="left"><input type="text" name="product_discount[' + discount_row + '][date_end]" value="" class="date" /></td>';
	html += '    <td class="left"><a onclick="$(\'#discount-row' + discount_row + '\').remove();" class="button">Remove</a></td>';
	html += '  </tr>';
    html += '</tbody>';

	$('#discount tfoot').before(html);

	$('#discount-row' + discount_row + ' .date').datepicker({dateFormat: 'yy-mm-dd'});

	discount_row++;
}
//--></script>
<script type="text/javascript"><!--
var special_row = 0;

function addSpecial() {
	html  = '<tbody id="special-row' + special_row + '">';
	html += '  <tr>';
    html += '    <td class="left"><select name="product_special[' + special_row + '][customer_group_id]">';
        html += '      <option value="1">Default</option>';
        html += '    </select></td>';
    html += '    <td class="right"><input type="text" name="product_special[' + special_row + '][priority]" value="" size="2" /></td>';
	html += '    <td class="right"><input type="text" name="product_special[' + special_row + '][price]" value="" /></td>';
    html += '    <td class="left"><input type="text" name="product_special[' + special_row + '][date_start]" value="" class="date" /></td>';
	html += '    <td class="left"><input type="text" name="product_special[' + special_row + '][date_end]" value="" class="date" /></td>';
	html += '    <td class="left"><a onclick="$(\'#special-row' + special_row + '\').remove();" class="button">Remove</a></td>';
	html += '  </tr>';
    html += '</tbody>';

	$('#special tfoot').before(html);

	$('#special-row' + special_row + ' .date').datepicker({dateFormat: 'yy-mm-dd'});

	special_row++;
}
//--></script>
<script type="text/javascript"><!--
function image_upload(field, thumb) {
	$('#dialog').remove();

	$('#content').prepend('<div id="dialog" style="padding: 3px 0px 0px 0px;"><iframe src="index.php?route=common/filemanager&token=c6157d95819e6b8448266a5411210929&field=' + encodeURIComponent(field) + '" style="padding:0; margin: 0; display: block; width: 100%; height: 100%;" frameborder="no" scrolling="auto"></iframe></div>');

	$('#dialog').dialog({
		title: 'Image Manager',
		close: function (event, ui) {
			if ($('#' + field).attr('value')) {
				$.ajax({
					url: 'index.php?route=common/filemanager/image&token=c6157d95819e6b8448266a5411210929&image=' + encodeURIComponent($('#' + field).attr('value')),
					dataType: 'text',
					success: function(text) {
						$('#' + thumb).replaceWith('<img src="' + text + '" alt="" id="' + thumb + '" />');
					}
				});
			}
		},
		bgiframe: false,
		width: 800,
		height: 400,
		resizable: false,
		modal: false
	});
};
//--></script>
<script type="text/javascript"><!--
var image_row = 0;

function addImage() {
    html  = '<tbody id="image-row' + image_row + '">';
	html += '  <tr>';
	html += '    <td class="left"><div class="image"><img src="http://localhost/oc15/image/cache/no_image-100x100.jpg" alt="" id="thumb' + image_row + '" /><input type="hidden" name="product_image[' + image_row + '][image]" value="" id="image' + image_row + '" /><br /><a onclick="image_upload(\'image' + image_row + '\', \'thumb' + image_row + '\');">Browse</a>&nbsp;&nbsp;|&nbsp;&nbsp;<a onclick="$(\'#thumb' + image_row + '\').attr(\'src\', \'http://localhost/oc15/image/cache/no_image-100x100.jpg\'); $(\'#image' + image_row + '\').attr(\'value\', \'\');">Clear</a></div></td>';
	html += '    <td class="right"><input type="text" name="product_image[' + image_row + '][sort_order]" value="" size="2" /></td>';
	html += '    <td class="left"><a onclick="$(\'#image-row' + image_row  + '\').remove();" class="button">Remove</a></td>';
	html += '  </tr>';
	html += '</tbody>';

	$('#images tfoot').before(html);

	image_row++;
}
//--></script>
<script type="text/javascript" src="view/javascript/jquery/ui/jquery-ui-timepicker-addon.js"></script>
<script type="text/javascript"><!--
$('.date').datepicker({dateFormat: 'yy-mm-dd'});
$('.datetime').datetimepicker({
	dateFormat: 'yy-mm-dd',
	timeFormat: 'h:m'
});
$('.time').timepicker({timeFormat: 'h:m'});
//--></script>
<script type="text/javascript"><!--
$('#tabs a').tabs();
$('#languages a').tabs();
$('#vtab-option a').tabs();

var profileCount = 0;

function addProfile() {
    profileCount++;

    var html = '';
    html += '<tr id="profile-row' + profileCount + '">';
    html += '  <td class="left">';
    html += '    <select name="product_profiles[' + profileCount + '][profile_id]">';
        html += '    </select>';
    html += '  </td>';
    html += '  <td class="left">';
    html += '    <select name="product_profiles[' + profileCount + '][customer_group_id]">';
        html += '      <option value="1">Default</option>';
        html += '    <select>';
    html += '  </td>';
    html += '  <td class="left">';
    html += '    <a class="button" onclick="$(\'#profile-row' + profileCount + '\').remove()">Remove</a>';
    html += '  </td>';
    html += '</tr>';

    $('#tab-profile table tbody').append(html);
}

    function openbayLinkStatus(){
        var product_id = '50';
        $.ajax({
            type: 'GET',
            url: 'index.php?route=extension/openbay/linkStatus&token=c6157d95819e6b8448266a5411210929&product_id='+product_id,
            dataType: 'html',
            success: function(data) {
                //add the button to nav
                $('<a href="#tab-openbay">Marketplace Links</a>').hide().appendTo("#tabs").fadeIn(1000);
                $('#tab-general').before(data);
                $('#tabs a').tabs();
            },
            failure: function(){

            },
            error: function() {

            }
        });
    }

    $(document).ready(function(){
        openbayLinkStatus();
    });

//--></script>

</div>
<div id="footer"><a href="http://www.opencart.com">OpenCart</a> &copy; 2009-2015 All Rights Reserved.<br />Version 1.5.6.4</div>
</body></html>