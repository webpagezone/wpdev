<?php
$designName = $_POST['dburl'];
if (file_exists($designName)) {
        $result = 'true';
    } else {
        $result = 'false';
    }
echo $result;    
?>