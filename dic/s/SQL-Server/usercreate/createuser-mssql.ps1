#####################################
# Written by Lowy Shin at 20240719  #
#####################################

# Command
# .\Create-SqlUser.ps1 -serverInstance "YOUR_SERVER_INSTANCE" -databaseName "YOUR_DATABASE_NAME" -newUserName "NEW_USER_NAME" -newUserPassword "NEW_USER_PASSWORD" -loginName "NEW_LOGIN_NAME"

param (
    [string]$serverInstance,
    [string]$databaseName,
    [string]$newUserPassword,
    [string]$loginName,
    [string]$adminUserName,
    [string]$adminPassword
)

# 管理者の資格情報を設定
# $securePassword = ConvertTo-SecureString $adminPassword -AsPlainText -Force
# $credential = New-Object System.Management.Automation.PSCredential ($adminUserName, $securePassword)

# 接続文字列を作成
$connectionString = "Server=$serverInstance;Database=$databaseName;User Id=$adminUserName;Password=$adminPassword;TrustServerCertificate=True;"

# SQLコマンド
$createLoginQuery = @"
use master;
CREATE LOGIN [$loginName] WITH PASSWORD = '$newUserPassword';
"@

Write-Output "Logins creation done..."

$createUserQuery = @"
USE [$databaseName];
CREATE USER [$loginName] FOR LOGIN [$loginName] WITH DEFAULT_SCHEMA = [$databaseName];
"@

Write-Output "User creation done..."

$grantPermissionsQuery = @"
USE [$databaseName];
EXEC sp_addrolemember N'db_owner', [$loginName];
"@

Write-Output "Role apply done..."

# SQL Serverに接続してコマンドを実行
Invoke-Sqlcmd -ConnectionString $connectionString -Query $createLoginQuery
Invoke-Sqlcmd -ConnectionString $connectionString -Query $createUserQuery
Invoke-Sqlcmd -ConnectionString $connectionString -Query $grantPermissionsQuery

# Get the current directory
$currentDirectory = Get-Location

# 結果の出力
Invoke-Expression -Command ". ${currentDirectory}\getuser-mssql.ps1  -serverInstance ""${serverInstance}"" -databaseName ""${databaseName}"" -adminUserName ""${adminUserName}"" -adminPassword ""${adminPassword}"" -resultFilename ""${TargetServerInstance}-userlist-${databaseName}-created"" "

Write-Output "=================================="
Write-Output "All user creation process done..."
Write-Output "Check result from YYYYMMDD-createuser-result.csv"
Write-Output "=================================="
