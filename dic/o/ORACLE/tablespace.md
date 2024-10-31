## Check Tablespace

* See free Table space
```sql
select a.TABLESPACE_NAME, Capacity, FreeSpace, round( (FreeSpace / Capacity * 100), 2) as FreeRate
from (
    SELECT TABLESPACE_NAME, sum(BYTES) as Capacity
    FROM   DBA_DATA_FILES
    group by TABLESPACE_NAME
) a 
inner join (
    select TABLESPACE_NAME, sum(BYTES) as FreeSpace
    from DBA_FREE_SPACE
    group by TABLESPACE_NAME
) b on a.TABLESPACE_NAME = b.TABLESPACE_NAME
order by FREERATE
;

```

## Create Tablespace

```sql
-- check table space files
SELECT *
FROM   DBA_DATA_FILES
where TABLESPACE_NAME like 'TS_001'
order by FILE_NAME
;

-- create file 
ALTER TABLESPACE TS_001
ADD DATAFILE
'/dev/raw/raw001'
SIZE 16777216000
AUTOEXTEND OFF
;

```

* If you have not permission of create raw file on ORACLE, make a file first on OS, then execute sql of alter tablespace


### Referral Links
  * official tablespace management
    * https://docs.oracle.com/cd/E57425_01/121/ADMIN/tspaces.htm#GUID-FB734C25-BA3A-45E8-BDCE-77C668140B67
  * https://doracle.tistory.com/48
    * tablespace auto resize, manual resize
  * http://kaludin.egloos.com/v/2919398
