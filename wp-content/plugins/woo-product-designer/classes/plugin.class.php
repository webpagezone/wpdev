<?php
/*
 * this is main plugin class
*/


/* ======= the model main class =========== */
if(!class_exists('NM_Framwork_V2_nm_wcpd')){
	$_framework = dirname(__FILE__) . DIRECTORY_SEPARATOR . 'nm-framework.php';
	if( file_exists($_framework))
		include_once($_framework);
	else
		die('Reen, Reen, BUMP! not found '.$_framework);
}


/*
 * [1]
 * TODO: change the class name of your plugin
 */
class NM_ProductDesigner extends NM_Framwork_V2_nm_wcpd{

	private static $ins = null;
	
	var $woo_designs_dir = 'woo-designs';
	var $product_id;
	var $design_id;
	var $_nonce;
	
	public static function init()
	{
		add_action('plugins_loaded', array(self::get_instance(), '_setup'));
	}
	
	public static function get_instance()
	{
		// create a new object if it doesn't exist.
		is_null(self::$ins) && self::$ins = new self;
		return self::$ins;
	}
	
	
	function _setup(){
		
		//setting plugin meta saved in config.php
		$this -> plugin_meta = get_plugin_meta_nm_wcpd();

		//getting saved settings
		$this -> plugin_settings = get_option ( $this -> plugin_meta['shortname'] . '_settings' );
		
		// populating $inputs with NM_Inputs object
		$this->inputs = $this->get_all_inputs ();
		
		$this -> _nonce = wp_create_nonce( 'woo-design' );
		
		/*
		 * [2]
		 * TODO: update scripts array for SHIPPED scripts
		 * only use handlers
		 */
		//setting shipped scripts
		$this -> wp_shipped_scripts = array('jquery');
		
		
		/*
		 * [3]
		* TODO: update scripts array for custom scripts/styles
		*/
		//setting plugin settings
		$this -> plugin_scripts =  array(array(	'script_name'	=> 'scripts',
												'script_source'	=> '/js/script.js',
												'localized'		=> true,
												'type'			=> 'js',
												'depends'		=> array('jquery'),
												'in_footer'		=> false,
												'version'		=> false,
										),
												array(	'script_name'	=> 'styles',
														'script_source'	=> '/plugin.styles.css',
														'localized'		=> false,
														'type'			=> 'style',
														'in_footer'		=> false,
														'version'		=> false,
												),
										);
		
		/*
		 * [4]
		* TODO: localized array that will be used in JS files
		* Localized object will always be your pluginshortname_vars
		* e.g: pluginshortname_vars.ajaxurl
		*/
		$messages = array(	'file_count_limit' => __('No more files allowed', 'nm-wcpd'),
							'canvas_save_confirm' => __('Are you sure? You cannot make changes in this design but re-design.', 'nm-wcpd'),);
							
		$this -> localized_vars = array(	'ajaxurl' 		=> admin_url( 'admin-ajax.php', (is_ssl() ? 'https' : 'http') ),
											'plugin_url' 	=> $this->plugin_meta['url'],
											'plugin_doing'	=> $this->plugin_meta['url'] . 'images/loading.gif',
											'settings'		=> $this -> plugin_settings,
											'messages'		=> $messages,
										);
		
		
		/*
		 * [5]
		 * TODO: this array will grow as plugin grow
		 * all functions which need to be called back MUST be in this array
		 * setting callbacks
		 * Updated V2: September 16, 2014
		 * Now truee/false against each function
		 * true: logged in
		 * false: visitor + logged in
		 */
		 
		//following array are functions name and ajax callback handlers
		$this -> ajax_callbacks = array('none'			=> true,	//do not change this action, is for admin
										'upload_file' 	=> false,
										'delete_file'	=> false,
										'save_canvases'	=> false,);	
										
		
		/*
		 * plugin localization being initiated here
		 */
		add_action('init', array($this, 'wpp_textdomain'));
		
		/*
		 * rendering a button on product page before cart button to launch designer
		 */
		add_action ( 'woocommerce_before_add_to_cart_button', array (
				$this,
				'render_product_designer' 
		), 15 );
		
		
		/*
		 * adding design canvas as product meta to cart
		 */
		add_filter ( 'woocommerce_add_cart_item_data', array (
				$this,
				'add_product_meta_to_cart' 
		), 10, 2 );
		
		
		/*
		 * now loading all meta on cart/checkout page from session confirmed that it is loading for cart and checkout
		 */
		add_filter ( 'woocommerce_get_cart_item_from_session', array (
				&$this,
				'get_cart_session_data' 
		), 10, 2 );
		
		/*
		 * this is showing meta on cart/checkout page
		 */
		add_filter ( 'woocommerce_get_item_data', array (
				$this,
				'add_item_meta' 
		), 10, 2 );
		
		add_action ( 'woocommerce_add_order_item_meta', array (
				$this,
				'order_item_meta' 
		), 10, 3 );
		
		
		/**
		 * adding order meta NOT Item Met
		 * */
		 add_action('woocommerce_checkout_order_processed', array (
				$this,
				'update_order_meta' 
		), 10, 2 );
		/*
		 * plugin main shortcode if needed
		 */
		//add_shortcode('nm-product-designer', array($this , 'render_shortcode_template'));
		
		
		/*
		 * hooking up scripts for front-end
		*/
		add_action('wp_enqueue_scripts', array($this, 'load_scripts'));
		
		/*
		 * registering callbacks
		*/
		$this -> do_callbacks();

		add_action( 'add_meta_boxes', array($this, 'woo_product_designer') );

		add_action( 'save_post', array($this, 'save_product_design') );

		add_action( 'init', array($this, 'create_design_post_type') );

		add_action( 'save_post', array($this, 'update_product_for_design_id'),10, 3 );
		
		//replacing cart thumb since version 1.2
		add_filter('woocommerce_cart_item_thumbnail', array($this, 'replace_cart_item_thumb'), 10, 3);
	}
	



