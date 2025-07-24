# natas 25 - START HERE;

Username: natas25 Password: ckELKUWZUfpOv6uxS6M7lXBpBssJZ4Ws


Ensimmäisen kirjauduttua joku lorem ipsum quote runoilu sivusto, ja siinä voi valita kielensä et menee joko oletuksena (eng) tai vaihtaa to saksan kieleksi. 


**view-source.html** koodissa on ainakin muutama funktio, josta koskien tämä pieni runoilu teksit säkeistöstä että sallii vaihtakielensä ja oletuksena se on englanniksi.

Tässä on jotakin vinkkejä annettu koskien "directory traversal attempt" , ja tiedostojen polku tyyppiä, että tekee funktioiden tarkistusta ja palauttamista, että sen korvaamisen suojaa tiedostopolkua.

🕵️‍♂️ logRequest()-funktio tallentaa session-tunnukseen perustuvan lokin tiedostoon, mikä on selvä vihje, että lokien polku voi paljastaa salaisuuksia. just tämä `/var/www/natas...`.

Erikseen on funktio kirjauttumisen pyyntö viesti, että annettu tällainen polku vinkkinä:

```
function logRequest($message){
        $log="[". date("d.m.Y H::i:s",time()) ."]";
        $log=$log . " " . $_SERVER['HTTP_USER_AGENT'];
        $log=$log . " \"" . $message ."\"\n"; 
        $fd=fopen("/var/www/natas/natas25/logs/natas25_" . session_id() .".log","a");
        fwrite($fd,$log);
        fclose($fd);
    }
```

Tämä Natas25 taso liittyy vahvasti haavoittuvuuteen nimeltä local file inclusion (LFI) ja mahdolliseen session-id -manipulointiin. Session-id kenttään tulee toi kirjautuneen evästeen PHPSESSID value. Sekä tässä lokituksessa ($log) termistössä on mainintana date (päiväys ja kellonaikakin), että normi lokituksen dataa.

Tässä kun valitsee kielensä esim. eng tai tanskaksi se kyllä muuttaa samantien sivuston URL perään `/?lang=en` ja sama pätee saksaksi `/?lang=de`- tämä voi kertoa jotakin tulostuksena tiedoston polkua.


Tässä alemmassa funktiossa, niin tässä tapahtuu **bypassing the ../ check** osa. Ainakin tässä mainuttu on tiedoston polku ja monta mahtaa olla kyseessä? Kokeillaan laitaa muutama piste ja kautakauta  että antaako mitään eli `....//`.


- Tässä `$filename, "../"` 

```
// check for directory traversal
        if(strstr($filename,"../")){
            logRequest("Directory traversal attempt! fixing request.");
            $filename=str_replace("../","",$filename);
        }
```

🔐 Mitä funktiossa tapahtuu?

PHP-koodissa yritetään suojautua hakemistohyökkäyksiltä (directory traversal) — eli tilanteilta, joissa käyttäjä yrittää päästä käsiksi tiedostoihin menemällä takaisin hakemistorakenteessa `../.`

🚧 Miksi tämä ei riitä?
Kirjoittaja kertoo, että vaikka `../` poistetaan, on mahdollista kiertää suoja käyttämällä erikoismuotoa: `....//`

Koodi yrittää estää tiedostojen luvattoman lukemisen poistamalla `../`, mutta fiksu hyökkääjä voi kiertää tämän käyttämällä `....//`, joka toimii samoin mutta ei jää suodatukseen kiinni.

Tämä on klassinen esimerkki siitä, miten **suodatus ei riitä** — pitää käyttää esim. **täydellistä polun normalisointia tai whitelist-pohjaista sisällytystä.**



