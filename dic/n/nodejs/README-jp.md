## Install

### NVM(Node Version Manager)

- install NVM for windows
https://github.com/coreybutler/nvm-windows

```sh
# Installed Node List
nvm list

# node 16 latest install 
nvm install 16

# change node
nvm use 16

# check version
node --v
```

### RHEL(Red Hat Enterprise Linux)

Install nodejs 16 version
```sh
dnf module -y install nodejs:16

# Check version
node -v
```

- Install Yarn
```sh
curl -sL https://dl.yarnpkg.com/rpm/yarn.repo -o /etc/yum.repos.d/yarn.repo

dnf install -y yarn
```


### CentOS

```sh
curl -fsSL https://rpm.nodesource.com/setup_16.x | sudo bash -
sudo yum install -y nodejs

# remove previous version of nodejs when conflict latest version
yum remove nodejs
yum clear all
```

## Management

### Nodejsで作ったプロジェクトをgithubにアップしたらCI/CDのようにバックグラウンドで実行する

普段はnodejsをサービスとして実行する追加モジュールをインストールするかjenkinsなどを利用する方法がありますが、
giipを利用して簡単に実装ができます。

1. giip登録及びLogical Server作成
   - https://github.com/LowyShin/giipdoc-ja/wiki/Quickstart
2. giipAgentLinuxをサーバーに登録
   - 1番手順のリンクにgiipAgentLinuxの登録手順が含まれてます。
3. git cloneでソースのダウンロード
   - git cloneコマンドを利用してサーバーからソースをダウンロードします。
   ```sh
   mkdir -p /usr/projects
   cd /usr/projects
   git clone https://github.com/LowyShin/myprj.git
   ```
   - git cloneから権限などの問題が発生したらssh-keyを登録する必要があります。
     - https://github.com/LowyShin/KnowledgeBase/blob/master/dic/g/git.md#account   
   - ソース位置とスクリプトの位置を合わせる必要がありますが、面倒だったら`mkdir -p /usr/projects`にしたらサンプルと同じ位置になります。
4. nodeを起動するスクリプトを作成
   - https://github.com/LowyShin/giip/blob/gh-pages/giipscripts/sh/nodejs-githubsyncandrun.sh
   - 上記のリンクのソースをそのままコピーし[Automation > AddScript](https://giipasp.azurewebsites.net/view/SMAHTML/ScrPut.asp)に登録します。
   - 登録方法は1番手順にあるQuick Startの[サーバー情報取得スクリプトの登録]をご参考ください。 
   - 起動しなかったらイシューに環境をお教え頂ければご対応致します。
5. 作成したスクリプトをサーバーに割り当て
   - Quick Startの手順３から作成したスクリプトを登録して割り当てます。
6. サーバーからログ確認
   - サーバーにssh接続後下記のコマンドから実行状況がリアルタイムで確認できます。
   - `tail -f /var/log/giipAgentYYYYMMDD.log`
   ![image](https://github.com/LowyShin/KnowledgeBase/assets/20239203/2691989d-5ba3-4ca0-a284-21d65d947279)
   - スクリプトは強制実行ボタンがあり、クリックすると待たずに実行できます。
   ![image](https://github.com/LowyShin/KnowledgeBase/assets/20239203/905bfc03-c719-49ac-9d7a-595556bb3ef8)

登録したらDAEMONなどのプロセスなしでsshコンソールは閉じてもプロセスがバックグラウンドで稼働中になります。
バックグラウンドにするためのなんの追加リソースも要りません。
そして、状態情報はKVSに自動登録されるためサービスの状況が把握できます。
スクリプトにプロセスが落ちたら自動的に起動するようになっているのでチェック周期だけ調整すればオッケーです。
ソースが変わった場合`yarn install`が自動実行され、インストールが終わったら`yarn build`でビルドしてプロセスを起動するようになってます。

サーバーが変わったとしてもそのままリストアしたり、giipAgent.cnfをそのまま持っていけばなんの修正もなしで運用が続けられます。

しかし、Auto Scaleなどでサーバーが自動に増える場合は増えたサーバー中1台のスクリプトが稼働するためその時はLogical Machineを追加するか
サーバーが実行したら他のサーバーにもアップするように再登録するなどのAPIを組む必要があります。

### NODE_ENV on Windows

nodejsのNODE_ENV, SET_ENV等Linux shellからの環境変数がWindowsでも読めるにはwindows bashが必要。
大体の場合gitをインストールしているためgit bashを利用して設定するのが楽

```sh
npm config set script-shell "C:\\Program Files\\git\\bin\\bash.exe"
```

ref : https://evantay.com/docs/nodejs-set-npm-run-shell/


## nodejs上で動くFramework

* [Flutter](https://github.com/LowyShin/KnowledgeBase/tree/master/wiki/flutter)
  * nodesjからインストールできるWeb/Android/iOSを一気に開発できるツール。コードの修正があまりいらなくnodejsからの様々な追加機能の活用ができる。
* [Vue.js](https://github.com/LowyShin/KnowledgeBase/tree/master/wiki/vue)
  * Front Web向け。SEO対策などが柔軟にできて反応が早い。
* [Nuxt.js](https://github.com/LowyShin/KnowledgeBase/tree/master/wiki/nuxtjs)
- [Nest.js](https://github.com/LowyShin/KnowledgeBase/tree/master/wiki/nestjs)

## Ref

* [node.js html内のjsファイルの読み込み](https://www.naka-sys.okinawa/nodejs-html-include/)
* [ゼロからはじめるExpress + Node.jsを使ったアプリ開発](https://qiita.com/nkjm/items/723990c518acfee6e473)
* [Node.js入門](https://www.tohoho-web.com/ex/nodejs.html#hello_web)

