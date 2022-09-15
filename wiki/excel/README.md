* JSONファイルを取り込む
    * データー＞ファイルから読み込む＞JSONから読むコムを選択すると簡単に読み込み可能
    * プリビュー画面から「record」、「list」などになって内容が表示されない場合はフィールド名の右にある拡張ボタンをクリックするとデータの形に合わせてフィールドが自動追加されます。
    * 構造上フィールの追加ではなく行の追加になった場合、区分を「コンマ」などに設定して一つのフィールドに統合することもできるのでデータを見ながら処理する必要があります。
    * Azure, AWS, Terraformなどの設定をJSONで管理した場合そのまま落としてExcelに同期して管理する場合便利です。
    * https://www.katalog.tokyo/?p=1740

* [エクセルやワードが遅い！OfficeのTelemetryを止める](https://nyanto.jimdofree.com/%EF%BD%B4%EF%BD%B8%EF%BD%BE%EF%BE%99%E9%96%A2%E6%95%B0-%E5%95%8F%E9%A1%8C%E8%A7%A3%E6%B1%BA/%E3%82%A8%E3%82%AF%E3%82%BB%E3%83%AB%E3%81%AE%E9%96%8B%E3%81%8F%E3%82%84%E4%BF%9D%E5%AD%98-%E9%96%89%E3%81%98%E3%82%8B%E3%81%8C%E9%81%85%E3%81%84-office%E3%81%AEtelemetry%E3%82%92%E6%AD%A2%E3%82%81%E3%82%8B%E6%96%B9%E6%B3%95/)
* [【図解】Excelでカーソル移動できない⁉︎ 対処法と便利な移動テクを徹底ガイド](https://mainichi.doda.jp/article/2019/10/28/1733.html#%E3%82%AB%E3%83%BC%E3%82%BD%E3%83%AB%E3%82%92%E7%A7%BB%E5%8B%95%E3%81%99%E3%82%8B%E3%81%A8%E7%94%BB%E9%9D%A2%E3%81%8C%E3%82%B9%E3%82%AF%E3%83%AD%E3%83%BC%E3%83%AB%E3%81%95%E3%82%8C%E3%81%A6%E3%81%97%E3%81%BE%E3%81%86%E3%81%A8%E3%81%8D%E3%81%AE%E5%AF%BE%E5%87%A6%E6%B3%95)

* Convert cell string type force
  * `=TEXT(date,format)`
  * https://exceljet.net/formula/convert-date-to-text

* get End date from string type date
  * A1 : 20200501
  * A2 : `=TEXT(EOMONTH(DATE(MID(A1, 1, 4), MID(A1, 5, 2), "01"),-1), "yyyymmdd")`
    * result : 20200430
  * A3 : `=TEXT(EOMONTH(DATE(MID(A1, 1, 4), MID(A1, 5, 2), "01"),0), "yyyymmdd")`
    * result : 20200531
  * A4 : `=TEXT(EOMONTH(DATE(MID(A1, 1, 4), MID(A1, 5, 2), "01"),1), "yyyymmdd")`
    * result : 20200630
 
### VLookUp

```vb
VLOOKUP(Findword, Range, ReturnFieldNumber)
```

### MAX

```vb
MAX(A1:B50)
```
* if range contains mixed with number and character, then return 0

### MOD
```vb
MOD(2198, 5)
```
left number of 2198 devide 5 
* https://office-hack.com/excel/mod/

### Pivot

* [Excel pivot table range change](https://office-hack.com/excel/pivot-table-range-change/)

### datetime

* excel 時間計算
  * https://www.tipsfound.com/excel/02207

### Macro(VBA)

* [VBA CSV ファイルの読み込み (Workbooks.OpenText 関数を使う)](https://www.tipsfound.com/vba/18015)
* [【VBA】UsedRangeの範囲から最終行など取得【UsedRange.Rows.Countなど】](https://daitaideit.com/vba-usedrange/)
