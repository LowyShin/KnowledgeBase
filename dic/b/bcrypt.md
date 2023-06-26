# BCrypt

BCryptはハッシュする度にデータが変わって原本が推測できない長所を持っている暗号化方式の一つです。

md5とかsha256は暗号化の結果が同じなのでデータが漏れて暗号化されたパスワードがハッカーの手に入ったらパスワードが分からなくても接近できちゃうんですが、bcryptはいつも変わってしまうために元パスワードが分からないと侵入できないです。


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
