<?php
$designName = $_POST['dfurl'];
if (file_exists($designName)) {
        $result = 'true';
    } else {
        $result = 'false';
    }
echo $result;    
?>