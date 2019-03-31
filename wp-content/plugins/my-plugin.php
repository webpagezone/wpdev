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
    echo "I read Buiding ....";
}

// get posts - return 100 posts 
$posts = get_posts( array( 'numberposts' => '100') );
 // loop all posts and display the ID & title 
foreach ( $posts as $post ) {        
	echo $post->ID . ': ' .$post->post_title . '<br>'; 
}


//$posts = get_posts(array('numberposts')) => '100') );


add_action('wp_footer', 'my_plugin_wp_footer');

?>
