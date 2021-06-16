# long_semaphore_wait

## message
```log
InnoDB: Warning: a long semaphore wait:
```

## Reason

Innodb Engine bug

* https://bugs.mysql.com/bug.php?id=94930
* https://bugs.mysql.com/bug.php?id=88523

## Solve

upgrade to mysql 5.5.17

* Patch note
    * https://openstandia.jp/oss_info/mysql/pdf/MySQL_5.5.17.pdf
    ```
    InnoDB ストレージエンジン: この修正により、long semaphore wait メッ
    セージで MySQL Server がハングしたり、異常終了するケースが解消さ
    れる
    ```

