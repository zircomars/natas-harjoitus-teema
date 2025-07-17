# natas 20 - START HERE;

Username: natas20 <br>
Password: p5mCvP7GS2K6Bmt3gqhM2Fc1A5T8MVyw

Tässä levelissä tapahtuu **rivien injektointi**. Tämä tarkoittaa, jossa sessioiden käsittely on toteutettu omatekoisesti — ja juuri siinä piilee haavoittuvuus. Tämä taso on enemmänkin tekstin käsittelyn haavoittuvuus, ei varsinaista salausta tai bruteforcea.

![alt text](./kuvat-level16-20/natas20-0.png)

**View-source.html** phpkoodissa on kirjoitettu oletusistunnon tallennusfunktioita, jossa lukee ja kirjoittaa session tiedoston, että muut funktiosta `myopen`, `myclose`, `mydestroy` ja `mygarbage` - ovat tyhjiä - että niitä ei tarvitse ottaa huomioon, mutta pieni hämäys.

`session_start();` - eli sivuston istunnon käynnisteässä ja odottaa käyttäjän syöttämisen - joka lukee tiedoston `mysess_<PHPSESID>`.

![alt text](./kuvat-level16-20/natas20-1.png)

![alt text](./kuvat-level16-20/natas20-2.png)


---

Tässä tarkistin ton eväste koodin, että mitä se tarkoittikaan ja ei antanut kauheasti mitään kuin pelkä "h" - kuitenkin hyvä tarkistus steppi aikaisempien harjoittelujen mukaankin.

![alt text](./kuvat-level16-20/natas20-3.png)

Tässä lisäsin url perään `?debug` - jonka jälkeen toi uuden sivuston ja tämän kautta (sivun) mukaan saadaa se natas21 salasansa selvitettyä, mutta miten?

![alt text](./kuvat-level16-20/natas20-4.png)

Tässä ideana on jotenkin syötettyö muutoksen nimensä "test" ja sitten toisen kerran "\naadmin 1" , siinä pitää tulla välilyönti mukaan.

![alt text](./kuvat-level16-20/natas20-5.png)

![alt text](./kuvat-level16-20/natas20-6.png)

![alt text](./kuvat-level16-20/natas20-7.png)

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

# Haavoittuvuuden paikantaminen

Eli nyt alettaan selvittää ja tarkisteellaan tämä tason haavoittuvuutta ja debugoidaan muuttujansa. Tässä välissä/tilanteessa joutuu kirjoittaa url perään toi **?debug**, koska jotta se ymmärtää ja syöttää toi kentän muuttamisen nimensä.

Ohjeissa on käytettään burp suit jotenkin jännästi (vanhat ohjeet), mutta jos yrittää saada toistetua "test" sitten "admin + 1" ja lisää url perään *"?debug"* niin sen jälkeen pitäisi saada nähdättyä natas21 salasanasa, mutta voi olla mennään mutkan kautta.

Burpsuit siinä kun syöttää kenttään "test admin 1" niin tässä välilyönnissä se muuttuu automaattisesti URL enkoodattuna ja sama pätee muita erikoismerkkiä ja sen kanssa.

Vastauksena ja ratkaistettuna pitisi mennä **\nAadmin 1** , et toi välilyönti tulee mukaan. Ja samahan pitäisi jotenkin aktivoida **BurpSuite** kautta ton **Proxy**:n *Intercept* asetuksensa päälle, jotta ikään kuin seuraa suoraan sitä lomakekenttäänsä. Keinona on jotenkin muuttaa sen lähetyksensä et menee oikeasti, koska joka kerta kun toistaa "test" ja "\naadmin 1" niin se ei ymmärrä sitä pyyntöä.

---

## kali linux - checkkausta


```
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
```


Muutamissa funtion koodissa on mainittu *debug* sana, että lisätty URl perään **?debug**, et ainakin näytti jotakin mielenkiintoista dataa/infoa. Toistin saman curl komennon, et verrattuna selaimessa on sama toisto. Tarkistin ton saving in /var polun, joka ei viennyt mihinkään

```
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
```


## Kali linux - Burpsuite

Avaa ohjelmasta kuin **Burp suite** - ja sitä tarvittaan tässä levelissä. Tässä jotekin pitää saada kaappattua se sivuston dataa ja sitten muuttaa "test":stä --> "\naadmin 1":ksi. 

Tässä on muutama kuva, josta on tullut pientä epäonnistumista, mutta jälkeen tulee se toimiva osuus.

