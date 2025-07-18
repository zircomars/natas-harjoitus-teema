# Curl komento

Tätä komentoa voi suorittaa joko PowerShell terminaalissa, normi Ubuntu/linux terminaalissa tai Kali linux ohjelmassa (virtualisoidun ympäristön kautta).

Natas-harjoituksessa, joka on osa tietoturvaan liittyvää oppimateriaalia, käytetään usein `$curl`-komentoja tai vastaavia työkaluja, koska nämä ovat tehokkaita ja joustavia välineitä HTTP-pyyntöjen suorittamiseen. Tämä harjoitussarja keskittyy verkkosovellusten tietoturvaan ja opettaa HTTP-protokollan perusteita sekä tiettyjen turva-aukkojen hyödyntämistä.

Syitä curl-komentojen käyttöön:
- Suora HTTP-pyyntöjen hallinta: Curl mahdollistaa GET-, POST- ja muiden HTTP-metodien käyttämisen helposti. Natas-harjoituksessa on tärkeää pystyä lähettämään tarkasti muotoiltuja pyyntöjä ja tarkastelemaan palvelimen vastauksia.

- Salasanan palautus: Monet Natas-harjoitukset sisältävät tehtäviä, joissa salasanoja löytyy palvelimen HTTP-vastauksista, piilotetuista parametreista tai muista verkkosovellusten kerroksista. Curl auttaa hakemaan nämä tiedot suoraan komentoriviltä.

- Automaatio: Curlia voidaan käyttää skriptien yhteydessä automatisoimaan tehtäviä ja testaukseen, mikä tekee siitä suositun työkalun tietoturva-ammattilaisten ja harrastajien keskuudessa.

- Helppous: Curl on kevyt ja tehokas työkalu, jota voi käyttää lähes kaikissa käyttöjärjestelmissä. Tämä tekee siitä kätevän harjoitusten suorittamiseen ilman lisäohjelmistojen asentamista.


Vaihtoehtoisia työkaluja:
Jos curl ei ole tuttu, samat toiminnot voi tehdä muilla työkaluilla, kuten:

- Postman: Käyttäjäystävällinen graafinen työkalu HTTP-pyyntöjen tekemiseen.
- PowerShell ja Invoke-WebRequest: Windows-käyttäjille sopiva vaihtoehto.

---

## Curl-komento: Käyttö ja Vastuullinen Testaus

Curl on tehokas ja joustava työkalu, jota käytetään HTTP-pyyntöjen suorittamiseen ja verkkopalvelujen testaamiseen. 

Curl-komento itsessään ei "anna" haavoittuvuutta, mutta se on hyödyllinen työkalu haavoittuvuuksien tunnistamiseen ja hyödyntämiseen, kun sitä käytetään oikein. Curl voi auttaa testaamaan palvelimen vastauksia, tietoturva-asetuksia tai selvittämään piilotettuja resursseja, jotka saattavat paljastaa haavoittuvuuden.

Sen käyttö ei rajoitu Natas-harjoituksiin, vaan sitä voidaan hyödyntää laajasti esimerkiksi seuraavissa tilanteissa:

### Curl-komennon käyttötarkoitukset
1. **API-yhteyksien testaaminen**
   - Tietojen hakeminen tai lähettäminen kolmannen osapuolen palvelimille.
   
2. **Verkkosivujen analysointi**
   - HTTP-vastausten ja otsikkotietojen tarkastelu verkkosivun toimivuuden testaamiseksi.
   
3. **Tiedostojen lataaminen**
   - Sisällön lataaminen suoraan verkosta komentorivin avulla.
   
4. **Verkon diagnosointi**
   - Yhteyksien nopeuksien ja virhetilanteiden testaaminen.
  

### Vaatimukset ja Luvat Testaukseen

Näiden testien suorittamiseen tarvitset palvelimen ylläpitäjän selkeän luvan, koska luvaton testaaminen on laitonta ja voi rikkoa käyttöehtoja. Curlin käyttö verkkopalveluiden testaamiseen on tehokasta, mutta siihen liittyy tiettyjä eettisiä ja juridisia vaatimuksia:

1. **Oman ympäristön käyttö**
   - Käytä curl-komentoa vapaasti omassa ympäristössäsi tai virtuaalilaboratoriossa, kuten Natas-harjoituksissa.

2. **Selkeä lupa**
   - Pyydä verkkosivuston tai palvelimen ylläpitäjältä lupa ennen curl-komennon käyttöä palvelun testaamiseen.

3. **Käyttöehdot**
   - Tarkista verkkosivujen ja palveluiden käyttöehdot; monet kieltävät automatisoitujen työkalujen käytön ilman lupaa.

4. **Eettiset periaatteet**
   - Harjoittele tarkoitukseen suunnatuilla alustoilla, kuten Natas, Hack The Box tai TryHackMe. Näissä ympäristöissä testaus on turvallista ja luvallista.

5. **Vastuullinen käyttö**
   - Noudata tietoturvatestaajien eettisiä periaatteita ja huolehdi, että toimintasi on lain mukaista.

---

