* VS Codeを利用した同期の管理
  * https://talklowy-jp.blogspot.com/2019/12/vs-codemicrosoft-visualstudio.html


* if can not upload large files, and delete original file.. then
```shell
git filter-branch --force --index-filter  'git rm --cached --ignore-unmatch kvexport/kv20190716-Kia02-s03_volume.csv'   --prune-empty --tag-name-filter cat -- --all

git push origin master
```

* GitHubでユーザ名・パスワード省略（push, pull）
  * https://qiita.com/azusanakano/items/8dc1d7e384b00239d4d9
```sh
echo "machine github.com">~/.netrc
echo "login ai@netbako.com">>~/.netrc
echo "password <password>">>~/.netrc

git config --global user.email "ai@netbako.com"
git config --global user.name "LowyAI"
```

* Git clone
```sh
git clone https://github.com/LowyShin/giipAgentLinux.sh
```

* git pull
```sh
git pull origin master
```
* git push
```sh
git add .
git commit -m "changes comment"
git push origin master
```

### git history clear

```sh
-- Remove the history from 
rm -rf .git

-- recreate the repos from the current content only
git init
git add --all
git commit -m "reinitial history"

-- push to the github remote repos ensuring you overwrite history
git remote add origin https://github.com/LowyShin/myrepo.git
git push -u --force origin master
```

### make branch

* https://qiita.com/TetsuTaka/items/5ab227a8bd2cd7106833

## Markdown

* Official : https://github.com/dotnet/docs/blob/master/styleguide/template.md#supported-languages

## Authentication

* vscode git basic credential logon failed
  * git application update 
    * `git update-git-for-windows`
  * reset windows auth
    * https://cpoint-lab.co.jp/article/201804/2137/
