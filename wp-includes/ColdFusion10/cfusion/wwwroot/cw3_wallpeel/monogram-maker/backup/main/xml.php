<?php
if (file_exists(("images/motives".'Thumbs.db'))){    
    unlink("images/motives/".'Thumbs.db');
}
$pout="<?xml version='1.0' encoding='utf-8'?>\n<images>\n";  
function mListFiles($dir) {  
    if($dh = opendir($dir)) {
        $files = Array();
        $inner_files = Array();
        while($file = readdir($dh)) {
            if($file != "." && $file != ".." && $file[0] != '.') {
                if(is_dir($dir . "/" . $file)) {
                    if(file_exists($dir . "/" . $file.'/Thumbs.db')){
                        unlink($dir . "/" . $file.'/Thumbs.db');
                    }
                    $inner_files = mListFiles($dir . "/" . $file);
                    if(is_array($inner_files)) $files = array_merge($files, $inner_files); 
                } else {
                    array_push($files, $dir . "/" . $file);
                }
            }
        }

        closedir($dh);
        return $files;
    }
}
foreach (mListFiles('images/motives') as $key=>$file){
    $pout.='<image name="'.$file.'"'."/>\n";
}
 $pout.="</images>";
 file_put_contents("xml/motives.xml",$pout); 



if (file_exists(("images/backgroundsV".'Thumbs.db'))){    
    unlink("images/backgroundsV/".'Thumbs.db');
}
$pout="<?xml version='1.0' encoding='utf-8'?>\n<images>\n";  
function bvListFiles($dir) {  
    if($dh = opendir($dir)) {
        $files = Array();
        $inner_files = Array();
        while($file = readdir($dh)) {
            if($file != "." && $file != ".." && $file[0] != '.') {
                if(is_dir($dir . "/" . $file)) {
                    if(file_exists($dir . "/" . $file.'/Thumbs.db')){
                        unlink($dir . "/" . $file.'/Thumbs.db');
                    }
                    $inner_files = bListFiles($dir . "/" . $file);
                    if(is_array($inner_files)) $files = array_merge($files, $inner_files); 
                } else {
                    array_push($files, $dir . "/" . $file);
                }
            }
        }

        closedir($dh);
        return $files;
    }
}
foreach (bhListFiles('images/backgroundsV') as $key=>$file){
    $pout.='<image name="'.$file.'"'."/>\n";
}
 $pout.="</images>";
 file_put_contents("xml/backgroundsV.xml",$pout);  


if (file_exists(("images/backgroundsH".'Thumbs.db'))){    
    unlink("images/backgroundsH/".'Thumbs.db');
}
$pout="<?xml version='1.0' encoding='utf-8'?>\n<images>\n";  
function bhListFiles($dir) {  
    if($dh = opendir($dir)) {
        $files = Array();
        $inner_files = Array();
        while($file = readdir($dh)) {
            if($file != "." && $file != ".." && $file[0] != '.') {
                if(is_dir($dir . "/" . $file)) {
                    if(file_exists($dir . "/" . $file.'/Thumbs.db')){
                        unlink($dir . "/" . $file.'/Thumbs.db');
                    }
                    $inner_files = bListFiles($dir . "/" . $file);
                    if(is_array($inner_files)) $files = array_merge($files, $inner_files); 
                } else {
                    array_push($files, $dir . "/" . $file);
                }
            }
        }

        closedir($dh);
        return $files;
    }
}
foreach (bhListFiles('images/backgroundsH') as $key=>$file){
    $pout.='<image name="'.$file.'"'."/>\n";
}
 $pout.="</images>";
 file_put_contents("xml/backgroundsH.xml",$pout); 




if (file_exists(("images/backgroundsFlyers".'Thumbs.db'))){    
    unlink("images/backgroundsFlyers/".'Thumbs.db');
}
$pout="<?xml version='1.0' encoding='utf-8'?>\n<images>\n";  
function bfListFiles($dir) {  
    if($dh = opendir($dir)) {
        $files = Array();
        $inner_files = Array();
        
        while($file = readdir($dh)) {
            if($file != "." && $file != ".." && $file[0] != '.') {
                if(is_dir($dir . "/" . $file)) {
                    if(file_exists($dir . "/" . $file.'/Thumbs.db')){
                        unlink($dir . "/" . $file.'/Thumbs.db');
                    }
                    $inner_files = bfListFiles($dir . "/" . $file);
                    if(is_array($inner_files)) $files = array_merge($files, $inner_files); 
                } else {
                    array_push($files, $dir . "/" . $file);
                }
            }
        }

        closedir($dh);
        return $files;
    }
}
foreach (bfListFiles('images/backgroundsFlyers') as $key=>$file){
    $pout.='<image name="'.$file.'"'."/>\n";
}
 $pout.="</images>";
 file_put_contents("xml/backgroundsFlyers.xml",$pout);       
?> 