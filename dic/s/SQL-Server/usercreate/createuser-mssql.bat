REM Copy from createuser-mssql.xlsx!Gen sheet
REM .\createuser-mssql-gen.ps1 -serverInstance "YOUR_SERVER_INSTANCE" -databaseName "YOUR_DATABASE_NAME" -loginName "NEW_LOGIN_NAME" -newUserPassword "NEW_USER_PASSWORD"

powershell .\createuser-mssql-gen.ps1
createuser-mssql-gen.bat
