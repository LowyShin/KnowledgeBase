# SQL Server DataCollection

SQL Server の Data Collection によって収集されたすべてのデータを取得する SQL クエリを作成します。
ただし、Data Collection のデータは複数のテーブルに格納されており、その構造も収集するデータの種類によって異なります。以下に、主な収集セットごとのデータを取得するための SQL クエリを示します。

---

**前提条件:**

- 管理データウェアハウス（Management Data Warehouse, MDW）のデータベース名を `[MDW]` とします。実際の環境では、この名前をご使用のデータベース名に置き換えてください。

---

### **1. ディスク使用量のデータを取得する**

```sql
SELECT *
FROM [MDW].[snapshots].[disk_usage]
ORDER BY snapshot_time DESC;
```

### **2. クエリ統計のデータを取得する**

```sql
SELECT *
FROM [MDW].[snapshots].[query_stats]
ORDER BY end_time DESC;
```

### **3. サーバーアクティビティのデータを取得する**

```sql
SELECT *
FROM [MDW].[snapshots].[server_activity]
ORDER BY collection_time DESC;
```

### **4. CPU 使用率のデータを取得する**

```sql
SELECT *
FROM [MDW].[snapshots].[os_cpu_utilization]
ORDER BY collection_time DESC;
```

### **5. メモリ使用量のデータを取得する**

```sql
SELECT *
FROM [MDW].[snapshots].[os_memory_usage]
ORDER BY collection_time DESC;
```

### **6. ファイル IO のデータを取得する**

```sql
SELECT *
FROM [MDW].[snapshots].[io_usage]
ORDER BY snapshot_time DESC;
```

### **7. すべてのテーブルからデータを取得する**

MDW データベース内のすべてのテーブルからデータを取得するには、以下のスクリプトを使用して各テーブルに対してクエリを実行できます。

```sql
DECLARE @TableName NVARCHAR(256);
DECLARE @SchemaName NVARCHAR(256);
DECLARE @SQL NVARCHAR(MAX);

DECLARE TableCursor CURSOR FOR
SELECT TABLE_SCHEMA, TABLE_NAME
FROM [MDW].INFORMATION_SCHEMA.TABLES
WHERE TABLE_TYPE = 'BASE TABLE';

OPEN TableCursor;
FETCH NEXT FROM TableCursor INTO @SchemaName, @TableName;

WHILE @@FETCH_STATUS = 0
BEGIN
    SET @SQL = 'SELECT * FROM [MDW].[' + @SchemaName + '].[' + @TableName + ']';
    PRINT 'Fetching data from table: ' + @SchemaName + '.' + @TableName;
    EXEC (@SQL);
    FETCH NEXT FROM TableCursor INTO @SchemaName, @TableName;
END;

CLOSE TableCursor;
DEALLOCATE TableCursor;
```

**注意:** このスクリプトは大量のデータを取得する可能性があるため、実行には注意が必要です。

---

### **特定の条件でデータをフィルタリングする例**

データ量が多い場合や特定の期間のデータのみが必要な場合、`WHERE` 句を使用してデータをフィルタリングできます。

```sql
SELECT *
FROM [MDW].[snapshots].[disk_usage]
WHERE snapshot_time BETWEEN '2023-01-01' AND '2023-01-31'
ORDER BY snapshot_time DESC;
```

---

### **テーブルとカラムの一覧を取得する**

MDW データベース内のテーブルとそのカラムを確認するには、以下のクエリを使用できます。

```sql
SELECT TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, DATA_TYPE
FROM [MDW].INFORMATION_SCHEMA.COLUMNS
ORDER BY TABLE_SCHEMA, TABLE_NAME;
```

---

### **注意事項**

- **データベース名の確認:** 実際の MDW データベース名を確認し、クエリ内の `[MDW]` を適切に置き換えてください。
  
- **権限:** データを取得するためには、MDW データベースへの適切なアクセス権限が必要です。

- **パフォーマンスへの影響:** 大量のデータを一度に取得すると、サーバーのパフォーマンスに影響を与える可能性があります。必要に応じて、クエリに条件を追加してデータ量を制限してください。

- **データの古さ:** Data Collection の設定によっては、古いデータが自動的に削除される場合があります。

---

