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

### DateDiff(Date Calculate)

```gs
var dt1 = new Date(), // today's date
var dt2 = new Date("2022-03-22T20:23:26+0000"); 

var lwDateDiff = Math.floor((dt1.getTime() - dt2.getTime())/(24*3600*1000));
var lwHourDiff = Math.floor((dt1.getTime() - dt2.getTime())/(3600*1000));
var lwMinuteDiff = Math.floor((dt1.getTime() - dt2.getTime())/(60*1000));

console.log("Date Diff : " + lwDateDiff);
console.log("Hour Diff : " + lwHourDiff);
console.log("Minute Diff : " + lwMinuteDiff);
```

### Post to Slack

```ga
function postSlack(text){
  var url = "Slack Post URL";//WebhookURL
  var options = {
    "method" : "POST",
    "headers": {"Content-type": "application/json"},
    "payload" : '{"text":"' + text + '"}'
  };
  UrlFetchApp.fetch(url, options);
}

```

### Send to Mail

```ga
function sendEmail(lwFromName, lwTo, lwSubject, lwBody){
  var recipient = lwTo;
  var subject = lwSubject;
  var body = lwBody;
  var options = {name: lwFromName};
  GmailApp.sendEmail(recipient, subject, body, options);
}

```


### Custom Property

* [GoogleAppsScript　スクリプトのプロパティの超簡単な使い方](https://qiita.com/0Delta/items/7d8303eebbff4062069e)

- [How to Get the Sheet Name in Google Sheets (Formula)](https://spreadsheetpoint.com/get-sheet-name-google-sheets/)


## Links

* [Google Apps Scriptで値の変更をトリガーにしつつ変更されたセルの行番号と列番号を知る](https://tonari-it.com/gas-trigger-changed/#toc2)
* [スプレッドシートで特定の列のセルに色がついた時に、メールで通知がくるようにしたい](https://teratail.com/questions/295611)

* [GASでローカルCSVを取り込み、スプレッドシートで請求書を作成する](https://dev.classmethod.jp/articles/gas-ss-csv-create-invoice/)

