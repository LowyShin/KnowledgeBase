TiDBにおける**ローカルインデックス**と**グローバルインデックス**の違いは、主にパーティションテーブルでのデータ管理とクエリパフォーマンスに影響します。

---

### **ローカルインデックス (Local Index)**

- **パーティション単位のインデックス**: ローカルインデックスは各パーティションごとに存在し、そのパーティション内のデータのみをカバーします。
- **クエリ時の挙動**: クエリが実行されると、該当するパーティションのインデックスのみが検索されます。
- **パフォーマンスの特性**:
  - **利点**: パーティションキーを含むクエリでは、高速なデータアクセスが可能です。
  - **欠点**: パーティションキーを含まないクエリでは、全パーティションを検索する必要があり、パフォーマンスが低下します。
- **メンテナンス**: インデックスはデータと一緒にパーティション化されるため、管理が比較的容易です。

### **グローバルインデックス (Global Index)**

- **全パーティションを跨ぐインデックス**: グローバルインデックスはすべてのパーティションのデータを統合してカバーします。
- **クエリ時の挙動**: クエリはグローバルインデックスを一度検索するだけで済み、パーティションキーの有無に関わらず効率的にデータを取得できます。
- **パフォーマンスの特性**:
  - **利点**: パーティションキーを含まないクエリでも高速なデータアクセスが可能です。
  - **欠点**: インデックスの更新やメンテナンス時にオーバーヘッドが発生しやすいです。
- **メンテナンス**: インデックスの一貫性を保つための追加の管理が必要で、複雑さが増します。

---

### **選択のポイント**

- **パーティションキーを頻繁に使用する場合**: ローカルインデックスが適しています。
- **パーティションキーを含まないクエリが多い場合**: グローバルインデックスを使用するとパフォーマンスが向上します。
- **データ更新の頻度**: グローバルインデックスは更新コストが高いため、更新が頻繁な場合はローカルインデックスが有利です。

**まとめ**: アプリケーションの特性やクエリパターンに応じて、ローカルインデックスとグローバルインデックスを適切に選択することが重要です。
