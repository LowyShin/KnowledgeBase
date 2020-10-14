set sHost=%COMPUTERNAME%

git pull origin master

git add .

git commit -m "auto sync from %sHost%"

git push origin master
