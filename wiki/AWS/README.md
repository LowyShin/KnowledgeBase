
## NetworkService

### PrivateLink

* [AWS PrivateLink の説明(megaport)](https://www.megaport.com/ja/blog/aws-privatelink-explained/)
* [Securely Access Services Over AWS PrivateLink(PDF)](https://d1.awsstatic.com/whitepapers/aws-privatelink.pdf)
* [PrivateLinkの特徴](https://dev.classmethod.jp/articles/usecases-about-privatelink-vpc-endpoint/)
* [拠点間（リージョン間）及びアカウント間Privatelink接続可能](https://toshioshimo.hatenablog.com/entry/2019/12/17/215004)

### Database

* Oracle11g를 19c로 바꾸면 접속용 클라이언트들도 신경써야 하는데, 최신 jdbc등이 지원 안되는 환경이라면 
  `SQLNET.ALLOWED_LOGON_VERSION_SERVER=11`
  등으로 클라이언트 접속을 강제로 11로 낮추면 jdbc6 같은 낮은 버전의 드라이버에서도 접속 가능하다. 
  * https://docs.oracle.com/cd/F19136_01/spuss/checking-for-accounts-using-case-insensitive-password.html#GUID-ABD2D296-EFB9-49CA-94C5-FB1068AF19DE

## Links

* [find available zone](https://aws.amazon.com/premiumsupport/knowledge-center/vpc-find-availability-zone-options/)

* [AWS - AWS VPC와 Onpremise VPN 연결(Untangle IPsec)](https://galid1.tistory.com/431)

* https://talklowykr.blogspot.com/2020/09/aws.html

* [aws mysql connection spec](https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/AuroraMySQL.Managing.Performance.html)

* MySQL AWS는 5.6부터 지원
  * 버전업이 필요한 서버 리스트
  * smartpdb slave에서 xtrabackup 해볼 것. 

* [aws aurora benchmark](https://aws-ref.s3.amazonaws.com/aurora/Amazon+Aurora.pdf)

* ELB limit : https://docs.aws.amazon.com/ja_jp/elasticloadbalancing/latest/application/load-balancer-limits.html
