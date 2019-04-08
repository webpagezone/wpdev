<?php
/**
 * 
 * Template to render product designer
 * 
 **/

if( ! defined("ABSPATH") )
	die('Not allowed');
	
	
$woo_pd = get_post_meta($this -> design_id, 'woo_pd', true);
$wpd_options = json_decode($woo_pd, true);
if($this -> if_browser_is_ie())
    $runtimes = 'flash';
else 
    $runtimes = 'html5,flash,silverlight,html4,browserplus,gear';

// var_dump($wpd_options);
$canSize = ($this->get_option('_canvas_size') != '') ? $this->get_option('_canvas_size') : '500' ;
 ?>
	<!--<link href="<?php echo $this-> plugin_meta['url']; ?>templates/css/bootstrap.min.css" rel="stylesheet">
	<link href="<?php echo $this-> plugin_meta['url']; ?>templates/css/bootstrap-theme.min.css" rel="stylesheet">-->
	<link href="<?php echo $this-> plugin_meta['url']; ?>templates/css/style.css" rel="stylesheet">

  <!-- HTML5 shim, for IE6-8 support of HTML5 elements -->
  <!--[if lt IE 9]>
    <script src="js/html5shiv.js"></script>
  <![endif]-->
	<!--<script type="text/javascript" src="<?php echo $this-> plugin_meta['url']; ?>templates/js/bootstrap.min.js"></script>-->
	<script type="text/javascript" src="<?php echo $this-> plugin_meta['url']; ?>templates/js/fabric.min.js"></script>
	<script type="text/javascript" src="<?php echo $this-> plugin_meta['url']; ?>templates/js/script.js"></script>

<!-- Bootrap CDN -->
<link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0-alpha.6/css/bootstrap.min.css" integrity="sha384-rwoIResjU2yc3z8GV/NPeZWAv56rSmLldC3R/AZzGRnGxQQKnKkoFVhFQhNUwEyJ" crossorigin="anonymous">
<script src="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0-alpha.6/js/bootstrap.min.js" integrity="sha384-vBWWzlZJ8ea9aCX4pEW3rVHjgjt7zpkNpZk+02D9phzyeVkE+jo0ieGizqPLForn" crossorigin="anonymous"></script>
<style>
	.designbtn{
		padding: 10px;
		background-color: <?php echo $this->get_option('_bg_color'); ?> !important;
		color: <?php echo $this->get_option('_font_color'); ?> !important;
		border-radius: 3px;
		text-decoration: none;
	}
</style>
<span id="cansize" data-cansize="<?php echo $canSize; ?>"></span>
<p style="text-align: center;height: auto;padding: 15px;border: 1px dotted #eee;">
	<a href="#TB_inline?width=1250&height=600&inlineId=woo-designer-area" class="thickbox designbtn" title="<?php _e('Design', 'nm-wcpd');?>">
		<?php echo $title = ($this->get_option('_btn_title')) ? $this->get_option('_btn_title') : 'Design Product' ; ?></a>
		
	<a data-toggle="modal" data-target="#myModal">Design</a>
</p>


<!-- this input will Hold all the canvas.toJson() data to pass through in cart -->
<input type="hidden" name="nm_canvases" id="nm_canvases">

<button type="button" class="btn btn-info btn-lg" data-toggle="modal" data-target="#myModal2">Open Modal</button>

<!-- Modal -->
<div id="myModal2" class="modal fade container" role="dialog">
  <div class="modal-dialog">

    <!-- Modal content-->
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">Modal Header</h4>
      </div>
      <div class="modal-body">
        <p>Some text in the modal.</p>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
      </div>
    </div>

  </div>
</div>


