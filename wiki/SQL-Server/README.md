* [Integration Services (SSIS) のインストール](https://docs.microsoft.com/ja-jp/sql/integration-services/install-windows/install-integration-services?view=sql-server-ver15)

* MSDTCを動作させるために必要な設定について
  * https://blogs.technet.microsoft.com/jpiis/2018/02/05/msdtc-settings/

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

### Rank

```sql
SELECT i.ProductID, p.Name, i.LocationID, i.Quantity  
    ,RANK() OVER   
    (PARTITION BY i.LocationID ORDER BY i.Quantity DESC) AS Rank  
FROM Production.ProductInventory AS i   
INNER JOIN Production.Product AS p   
    ON i.ProductID = p.ProductID  
WHERE i.LocationID BETWEEN 3 AND 4  
ORDER BY i.LocationID;  
```
https://docs.microsoft.com/ja-jp/sql/t-sql/functions/rank-transact-sql?view=sql-server-ver16

### Accumulated field

- Monthly accumulated amount
```sql
SELECT A1.Month
      ,A1.Amount
      ,A2.Amount
FROM   WORK_DATA A1
INNER JOIN WORK_DATA A2
ON  A1.Month >= A2.Month
ORDER BY A1.Month
```

## Functions

* `DATEADD(type, interval, sourcedate)`
* `CONVERT(varchar(20), getdate(), 120)` 
  * https://talklowy-jp.blogspot.com/2020/06/sql-server-convert-datetime.html
* [CONVERT(MS Official)](https://docs.microsoft.com/ja-jp/sql/t-sql/functions/cast-and-convert-transact-sql?view=sql-server-ver15)

## Replication

* [AWS RDS for sqlserver Replication](https://aws.amazon.com/jp/blogs/news/how-to-migrate-to-amazon-rds-for-sql-server-using-transactional-replication/)
* [AWS RDS for sqlserver Read Replica(Enterprise Edition)](https://docs.aws.amazon.com/ja_jp/AmazonRDS/latest/UserGuide/SQLServer.ReadReplicas.html)


## Datatype

データ型 | Range | ストレージ
--|--|--
bigint | -2^63 (-9,223,372,036,854,775,808) ～ 2^63-1 (9,223,372,036,854,775,807) | 8 バイト
int | -2^31 (-2,147,483,648) ～ 2^31-1 (2,147,483,647) | 4 バイト
smallint | -2^15 (-32,768) ～ 2^15-1 (32,767) | 2 バイト
tinyint | 0 ～ 255 | 1 バイト

* https://docs.microsoft.com/ja-jp/sql/t-sql/data-types/int-bigint-smallint-and-tinyint-transact-sql?view=sql-server-ver16

- [Amazon RDS for SQL Server でのデータベースメールの使用](https://docs.aws.amazon.com/ja_jp/AmazonRDS/latest/UserGuide/SQLServer.DBMail.html)

- [At time zone](https://learn.microsoft.com/ja-jp/sql/t-sql/queries/at-time-zone-transact-sql?view=sql-server-ver16)
  - Azure SQLの場合UTCが基本になって変更ができないため全てのdatetime形式はAt time zoneを利用して変換しないといけない。
  ```sql
  -- getdate for JST
  select getdate() at time zone 'Tokyo Standard Time'
  -- convert UCT to JST
  select @mydate at time zone 'UTC' at time zone 'Tokyo Standard Time'
  ```
  
  - custom time function
  ```sql
  CREATE FUNCTION [dbo].[fzonetime] 
  (
      @timestr datetime,
      @zonecode varchar(max)
  )
  RETURNS datetime
  AS
  BEGIN

      DECLARE @Result datetime = getdate();
      DECLARE @zonename varchar(max);

      select @zonename = 
          case when @zonecode = 'jp' then 'Tokyo Standard Time'
          else @zonecode
          end ;

      Select @Result = @timestr AT TIME ZONE 'UTC' AT TIME ZONE @zonename;

      RETURN @Result

  END
  GO
  ```