	/*
	 * =============== NOW do your JOB ===========================
	 * 
	 */
	
	// i18n and l10n support here
	// plugin localization
	function wpp_textdomain() {

		$locale_dir = dirname( plugin_basename( dirname(__FILE__ ) ) ) . '/locale/';
		load_plugin_textdomain('nm-wcpd', false, $locale_dir);
	
	}
		
	/*
	 *	rendering the function for product designer
	 */
	

	
	function get_plugin_settings(){
		
		$temp_settings = array();
		foreach($this -> plugin_setting_tabs as $tab){
			
			$temp_settings[$tab] = get_option( $tab . '_settings' );
		}
		
		$this -> pa($temp_settings);
		
		return $temp_settings;
	}
	
	function create_design_post_type(){

		register_post_type( 'product-designs',
		    array(
		      'labels' => array(
		        'name' => __( 'Product Designs' ),
		        'singular_name' => __( 'Design' )
		      ),
		      'menu_icon' => 'dashicons-admin-customizer',
		      'public' => true,
		      'has_archive' => true,
		    )
		);

		remove_post_type_support( 'product-designs', 'editor' );	
	}
		
	function woo_product_designer(){
		add_meta_box( 'WCPD_box', 'Product Designer', array($this, 'WCPD_box_cb'), 'product-designs', 'normal', 'default' );
	}

	function WCPD_box_cb( $design ){

		ob_start ();
			
		$template_vars = array('designid' => $design -> ID);	
		$this->load_template ( 'admin/product-box.php', $template_vars );
			
		$output_string = ob_get_contents ();
		ob_end_clean ();
		
		echo $output_string;
		  		
	}

	/*
	 *	saving product design as post meta
	 */
	function save_product_design( $post_id ) {
	
		/*echo '<pre>';
		 print_r($_POST);
		echo '</pre>';
		exit;*/
	
		if ( wp_is_post_revision( $post_id ) )
			return;
	
		if ( 'product-designs' != $_POST['post_type'] ) {
			return;
		}

		$woo_pd_fields = sanitize_text_field( $_POST['save_woo_product'] );	

		if(update_post_meta($post_id, 'woo_pd', $woo_pd_fields))
			return true;
		 
	
	}	
	/*
	 * rendering template against shortcode
	*/
	function render_product_designer(){

		global $post;

		$this -> product_id = $post -> ID;
		$this -> design_id	= get_post_meta( $post -> ID, 'wcpd_design_id', true );

		if($this -> design_id)
			$this -> load_template('_product-designer.php');
		
		return false;
	}
	
