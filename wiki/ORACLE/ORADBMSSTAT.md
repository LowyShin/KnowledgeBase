## DBMS_STATS

```sql
--DBMS_STATSによる統計情報の取得
--表のみ
exec DBMS_STATS.GATHER_TABLE_STATS(ownname=>'TEST',tabname=>'TAB1',cascade=>false);

--表+インデックス(cascadeオプションを省略した場合、9iはインデックスは取得しないが10g以降はORACLEが判断する)
exec DBMS_STATS.GATHER_TABLE_STATS(ownname=>'TEST',tabname=>'TAB1',cascade=>true);

--インデックス
exec DBMS_STATS.GATHER_INDEX_STATS(ownname=>'TEST',indname=>'I_TAB1');

--表+インデックス+列統計(ヒストグラムのサイズは自動判断)
exec DBMS_STATS.GATHER_TABLE_STATS(ownname=>'TEST',tabname=>'TAB1',cascade=>true,method_opt=>'FOR ALL COLUMNS SIZE AUTO');
--表+インデックス+列統計(ヒストグラムのサイズを最も大きくする場合)
exec DBMS_STATS.GATHER_TABLE_STATS(ownname=>'TEST',tabname=>'TAB1',cascade=>true,method_opt=>'FOR ALL COLUMNS SIZE 254');

--拡張統計機能による相関列統計の取得(11g～)
--拡張統計の定義作成(tab1表のcol1とcol2の相関列統計を取得する、作成した定義はuser_col_statistics等で確認可能)
select dbms_stats.create_extended_stats(null,'TAB1','(col1,col2)') from dual;
--ヒストグラムを取得することで相関列統計も取得される
exec dbms_stats.gather_table_stats(NULL,'TAB1',method_opt => 'for all columns size skewonly');

--スキーマ全体
exec DBMS_STATS.GATHER_SCHEMA_STATS(ownname=>'TEST');

--DB全体
exec DBMS_STATS.GATHER_DATABASE_STATS();

--SYSTEM統計(CPUやIO速度等の統計)
exec DBMS_STATS.GATHER_SYSTEM_STATS();

--パーティション表のグローバルレベルのみ
exec DBMS_STATS.GATHER_TABLE_STATS(ownname=>'TEST',tabname=>'TAB1',cascade=>true,granularity=>'GLOBAL');

--パーティション表のパーティションレベルのみ
exec DBMS_STATS.GATHER_TABLE_STATS(ownname=>'TEST',tabname=>'TAB1',cascade=>true,granularity=>'PARTITION');
exec DBMS_STATS.GATHER_TABLE_STATS(ownname=>'TEST',tabname=>'TAB1',cascade=>true,granularity=>'SUBPARTITION');

--テーブル統計のセット(行数100万、ブロック数100万、平均行サイズ8000byte)
exec DBMS_STATS.SET_TABLE_STATS(ownname=>'TEST',tabname=>'TAB1',numrows=>1000000,numblks=>1000000,avgrlen=>8000);

--列統計のセット(値の種類100万,平均列長30byte)
exec DBMS_STATS.SET_COLUMN_STATS(ownname=>'TEST',tabname=>'TAB1',colname=>'col2',distcnt=>'1000000',avgclen=>'30');

--インデックス統計のセット(行数100万、ブロック数100万、キー値の種類100万)
exec DBMS_STATS.SET_INDEX_STATS(ownname=>'TEST',indname=>'I_TAB1',numrows=>1000000,numlblks=>1000000,numdist=>1000000);

--統計のロック
exec DBMS_STATS.LOCK_TABLE_STATS ('TEST', 'TAB1');
--統計のアンロック
exec DBMS_STATS.UNLOCK_TABLE_STATS ('TEST', 'TAB1');

--統計の削除
exec DBMS_STATS.DELETE_TABLE_STATS(ownname=>'TEST',tabname=>'TAB1');
--SYSTEM統計削除
exec DBMS_STATS.DELETE_SYSTEM_STATS();

--統計情報エクスポート
exec DBMS_STATS.CREATE_STAT_TABLE (ownname =>'TEST',stattab =>'STAT_TAB',tblspace =>'USERS');
exec DBMS_STATS.EXPORT_TABLE_STATS (ownname => 'TEST',tabname => 'TAB1',stattab => 'STAT_TAB',cascade => TRUE);

--エクスポートテーブル削除
exec DBMS_STATS.DROP_STAT_TABLE (ownname => 'TEST',stattab => 'STAT_TAB');

--インポート
exec DBMS_STATS.IMPORT_TABLE_STATS (ownname => 'TEST',tabname => 'TAB1',stattab => 'STAT_TAB',cascade => TRUE);

--アナライズコマンドによる統計情報の取得
--統計の取得
ANALYZE TABLE TAB1 COMPUTE STATISTICS;
--統計の削除
ANALYZE TABLE TAB1 DELETE STATISTICS;

--関連ディクショナリ
SELECT * FROM DBA_TAB_STATISTICS;
SELECT * FROM DBA_IND_STATISTICS;
SELECT * FROM DBA_TAB_COL_STATISTICS;
SELECT * FROM DBA_PART_COL_STATISTICS;
SELECT * FROM DBA_SUBPART_COL_STATISTICS;
--統計履歴ディクショナリ(10g～)
SELECT * FROM DBA_OPTSTAT_OPERATIONS;
SELECT * FROM DBA_TAB_STATS_HISTORY;
```
* http://www.doppo1.net/oracle/script/statistics.html
