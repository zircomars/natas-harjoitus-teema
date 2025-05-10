# LEVEL 12 - START HERE

natas12 is yZdkjAYZRd3R7tq7T5kXMjMJlOIkzDeB

Perus ekana tarkistellaan, mitä tässä on koodattukaan 

![alt text](./kuvat-level11-15/level12-0.png)

Jotenkin tässä harjoituksessa huomataan PHP-koodikielestä että **JPEG** - kuva tiedosto maksimi on 1KB (MAX_FILE_SIZE).

![alt text](./kuvat-level11-15/level12-1.png)

Periaatteessa upotin jonkun satunnaisen kuvatiedoston ja testiä ainakin toimii siis et tuli _"There was an error uploading the file, please try again!"_  - mut tämä tapahtuu toisessa uudessa sivuston alla kun jos tulee _error_ ja polku */index.php*. 

![alt text](./kuvat-level11-15/level12-3.png)

![alt text](./kuvat-level11-15/level12-4.png)

Perus selvittämistä ja etsitään netistä lisää ohjeita ja lisätietoa, mutta siellä on jotakin testejä että upottaa PHP-koodikielisen scriptin. Rakensin simppelin PHP koodikielen pikaisesti joku **Hello world** Kali Linux:seen , `tesi1.php`. Huomioina ennen kuin upottaa ton PHP-scriptin testin sinne Natas12 harjoitukseen, niin avaa ohjelmisto työkalu kuin **Burp Suite**, ja Kali linux antama oletus ja minimaaliset on jo riittävät ettei tarvitse olla mitään _pro / subscribe_ versiota. 

Burp Suite:ssa riittää avaa _History_ välilehden ja seuraa sieltä tarkasti sivussa, kun on upottanut PHP-koodi scriptin Natas 12 levelin alle.

```
<?php

echo "Hello World!";

?>

```

![alt text](./kuvat-level11-15/level12-5.png)

![alt text](./kuvat-level11-15/level12-6.png)

![alt text](./kuvat-level11-15/level12-7.png)

![alt text](./kuvat-level11-15/level12-8.png)

![alt text](./kuvat-level11-15/level12-9.png)
