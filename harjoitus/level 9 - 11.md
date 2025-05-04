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







