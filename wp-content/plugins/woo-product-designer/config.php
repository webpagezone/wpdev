<?php
/*
 * this file contains pluing meta information and then shared
 * between pluging and admin classes
 * 
 */

/*
 * TODO: change the function name
*/

$plugin_meta = array();
function get_plugin_meta_nm_wcpd(){
	
	$plugin_meta = array('name'				=> 'Woo Product Designer',
							'shortname'		=> 'nm_wcpd',
							'path'			=> plugin_dir_path( __FILE__ ),
							'url'			=> plugin_dir_url( __FILE__ ),
							'plugin_version'=> 1.0,
							'logo'			=> plugin_dir_url( __FILE__ ) . 'images/logo.png',);
	
	//print_r($plugin_meta);
	
	return $plugin_meta;
}


/**
 * printing the formatted array
 */
 function pa_nm_wcpd( $arr ){
 	
	echo '<pre>';
		print_r( $arr );
	echo '</pre>';
}

/**
 * rendering canvas design with thumb
 **/
function wcpd_render_canvas_design($canvas_data) {
	
	$btns_html = '';
	if(is_array($canvas_data)){
		foreach ($canvas_data as $key => $src) {
			$btns_html .= '<a href="'.$src.'">'.__('Canvas', 'nm-wcpd').' '.($key+1).'</a> ';
		}
	}
	
	return $btns_html;
	
}