# Natas lunttilapput

Eli aikaisempien harjoittuksien kannalta kertyy ja taso menee vaikeammaksi ja vaikeammaksi. Listataan olennaiset tarkistukset, ettei ole vain yhtä tapaa;

- tarkista sivuston "inspect" eli avaamalla näppäimistöstä F12 , tai joko sivustolta oikea hiirellä "inspect" - ja katso onko koodissa mitään `username:password`
  - tarkista onko tiedoston polussa mitään polkuaja kuten `/file/image.jpg`, eli poista image.jpg , ja mene `/file`- polkuun, ja tarkista onko mahdollista olla .txt tiedostoa tai muuta arkistoa
  - lisää url polkuun `/robots.txt` , jos ois robots tiedosto, niin siellä voi lukea lisä vinkkejä. Todellisuudessaan kaikilla sivustoilla ei ole robots.txt-tiedostoa, koska sen käyttö ei ole pakollista. Jotkut haluavat hakukoneiden indeksoivan kaiken, kun taas toiset eivät tarvitse erityisiä rajoituksia. Ilman tätä tiedostoa hakukoneet voivat silti yrittää indeksoida kaikki löydettävissä olevat sivut, ellei muita estomekanismeja ole käytössä.
 
# curl komentoja

käytettään -Headeri referenssiä (`-H` - on se lyhenne), ja tässä muutama ovat melko samoja, mutta jotekin se objekti/nimi/muuttuja on erissä järjestyksessä mutta idea on sama;

- `$curl -H "Referer: http://natas7.natas.labs.overthewire.org/" -u "natas7:bmg8SvU1LizuWjx3y7xkNERkHxGre0GS" "http://natas7.natas.labs.overthewire.org/index.php?page=home" `

- `$curl -u natas7:bmg8SvU1LizuWjx3y7xkNERkHxGre0GS "http://natas7.natas.labs.overthewire.org"`

---

# LEVEL 9 - START HERE;

natas9  ZE1ck82lmdGIoErlhQgWND6j2Wzz6b6t

Tässä kappaleessa tapahtuu SQL injektiota, ja tässä tasossa käytettään puolikasta kaksoispistettä `;`. Miten tämä liittyy tähän haavoittuvuutteen ja tasoon? Koska SQL-injektiossa liittyy siihen, miten SQL-kyselyt voidaan ketjuttaa tai erottaa toisistaan. SQL-injektiossa hyökkääjä voi käyttää puolikasta kaksoispistettä ; lisätäkseen ylimääräisiä SQL-komentoja alkuperäiseen kyselyyn, mikä voi johtaa tietokannan manipulointiin tai tietojen vuotamiseen.

Ensimmäisenä tarkistettaan koodit joko F12 / hiiren oikean klikkauksella, ja sama idea kuin aikaisempi taso (Level 8), jossa anna salainen koodi niin saadaan Level 10 salasanansa. Seuraavaksi sitten mennään **"view sourcode" välilehteen**.
![alt text](./kuvat-level6-10/level9-0.png)

Sama tässä "view sourcecode" sivuston välilehdessä toi pientä vihjettä, mutta ei paljoo - paitsi "dictionary.txt"

![alt text](./kuvat-level6-10/level9-1.png)

Sijoitin tiedoston polun URL linkkiin, mutta yhtäkkiä se onkin joku yleinen tiedosto kirjasto `/dictionary.txt`

![alt text](./kuvat-level6-10/level9-2.png)

## Level 9 - 1 selvittämistä

Tässä välilehden sivustossa on koodattu PHP-koodkielellä (siinä välissä)

Harjoituksessa tässä tapahtuu periaatteessa rivissä / kohdalla kuin `"passthru("grep -i $key dictionary.txt");"` - joka on haavoittuvuus. Tämä ei tarkista, mitä `$key` muuttujassa on - joten käyttäjä voi lisätä shell-komentoja sen perään puolipisteellä `;`

Tässä harjoituksessa nimenomaan passthru()-funktio on haavoittuva, koska:
- Se suorittaa shell-komennon suoraan ilman suodatusta.
- Käyttäjän syöte ($_REQUEST["needle"]) liitetään suoraan komentoon ilman rajausta tai puskurointia.
- Ja kuten mainittua – puolipiste ; toimii komentojen erottimena Linuxin bashissa, jolloin hyökkääjä voi lisätä omia komentojaan perään.

**Tuotannossa/tosi elämässään**; <br>
Todellisuuden parantaminen, jos puhutaan tietoturvallisesta ja vastuullisesta tavasta käsitellä käyttäjän syötettä, niin `passthru()`-funktion käyttö pitäisi useimmissa tapauksissa poistaa tai ainakin eristää tarkasti.
- älä koskaan päästä käyttäjiä syötettä komentoriville - edes käsitelynsä - jos voi tehdä niin saman asian suoraan PHP:llä.
- Vain rajoittaa käyttäjän syötettä siten, että sitä ei käsitellä tai hyväksyä, ellei se viittaa tiettyyn hyväksyttyyn tiedostoon/hakemistoon tai arvoon. Tämä on yksi suojaustapa.

Tämä koskee myös muita erikoismerkkejä, polkuviittauksia kuten `../secrets.txt` ja sallii vain esim. `dictionary.txt`- tiedoston käsittelyä, ja ei käytä komentorivienkäskyjä **(passthru/exec)**- kaikkiin tehdä turvallisesti PHP:llä ja tämä koskee koko verkkosivustojen arkkitehtuuria.

![alt text](./kuvat-level6-10/level9-1.png)

## Level 9 - 2 - HARJOITUS JATKUU

Periaatteessa menee takaisin etusivulle ja siitä syöttää ja tekee SQL injektiota käyttäen kaksois puolipistettä `;` ja tässä harjoituksessa kokeillaan käyttää Linux terminaalia ja yleisiä komentoja. Muissa linkeissä (netistä) jos tarkistelee ja lunttaa sieltä, niin siellä on muitakin keinoja mm. syöttää siihen kenttään `../../../` ja jne. mutta harjoitus on harjoitus.

Tässä harjoituksessa halutaan mennä kuin aikaisempi tasossa **(level 7)** ideana, että selvitettään `/etc/natas_webpass/natas10` - tämän level 10 tason salasansa. Eli kiinnitettään tähän hakemiston polkuun `/etc/natas_webpass/` - eli **uutta asiaa jälleen kerran**.

Harjoituksessa käytin kenttään; `;ls -l;` - jossa alkaa kaksois puolipiste ja Linux list `-l` (long), ja kuvassa näkyy minkä toistin, niin se tuo sen tuloksensa.

![alt text](./kuvat-level6-10/level9-3.png)












































