### Harjoitusympäristöt
Jos haluat kehittää taitojasi curl-komennon käytössä, harkitse seuraavia harjoittelualustoja:
- **Hack The Box**
- **TryHackMe**
- **OWASP Juice Shop**
- **DVWA (Damn Vulnerable Web Application)**

---

# Kali Linux - ohjelma

Kali Linux tarjoaa lukuisia työkaluja, joita voi käyttää harjoitteluun ja erityisesti Natas-tyylisiin harjoituksiin, joissa keskitytään verkkosovellusten tietoturvaan.

### 1. Burp Suite (Community Edition)
- Soveltuu verkkosovellusten liikenteen manipulointiin ja haavoittuvuuksien etsimiseen.
- Hyödyllinen tarkastelemaan ja muokkaamaan HTTP-pyyntöjä.

### 2. Nikto
- Työkalu verkkopalvelimien haavoittuvuuksien kartoittamiseen.
- Auttaa löytämään piilotettuja tiedostoja ja hakemistoja.

### 3. WFuzz
- Erinomainen hakemistojen ja piilotettujen resurssien kartoittamiseen.
- Voidaan käyttää tiedostojen tai salasanojen etsimiseen.

### 4. Hydra
- Suunniteltu suorittamaan raa'an voiman hyökkäyksiä salasanojen murtamiseen verkkopalveluissa.

### 5. DirBuster ja gobuster
- Työkaluja verkkosivuston hakemistojen ja piilotettujen tiedostojen etsintään.

### 6. Netcat
- Monipuolinen työkalu verkkoprotokollien käsittelyyn ja keskustelujen seuraamiseen.

### 7. Curl ja wget
- Komentorivityökalut HTTP-pyyntöjen suorittamiseen, kuten GET- ja POST-pyyntöihin.

### 8. ZAP (OWASP Zed Attack Proxy)
- Käyttäjäystävällinen verkkosovellusten testaukseen; hyvä aloittelijoille.

## Muut Harjoitteluun Soveltuvat Resurssit
- **DVWA (Damn Vulnerable Web Application)**: Sovellus verkkosovellusten haavoittuvuuksien turvalliseen harjoitteluun.
- **Kali Linuxin yhteisö ja oppaat**: Useita valmiiksi asennettuja työkaluja sekä oppimateriaaleja kyberturvallisuuden harjoitteluun.

---

# 🛡️ Web CTF & Pentest Taktiset Perusmenetelmät

Tämä dokumentti osa kokoaa yhteen yleisiä ja tehokkaita menetelmiä, joita käytetään web-pohjaisissa CTF-haasteissa ja penetraatiotestauksessa. Menetelmät keskittyvät HTTP-pyyntöjen manipulointiin, debug-parametrien hyödyntämiseen, uudelleenohjauksien tarkasteluun ja mahdollisiin injektioihin.

## 📌 1. `curl`-komennon käyttö

`curl` on tehokas työkalu HTTP-pyyntöjen lähettämiseen ja vastausten analysointiin.

### 🔧 Peruskomennot

```
$curl -i http://example.com
$curl -v http://example.com
$curl -X POST -d "username=admin&password=1234" http://example.com/login
$curl --cookie "PHPSESSID=xyz" http://example.com
```

Optiota ja selitystä: 
- `-i`	Näyttää HTTP-headerit ja sisällön
- `-v`	Verbose-tila: näyttää yhteyden muodostuksen ja headerit
- `-X`	Määrittää HTTP-metodin (GET, POST, PUT jne.)
- `-d`	Lähettää dataa POST-pyynnössä
- `--cookie`	Asettaa evästeen manuaalisesti

---

## 🔍 2. URL-parametrien testaus

Monet haavoittuvuudet paljastuvat, kun kokeillaan erilaisia parametreja URL:ssa. 🧪 Testattavia parametreja jotka menevät url perään:

```
?debug=1
?admin=1
?reveal=true
?source=1
?test=1
?show=all
?view=raw
?cmd=ls
```

🔎 Näiden tarkoitus tarkoitus:
- Aktivoi debug-tila tai kehittäjän jättämä testikoodi
- Ohittaa käyttöoikeusvalvonnan
- Paljastaa lähdekoodin
- Käynnistää komentoja (jos haavoittuvuus sallii)

---

### 🚨 3. Poikkeustilanteiden hyödyntäminen

Joissain sovelluksissa virhetilanteet paljastavat arkaluontoista tietoa.

Esimerkkejä:
. Virheviestit, jotka paljastavat tiedostopolkuja tai SQL-kyselyitä
- Uudelleenohjaukset, jotka eivät lopeta koodin suorittamista (`header("Location: ...")`)
- Epäjohdonmukaiset sessionhallinnat

Testauksena esim. `curl -i "http://example.com/?reveal=1"`

Mikäli jos palvelin vastaa mutta myös salasansa voi olla haavoittuva

---

### 💉 4. Injektiot ja manipulointi
Parametrit voivat olla alttiita injektioille:

🔥 Mahdollisia hyökkäyksiä
SQL-injektio: ?id=1' OR '1'='1

Command injection: ?cmd=ls; cat /etc/passwd

XSS: ?search=<script>alert(1)</script>

Path traversal: ?file=../../etc/passwd


















