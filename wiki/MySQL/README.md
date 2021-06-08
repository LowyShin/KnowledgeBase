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
  * https://www.ritolab.com/entry/98
    * managing binary log
  * https://www.percona.com/blog/2015/07/30/why-base64-outputdecode-rows-does-not-print-row-events-in-mysql-binary-logs/
    * Decode binary log

* Start option
  * Official : https://dev.mysql.com/doc/refman/5.6/en/mysql-command-options.html

* stop
  ```sh
  mysqladmin -u root -p shutdown
  ```

* Run from sql file
  * Official : https://dev.mysql.com/doc/refman/8.0/en/mysql-batch-commands.html

## Tuning

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

