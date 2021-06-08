## First Configuration

* Master Server
  ```sql
  -- create user for replication
  GRANT REPLICATION SLAVE ON *.* TO 'replusr'@'XXX.XXX.XXX.XXX' IDENTIFIED BY 'replpwd';
  -- check user
  select user, host from mysql.user where user = 'replusr';

  RESET MASTER;
  -- Locking for start sync
  FLUSH TABLES WITH READ LOCK;
  -- check all task was flushed
  SHOW STATUS LIKE 'Key_blocks_not_flushed';
  /*
  Key_blocks_not_flushed | 0 
  */

  -- get file name and position
  SHOW MASTER STATUS\G;
  /*
  File: mysql-bin.000001
  Position: 999
  */

  ```
* Master check sync
  ```sh
  mysql -u root -p -e "SHOW ENGINE INNODB STATUS\G" | grep -e "Log sequence number" -e "Log flushed up to"
  ```
* Master backup
  ```sh
  mysqldump -u root -p --all-databases >all-databases.dmp
  ```

* Slave conf
  ```sql
  STOP SLAVE;
  RESET SLAVE ALL;
  -- using master file and position
  CHANGE MASTER TO 
  MASTER_HOST='XXX.XXX.XXX.XXX',
  MASTER_USER='replusr',
  MASTER_PASSWORD='replpwd',
  MASTER_LOG_FILE='mysql-bin.000001',
  MASTER_LOG_POS=999;

  UNLOCK TABLES;
  -- check slave
  SHOW SLAVE STATUS\G
  ```

## BinaryLog

Bin-log need for replication configuration. 

* `vi /etc/my.cnf`
  ```conf
  [mysqld]
  # enable binary log
  log-bin=mysql-bin
  server-id=1001
  # set expire bin-log
  expire_logs_days=14
  ```
* SQL
  ```sql
  -- show bin-log files
  SHOW MASTER STATUS;
  -- delete under mysql-bin.000989
  PURGE MASTER LOGS TO 'mysql-bin.000990';
  ```

## Check

* Master
```sql
show master status;
-- Check Master position
-- if null, this server is slave or stand-alone
```


* Slave
```sql
show slave status;
-- Check master position and slave position
-- You can see result on master and slave
```

## Reconnect

* If replication is broken and reconnect
```sql
/* on Slave
*/
show slave status;
-- get Master_Log_file
-- get Exec_Master_Log_Pos

STOP SLAVE;

RESET SLAVE;

CHANGE MASTER TO MASTER_LOG_FILE='<Master_Log_file>', MASTER_LOG_POS=<Exec_Master_Log_Pos>;

START SLAVE;

show slave status;

```

## Fully_initialize

```sql
/* on Master =====================
*/

RESET MASTER;
FLUSH TABLES WITH READ LOCK;
SHOW MASTER STATUS;

-- get Master_Log_file
-- get Master_Log_Pos

/* run mysqldump on ssh
mysqldump mydata.sql
*/

UNLOCK TABLES;

/* on Slave =====================
*/

STOP SLAVE;

/* import from ssh
mysql -uroot -p < mydata.sql
*/

RESET SLAVE;

CHANGE MASTER TO MASTER_LOG_FILE='<Master_Log_file>', MASTER_LOG_POS=<Master_Log_Pos>;

START SLAVE;

show slave status;

```

### Ref

* Knowledgebase
  * https://github.com/LowyShin/KnowledgeBase/wiki

* for edit page
  * https://github.com/LowyShin/KnowledgeBase/tree/master/wiki/MySQL/MySQL-Replication.md


