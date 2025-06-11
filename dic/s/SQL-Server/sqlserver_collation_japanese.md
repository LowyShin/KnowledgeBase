`Japanese_XJIS_140_CI_AS_UTF8` と `Japanese_UNICODE_CI_AS` はどちらも日本語向けの照合順序ですが、**目的やエンコーディング、互換性、性能**が異なります。以下に詳しく比較します。

---

### 🆚 比較表：`Japanese_XJIS_140_CI_AS_UTF8` vs `Japanese_UNICODE_CI_AS`

| 項目               | `Japanese_XJIS_140_CI_AS_UTF8`             | `Japanese_UNICODE_CI_AS`      |
| ---------------- | ------------------------------------------ | ----------------------------- |
| **導入バージョン**      | SQL Server 2019 以降                         | SQL Server 2005 以降（もっと前からあり）  |
| **エンコーディング**     | UTF-8（可変長）                                 | UTF-16（固定長）                   |
| **ベース言語**        | Shift\_JIS（XJIS）                           | Unicode                       |
| **照合順序名に含まれる意味** | `XJIS_140` → 日本のJIS X 0213:2004に基づく照合順     | Unicode標準ベースで照合               |
| **文字セットの柔軟性**    | 高い（ASCII、Emoji、マルチリンガル対応）                  | 高いが UTF-16前提なのでDB設計に制約あり      |
| **データ型**         | `VARCHAR`, `CHAR`（UTF-8使用可）                | `NVARCHAR`, `NCHAR`（UTF-16固定） |
| **互換性**          | Shift\_JISに近いためレガシーシステムとの互換性が高い            | Unicodeアプリと広く互換性あり            |
| **ストレージ効率**      | UTF-8によりASCIIは省スペース、日本語は中程度                | UTF-16により全て2バイト以上で固定的に重い傾向    |
| **RDSでの使用可否**    | SQL Server 2019以降でサポート（RDSインスタンスのバージョンに注意） | 広く利用可能（特に制限なし）                |

---

### ✅ どちらを選ぶべきか？

| 使用目的                                           | 推奨照合順序                                          |
| ---------------------------------------------- | ----------------------------------------------- |
| レガシーなShift\_JIS互換が必要                           | `Japanese_XJIS_140_CI_AS_UTF8`                  |
| アプリが `NVARCHAR`/`NCHAR` を使用しており、Unicodeで統一している | `Japanese_UNICODE_CI_AS`                        |
| テーブルサイズを小さくしたい（英数字中心）                          | `Japanese_XJIS_140_CI_AS_UTF8`（UTF-8の方が圧縮効率が良い） |
| 既存のSQL Serverベースの業務システムをそのまま利用                 | `Japanese_UNICODE_CI_AS` の方が安全                  |

---

### 🔎 参考：UTF-8が有効なデータ型の確認

```sql
SELECT name, collation_name
FROM sys.columns
WHERE collation_name LIKE '%UTF8%'
```

---
