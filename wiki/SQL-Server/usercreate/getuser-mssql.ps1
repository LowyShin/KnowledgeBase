# SQL Server接続情報
param (
    [string]$serverInstance,
    [string]$databaseName,
    [string]$adminUserName,
    [string]$adminPassword,
    [string]$resultFilename
)

# 接続文字列を作成
$connectionString = "Server=$serverInstance;Database=$databaseName;User Id=$adminUserName;Password=$adminPassword;TrustServerCertificate=True;"

# 現在の日付を取得してフォーマット
$date = Get-Date -Format "yyyyMMdd"

# Get the current directory
$currentDirectory = Get-Location

# Output File
$csvFilePath = "$currentDirectory\${date}_${resultFilename}.csv"

# SQLクエリ
$query = @"
use [$databaseName];
SELECT 
    dp.name AS UserName,
    dp.type_desc AS UserType,
    dp.create_date AS UserCreateDate,
    dp.modify_date AS UserModifyDate,
    pe.permission_name AS PermissionName,
    pe.state_desc AS PermissionState,
    pe.class_desc AS PermissionClass,
    OBJECT_NAME(pe.major_id) AS ObjectName
FROM 
    sys.database_principals dp
LEFT JOIN 
    sys.database_permissions pe ON dp.principal_id = pe.grantee_principal_id
WHERE 
    dp.type IN ('S', 'U', 'G', 'A') -- S: SQL user, U: Windows user, G: Windows group, A: Application role
ORDER BY 
    dp.name;
"@

# SQLクエリを実行して結果を取得
$results = Invoke-Sqlcmd -ConnectionString $connectionString -Query $query

# 結果をCSVファイルにエクスポート
$results | Export-Csv -Path $csvFilePath -NoTypeInformation

Write-Host "Output file : $csvFilePath"
