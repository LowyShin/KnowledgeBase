## Usage

* Select data a point of timestamp as rollback.
```sql
SELECT * FROM MyTable
AS OF TIMESTAMP TO_TIMESTAMP('20200530032500', 'YYYYMMDDHH24MISS') 
```
* Important
  * Too many data changes within that time, it occurs error of flashback result.

