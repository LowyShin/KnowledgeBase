## Install

### RHEL(Red Hat Enterprise Linux)

Install nodejs 16 version
```sh
dnf module -y install nodejs:16

# Check version
node -v
```

### CentOS

```sh
curl -fsSL https://rpm.nodesource.com/setup_16.x | sudo bash -
sudo yum install -y nodejs

# remove previous version of nodejs when conflict latest version
yum remove nodejs
yum clear all
```

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

