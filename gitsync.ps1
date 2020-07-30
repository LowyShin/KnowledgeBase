$hn = (Get-CimInstance -Class Win32_ComputerSystem).Name

git pull origin master

git add .

git commit -m "auto sync from $hn"

git push origin master
