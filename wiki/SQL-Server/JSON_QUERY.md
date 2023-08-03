## JSON_VALUE

```sql
select jsondata, JSON_VALUE(jsondata, '$."MyField"') 
from tBLOBData 
where jsondata like '%MyField%'
```

Data : 
```json
[
	"field1":"data1",
	"PROCCHK":[
		"PROC":"data2-1",
		"PID":"data2-2",
	],
]
```

```sql
select top 20 *
	, JSON_VALUE(kValue, '$.PROCCHK[0]."PROC"')
from tKVS
where kValue like '%"PROC":%'
order by ksn desc

```
