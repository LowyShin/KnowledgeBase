## JSON_QUERY

JSON Query can be used over sql server 2015(?).

* You must filter to existed data, or get error
```sql
select * 
from (
	select top 200 * 
	from <tablename>
	where <jsonfield> like '%status%'
) A
where
	JSON_VALUE(<jsonfield>, '$."status"') = 0
```
- Field 一部だけJSONの場合
  - lsParamフィールドがJSONデータの場合
  - フィールド名が一致しないと`JSON text is not properly formatted. Unexpected character '@' is found at position 0.`エラーが発生するのでまずlike検索でフィルターをかける。（大小文字区別するので注意必要）
  ```sql
  select lssn, lsName, lsRegdt
  	, JSON_VALUE(lsParam, '$.UID') as juid
  from (
  	select * from tLogSp
  	where lsParam like '{%' 
  		and lsParam like '%UID%'
  ) a
  ```
* https://docs.microsoft.com/ja-jp/sql/t-sql/functions/json-modify-transact-sql?view=sql-server-ver15

* JSONをテーブルのように使う
  * https://docs.microsoft.com/ja-jp/sql/t-sql/functions/json-query-transact-sql?view=sql-server-ver15


* [SQL Server JSON select update delete](https://docs.microsoft.com/ja-jp/sql/t-sql/functions/json-modify-transact-sql?view=sql-server-ver15)
* [sql server openjson compatible level change](https://database.guide/how-to-fix-invalid-object-name-openjson-in-sql-server/)

* How to Create a MongoDB Collection Directly from SQL Server
  * https://studio3t.com/knowledge-base/articles/create-mongodb-collection-from-sql-server/

* SQL Server Monitoring tool
  * https://talklowykr.blogspot.com/2020/09/sql-server.html
 
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