	/*
	 * uploading file here
	 */
	function upload_file() {
		
		
		header ( "Expires: Mon, 26 Jul 1997 05:00:00 GMT" );
		header ( "Last-Modified: " . gmdate ( "D, d M Y H:i:s" ) . " GMT" );
		header ( "Cache-Control: no-store, no-cache, must-revalidate" );
		header ( "Cache-Control: post-check=0, pre-check=0", false );
		header ( "Pragma: no-cache" );
		
		// setting up some variables
		$file_dir_path = $this->setup_file_directory ( $this -> _nonce );
		$response = array ();
		if ($file_dir_path == 'errDirectory') {
			
			$response ['status'] = 'error';
			$response ['message'] = __ ( 'Error while creating directory', 'nm-personalizedproduct' );
			die ( 0 );
		}
		
		$cleanupTargetDir = true; // Remove old files
		$maxFileAge = 5 * 3600; // Temp file age in seconds
		                        
		// 5 minutes execution time
		@set_time_limit ( 5 * 60 );
		
		// Uncomment this one to fake upload time
		// usleep(5000);
		
		// Get parameters
		$chunk = isset ( $_REQUEST ["chunk"] ) ? intval ( $_REQUEST ["chunk"] ) : 0;
		$chunks = isset ( $_REQUEST ["chunks"] ) ? intval ( $_REQUEST ["chunks"] ) : 0;
		$file_name = isset ( $_REQUEST ["name"] ) ? $_REQUEST ["name"] : '';
		
		// Clean the fileName for security reasons
		//$file_name = sanitize_file_name($file_name); 		//preg_replace ( '/[^\w\._]+/', '_', $file_name );
		$file_name = wp_unique_filename($file_dir_path, $file_name);
		$file_name = strtolower($file_name);
		
		// Make sure the fileName is unique but only if chunking is disabled
		if ($chunks < 2 && file_exists ( $file_dir_path . $file_name )) {
			$ext = strrpos ( $file_name, '.' );
			$file_name_a = substr ( $file_name, 0, $ext );
			$file_name_b = substr ( $file_name, $ext );
			
			$count = 1;
			while ( file_exists ( $file_dir_path . $file_name_a . '_' . $count . $file_name_b ) )
				$count ++;
			
			$file_name = $file_name_a . '_' . $count . $file_name_b;
		}
		
		// Remove old temp files
		if ($cleanupTargetDir && is_dir ( $file_dir_path ) && ($dir = opendir ( $file_dir_path ))) {
			while ( ($file = readdir ( $dir )) !== false ) {
				$tmpfilePath = $file_dir_path . $file;
				
				// Remove temp file if it is older than the max age and is not the current file
				if (preg_match ( '/\.part$/', $file ) && (filemtime ( $tmpfilePath ) < time () - $maxFileAge) && ($tmpfilePath != "{$file_path}.part")) {
					@unlink ( $tmpfilePath );
				}
			}
			
			closedir ( $dir );
		} else
			die ( '{"jsonrpc" : "2.0", "error" : {"code": 100, "message": "Failed to open temp directory."}, "id" : "id"}' );
		
		$file_path = $file_dir_path . $file_name;
		
		// Look for the content type header
		if (isset ( $_SERVER ["HTTP_CONTENT_TYPE"] ))
			$contentType = $_SERVER ["HTTP_CONTENT_TYPE"];
		
		if (isset ( $_SERVER ["CONTENT_TYPE"] ))
			$contentType = $_SERVER ["CONTENT_TYPE"];
			
			// Handle non multipart uploads older WebKit versions didn't support multipart in HTML5
		if (strpos ( $contentType, "multipart" ) !== false) {
			if (isset ( $_FILES ['file'] ['tmp_name'] ) && is_uploaded_file ( $_FILES ['file'] ['tmp_name'] )) {
				// Open temp file
				$out = fopen ( "{$file_path}.part", $chunk == 0 ? "wb" : "ab" );
				if ($out) {
					// Read binary input stream and append it to temp file
					$in = fopen ( $_FILES ['file'] ['tmp_name'], "rb" );
					
					if ($in) {
						while ( $buff = fread ( $in, 4096 ) )
							fwrite ( $out, $buff );
					} else
						die ( '{"jsonrpc" : "2.0", "error" : {"code": 101, "message": "Failed to open input stream."}, "id" : "id"}' );
					fclose ( $in );
					fclose ( $out );
					@unlink ( $_FILES ['file'] ['tmp_name'] );
				} else
					die ( '{"jsonrpc" : "2.0", "error" : {"code": 102, "message": "Failed to open output stream."}, "id" : "id"}' );
			} else
				die ( '{"jsonrpc" : "2.0", "error" : {"code": 103, "message": "Failed to move uploaded file."}, "id" : "id"}' );
		} else {
			// Open temp file
			$out = fopen ( "{$file_path}.part", $chunk == 0 ? "wb" : "ab" );
			if ($out) {
				// Read binary input stream and append it to temp file
				$in = fopen ( "php://input", "rb" );
				
				if ($in) {
					while ( $buff = fread ( $in, 4096 ) )
						fwrite ( $out, $buff );
				} else
					die ( '{"jsonrpc" : "2.0", "error" : {"code": 101, "message": "Failed to open input stream."}, "id" : "id"}' );
				
				fclose ( $in );
				fclose ( $out );
			} else
				die ( '{"jsonrpc" : "2.0", "error" : {"code": 102, "message": "Failed to open output stream."}, "id" : "id"}' );
		}
		
		// Check if file has been uploaded
		if (! $chunks || $chunk == $chunks - 1) {
			// Strip the temp .part suffix off
			rename ( "{$file_path}.part", $file_path );
			
			// making thumb if images
			if($this -> is_image($file_name))
			{
				$thumb_size = 175;
				$thumb_dir_path = $this -> create_thumb($file_dir_path, $file_name, $thumb_size);
				$settings = array('cropping' => 'yes');
				
				list($fw, $fh) = getimagesize( $thumb_dir_path );
				$response = array(
						'file_name'			=> $file_name,
						'file_w'			=> $fw,
						'file_h'			=> $fh,
						'nocache'			=> time(),
						'html'				=> $this->uploaded_html($file_dir_path, $file_name, $settings),
				);
			}else{
				$response = array(
						'file_name'			=> $file_name,
						'file_w'			=> 'na',
						'file_h'			=> 'na',
						'html'				=> $this->uploaded_html($file_dir_path, $file_name, $is_image=false, $_REQUEST['settings']),
				);
			}
		}
			
		// Return JSON-RPC response
		//die ( '{"jsonrpc" : "2.0", "result" : '. json_encode($response) .', "id" : "id"}' );
		die ( json_encode($response) );
		
		
	}
	
