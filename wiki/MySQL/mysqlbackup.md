# Backup for MySQL

## mysqldump

* on the shell
```sh
# Dump all databases
mysqldump --single-transaction --quick --master-data -u USER_NAME -p -h HOST_NAME -A > OUTPUT_FILE_NAME

# Dump all databases definition 
mysqldump --single-transaction --quick --master-data -u USER_NAME -p -h HOST_NAME -A -d > OUTPUT_FILE_NAME

# Database backup
mysqldump --single-transaction --quick --master-data -u USER_NAME -p -h HOST_NAME DB_NAME > OUTPUT_FILE_NAME

# Table backup
mysqldump --single-transaction --quick --master-data -u USER_NAME -p -h HOST_NAME DB_NAME TABLE_NAME > OUTPUT_FILE_NAME

# Table definition + Data dump
mysqldump --single-transaction --quick --master-data -u USER_NAME -p -h HOST_NAME -A -n > OUTPUT_FILE_NAME 

# Restore
mysql -u USER_NAME -p -h HOST_NAME DB_NAME < OUTPUT_FILE_NAME

```
* Options
  * --single-transaction : Take a snapshot with no lock database
  * --quick : No use memory for large sized data
  * --master-data : show bin-log file name and position. if not use --single-transaction, enabled --lock-all-tables

## xtrabackup

https://developers.cyberagent.co.jp/blog/archives/28454/

