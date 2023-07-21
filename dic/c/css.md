# Cascade Style Sheet(CSS)

### CSSだけで外部サイトへのリンクにマーク(アイコン)をつける方法1

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

### Custom Cursor

```css
<ul>
<li style="cursor: auto">auto　ブラウザが自動的に選択したカーソル</li>
<li style="cursor: default">default　矢印型など利用環境の標準カーソル</li>
<li style="cursor: pointer">pointer　リンクカーソル</li>
<li style="cursor: crosshair">crosshair　十字カーソル</li>
<li style="cursor: move">move　移動カーソル</li>
<li style="cursor: text">text　テキスト編集カーソル</li>
<li style="cursor: wait">wait　待機・処理中カーソル</li>
<li style="cursor: help">help　ヘルプカーソル</li>
<li style="cursor: n-resize">n-resize　北方向のリサイズカーソル</li>
<li style="cursor: s-resize">s-resize　南方向のリサイズカーソル</li>
<li style="cursor: w-resize">w-resize　西方向のリサイズカーソル</li>
<li style="cursor: e-resize">e-resize　東方向のリサイズカーソル</li>
<li style="cursor: ne-resize;">ne-resize　北東方向のリサイズカーソル</li>
<li style="cursor: nw-resize;">nw-resize　北西方向のリサイズカーソル</li>
<li style="cursor: se-resize">se-resize　南東方向のリサイズカーソル</li>
<li style="cursor: sw-resize;">sw-resize　南西方向のリサイズカーソル</li>
<li style="cursor: progress">progress　進行中カーソル（CSS 2.1より仕様に追加）</li>
<li style="cursor: url('../images/htmq.cur')">url('ファイルのパス')　オリジナルのカーソル</li>
<li style="cursor: hand">hand　指型カーソル（IE4以上の独自拡張）</li>
<li style="cursor: no-drop">no-drop　ドロップ禁止カーソル（IE6以上の独自拡張）</li>
<li style="cursor: all-scroll">all-scroll　全スクロールカーソル（IE6以上の独自拡張）</li>
<li style="cursor: col-resize">col-resize　横方向のリサイズカーソル（IE6以上の独自拡張）</li>
<li style="cursor: row-resize">row-resize　縦方向のリサイズカーソル（IE6以上の独自拡張）</li>
<li style="cursor: not-allowed">not-allowed　禁止カーソル（IE6以上の独自拡張）</li>
<li style="cursor: vertical-text">vertical-text　縦書きカーソル（IE6以上の独自拡張）</li>
</ul>
```