	/*
	 * deleting uploaded file from directory
	 */
	function delete_file() {
		$dir_path = $this -> setup_file_directory ( $this -> _nonce);
		$file_path = $dir_path . $_REQUEST ['file_name'];
		
		if (unlink ( $file_path )) {
			
			if ($this -> is_image($_REQUEST ['file_name'])){
				$thumb_path = $dir_path . 'thumbs/' . $_REQUEST ['file_name'];
				if(file_exists($thumb_path))
					unlink ( $thumb_path );
				
				$cropped_image_path = $dir_path . 'cropped/' . $_REQUEST ['file_name'];
				if(file_exists($cropped_image_path))
					unlink ( $cropped_image_path );
			}
			
			_e( 'File removed', 'nm-personalizedproduct' );
			
				
		} else {
			printf(__('Error while deleting file %s', 'nm-personalizedproduct'), $file_path );
		}
		
		die ( 0 );
	}
	
	
	function replace_cart_item_thumb($item_image, $cart_item, $cart_item_key){
		
		// var_dump($cart_item['canvas_meta']);
		
		
		if( isset($cart_item['canvas_image']) ){
			foreach($cart_item['canvas_image'] as $c_id => $img_url){
				$item_image = '<img src="'.$img_url.'" class="attachment-shop_thumbnail size-shop_thumbnail wp-post-image">';
			}
		}
		
		
		return $item_image;
	}


