# BCrypt



## Python sample

```py
import bcrypt

password = b"test123456"

salt = bcrypt.gensalt()

hashed = bcrypt.hashpw(password,salt)

if bcrypt.checkpw(password, hashed):
    print("照合されました")
else:
    print("照合されませんでした")
```


- [python sample(ja)](https://laboratory.kazuuu.net/using-bcrypt-in-python-to-match-passwords-against-a-hash-value/)
