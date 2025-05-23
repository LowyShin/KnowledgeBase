# tidb_ttl_task

`tidb_ttl_task` テーブルは、TiDB の TTL（Time-To-Live）機能に関する情報を管理するシステムテーブルです。このテーブルには、TTLタスクが実行される際の詳細が記録されており、TTL による自動データ削除を管理するための情報が含まれています。

### `tidb_ttl_task` テーブルに含まれる主な情報

`tidb_ttl_task` テーブルには、以下のような情報が含まれています。

1. **タスクID** - TTLタスクごとに一意のIDが割り当てられています。このIDを使って、個別のタスクを識別します。
   
2. **テーブル情報** - 対象となるテーブルのIDや名前が含まれており、TTL処理が行われるテーブルがどれかを把握できます。

3. **スキャン範囲** - `scan_range_start` や `scan_range_end` などのカラムに、削除するデータのキー範囲がHEX形式で格納されています。
   - `scan_range_start`: スキャンの開始位置（キー）。
   - `scan_range_end`: スキャンの終了位置（キー）。

4. **削除対象の条件や範囲** - TTL で削除する際の条件（例: 作成日が一定期間を超えたデータのみ削除）などが含まれています。

5. **タスクのステータスと進行状況** - 現在のタスクの状態（未開始、実行中、完了など）や進行状況が記録されています。これにより、TTLタスクの処理状況をモニタリングできます。

6. **実行日時やタイムスタンプ** - 各タスクがいつ実行されたかや、次のスケジュールされた実行時間などが含まれています。

### `tidb_ttl_task` のデータの用途

- **データ管理**: 古いデータや特定条件に該当するデータを自動的に削除し、ストレージの効率化を図ります。
- **運用の自動化**: 過去のデータを手動で削除する手間を省き、データ保持ポリシーに基づいた自動削除を実行します。
- **モニタリングとトラブルシューティング**: タスクの進行状況やエラーの把握が可能なため、TTLタスクの監視や障害対応をサポートします。

TTL は、定期的に実行されるタスクで指定条件を満たす古いデータを削除するため、`tidb_ttl_task` の情報を使うことでデータのライフサイクル管理が簡便化されます。

## データの削除

`tidb_ttl_task` テーブルのデータは、TTL（Time-To-Live）タスクが完了した後に自動的に削除されます。具体的には、TTL タスクの完了後に一定期間保持された後、システムによってクリーンアップされます。

### `tidb_ttl_task` のデータ削除の流れ

1. **タスク完了後の一時保持**: TTL タスクが完了すると、その情報はしばらく `tidb_ttl_task` に保持されます。この期間はシステムが定義しており、TTL タスクの状態や履歴を短期間参照できるようにしています。

2. **クリーンアッププロセス**: TiDB の内部プロセスが定期的に `tidb_ttl_task` のエントリをチェックし、完了から一定時間が経過した古いタスク情報を削除します。保持期間はシステム設定に依存しますが、通常は数日から数週間程度です。

3. **エラーハンドリング**: 一部のタスクがエラー状態のまま放置されている場合、エラー情報も一定期間保持されますが、やはり定期的なクリーンアップの対象になります。

### クリーンアップの設定確認と変更

`tidb_ttl_task` に格納されたデータの保持期間は、TiDB の設定ファイルやシステム変数で調整できる場合があります。もし保持期間を変更したい場合は、TiDB の公式ドキュメントやシステム設定で、TTLタスク履歴の保持に関する設定を確認してください。

このように、`tidb_ttl_task` テーブルのデータは、TTLタスク完了後に自動削除される仕組みがあり、通常の運用の中で手動で削除する必要はありません。


通常、`tidb_ttl_task` に残っているデータは TiDB が自動的に管理・削除するため、手動で削除する必要はありません。TiDB は TTL タスクの履歴をシステムの設定に基づいて保持し、一定期間が経過したデータを自動的にクリーンアップします。

### 手動で削除が必要な場合

ただし、特定の状況下で手動削除が必要なケースもあります：

1. **ストレージリソースの逼迫**: `tidb_ttl_task` に大量のタスク履歴が残り、システムのストレージやパフォーマンスに影響が出ている場合、不要なデータを手動で削除することでリソースを確保できます。

2. **システムエラーや障害**: 何らかの原因で `tidb_ttl_task` のデータが適切にクリーンアップされない場合、手動で削除することもあります。これは、TiDB のクリーンアッププロセスが正常に動作していない場合に限られます。