	function save_canvases(){
		
		if (isset($GLOBALS["HTTP_RAW_POST_DATA"]))
		{
			//pa_nm_wcpd($GLOBALS["HTTP_RAW_POST_DATA"]); exit;
		
		
			$filter_data = substr($GLOBALS["HTTP_RAW_POST_DATA"]	, strpos($GLOBALS["HTTP_RAW_POST_DATA"], ",")+1);
			
			//echo 'filter data '.$filter_data;
			
			$unencoded_data = base64_decode($filter_data);
			
			//echo 'decoded data '.$unencoded_data;
			
			$filename = $_REQUEST['canvas_id'] . '.png';
			$canvas_dir = $this -> _nonce . '/canvas';
			$canvas_image = $this -> setup_file_directory( $canvas_dir ) . $filename;
			//$success = file_put_contents($canvas_image, $unencoded_data);
			$fp = fopen( $canvas_image, 'wb' );
			fwrite( $fp, $unencoded_data);
			fclose( $fp );
			
			$response = array('filename'	=> $filename,
								'thumburl'	=> $this -> get_file_dir_url ( $this -> _nonce . '/canvas' ) . $filename . '?nocache='.time());
								
			echo json_encode($response);
			
		}
			
		die(0);
		
	}
	
	
	//adding canvas meta into product meta in cart 
	function add_product_meta_to_cart($the_cart_data, $product_id) {
		
		if( ! isset($_POST['nm_canvases']) ) {
			return $the_cart_data;
		}
		
		global $woocommerce;
		
		// pa_nm_wcpd($_POST); exit;
		$canvas_data = json_decode(stripslashes($_POST['nm_canvases']));
		//pa_nm_wcpd($canvas_data); exit;
		
		if( isset($_POST['nm_canvases']) )
			$the_cart_data ['canvas_meta'] = $_POST['nm_canvases'];
			
		if( isset($_POST['_canvas_image']) )
			$the_cart_data ['canvas_image'] = $_POST['_canvas_image'];
		
		return $the_cart_data;
	}
	
	
	function get_cart_session_data($cart_items, $values) {
		
		// pa_nm_wcpd($cart_items);
		if (isset ( $values ['canvas_meta'] )){
			$cart_items ['canvas_meta'] = $values ['canvas_meta'];	
		}
		
		return $cart_items;
	}
	
	function add_item_meta($item_meta, $existing_item_meta) {
		
		if ( ! isset($existing_item_meta['canvas_meta'] ) )
			return $item_meta;
			
		$canvas_data = json_decode(stripslashes($existing_item_meta['canvas_meta']));
		// nm_personalizedproduct_pa($existing_item_meta['canvas_image']);
		
		$product_id = $existing_item_meta['product_id'];
		$link = get_permalink( $product_id );
		$title = 'Edit';
		
		if(isset($canvas_data) && $canvas_data != ''){
			
			$value = wcpd_render_canvas_design($existing_item_meta['canvas_image']);
			
			$item_meta [] = array (
								'name' =>  __('Design Attached', 'nm-wcpd'),
								'value' => $value
						);
		}
		
		return $item_meta;
		
		//exit;
	}
	
	function order_item_meta($item_id, $cart_item, $cart_key) {

		  //pa_nm_wcpd($cart_item); exit;
		 if(isset($cart_item['canvas_image']) && $cart_item['canvas_image'] != ''){
		 	$images = '';
		 	foreach($cart_item['canvas_image'] as $can_id => $img_url){
		 		$images .= '<a href="'.$img_url.'">'.__('Design: ', 'nm-wcpd').($can_id+1).'</a>, ';
		 	}
		 	
		 	wc_add_order_item_meta ( $item_id, 'Design', $images );
		 }
		
	}
	
