## Initialize

* サーバーに接続した場合最初設定手順

1. サーバーにAccount登録
```sh
echo "machine github.com">~/.netrc
echo "login <githubLoginName>">>~/.netrc
echo "password <password>">>~/.netrc
```

2. git config設定
```sh
git config --global user.email "LowyAI@GIIP.com"
git config --global user.name "LowyAI"
```

3. サーバーのRSAキー作成
```sh
ssh-keygen -t rsa -b 4096 -C 'giip@thismachinename'
```

4. githubにRSAキー登録
  * githubホームページの右上の自分のアカウント画像クリック
  * Settings
  * SSH and GPG Key
  * New SSH Key
  ```sh
  cat ~/.ssh/id_rsa.pub
  ```
  * id_rsa.pubファイルの内容を記入して登録

5. FreeBSDなどhttp通信できない場合
  * FreeBSD等の一部のOSでは4番までやっても「no matching mac found」とはじかれるケースがあるのでその場合は次に従う
  * Settings > Developer Settings > Personal Access Tokens > Generate New Token 
  * Repository関連だけチェックを入れて作成
  * 現在作業しているサーバーのターミナルから`vi .git/config`で設定を開く
  * `git@github.com~~~`の部分の前のgitを作成したキーに入れ替える
    * 例 : `https://ghp_nnsj1ShqSXXXXXXXXXVAiTQfzXXXXxeP2@github.com/LowyShin/myrepo.git`

## Account

### [GitHub] SSHの鍵を登録しパスワード入力を不要にする

1. ssh-keygenでキーファイルを作成
```
ssh-keygen -t rsa -b 4096 -C 'giip@myclient01'

cat ~/.ssh/id_rsa.pub
# copy to clipboard id_rsa.pub text
```
2. Login to github
3. Account > Setting > SSH and GPG Keys
4. Click New SSH Key
5. Paste from clipboard id_rsa.pub text
6. Clic Add SSH Key

then you can use git command by ssh

```sh
git clone git@github.com:LowyShin/Knowledgebase.git
```


## tips

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
* git branch make
  * https://qiita.com/hinatades/items/d47dec72a87c5fed50f7
  * https://techacademy.jp/magazine/10264

* git history clear(reinit)
  *  https://gist.github.com/stephenhardy/5470814



## Markdown

* Official : https://github.com/dotnet/docs/blob/master/styleguide/template.md#supported-languages

## Authentication

* vscode git basic credential logon failed
  * git application update 
    * `git update-git-for-windows`
  * reset windows auth
    * https://cpoint-lab.co.jp/article/201804/2137/
* [git credential problem(password change, initialize)](https://www.zunouissiki.com/entry/git-credential-manager-for-windows/)

