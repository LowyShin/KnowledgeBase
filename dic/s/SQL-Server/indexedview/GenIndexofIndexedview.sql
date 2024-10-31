DECLARE @sql NVARCHAR(MAX) = N'';
DECLARE @crlf NCHAR(2) = NCHAR(13) + NCHAR(10);

-- クエリでメタデータを取得して、動的SQLを生成
create table #zIndexCreate (sqltext nvarchar(max))

SELECT @sql = @sql + 
    'CREATE ' +
    CASE WHEN i.is_unique = 1 THEN 'UNIQUE ' ELSE '' END +
    i.type_desc + ' INDEX ' + QUOTENAME(i.name) + @crlf +
    'ON ' + QUOTENAME(SCHEMA_NAME(o.schema_id)) + '.' + QUOTENAME(o.name) + ' (' +
    (
        SELECT STRING_AGG_PARTS = STUFF((SELECT ', ' + QUOTENAME(c.name) + 
        CASE WHEN ic.is_descending_key = 1 THEN ' DESC' ELSE ' ASC' END
        FROM sys.index_columns ic
        INNER JOIN sys.columns c ON ic.object_id = c.object_id AND ic.column_id = c.column_id
        WHERE ic.object_id = i.object_id AND ic.index_id = i.index_id AND ic.is_included_column = 0
        ORDER BY ic.key_ordinal
        FOR XML PATH(''), TYPE).value('.', 'NVARCHAR(MAX)'), 1, 2, '')
    ) + ')' + @crlf +
    CASE WHEN EXISTS(SELECT 1 FROM sys.index_columns ic WHERE ic.object_id = i.object_id AND ic.index_id = i.index_id AND ic.is_included_column = 1)
        THEN 'INCLUDE (' + 
        STUFF((SELECT ', ' + QUOTENAME(c.name)
        FROM sys.index_columns ic
        INNER JOIN sys.columns c ON ic.object_id = c.object_id AND ic.column_id = c.column_id
        WHERE ic.object_id = i.object_id AND ic.index_id = i.index_id AND ic.is_included_column = 1
        FOR XML PATH(''), TYPE).value('.', 'NVARCHAR(MAX)'), 1, 2, '') + ')' + @crlf
        ELSE ''
    END +
    'ON ' + QUOTENAME(ds.name) + ';' + @crlf + @crlf
FROM 
    sys.views v
INNER JOIN 
    sys.indexes i ON v.object_id = i.object_id
INNER JOIN 
    sys.objects o ON i.object_id = o.object_id
INNER JOIN 
    sys.data_spaces ds ON i.data_space_id = ds.data_space_id
WHERE 
    v.is_ms_shipped = 0;

-- 出力
insert into #zIndexCreate
values (@sql);

select * from #zIndexCreate
-- 必要に応じて結果を実行する場合は以下の行のコメントを解除
-- EXEC sp_executesql @sql;
drop table #zIndexCreate;


