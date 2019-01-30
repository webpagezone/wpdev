<?php
/*
	Plugin Name: BWAWWP Code Examples
*/

/*
	For *some* examples, you should be able to simply include the file here to get it to run.
*/
function bwawwp_init()
{
	if(!empty($_REQUEST['chapter']) && !empty($_REQUEST['example']))	
		require(dirname(__FILE__) . "/chapter-" . $_REQUEST['chapter'] . "/example-" . $_REQUEST['example'] . ".php");
}
add_action("init", "bwawwp_init");
