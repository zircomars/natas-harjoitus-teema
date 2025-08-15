# OWASP ja natas

## Natas
Natas-harjoitus on verkkosivustojen haavoittuvuuksien testaamiseen tarkoitettu harjoitusympäristö, joka toimii selaimen kautta. Nataksella on n. 34 tasoa harjoitusta, jokaisessa on **HTTP Basic Authenticationilla**. Jokaisessa sivustossa on sama URL alkuinen osa, mutta se loppu osa on vain eri: `http://natas{LEVEL}.natas.labs.overthewire.org` .

Natas ympäristössä on monia **OWASP Top 10** kategorioiden harjoittelua, mutta ei kuitenkaan katta jokaista kohtaa täydellisesti, mutta jo pelkästään tasoissa esiintyy haasteitta osuvien useissiin listoihin ytimeen.

- **Injection (A03)**
  - Löytyy mm. SQL-injektioita, komentoinjektioita ja XSS:ää.
  -  Hyvä paikka harjoitella syötteen manipulointia ja filtterien kiertämistä.

- **Broken Access Control (A01)**
   - Joillakin tasoilla pääsee käsiksi tietoihin tai toimintoihin, joihin ei pitäisi olla oikeuksia, esim. URL-manipulaatiolla tai HTTP Basic Auth -tietojen arvaamisella.

- **Security Misconfiguration (A05)**
  - Esim. palvelimen paljastamat tiedostot, väärin asetetut hakemistolistaukset tai debug-tiedot.

- **Identification & Authentication Failures (A07)**
  - Salasanojen bruteforce, heikot tunnukset, session hallinnan puutteet.

- **Cryptographic Failures (A02)**
  - Joissakin tasoissa näkee heikkoja tai väärin käytettyjä salausmenetelmiä.

- **Software & Data Integrity Failures (A08)**
  - Harvemmin suoraan, mutta voi tulla vastaan esim. luottamusta ulkoisiin resursseihin ilman tarkistusta.

---

## OWASP TOP 10

OWASP (Open Web Application Security Project) Top 10 -lista on yleisesti tunnustettu luettelo tärkeimmistä verkkosovellusten haavoittuvuuksista. Se on hyödyllinen lähtökohta, koska se kattaa kaikkein kriittisimmät ja yleisimmät haavoittuvuudet, jotka voivat vaarantaa verkkosivuston ja sen käyttäjien turvallisuuden. Tämän listan avulla voidaan tunnistaa ja korjata haavoittuvuuksia ennen kuin niitä hyödynnetään haitallisesti.


Tämä taulukko tarjoaa tiiviin yhteenvedon OWASP Top 10 -haavoittuvuuksista, niiden kuvauksista, esimerkeistä/testausideoista sekä yleisistä testaukseen käytettävistä työkaluista.  
Soveltuu nopeaan kertaamiseen, harjoitteluun (esim. DVWA/Juice Shop) tai projektin README-tiedostoksi.

| #   | Haavoittuvuus | Kuvaus | Esimerkki / Testausidea | Työkalut |
|-----|---------------|--------|------------------------|----------|
| **A01** | Broken Access Control | Käyttäjä pääsee tietoihin tai toimintoihin ilman oikeuksia | URL-manipulaatio: `/admin/delete?id=1` | Burp Suite, OWASP ZAP, curl |
| **A02** | Cryptographic Failures | Salauksen puutteet tai virheellinen käyttö | Salaamaton HTTP, heikko hash | testssl.sh, sslscan, Wireshark |
| **A03** | Injection | Haitallinen syöte suoritetaan komentona/kyselynä | SQL: `' OR '1'='1` | sqlmap, NoSQLMap, Burp Intruder |
| **A04** | Insecure Design | Turvallisuuspuutteet suunnittelussa | Ei kirjautumisyritysten rajoituksia | OWASP Threat Dragon, Draw.io |
| **A05** | Security Misconfiguration | Väärin asetetut palvelimet, headerit, debug-tilat | Paljastettu stack trace, avoin admin | Nikto, Nmap, WhatWeb |
| **A06** | Vulnerable & Outdated Components | Haavoittuvat kirjastot tai ohjelmistot | jQuery 1.x, vanha Log4j | Nmap + Vulners, OpenVAS, dependency-check |
| **A07** | Identification & Authentication Failures | Heikko tunnistus/kirjautuminen | Brute force, session hijacking | Hydra, Medusa, Burp Suite |
| **A08** | Software & Data Integrity Failures | Datan/koodin eheystarkastusten puute | CDN JS ilman hashia | sha256sum, GPG, Sigstore Cosign |
| **A09** | Security Logging & Monitoring Failures | Ei lokitusta tai hälytyksiä | Ei merkintää epäonnistuneista kirjautumisista | GoAccess, OSSEC, Splunk Free |
| **A10** | Server-Side Request Forgery (SSRF) | Palvelin tekee pyynnön käyttäjän syötteen mukaan | `http://localhost:8080/admin` | Burp Repeater, curl, wget |



















