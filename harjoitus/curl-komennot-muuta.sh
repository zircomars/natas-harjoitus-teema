# level 0 - 2

https://overthewire.org/wargames/natas/


## curl komenot

Apua ja miten tätä curl komentoa pelitettään tosiaan `curl --help` toistaa vähä kuin pientä ohjeistusta 

Tässä voi olal ehkä tärkeimistä ollaan käytettään -I (hakee head pyyntöä eli headeriä palvelimelta) ja -U ( käytetään määrittämään proxy-käyttäjätunnus ja salasana. Tämä valinta liittyy siihen, että käytetään välimuistipalvelinta (proxy) verkon liikenteen ohjaamiseen)

```
PS C:\> curl --help
Usage: curl [options...] <url>
 -d, --data <data>           HTTP POST data
 -f, --fail                  Fail fast with no output on HTTP errors
 -h, --help <category>       Get help for commands
 -i, --include               Include response headers in output
 -o, --output <file>         Write to file instead of stdout
 -O, --remote-name           Write output to file named as remote file
 -s, --silent                Silent mode
 -T, --upload-file <file>    Transfer local FILE to destination
 -u, --user <user:password>  Server user and password
 -A, --user-agent <name>     Send User-Agent <name> to server
 -v, --verbose               Make the operation more talkative
 -V, --version               Show version number and quit

This is not the full help; this menu is split into categories.
Use "--help category" to get an overview of all categories, which are:
auth, connection, curl, deprecated, dns, file, ftp, global, http, imap, ldap, output, pop3, post, proxy, scp, sftp, smtp, ssh, telnet, tftp, timeout, 
tls, upload, verbose.
For all options use the manual or "--help all".
```

## level 0 

```
Username: natas0
Password: natas0
URL:      http://natas0.natas.labs.overthewire.org
```

Eli ekaksi mennään tuohon sivustoon eli tosiaan, ensimmäisenä syöttää perus username:password
Näiden sivustossa nasta jotakin lukua on se level mitä vaikeammaksi mennään eli vaikappa level 1 (natas1) , level 2 (natas2) ja jne. Käyttäjänimi on alku osa sama paitsi se luku on vain eri, että salasana on vedetty hattusta, joten pitää selvittää mikä salasana on.

![alt text](./kuvat/level0-1.png)

sitten seuraavaksi päästyä nii näkymä tulee `You can find the password for the next level on this page.`

![alt text](./kuvat/level0-2.png)


Miten tästä päästään jatkaa? 


### level 0 - 1
Tosiaan sivustossa monet saattaa käydä katsossa sitä koodia miltä se näyttää just mm. se on kirjoitettu html tyyppisenä eli F12 tai oikean hiiren klikkauksella (tai näppäimistöstä CTRL + U)


Avattuna CTRL + U , tai oikean hiiren klikkauksesta "View page source" ja sama idea oiskin avaisi F12

![alt text](./kuvat/level0-3.png)


### level 0 - 2

kokeillaan leikkiä vähäsen `curl` komentoa, jos tosiaan curl komennossa tulee ongelmia, että pitää toista `$curl.exe` niin se on työllästä niin poista tämä/aktivoi poistaa tämän aliasin nykyisessä PowerShell-istunnossa `Remove-Item Alias:curl` , jonka jälkeen voi normaalisti toistaa `curl`


nyt tosiaan saattiin se salasana eli level 1:selle, niin avaa uuden välilehden ja menee tuohon sivustoon. Kantsii tarvittaessa kirjoittaa ylös toi salsana uutteen txt tiedoston alle.

```
PS C:\> curl -u natas0:natas0 http://natas0.natas.labs.overthewire.org
<html>
<head>
<!-- This stuff in the header has nothing to do with the level -->
<link rel="stylesheet" type="text/css" href="http://natas.labs.overthewire.org/css/level.css">
<link rel="stylesheet" href="http://natas.labs.overthewire.org/css/jquery-ui.css" />
<link rel="stylesheet" href="http://natas.labs.overthewire.org/css/wechall.css" />
<script src="http://natas.labs.overthewire.org/js/jquery-1.9.1.js"></script>
<script src="http://natas.labs.overthewire.org/js/jquery-ui.js"></script>
<script src=http://natas.labs.overthewire.org/js/wechall-data.js></script><script src="http://natas.labs.overthewire.org/js/wechall.js"></script>
<script>var wechallinfo = { "level": "natas0", "pass": "natas0" };</script></head>
<body>
<h1>natas0</h1>
<div id="content">
You can find the password for the next level on this page.

<!--The password for natas1 is 0nzCigAq7t2iALyvU9xcHlYN4MlkIwlq -->
</div>
</body>
</html>
```

tämä on sama kuin ylempi ja sama idea komento, mutta alkuun laitettu `http://<USERNAME:PASSWORD>` - sitten natas level taso numero ja se loppu url kenttä. tämä pitää olla mukana, koska kuin kirjauduttaisiin SSH johonkin `<USERNAME>:<PASSWORD>` ja tätä tullaan käyttää seuraavissa levelissäkin.

