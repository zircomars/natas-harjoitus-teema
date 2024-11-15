# Referrer

`PS C:\> curl -e www.example.org http://www.example.com/`


Referer:istä vähä teoriaa
referer - vaihtoehto käyttäminen on toi .net-ratkaisun virhekorjaus, ja tämä viittaa logiikka riippuu viittaavasta sivutosta. 
suom. lähettäjä. Periaatteessa käyttää HTTP-pyyntöä liittyviä kenttä, joka kertoo, mistä vekrkosivustosta pyyntöä on lähtöisin. Eli kertoo, mikä URL-osoite on ohjannut käytäjän nykyiselle sivulle. Esimerkiksi, jos käyttäjä klikkaa linkkiä toisella sivulla ja saapuu nykyiselle sivulle, niin tämä toinen sivu (jolta linkki tuli) näkyy referrer-kentässä.

#esim, tässä määrittää "referrin", eli mistä osoitteesta pyyntö on tullut, sekä tämä lähettää pyynnön kohdesivulle ja ilmiottaa että pyyntö on tullut osoitteesta "http://example.com". Lyhyesti sanottuna MISTÄ sivustosta MIHIN sivustoon.
`PS C:\> curl -e "http://example.com" https://www.example.org`

päätteelle ei ole mitään väliä, eli vaikka ois domainissa (.org .fi .com ja jne) eli merkityksellistä. Referrer kenttä kertoo vain sen verkkosivuston tai URL-osoitteen, jolta pyyntö on tullut, riippumatta pääteosasta (domain-päätteestä).

Referrerin avulla voidaan siis seurata, mistä URL-osoitteesta pyyntö on lähtenyt ja minne se menee. Se ei sisällä käyttäjätietoja kuten käyttäjänimeä tai salasanaa, vaan kertoo vain verkkosivuston polun.


muita referrien pyyntöä ja esim. 
`-A` / `--user-agent` - määrittää user-agentin, joka kertoo, mikä selain tai ohjelma tekee pyynnön, ja tämä on tärkeä, koska jotkut palvelimet voivat käsitellä pyyntöä eri tavalla.

esim. tässä määritetään "Mozilla/5.0/ pyyntöä vaikutta tulevan chrome selaimelta.
`PS C:\> curl -A "Mozilla/5.0 (Windows NT 10.0; Win64; x64)" https://example.com`


`-H` / `--header` - muita HTTP-headerin arvoja. Tämän antaa mahdollisuuden lisätä custom HTTP-headerin pyyntöä. Tämä asettaa esim. Referrer-kentän manuaalisen tai muita kenttiä kuten <b>Authorization</b>

esim.  refer-headerin HTTP pyyntölä, jossa ensimmäisenä referr on example.com ja mikäli jos halutaan täysin hallita pyynnön headerit.
`PS C:\> curl -H "Referer: https://example.com" https://example.com`


<hr>

# Perus lisätietoa ja lukemista:

https://curl.se/docs/tutorial.html<br>
https://catonmat.net/cookbooks/curl/add-referrer<br>
https://martint86.github.io/curl-referer/<br>
https://wiki.sharewiz.net/doku.php?id=curl:referer_user_agent<br>
https://gist.github.com/afair/5265874<br>
https://www.cyberciti.biz/faq/linux-unix-appleosx-bsd-curl-command-httpreferer/<br>
https://dev.to/jvon1904/a-beginners-guide-to-curl-part-1-4j4j<br>
https://supporthost.com/curl-command-linux/<br>
https://loadfocus.com/fi-fi/glossary/what-is-curl-command<br>