### 手動での削除方法

手動で削除する場合は、以下のクエリで特定のタスク情報を削除できます。ただし、これは慎重に行う必要があり、特に本番環境では必ずバックアップを取ってから実行するようにしましょう。

```sql
DELETE FROM mysql.tidb_ttl_task
WHERE task_id = '対象のタスクID';
```

あるいは、一定期間前に完了した古いタスクをまとめて削除する場合は、完了日時（例えば `finished_at` カラム）を条件に指定します。

```sql
DELETE FROM mysql.tidb_ttl_task
WHERE finished_at < NOW() - INTERVAL 30 DAY;
```

このように手動で削除することで、特定の要件や問題に対応できますが、基本的には TiDB が自動的にクリーンアップするため、通常の運用では削除する必要はありません。


`tidb_ttl_task` テーブルに残っているデータのうち、特定の情報を削除することで、システムの正常な動作に影響を与える可能性があるデータがあります。以下は、削除を避けるべき、削除すると危険なデータです。

### 削除を避けるべきデータ

1. **未完了のTTLタスク**:
   - `tidb_ttl_task` に「実行中」や「待機中」などの未完了タスクが残っている場合、それを削除すると、対象のテーブルでデータの自動削除が中断される可能性があります。
   - 例えば、`status` カラムが「running」や「pending」となっているタスクは、まだ実行中であるか、実行を待機しているため、削除は避けるべきです。

2. **エラーステータスのタスク**:
   - 一部のタスクが「エラー状態」で停止している場合も、削除せずに残しておくのが一般的です。これらのタスクは何らかの理由でエラーが発生しているため、再試行やトラブルシューティングのために必要です。
   - `status` カラムが「error」となっているタスクは、問題が解決されるまで残しておくことが推奨されます。

3. **タスク履歴が必要なデータ**:
   - 特定の監査やデータ保持ポリシー上、TTLタスクの実行履歴が求められる場合があります。例えば、内部監査やデータ削除の記録を保持する必要がある場合には、`finished_at` のタイムスタンプがある程度最近のタスク履歴は削除しない方が良いでしょう。

### 削除しても安全なデータ

一方で、以下のようなデータは削除しても比較的安全です：

- **完了済みで、かつ一定期間経過したタスク**: 
  - `status` カラムが「finished」や「succeeded」などの完了状態で、`finished_at` カラムの日時がかなり前のもの（例: 数か月以上前のもの）であれば、システムの動作に影響はありません。

### 削除時の注意点

手動で `tidb_ttl_task` のデータを削除する際は、まずバックアップを取ることを推奨します。また、できるだけ `status` カラムや `finished_at` のような時間条件で古いタスクを削除するなど、影響範囲を限定するようにしてください。

削除が適切であるか不明な場合は、削除前にシステムの動作状況や関連するタスクの影響範囲を確認し、必要に応じて TiDB の公式ドキュメントやサポートに問い合わせると安心です。


## wating status

`tidb_ttl_task` テーブルの `status` が `waiting` の場合、そのタスクは「実行待ち」の状態を意味します。具体的には、TTL タスクがスケジュールされているものの、まだ実行開始の条件を満たしていないため、キューに待機している状態です。

### `waiting` 状態の特徴

1. **実行待機中**:
   - `waiting` 状態のタスクは、スケジュールはされているが、まだ実行が開始されていません。
   - この状態では、条件（通常は開始時刻やリソース状況）を満たすのを待っている状態です。

2. **リソース不足や他のタスク待ち**:
   - `waiting` 状態は、システムがリソースの都合などにより他のタスクが完了するのを待っている場合もあります。たとえば、並列に実行できる TTL タスクの数に制限がある場合、他のタスクが完了するまで待機します。

3. **指定のスケジュールまで待機**:
   - `waiting` 状態は、タスクが開始する時刻（例えば、夜間に実行するように設定）を待っている場合にも表示されます。

### `waiting` 状態のタスクの扱い

- 通常、`waiting` 状態のタスクはシステムが自動的に管理するため、手動での操作や削除は不要です。
- ただし、`waiting` 状態が長時間続く場合、システムのリソースや設定を確認し、TTLタスクが実行されるべき条件が満たされているか確認するとよいでしょう。

このように、`waiting` 状態は、TTL タスクがスケジュールの都合やシステムのリソース待ちで一時的に保留されている状態を示します。

