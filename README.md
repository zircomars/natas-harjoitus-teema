# natas-harjoitus-teema
pieni harjoittelu, perus curl ja komentorivien pelittämistä web-sivustojen turvallisuutta
harjoituksessa käytettään powershell ja voihan kokeilla pientä python koodaustakin, mutta ideana on sama
tässä harjoituksessa haettaan sivustojen <b>käyttäjänimi : salasanaa </b>, eli se voi ola tallennettu palvelimen tiedoston alle, html koodin alle, kommentiksi tai jopa index of file (alle) tai muualle. Eli kokeillaan ja miten pitkälle saadaan. 

näitä vastauksia saa googlen ja muu julkaisemien tekemien harjoituksien kautta.
tämä on hyvä käyttää joko cmd/powershell tai vscode työkalua, mutta `curl` komento vaikuttaa siihen istuntoon, että pitää päivittää jatkuvasti jos yhtäkkiä lopettaa harjoittleun/tehtävän prosessin

# harjoitus linkki:
https://overthewire.org/wargames/natas/ <br>
https://overthewire.org/wargames/ (sama linkki, mutta etusivu)

## OvertheWire

Tämä itsensä on pelisarja, että alla on muita keskitettyi eri osia, koskien turvallisuusalueisiin ja -teemoihin. Pelejä on mm. **Bandwith** , **Leviathan**, **Krypton** ja jne.

## 1. **Bandit**
   - **Tarkoitus:** Bandit on tarkoitettu aloittelijoille ja se keskittyy komentorivikäytön, tiedostojärjestelmän ja perus-hakkeroinnin opetteluun.
   - **Teema:** Bandit on parhaiten tunnettu sen simppelistä ja suoraviivaisesta lähestymistavastaan. Haasteet käsittelevät pääasiassa oikeuksia, tiedostoja, hakemistoja ja salasanan murtamista.

## 2. **Leviathan**
   - **Tarkoitus:** Leviathan on verkkoturvallisuuden ja ohjelmistohakkeroinnin harjoitteluun suunniteltu peli.
   - **Teema:** Haasteet käsittelevät erityisesti verkkosovellusten ja protokollien turvallisuutta, kuten SSL, autentikointi ja etäyhteydet.

## 3. **Krypton**
   - **Tarkoitus:** Krypton on erityisesti kryptografiaan keskittyvä peli.
   - **Teema:** Haasteet liittyvät salaukseen ja salaustekniikoihin, kuten Caesar-salaus, XOR-salaus ja muuhun tietoturvaan liittyvään.

## 4. **Narnia**
   - **Tarkoitus:** Narnia keskittyy erityisesti ohjelmointivirheisiin ja haavoittuvuuksiin, joita voidaan hyödyntää hakkeroinnissa.
   - **Teema:** Se käsittelee erityisesti muistinhallintaa ja binäärifailien manipulaatiota. Haasteet voivat olla haastavampia, koska ne vaativat ymmärrystä ohjelmoinnista ja virheiden hyväksikäytöstä.

## 5. **Behemoth**
   - **Tarkoitus:** Behemoth on tarkoitettu haavoittuvuuksien etsimiseen ja hyödyntämiseen, erityisesti vanhemmissa ohjelmistoissa.
   - **Teema:** Behemoth käsittelee alkeellisempaa haavoittuvuuksien etsimistä ja turvallisuushaasteita, joissa on tarpeen käyttää vanhentuneita tekniikoita.

## 6. **Utumno**
   - **Tarkoitus:** Utumno keskittyy binäärisen koodin analysointiin ja ohjelmointivirheiden etsimiseen.
   - **Teema:** Tämä peli vaatii ymmärrystä siitä, miten ohjelmakoodia voidaan manipuloida ja hyväksikäyttää.

## 7. **Maze**
   - **Tarkoitus:** Maze on enemmän kuin vain haavoittuvuuksien etsimistä; siinä haetaan myös logiikkaa ja polkuja, jotka voivat johtaa päämäärään.
   - **Teema:** Tämä on hieman erikoisempi peli, jossa pelaaja navigoi "labyrintissa" ratkoen ongelmia ja haasteita.

## 8. **Vortex**
   - **Tarkoitus:** Vortex on verkkosovellusten ja haavoittuvuuksien hyödyntämiseen keskittyvä peli.
   - **Teema:** Haasteet voivat liittyä palvelimiin ja niiden konfiguraatioihin sekä palveluissa oleviin virheisiin ja bugeihin.

