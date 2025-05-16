# IPアドレス・マシン名・ログイン名を許可リストテーブルで管理し、LOGON トリガーでチェックして許容するかどうかを判定

---

## ✅ 全体構成の概要

1. **許可リスト用テーブル**を作成（IP・マシン名・ログイン名で許可を管理）
2. **ログ記録テーブル**を作成（ログ試行を記録）
3. **ログイントリガー**を作成して、上記許可リストにマッチしない場合は `ROLLBACK`

---

## ✅ ① 許可リストテーブルの作成

```sql
USE [YourDBName]; -- ログ・許可情報管理用のDB

CREATE TABLE dbo.LoginAllowList (
    LoginName    SYSNAME NOT NULL,
    ClientIP     NVARCHAR(48) NULL,
    ClientHost   NVARCHAR(100) NULL,
    CONSTRAINT PK_LoginAllowList PRIMARY KEY (LoginName, ClientIP, ClientHost)
);
```

* `ClientIP` や `ClientHost` は `NULL` にすることで「全IP・全マシン許可」の意味にも使えます。

#### 例: 登録データ

| LoginName | ClientIP     | ClientHost |
| --------- | ------------ | ---------- |
| sa        | 192.168.1.10 | NULL       |
| app\_user | NULL         | APP01-PC   |
| admin     | 10.0.0.5     | ADMIN-PC   |

---

## ✅ ② ログ記録テーブルの作成

```sql
CREATE TABLE dbo.LoginAttemptLog (
    LogTime       DATETIME DEFAULT GETDATE(),
    LoginName     SYSNAME,
    ClientHost    NVARCHAR(100),
    Application   NVARCHAR(200),
    ProgramName   NVARCHAR(200),
    ClientIP      NVARCHAR(48),
    IsBlocked     BIT
);
```

---

## ✅ ③ トリガーの作成（許可リスト参照）

```sql
CREATE TRIGGER trg_check_login_permissions
ON ALL SERVER
FOR LOGON
AS
BEGIN
    DECLARE @client_ip NVARCHAR(48) = EVENTDATA().value('(/EVENT_INSTANCE/ClientHost)[1]', 'NVARCHAR(48)');
    DECLARE @login_name SYSNAME = ORIGINAL_LOGIN();
    DECLARE @client_host NVARCHAR(100) = HOST_NAME();
    DECLARE @program_name NVARCHAR(200) = APP_NAME();
    DECLARE @is_blocked BIT = 1; -- デフォルトはブロック

    -- 許可リストチェック
    IF EXISTS (
        SELECT 1
        FROM [YourDBName].dbo.LoginAllowList
        WHERE LoginName = @login_name
          AND (ClientIP IS NULL OR ClientIP = @client_ip)
          AND (ClientHost IS NULL OR ClientHost = @client_host)
    )
    BEGIN
        SET @is_blocked = 0; -- 許可
    END

    -- ログ記録
    BEGIN TRY
        INSERT INTO [YourDBName].dbo.LoginAttemptLog
            (LoginName, ClientHost, Application, ProgramName, ClientIP, IsBlocked)
        VALUES
            (@login_name, @client_host, @program_name, @program_name, @client_ip, @is_blocked);
    END TRY
    BEGIN CATCH
        -- ログ失敗時は握りつぶし
    END CATCH

    -- ブロック処理
    IF @is_blocked = 1
    BEGIN
        ROLLBACK;
    END
END;
```

---

## ✅ 使い方・運用例

* `dbo.LoginAllowList` に必要なログイン名とIP/マシン名を登録すれば接続可能
* 不正なログイン試行は `dbo.LoginAttemptLog` に記録され、接続は拒否される

---

## 🔐 補足・注意点

| 注意項目                                                                      | 内容 |
| ------------------------------------------------------------------------- | -- |
| 自分のIPが許可されていないと接続不能になります。最初は `ClientIP IS NULL` で全許可状態でテストをおすすめ           |    |
| `YourDBName` は `master` や運用監視用のDB名などに変更してください                             |    |
| `EVENTDATA().value('...')` はログイントリガー固有。使える項目は限られます（IPはやや不安定なので補完が必要なケースも） |    |

---

