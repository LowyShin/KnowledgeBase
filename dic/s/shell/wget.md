サイトを階層指定をしてダウンロード
```sh
# (-l 3) は3階層までのリンク、(-r)はリンクをたどって再帰的、(-H)はドメイン固定、他のサイトへのリンクは辿らない
wget -l 3 -H -r http://www.hatena.ne.jp
```

名前を付けて保存
```sh
# (-O <path><filename>)で名前を指定してダウンロード
wget http://www.hatena.ne.jp -O ./DL/hatena-top.html
```

SSLの付いたサイトへアクセスするには
```sh
# httpsなサイトから、sslに対応していないwgetを使うとエラーになるので--no-check-certificateで無視して落とせる
wget --no-check-certificate <URL>

# ~/.wgetrcにルート証明書などを追記してやれば、wgetをsslに対応させることもできる
# wget -q http://curl.haxx.se/ca/cacert.pem -O ~/.cacert.pem
# echo ca-certificate = ~/.cacert.pem >> ~/.wgetrc 
# ユーザーごとではなく、全体に対応させる場合は/etc/wgetrcに追記する
```

BASIC認証で制限の掛かったサーバーからwgetする方法
```sh
# BASIC認証は最近見かけなくなりましたが、こんな感じで
wget --http-user={username} --http-passwd={password} {url} 
```

OAuth認証のかかったサーバはcookiesで対応する
```sh
wget --save-cookies cookies.txt --post-data 'user=foo&password=bar' http://server.com/auth.php
wget --load-cookies cookies.txt -p http://server.com/interesting/article.php
```

ユーザエージェントをつけてアクセスする場合
```sh
# 携帯サイトからデータを引っ張るときとか、UAを偽装しないといけないときなど
wget --user-agent="Mozilla/5.0 (iPhone; CPU iPhone OS 7_0 like Mac OS X) AppleWebKit/537.51.1 (KHTML, like Gecko) Version/7.0 Mobile/11A465 Safari/9537.53"
```

post送信したい場合
```sh
# useridとpasswordフォームを送りつける場合
wget --post-data="userid=XXXXXXX&password=YYYYYYY" --no-check-certificate "https://accounts.google.com/servicelogin?hl=ja"
```

wgetでSOAPのテストをする、APIを叩く
```sh
# xmlをポストして、xmlを受ける場合
wget --post-file=soaprequest.xml --header="Content-Type: text/xml" --header="SOAPAction: \"soapaction\"" http://server/app/myservice.asmx -O response.xml

# jsonをポストして、jsonを受ける場合
wget --post-file=soaprequest.json --header="Content-Type: text/json" --header="SOAPAction: \"soapaction\"" http://server/app/myservice.asmx -O response.json
wgetでRestful APIへアクセスする
wget -dvO- --post-file request.xml http://example.net/service
```

クッキーを無効にして、ヘッダーをつけてJDKを落とす
```sh
wget --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/8u121-b13/e9e7ea248e2c4826b92b3f075a80e441/jdk-8u121-linux-x64.rpm
```

連番ファイルを落とす
環境依存になります、うまく展開されず、{}が%7Bと%7DにURLエンコードされてしまう場合はおとなしくcURLを利用してください

```sh
wget http://example.com/H1000{00..99}.JPG
```

【代替コマンド】cURLでの連番展開例
```sh
# 1～100までのファイル
curl -O http://example.com/[1-100].jpg

# a～zまでのファイル
curl -O http://example.com/[a-z].jpg

# 1～100までを10きざみで
curl -O http://example.com/[1-100:10].jpg

URLリストを作って連続ダウンロード
wget -i url-file.txt
```

ニコニコ静画をダウンロードしてPDFにする
```sh
#Cookieのセーブとロードがミソ
wget -O - --post-data="mail_tel=<メールアドレス>&password=<パスワード>" --save-cookies=cookie.txt --keep-session-cookies "https://secure.nicovideo.jp/secure/login?site=niconico"
wget -O - --load-cookies=cookie.txt "http://seiga.nicovideo.jp/api/theme/data?theme%5Fid=87011" | grep source_url | grep -o 'http[^<]\+' | xargs wget
convert [!cookie.txt]* seiga.pdf
```

プロキシを設定してアクセス(.wgetrcが使えない場合や都度設定したいとき)
```sh
wget -e HTTP_PROXY=proxy.co.jp:8080 'http://www.google.co.jp/'
```

Refererの設定
```sh
wget "http://example.com/" --referer="http://example.com/example.html"
```

あぷろだなどから、アップロードされた時のファイル名で、さらに日本語ファイル名のまま文字化けしないように/opt/zips/にダウンロードする場合
```sh
wget --restrict-file-names=nocontrol \
     --content-disposition \
     --user-agent="Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:52.0) Gecko/20100101 Firefox/52.0" \
     "http://axfc.uploader.local/file=テストファイル.zip" \
     -P /opt/zips/
```

オプションまとめ

