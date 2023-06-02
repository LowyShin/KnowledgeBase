# Azure Application Gateway

Azure application gatewayはサーバの前に置く負荷分散及びセキュリティなどの役割を担当する機能の一つです。
AzureからのLoad balancingサービスはFront Door(CDN), Load Balancer(Classic L4), Traffic Manager(GLB/GSLB)などがありますが、詳しい内容は他のページに載せます。

Application gatewayの特徴はL7レイヤの負荷分散が可能（HTTP Header毎に分散ができる）なことと、SSLをAGW（Application GateWay）に置くことで内部にはhttpだけの通信ができたり、SSLを各サーバに置いて毎回更新するのなどの面倒な作業が省かれるのでよく使います。

agw + vmss(Virtual Machine Scale Set)を利用するとより冗長を強力な環境構築ができます。

agwはWAFが基本搭載されるためセキュリティも充実しているためできるだけagwを前に置くのをお勧めします。

## Firewall

- [Azure Application GatewayでGeoフィルタリングを行う。](https://level69.net/archives/29838)
