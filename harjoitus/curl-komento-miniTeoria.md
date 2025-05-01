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






