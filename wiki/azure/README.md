
## [Powershell for azure](https://github.com/LowyShin/KnowledgeBase/blob/master/wiki/ps1/ps-azure.md)

## Deployment

* Simple management source and service by Github + Azure App Service
  * Korean : https://talklowykr.blogspot.com/2020/03/azure-github.html

* Python Web App
  * https://docs.microsoft.com/ko-kr/azure/app-service/containers/quickstart-python?tabs=bash

* Django Web App
  * https://docs.microsoft.com/ko-kr/azure/app-service/containers/tutorial-python-postgresql-app

## Log Analysis

* [Azure LogAnalyticsワークスペースへのApacheログの取り込み](https://cloud.ebisuda.com/2021/07/05/azure-loganalytics%E3%83%AF%E3%83%BC%E3%82%AF%E3%82%B9%E3%83%9A%E3%83%BC%E3%82%B9%E3%81%B8%E3%81%AEapache%E3%83%AD%E3%82%B0%E3%81%AE%E5%8F%96%E3%82%8A%E8%BE%BC%E3%81%BF/)

* [App Serviceからのログ取り込み](https://cloud.ebisuda.com/2021/07/11/app-service%E3%81%8B%E3%82%89%E3%81%AE%E3%83%AD%E3%82%B0%E5%8F%96%E3%82%8A%E8%BE%BC%E3%81%BF/)

* [Log Query](https://docs.microsoft.com/en-us/azure/azure-monitor/logs/query-optimization#use-effective-aggregation-commands-and-dimensions-in-summarize-and-join)

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

## Documentation

- 各画面でJSON表示ができてそのJSONをファイルに落としてからExcelから読み取ってテーブル変換などの工夫によってそのまま使えるテーブルが作成できる。


## Microsoft Ignite

- [Microsoft Ignite 質問応答のエクスポート/インポート/更新](https://learn.microsoft.com/ja-jp/azure/cognitive-services/language-service/question-answering/how-to/export-import-refresh)
- [Microsoft Excel にインポートされた Azure Data Explorer Kusto クエリを使用してデータを視覚化する](https://learn.microsoft.com/ja-jp/azure/data-explorer/excel-blank-query)
