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