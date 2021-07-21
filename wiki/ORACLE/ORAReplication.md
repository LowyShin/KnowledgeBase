

* [Oracle Replication Products](https://cosol.jp/techdb/2020/05/oracle-replication-methods-support-status/)

* [Data Guard replication setting](https://udonsoba.hatenablog.com/entry/2016/06/28/172736)

* [4種類のRMAN DUPLICATEでそれぞれ実際にデータベースをコピーする](https://qiita.com/tlokweng/items/a041394e1011434eca06)
* [Duplicate from Active database](https://qiita.com/plusultra/items/51f661836828b3765d4b)

* [DataGuard構築後に使うSQLコマンドまとめ（逆引き）](https://www.ashisuto.co.jp/db_blog/article/20160831_dataguard_sql.html)

* [Dataguard status](https://dbtut.com/index.php/2020/01/30/how-to-check-data-guard-status/)
  ```sql
  -- from slave database
  https://dbtut.com/index.php/2020/01/30/how-to-check-data-guard-status/
  ```

* [Dataguard sql reference](https://www.ashisuto.co.jp/db_blog/article/20160831_dataguard_sql.html)
  ```sql
  -- check master setting
  SELECT DEST_NAME,RECOVERY_MODE FROM V$ARCHIVE_DEST_STATUS WHERE TYPE = 'PHYSICAL';
  -- check slave setting
  SELECT PROCESS,STATUS FROM V$MANAGED_STANDBY WHERE PROCESS LIKE 'MRP%';
  ```
