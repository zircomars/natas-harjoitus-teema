<?php

// next step is use the former (PHP-script-level11-1.php) input code which where will take small part and put in here.
function xor_encrypt($in) {
    $key = "eDWo";
    $text = $in;
    $outText = '';

    // Iterate through each character
    for($i=0;$i<strlen($text);$i++) {
    $outText .= $text[$i] ^ $key[$i % strlen($key)];
    }

    return $outText;
}

//final will echo and input the new cookie value which will this function to yes - as we want to solve the level 12 password 
echo base64_encode(xor_encrypt(json_encode(array( "showpassword"=>"yes", "bgcolor"=>"#ffffff"))));

?>
