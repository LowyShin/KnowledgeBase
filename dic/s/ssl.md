# SSL

## Free SSL

SSL자체에 비용을 내는 것은 불합리하다는 운동이 퍼짐에 따라 무료 SSL을 제공하는 서비스가 늘고 있습니다. 
그 중에서도 여러가지 편의 툴을 제공하여 스크립팅이 가능하게 해주는 CertBot이란 서비스가 있습니다.

- 공식 : https://certbot.eff.org/

install certbot
```sh
dnf install https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm  
dnf config-manager --set-enabled PowerTools
# -- no match

# select by environment
# for apache
dnf install certbot python3-certbot-apache
# for nginx
dnf install certbot python3-certbot-nginx
# for windows
winget install certbot
```

SSL발행
```sh
certbot certonly --manual -d *.littleworld.net --key-type rsa --agree-tos --manual-public-ip-logging-ok
```
명령을 실행하면 email 요청함. 이메일 입력하면 . 
```
ould you be willing, once your first certificate is successfully issued, to
share your email address with the Electronic Frontier Foundation, a founding
partner of the Let's Encrypt project and the non-profit organization that
develops Certbot? We'd like to send you email about our work encrypting the web,
EFF news, campaigns, and ways to support digital freedom.
```
라고 표시되는데 Y를 눌러 이메일 등록. 

```
Please deploy a DNS TXT record under the name:

_acme-challenge.littleworld.net.

with the following value:

cJVlZDstMqheupXCSRfKrj0FCmQ8g7UKOZsN2uLUGPs

Before continuing, verify the TXT record has been deployed. Depending on the DNS
provider, this may take some time, from a few seconds to multiple minutes. You can
check if it has finished deploying with aid of online tools, such as the Google
Admin Toolbox: https://toolbox.googleapps.com/apps/dig/#TXT/_acme-challenge.littleworld.net.
Look for one or more bolded line(s) below the line ';ANSWER'. It should show the
value(s) you've just added.
```
라고 DNS레코드 등록하여 오너 인증을 해야 함. 

DNS에서 Txt레코드를 등록
DNS인증이 완료되면 
```
uccessfully received certificate.
Certificate is saved at: /etc/letsencrypt/live/littleworld.net/fullchain.pem
Key is saved at:         /etc/letsencrypt/live/littleworld.net/privkey.pem
This certificate expires on 2023-09-25.
These files will be updated when the certificate renews.

NEXT STEPS:
- This certificate will not be renewed automatically. Autorenewal of --manual certificates requires the use of an authentication hook script (--manual-auth-hook) but one was not provided. To renew this certificate, repeat this same certbot command before the certificate's expiry date.

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
If you like Certbot, please consider supporting our work by:
 * Donating to ISRG / Let's Encrypt:   https://letsencrypt.org/donate
 * Donating to EFF:                    https://eff.org/donate-le
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
```
라고 표시되면서 종료되면 완료. 

`/etc/letsencrypt/archive/`에 파일들이 정상적으로 들어있는지 확인후 문제 없으면 필요한 파일로 변형하여 저장. 
pem밖에 없으므로 pfx나 다른 파일로는 openssl등의 툴로 변환을 해야 함.

Azure Application Gateway등에 넣을 pfx 포맷으로 변경(openssl 설치 필요)
```sh
openssl pkcs12 -inkey privkey1.pem -in cert1.pem -export -out fullchain.pfx
```

https://github.com/LowyShin/KnowledgeBase/blob/master/dic/o/openssl.md

### 참고

- windows의 경우 certbot 명령을 쉽게 해주는 batch를 만들 수 있습니다. 보통 C:\Program Files\Certbot\bin 에 실행프로그램이 있으므로 환경변수의 PATH에 추가를 해야 합니다.
- certexec.bat
```bat
@ECHO off
REM certbot wrapper
REM sslcert musubi.green [test]
REM  test를 지정하면 --dry-run (시뮬레이션)을 붙여 실행합니다.
SETLOCAL
if "%~1"=="" (
  ECHO put into domain for SSL
  GOTO END
)

if "%~2"=="test" (
  SET DRYRUN=--dry-run
) else (
  SET DRYRUN=
)

certbot certonly --manual -d %~1 --key-type rsa --agree-tos --manual-public-ip-logging-ok --manual-auth-hook certbot-preauth.cmd --manual-cleanup-hook certbot-postauth.cmd %DRYRUN%

:END
ENDLOCAL
PAUSE
```
- 윈도우즈 환경에서는 여러가지 어려운 점들이 있어 linux vm을 열고 작업하는 것을 추천...


