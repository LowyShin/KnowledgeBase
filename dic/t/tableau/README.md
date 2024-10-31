## Introduction

Tableau(タブロー)とは異なるデータを読込BIのビジュアルみたいな表示が簡単にできるツールです。デスクトップバージョンと共同作業が可能なサーバーバージョンがあって現在一番使いやすいBIツールなどに分類されています。

## Official Help

### DesktopとServerのバージョン違いの場合

* 任意のバージョンの Tableau Desktop で作成されたワークブックは、サポートされている任意のバージョンの Tableau Server に接続できます。ただし、接続すると、実行するアクションによっては、使用しているバージョンによって互換性が問題となる場合があります。
  * https://help.tableau.com/current/desktopdeploy/ja-jp/desktop_deploy_compatibility.htm



### Local Network

* Tableau Desktop や Tableau Prep Builder は、インターネットにアクセスして操作するよう設計されました。たとえば、Tableau では、マップ ビューの読み込みやダッシュボードの Web ページの読み込み、およびライセンス リクエストの要求を処理するため、インターネット アクセスが必要です。
  * https://help.tableau.com/current/desktopdeploy/ja-jp/desktop_deploy_proxy.htm

* ネットワーク構成などの公式参考
  * https://help.tableau.com/current/server/ja-jp/license_lblm.htm
  *  Tableau Server または Tableau Online は Tableau でホストされる実行承認 (ATR) サービスに連絡して Tableau Desktop クライアントがアクティブ化を許可されていることを確認します。
![Local install](https://help.tableau.com/current/server/ja-jp/Img/virtual_desktop_server_lblm.png)

* [Tableau サービス マネージャーのポート](https://help.tableau.com/current/server/ja-jp/ports.htm)

### Contents Permission Management

* [コンテンツ プロジェクト、グループ、パーミッションの構造作成](https://help.tableau.com/current/guides/everybody-install/ja-jp/everybody_admin_permissions.htm)
  * Groups (グループ) — コンテンツに対して同一タイプのアクセスが必要なユーザーのセット。
  * Projects (プロジェクト) — ワークブックやデータ ソースのコンテナ。一般に、各々がコンテンツのカテゴリを指す。
  * Permissions (パーミッション) — 誰がどのコンテンツを操作できるかを定義する権限のセット。
  * ユーザーをグループに整理することを強くお勧めします。
  * グループを作成してユーザーを参加させサブプロジェクト毎に権限を付与するマニュアル。
* [プロジェクトを使用したコンテンツへのアクセスの管理](https://help.tableau.com/current/server/ja-jp/projects.htm)
* [Tableauで閲覧ユーザごとに権限管理](https://blog.truestar.co.jp/tableau/20180503/1507/)
* [ Excel等のユーザリストを用いたユーザーフィルタ](https://newssdx.kcme.jp/tableautips-userfilter-security/)
  * お勧め：グループを作成してユーザーを入れる⇒グループごとにサブプロジェクトを割り当てる
  * Excelで権限の統合管理可能。

### Performance

* [Tableau Server へのアップロード時間の減少](https://help.tableau.com/current/pro/desktop/ja-jp/perf_reduce_upload_times.htm)
  * ワークブック (.twb ファイル) とデータ ソースを一緒にパッケージドワークブック (.twbx ファイル) としてパブリッシュするのではなく、別々にパブリッシュするのがベスト プラクティスです。
* [データの更新または自動更新の一時停止](https://help.tableau.com/current/pro/desktop/ja-jp/refresh.htm)
* [Tableau Server または Tableau Online へのフローのパブリッシュ](https://help.tableau.com/current/prep/ja-jp/prep_conductor_publish_flow.htm)
  * Tableau Prep conductorなどを利用してデータ自動アップロードのフローを作成・管理可能

### Tableau Prep Conductor

* [Tableau Prep Conductor](https://help.tableau.com/current/server/ja-jp/prep_publishserver_overview.htm)
  * ableau Prep Conductor を使用すると、Tableau Server で利用可能なスケジュール調整機能および追跡機能を活用して、フローを自動的に実行してフロー出力を更新できます。
  * Tableau Prep Conductor は、Tableau Server バージョン 2019.1 で導入された Tableau Data Management Add-on の一部であり、フローの実行をスケジュールするために有効にする必要があります。
  * 注: バージョン 2020.4 以降では、スケジュールに従ってフローを実行する場合にのみ Data Management アドオン が必要になります。フローをパブリッシュして、Web 上で手動で実行したり、Creator としてサーバー上で直接フローを作成および編集したりする場合、Data Management アドオン は不要になりました。
  * Tableau Prep Builder で作成されたフローは、その実行をスケジュールする前に Tableau Server にパブリッシュする必要があります。
