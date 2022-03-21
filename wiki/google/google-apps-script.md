# Google Apps Script

## Google Sheet

* 拡張機能 > Apps Script
  * Trigger(トリガー、時計アイコン)メニューから条件の設定が可能
  * ソースで関数ごとにコードを書いた後、Triggerから関数別実行条件を設定可能。
    * 周期的に実行
    * セルに変化があったら実行

### Write Cell

```gs
var sheet = SpreadsheetApp.getActiveSpreadsheet().getActiveSheet();
var cell = sheet.getRange(3,2);
cell.setValue(10000);
```

### Get Now()

```gs
var date = new Date();
Logger.log(Utilities.formatDate( date, 'Asia/Tokyo', 'yyyy-MM-dd HH:mm:ss'));
```

* [Google Apps Scriptで値の変更をトリガーにしつつ変更されたセルの行番号と列番号を知る](https://tonari-it.com/gas-trigger-changed/#toc2)
* [スプレッドシートで特定の列のセルに色がついた時に、メールで通知がくるようにしたい](https://teratail.com/questions/295611)


