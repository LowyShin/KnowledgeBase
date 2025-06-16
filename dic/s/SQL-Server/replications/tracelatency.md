```sql
-- 1. トレーサートークンを挿入
EXEC sp_posttracertoken @publication = N'cosme_trans_base_001';
⇒ tokenを登録するだけなのでデータはないため負荷の影響なし。

-- 2. トークンの一覧を取得（最新の token_id を確認）
EXEC sp_helptracertokens @publication = N'cosme_trans_base_001';
⇒ 最終入力したトークン情報の取得

/*出力例
-2147483647 2025-06-16 14:07:51.213
*/

-- 3. token_id を指定して到達時間を取得
EXEC sp_helptracertokenhistory @publication = N'cosme_trans_base_001', @tracer_id = -2147483647;
```
