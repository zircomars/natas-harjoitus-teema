# normaalisti curl.exe TAI pelkä "curl" komento toimii

#alkuun oli curl komentojen ongelmia, kun alkuun piti toistella "$curl.exe" - niin nyt poistettaan toi joku itemi niin nyt pitäisi toimia eli pelkällä "$curl" jotakin
$Remove-Item Alias:curl
$curl -I https://example.com
HTTP/1.1 200 OK
Content-Encoding: gzip
Accept-Ranges: bytes
Age: 390652
Cache-Control: max-age=604800
Content-Type: text/html; charset=UTF-8
Date: Sat, 09 Nov 2024 09:21:16 GMT
Etag: "3147526947+gzip"
Expires: Sat, 16 Nov 2024 09:21:16 GMT
Last-Modified: Thu, 17 Oct 2019 07:18:26 GMT
Server: ECAcc (nyd/D148)
X-Cache: HIT
Content-Length: 648

curl.exe --help
Usage: curl [options...] <url>
 -d, --data <data>           HTTP POST data
 -f, --fail                  Fail fast with no output on HTTP errors
 -h, --help <category>       Get help for commands
 -i, --include               Include response headers in output
 -o, --output <file>         Write to file instead of stdout
 -O, --remote-name           Write output to file named as remote file
 -s, --silent                Silent mode
 -T, --upload-file <file>    Transfer local FILE to destination
 -u, --user <user:password>  Server user and password
 -A, --user-agent <name>     Send User-Agent <name> to server
 -v, --verbose               Make the operation more talkative
 -V, --version               Show version number and quit

This is not the full help; this menu is split into categories.
Use "--help category" to get an overview of all categories, which are:
auth, connection, curl, deprecated, dns, file, ftp, global, http, imap, ldap, output, pop3, post, proxy, scp, sftp, smtp, ssh, telnet, tftp, timeout, 
tls, upload, verbose.
For all options use the manual or "--help all".


curl.exe -I https://example.com
HTTP/1.1 200 OK
Content-Encoding: gzip
Accept-Ranges: bytes
Age: 161903
Cache-Control: max-age=604800
Content-Type: text/html; charset=UTF-8
Date: Sat, 09 Nov 2024 09:18:08 GMT
Etag: "3147526947+gzip"
Expires: Sat, 16 Nov 2024 09:18:08 GMT
Last-Modified: Thu, 17 Oct 2019 07:18:26 GMT
Server: ECAcc (nyd/D16E)
X-Cache: HIT
Content-Length: 648


$curl.exe -u natas0:natas0 http://natas0.natas.labs.overthewire.org 
<html>
<head>
<!-- This stuff in the header has nothing to do with the level -->
<link rel="stylesheet" type="text/css" href="http://natas.labs.overthewire.org/css/level.css">
<link rel="stylesheet" href="http://natas.labs.overthewire.org/css/jquery-ui.css" />
<link rel="stylesheet" href="http://natas.labs.overthewire.org/css/wechall.css" />
<script src="http://natas.labs.overthewire.org/js/jquery-1.9.1.js"></script>
<script src="http://natas.labs.overthewire.org/js/jquery-ui.js"></script>
<script src=http://natas.labs.overthewire.org/js/wechall-data.js></script><script src="http://natas.labs.overthewire.org/js/wechall.js"></script>
<script>var wechallinfo = { "level": "natas0", "pass": "natas0" };</script></head>
<body>
<h1>natas0</h1>
<div id="content">
You can find the password for the next level on this page.

<!--The password for natas1 is 0nzCigAq7t2iALyvU9xcHlYN4MlkIwlq -->
</div>
</body>
</html>


##############################################################################