	function update_order_meta($order_id, $posted){
		
		$cart_items =  WC()->cart->get_cart();
		
		$canvases_array = '';
		foreach ( $cart_items as $cart_item_key => $values ) {
			if(isset($values['canvas_meta'])){
				$canvases_array[] = $values['canvas_meta'];
				//echo 'order id '.$order_id;
			}
		}
		
		if( $canvases_array ) {
			
			update_post_meta($order_id, 'canvas_meta', $canvases_array);
		}
		
	}


	function update_product_for_design_id( $post_id,$post, $update ) {

	/*
     * In production code, $slug should be set only once in the plugin,
     * preferably as a class property, rather than in each function that needs it.
     */
    $slug = 'product-designs';

    // If this isn't a 'book' post, don't update it.
    if ( $slug != $post->post_type ) {
        return;
    }

    //pa_nm_wcpd($_REQUEST); exit;
    
    update_post_meta( $_REQUEST['wcpd_product'], 'wcpd_design_id', $post_id );
}


	// ================================ SOME HELPER FUNCTIONS =========================================

	/*
	 * setting up user directory
	 */
	function setup_file_directory( $sub_dir_name = null) {
		$upload_dir = wp_upload_dir ();
		
		
		$parent_dir = $upload_dir ['basedir'] . '/' . $this -> woo_designs_dir . '/';
		$thumb_dir  = $parent_dir . 'thumbs/';
		
		if($sub_dir_name){
			$sub_dir = $parent_dir . $sub_dir_name . '/';
			if(wp_mkdir_p($sub_dir)){
				return $sub_dir;
			}else{
				die('Error while creating parent dirctory '.$sub_dir);
			}
		}elseif(wp_mkdir_p($parent_dir)){
			if(wp_mkdir_p($thumb_dir)){
				return $parent_dir;
			}else{
				die('Error while creating parent dirctory '.$thumb_dir);
			}
		}else{
			die('Error while creating parent dirctory '.$parent_dir);
		}
	
	}
	
	/*
	 * check if file is image and return true
	*/
	function is_image($file){
	
		$type = strtolower ( substr ( strrchr ( $file, '.' ), 1 ) );
	
		if (($type == "gif") || ($type == "jpeg") || ($type == "png") || ($type == "pjpeg") || ($type == "jpg"))
			return true;
		else
			return false;
	}
	
	
		/**
	 * it will return html template of uploaded file
	 * to preview
	 */
	function uploaded_html($file_dir_path, $file_name, $settings){
		
		$thumb_url = $file_meta = $file_tools = $_html = '';
		
		//$this -> pa($settings);
		$file_id = 'thumb_'.time();

		list($fw, $fh) 	= getimagesize( $file_dir_path . $file_name );
		$file_meta		= $fw . '(w) x '.$fh.'(h)';
		$file_meta		.= ' - '.__('Size: ', 'nm-wcpd') . size_format(filesize($file_dir_path . $file_name));
		
		$thumb_url = $this -> get_file_dir_url ( $this -> _nonce, true ) . $file_name . '?nocache='.time();
		
		//large view
		$image_url = $this -> get_file_dir_url($this -> _nonce) . $file_name . '?nocache='.time();
		// $_html .= '<div style="display:none" id="u_i_c_big_'.$file_id.'"><div id="thumb-thickbox"><img src="'.$image_url.'" /></div></div>';
		
		
		$file_tools .= '<a href="#" class="nm-file-tools nm-wpd-delete-img u_i_c_tools_del" title="'.__('Remove', 'nm-wcpd').'"><span class="fa fa-times"></span></a>';	//delete icon
		//$file_tools .= '<a href="#TB_inline?width=500&height=400&inlineId=u_i_c_big_'.$file_id.'" class="nm-file-tools u_i_c_tools_zoom thickbox" title="'.sprintf(__('%s', 'nm-wcpd'), $file_name).'"><span class="fa fa-expand"></span></a>';	//big view icon
		
		/*if($settings['cropping'] != NULL){
			
			$cropping_ratios = json_encode($settings['cropping']);
			//echo $cropping_ratios;
			$file_tools .= '<a href="javascript:;" onclick="launch_crop_editor(\''.$file_id.'\', \''.$image_url.'\', \''.$file_name.'\', \''.esc_attr($cropping_ratios).'\')" class="nm-file-tools" title="'.__('Crop image', 'nm-wcpd').'"><span class="fa fa-crop"></span></a>';	//big view icon
		}*/
		
				
		$_html .= '<table class="uploaded-files-box"><tr>';
		$_html .= '<td style="vertical-align:middle;position:relative;text-align:center;background-color: #d8d6d8;"><img id="'.$file_id.'" src="'.$image_url.'" data-big="'.$image_url.'" />'.$file_tools.'</td>';
		
		// $trimed_filename = (strlen($file_name) > 35 ? substr($file_name, 0, 35) . '...' : $file_name); 
		// $_html .= '<td>';
		// $_html .= '<span class="file-meta">'.$file_meta.'</span><br>';
		// $_html .= '</td>';
		
		$_html .= '</tr></table>';
		
		return $_html;
	}
	
	
	
