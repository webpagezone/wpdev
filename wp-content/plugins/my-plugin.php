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

function my_plugin_wp_footer90{
    echo "I read Buiding ....";
    echo "<br/>my string";
}

add_action('wp_footer', 'my_plugin_wp_footer');



?>