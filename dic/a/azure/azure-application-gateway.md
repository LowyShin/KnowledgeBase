# Azure Application Gateway

Azure application gatewayはサーバの前に置く負荷分散及びセキュリティなどの役割を担当する機能の一つです。
AzureからのLoad balancingサービスはFront Door(CDN), Load Balancer(Classic L4), Traffic Manager(GLB/GSLB)などがありますが、詳しい内容は他のページに載せます。

Application gatewayの特徴はL7レイヤの負荷分散が可能（HTTP Header毎に分散ができる）なことと、SSLをAGW（Application GateWay）に置くことで内部にはhttpだけの通信ができたり、SSLを各サーバに置いて毎回更新するのなどの面倒な作業が省かれるのでよく使います。

agw + vmss(Virtual Machine Scale Set)を利用するとより冗長を強力な環境構築ができます。

agwはWAFが基本搭載されるためセキュリティも充実しているためできるだけagwを前に置くのをお勧めします。

## Firewall

- [Azure Application GatewayでGeoフィルタリングを行う。](https://level69.net/archives/29838)

## Multi Domain on Single application gateway

### 환경

- 개발 서버 : dev.giip.net, devsvr.giip.net, devvm.giip.net (ws, was의 리스너용 및 실vm용 도메인 총 3 개를 준비해야 함.)
  - 4000포트에 ws기동. 프론트 웹 서버
  - 3000포트에 was기동. 백엔드 어플리케이션 서버
- 스테이징 서버 : stg.giip.net, stgvm.giip.net
  - 4000포트에 ws기동, prod환경의 was에 접속해서 최종 테스트
- 서비스 서버 : prod.giip.net, prodsvr.giip.net, prodvm.giip.net (ws, was의 리스너용 및 실vm용 도메인 총 3 개를 준비해야 함.)
  - 4000포트에 ws기동
  - 3000포트에 was기동

### 설정

1. Add backend pool
   - dev-be4000 : 개발 서버의 4000포트(WS)
     - FQDN : devvm.giip.net
   - dev-be3000 : 개발 서버의 3000포트(WAS)
     - FQDN : devvm.giip.net
   - stg-be4000 : 스테이징 서버의 4000포트(WS)
     - FQDN : stgvm.giip.net
   - prod-be4000 : 서비스용 4000포트(WS)
     - FQDN : prodvm.giip.net
   - prod-be3000 : 서비스용 3000포트(WAS)
     - FQDN : prodvm.giip.net

2. Add backedn configuration
   - ws-4000 : WS용 설정
     - Protocol : HTTP (내부적으로는 http통신으로 하기 때문)
     - Port : 4000
   - was-3000 : WAS용 설정
     - Protocol : HTTP (내부적으로는 http통신으로 하기 때문)
     - Port : 3000

3. Add listener
   - devws-lsnr443
     - Protocol : HTTPS
     - Port : 443
     - SSL : pkx파일 업로드
     - Listner 종류 : multi site
     - host 종류 : 복수 또는 와일드카드
       - dev.giip.net (이 도메인으로 접속하면 이 설정을 탐)
   - devwas-lsnr443
     - Protocol : HTTPS
     - Port : 443
     - SSL : pkx파일 업로드
     - Listner 종류 : multi site
     - host 종류 : 복수 또는 와일드카드
       - devsvr.giip.net(이 도메인으로 접속하면 이 설정을 탐)
   - stgws-lsnr443
   - prodws-lsnr443
   - prodwas-lsnr443

4. Add rule
   - devws-rr443
     - listener : devws-lsnr443
     - backend target : dev-be4000 (개발환경 도메인 연결)
     - backend configuration : ws-4000 (4000포트 설정 가져옴)
   - devwas-rr443
     - listener : devwas-lsnr443
     - backend target : dev-be3000 (개발환경 WAS 도메인 연결)
     - backend configuration : ws-3000 (3000포트 설정 가져옴)
   - stgws-rr443
   - prodws-rr443
   - prodwas-rr443

이런식으로 설정하면 하나의 agw로 여러 도메인 및 서버를 교통정리할 수 있음!
