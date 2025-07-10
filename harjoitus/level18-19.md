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


## Jatkuu - selvittämistä
