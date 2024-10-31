REM Copy from deleteuser-mssql.xlsx!Gen sheet
REM .\deleteuser-mssql-gen.ps1 -serverInstance "YOUR_SERVER_INSTANCE" -databaseName "YOUR_DATABASE_NAME" -loginName "NEW_LOGIN_NAME" -newUserPassword "NEW_USER_PASSWORD"

powershell .\deleteuser-mssql-gen.ps1
deleteuser-mssql-gen.bat
