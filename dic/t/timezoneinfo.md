- [Azure SQL database time zone info](https://learn.microsoft.com/en-us/sql/relational-databases/system-catalog-views/sys-time-zone-info-transact-sql?view=sql-server-ver16)
  - Azure는 DB에 UTC를 기본으로 저장. Country code등을 바꾸는 기능이 없기 때문에 다음과 같이 표현을 해야 한다. 
  ```sql
  select getdate() at time zone 'Tokyo Standard Time'
  ```
  - 이 경우 zone에 해당하는 스트링이 sql database의 시스템 테이블에 있는데 그 내용을 확인하려면 time_zone_info 테이블을 확인하면 된다. 
    (jp, kr등의 컨트리 코드와 연결이 되어 있지 않은데다가 하나의 지역코드가 광활 하면 여러 타임존을 넘나들어 DB화 하기가 무척 힘들다)
  ```sql
  select * from sys.time_zone_info
  ```
