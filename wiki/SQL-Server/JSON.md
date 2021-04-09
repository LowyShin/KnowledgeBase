## JSON_VALUE

```sql
select jsondata, JSON_VALUE(jsondata, '$."MyField"') 
from tBLOBData 
where jsondata like '%MyField%'
```
