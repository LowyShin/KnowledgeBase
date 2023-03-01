## Introduce

AzureはMSで作ったサービスなのでExcelから管理しやすくなっているのが長所でAzureのデータストアに入れたままExcelに表示したり、Azureの設定などをJSONに吐き出してExcelに取り込んなりするといちいち管理台帳を手動で作らなくても管理がしやすいです。

そしてazコマンドがPowershellで使えるのでインフラ管理をPowershellを利用して自動化するのが便利です。

さらにTerraformなどの外部ツールを利用すると一括管理・適用ができて大規模インフラの統合管理及び操作履歴管理など体系的に管理ができます。

App Serviceなどを利用するとサーバーレスで今までのサーバーの管理手間が省いてさらにスケーラブルなインフラ管理が自動で管理できます。App Serviceはnodejs、PHP、.Netなど様々は開発環境を提供するためOS上に環境をインストールする必要がなく冗長構成も要りません。

Windows VMを使うときはWindowsライセンスが無料なのでAWSより安く使えます。

SQL Serverの場合もAWSより安いサーバーレスモデルを提供するので2千円からライセンス込みで利用することができます。

簡単な設定でLinuxとWindowsのシステムからシステムログなどが収集できてLog Analyticsから統合して確認することができるので時系列の異常分析にも役に立ちます。

