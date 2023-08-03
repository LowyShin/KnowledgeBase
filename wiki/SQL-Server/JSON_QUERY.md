## JSON_VALUE

```sql
select jsondata, JSON_VALUE(jsondata, '$."MyField"') 
from tBLOBData 
where jsondata like '%MyField%'


select top 20 *
	, JSON_VALUE(kValue, '$.PROCCHK[0]."PROC"')
from tKVS
where kValue like '%"PROC":%'
order by ksn desc

```
