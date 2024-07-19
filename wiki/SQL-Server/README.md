# SQL Server & Azure SQL Server

## Install & Configuration

* [Integration Services (SSIS) のインストール](https://docs.microsoft.com/ja-jp/sql/integration-services/install-windows/install-integration-services?view=sql-server-ver15)

* MSDTCを動作させるために必要な設定について
  * https://blogs.technet.microsoft.com/jpiis/2018/02/05/msdtc-settings/

## User

- Add user for azure database
```sql
-- create server logins
use master
CREATE LOGIN mydbo
	WITH 
		PASSWORD = 'PWPWPWPWPW'
GO

-- create db logins
use my_db
CREATE USER mydbo
	FOR LOGIN mydbo
	WITH DEFAULT_SCHEMA = my_db
GO

-- Add user to the database owner role
EXEC sp_addrolemember N'db_owner', N'mydbo'
GO
```

- [create user script](usercreate)
  - for mass server and user management by excel

## JSON_QUERY and JSON_VALUE

https://github.com/LowyShin/KnowledgeBase/blob/master/wiki/SQL-Server/JSON_QUERY.md

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

### Select from SP

```sql
declare @myVal nvarchar(100)
Declare @T Table (LeftPoint int, LeftBonus int, pchPoint int, pchBonus int, pchPointUsed int, pchBonusUsed int)
Insert @T Exec pAStatPoint
Select @myVal = LeftPoint from @T

select @myVal as LeftPoint
```

## External Data

- [외부 데이터 엑세스(using External Data Source)](https://github.com/LowyShin/KnowledgeBase/blob/master/wiki/SQL-Server/extdata.md)

## Indexed View

- [Generate Index from Indexed View](https://github.com/LowyShin/KnowledgeBase/blob/master/wiki/SQL-Server/indexedview/GenIndexofIndexedview.sql)

## Management

### Table Allocate

```sql
create procedure pASysTableAllocate
as
select schema_name(tab.schema_id) + '.' + tab.name as [table],
    cast(sum(spc.used_pages * 8)/1024.00 as numeric(36, 2)) as used_mb,
    cast(sum(spc.total_pages * 8)/1024.00 as numeric(36, 2)) as allocated_mb
from sys.tables tab
    inner join sys.indexes ind 
        on tab.object_id = ind.object_id
    inner join sys.partitions part 
        on ind.object_id = part.object_id and ind.index_id = part.index_id
    inner join sys.allocation_units spc
        on part.partition_id = spc.container_id
group by schema_name(tab.schema_id) + '.' + tab.name
order by sum(spc.used_pages) desc

```

## Functions

* `DATEADD(type, interval, sourcedate)`
* `CONVERT(varchar(20), getdate(), 120)` 
  * https://talklowy-jp.blogspot.com/2020/06/sql-server-convert-datetime.html
* [CONVERT(MS Official)](https://docs.microsoft.com/ja-jp/sql/t-sql/functions/cast-and-convert-transact-sql?view=sql-server-ver15)

## Replication

* [AWS RDS for sqlserver Replication](https://aws.amazon.com/jp/blogs/news/how-to-migrate-to-amazon-rds-for-sql-server-using-transactional-replication/)
* [AWS RDS for sqlserver Read Replica(Enterprise Edition)](https://docs.aws.amazon.com/ja_jp/AmazonRDS/latest/UserGuide/SQLServer.ReadReplicas.html)

## Updates

`update <tablename> with (rowlock)` を使うとUpdate対象行だけロックがかかる。
しかし、updateの量が全体の1/10を超えてしまうとTable Lockになるので注意が必要。

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

### date

```sql
SELECT DATEPART(WEEKDAY,GETDATE())
---------------------------
  1
```

```sql
SELECT DATENAME(WEEKDAY, GETDATE()) 
---------------------------
Monday
```

### geography

sql server에는 geography 라는 속성의 컬럼이 생겼습니다. (언제부터인지...)

그걸 이용하면 특정 지점에서 가장 가까운 순으로 소팅된 데이터를 부를 수 있지요. 

```sql
DECLARE @InputLatitude FLOAT = 40.7128; -- 입력 지점의 위도
DECLARE @InputLongitude FLOAT = -74.0060; -- 입력 지점의 경도

SELECT TOP 50 *
FROM YourTableName
ORDER BY geographyColumn.STDistance(geography::Point(@InputLatitude, @InputLongitude, 4326)) ASC;
```

만약 당신 주변의 가장 가까운 사람들 리스트를 얻고 싶다면 이렇게 하시면 됩니다. 
그런데 데이터를 넣을때는? 

```sql
create table tUser(
uSn bigint identity(1, 1),
uUid nvarchar(200),
uLoc geography, 
uLocText nvarchar(200)
)
```

이렇게 테이블을 만들었다 칩시다. 
위도 경도를 받아서 uLocText에 위도 경도를 넣고, uLoc 에는 geography값을 넣는다면, 

```sql
declare @uLocText nvarchar(200), @uSn bigint

set @uLocText = '40.7128, -74.0060'
set @uSn = 1

UPDATE tUser
SET uLoc= geography::Point(CAST(SUBSTRING(@uLocText, 1, CHARINDEX(',', @uLocText) - 1) AS FLOAT), 
         CAST(SUBSTRING(@uLocText, CHARINDEX(',', @uLocText) + 1, LEN(@uLocText)) AS FLOAT), 
         4326)
    , uLocText = @uLocText
where uSn = @uSn

```

가 되는 것이지요. 
실제로 uLoc 값에는 hex코드가 들어있어서 확인이 어려우니 위도 경도에 대한 텍스트를 따로 가지고 있으면 활용하기가 쉬워 집니다. 


giip :: Control all Robots and Devices! Free inter-RPA orchestration tool! https://giipasp.azurewebsites.net/

