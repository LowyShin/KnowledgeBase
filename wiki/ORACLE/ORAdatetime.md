
* today
```sql
select SYSDATE from dual;
```
* change format to YYYYMMDD today
```sql
select to_char(SYSDATE, 'YYYYMMDD') from dual;
```

* change format to YYYYMMDD yesterday
```sql
select to_char(SYSDATE - 1, 'YYYYMMDD') from dual;
```

* change format to YYYYMMDD previous month
```sql
select to_char(ADD_MONTHS(SYSDATE, -1), 'YYYYMMDD') from dual;
```

* last date of this month
```sql
select to_date(to_char(ADD_MONTHS(SYSDATE, 1), 'YYYYMM') || '01', 'YYYYMMDD') - 1 from dual;
```

* last date of previous month
```sql
select to_date(to_char(SYSDATE, 'YYYYMM') || '01', 'YYYYMMDD') - 1 from dual;
```


* Pick yesterday, then set first date of that month and set last date of that month.
```sql
select 
  TO_DATE(TO_CHAR(ADD_MONTHS(SYSDATE, -1), 'YYYYMM') || '01000000', 'YYYYMMDDHH24MISS') as MoFirstDt
  , TO_DATE(TO_CHAR(SYSDATE, 'YYYYMM') || '01000000', 'YYYYMMDDHH24MISS') - 1 as MoLastDt
from dual;
```
