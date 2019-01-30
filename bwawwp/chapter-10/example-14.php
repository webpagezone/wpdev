<?php
function bwawwp_xmlrpc_getComments() {
    global $xmlrpc_url, $xmlrpc_user, $xmlrpc_pass;
    $rpc = new IXR_CLIENT( $xmlrpc_url );
    $filter = array( 'status' => 'approve', 'number' => '20' );
    $rpc->query( 'wp.getComments', 0, $xmlrpc_user, $xmlrpc_pass, $filter );
    echo '<h1>Approved Comments</h1>';
    echo '<pre>';
    print_r( $rpc->getResponse() );
    echo '</pre>';
    exit();
}
add_action( 'init', 'bwawwp_xmlrpc_getComments', 999 );
?>