```
PS C:\> curl http://natas0:natas0@natas0.natas.labs.overthewire.org 
<html>
<head>
<!-- This stuff in the header has nothing to do with the level -->
<link rel="stylesheet" type="text/css" href="http://natas.labs.overthewire.org/css/level.css">
<link rel="stylesheet" href="http://natas.labs.overthewire.org/css/jquery-ui.css" />
<link rel="stylesheet" href="http://natas.labs.overthewire.org/css/wechall.css" />
<script src="http://natas.labs.overthewire.org/js/jquery-1.9.1.js"></script>
<script src="http://natas.labs.overthewire.org/js/jquery-ui.js"></script>
<script src=http://natas.labs.overthewire.org/js/wechall-data.js></script><script src="http://natas.labs.overthewire.org/js/wechall.js"></script>
<script>var wechallinfo = { "level": "natas0", "pass": "natas0" };</script></head>
<body>
<h1>natas0</h1>
<div id="content">
You can find the password for the next level on this page.

<!--The password for natas1 is 0nzCigAq7t2iALyvU9xcHlYN4MlkIwlq -->
</div>
</body>
</html>
```



## To level 1 

http://natas1.natas.labs.overthewire.org/

toistetaan se level 0 haettu tämän level 1 salasana.

![alt text](./kuvat/level1-0.png)


![alt text](./kuvat/level1-1.png)

Nyt päästettyä sisään niin normi oikeasta hiiren klikkaus ei toimi enään, mitä neuvoksi tehdään?
![alt text](./kuvat/level1-2.png)


## To level 1 - 1

Ratkaisuna on näppäimstön CTRL + U , tai powershell terminaalista käyttäen level1 salasanaa eli.. tässä saattaan tulla pientä hämäystä että pitää olla alkuu -U tai -I ja jne, mutta hyvä kokeilla kaikkea mahdollisia vaihtoehtoja. Tässä periaatteessa ikään kuin kirjauduttaan sivuston natas1 ja sen salasanalla sisään, ja sen polku. Joten päästään seuraavaksi level 2:lle.

```
PS C:\> curl http://natas1:0nzCigAq7t2iALyvU9xcHlYN4MlkIwlq@natas1.natas.labs.overthewire.org
<html>
<head>
<!-- This stuff in the header has nothing to do with the level -->
<link rel="stylesheet" type="text/css" href="http://natas.labs.overthewire.org/css/level.css">
<link rel="stylesheet" href="http://natas.labs.overthewire.org/css/jquery-ui.css" />
<link rel="stylesheet" href="http://natas.labs.overthewire.org/css/wechall.css" />
<script src="http://natas.labs.overthewire.org/js/jquery-1.9.1.js"></script>
<script src="http://natas.labs.overthewire.org/js/jquery-ui.js"></script>
<script src=http://natas.labs.overthewire.org/js/wechall-data.js></script><script src="http://natas.labs.overthewire.org/js/wechall.js"></script>
<script>var wechallinfo = { "level": "natas1", "pass": "0nzCigAq7t2iALyvU9xcHlYN4MlkIwlq" };</script></head>
<body oncontextmenu="javascript:alert('right clicking has been blocked!');return false;">
<h1>natas1</h1>
<div id="content">
You can find the password for the
next level on this page, but rightclicking has been blocked!

<!--The password for natas2 is TguMNxKo1DSa1tujBLuZJnDUlCcUAPlI -->
</div>
</body>
</html>
```

<hr>

## level 2 

Skippasin tästä kirjauttumisen sisään, mutta sama idea kuin edellisessä levelissä 0 ja 1, että avatun välilehteen syötä <USERNAME>:<PASSWORD>

Ensimmäinen oletus sivusto ja ihan normaalilta, sitten alettaan hakea kaikkea mahdollisia aukkoja/keinoja saadakseen seuraavan level 3:sen salasana. On hyvä esim. laittaa ranskalais viiva ja mahdollisia keinoja miten, kuinka ja mistä löytää se level 3:sen salasana. 
![alt text](./kuvat/level2-1.png)

Tästäkin nyttenkin mentiin oikeahiiren klikkauksesta (view open source), (options: CTRL + U , tai F12) ja nyt meitä kiinnosta toi rivi 15, jossa on kuva tiedosto ja se voi olla viittaa sinne palvelimen tiedostoihin/kansioihin. Palvelimen/Serverin tiedoston takana saattaa olla muita tiedostoja mm. kuvat, videot, javascript koodit, tietokannat ja jne. Eli klikkaamalla tuota tai välilehdestä syöttää perään toi `files/pixel.png`
![alt text](./kuvat/level2-2.png)

Avatun ton pixel.png kuvassa ei löytynyt kauhesti mitään mieleniintoa ja siksi tuossa välilehden polussa kumitin sen pois, ja siksi mentiin tähän `files` polkuun. Näin ollen päästiin seuraavaan vihjeeseen/johtolankaan, ja ensimmäisen pistää silmiinsä toi `users.txt` ja avataan sitä. 
![alt text](./kuvat/level2-3.png)

