<?php

$designName = $_POST['curDesignName'];
$curTime = $_POST['curTime'];
$data = $_POST['data'];
$file = $curTime . '.png';
if(!is_dir("uploadMotive/".$designName)) mkdir("uploadMotive/".$designName, 0755);
// remove "data:image/png;base64,"
$uri =  substr($data,strpos($data,",")+1);
// save to file
file_put_contents('uploadMotive/'.$designName.'/'.$file, base64_decode($uri));
// return the filename
echo $file; exit;
?>