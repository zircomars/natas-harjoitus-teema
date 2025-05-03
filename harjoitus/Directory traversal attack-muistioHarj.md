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

Kuista päästääisiin maaliin asti? Käyttäen `/etc/natas_webpass/natas8` -tiedostoon ilman tarkkaa tietoa alkuperäisestä polusta, voisi lähteä oletuksesta, että sivusto pyörii web-palvelimen hakemistossa (`/var/www/`). Siitä voi arvioida tarvittavat siirtymät. Näin otettaan tämä tiedostopolkua `/var/www/natas/natas7/index.php` muutettaan `../` - merkintöjä päästäkseen ylöspäin hakemistorakennetta ja näin ollen haluttua kohdetta, ja se on oletuttu tiedostopolku siksi muuttuu näin `../../../../../../etc/natas_webpass/natas8`.

Periaatteessa tämä mahdollistaa **directory traversal** -hyökkäyksen, jossa pääset lukemaan tiedostoja, joita ei pitäisi olla saatavilla. Tästä syystä verkkopalveluiden pitäisi suojautua tällaiselta manipulaatiolta esimerkiksi **suodattamalla** `../`-merkinnät ja määrittämällä tiukat käyttöoikeudet tiedostoille.

---

# Mitä jos ei tiedetä, kuinka monta ../ tullaan syöttää?

# Vihjeitä sijainnista?
