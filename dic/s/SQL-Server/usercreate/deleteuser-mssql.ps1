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

# Kill connections
# 特定のユーザーのコネクションを取得
$query = @"
SELECT session_id 
FROM sys.dm_exec_sessions 
WHERE login_name = '$loginName'
"@

$sessions = Invoke-Sqlcmd -ConnectionString $connectionString -Query $query

# コネクションを切断
foreach ($session in $sessions) {
    $sessionId = $session.session_id
    $killQuery = "KILL $sessionId"
    Invoke-Sqlcmd -ConnectionString $connectionString -Query $killQuery
    Write-Output "Session ID $sessionId has been killed."
}

# Remove from database;
$removePermissionsScript = @"
use [$databaseName];
DROP LOGIN [$loginName]
"@

Invoke-Sqlcmd -ConnectionString $connectionString -Query $removePermissionsScript
Write-Output "remove database user done..."

# ユーザーを削除する
$dropUserScript = "DROP USER [$loginName];"
Write-Output "drop user done..."

# SQL Serverに接続してコマンドを実行
Invoke-Sqlcmd -ConnectionString $connectionString -Query $dropUserScript

# Get the current directory
$currentDirectory = Get-Location

# 結果の出力
Invoke-Expression -Command ". ${currentDirectory}\getuser-mssql.ps1  -serverInstance ""${serverInstance}"" -databaseName ""${databaseName}"" -adminUserName ""${adminUserName}"" -adminPassword ""${adminPassword}"" -resultFilename ""${TargetServerInstance}-userlist-${databaseName}-left"" "

Write-Output "=================================="
Write-Output "All user deletion process done..."
Write-Output "=================================="
