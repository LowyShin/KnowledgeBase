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

### Nodejs에서 만든 프로젝트를 github에 올리면 CI/CD처럼 받아 백그라운드에서 지속 실행

보통 nodejs를 서비스로서 실행하는 서비스를 설치하거나 jenkins등을 이용해서 설치하는 방법이 있으나,
giip를 이용해서 간단하게 실행하는 방법을 소개합니다. 

1. giip가입 및 Logical Server 생성
   - https://github.com/LowyShin/giipdoc-ko/wiki/%EB%B9%A0%EB%A5%B8-%EC%8B%9C%EC%9E%91
   - 양은 좀 많지만 어렵지 않으니 따라하시기 바랍니다.
2. giipAgentLinux 를 서버에 설치
   - 1번의 링크를 따라하면 giipAgentLinux를 서버에 설치까지 끝납니다.
3. git clone으로 첫 소스 가져옴
   - git clone명령을 사용하여 서버에서 소스를 우선 가져옵니다.
   - 소스 위치와 스크립트의 위치를 맞출 필요가 있습니다. 만약 맞추기 귀찮다면 `mkdir -p /usr/projects` 라고 생성해서 그 위치에서 git clone을 하면 편리합니다. 
4. node를 기동하는 스크립트 작성
   - https://github.com/LowyShin/giip/blob/gh-pages/giipscripts/sh/nodejs-githubsyncandrun.sh
   - 기동하지 않는다면 이슈에 환경을 올려주면 맞춰드립니다. ^^
5. 작성한 스크립트를 서버에 할당
   - 아래 링크에서부터 실행하여 3에서 작성한 스크립트를 등록하고 할당합니다.
   - https://github.com/LowyShin/giipdoc-ko/wiki/%EB%B9%A0%EB%A5%B8-%EC%8B%9C%EC%9E%91#%EC%84%9C%EB%B2%84-%EC%A0%95%EB%B3%B4-%EC%B7%A8%EB%93%9D-%EC%8A%A4%ED%81%AC%EB%A6%BD%ED%8A%B8%EC%9D%98-%EB%93%B1%EB%A1%9D
6. 서버에서 로그 확인
   - 서버에 ssh로 접속후 아래 커맨드로 실행여부를 리얼타임으로 확인 가능합니다.
   - `tail -f /var/log/giipAgentYYYYMMDD.log`
   - 기다리기 싫은 경우는 강제 실행 버튼을 눌러 실행할 수 있습니다.
   ![image](https://github.com/LowyShin/KnowledgeBase/assets/20239203/905bfc03-c719-49ac-9d7a-595556bb3ef8)


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

