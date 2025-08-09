# natas27 - START HERE;

natas27 ; u3RRffXjysjgwFU6b9xa23i6prmUsYne 

![alt text](./kuvat-level22-28/natas27-0.png)


syötin ainakin pari tunnusta mutta "admin:admin" sanoi : User admin was created!
kokeilin toista "testi.testi" - User testi was created!

syötin uudestaan (admin:admin) niin kirjautui sisään ja tuli tervetuloa - odotellaan n. 5 min (view-source mukaan) - pitäisi tyhjentää tietokannan - voiko se koskea näitä luoneita tunnuksia?

Eli periaatteessa tässä etusivun kirjautumisessa tapahtuu niin että joutuu luoda uuden tunnuksen ikään kuin (admin;admin) sitten pääsee kirjauttuu sisään ja tulee se tervetuloa admin. 5 min päästä se poistaa tämän luoneen tunnuksen tietokannasta ja huomoina tarkistettu se ei ainakaan tallenna evästeitä.

view-source.html:ssä on osa jotakin SQL komentoja koodattu tässä PHP funktoin määrityksen sisällä kuitenkin.

![alt text](./kuvat-level22-28/natas27-1.png)

![alt text](./kuvat-level22-28/natas27-2.png)

## koodin tarkistuksena - START HERE;

Eli käydään lävitse view-source.html:ssä mitä tässä koodissa oikein puhuttaan vaikka onkin SQL:ää tässä mainittu tosi osassa funktioiden alla.


Tässä , jos pyyntö sisältää käyttäjätunnus ja salasansa , kun lähetämme lomakkeen ja kuin täyttäisi uuden tunnuksensa.

```
if(array_key_exists("username", $_REQUEST) and array_key_exists("password", $_REQUEST)) {
    $link = mysqli_connect('localhost', 'natas27', '<censored>');
    mysqli_select_db($link, 'natas27');


    if(validUser($link,$_REQUEST["username"])) {
        //user exists, check creds
        if(checkCredentials($link,$_REQUEST["username"],$_REQUEST["password"])){
            echo "Welcome " . htmlentities($_REQUEST["username"]) . "!<br>";
            echo "Here is your data:<br>";
            $data=dumpData($link,$_REQUEST["username"]);
            print htmlentities($data);
        }
        else{
            echo "Wrong password for user: " . htmlentities($_REQUEST["username"]) . "<br>";
        }
    }
    else {
        //user doesn't exist
        if(createUser($link,$_REQUEST["username"],$_REQUEST["password"])){
            echo "User " . htmlentities($_REQUEST["username"]) . " was created!";
        }
    }

    mysqli_close($link);
} else {
?>
```



Seuraavaksi, yhteys ottaa tietokantaansa ja ohjelma tarkastaa käytäjätunnuksensa kelvolliseksi käyttämällä tätä funktiota `validUser()`.

```
function validUser($link,$usr){

    $user=mysqli_real_escape_string($link, $usr);

    $query = "SELECT * from users where username='$user'";
    $res = mysqli_query($link, $query);
    if($res) {
        if(mysqli_num_rows($res) > 0) {
            return True;
        }
    }
    return False;
}
```


Jos mikäli tunnistetieto (käyttäjätunus ja salasnsa) nini tarkistettaan funktiossa `checkCredentials` alla.

```
function checkCredentials($link,$usr,$pass){

    $user=mysqli_real_escape_string($link, $usr);
    $password=mysqli_real_escape_string($link, $pass);

    $query = "SELECT username from users where username='$user' and password='$password' ";
    $res = mysqli_query($link, $query);
    if(mysqli_num_rows($res) > 0){
        return True;
    }
    return False;
}

```


seuraavaksi, jos tunnusket täsmää ja kelvollisia niin sitten kaikki tunnukset dumpataan eli `dumpData` funktiolla - eli kuin tyhjentää sen tunnuksen pois alta.

```
function dumpData($link,$usr){

    $user=mysqli_real_escape_string($link, trim($usr));

    $query = "SELECT * from users where username='$user'";
    $res = mysqli_query($link, $query);
    if($res) {
        if(mysqli_num_rows($res) > 0) {
            while ($row = mysqli_fetch_assoc($res)) {
                // thanks to Gobo for reporting this bug!
                //return print_r($row);
                return print_r($row,true);
            }
        }
    }
    return False;
}

```


