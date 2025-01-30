DECLARE @TableName NVARCHAR(128) = '찾고자하는테이블명';

DECLARE @SQL NVARCHAR(MAX) = '';
DECLARE @DBName NVARCHAR(128);

CREATE TABLE #Results (DatabaseName NVARCHAR(128));

DECLARE db_cursor CURSOR FOR
SELECT name FROM sys.databases WHERE state_desc = 'ONLINE';

OPEN db_cursor;

FETCH NEXT FROM db_cursor INTO @DBName;

WHILE @@FETCH_STATUS = 0
BEGIN
    SET @SQL = 'IF EXISTS (SELECT 1 FROM [' + @DBName + '].sys.tables WHERE name = ''' + @TableName + ''')
                INSERT INTO #Results SELECT ''' + @DBName + '''';

    EXEC sp_executesql @SQL;

    FETCH NEXT FROM db_cursor INTO @DBName;
END;

CLOSE db_cursor;
DEALLOCATE db_cursor;

SELECT * FROM #Results;

DROP TABLE #Results;