<div class="modal fade" id="myModal" role="dialog">
	<div class="modal-dialog modal-lg">
		
	<!-- Modal content-->
    <div class="modal-content">
    	
    <div class="modal-body">
    	
	<div class="row clearfix">
		<div class="col-sm-8 col-xs-12 col-md-push-2">
			<div class="row">
				<div class="col-md-12 text-center" id="nm-toolbar">
					<br>
					<div id="delete-btn" class="btn-group btn-group-sm" role="group" aria-label="sdsdsd">
					  <button id="delete-it" class="btn btn-default disabled"><span class="glyphicon glyphicon-trash"></span>
					  	<?php _e( 'Delete', 'nm-wcpd' ); ?>
					  </button>
					  <button id="zoom-in" class="btn btn-default"><span class="glyphicon glyphicon-zoom-in"></span>
					  	<?php _e( 'Zoom in', 'nm-wcpd' ); ?>
					  </button>
					  <button id="reset-zoom" class="btn btn-default"><span class="glyphicon glyphicon-refresh"></span>
					  	<?php _e( 'Reset zoom', 'nm-wcpd' ); ?>
					  </button>
					  <button id="zoom-out" class="btn btn-default"><span class="glyphicon glyphicon-zoom-out"></span>
					  	<?php _e( 'Zoom out', 'nm-wcpd' ); ?>
					  </button>
					  <button id="clear-canvas" class="btn btn-default"><span class="glyphicon glyphicon-home"></span>
					  	<?php _e( 'Clear all', 'nm-wcpd' ); ?>
					  </button>
					  <button id="bring-front-btn" class="btn btn-default"><span class="glyphicon glyphicon-level-up"></span>
					  	<?php _e( 'Bring Front', 'nm-wcpd' ); ?>
					  </button>
					  <button id="clone-object" class="btn btn-default disabled"><span class="glyphicon glyphicon-duplicate"></span>
					  	<?php _e( 'Clone', 'nm-wcpd' ); ?>
					  </button>
					  <a href="#" download="preview.png" id="save-image" class="btn btn-default">
					  	<span class="glyphicon glyphicon-save-file"></span>
					  	<?php _e( 'Save Image', 'nm-wcpd' ); ?>
					  </a>
					  <button id="proceed" class="btn btn-sm btn-success"><span class="glyphicon glyphicon-menu-right"></span><?php _e( 'Proceed', 'nm-wcpd' ); ?></button>
					</div>
				</div>
			</div>
			
			<br>
			<div class="row" id="saving-canvases">
				<div class="progress">
				  <div class="progress-bar progress-bar-striped active progress-bar-success" role="progressbar" 
				   style="width:0%">
				    <?php _e( 'Proceeding...', 'nm-wcpd' ); ?>
				  </div>
				</div>				
			</div>
			<div class="row">
				<div class="col-md-12" id="insert-canvases">
					
				</div>
			</div>
		</div>	
		<div class="col-sm-2 col-xs-12 col-md-pull-8">
			<div class="panel-group" id="panel-199619">
				<div class="panel panel-default">
					<div class="panel-heading">
						 <a class="panel-title collapsed" data-toggle="collapse" data-parent="#panel-199619" href="#templates-container"><?php _e( 'Templates', 'nm-wcpd' ); ?></a>
					</div>
					<div id="templates-container" class="panel-collapse in">
						<div class="panel-body">
							<div class="row">
								<?php
									$id_counter = 0;
									foreach ($wpd_options['templates'] as $key => $value) {
										echo '<div class="col-xs-12 design-boxes"><img data-cid="c'.$id_counter.'" src="'.$value.'" alt="'.$key.'"></div>';
										$id_counter++;
									}
								?>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>

		<div class="col-sm-2 col-xs-12">
			<div class="panel-group" id="panel-950588">

				<!-- text edit panel -->

				<div class="panel panel-default text-edit-panel">
					<div class="panel-heading">
						 <a class="panel-title" id="edit-this-text" href="#"><?php _e( 'Edit Text', 'nm-wcpd' ); ?></a>
					</div>
					<div id="change-text-styles" class="panel-collapse">
						<div class="panel-body">
							<div class="form-group">
								<input type="text" class="form-control" id="edit-text">
							</div>
							<div class="form-group">
						    	<label class="checkbox-inline">
						      		<input type="checkbox" id="bold-text"> <?php _e( 'Bold', 'nm-wcpd' ); ?>
						    	</label>
						    	<label class="checkbox-inline">
						      		<input type="checkbox" id="italic-text"> <?php _e( 'Italic', 'nm-wcpd' ); ?>
						    	</label>
						    </div>
						  	<div class="form-group">
						    	<label for="color-text"><?php _e( 'Color', 'nm-wcpd' ); ?>: </label>
						      	<input type="color" class="form-control" id="color-text">
						  	</div>
							
							<?php
								$add_fonts = $this->get_option('_custom_fonts');
								$add_fonts_arr = explode('\n', $add_fonts);
							?>
						  	<div class="form-group">
						    	<label for="font-famil"><?php _e( 'Font Family', 'nm-wcpd' ); ?>: </label>
						      	<select name="font-famil" id="font-famil" class="form-control">
						      		<option value="arial" selected="selected">Arial</option>
						      		<option value="arial black">Arial Black</option>
						      		<option value="cursive">Cursive</option>
						      		<option value="comic sans ms">Comic Sans MS</option>
						      		<option value="fantasy">Fantasy</option>
						      		<option value="georgia">Georgia</option>
						      		<option value="helvetica">Helvetica</option>
						      		<option value="impact">Impact</option>
						      		<option value="lucida console">Lucida Console</option>
						      		<option value="monospace">Monospace</option>
						      		<option value="palatino linotype">Palatino Linotype</option>
						      		<option value="serif">Serif</option>
						      		<option value="sans-serif">Sans-Serif</option>
						      		<option value="tahoma">Tahoma</option>
						      		<option value="times new roman">Times New Roman</option>
						      		<option value="trebuchet ms">Trebuchet MS</option>
						      		<option value="verdana">Verdana</option>
						      		<?php
						      			if(is_array($add_fonts_arr) && !empty($add_fonts_arr)){
						      				foreach($add_fonts_arr as $font){
						      					if($font != ''){
						      						echo '<option value="'.trim($font).'">'.$font.'</option>';
						      					}
						      				}
						      			}
						      		?>
						      	</select>
						  	</div>

						  	<div class="form-group">
						    	<label for="text-decor"><?php _e( 'Text Decoration', 'nm-wcpd' ); ?>: </label>
						      	<select name="text-decor" id="text-decor" class="form-control">
						      		<option value="underline"><?php _e( 'Underline', 'nm-wcpd' ); ?></option>
						      		<option value="line-through"><?php _e( 'Line Through', 'nm-wcpd' ); ?></option>
						      		<option value="overline"><?php _e( 'Overline', 'nm-wcpd' ); ?></option>
						      		<option value="none" selected="selected"><?php _e( 'None', 'nm-wcpd' ); ?></option>
						      	</select>
						  	</div>

						  	<div class="form-group">
						    	<label for="font-size"><?php _e( 'Font Size', 'nm-wcpd' ); ?>: </label>
						      	<input type="number" name="font-size" id="font-size" min="0" class="form-control" />
						  	</div>

						</div>
					</div>
				</div>	

				<!-- image edit panel -->

				<div class="panel panel-default image-edit-panel">
					<div class="panel-heading">
						 <a class="panel-title" href="#"><?php _e( 'Edit Image', 'nm-wcpd' ); ?></a>
					</div>
					<div class="panel-collapse">
						<div class="panel-body">
							<div class="checkbox">
								<label><input type="checkbox" id="grayscale-filter" value="0"> <?php _e( 'Grayscale', 'nm-wcpd' ); ?></label>
							</div>
							<div class="checkbox">
								<label><input type="checkbox" id="sepia-filter" value="1"> <?php _e( 'Sepia', 'nm-wcpd' ); ?></label>
							</div>
							<div class="checkbox">
								<label><input type="checkbox" id="invert-filter" value="2"> <?php _e( 'Sepia 2', 'nm-wcpd' ); ?></label>
							</div>
							<div class="checkbox">
								<label><input type="checkbox" id="emboss-filter" value="3"> <?php _e( 'Invert', 'nm-wcpd' ); ?></label>
							</div>
						  	<div class="form-group">
						    	<label for="color-image"><?php _e( 'Color', 'nm-wcpd' ); ?>: </label>
						      	<input type="color" class="form-control" id="color-image">
						  	</div>
						</div>
					</div>
				</div>

				<!-- shapes panel -->

				<div class="panel panel-default">
					<div class="panel-heading">
						 <a class="panel-title collapsed" data-toggle="collapse" data-parent="#panel-950588" href="#shapes-container"><?php _e( 'Add Shapes', 'nm-wcpd' ); ?></a>
					</div>
					<div id="shapes-container" class="panel-collapse in">
						<div class="panel-body">
							<div class="row">
								<?php 
									foreach ($wpd_options['shapes'] as $key => $value) {
										echo '<div class="col-xs-12 design-boxes"><img src="'.$value.'" alt="'.$key.'"></div>';
									}
								?>
							</div>
						</div>
					</div>
				</div>

				<!-- text adding panel -->

				<div class="panel panel-default">
					<div class="panel-heading">
						 <a class="panel-title collapsed" data-toggle="collapse" data-parent="#panel-950588" href="#text-container"><?php _e( 'Add Text', 'nm-wcpd' ); ?></a>
					</div>
					<div id="text-container" class="panel-collapse collapse">
						<div class="panel-body">
							<input type="text" class="form-control" id="enter-text"><br>
							<button class="btn btn-default btn-block" id="insert-text">Add</button>
						</div>
					</div>
				</div>

				<!-- custom upload panel -->

				<div class="panel panel-default">
					<div class="panel-heading">
						 <a class="panel-title collapsed" data-toggle="collapse" data-parent="#panel-950588" href="#panel-element-491562"><?php _e( 'Custom Upload', 'nm-wcpd' ); ?></a>
					</div>
					<div id="panel-element-491562" class="panel-collapse collapse">
						<div class="panel-body" id="nm-uploadfile">
							
							<?php
							$nm_file_size      = $this -> get_option ( '_max_file_size' );
				 			$nm_file_types     = $this -> get_option ( '_file_types' );
				 			$nm_files_allowed  = $this -> get_option ( '_max_files' );

						  $nm_file_size 		= (!$nm_file_size == '') ? $nm_file_size : '5mb';
						  $nm_file_types		= (!$nm_file_types == '') ? $nm_file_types : 'jpg,png,gif,zip,pdf';
						  $nm_files_allowed	= (!$nm_files_allowed == '') ? $nm_files_allowed : 3;
						  
				 			?>
				 			
				 			<em><?php printf( __('File max size: %s', 'nm-wcpd'), $nm_file_size);?></em><br />
	            <em><?php printf( __('File types: %s', 'nm-wcpd'), $nm_file_types);?></em><br />
             	<em><?php printf( __('Files allowed: %s', 'nm-wcpd'), $nm_files_allowed);?></em><br />
							<button class="btn btn-default btn-block" id="select-button">Upload</button>
							
							<div id="filelist-uploadfile" class="filelist"></div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	
	</div>  <!--modal-body-->
	</div>	<!--modal-content-->
	</div>	<!--modal-dialog-->