Viimeisenä jos ei , niin voi luoda uuden käyttäjäntunnuksens ja salasansa - jos ei ole olemassa mikäli on dumpattu/tyhjennetty tietokannan alta - `createUser` - funktio.

```
function createUser($link, $usr, $pass){

    if($usr != trim($usr)) {
        echo "Go away hacker";
        return False;
    }
    $user=mysqli_real_escape_string($link, substr($usr, 0, 64));
    $password=mysqli_real_escape_string($link, substr($pass, 0, 64));

    $query = "INSERT INTO users (username,password) values ('$user','$password')";
    $res = mysqli_query($link, $query);
    if(mysqli_affected_rows($link) > 0){
        return True;
    }
    return False;
}

```


🔎 Tilannekuva

Nyt yritettään pitää saada tietoa käyttäjästä natas28, mutta ei tiedetä tiedä **natas28** salasanaansa. Suoraa SQL-injektiota ei voi tehdä, koska kaikki syötteet suojataan `mysql_real_escape_string()`-funktiolla. Tästä syystä perinteinen SQL-injektio ei onnistu.


💡 Vihjeet ja havaintoja
1. checkCredentials() tarkistaa käyttäjätunnuksen JA salasanan.
Eli jos syötät väärän salasanan, saat virheilmoituksen.

2. validUser() ja dumpData() tarkistavat VAIN käyttäjätunnuksen.
Eli kun joku käyttäjätunnus löytyy, niin voit saada sen tiedot näkyviin — vaikka salasana olisi väärä.

3. Taulussa ei ole määritelty käyttäjänimen ainutlaatuisuutta!
Usein username on asetettu UNIQUE, mutta tässä ei ole. Tämä on kriittinen.

4. Käyttäjänimen ja salasanan sarakkeet ovat VARCHAR(64)
Jos laitat yli 64 merkkiä pitkän merkkijonon, MySQL leikkaa ylimääräiset pois (ellei strict mode ole käytössä, mikä tässä oletetaan olevan pois päältä).



🎯 Hyökkäysidea: Hyödynnä käyttäjänimen leikkaantumista

Koska username-kenttä on VARCHAR(64) ja ei ole ainutkertainen, voit luoda uuden käyttäjänimen, joka alkaa samalla tavalla kuin natas28, mutta jatkuu ylimääräisillä merkeillä yli 64 merkkiä.


- Esim, käyttäjänimellä: `natas28AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA`
- Salasana osuus: `natas28AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA`

Eli näissä molemmissa siis kun syötetään tietokantaan, MySQL **truncaa** (truncate table) sen 64 merkin kohdalla.

Jos tekisi  salasantarkistuksensa checkCredentials()-funktiolla, niin sinun syötteesi ei ole täsmälleen sama kuin tietokannassa oleva, joten salasanatarkistus epäonnistuu. Ei haittaa!

Kun taas käytät dumpData()-funktiota, joka hakee tietoja pelkän käyttäjänimen perusteella, niin jos teet uuden käyttäjän jolla on username = natas28 ja se tallentuu truncattuna samalla tavalla kuin oikea natas28, saatat osua oikean käyttäjän tietoihin — koska MySQL:n vertaillessa username-kenttää se näkee leikatun version.

- `mysql_real_escape_string()` - estää injektiot, mutta ei loogisia virheitä.
- Käyttämällä yli 64 merkkiä pitkää käyttäjänimeä, joka alkaa natas28, voit huijata järjestelmää dumpaamaan toisen käyttäjän tietoja.



![alt text](./kuvat-level22-28/natas27-3.png)
![alt text](./kuvat-level22-28/natas27-4.png)
![alt text](./kuvat-level22-28/natas27-5.png)
![alt text](./kuvat-level22-28/natas27-6.png)
![alt text](./kuvat-level22-28/natas27-7.png)
![alt text](./kuvat-level22-28/natas27-8.png)
![alt text](./kuvat-level22-28/natas27-9.png)
![alt text](./kuvat-level22-28/natas27-10.png)
![alt text](./kuvat-level22-28/natas27-11.png)
