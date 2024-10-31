

* [iPhone モデル別解像度](https://qiita.com/tomohisaota/items/f8857d01f328e34fb551)


### DevTools

- SQL Server Mobile Client(Filippo Maguolo)
  - 比較的にツールがよく作られてる。
  - 無料の状態でもかなり使える（SPの修正・実行したクエリの保存など）
  - 日付フィールドがシステムデータを読み込むのではなく現地のデータに勝手に変更されて表示される。
      - DBにgetdate()で入れたのにselectしてみるとJST時間が表示される。しかしSSMSから確認するとUTCになっている。（そもそもAzure SQLはUTCしかサポートしてない）
  - https://apps.apple.com/jp/app/sql-server-mobile-client/id1406176302