	/*
	 * getting file URL
	 */
	function get_file_dir_url($sub_dir=false, $thumbs = false) {

		$upload_dir = wp_upload_dir ();	

		$the_url = '';	
		
		if ($thumbs){
			
			if($sub_dir)
				$the_url = $upload_dir ['baseurl'] . '/' . $this -> woo_designs_dir . '/' . $sub_dir . '/thumbs/';
			else
				$the_url = $upload_dir ['baseurl'] . '/' . $this -> woo_designs_dir . '/thumbs/';
		}else{
			
			if($sub_dir)
				$the_url = $upload_dir ['baseurl'] . '/' . $this -> woo_designs_dir . '/' .$sub_dir . '/';
			else
				$the_url = $upload_dir ['baseurl'] . '/' . $this -> woo_designs_dir . '/';
		}

		if (function_exists('set_url_scheme')) {
			return set_url_scheme($the_url);
		} else {
			return $the_url;
		}
	}
	
	function get_file_dir_path() {
		$upload_dir = wp_upload_dir ();
		return $upload_dir ['basedir'] . '/' . $this -> woo_designs_dir . '/';
	}
	
	
	/*
	 * creating thumb using WideImage Library Since 21 April, 2013
	 */
	function create_thumb($dest, $image_name, $thumb_size) {

	// using wp core image processing editor, 6 May, 2014
		$image = wp_get_image_editor ( $dest . $image_name );
		$dest = $dest . 'thumbs/' . $image_name;
		if (! is_wp_error ( $image )) {
			$image->resize ( 75, 75, true );
			$image->save ( $dest );
		}
		
		return $dest;
	}
	

	public static function activate_plugin(){

		//do nothing so far.

	}

	public static function deactivate_plugin(){

		//do nothing so far.
	}
	
	/*
	 * returning NM_Inputs object
	*/
	function get_all_inputs() {
		if (! class_exists ( 'NM_Inputs_nm_wcpd' )) {
			$_inputs = dirname ( __FILE__ ) . DIRECTORY_SEPARATOR . 'input.class.php';
			if (file_exists ( $_inputs ))
				include_once ($_inputs);
			else
				die ( 'Reen, Reen, BUMP! not found ' . $_inputs );
		}
	
		$nm_inputs = new NM_Inputs_nm_wcpd ();
		// webcontact_pa($this->plugin_meta);
	
		// registering all inputs here
	
		return array (
	
			
				'file' 		=> $nm_inputs->get_input ( 'file' ),
			
		);
	
		// return new NM_Inputs($this->plugin_meta);
	}

	/*
	 * check if browser is ie
	 */
	function if_browser_is_ie()
	{
		//print_r($_SERVER['HTTP_USER_AGENT']);
		
		if(!(isset($_SERVER['HTTP_USER_AGENT']) && (strpos($_SERVER['HTTP_USER_AGENT'], 'Trident') !== false || strpos($_SERVER['HTTP_USER_AGENT'], 'MSIE') !== false))){
			return false;
		}else{
			return true;
		}
	}	
}