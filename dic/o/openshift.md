# OpenShift

OpenShift とは、Red Hat社が提供しているエンタープライズ対応のKubernetesコンテナプラットフォームで、Docker、Kubernetes、Dockerレジストリなどで構成されるCaaS(Container as a Service)基盤です。CaaSとはPaaS(Platform as a Service)の中でも、特にコンテナサービスに重点を置いたサービスを意味します。
OpenShiftを利用することで、短時間で簡単にアプリケーションを構築、開発、提供することができます。

## Products

### OKD
OSS版で、無償で利用できます。OpenShiftをローカル環境で試すためのMinishiftというツールも提供されており、小規模での利用に向いています。
OpenShift Originのバージョン3.10リリース時（2018/08/03）に、OKD (The Community Distribution of Kubernetes that powers Red Hat's OpenShift)に名称を変更しました。
### OpenShift Container Platform、OpenShift Kubernetes Engine
社内のデータセンターなどにCaaSを構築するための製品であり、エンタープライズレベルのKubernetesをデプロイするためのパッケージです。また、Red Hat社がサポートを提供しています。
### OpenShift Dedicated
Red Hat社の提供するパブリッククラウド上に、一社向けにCaaSを提供する製品であり、Red Hat社がサポートを提供しています。ネットワーク接続の安全性を担保しつつ、AWSやGCPと容易に連携させることができるのが特徴です。
### Amazon Red Hat OpenShift、OpenShift Microsoft Azure、Red Hat OpenShift on IBM Cloud
Red Hat社とAWS社・Microsoft社・IBM社が共同で開発、運用、サポート提供しているOpenShiftの高可用性クラスタで、各社のクラウド上にホスティングされるフルマネージドサービス製品です。
### OpenShift Online
Red Hat社の提供するパブリックCaaSを利用することができ、Red Hat社がサポートを提供しています。

### Azure Red Hat OpenShift
Microsoft社と Red Hat社が共同開発したOpenShiftサービスです。

## 特徴

OpenShiftはDevOpsの促進を目的として開発されたため、OpenShiftの利用は開発者と運用者の両方にとってメリットがあります。
開発者は、ローカルに開発環境をセットアップする必要がなくなり、クラウド環境または社内のデータセンターに素早く、容易に開発環境をセットアップすることができるようになります。また、CI/CDパイプラインの作成、開発したアプリケーションの自動テスト、アプリケーションのdocker imageとしてのデプロイ、および監視もサポートされるため、その後の運用も容易になります。

OpenShiftはMasterとNodeという2つのホストで構成されます。Masterは複数のNodeを管理するホストで、ユーザの認証、アプリケーションの管理、ノード間の通信などを行います。また、Nodeはユーザアプリケーションを実行するホストで複数のコンテナから成り立っています。

![image](https://github.com/LowyShin/KnowledgeBase/assets/20239203/d62e1aaa-cccf-40c1-ba74-22d1275d22dc)


## サポートイメージ

OpenShift Container Platformは60種類近くのイメージをサポートしています。
Jenkins、Httpd、node、Elasticsearch、Ruby、PHP、Perl、Python、.NET、MySQL、MariaDB、MongoDBなど主要なコンテンツにはほとんど対応しています。より詳細な内容については以下のURLを参考にしてください。

https://access.redhat.com/articles/2176281

## 機能

OpenShiftではKubernetesで実装されている機能が利用できることに加えて独自のコンポーネントを備えています。

- Integrated Docker Registry
OpenShiftではDocker imageを内部で保持します。そのためのリポジトリがIntegrated Docker Registryです。

- Software Defined Network
この機能を用いることで、サーバをまたいだコンテナ間の通信を一つのオーバレイネットワーク上で利用するシングルテナントか、プロジェクトごとにオーバレイネットワークを分けるマルチテナントで構成することできます。

- Build Configuration
Docker imageを作成するための設定です。

- Deployment Configuration
Kubernetesを拡張したコンテナ型アプリケーションのデプロイするための設定です。

- Source to Image
既に存在するコンテナイメージに別のソースコードからビルドしたアプリケーションをデプロイし、新しいDocker imageを作成します。

- Image Stream
OpenShiftがビルドしたDocker image、外部のDocker imageへのポインターを保持します。

- Route
OpenShift上で動作しているアプリケーションをURLでアクセスできるようにします。

