# Cascade Style Sheet(CSS)

### CSSだけで外部サイトへのリンクにマーク(アイコン)をつける方法

```html
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.11.0/css/all.css">
```

```css
a[href^="http"]:after,
a[href^="//"]:after {
  margin: 0 0 0 3px;
  font-family: "Font Awesome 5 Free";
  content: '\f35d';
  font-weight: 900;
}
a[href^="https://www.rectus.co.jp/"]:after {
  margin: inherit;
  font-family: inherit;
  content: '';
  font-weight: inherit;
}
```
