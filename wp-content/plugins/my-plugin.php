<?php
/*
* Plugin Name: My Plugin
* Plugin URI: http://webdevstudios.com/
* Description: This is my plugin description.
* Author: messenlehner, webdevstudios, strangerstudios 
* Version: 1.0.0
* Author URI: http://bwawwp.com
* License: GPLv2 or later
*/

function my_plugin_wp_footer(){
    //echo "I read Buiding ....";
}

// get posts - return 100 posts 
$posts = get_posts( array( 'numberposts' => '100') );
 // loop all posts and display the ID & title 
//foreach ( $posts as $post ) {        
	//echo $post->ID . ': ' .$post->post_title . '<br>'; 
//}


//$posts = get_posts(array('numberposts')) => '100') );


add_action('wp_footer', 'my_plugin_wp_footer');

// insert post - set post status to draft 
/*
$args = array(        
	'post_title'   => 'Building Web Apps with WordPress',        
	'post_excerpt' => 'WordPress as an Application Framework',        
	'post_content' => 'WordPress is the key to successful cost effective        web solutions in most situations. Build almost anything on top of the        WordPress platform. DO IT NOW!!!!',        
	'post_status'  => 'draft',        
	'post_type'    => 'post',        
	'post_author'  => 1,        
	'menu_order'   => 0 ); 

$post_id = wp_insert_post( $args ); echo 'post ID: ' . $post_id . '<br>';

// get post - return post data as an object 
$post = get_post( $post_id ); echo 'Object Title: ' . $post->post_title . '<br>';


// get posts - return the latest post 
$posts = get_posts( 
	array( 
	'numberposts' => '100', 
	'orderby' =>    'post_date', 
	'order' => 'DESC' ) 
); 

foreach ( $posts as $post ) { 
	$post_id = $post->ID;
	echo "post_id: $post->ID <br/>" ;

	$content = "You should see this <br/>";
	update_post_meta( $post_id,  '_bwawwp_hidden_field', $content );


	// get post meta - get all meta keys        
	$all_meta = get_post_meta( $post_id );        
	echo '<pre>';        
		print_r( $all_meta );        
	echo '</pre>';

}
*/
?>
