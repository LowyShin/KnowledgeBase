## Management

* Connect from shell
  * `mysql -u root -h giipdb.mysql.com -p -P 3306`
    * `-u` : user
    * `-p` : ask password
    * `-h` : host
    * `-P` : Port

* show running SQL
  * `show processlist;`
  * `show full processlist \G`

* Cursor
  * https://codeday.me/jp/qa/20190213/271235.html - jp

* Binlog(Binary Log)
  * delete bin-log
    * https://www.skyarch.net/blog/?p=1096
    * on sql prompt
    ```sql
    show global variables like ‘expire_logs_days’;
    set global expire_logs_days = 7;
    show global variables like ‘expire_logs_days’;
    ```
    * my.cnf
    ```conf
    [mysqld]
    expire_logs_days = 7
    ```
  * managing binary log
    * https://www.ritolab.com/entry/98
  * Decode binary log
    * https://www.percona.com/blog/2015/07/30/why-base64-outputdecode-rows-does-not-print-row-events-in-mysql-binary-logs/

* Start option
  * Official : https://dev.mysql.com/doc/refman/5.6/en/mysql-command-options.html

* stop
  ```sh
  mysqladmin -u root -p shutdown
  ```

* Run from sql file
  * Official : https://dev.mysql.com/doc/refman/8.0/en/mysql-batch-commands.html

## Tuning

* [DBの負荷分散手法](https://www.engineer-memo.net/20200305-5241)

### Innodb

* Check tuning point using mysqltuner
  * You can tune easy by suggestion on mysqltuner
```
$ wget https://github.com/major/MySQLTuner-perl/zipball/master
$ unzip master
$ cd master
$ ./mysqltuner.pl
```
  * https://corporate.inter-edu.com/developper/1373

* innodb storage engine
  * https://enterprisezine.jp/dbonline/detail/3829
* SQL relative innodb buffer pool size
  * https://dba.stackexchange.com/questions/27328/how-large-should-be-mysql-innodb-buffer-pool-size

* show innodb engine information
  * `SHOW ENGINE INNODB STATUS\G`

* Query Cache Tuning
```sql
-- Configuration
SHOW VARIABLES LIKE '%query_cache%';

-- Usages
SHOW STATUS LIKE 'Qcache%';
```
  * https://qiita.com/tukiyo3/items/797f9916e6494ec33991

* tuning writings
  * https://gihyo.jp/dev/serial/01/MySQL-tuning-scale

## Information

* Characterset vs collation
  * collation_connection, collation_server
  * character_server, character_database
  * https://atsuizo.hatenadiary.jp/entry/2016/08/22/090000


## Trouble shooting

* extend timeout from MySQL Workbench client
  * http://oboe2uran.hatenablog.com/entry/2016/03/21/102931
* `InnoDB: Doing recovery: scanned up to log sequence number 2938498040110`
  * https://yakst.com/ja/posts/53
* If you forgot root password...
  * https://liginc.co.jp/web/programming/mysql/87393
  * `mysqld_safe --skip-grant-tables &` as Run with no pass
* Can not effect grant command
  * resolve to recreate user using grant command
    * https://talklowy-jp.blogspot.com/2020/06/mysql-grant.html
* [データベースの破損をチェックする方法](https://docs.moodle.org/3x/ja/%E3%83%87%E3%83%BC%E3%82%BF%E3%83%99%E3%83%BC%E3%82%B9%E3%81%AE%E7%A0%B4%E6%90%8D%E3%82%92%E3%83%81%E3%82%A7%E3%83%83%E3%82%AF%E3%81%99%E3%82%8B%E6%96%B9%E6%B3%95)
* [How to repair MySQL databases and tables](https://www.a2hosting.com/kb/developer-corner/mysql/repairing-mysql-databases-and-tables)

## Useful SQL

* Update join 
```sql
UPDATE users a
LEFT JOIN userlog b
ON a.userid = b.userid
SET a.point = a.point + 100
WHERE b.loginstatus = 1;
```

* insert select on duplicate key update
  * it have to make primary key. Compare with TABLEA and TABLEB by primary key.
```sql
insert into TABLEA (FIELDA01, FIELDA02)
select FIELDB01, FIELDB02
from TABLEB
where FIELDB03 = 'formerge'
on duplicate key update FIELDA02 = FIELDB04
```

## Functions

* CAST() - converting various datetime format using CAST
  * http://daas.la.coocan.jp/mysql/kowaza_01_MojiToDate.htm

* DATE_FORMAT()
  * https://variable.jp/2009/07/14/mysql%E6%97%A5%E4%BB%98%E9%96%A2date_format%E3%82%84time_format/

## Shell

* do not ask password when running cron job or shell batch
  * https://qiita.com/goto_yoshiki/items/4f75568799c044df811d


## Index

* [Knowledgebase](https://github.com/LowyShin/KnowledgeBase)
  * [edit this page](https://github.com/LowyShin/KnowledgeBase/blob/master/wiki/MySQL/README.md)

## Trouble Shooting

* [[ERROR] /usr/local/mysql/libexec/mysqld: Sort aborted]()
  * change sort_buffer 
  * InnoDB ストレージエンジン: この修正により、long semaphore wait メッセージで MySQL Server がハングしたり、異常終了するケースが解消される
  * 5.5.17에서 패치됨(Bug #11766591、Bug #59733)
    * https://openstandia.jp/oss_info/mysql/pdf/MySQL_5.5.17.pdf

* MySQL my.cnf description
  * https://qiita.com/yoheiW@github/items/bcbcd11e89bfc7d7f3ff

* Federated table - mysql
  * https://winashwin.wordpress.com/2012/08/22/mysql-federated-table/

* [mysql purge](https://www.mk-mode.com/blog/2012/05/23/23002009/)
  * `PURGE MASTER LOGS BEFORE now() - 15;`


## Ref

* [MySQL の max_connections, table_open_cache, open_files_limit の関係](https://tmtms.hatenablog.com/entry/2017/10/12/mysql-max-connections)
* [How to set memory limit in my.cnf file](https://stackoverflow.com/questions/12104185/how-to-set-memory-limit-in-my-cnf-file)
* [ySQLのメモリ使用量の調整](https://tyablog.net/2020/02/22/adjust-mysqld-memory-usage/)
* [mysqldump_single-transaction](https://dev.mysql.com/doc/refman/8.0/en/mysqldump.html#option_mysqldump_single-transaction)
* [テーブルロックを発生させずにmysqldumpを実行する](https://hodalog.com/mysqldump-without-locking-tables/)
