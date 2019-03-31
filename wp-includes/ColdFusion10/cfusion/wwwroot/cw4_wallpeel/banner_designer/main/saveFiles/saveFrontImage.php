<?php
$designName = $_POST['curDesignName'];
$data = $_POST['data'];
$file = $designName . '_front.png';
if(!is_dir("../orders/".$designName)) mkdir("../orders/".$designName, 0755);
// remove "data:image/png;base64,"
$uri =  substr($data,strpos($data,",")+1);
// save to file
file_put_contents('../orders/'.$designName.'/'.$file, base64_decode($uri));
// return the filename
echo $file; exit;

?>