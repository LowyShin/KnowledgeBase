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