</div>

<?php
add_thickbox();
?>

<script>
	<!--
	var file_count_wcpd = 1;
	var running_quota = 0;
	var uploader_wcpd;
	
	jQuery(document).ready(function($) {
   
   	// delete file
	$(".filelist").on('click', '.u_i_c_tools_del', function(e){
		e.preventDefault();

		// console.log($(this));
		var del_message = '<?php _e('are you sure to delete this file?', 'nm-personalizedproduct')?>';
		var a = confirm(del_message);
		if(a){
			// it is removing from uploader instance
			var fileid = $(this).closest('.u_i_c_box').attr("data-fileid");
			
			uploader_wcpd.removeFile(fileid);

			var filename  = jQuery('input:checkbox[name="uploaded_files['+fileid+']"]').val();
			
			// it is removing physically if uploaded
			jQuery("#u_i_c_"+fileid).find('img').attr('src', nm_wcpd_vars.plugin_url+'/images/loading.gif');
			
			// console.log('filename uploaded_files['+fileid+']');
			var data = {action: 'nm_wcpd_delete_file', file_name: filename};
			
			jQuery.post(nm_wcpd_vars.ajaxurl, data, function(resp){
				alert(resp);
				jQuery("#u_i_c_"+fileid).hide(500).remove();

				// it is removing for input Holder
				jQuery('input:checkbox[name="uploaded_files['+fileid+']"]').remove();
				file_count_wcpd--;		
				
			});
		}
	});

    $('#fileupload-button').on('click', function(e)  {
    	e.preventDefault();
    	$('#form-save-new-file').submit();
    });
    

    // file uploader script
    var $filelist_DIV = $('#filelist-uploadfile');
    uploader_wcpd = new plupload.Uploader({
		runtimes 			: '<?php echo $runtimes; ?>',
		browse_button 		: 'select-button', // you can pass in id...
		container			: 'nm-uploadfile', // ... or DOM Element itself
		drop_element		: 'nm-uploadfile',
		url 				: '<?php echo admin_url( 'admin-ajax.php', (is_ssl() ? 'https' : 'http') );?>',
		multipart_params 	: {'action' : 'nm_wcpd_upload_file'},
		max_file_size 		: '<?php echo $nm_file_size;?>',
		  
	  chunk_size: '1mb',
		
	    // Flash settings
		flash_swf_url 		: '<?php echo $this -> plugin_meta['url']?>/js/plupload-2.1.2/js/uploader/Moxie.swf',
		// Silverlight settings
		silverlight_xap_url : '<?php echo $this -> plugin_meta['url']?>/js/plupload-2.1.2/js/uploader/Moxie.xap',
		
		filters : {
			mime_types: [
				{title : "Filetypes", extensions : "<?php echo $nm_file_types;?>"}
			]
		},
		
		init: {
			PostInit: function() {
				$filelist_DIV.html('');

			},

			FilesAdded: function(up, files) {

				var files_added = files.length;
						var max_count_error = false;
	
						//console.log((file_count_wcpd + files_added));
						if((file_count_wcpd + files_added) > <?php echo $nm_files_allowed;?>){
							alert(uploader_wcpd.settings.max_file_count + nm_wcpd_vars.messages.file_count_limit);
						}else{
							
							
							plupload.each(files, function (file) {
								file_count_wcpd++;
					    		// Code to add pending file details, if you want
					            add_thumb_box(file, $filelist_DIV, up);
					            setTimeout('uploader_wcpd.start()', 100);
					        });
						}

			    
			},
			
			FileUploaded: function(up, file, info){
				
				/* console.log(up);*/
				console.log(file);
				
				var obj_resp = $.parseJSON(info.response);
			
				$filelist_DIV.find('#u_i_c_' + file.id).html(obj_resp.html);
			
				// console.log(obj_resp.html);
				// adding checkbox input to Hold uploaded file name as array
				$filelist_DIV.append('<input style="display:none" checked="checked" type="checkbox" value="'+obj_resp.file_name+'" name="uploaded_files['+file.id+']" />');
				
				//file name	
				//$filelist_DIV.find('#u_i_c_' + file.id).find('.progress_bar').html(obj_resp.file_name);
			
			},

			UploadProgress: function(up, file) {
				//document.getElementById(file.id).getElementsByTagName('b')[0].innerHTML = '<span>' + file.percent + "%</span>";
				//console.log($filelist_DIV.find('#' + file.id).find('.progress_bar_runner'));
				$filelist_DIV.find('#u_i_c_' + file.id).find('.progress_bar_number').html(file.percent + '%');
				$filelist_DIV.find('#u_i_c_' + file.id).find('.progress_bar_runner').css({'display':'block', 'width':file.percent + '%'});
			},

			Error: function(up, err) {
				//document.getElementById('console').innerHTML += "\nError #" + err.code + ": " + err.message;
				alert("\nError #" + err.code + ": " + err.message);
			}
		}
		

	});

    uploader_wcpd.init();
    
    // delete file
			$(".nm-file-thumb").find('.u_i_c_tools_del > a').live('click', function(){

				//console.log($(this));
				var a = confirm(nm_wcpd_vars.delete_file_message);
				if(a){
					// it is removing from uploader instance
					var fileid = $(this).attr("data-fileid");
					uploader_wcpd.removeFile(fileid);

					var filename  = jQuery('input:checkbox[name="uploaded_files['+fileid+']"]').val();
					
					// it is removing physically if uploaded
					jQuery("#u_i_c_"+fileid).find('img').attr('src', nm_wcpd_vars.plugin_url+'/images/loading.gif');
					
						var data = {action: 'nm_wcpd_delete_file_new', file_name: filename};
					
						jQuery.post(nm_wcpd_vars.ajaxurl, data, function(resp){
							alert(resp.message);
							jQuery("#u_i_c_"+fileid).hide(500).remove();

							// it is removing for input Holder
							jQuery('input:checkbox[name="uploaded_files['+fileid+']"]').remove();
							running_quota -= resp.file_size;
							file_count_wcpd--;
						
					}, 'json');
				}
			});

});


	
	function add_thumb_box(file, $filelist_DIV){
		
		var inner_html	= '<div class="progress_bar"><span class="progress_bar_runner"></span><span class="progress_bar_number">(' + plupload.formatSize(file.size) + ')<span></div>';
		
		jQuery( '<div />', {
			'id'	: 'u_i_c_'+file.id,
			'data-fileid': file.id,
			'class'	: 'u_i_c_box',
			'html'	: inner_html,
			
		}).appendTo($filelist_DIV);

		// clearfix
		// 1- removing last clearfix first
		$filelist_DIV.find('.u_i_c_box_clearfix').remove();
		
		jQuery( '<div />', {
			'class'	: 'u_i_c_box_clearfix',				
		}).appendTo($filelist_DIV);
	}
	//-->
</script>
