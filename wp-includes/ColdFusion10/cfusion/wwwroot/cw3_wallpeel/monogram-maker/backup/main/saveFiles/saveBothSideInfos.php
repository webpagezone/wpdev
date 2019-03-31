<?php
include "../settings.php";
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
$designPrice = $_POST['designPrice'];
$pout="<?xml version='1.0' encoding='utf-8'?>\n<infos>\n";  
$productPrice = $_POST['productPrice'];
$productName = $_POST['productName'];
$designPrice = $_POST['designPrice'];
$contact_name = $_POST['name'];
$contact_address = $_POST['address'];
$contact_email = $_POST['email'];
$fdesignTop = $_POST['fdesignTopPosition'];
$fdesignLeft = $_POST['fdesignLeftPosition'];
$bdesignTop = $_POST['bdesignTopPosition'];
$bdesignLeft = $_POST['bdesignLeftPosition'];
$productCategory = $_POST['productCategory'];
$productFormat = $_POST['productsFormat'];
$productBIMGF = $_POST['productBIMGF'];
$productBIMGB = $_POST['productBIMGB'];
$productBCF = $_POST['productBCF'];
$productBCB = $_POST['productBCB'];
$productImageFront = $_POST['productImageFront'];
$productImageBack = $_POST['productImageBack'];
$pout.='<info name="'.$contact_name.'" address="'.$contact_address.'" email="'.$contact_email.'" productImageFront="'.$productImageFront.'" productImageBack="'.$productImageBack.'" productBIMGF="'.$productBIMGF.'" productBIMGB="'.$productBIMGB.'" productBCF="'.$productBCF.'" productBCB="'.$productBCB.'" productFormat="'.$productFormat.'" productCategory="'.$productCategory.'" fdesignTop="'.$fdesignTop.'" fdesignLeft="'.$fdesignLeft.'" bdesignTop="'.$bdesignTop.'" bdesignLeft="'.$bdesignLeft.'" productPrice="'.$productPrice.'" productName="'.$productName.'" designPrice="'.$designPrice.'"'."/>";
$pout.="</infos>";

if(!is_dir("../orders/".$designName)) mkdir("../orders/".$designName, 0755);
// save to file
file_put_contents('../orders/'.$designName.'/'.$fileFront, $dataFront);
file_put_contents('../orders/'.$designName.'/'.$fileBack, $dataBack);
file_put_contents('../orders/'.$designName.'/infos.xml',$pout);
// send confirmation email to user
$dir = $designName;
$contact_name = $_POST['name'];
$contact_address = $_POST['address'];
$contact_email = $_POST['email'];
$contact_message_admin = $_POST['message'];
echo $dir;
echo $contact_email;
echo $contact_path;
$from = $_POST['email'];
$email_from = $from; 
$email_user = '<html> 
                    <head> 
                    <title></title> 
                    <style type="text/css"> 
                    <!-- 
                    .Stil1 { 
                        font-family: Arial, Helvetica, sans-serif; 
                        font-weight: bold; 
                        font-size: 14px; 
                        color: #000000; 
                    } 
                    body,td,th { 
                        color: #000000; 
                        font-family: Arial, Helvetica, sans-serif; 
                        font-size: 12px; 
                    } 
                    a { 
                        font-size: 12px; 
                        color: #316CE4; 
                        font-weight: bold; 
                    } 
                    a:link { 
                        text-decoration: none; 
                    } 
                    a:visited { 
                        text-decoration: none; 
                        color: #FF0000; 
                    } 
                    a:hover { 
                        text-decoration: none; 
                        color: #FF0000; 
                    } 
                    a:active { 
                        text-decoration: none; 
                        color: #FF0000; 
                    } 
                    --> 
                    </style> 
                    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"> 
                    </head> 
                   <body bgcolor="#ededed"> 
                    <table width="100%" cellpadding="30" cellspacing="0" class="backgroundTable">
                        <tr>
                            <td valign="top" align="center">
                            <table width="676" cellpadding="0" cellspacing="0" bgcolor="#f0f0f0">
                                <tr>
                                    <td  bgcolor="#FFFFFF" valign="top">
                                        <table width="100%" border="0" cellpadding="0" cellspacing="0" background="'.$contact_path.'form_bg.jpg">
                                        <tr>
                                            <td><img style="display:block" src="'.$contact_path.'emailheader.jpg" width="676" height="100" alt="" />
                                            </td>
                                        </tr>
                                <tr>
                                    <td><table width="566" border="0" align="center" cellpadding="0" cellspacing="0">
                                        <tr>
                                            <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
                                                <tr>
                                                    <td width="80%" valign="top"><p style="font-size:12px; line-height:120%">
                                                        <p>ProductName: <strong>'.trim($_POST['productName']).'</strong><br>
                                                        DesignCode: <strong>'.trim($_POST['curDesignName']).'</strong><br>
                                                        Order Price: <strong>'.trim($_POST['designPrice']).trim($_POST['shopCurrency']).'</strong><br>
                                                        Shipment Price: <strong>'.$PaypalShipment.trim($_POST['shopCurrency']).'</strong></p>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td width="80%" valign="top"><p style="font-size:12px; line-height:120%">
                                                        Name: <strong>'.trim($_POST['name']).'</strong></p>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td width="80%" valign="top"><p style="font-size:12px; line-height:120%">
                                                        Address: <strong>'.trim($_POST['address']).'</strong></p>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td width="80%" valign="top"><p style="font-size:12px; line-height:120%">
                                                        Message: <strong>'.trim($_POST['message']).'</strong></p>
                                                    </td>
                                                </tr>                                               
                                                </table>
                                            </td>
                                        </table></td>
                                </tr>
                                <tr>
                                    <td height="16"><img style="display:block" src="'.$contact_path.'form_bg_separator.jpg" width="676" height="16" alt="" /></td>
                                </tr>
                                <tr>
                                    <td>
                                    <table width="100%" border="0" cellspacing="0" cellpadding="10" background="form_bg_grey.jpg">
                                    <tr>
                                        <td><p style="font-size:10px; line-height:140%; margin-left:45px; margin-right:45px; color:#666;" align="center">
                                            Copyright 2014 by Product-Designer</p>
                                        </td>
                                    </tr>
                                    </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td height="16"><img style="display:block" src="'.$contact_path.'form_bg_grey_end.jpg" width="676" height="16" /></td>
                                </tr>
                            </table></td>
                        </tr>
                </table></td>
                    </tr>
                        </table>
                        </td>
                        </tr>
                    </table>
                </body> 
            </html>';
$headers = "From: ".$email_to; 
$semi_rand = md5(time()); 
$mime_boundary = "==Multipart_Boundary_x{$semi_rand}x"; 
$headers .= "\nMIME-Version: 1.0\n" . 
            "Content-Type: multipart/mixed;\n" . 
            " boundary=\"{$mime_boundary}\"";
//
$contact_message_user .= $email_user . "\n\n" . 
                "--{$mime_boundary}\n" . 
                "Content-Type:text/html; charset=\"utf-8\"\n" . 
               "Content-Transfer-Encoding: 7bit\n\n" . 
$email_user . "\n\n";
$contact_message_user .= "--{$mime_boundary}\n" . 
                  "--{$mime_boundary}--\n"; 
$ok = @mail($contact_email, $userEmailSubject, $contact_message_user, $headers); 
echo "success=yes";
// return the filename
echo $file; exit;
?>