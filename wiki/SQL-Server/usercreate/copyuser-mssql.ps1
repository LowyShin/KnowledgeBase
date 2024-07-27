#####################################
# Written by Lowy Shin at 20240726  #
#####################################

# Command
# .\Create-SqlUser.ps1 -serverInstance "YOUR_SERVER_INSTANCE" -databaseName "YOUR_DATABASE_NAME" -newUserName "NEW_USER_NAME" -newUserPassword "NEW_USER_PASSWORD" -loginName "NEW_LOGIN_NAME"

param (
    [string]$SourceServerInstance,
    [string]$TargetServerInstance,
    [string]$databaseName,
    [string]$roleName,
    [string]$loginName,
    [string]$adminUserName,
    [string]$adminPassword
)

# 管理者の資格情報を設定
# $securePassword = ConvertTo-SecureString $adminPassword -AsPlainText -Force
# $credential = New-Object System.Management.Automation.PSCredential ($adminUserName, $securePassword)

# Get the current directory
$currentDirectory = Get-Location

# Gen sql
Invoke-Expression -Command ". ${currentDirectory}\genuser-mssql.ps1  -serverInstance ""${SourceServerInstance}"" -databaseName ""${databaseName}"" -adminUserName ""${adminUserName}"" -adminPassword ""${adminPassword}"" -loginName ""${loginName}"" "

Write-Output "Invoke genuser-mssql.ps1"
Write-Output "-serverInstance : ${SourceServerInstance}"
Write-Output "-databaseName : ${databaseName}"
Write-Output "-adminUserName : ${adminUserName}"
Write-Output "-adminPassword : ${adminPassword}"
Write-Output "-loginName : ${loginName}"

# SQLファイルのパスを指定します
$sqlFilePath = "$currentDirectory\oopyuser-mssql-createuser.sql"

# SQLファイルの内容を読み取ります
#$sqlContent = Get-Content -Path $sqlFilePath -Raw
$sqlContent = Get-Content -Path $sqlFilePath
$createLoginQuery = $sqlContent[3..($sqlContent.Length - 1)] -join "`n"
$createLoginQuery = $createLoginQuery -replace '"', ""
Write-Output "createLoginQuery : $createLoginQuery"

# 接続文字列を作成
$connectionString = "Server=$TargetServerInstance;Database=$databaseName;User Id=$adminUserName;Password=$adminPassword;TrustServerCertificate=True;"

$createUserQuery = @"
USE [$databaseName];
CREATE USER [$loginName] FOR LOGIN [$loginName] WITH DEFAULT_SCHEMA = [$databaseName];
"@

$grantPermissionsQuery = @"
USE [$databaseName];
EXEC sp_addrolemember N'db_owner', [$loginName];
"@

# SQL Serverに接続してコマンドを実行
Invoke-Sqlcmd -ConnectionString $connectionString -Query $createLoginQuery
Write-Output "Logins creation done..."
Invoke-Sqlcmd -ConnectionString $connectionString -Query $createUserQuery
Write-Output "User creation done..."
Invoke-Sqlcmd -ConnectionString $connectionString -Query $grantPermissionsQuery
Write-Output "Role apply done..."

# Get the current directory
$currentDirectory = Get-Location

# 結果の出力
Invoke-Expression -Command ". ${currentDirectory}\getuser-mssql.ps1  -serverInstance ""${TargetServerInstance}"" -databaseName ""${databaseName}"" -adminUserName ""${adminUserName}"" -adminPassword ""${adminPassword}"" -resultFilename ""${TargetServerInstance}-userlist-${databaseName}-created"" "

Write-Output "=================================="
Write-Output "All user creation process done..."
Write-Output "Check result from YYYYMMDD-createuser-result.csv"
Write-Output "=================================="
