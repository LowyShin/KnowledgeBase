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

