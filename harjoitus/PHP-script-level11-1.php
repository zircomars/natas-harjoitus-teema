<?php
// Eli Ekana tässä PHP koodi skriptissä tapahtuu näin;
// "cookie se value + xor encryptaus + base64 enkoodaus" = valmis eväste

// funnction which where we can to change
function xor_encrypt($in) {
    $key = json_encode(array( "showpassword"=>"no", "bgcolor"=>"#ffffff"));
    $text = $in;
    $outText = '';

    // Iterate through each character
    for($i=0;$i<strlen($text);$i++) {
    $outText .= $text[$i] ^ $key[$i % strlen($key)];
    }

    return $outText;
}

//original cookie value 
$cookie = "HmYkBwozJw4WNyAAFyB1VUcqOE1JZjUIBis7ABdmbU1GIjEJAyIxTRg%3D";
echo "Key = ";

// echo input the key code
echo xor_encrypt(base64_decode($cookie))

?>
