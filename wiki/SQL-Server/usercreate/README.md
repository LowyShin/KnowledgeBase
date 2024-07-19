SQL Server ユーザー作成ツールをPowershellで作成

モジュールのインストール

```ps1
Install-Module -Name SqlServer
```

## 環境設定

### 管理者情報登録

- [createuser-mssql.ps1](./createuser-mssql.ps1)
```ps1
# 管理者の資格情報を設定
$adminUserName = ""
$adminPassword = ""
```

## ユーザー作成手順

1. createuser-mssql.xlsx のSheet1に追加したいユーザー情報を追加
2. createuser-mssql.batを実行

## File Structure

### createuser-mssql.bat

1. ExcelファイルのGenシートからcreateuser-mssql-gen.batファイルにコマンドを落とす
2. 作成されたcreateuser-mssql-gen.batを実行する

### createuser-mssql-gen.ps1

ExcelファイルのGenシートからcreateuser-mssql-gen.batファイルにコマンドを落とす

### createuser-mssql.ps1

SQL Serverに接続してユーザー作成クエリを実行する。