![alt text](./kuvat-level16-20/natas20-8.png)

![alt text](./kuvat-level16-20/natas20-9.png)

![alt text](./kuvat-level16-20/natas20-9-1.png)

Tästä jotekin pitää saada otettua **repeater** talteen, jonka idea on toistaa ja lähettää sitä muutettua osaa.

![alt text](./kuvat-level16-20/natas20-9-2.png)

![alt text](./kuvat-level16-20/natas20-10.png)

Tässä on pientä toistoa, mutta tässä (vasemmalla) alhaala sitten muuttaa **"test"** kohti --> **"\naadmin 1"** ja huomoina, jokaisesta erikoismerkistä/tietty sana ja välilyönti muuttuu enkoodattuna URL:issa. 

Muutetun jälkeen sitten "\naadmin 1" --> sitten *send* , jonka jälkeen päivittä sivusto ja laita perään **?debug**, koska sitä tarvittaan ja näin saatujen jälkeen niin tulos tulee näkyviinsä.

![alt text](./kuvat-level16-20/natas20-11.png)

![alt text](./kuvat-level16-20/natas20-12.png)

--- 

# natas 21 - START HERE


Username: natas21 <br>
Password: BPhv63cKE1lkQl04cE5CuFTzXe15NfiH

Tässä on pari erisivustoa, josta etusivu on ja toisessa on väri sivusto, että molemmissa menee sama salasansa. Toisessa sivustossa voi muuttaa värinsä natas21 - CSS style experimenter

![alt text](./kuvat-level16-20/natas21-0.png)

![alt text](./kuvat-level16-20/natas21-1.png)


![alt text](./kuvat-level16-20/natas21-2.png)


![alt text](./kuvat-level16-20/natas21-3.png)

Pikainen tarkistus tuosta evästeestä, kun kirjauduttiin normaalisti natas21 ja sen salasansa mukaan.

![alt text](./kuvat-level16-20/natas21-4.png)


![alt text](./kuvat-level16-20/natas21-5.png)


![alt text](./kuvat-level16-20/natas21-6.png)

Testasin muutamalla admin tunnuksella, et miltä se näyttikään ja siellä css style view source koodissa on mainittukin **debug** sana.

CSS Tyle experimenter - sallitut ominaisuudet ja ainoastaan sanalla "hello world" - että sen takana on pieni taustaväri. Vain validoitut ominaisuudet ja tietyt voi muuttaa esim. se teksti voi siirtyä keksellä, vasen ja oikealle, että taustaväri ja oletuksena on se on väriltään keltainen kun kirjautuu uudestaan, että fontti koko voi muuttaa prosenttin mukaan. Sekä siellä koodi pätkässä on **debug** joten lisättin url perään **?debug** ja antoi tämän eli just: 

```
[DEBUG] Session contents:
Array ( )
```

![alt text](./kuvat-level16-20/natas21-7.png)

Pientä pohdiskelua ainakin tämä muistuu aikaisemman tason mukaan (natas20), mutta silti kirjauduttu natas21 etusivuston mukaan ollaan kirjauduttu regular user.

---

## Kali linux checkkausta

```
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
```

Otin toisesta sivusta vähä lisätietoa ja katsotaan mitä tulostui;
```
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
```

Tässä lisäsin `-v` eli verbose (`--verbose`) , mitä halutaan nähdä tarkemmin mitä tapahtuu;

```
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
```

## Kali linux - Burpsuite

Tämä burp suite harjoitus joka muistuu sama kuin aikaisempi taso eli *natas20* level, mutta tarvittaan se burp suit sivusto ja toistetaan se "send to repeater" välilehteen. Tällä kertaa käytettään se **css style sivustoa**, koska siellä on lomakekenttä, vaikka se on tarkoitettu syöttää vain muotoilua värinvaihto, tekstin kenttä onko keskellä-vasen-oikealla ja fonttin kokoon.

Jotenkin osasta ohjeesta, muuttaa tuosta kentästä ja lähettää **&admin=1** - niin saa uuden PHPSESSID tunnuksensa, sitten korvaa sinne natas21 etusivuun ja päivittää sivuston niin natas22 salasana pitäisi tulla.

Periaatteessa pitäisi mennä sivuston natas21-experimenter-sivulle ja tehdä lomakemuokkaus (admin=1). Niin sieltä tulee joku PHPSESSID-arvo ja sitä pitää liittää natas21 pääsivulle ja sitten päivittää uuden sivuston niin pitäisi saada admin oikeus..







