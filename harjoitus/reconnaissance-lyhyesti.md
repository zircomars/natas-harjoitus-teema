# Reconnaissance

Reconnaissance (tiedustelu) on ensimmäinen vaihe monissa hyökkäysmalleissa, kuten _Cyber Kill Chainissa_. Sen tarkoitus on **kerätä mahdollisimman paljon tietoa kohteesta ennen varsinaista hyökkäystä.** Tausta tulee pitkälti sotilasopista, jossa tiedustelu on jatkuvaa ja tavoitteellista toimintaa. Reconnaissancillä on kaksi päätyyppiä: **passiivinen ja aktiivinen** reconnaissance.

- Passive reconnaissance = tiedonkeruu ilman suoraa vuorovaikutusta kohteen järjestelmien kanssa, esim. OSINT, julkiset rekisterit, hakukoneet, sosiaalinen media. Tarkoitus on pysyä huomaamattomana.

- Active reconnaissance = tiedonkeruu, jossa otetaan suoraan yhteyttä kohteen järjestelmiin, esim. porttiskannaus, palveluiden tunnistus, ping‑testit. Tämä voi paljastaa hyökkääjän toiminnan.

Tässä natas harjoituksessa tapahtuu active reconnaissance:a

🧠 Miksi se on aktiivista?
Koska:
- Lähetät suoria HTTP-pyyntöjä Natas-palvelimelle (esimerkiksi hakemistorakenteen tutkiminen, URL-parametrien manipulointi, jne.)
- Vuorovaikutat suoraan kohdejärjestelmän kanssa (vaikka se onkin tarkoituksellisesti harjoituskohde)
- Saat vastauksia palvelimelta pyyntöihisi → tämä on määritelmän mukaan aktiivista tiedustelua.

🛠 Esim. Kun käytettään Kali Linuxilla työkaluja (osat esiasennettu tai pitää asentaa erikseen) `curl`, `Burp Suite`, `ZAP Proxy`, `dirb`, `gobuster` tai muita HTTP-työkaluja testataksesi Natasin tehtäviä – toimit aktiivisesti.


❓ Voiko siinä olla passiivisia elementtejä?
Kyllä, mutta vain jos et tee suoria pyyntöjä palvelimelle.

Esimerkkejä passiivisesta harjoittelusta:
- Lukea Natas-tason lähdekoodia, joka on jo esillä selaimessa ilman, että teet uusia pyyntöjä.
- Tehdä Google-hakuja liittyen haavoittuvuuteen.
- Etsiä tietoa siitä, miten tietynlainen tehtävä yleisesti ratkaistaan ilman interaktiota kohteen kanssa.
- Mutta käytännössä, kun "ratkaiset Natas-tehtäviä", toimittaan aktiivisesti.

| Toiminto                                              | Tyyppi         |
|-------------------------------------------------------|----------------|
| Googletat SQL-injektiosta yleisesti                   | 🔵 Passiivinen |
| Skannaat Natas-tehtävän palvelinta `dirb`:llä         | 🔴 Aktiivinen  |
| Käytät Burp Suitea testataksesi lomakkeita            | 🔴 Aktiivinen  |
| Luet Natasin HTML-lähdekoodia selaimessa              | 🔵 Passiivinen |




