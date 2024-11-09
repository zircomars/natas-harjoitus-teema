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

Ratkaisuna on näppäimstön CTRL + U , tai powershell terminaalista käyttäen level1 salasanaa eli.. tässä saattaan tulla pientä hämäystä että pitää olla alkuu -U tai -I ja jne, mutta hyvä kokeilla kaikkea mahdollisia vaihtoehtoja. 

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



