# Data(Database, RDBMS, NoSQL)

## Common
* [CLoud RDBMS比較](https://cloud-textbook.com/50/)

## RDBMS

### SQL Server

* [SQL Server](https://github.com/LowyShin/KnowledgeBase/tree/master/dic/s/SQL-Server)
  * 同時5000Transaction程のDB負荷なら管理がしやすいSQL Serverをお勧めします。Azure SQLを使うと自動チューニング機能があってオンしておくと勝手にIndex Tuningを行います。（勝手にIndexがなくなったり作成されたり）データのアクセスパターンによって同じデータセットだとしても使うユーザーのパターンによってチューニングが変わるのでDBMSに詳しくない場合でも十分なパフォーマンスが保たれます。
  * [Ezis - RDBMS Monitoring](https://github.com/LowyShin/ezis-jp)

### ORACLE

* [ORACLE](./dic/o/ORACLE/README.md)
  * [Ezis - RDBMS Monitoring](https://github.com/LowyShin/ezis-jp)
  * 同時10000Transaction以上・無限にユーザーを増加させたいならORACLEより強いDBMSはありません。しかしその分十分なDBMS知識なしでは逆効果になるので自身があったらおすすめします。
  * [ORACLE Active Duplicate](./dic/o/ORACLE/ORA-ActiveDuplicate.md)
  * [Basic Management](https://talklowy-jp.blogspot.com/2020/10/oracle-management-knowledge.html)
  * [Installation](./dic/o/ORACLE/ORACLEInstallTips/README.md)
  * [InstantClient](https://talklowy-jp.blogspot.com/2021/10/oracle-linuxcentos-instant-client.html)
  * [DDL](https://talklowy-jp.blogspot.com/2020/10/oracle-ddl-lowy-knowledgebase.html)
  * [ORACLETuning](./dic/o/ORACLE/ORACLETuning.md)
  * [Merge Into/Update Join](./dic/o/ORACLE/MERGE.md)
  * [Useful SQL](https://talklowy-jp.blogspot.com/2020/10/oracle-useful-sql.html)
  * [TableSpaceManagement](./dic/o/ORACLE/tablespace.md)
  * [datetime](./dic/o/ORACLE/ORAdatetime.md)
  * [Flashback](./dic/o/ORACLE/ORAFlashback.md)
  * [BackupRestore](https://talklowy-jp.blogspot.com/2021/02/oracle-backup-and-restore-lowy.html)
  * [Characterset(Official)](https://www.oracle.com/technetwork/jp/content/charcterset-250314-ja.pdf)
  * [DBMS STAT](./dic/o/ORACLE/ORADBMSSTAT.md)
  * [dbvisitを利用したAWS上のRoacle Cluster](https://cosol.jp/techdb/2020/08/oracle-se2-multi-az-deploy-on-aws-ec2-using-dbvisit-standby/)

### MySQL/Mariadb/Aurora

* [MySQL](./dic/m/MySQL)
  * 同時4000トランザクション未満の3GB未満データでは一番軽く早いDBMSです。しかし容量と同時接続が増えるほど設計能力がパフォーマンスに直結するため拡張を考えるなら真剣に拡張設計から考慮することを推奨します。
  * [Ezis - RDBMS Monitoring](https://github.com/LowyShin/ezis-jp)
  * [my.cnf](https://github.com/LowyShin/KnowledgeBase/wiki/my.cnf)
  * [Replication](https://talklowykr.blogspot.com/2021/03/mysql-replication.html)
  * [backup](./dic//MySQL)
  * [MMM-MultiMaster](https://talklowy-jp.blogspot.com/2014/08/mysql-mmm-multi-master-ha.html)
  * [semaphore bug](./dic/m/MySQL/semaphorebug.md)
* [mariadb](./dic//mariadb)
  * MySQLエンジンを使って分離されたDBMSですが、今はエンジンもかなり異なっておりスピードより拡張を考慮して発展し続いているDBMSです。4台以上の分散が必要な場合分散及び管理がより簡単にできますが、台数が増えても性能は上がることではないので分散設計は人の力に依存します。
  * [Ezis - RDBMS Monitoring](https://github.com/LowyShin/ezis-jp)

## NoSQL

- [TiDB](./dic/t/tidb/README.md)
  - KV(Key Value)を使ったNoSQLのような保存方式でMySQLと同じSQLが使えるDBMS
* [Mongodb](./dic/m/mongodb)
  * ドキュメントデータベースとかに言われたりするHadoopと共にNoSQLの代表になりましたが、RDBMSではないのでRDBMSみたいにJoinをかけたりすると一般RDBMSよりもパフォーマンスが出ないこともあります。なのでNoSQLに入れるべきUnstructured(非構造)データを非正規化していかに高性能に使うかを考慮して設計しないと普通の大量テキストストレージになってしまうのでご注意を！

## BigData

* [MachineLearning(ML/AI)](./dic/m/MachineLearning/README.md)
* [BI](https://github.com/LowyShin/KnowledgeBase/wiki/BI)
  * Tableau, Google Data Portal, Redash and BI, data visualization tools

## MemoryDB/Cache

* [Redis with MySQL](./dic/Redis/README.md)
  * DBMSのIO負荷を下げる中間DBMSとしてよく使われておりますが、KVS(Key Value Store)構造のメモリ保管モジュールなので色んな役割で使いこなすとすごい力になると思います。しかし、単純にCluster DB Cacheなどの意味で使ってしまうと逆に同期の問題で性能があまり出ないこともあるので十分知ってから使うことを推奨します。

## Data Tools

* [Apache-Drill](https://github.com/LowyShin/KnowledgeBase/wiki/Apache-Drill)
  * Apache財団から推しているデータ抽出ツールでRDBMSとNoSQL、CSVなどのファイルデータなどをすべて一つのSQLで抽出できる強力なツールです。しかしインストールされたOSの言語とデータのCharactersetによって文字化けが多いので十分な工夫が必要です。NoSQLなどの非定型データとRDBMSのJoinが楽なのでデータ変換に時間をかけている場合は検討を推奨します。
  * Visualization機能がないのでもしレポート・グラフなどのビジュアル系が好みだったら[Tableau](./dic//tableau)をお勧めします。TableauはNoSQLとRDBMSのJoinまではできませんが、ある程度処理（Preparation, プレパレーションツール）をしたデータの分析及びグラフ出力には優れたツールです。
* [A5MK2-MultiDBMSTool](https://github.com/LowyShin/KnowledgeBase/wiki/A5MK2)
* [Referrals](https://github.com/LowyShin/KnowledgeBase/wiki/Referrals)

## Data Service

* [Kaggle: Your Machine Learning and Data Science Community](https://www.kaggle.com/)
- retool
  - Webでデータ管理ができるツール。柔軟なカスタマイズが特徴
  - DBMSから許可すべきIPアドレス : https://docs.retool.com/docs/allow-retools-cloud-ip-addresses
