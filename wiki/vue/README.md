## Tips

### Global Variables

.env.{environment}
```js
VUE_APP_VAR01 = "my var"
```
- 変数前に`VUE_APP`を入れないとサービス全体で使えずに`vue.config.js`みたいなシステム関連ファイルだけで読み込めますが、変数の前に`VUE_APP`を入れると全てのvueファイルで変数が使えます。これは仕様です！

### Proxy

vue.config.js
```js
module.exports = {
  devServer: {
    proxy: {
      '^/api': {
        target: '<url>',
        ws: true,
        changeOrigin: true
      },
      '^/foo': {
        target: '<other_url>'
      }
    }
  }
}
```

### invalid host header

if you use many dns and hostname for dev, disable host check.
  
vue.config.js
```js
module.exports = {
  transpileDependencies: ["vuetify"],
  devServer: {
    disableHostCheck: true
  }
};
```

## Links

* configuration for web servers
  * https://router.vuejs.org/guide/essentials/history-mode.html#memory-mode

* [VueのUIフレームワーク比較](https://qiita.com/yoshiplur/items/d39fe389d363a66dbb1c)

* [Quasar + SSR + Nest.js Boilerplate](https://github.com/composite/quasar-ssr-nestjs-boilerplate)

* [サーバサイドレンダリング](https://v3.ja.vuejs.org/guide/ssr.html#%E5%AE%8C%E5%85%A8%E3%81%AA-ssr-%E3%82%AB%E3%82%99%E3%82%A4%E3%83%88%E3%82%99)

* [Vue3 UI Framework 비교](https://www.youtube.com/watch?v=mWOWOs3smPE)

