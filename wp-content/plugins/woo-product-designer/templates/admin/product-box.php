<?php

global $nm_wcpd;
$woo_pd = get_post_meta($designid, 'woo_pd', true);

$wpd_options = json_decode($woo_pd, true);
// var_dump($wpd_options);

?>
<style>
	#wcpd-plugin label {
		color: #333333;
		font-size: 13px;
		line-height: 1.5em;
		font-weight: bold;
		padding: 0;
		margin: 0 0 3px;
		display: block;
		vertical-align: text-bottom;
	}
	#wcpd-plugin li img {
		max-width: 100%;
	}
	#wcpd-plugin li .del-it {
		position: absolute;
		right: -8px;
		top: -8px;
		cursor: pointer;
	}
	#wcpd-plugin table {
		width: 100%;
	}
	#wcpd-plugin input[type="checkbox"] {
		display: none;
	}
	#wcpd-plugin .thumbs-prev {
		list-style-type: none;
	}
	#wcpd-plugin .thumbs-prev li {
		width: 100px;
		float: left;
		position: relative;
		border: 1px solid #ccc;
		text-align: center;
		height: 100px;
		margin-right: 10px;
	}
	#wcpd-plugin .p-box {
		border: 1px solid #eee;
		padding: 10px;		
	}
</style>
<div id="wcpd-plugin">
	<div class="wrap-templates p-box">
		<h2>Templates Contents</h2>
		<p>These templates will be rendered as statics Canvas which can only be resized like T-Shirts, Mugs, Mobile covers etc. Clients will choose each template at a time and will design by addding
		<strong>Shapes, Text or Images</strong> uploaded by him.
		</p>
		<button class="button nm-media-upload" id="wcpd_templates">Upload</button>
		<ul class="thumbs-prev">
			<?php 
			if ($wpd_options['templates'] != '') {
					foreach ($wpd_options['templates'] as $key => $value) {
						echo '<li><img src="'.$value.'"><input type="checkbox" name="'.$key.'" value="'.$value.'"><img src="'.$this-> plugin_meta['url'].'/images/cross.png" class="del-it"></li>';
					}
			}
			?>
		</ul>
		<p style="clear: both;"></p>
	</div>
	<hr>
	<div class="wrap-shapes p-box">
		<h2>Shapes</h2>
		<p>Pre defined set of images ‘shapes’ is just like library images to help client to design his product.</p>
		<button class="button nm-media-upload" id="wcpd_shapes">Upload</button>
		<ul class="thumbs-prev">
			<?php 
				if ($wpd_options['shapes'] != '') {
					foreach ($wpd_options['shapes'] as $key => $value) {
						echo '<li><img src="'.$value.'"><input type="checkbox" name="'.$key.'" value="'.$value.'"><img src="'.$this-> plugin_meta['url'].'/images/cross.png" class="del-it"></li>';
					}
				}
			?>				
		</ul>
		<p style="clear: both;"></p>
	</div>
	<hr>
	<div class="wrap-uploader p-box">
		<h2>Client Image Settings</h2>
		<table>
			<tr>
				<td><label for="wcpd_upload_title">Upload Button Label</label></td>
				<td><input type="text" name="wcpd_upload_title" id="wcpd_upload_title" value="<?php echo $wpd_options['btn_label']; ?>"></td>
				<td>It is label for upload button</td>
			</tr>
			<tr>
				<td><label for="wcpd_upload_size">Image Size</label></td>
				<td><input type="text" name="wcpd_upload_size" id="wcpd_upload_size" value="<?php echo $wpd_options['file_size']; ?>"></td>
				<td>Maximum image size for upload by user (in MBs)</td>
			</tr>
			<tr>
				<td><label for="wcpd_upload_type">Image Types</label></td>	
				<td><input type="text" name="wcpd_upload_type" id="wcpd_upload_type" value="<?php echo $wpd_options['file_types']; ?>"></td>
				<td>Allowed image types separated by commas</td>
			</tr>
		</table>
	</div>
	<hr>
	<div class="p-box">
		<h2>Select Product</h2>
		<p>Please select any product from list to attach this design.</p>
		<label for="wcpd_product">Attach this design with</label>
		 <?php 
		 	$product_args = array(
		 			'post_type' => 'product',
		 			'posts_per_page' => -1
		 		);
		 	$mypostype = get_posts($product_args);?>

		    <select id="wcpd_product" name="wcpd_product">
			    <?php foreach ( $mypostype as $mypost  ) : ?>
			    <option value="<?php echo $mypost->ID; ?>" <?php selected( $wpd_options['attach_with'], $mypost->ID, true); ?>><?php echo $mypost->post_title; ?></option>
			    <?php endforeach; ?>
		    </select>
	</div>
	<input type="hidden" name="save_woo_product" id="save-woo-product" value="<?php echo esc_attr($woo_pd); ?>">
	<button class="button button-primary" id="save-product">Save Product Designer</button>
</div>

<?php
/*if(function_exists('add_thickbox'))
	add_thickbox();*/
?>

 <script type="text/javascript">
 <!--
 var nm_plugin_url = "<?php echo $nm_wcpd->plugin_meta['url'];?>";

	jQuery(function($){
	    $(".nm-media-upload").on('click', function(e){
	    	e.preventDefault();
	    	
	    	var the_parent = $(this).closest('div');
	    	
	    	wp.media.editor.send.attachment = function(props, attachment)
			{

				var fileurl = attachment.url;
					var checkbx = '<input type="checkbox" name="pre_images['+attachment.id+']" value="'+fileurl+'">';


				if(fileurl){
		        	var image_box = '<li><img src="'+fileurl+'">'+checkbx+'<img src="'+nm_plugin_url+'images/cross.png" class="del-it"></li>';
		        	the_parent.find('.thumbs-prev').append(image_box);
				}
				
			}
			
			wp.media.editor.open();
			return false;
	    });

	    $("#save-product").on('click', function(e) {
	    	e.preventDefault();

	    	var templates = {};
	    	$(".wrap-templates").find('input').each(function(index) {
	    		templates[this.name] = $(this).val();
	    	});

	    	var shapes = {};
	    	$(".wrap-shapes").find('input').each(function(index) {
	    		shapes[this.name] = $(this).val();
	    	});

	    	var data = {
	    		templates: templates,
	    		shapes: shapes,
	    		btn_label: $("#wcpd_upload_title").val(),
	    		file_size: $("#wcpd_upload_size").val(),
	    		file_types: $("#wcpd_upload_type").val(),
	    		attach_with: $("#wcpd_product").val(),
	    	}
	    	$('#save-woo-product').val(JSON.stringify(data));
	    	$('#publish').click();
	    });	

	    // Removing images

	    $('.del-it').on('click', function() {
	    	$(this).closest('li').remove();
	    });

	});
//-->
</script>