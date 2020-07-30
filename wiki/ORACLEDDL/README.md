## Database Link

* Create database link using tnsnames.ora file
```sql
create [public] database link GIIPDB connect to GIIPADMIN identified by "GIIPPWD" using 'GIIPDBTNS';
```
* tnsnames.ora
```conf
GIIPDB =
  (DESCRIPTION =
    (ADDRESS = (PROTOCOL = TCP)(HOST = giipdb.littleworld.net)(PORT = 1984))
    (CONNECT_DATA =
      (SERVICE_NAME = GIIPDB)
    )
  )
```


## Table

* Create Table

```sql
create table <tablename> (
Field1 varchar(100)
, Field2 number(10)
)
tablespace USR_D01
;
```

* Copy table
```sql
create table <tablename> tablespace USR_D01 as
select * from <tablenameorg>
;
```

* Change table name
```sql
ALTER TABLE TAB_A RENAME TO TAB_B;
```

## Add Constraint(PK, Primary Key)

Find primary key from original table
```sql
select OWNER, CONSTRAINT_NAME, TABLE_NAME from all_constraints where CONSTRAINT_TYPE = 'P' and TABLE_NAME = '<tablename>';
```

Add primary key
```sql
alter table <tablename>
add constraint <tablename>_PK primary key (<Field1>) ;
```

## Alter table

* Change column spec
```sql
alter table TABLENAME
modify (FIELDNAME1 varchar2(20));
```

## Get ddl script

```sql
-- if use long when ddl script be truncated
set long 100000
select dbms_metadata.get_ddl('TABLE','TableName','Owner') from dual;
select dbms_metadata.get_ddl('Procedure','ProcedureName','Owner') from dual;
```

* Copy sequence at same starting point
```sql
SELECT ' CREATE SEQUENCE ' || SEQUENCE_OWNER || '.' || SEQUENCE_NAME ||
	' INCREMENT BY ' || TO_CHAR(INCREMENT_BY) ||
	' START WITH ' || TO_CHAR(LAST_NUMBER) ||
	' MAXVALUE ' || TO_CHAR(MAX_VALUE) ||
	' MINVALUE ' || TO_CHAR(MIN_VALUE) ||
	' CACHE ' || TO_CHAR(case when CACHE_SIZE = 0 then 10 else CACHE_SIZE end) ||
	DECODE (CYCLE_FLAG, 'N', ' NOCYCLE ', 'Y', ' CYCLE ') ||
	DECODE (ORDER_FLAG, 'N', ' NOORDER ', 'Y', ' ORDER ') || ';'
FROM ALL_SEQUENCES
WHERE SEQUENCE_OWNER in ('GIIP');
```
* set sequence
```sql
alter sequence
    <SEQNAME>
increment by 9999;
```
* get sequence
  * Error occurs when current session has no sequence data. It need execute nextval when error occurs
```sql
-- next sequence of SEQA
select SEQA.NEXTVAL from dual;
-- current sequence of SEQA
select SEQA.CURRVAL from dual;
```

* generate user ddl
  * https://oracle-base.com/dba/script?category=script_creation&file=user_ddl.sql

