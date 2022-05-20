## Official Help

### Local Network

* Internet연결 안하면 ATR서버에 접속 안됨.

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
