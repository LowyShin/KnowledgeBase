# AWS의 RDF for SQL Server운영 중 index재작성이 필요한가?

AWS공식 : https://repost.aws/ja/knowledge-center/rds-sql-server-create-maintenance-tasks

## 인덱스 단편화 체크

RDS for SQL Server で **インデックス再編成（または再構築）が必要かどうかを確認する方法**は、以下のように `sys.dm_db_index_physical_stats` ビューを使って **フラグメント率（fragmentation）** を取得するのが一般的です。

---

## ✅ 確認手順（T-SQL）

```sql
SELECT
    OBJECT_NAME(i.[object_id]) AS TableName,
    i.name AS IndexName,
    i.index_id,
    ps.avg_fragmentation_in_percent,
    ps.page_count
FROM sys.dm_db_index_physical_stats (
        DB_ID(),      -- 現在のDB
        NULL,         -- すべてのテーブル対象
        NULL,         -- すべてのインデックス
        NULL,         -- すべてのパーティション
        'LIMITED'     -- パフォーマンス優先モード（DETAILEDは重い）
) AS ps
JOIN sys.indexes AS i
    ON ps.[object_id] = i.[object_id]
    AND ps.index_id = i.index_id
WHERE i.index_id > 0  -- ヒープ（クラスタなし）は除外
  AND ps.page_count > 100  -- ページ数が少ないものは除外（任意）
ORDER BY ps.avg_fragmentation_in_percent DESC;
```

---

## 📊 フラグメント率の目安

| フラグメント率   | 対応方法                                |
| --------- | ----------------------------------- |
| 0〜5%      | 何もしなくてOK                            |
| **5〜30%** | `ALTER INDEX ... REORGANIZE`（再編成）推奨 |
| **30%以上** | `ALTER INDEX ... REBUILD`（再構築）推奨    |

> ※ `page_count`（ページ数）が少ないインデックスはパフォーマンスへの影響が少ないため、無視してもOKです（例：100ページ未満）

---

## 🛠 オプション：対象のインデックスだけ表示するクエリ

```sql
-- 再編成 or 再構築が必要なインデックスのみ表示
SELECT
    OBJECT_NAME(i.[object_id]) AS TableName,
    i.name AS IndexName,
    ps.avg_fragmentation_in_percent,
    CASE
        WHEN ps.avg_fragmentation_in_percent BETWEEN 5 AND 30 THEN 'REORGANIZE'
        WHEN ps.avg_fragmentation_in_percent > 30 THEN 'REBUILD'
        ELSE 'OK'
    END AS Action,
    ps.page_count
FROM sys.dm_db_index_physical_stats(DB_ID(), NULL, NULL, NULL, 'LIMITED') ps
JOIN sys.indexes i
    ON ps.[object_id] = i.[object_id]
    AND ps.index_id = i.index_id
WHERE i.index_id > 0 AND ps.page_count > 100
  AND ps.avg_fragmentation_in_percent > 5
ORDER BY ps.avg_fragmentation_in_percent DESC;
```

---

## 📝 注意点（RDS特有）

* `sys.dm_db_index_physical_stats` は **RDSでも利用可能**です。
* `LIMITED` モードなら軽量で、プロダクション環境でも比較的安全に使えます。
* SQL Server Agent を使って、定期的にこのチェックと再編成を自動化するのが理想です。

---


いい質問です。

### ❓AWS RDS for SQL Server はインデックスの再編成・再構築を **自動でやってくれるのか？**

→ **答え：** *いいえ、**自動ではやってくれません**。*

---

### 🔍 詳細解説

#### 🔸 RDSの自動メンテナンス（AWSがやってくれる範囲）

AWSは以下のようなメンテナンスを「自動」で実行することはありますが、**インデックスの再編成・再構築は含まれていません**：

| 自動実行                 | 内容                |
| -------------------- | ----------------- |
| ✅ OSパッチ適用            | セキュリティ更新など        |
| ✅ DBエンジンのマイナーアップグレード | メンテナンスウィンドウ中に実施可能 |
| ✅ バックアップ             | 自動スナップショット作成      |
| ❌ インデックス再編成／再構築      | **やってくれない**       |

---

### 🔧 つまりどうすればいいか？

RDS上でも**ユーザー側でインデックスメンテナンスを自動化する**必要があります。

#### 方法1：SQL Server Agent（RDSで有効化可能）でスケジュールジョブ

* `ALTER INDEX ... REORGANIZE` や `REBUILD` を使うT-SQLスクリプトをジョブ化
* 毎晩や週次などにスケジュール

#### 方法2：PowerShellやLambda + SSMなどで外部から制御（高度）

---

### 🧩 参考：SQL Server Agent の有効化方法（RDS）

1. RDSインスタンスに接続
2. 以下のクエリで有効化確認

```sql
EXEC msdb.dbo.rds_ms_agent_task_status;
```

3. 必要に応じて以下のようにジョブを作成

```sql
EXEC msdb.dbo.sp_add_job ...
```

---

### ✅ 結論まとめ

| 項目              | 内容                                |
| --------------- | --------------------------------- |
| 自動化されている？       | ❌ インデックス再編成・再構築は自動では実行されない        |
| 代替手段            | ✅ SQL Server Agentで定期ジョブを設定する必要あり |
| AWSの自動メンテナンス対象？ | ❌ 含まれていない                         |

---

