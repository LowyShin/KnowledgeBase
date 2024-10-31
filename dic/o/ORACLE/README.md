## Product detail

* Product by edition and additional products(jp)
  * https://docs.oracle.com/cd/E16338_01/license.112/b56284/editions.htm#CJACGHEB

## Management

### Start and stop

* Starting Oracle service
  * Switching Oracle Account
    * `root@localhost#>su - oracle`
  * execute sqlplus
    * `oracle@localhost$>sqlplus / as sysdba`
  * start oracle instance
    * `SQL>startup`
  * exit from sqlplus
    * `SQL>quit`
  * startup listener
    * `oracle@localhost$>lsnrctl start`
  * referral docs 
    * kr : https://mkil.tistory.com/336
* Stop oracle service
  * `su - oracle`
    * change oracle account
  * `emctl stop dbconsole`
    * Stop oracle enterprise manager
  * `lsnrctl stop`
    * Stop listener
  * `sqlplus / as sysdba`
    * Login sqlplus
  * `shutdown immediate`
    * shutdown oracle process when waiting exist connection
  * `shutdown abort`
    * shutdown oracle process aborting all connection
    * use when take too long time on `shutdown immediate` command

### Delete log files

* Listner log delete
```shell
$ adrci
adrci> show homepath
adrci> show control
adrci> purge -age 50000 -type alert
```
* -aget 50000 : 50000min.
* when purge, deleted xml log files.

```shell
$> lsnrctl
LSNRCTL> show log_status
LSNRCTL> show log_directory
LSNRCTL> show log_file
LSNRCTL> set log_status off
$> mv <log_file> <bak_file>
LSNRCTL> set log_status on
```

* Select Log
```sql
select 
originating_timestamp,
module_id,
message_text
from v$diag_alert_ext
```
* http://ichannel.tokyo/technoracle/%E3%82%A2%E3%83%A9%E3%83%BC%E3%83%88%E3%83%AD%E3%82%B0%E3%81%AE%E6%A4%9C%E7%B4%A2%E6%96%B9%E6%B3%95/2752/

## Backup and Restore

* [Oracle Backup and Restore](ORACLE-BackupRestore)

* [Active Duplicate](ORA-ActiveDuplicate.md)

## Tuning

  * https://github.com/LowyShin/KnowledgeBase/wiki/ORACLETuning

## Initialize

* NLS_LANG
```
●UTF8
NLS_LANG=Japanese_Japan.AL32UTF8

●SJIS
NLS_LANG=Japanese_Japan.JA16SJIS

●EUC
NLS_LANG=Japanese_Japan.JA16EUC
```

※DatabaseをUS7ASCIIに設定して日本語を入れてもDBには正常に記録されるが、読み取りの際にUS7ASCIIにしてもORACLEの仕様上勝手にUTF8に変更される。これはOCI経由ではNLS_LANGパラメータを利用してクライアントのCharactersetを強制に指定できるが、Direct ConnectまたはODBC、JDBCを経由するとUnicodeに変換され文字化けになってしまう。なので文字化けした場合には必ず次の内容をチェックする

* OCIがサポートするクライアントツール
* NLS_LANG = US7ASCIIになっている(ClientまたはOS Parameter)
* クライアントツール側に自動変換をOFFにしている

## Client

### Freeware

* Oracle Instant Client
  * https://www.oracle.com/technetwork/jp/database/database-technologies/instant-client/overview/index.html

### Shareware

* Orange Client
  * http://www.warevalley.com/solutions/orange.asp
* Toad
  * https://www.quest.com/products/toad-for-oracle/

## Other links

* rman basic : https://blogs.oracle.com/otnjp/kusakabe-007
* rman example : https://www.atmarkit.co.jp/ait/articles/1103/03/news110.html
* count dml times : https://kenken0807.hatenablog.com/entry/2016/04/27/102801
* rman transportability incremental backup
  * https://zatoima.github.io/oracle-jpoug-migration-database.html
* table diff (MINUS) : https://itsakura.com/sql-minus
* dba_hist_snapshot : https://docs.oracle.com/cd/B19306_01/server.102/b14237/statviews_3177.htm#REFRN23442
* merge : https://www.shift-the-oracle.com/sql/merge.html
* grant : http://itref.fc2web.com/oracle/sql/grant.html
* Set Linesize : https://www.shift-the-oracle.com/sqlplus/system-variable/linesize.html
* Wrap system variables : https://www.shift-the-oracle.com/sqlplus/system-variable/wrap.html
* sql plus silent mode : https://www.shift-the-oracle.com/sqlplus/tutorial/sqlplus-silent.html
* OPN Register : https://docs.google.com/document/d/1D4cxbJyLDbRokY4QTKnEnVsF56ClSKDvRHuA6MvpB68/edit?usp=sharing
* alter user account unlock 
  * https://dbtut.com/index.php/2019/03/09/why-oracle-user-is-locked-who-is-locking-oracle-user/
* select where in 
  * https://qiita.com/kametter/items/b26282d0fad3436bffc2
* ALTER TABLESPACE temp ADD TEMPFILE '+DATA/ORCL/DATAFILE/temp02.dbf' SIZE 2048M REUSE;
  * https://dba.stackexchange.com/questions/240774/how-to-increase-size-of-temp-tablespace-in-oracle-12c-rac-with-asm
* temp tablespace usage
  * https://www.fuku.tokyo/2020/04/temp/
