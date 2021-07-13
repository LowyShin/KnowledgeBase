## Oracle Tuning

* Find SQL Usage
* Check index and table full scan, etc.
* add or correct index
* suggest PK(clustered index)
* rewrite SQL by data size and statistics

## Referral SQL

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

```sql
SELECT
      sample_time
      ,session_id
      ,session_serial#
      ,seq#
      ,user_id
      ,sql_id
      ,top_level_sql_id
      ,event
      ,session_state
      ,program
      ,machine
      ,pga_allocated
  FROM
      dba_hist_active_sess_history
   WHERE
     sample_time > sysdate - 1
;

SELECT
      count(1)
  FROM
      dba_hist_active_sess_history
   WHERE
     sample_time > sysdate - 1
;

      to_timestamp (SYS, 'YY-MM-DD HH24:MI:SS')
                  AND to_timestamp ('17-03-09 14:10:00', 'YY-MM-DD HH24:MI:SS')
  ORDER BY 1
 ;

select a.value, s.username, s.sid, s.serial#

select count(1)
from v$sesstat a, v$statname b, v$session s
where a.statistic# = b.statistic#  and s.sid=a.sid
and b.name = 'opened cursors current';

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

* ulimit change
  * https://alpha-netzilla.blogspot.com/2012/12/parameter-user.html
  * see all : ulimit -a
  * change : ulimit -l unlimited -> max locked memory
  * /etc/security/limits.conf

* [ORACLE tablespace defragmentation](https://blog.toadworld.com/tablespaces_-_defragmenting)
* [[SQL] '%'や'_'をLIKE検索する](https://oracle.programmer-reference.com/sql-like-percent-underbar/)

* [Oracle DataPump](https://qiita.com/plusultra/items/0510587dc052ac4c0875)
* Oracle expdp:ORA-31634: job already exists
  * https://www.twblogs.net/a/5c237063bd9eee16b3db454f
  * https://www.code-lab.net/?p=21850
* [Oracle expdp usage](https://sql-oracle.com/?p=183)
* [ORACLE rman example script](https://qiita.com/shione/items/adcc6b9730e4b4f6f640)
* [oracle archive log activate](https://www.sql-dbtips.com/architecture/log_mode/)
  * `select log_mode from v$database;`
* [rman incremental tablespace backup and restore redundant server](https://zatoima.github.io/oracle-jpoug-migration-database.html)
* [rman move tablespace](https://cosol.jp/techdb/2019/12/love_rman_jpoug_advent_calendar_2019_1st_day/)
* [rman duplicate active database](https://qiita.com/tlokweng/items/a041394e1011434eca06)
* [rman backup incremental](https://cosol.jp/techdb/2019/12/love_rman2_ultra_fast_oracle_recovery/)
* [rman archive log delete command](https://it-memo.info/?p=1413)
* [drill down rman backup and schedule](https://www.slideshare.net/oracle4engineer/rman-44068359)
* [rman example script](https://qiita.com/shione/items/adcc6b9730e4b4f6f640)
* [ORACLE awr report](https://hackaday.hatenablog.com/entry/2019/12/14/082747)
* [ORACLE DDL](https://siguniang.wordpress.com/2013/09/04/oracle-dbms_metadata-get_ddl-fetch-ddl-for-tables/)
* [ORACLE DDL PACKAGE](https://qiita.com/Papageno/items/5b3159ec1a3b0e9db9ed)
* [oracle - instr](https://www.shift-the-oracle.com/sql/functions/instr.html)
* [oracle - regex substr](https://www.shift-the-oracle.com/sql/functions/regexp_substr.html)

