<?php
$designName = $_POST['curDesignName'];
$designSide = $_POST['curSide'];
$data = $_POST['data'];
$file = $designName .'_'.$designSide.'HQ.png';
if(!is_dir("../orders/".$designName)) mkdir("../orders/".$designName, 0755);
// remove "data:image/png;base64,"
$uri =  substr($data,strpos($data,",")+1);
// save to file
file_put_contents('../orders/'.$designName.'/'.$file, base64_decode($uri));
// return the filename
echo $file; exit;

?>