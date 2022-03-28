* [Integration Services (SSIS) のインストール](https://docs.microsoft.com/ja-jp/sql/integration-services/install-windows/install-integration-services?view=sql-server-ver15)

* MSDTCを動作させるために必要な設定について
  * https://blogs.technet.microsoft.com/jpiis/2018/02/05/msdtc-settings/

## Functions

* `DATEADD(type, interval, sourcedate)`
* `CONVERT(varchar(20), getdate(), 120)` 
  * https://talklowy-jp.blogspot.com/2020/06/sql-server-convert-datetime.html

## JSON Query

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
* https://docs.microsoft.com/ja-jp/sql/t-sql/functions/json-modify-transact-sql?view=sql-server-ver15

* JSONをテーブルのように使う
  * https://docs.microsoft.com/ja-jp/sql/t-sql/functions/json-query-transact-sql?view=sql-server-ver15


* [SQL Server JSON select update delete](https://docs.microsoft.com/ja-jp/sql/t-sql/functions/json-modify-transact-sql?view=sql-server-ver15)
* [sql server openjson compatible level change](https://database.guide/how-to-fix-invalid-object-name-openjson-in-sql-server/)

* How to Create a MongoDB Collection Directly from SQL Server
  * https://studio3t.com/knowledge-base/articles/create-mongodb-collection-from-sql-server/

* SQL Server Monitoring tool
  * https://talklowykr.blogspot.com/2020/09/sql-server.html

## Functions

* [CONVERT(MS Official)](https://docs.microsoft.com/ja-jp/sql/t-sql/functions/cast-and-convert-transact-sql?view=sql-server-ver15)

## Replication

* [AWS RDS for sqlserver Replication](https://aws.amazon.com/jp/blogs/news/how-to-migrate-to-amazon-rds-for-sql-server-using-transactional-replication/)
* [AWS RDS for sqlserver Read Replica(Enterprise Edition)](https://docs.aws.amazon.com/ja_jp/AmazonRDS/latest/UserGuide/SQLServer.ReadReplicas.html)




