REM Copy from copyuser-mssql.xlsx!Gen sheet
REM .\copyuser-mssql-gen.ps1 -serverInstance "YOUR_SERVER_INSTANCE" -databaseName "YOUR_DATABASE_NAME" -loginName "NEW_LOGIN_NAME" -newUserPassword "NEW_USER_PASSWORD"

powershell .\copyuser-mssql-gen.ps1
copyuser-mssql-gen.bat