```sh
-o ログファイル指定
-w ウェイト
-N タイムスタンプ保持
-x ドメインとかパスを保持
-r 再帰
-l inf 再帰の深さを無限にする
-P /path/to/ ファイルのダウンロードパス
--no-proxy プロキシを通さずにアクセス
--tries=4 リトライ回数の上限を指定 (0 は無制限).
--retry-connrefused 接続を拒否されてもリトライする
--no-clobber 存在しているファイルをダウンロードで上書きしない
--continue 部分的にダウンロードしたファイルの続きから始める
--http-user="userName" ベーシック認証のユーザ名
--http-passwd="password" ベーシック認証のパスワード
--restrict-file-names=modes ファイル名の制御：modeで規定
--restrict-file-names=nocontrol マルチバイト文字のファイル名をダウンロードする場合の文字化け防止
--content-disposition content-dispositionに記載されているファイル名でダウンロードする
--server-response サーバの応答を表示する
--spider 何もダウンロードしない
--timeout=SECONDS 全てのタイムアウトを SECONDS 秒に設定する
--dns-timeout=SECS DNS 問い合わせのタイムアウトを SECS 秒に設定する
--connect-timeout=SECS 接続タイムアウトを SECS 秒に設定する
--read-timeout=SECS 読み込みタイムアウトを SECS 秒に設定する
--wait=SECONDS ダウンロード毎に SECONDS 秒待つ
--waitretry=SECONDS リトライ毎に 1?SECONDS 秒待つ
--random-wait ダウンロード毎に 0?2*WAIT 秒待つ
--quota=NUMBER ダウンロードするバイト数の上限を指定する
--bind-address=ADDRESS ローカルアドレスとして ADDRESS (ホスト名か IP) を使う
--limit-rate=RATE ダウンロード速度を RATE に制限する
--no-dns-cache DNS の問い合わせ結果をキャッシュしない
--restrict-file-names=OS OS が許しているファイル名に制限する
--ignore-case ファイル名/ディレクトリ名の比較で大文字小文字を無視する
--inet4-only IPv4 だけを使う
--inet6-only IPv6 だけを使う
--prefer-family=FAMILY 指定したファミリ(IPv6, IPv4, none)で最初に接続する
--user=USER ftp, http のユーザ名を指定する
--password=PASS ftp, http のパスワードを指定する
--ask-password パスワードを別途入力する
--no-iri IRI サポートを使わない
--local-encoding=ENC 指定した ENC を IRI のローカルエンコーディングにする
--remote-encoding=ENC 指定した ENC をデフォルトのリモートエンコーディングにする
--no-http-keep-alive HTTP の keep-alive (持続的接続) 機能を使わない
--no-cookies クッキーを使わない
--load-cookies=FILE クッキーを FILE から読みこむ
--save-cookies=FILE クッキーを FILE に保存する
--keep-session-cookies セッションだけで用いるクッキーを保持する
--auth-no-challenge サーバからのチャレンジを待たずに、Basic認証の情報を送信します。
--user-agent="Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:52.0) Gecko/20100101 Firefox/52.0" ユーザーエージェントの偽装
--referer="http://example.com/" リファラの偽装
--header="Host: example.com" ヘッダーの付与
--post-data="userid=hoge&password=hogehoge" POST送信
--post-file="/path/to/file" POSTでファイル送信
--secure-protocol=PR セキュアプロトコルを選択する (auto, SSLv2, SSLv3, TLSv1)
--no-check-certificate サーバSSL証明書を検証しない
--certificate=FILE クライアント証明書として FILE を使う
--certificate-type=TYPE クライアント証明書の種類を TYPE (PEM, DER) に設定する
--private-key=FILE 秘密鍵として FILE を使う
--private-key-type=TYPE 秘密鍵の種類を TYPE (PEM, DER) に設定する
--ca-certificate=FILE CA 証明書として FILE を使う
--ca-directory=DIR CA のハッシュリストが保持されているディレクトリを指定する
--random-file=FILE  SSL PRNG の初期化データに使うファイルを指定する
--egd-file=FILE  EGD ソケットとして FILE を使う
--recursive 再帰ダウンロードを行う
--level=NUMBER 再帰時の階層の最大の深さを NUMBER に設定する (0 で無制限)
--delete-after ダウンロード終了後、ダウンロードしたファイルを削除する
--convert-links HTML や CSS 中のリンクをローカルを指すように変更する
--backup-converted リンク変換前のファイルを .orig として保存する
--mirror "-N -r -l 0 --no-remove-listing" の省略形
--page-requisites HTML を表示するのに必要な全ての画像等も取得する
--strict-comments HTML 中のコメントの処理を厳密にする
--accept=LIST ダウンロードする拡張子をコンマ区切りで指定する
--reject=LIST ダウンロードしない拡張子をコンマ区切りで指定する
--domains=LIST ダウンロードするドメインをコンマ区切りで指定する
--exclude-domains=LIST ダウンロードしないドメインをコンマ区切りで指定する
--follow-ftp HTML 文書中の FTP リンクも取得対象にする
--follow-tags=LIST 取得対象にするタグ名をコンマ区切りで指定する
--ignore-tags=LIST 取得対象にしないタグ名をコンマ区切りで指定する
--span-hosts 再帰中に別のホストもダウンロード対象にする
--relative 相対リンクだけ取得対象にする
--include-directories=LIST 取得対象にするディレクトリを指定する
--trust-server-names use the name specified by the redirection url last component.
--exclude-directories=LIST 取得対象にしないディレクトリを指定する
--no-parent 親ディレクトリを取得対象にしない
--ftp-user=USER ftp ユーザとして USER を使う
--ftp-password=PASS ftp パスワードとして PASS を使う
--no-remove-listing  `.listing' ファイルを削除しない
--no-glob FTP ファイル名のグロブを無効にする
--no-passive-ftp "passive" 転送モードを使わない
--retr-symlinks 再帰取得中に、シンボリックリンクでリンクされた先のファイルを取得する
```

원본 : [wgetでこういう時はこうする!!](https://qiita.com/hirohiro77/items/b774908436ec032df719)
