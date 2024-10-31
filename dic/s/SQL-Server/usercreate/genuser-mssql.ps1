# SQL Server接続情報
param (
    [string]$serverInstance,
    [string]$databaseName,
    [string]$adminUserName,
    [string]$adminPassword,
    [string]$loginName
)

# 接続文字列を作成
$connectionString = "Server=$serverInstance;Database=$databaseName;User Id=$adminUserName;Password=$adminPassword;TrustServerCertificate=True;"
# Write-Host "connectionString : $connectionString"

# 現在の日付を取得してフォーマット
$date = Get-Date -Format "yyyyMMdd"

# Get the current directory
$currentDirectory = Get-Location

# Output File
$csvFilePath = "$currentDirectory\oopyuser-mssql-createuser.sql"

# SQLクエリ
$query = @"
use master;
exec sp_help_revlogin '${loginName}'
"@

# Write-Host "query : $query"

# SQLクエリを実行して結果を取得
$results = Invoke-Sqlcmd -ConnectionString $connectionString -Query $query

# 結果をCSVファイルにエクスポート
$results | Export-Csv -Path $csvFilePath -NoTypeInformation

#$csvContent = $results | ForEach-Object {
#    $_.PSObject.Properties.Value -join ','
#}

#Write-Host "csvContent : $csvContent"


#$csvContent | Out-File -FilePath $csvFilePath -Encoding utf8

Write-Host "Output file : $csvFilePath"