* check user expire
  * https://rajeevjhaoracle.wordpress.com/2014/06/19/how-to-recover-an-expired-user-account-in-oracle-database/
  ```sql
  SELECT username, account_status, expiry_date
  FROM dba_users
  ```
  * https://stackoverflow.com/questions/5521766/change-oracle-user-account-status-from-expiregrace-to-open
  ```sql
  select
  'alter user ' || su.name || ' identified by values'
  || ' ''' || spare4 || ';'    || su.password || ''';'
  from sys.user$ su 
  join dba_users du on ACCOUNT_STATUS like 'EXPIRED%' and su.name = du.username;
  ```
* TO_NUMBER error
  * put into from the table when error TO_NUMBER
  ```sql
  select TO_NUMBER(MYFLD)
  from (
    select SUBSTR(MYFLD, 3) as MYFLD
    from MYTBL
  ) A
  ```
* dbms_stats.gather_schema_stats : https://www.krenger.ch/blog/difference-between-dba_tables-num_rows-and-count/
* pga/sga : https://blog.yannickjaquier.com/oracle/pga-and-sga-sizing.html
* pga tuning : https://www.ex-em.co.jp/oracle-k/oracle-parameter/1740/
* DBMS STAT : https://www.shift-the-oracle.com/performance-tuning/dbms_stats_table.html
* Generate STAT : https://docs.oracle.com/cd/E16338_01/appdev.112/b56262/d_stats.htm#i1036560
* TEMP tablespace usage
    * https://www.fuku.tokyo/2020/04/temp/
    ```sql
    COL "USED[MB]" FORMAT 999999.9
    COL "FSIZE[MB]" FORMAT 999999.9
    COL "MAXSIZE[MB]" FORMAT 999999.9
    SELECT
      DT.TABLESPACE_NAME,
      NVL("USED[MB]",0 ) "USED[MB]",   -- 使用中のサイズ
      "FSIZE[MB]",                     -- 現在のファイルサイズ
      "MAXSIZE[MB]"                    -- 自動拡張の最大ファイルサイズ 
    FROM
      (SELECT
          TABLESPACE_NAME,
          SUM(BYTES)/1024/1024 "FSIZE[MB]",
          SUM(MAXBYTES)/1024/1024 "MAXSIZE[MB]"
        FROM
          DBA_TEMP_FILES
        GROUP BY TABLESPACE_NAME) DT
    LEFT OUTER JOIN
      (SELECT
          TABLESPACE_NAME,
          MIN(BYTES_USED)/1024/1024 "USED[MB]"
        FROM GV$TEMP_EXTENT_POOL
        GROUP BY TABLESPACE_NAME ) TE
    ON DT.TABLESPACE_NAME = TE.TABLESPACE_NAME
    ORDER BY TABLESPACE_NAME
    ;
    ```
* buffer cache
  * http://www.doppo1.net/oracle/tuning/buffer_cache.html
  * https://www.atmarkit.co.jp/ait/articles/0412/11/news016_2.html
* FAQ 묶음
  * https://www.ashisuto.co.jp/ojt/aftersupport/download_oracle/faq_otn.pdf
* oracle EOL(End of License)
  * https://support.oracle.com/knowledge/Oracle%20Cloud/2068697_1.html
* huge page config
  * https://oracle-base.com/articles/linux/configuring-huge-pages-for-oracle-on-linux-64
* SGA tuning
  * https://blog.naver.com/noranja69/220271949788
* Useful sql for tuning(system status)
  * http://system3support.jp/pdf/oracle_knowledge/architecture/p114.pdf
* slow query finder
  * https://jmkjb.tistory.com/131

* [セッションの一覧を取得し、不要なセッションを強制終了する（ALTER SYSTEM KILL SESSION）](https://www.projectgroup.info/tips/Oracle/SQL/SQL000028.html)


* [基本からわかる！高性能×高可用性データベースシステムの作り方　第7回 バックアップ/リカバリ(2)RMANの基本](https://blogs.oracle.com/otnjp/post/kusakabe-007)
* [Active Database Duplicateで静的リスナーが不要になっていた件](https://qiita.com/tlokweng/items/1e2cd7d293e5dde5a4b2)
* [Build a Secure Node.js App with SQL Server](https://developer.okta.com/blog/2019/03/11/node-sql-server)
* [Backup and Recovery User's Guide](https://docs.oracle.com/en/database/oracle/oracle-database/19/bradv/rman-backup-concepts.html#GUID-B3380142-ABCD-437F-9E06-B219D74E6738)
* [19c Upgrade를 위해서 11g ADG 구성](https://files.slack.com/files-pri/TMAK63B3R-F02P11GHP6Z/11g_asm_mig_for_upgrade-4.txt)
* [asm_migration video](https://files.slack.com/files-tmb/TMAK63B3R-F02PGJELH09-cfc6fe38e2/01.asm_migration.mp4)
* [Recovery Manager](https://slack-files.com/files-pri-safe/TMAK63B3R-F02PGKFFVK3/rman_knt_goodusdata.pdf?c=1638576463-022e053d602155b0)
* [dataguard](https://files.slack.com/files-pri/TMAK63B3R-F02P12J2AE9/adg_knt_goodusdata_new.pdf)
* [Active duplication](https://files.slack.com/files-pri/TMAK63B3R-F02P420KSNP/image.png)
* [오라클 메모리 관련 정리](https://positivemh.tistory.com/493)
* [ORACLE 11 to 19c Migration](https://blog.serverworks.co.jp/best-practices-for-upgrading-amazon-rds-for-oracle-db-instances-from-11-2-0-4-to-19c)