## 9. **Manpage**
   - **Tarkoitus:** Tämä on enemmän kuin vain turvallisuus; se keskittyy hakkerointiin, joka liittyy manuaalisivuihin ja käyttöjärjestelmän työkaluihin.
   - **Teema:** Manpage voi liittyä komentorivikäyttöön, ja sen tarkoitus on parantaa ymmärrystä Unix- ja Linux-järjestelmien komento- ja työkalupaketeista.

## 10. **Drifter**
   - **Tarkoitus:** Drifter on pelissä, jossa pelaaja etsii ja hyväksikäyttää haavoittuvuuksia ja hajoaa järjestelmän.
   - **Teema:** Tämä peli keskittyy erityisesti haavoittuvuuksien analysointiin ja niiden manipuloimiseen ohjelmointivirheiden avulla.

## 11. **FormulaOne**
   - **Tarkoitus:** FormulaOne on keskittynyt erityisesti ohjelmistotestaukseen ja hakkerointiin nopealla aikarajalla.
   - **Teema:** Tämä peli keskittyy nopeisiin hyökkäyksiin ja järjestelmän hajoamiseen, joten se on enemmän nopeatempoista ja vaatii reagointikykyä.

---

# muita huomioita;
tästä tuli jopa sähköpostia itselleni:

```
GitGuardian has detected the following Basic Auth String exposed within your GitHub account.
Details

- Secret type: Basic Auth String
```

GitGuardian ilmoittaa, on, että he ovat havainneet GitHub-tililläsi tunnistetiedot (käyttäjätunnus ja salasana) jollain tavalla julkisesti näkyvissä. Tässä tapauksessa kyseessä on Basic Auth String, joka on yksinkertainen tapa välittää käyttäjätunnus ja salasana verkkopyynnöissä. Se voi olla vaarallista, koska jos joku pääsee käsiksi tuohon tietoon, hän voi käyttää sitä päästäkseen käsiksi järjestelmiin, jotka vaativat autentikointia.


GitGuardian on työkalu, joka etsii tällaisia tietovuotoja GitHub-repositorioissa (ja mahdollisesti muilla alustoilla), ja lähettää ilmoituksen, jos se löytää, että arkaluontoisia tietoja (esim. salasanoja, API-avaimia tai muita tunnisteita) on vuotanut julkisesti.

Tämä on Natas on vain harjoitus joten on tämä Github-repositori on tehty simuloitu turvallisuustesti, silloin ei tarvitse huolestua oikeasta tietovuodosta ja pientä asiaa pitää tarkista mm.

- Jos tämä ilmoitus tuli GitGuardianilta tai muulta luotettavalta lähteeltä, kannattaa tarkistaa, onko kyseessä oikea ilmoitus vai testiviesti. Jos se on aidosti GitGuardianin lähettämä ilmoitus ja liittyy turvallisuustestaukseen, se todennäköisesti on vain harjoitus, eikä mikään vakava tietovuoto.

- Repo yksityinen tai julkinen. Jos repo on yksityinen, ei ole suurta vaaraa, koska vain sinä ja valtuutetut käyttäjät pääsevät siihen käsiksi. Jos taas repo on julkinen, ja siellä on vuotanut tunnistetietoja, silloin se kannattaa ottaa vakavasti.

- tietojen vuoto eli  GitGuardian voi tehdä ilmoituksen myös silloin, kun oikeasti on tapahtunut tietovuoto (esimerkiksi jos tunnistetiedot on vahingossa jätetty koodiin ja repo on julkinen). Siksi on hyvä varmistaa, ettei oikeasti ole mitään vuotanut, vaikka tämä olisikin vain harjoitus.

- harjoitusviesti opastusta, vaikka kyseessä on harjoitus, viesti saattaa sisältää myös ohjeita, kuten miten korjata tilanne ja mitä toimenpiteitä sinun tulisi tehdä. Jos et ole saanut sellaista ohjeistusta, kannattaa tarkistaa, onko viesti peräisin luotettavasta lähteestä.

- Vaikka kyseessä olisikin vain harjoitus, on silti hyvä varmuuden vuoksi vaihtaa kaikki salasana- ja API-avaimet, jotka saattavat olla julkisesti näkyvissä koodissasi. Se on hyvä turvallisuuskäytäntö.

