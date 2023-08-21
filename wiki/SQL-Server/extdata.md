# 외부 데이터 엑세스

SQL Server에서도 파일들을 형식을 맞추어 외부 데이터로 사용할 수 있다. 

```sql
select * 
from openrowset(bulk 'https://giipteststr.blob.core.windows.net/numbers/20230821/0.txt'
--	DATA_SOURCE = 'SqlOnDemandDemo',
	, SINGLE_BLOB
--	format = 'CSV', 
--	FIELDTERMINATOR = ',',
--	ROWTERMINATOR = '\n',
--	firstrow = 1
	) 
	as rows
--
```
여러가지 옵션들을 주석처리를 했다가 풀었다가 해봤는데 결국 `Operating system error code 997(Overlapped I/O operation is in progress.).` 에러가 나서 포기. 
파일 위치를 로컬 피씨에서 하면 997 에러가 나고, Storage Account에 올려서 공유를 다 풀어서 해도 `Operating system error code (null).`
발생.. 

전부 포기하고 
Storage Account에 올린 파일을 External Data Source로 세팅. 

데이터가 보안이 필요한 경우는 Credential설정을 해야 하는데, 이번 데이터는 크롤한 데이터이기 때문에 이미 인터넷에 있어서 보안설정 무시함. 

```sql
-- 외부 데이터 소스로 한 번만 설정. 아래 CREDENTIAL이 필요 없어서 주석처리함.
CREATE EXTERNAL DATA SOURCE giipstrtest01
WITH ( TYPE = BLOB_STORAGE,
          LOCATION = 'https://giipstrtest01.blob.core.windows.net'
--          , CREDENTIAL= sampleblobcred1
);

-- 데이터를 내가 원하는 테이블에 집어 넣는 SQL
-- Azure의 날짜 표기는 getdate()를 하면 UTC에서 변경 불가능하여 JST로 가져오는 함수를 따로 만듬. dbo.fgetJST()
insert into tRawData(rdRegdt, rdData)
select dbo.fgetJST(), convert(varchar(max), BulkColumn)
FROM OPENROWSET( 
BULK 'numbers/20230821/0.txt',
DATA_SOURCE = 'giipstrtest01', SINGLE_BLOB) AS rdData

```
