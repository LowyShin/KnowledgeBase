SQL Server ユーザー作成ツールをPowershellで作成

モジュールのインストール

PowershellスクリプトからSQLサーバーの接続のためSqlServerモジュールを最初1回はインストールが必要です。

```ps1
Install-Module -Name SqlServer
```
Powershellはpowershellスクリプト実行権限を与えてから実行するか管理者権限で実行する必要があります。

## ユーザー作成手順

1. createuser-mssql.xlsx のSheet1に追加したいユーザー情報を追加
2. createuser-mssql.batを実行
3. createuser-mssql.xlsxをバックアップ
4. createuser-mssql.xlsxの機密情報を削除
5. エビデンスとして`YYYYMMDD_<TargetServerInstance>-userlist-<database>-created.csv`ファイルを提出

## ユーザーコピー手順

1. copyuser-mssql.xlsx のSheet1に追加したいユーザー情報を追加
2. copyuser-mssql.batを実行
3. copyuser-mssql.xlsxをバックアップ
4. copyuser-mssql.xlsxの機密情報を削除
5. エビデンスとして`YYYYMMDD_<TargetServerInstance>-userlist-<database>-created.csv`ファイルを提出

## ユーザー削除手順

ユーザー作成手順によって作成されたユーザーを削除するための手順になります。

1. ユーザー作成手順から作成したユーザーを確認
   - 削除対象が異なる場合はcreateuser-mssql.xlsxファイルをバックアップして修正すること
2. deleteuser-mssql.batを実行
3. createuser-mssql.xlsxをバックアップ
4. createuser-mssql.xlsxの機密情報を削除
5. エビデンスとして`YYYYMMDD_<TargetServerInstance>-userlist-<database>-left.csv`ファイルを提出

## 構造

### ユーザーコピープロセス

1. ユーザー作成スクリプト生成
   - genuser-mssql.ps1
2. ターゲットリストをexcelから読み取る
   - copyuser-mssql-gen.ps1
   - 生成されたファイル : copyuser-mssql.bat
3. サーバーに接続しユーザー作成
   - copyuser-mssql.ps1
4. 全体のプロセスを実行するbat
   - copyuser-mssql.bat


## File Structure

### createuser-mssql.bat

1. ExcelファイルのGenシートからcreateuser-mssql-gen.batファイルにコマンドを落とす
2. 作成されたcreateuser-mssql-gen.batを実行する

### createuser-mssql-gen.ps1

ExcelファイルのGenシートからcreateuser-mssql-gen.batファイルにコマンドを落とす

### createuser-mssql.ps1

SQL Serverに接続してユーザー作成クエリを実行する。
