
### find SQL from binary log(bin-log)
```sh
mysqlbinlog --no-defaults --database=lowydb /mysql/logs/binary_log.006143 | grep tablename | grep username > lowydb_20210702_1.sql
```