Näin olen löydettiin se txt tiedosto ja level 3:sen salasana.
![alt text]./kuvat/(level2-4.png)


## level 2 - 1 

tässä sivu kappaleena tarkistellan powershell terminaalista eli leikkimistä curl kanssa
tässä pieni huomiona, että ensin kirjauduttiin siihen natas2 salasanaan, ja tuloksena näyttikin sen palvelimen html koodit ja sama ideana koodista pisti silmiinsä toi `<img src="files/pixel1.png">` polku, mutta toi files polku kiinnostaa.

PS C:\> curl http://natas2:TguMNxKo1DSa1tujBLuZJnDUlCcUAPlI@natas2.natas.labs.overthewire.org
<html>
<head>
<!-- This stuff in the header has nothing to do with the level -->
<link rel="stylesheet" type="text/css" href="http://natas.labs.overthewire.org/css/level.css">
<link rel="stylesheet" href="http://natas.labs.overthewire.org/css/jquery-ui.css" />
<link rel="stylesheet" href="http://natas.labs.overthewire.org/css/wechall.css" />
<script src="http://natas.labs.overthewire.org/js/jquery-1.9.1.js"></script>
<script src="http://natas.labs.overthewire.org/js/jquery-ui.js"></script>
<script src=http://natas.labs.overthewire.org/js/wechall-data.js></script><script src="http://natas.labs.overthewire.org/js/wechall.js"></script>
<script>var wechallinfo = { "level": "natas2", "pass": "TguMNxKo1DSa1tujBLuZJnDUlCcUAPlI" };</script></head>
<body>
<h1>natas2</h1>
<div id="content">
There is nothing on this page
<img src="files/pixel.png">
</div>
</body></html>

tässä komennossa jatketiin sama kuin edellinen, mutta siihen välilehdene perästä haettaan vielä lisätietoa, mitä ikään kuin surffailaan chromessa niin miltä se näyttää. Tässä samaa vastaavasti toi `users.txt` eli txt tiedoston 
PS C:\> curl http://natas2:TguMNxKo1DSa1tujBLuZJnDUlCcUAPlI@natas2.natas.labs.overthewire.org/files/
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2 Final//EN">
<html>
 <head>
  <title>Index of /files</title>
 </head>
 <body>
<h1>Index of /files</h1>
  <table>
   <tr><th valign="top"><img src="/icons/blank.gif" alt="[ICO]"></th><th><a href="?C=N;O=D">Name</a></th><th><a href="?C=M;O=A">Last modified</a></th><th><a href="?C=S;O=A">Size</a></th><th><a href="?C=D;O=A">Description</a></th></tr>
   <tr><th colspan="5"><hr></th></tr>
<tr><td valign="top"><img src="/icons/back.gif" alt="[PARENTDIR]"></td><td><a href="/">Parent Directory</a></td><td>&nbsp;</td><td align="right">  - </td><td>&nbsp;</td></tr>
<tr><td valign="top"><img src="/icons/image2.gif" alt="[IMG]"></td><td><a href="pixel.png">pixel.png</a></td><td align="right">2024-09-19 07:03  </td><td align="right">303 </td><td>&nbsp;</td></tr>
<tr><td valign="top"><img src="/icons/text.gif" alt="[TXT]"></td><td><a href="users.txt">users.txt</a></td><td align="right">2024-09-19 07:03  </td><td align="right">145 </td><td>&nbsp;</td></tr>
   <tr><th colspan="5"><hr></th></tr>
</table>
<address>Apache/2.4.58 (Ubuntu) Server at natas2.natas.labs.overthewire.org Port 80</address>
</body></html>

jälleen kerran toistettaan viimeisenä ja lisättynä url polkuun toi `users.txt` ja näin ollen päästään ja saadan level3:sen salasana
PS C:\> curl http://natas2:TguMNxKo1DSa1tujBLuZJnDUlCcUAPlI@natas2.natas.labs.overthewire.org/files/users.txt
# username:password
alice:BYNdCesZqW
bob:jw2ueICLvT
charlie:G5vCxkVV3m
natas3:3gqisGdR0pjm6tpkDKdIWO2hSvchLeYH
eve:zo4mJWyNj2
mallory:9urtcpzBmH


# Perus lisätietoa ja lukemista:

https://curl.se/docs/tutorial.html
https://catonmat.net/cookbooks/curl/add-referrer
https://martint86.github.io/curl-referer/
https://wiki.sharewiz.net/doku.php?id=curl:referer_user_agent
https://gist.github.com/afair/5265874
https://www.cyberciti.biz/faq/linux-unix-appleosx-bsd-curl-command-httpreferer/
https://dev.to/jvon1904/a-beginners-guide-to-curl-part-1-4j4j
https://supporthost.com/curl-command-linux/
https://loadfocus.com/fi-fi/glossary/what-is-curl-command