さらにDBMS分析ツールの[Ezis](https://github.com/LowyShin/ezis-jp)を利用するとより詳しくパフォーマンス分析ができます。

azureにはトポロジー機能があって今までネットワーク構成図を手動で描いてたらこれからはトポロジーをスクショを撮るだけで最新のネットワーク構成図の管理ができちゃいます。

AzureのSQL DatabaseにはAuto Tuning機能が付いていてオンにするだけでDBMS専門家が要らない程のリアルタイムチューニングを行います。SQLのパターンを分析してパフォーマンスに応じてインデクスを作成または削除しながらパフォーマンスを保ってくれます。

## Use more powerful

* [Powershell for azure](https://github.com/LowyShin/KnowledgeBase/blob/master/wiki/ps1/ps-azure.md)
    * Azure login using az command
    * change subscription or component control

## Deployment

* Simple management source and service by Github + Azure App Service
  * Korean : https://talklowykr.blogspot.com/2020/03/azure-github.html

* Python Web App
  * https://docs.microsoft.com/ko-kr/azure/app-service/containers/quickstart-python?tabs=bash

* Django Web App
  * https://docs.microsoft.com/ko-kr/azure/app-service/containers/tutorial-python-postgresql-app

## Performance

* [仮想マシンとディスクのパフォーマンス(ディスクタイプ別パフォーマンス)](https://learn.microsoft.com/ja-jp/azure/virtual-machines/disks-performance)

## Log Analysis

- [Useful query for log analytics](https://github.com/LowyShin/KnowledgeBase/blob/master/wiki/azure/logquery.md)

- [Azure Monitor Log Alert V2(➽)](https://cloudadministrator.net/2021/11/04/azure-monitor-log-alert-v2/)

* [Azure LogAnalyticsワークスペースへのApacheログの取り込み(➽)](https://cloud.ebisuda.com/2021/07/05/azure-loganalytics%E3%83%AF%E3%83%BC%E3%82%AF%E3%82%B9%E3%83%9A%E3%83%BC%E3%82%B9%E3%81%B8%E3%81%AEapache%E3%83%AD%E3%82%B0%E3%81%AE%E5%8F%96%E3%82%8A%E8%BE%BC%E3%81%BF/)

* [App Serviceからのログ取り込み(➽)](https://cloud.ebisuda.com/2021/07/11/app-service%E3%81%8B%E3%82%89%E3%81%AE%E3%83%AD%E3%82%B0%E5%8F%96%E3%82%8A%E8%BE%BC%E3%81%BF/)

* [Log Query(➽Official)](https://docs.microsoft.com/en-us/azure/azure-monitor/logs/query-optimization#use-effective-aggregation-commands-and-dimensions-in-summarize-and-join)

## Basic Functions

### Networking

- [【Azure】App ServiceのVNet統合とプライベートリンクを利用した通信閉域化](https://techblog.ap-com.co.jp/entry/2021/03/12/150117)

## Azure AD(Active Directory)

* [Azure portal を使用して Azure ロールを割り当てる](https://docs.microsoft.com/ja-jp/azure/role-based-access-control/role-assignments-portal?tabs=current)

## Trouble Shooting

* [Azure VM 上でローカルの Linux パスワードをリセットする方法](https://docs.microsoft.com/ja-jp/troubleshoot/azure/virtual-machines/reset-password)

## Pricing

* Azure pricing calculator
  * https://azure.microsoft.com/pricing/calculator/
* App Service Pricing
  * https://azure.microsoft.com/pricing/details/app-service/windows/
* [自動化を使用したコストの管理](https://learn.microsoft.com/ja-jp/azure/cost-management-billing/costs/manage-automation?source=recommendations)

## Azure Database

* [MariaDB Enterprise Cluster® on Azure](https://azure.microsoft.com/ja-jp/blog/mariadb-enterprise-cluster-on-azure/)
* [Azure Database for MySQL - フレキシブル サーバー](https://docs.microsoft.com/ja-jp/azure/mysql/flexible-server/overview)
  * 10台の読み取りレプリカが自動スケール(Auto scale)されるサービス
* [リストア時の「Access denied; you need (at least one of) the SUPER privilege(s) for this operation」エラー](https://next4us-ti.hatenablog.com/entry/2019/03/30/100627)
* [[MySQL] ERROR 1227 (42000) at line 18: Access denied; you need (at least one of) the SUPER privilege(s) for this operation](https://qiita.com/jesus_isao/items/16da16885e0c3a2aec4c)

* [Running an optimized MariaDB (MySQL) cluster on Azure](https://sabbour.me/running-a-mariadb-cluster-on-azure/)

## Integration

- [Export CSV by Powershell](https://www.sanganakauthority.com/2015/05/export-to-excel-microsoft-azure-vm-list.html)

## Connection

### Azure Bastion

* [Azure Bastion とは(Azure official)](https://docs.microsoft.com/ja-jp/azure/bastion/bastion-overview)
![bastion](https://docs.microsoft.com/ja-jp/azure/bastion/media/bastion-overview/architecture.png)


## Azure Cli

* [Official Reference](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/guides/service_principal_client_secret)
* login
```
az login
```
* set subscription
```
az account set --subscription="SUBSCRIPTION_ID"
```
* get signed id information
```az
az ad signed-in-user show
```

- [ブラウザ認証をスキップし、CLIでAzureにログインする方法](https://tech-blog.cloud-config.jp/2022-09-16-auto-azure-login-for-cli/)

## Documentation

- 各画面でJSON表示ができてそのJSONをファイルに落としてからExcelから読み取ってテーブル変換などの工夫によってそのまま使えるテーブルが作成できる。


## Microsoft Ignite

- [Microsoft Ignite 質問応答のエクスポート/インポート/更新](https://learn.microsoft.com/ja-jp/azure/cognitive-services/language-service/question-answering/how-to/export-import-refresh)
- [Microsoft Excel にインポートされた Azure Data Explorer Kusto クエリを使用してデータを視覚化する](https://learn.microsoft.com/ja-jp/azure/data-explorer/excel-blank-query)

### Azure DevOps

- [Azure DevOpsを触ってみた](https://www.qes.co.jp/media/Microservices/a104)

### Load Balancing and CDN

- [Quickstart: Integrate an Azure Storage account with Azure CDN(official)](https://learn.microsoft.com/en-us/azure/cdn/cdn-create-a-storage-account-with-cdn)
- [Azure CDN 製品の機能比較](https://learn.microsoft.com/ja-jp/azure/cdn/cdn-features?WT.mc_id=Portal-Microsoft_Azure_Cdn)

- [Azure Front Door と Azure Application Gateway の違いは何ですか?](https://learn.microsoft.com/ja-jp/azure/frontdoor/standard-premium/faq)

## Links

- [Terrafomr for Azure](https://github.com/LowyShin/KnowledgeBase/blob/master/wiki/terraform/tfazure.md)



