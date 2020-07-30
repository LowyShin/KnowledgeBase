## Update

* Update join
```sql
update TMEMBER M
set MPNT = (select M.MPNT + Q.MPNTCHRG from CHRGEQUEUE Q where M.UID = Q.UID)
where exists (select 1 from CHRGEQUEUE QC where QC.UID = M.UID)
```

## String

* SUBSTR(Substring, left, right)
```sql
/* if you want using left */
select SUBSTR('mystr', 1, 3) from dual;
-- result : mys

/* if you want using right */
select SUBSTR('mystr', -3) from dual;
-- result : str

/* if you want using substring */
select SUBSTR('mystr', 3, 2) from dual;
-- result : st
```

* replace(sourcetext, findstr, replacestr)
```sql
select REPLACE('mystr', 's', 'o') from dual;
-- result : myotr

```

## Math

* mod
```sql
select mod(10, 7) from dual;
-- result : 3
```


## Others

* Find String from Procedure source
```sql
SELECT *
 FROM ALL_SOURCE
 WHERE TEXT LIKE '%EVENTSTRING%'
 ORDER BY TYPE, NAME, LINE;
```

* Japanese Traditional datetime
  * https://www.shift-the-oracle.com/sql/functions/to_date.html

```sql
SQL> select to_char(SYSDATE, 'EEDL', 'NLS_CALENDAR=''JAPANESE IMPERIAL''')
  2  from dual;
 
TO_CHAR(DATE'1900-01-01','EEDL','NLS_CALEN
------------------------------------------
明治33年1月1日 月曜日
```

* DateDiff
```sql
select dtA - dtB as sDatediff from TableA;
```
  * https://www.shift-the-oracle.com/sql/functions/function-base-reference-2.html

* ADD_MONTH()
```sql
SELECT  TO_CHAR (ADD_MONTHS (SYSDATE, -1), 'YYYYMM')  AS m1
  , TO_CHAR (ADD_MONTHS (SYSDATE, -2), 'YYYYMM')  AS m2
  , TO_CHAR (ADD_MONTHS (SYSDATE, -3), 'YYYYMM')  AS m3
FROM    dual;
```

* Create DDL script
```sql
-- if use long when ddl script be truncated
set long 100000
select dbms_metadata.get_ddl('TABLE','TableName','Owner') from dual;
select dbms_metadata.get_ddl('Procedure','ProcedureName','Owner') from dual;
```

* Find locked SQL
```sql
select * from v$lock where block = 1;
```

* Update Join
  * http://www.mitene.or.jp/~rnk/TIPS_ORCL_UPDATE.htm
  * https://codeday.me/jp/qa/20190309/382305.html
    * 11g Versionでは使えなかった。


### Table/View/Procedure/Function structure

* https://devlights.hatenablog.com/entry/20091005/p1
  * user_tables -> all_tables のようにuserをallに変えたら異なるユーザーが作成したリソースが確認できる。

### Ranking

* https://sql-oracle.com/?p=1246
```sql
SELECT stu_no,activity,score,
 RANK() OVER (ORDER BY score) score_rank
FROM student
ORDER BY score_rank;
```

* split field by delimeter character
  * https://www.shift-the-oracle.com/sql/functions/strtoken.html
```sql
CREATE OR REPLACE FUNCTION STRTOKEN(
	P_STRING VARCHAR2, P_DELIMIT VARCHAR2,
	P_POS POSITIVEN := 1, P_NTH POSITIVEN := 1,
	P_EOD VARCHAR2 := NULL)
RETURN VARCHAR2
IS
	vStartPos	PLS_INTEGER;
	vEndPos		PLS_INTEGER;
BEGIN
	IF (P_POS = 1) THEN
		vStartPos := 1;
	ELSE
		vStartPos := INSTR(P_STRING, P_DELIMIT, 1, P_POS - 1);
		IF (vStartPos = 0) THEN
			RETURN P_EOD;
		END IF;
		vStartPos := vStartPos + 1;
	END IF;
	vEndPos := INSTR(P_STRING, P_DELIMIT, vStartPos, P_NTH);
	IF (vEndPos = 0) THEN
		RETURN SUBSTR(P_STRING, vStartPos);
	END IF;
	RETURN SUBSTR(P_STRING, vStartPos, vEndPos - vStartPos);
END;
/
```

* Group by / ROLLUP
  * https://qiita.com/q1701/items/2321b9a8674d9796af5b

### Functions

* REGEXP_SUBSTR
  * https://www.shift-the-oracle.com/sql/functions/regexp_substr.html

### Triggers

* Enable/disable/compile
```sql
alter trigger <triggername> disable;
alter trigger <triggername> compile;
alter trigger <triggername> enable;
```

### DB Link

* MySQL DB Link
  * https://qiita.com/mossi/items/d2a8c8c113738bee9f2d

### AWR / ASH

* https://www.oracle.com/technetwork/jp/ondemand/branch/20150617-awr-2602086-ja.pdf

