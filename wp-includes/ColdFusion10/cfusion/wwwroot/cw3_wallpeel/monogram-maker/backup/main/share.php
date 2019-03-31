<?php
include "settings.php";
$ranName = date( 'YmdHis', time());
$designName = $_POST['curDesignName'];
$data = $_POST['data'];
$file = $designName .$ranName. '.png';
$htmlFile = $designName . $ranName . '.html';
if(!is_dir("orders/".$designName."/fb")) mkdir("orders/".$designName."/fb", 0755);
// remove "data:image/png;base64,"
$uri =  substr($data,strpos($data,",")+1);
// save to file
$dir = 'orders/'.$designName.'/fb/';
foreach(glob($dir.'*.*') as $v){
    unlink($v);
}
file_put_contents('orders/'.$designName.'/fb/'.$file, base64_decode($uri));
// save to html
$htmlContent = '<html><head>
<meta property="og:title" content="Hi there ..."/>
<meta property="og:url" content='.$domain.$designName.'/'.$htmlFile.'/>
<meta property="og:description" content="This is my new Design by Print-Designer!"/>
</head>
<body>
<img src='.$domain.$designName.'/fb/'.$file.'></img></body></html>';
file_put_contents('orders/'.$designName.'/fb/'.$htmlFile, $htmlContent);
// return the filename
echo $file; exit;
echo $ranName;
?>