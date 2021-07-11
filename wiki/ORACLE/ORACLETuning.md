## Oracle Tuning

* Find SQL Usage
* Check index and table full scan, etc.
* add or correct index
* suggest PK(clustered index)
* rewrite SQL by data size and statistics

## Referral SQL

### 20210616SQL

* Locking SQL text
```sql
SELECT
  s.machine,status
  , s.event
  , to_char(prev_exec_start, 'YYYYMMDD HH24MISS')
  , row_wait_block#
  , row_wait_file#
  , a.sql_text
FROM v$session s,
     v$sqlarea a,
     v$process p
WHERE s.PREV_HASH_VALUE = a.hash_value
  AND s.PREV_SQL_ADDR = a.address
  AND s.paddr = p.addr
  AND sid in (
  	select SID from v$lock
	where type in ('TX', 'XR')
	)
order by s.machine;
```

* Count executed SQL by machine
```sql
SELECT
  s.machine,
  count(1) as Cnt
FROM v$session s,
     v$sqlarea a,
     v$process p
WHERE s.PREV_HASH_VALUE = a.hash_value
  AND s.PREV_SQL_ADDR = a.address
  AND s.paddr = p.addr
group by s.machine
order by count(1) desc, s.machine
;
```

* Count executed SQL by SQL_TEXT
```sql
SELECT
  count(1) as Cnt,
  a.sql_text
FROM v$session s,
     v$sqlarea a,
     v$process p
WHERE s.PREV_HASH_VALUE = a.hash_value
  AND s.PREV_SQL_ADDR = a.address
  AND s.paddr = p.addr
group by a.sql_text
order by count(1) desc, sql_text
;
```
* Last SQL execute time and source on memory. 
```sql
select last_active_time,parsing_schema_name,sql_text from v$sqlarea
order by last_active_time desc;
```

* Useful column by SQL on memory
```sql
SELECT
    count(1) as Cnt,
  s.status,  s.machine,  s.osuser,  s.module,  s.username,  p.program,  a.sql_text
FROM v$session s,
     v$sqlarea a,
     v$process p
WHERE s.PREV_HASH_VALUE = a.hash_value
  AND s.PREV_SQL_ADDR = a.address
  AND s.paddr = p.addr
group by 
  s.status,  s.machine,  s.osuser,  s.module,  s.username,  p.program,  a.sql_text
order by count(1) desc, machine, sql_text
;
```

* all table size
  * https://www.zanmai.net/blog/data/252.html
```sql
SELECT 
	a.owner
	, a.table_name
	,a.num_rows
	, b.MB
FROM all_tables a
      , (Select Segment_Name,Sum(bytes)/1024/1024 MB From dba_segments Group By Segment_Name) b
WHERE a.table_name = b.Segment_Name
ORDER BY b.MB desc, a.num_rows desc;
```
if you can not see row number, execute below system procedure gather_table_stat

* FInd table owner and size(rownum) check
```sql
select OWNER, TABLE_NAME, TABLESPACE_NAME, NUM_ROWS, TABLESPACE_NAME
from all_tables 
where TABLE_NAME in ('<Table name>')
;
```

* Execute if NUM_ROWS is null of above SQL
```sql
exec dbms_stats.gather_table_stats('<Owner>', '<Table Name>');
```

* Find column name from all tables
```sql
select * 
from all_tab_columns
where column_name like '<Column Name>'
;
```

* Get index info
```sql
select * from all_indexes
where TABLE_NAME in ('<Table Name>')
;

select * from all_ind_columns
where INDEX_NAME in (
    select INDEX_NAME from all_indexes
    where TABLE_NAME in ('<Table Name>')
    )
order by TABLE_NAME, INDEX_NAME, COLUMN_POSITION
;
```
* Put plan table
```sql
explain plan for
select AAA, count(1) from TABLENAME group by AAA;

select * 
from PLAN_TABLE
where to_char(TIMESTAMP, 'YYYYMMDDHH24MISS') in (select MAX(to_char(TIMESTAMP, 'YYYYMMDDHH24MISS')) from PLAN_TABLE)
order by PARENT_ID, ID
;
```

### Tuning information

* DWH tuning, Query statistics (jp)
  * https://www.oracle.com/jp/technical-resources/articles/pickup.html

### Database movement

* Oracle 11g movement Notes
  * https://talklowy-jp.blogspot.com/2020/07/oracle_29.html

### Lock management

* Lock mode explain and solution
  * (ja) https://www.ex-em.co.jp/oracle-k/oracle-event-%E8%A7%A3%E8%AA%AC/889/
* Lock mode description
  * (ja) https://www.shift-the-oracle.com/lock-event-enqueue/table-lock-matrix.html

### free buffer waits 

* https://www.ex-em.co.jp/oracle-k/oracle-event-%E8%A7%A3%E8%AA%AC/1266/free-buffer-waits/
* https://magnusjohanssontuning.wordpress.com/2017/09/05/free-buffer-waits/

```sql
select filetype_name, asynch_io, count(1)
from v$iostat_file
group by  filetype_name, asynch_io;
```

* https://oracle-base.com/articles/misc/direct-and-asynchronous-io

```sql
SHOW PARAMETER FILESYSTEMIO_OPTIONS

ALTER SYSTEM SET FILESYSTEMIO_OPTIONS=SETALL SCOPE=SPFILE;
SHUTDOWN IMMEDIATE
STARTUP

show parameter db_cache_size;
-- db_cache_size                        big integer 0
```

* http://www.nazmulhuda.info/buffer-cache-tuning
```sql
select name,value
from v$sysstat where name='free buffer inspected';

/*
select event,total_waits
from v$system_event
where event in ('buffer busy waits');
*/

show parameter sga;

SHOW PARAMETER buffer
-- log_buffer                           integer     9322496
-- alter system set log_buffer = 20M

select event, total_waits, time_waited
from v$session_event
where sid = (select sid from v$mystat where rownum = 1)
order by 3 desc;

```

