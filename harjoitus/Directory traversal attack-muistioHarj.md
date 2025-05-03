# Directory traversal attack

tämä koskee level 7 harjoitusta, joka on ideana selvittää URL-linkin polkua, jotta saadaan selvitettyä sitä level 8 pääsyn salasansa esim. `http://example.com/../../company/users/list.txt`

# level 7 - koskien

tämä on se virallinen vastaus polku; `http://natas7.natas.labs.overthewire.org/index.php?page=../../../../../../etc/natas_webpass/natas8` 

tämä on se alkuperin URL polkua, mitä oli käytössä; `http://natas7.natas.labs.overthewire.org/index.php?page=home/`

Saattiin yhdestä/useammasta sivustosta vihjettä;
```
<br />
<b>Warning</b>:  include(home/etc/natas_webpass/natas8): failed to open stream: No such file or directory in <b>/var/www/natas/natas7/index.php</b> on line <b>21</b><br />
<br />
<b>Warning</b>:  include(): Failed opening 'home/etc/natas_webpass/natas8' for inclusion (include_path='.:/usr/share/php') in <b>/var/www/natas/natas7/index.php</b> on line <b>21</b><br />

<!-- hint: password for webuser natas8 is in /etc/natas_webpass/natas8 -->

```

1. sijoitin ton antaman vihjeen `/etc/natas_webpass/natas8` tuohon alkuperäiseen URL perään, ja katsottiin mitä se antoi.
   - näin ollen; `http://natas7.natas.labs.overthewire.org/index.php?page=home/etc/natas_webpass/natas8`

2. seuraavaksi aloitettiin ottaa tuota tarjoamaa ettei ole tällaista tiedostoa ja/tai hakemiston polkua eli `/var/www/natas/natas7/index.php`- tässä tapauksessa kertoo, että tiedosto sijaitsee hakemistossa `/var/www/natas/natas7/`.

Kuista päästääisiin maaliin asti? Käyttäen `/etc/natas_webpass/natas8` -tiedostoon ilman tarkkaa tietoa alkuperäisestä polusta, voisi lähteä oletuksesta, että sivusto pyörii web-palvelimen hakemistossa (`/var/www/`). Siitä voi arvioida tarvittavat siirtymät. Näin otettaan tämä tiedostopolkua `/var/www/natas/natas7/index.php` muutettaan `../` - merkintöjä päästäkseen ylöspäin hakemistorakennetta ja näin ollen haluttua kohdetta, ja se on oletuttu tiedostopolku siksi muuttuu näin `../../../../../../etc/natas_webpass/natas8`. Siksi tämä `../` alkaa `home` polusta alkaen, että korvautuu siihen tilalle.


Periaatteessa tämä mahdollistaa **directory traversal** -hyökkäyksen, jossa pääset lukemaan tiedostoja, joita ei pitäisi olla saatavilla. Tästä syystä verkkopalveluiden pitäisi suojautua tällaiselta manipulaatiolta esimerkiksi **suodattamalla** `../`-merkinnät ja määrittämällä tiukat käyttöoikeudet tiedostoille.

Sekä tämä on tärkeä pointti käytännön hyökkäyksissä tai CTF-tehtävissä, joissa ei tiedetä tarkkaa polkua (eli mistä hakemistosta `include()` suoritetaan). 

---

# Mitä tehdään, jos ei tiedetä kuinka monta `../?`

Jos ei tiedetä, missä hakemistossa ollaan, voidaan kokeilla eri määriä `../`-tasoja ja toistaa yrityksiä kunnes osutaan oikeaan.

esim. kokeilla näin; 
```
?page=../../etc/natas_webpass/natas8
?page=../../../etc/natas_webpass/natas8
?page=../../../../etc/natas_webpass/natas8
?page=../../../../../etc/natas_webpass/natas8
```

Jatketaan, kunnes ei enää tule virhettä vaan sisältö ladataan. Tyypillisesti 4–6 kpl `../` riittää, jos ollaan jossain `/var/www/...` -rakenteessa.


## Vihjeitä sijainnista?

Jos saa virheilmoituksen kuten; `Warning: include(home/etc/...) in /var/www/natas/natas7/index.php`.
On mahdollista tällainen tai muuten vastaava web-sovellus/sivusto testaessa kuten saa suoraan PHP:n koodikielen virheilmoituksensa kuten; `Warning: include(home/etc/natas_webpass/natas8): failed to open stream...` 
Tämä toisi vihjettä _hakkerille_ - ja juuri tämä on asia, jota ei saisi tapahtua virallisesti tuotannonympäristössä.

Tämä kertoo jo, että `index.php` sijaitsee hakemistossa `/var/www/natas/natas7/`. Nyt voidaan laskea tarvittavat `../` -tasot tarkasti:

- /var (1)
- /www (2)
- /natas (3)
- /natas7 (4)

Yksi lisää, että päästään juureen: yhteensä 5 kpl `../`
Eli `../../../../../etc/natas_webpass/natas8`


## Jos mitään vihjettä ei ole?
Jos PHP:n virheilmoituksia ei näytetä ollenkaan (esim. virheenkäsittely pois päältä), silloin pitää arvailla ja testata monta eri vaihtoehtoa, ja toivoa, että jossain vaiheessa saat oikean sisällön takaisin (esim. salasanan tai tunnistetekstin).

---

# Kali Linux - terminaalissa 

Aikaisemman harjoittuksen kannalta onko ainoa tapa testata `../` polkun selvittämistä, että kyllä jos ei tiedetä tasan tarkkalleen oikeeta polkua.
Directory traversal -hyökkäys perustuu siihen, että yrität suhteellisesti mennä ylöspäin hakemistorakenteessa, kunnes pääset johonkin arkaluontoiseen tiedostoon.

perus voi kokeilla tätä bash komentoa ja tämä on for-loop, periaatteessa skriptinäkin toimii ja tämä on _brute-force traversaliksi_;
```
for i in $(seq 1 10); do
  path=$(printf "../%.0s" $(seq 1 $i))
  curl "http://natas7.natas.labs.overthewire.org/index.php?page=${path}etc/natas_webpass/natas8" --user natas7:<salasana>
done
```





