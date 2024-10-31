# Get the current directory
$currentDirectory = Get-Location

# Path to the Excel file in the current directory
$excelFilePath = "$currentDirectory\copyuser-mssql.xlsx"

# Name of the sheet you want to convert
$sheetName = "Gen"

# Path to the temporary CSV file in the current directory
$tempCsvFilePath = "$currentDirectory\copyuser-mssql-temp.csv"
$tempCsvFilePath02 = "$currentDirectory\copyuser-mssql-temp02.csv"

# Path to the final CSV file without quotation marks
$finalCsvFilePath = "$currentDirectory\copyuser-mssql-gen.bat"

# Create an instance of Excel application
$excel = New-Object -ComObject Excel.Application

# Disable alerts to prevent any pop-ups
$excel.DisplayAlerts = $false

# Open the Excel workbook
$workbook = $excel.Workbooks.Open($excelFilePath)

# Get the sheet by name
$sheet = $workbook.Sheets.Item($sheetName)

# Save the sheet as a temporary CSV file
$sheet.SaveAs($tempCsvFilePath, 6)  # 6 is the constant for xlCSV

# Close the workbook without saving changes
$workbook.Close($false)

# Quit the Excel application
$excel.Quit()

# Release the COM objects
[System.Runtime.Interopservices.Marshal]::ReleaseComObject($sheet) | Out-Null
[System.Runtime.Interopservices.Marshal]::ReleaseComObject($workbook) | Out-Null
[System.Runtime.Interopservices.Marshal]::ReleaseComObject($excel) | Out-Null

# Perform garbage collection
[GC]::Collect()
[GC]::WaitForPendingFinalizers()

# Read the temporary CSV file, remove quotes, and write to the final CSV file
Get-Content -Path $tempCsvFilePath | ForEach-Object { $_ -replace '""', '''' } | Set-Content -Path $tempCsvFilePath02
Get-Content -Path $tempCsvFilePath02 | ForEach-Object { $_ -replace '"', '' } | Set-Content -Path $tempCsvFilePath
Get-Content -Path $tempCsvFilePath | ForEach-Object { $_ -replace '''', '"' } | Set-Content -Path $finalCsvFilePath

# Remove the temporary CSV file
Remove-Item -Path $tempCsvFilePath
Remove-Item -Path $tempCsvFilePath02

Write-Output "Excel sheet '$sheetName' has been successfully saved as CSV to '$finalCsvFilePath' without quotation marks."
