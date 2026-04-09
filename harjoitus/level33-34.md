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


















