<?php
if (function_exists('get_magic_quotes_gpc') && get_magic_quotes_gpc())
{
    function strip_slashes($input)
    {
        if (!is_array($input))
        {
                return stripslashes($input);
        }
        else
        {
                return array_map('strip_slashes', $input);
        }
    }
    $_GET = strip_slashes($_GET);
    $_POST = strip_slashes($_POST);
    $_COOKIE = strip_slashes($_COOKIE);
    $_REQUEST = strip_slashes($_REQUEST);
}
$designName = $_POST['curDesignName'];
$dataFront = $_POST['jsonFront'];
$fileFront = $designName . '_front.json';
$dataBack = $_POST['jsonBack'];
$fileBack= $designName . '_back.json';
$productPrice = $_POST['productPrice'];
$productName = $_POST['productName'];
$designPrice = $_POST['designPrice'];
$fdesignTop = $_POST['fdesignTopPosition'];
$fdesignLeft = $_POST['fdesignLeftPosition'];
$bdesignTop = $_POST['bdesignTopPosition'];
$bdesignLeft = $_POST['bdesignLeftPosition'];
$productBIMGF = $_POST['productBIMGF'];
$productBIMGB = $_POST['productBIMGB'];
$productBCF = $_POST['productBCF'];
$productBCB = $_POST['productBCB'];
$productImageFront = $_POST['productImageFront'];
$productImageBack = $_POST['productImageBack'];
if(!is_dir("../orders/".$designName)) mkdir("../orders/".$designName, 0755);

$pout="<?xml version='1.0' encoding='utf-8'?>\n<infos>\n";  
$productPrice = $_POST['productPrice'];
$designPrice = $_POST['designPrice'];
$contact_name = $_POST['name'];
$contact_address = $_POST['address'];
$contact_email = $_POST['email'];
$productCategory = $_POST['productCategory'];
$productFormat = $_POST['productsFormat'];
$pout.='<info name="'.$contact_name.'" address="'.$contact_address.'" email="'.$contact_email.'" productImageFront="'.$productImageFront.'" productImageBack="'.$productImageBack.'" productBIMGF="'.$productBIMGF.'" productBIMGB="'.$productBIMGB.'" productBCF="'.$productBCF.'" productBCB="'.$productBCB.'" productFormat="'.$productFormat.'" productCategory="'.$productCategory.'" fdesignTop="'.$fdesignTop.'" fdesignLeft="'.$fdesignLeft.'" bdesignTop="'.$bdesignTop.'" bdesignLeft="'.$bdesignLeft.'" productPrice="'.$productPrice.'" productName="'.$productName.'" designPrice="'.$designPrice.'"'."/>";
$pout.="</infos>";

// save to file
file_put_contents('../orders/'.$designName.'/'.$fileFront, $dataFront);
file_put_contents('../orders/'.$designName.'/'.$fileBack, $dataBack);
file_put_contents('../orders/'.$designName.'/infos.xml',$pout);
// return the filename
echo $file; exit;
?>