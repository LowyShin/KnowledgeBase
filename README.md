[Translate this page?](https://translate.googleusercontent.com/translate_c?depth=1&hl=en&rurl=translate.google.com&sl=auto&sp=nmt4&tl=ja&u=https://github.com/LowyShin/KnowledgeBase&usg=ALkJrhgmYJ2j5I5KtTO5ROlKUAYf8bQMcw)

## [KnowledgeBase](https://github.com/LowyShin/KnowledgeBase/wiki)

* [Markdown](https://github.com/LowyShin/KnowledgeBase/tree/master/wiki/Markdown)
* [Real World PlantUML](https://real-world-plantuml.com/)
  * Draw diagram on Markdown and so on. 
* [PUML for Markdown](https://github.com/danielyaa5/puml-for-markdown)
  * Draw diagram on Markdown and so on. 

### Data(DBMS, NoSQL, Datascience)

* [CLoud RDBMS比較](https://cloud-textbook.com/50/)
* [MachineLearning](https://github.com/LowyShin/KnowledgeBase/blob/master/wiki/AI/MachineLearning.md)
* [SQL Server](https://github.com/LowyShin/KnowledgeBase/blob/master/wiki/SQL-Server)
  * 同時5000Transaction程のDB負荷なら管理がしやすいSQL Serverをお勧めします。
* [ORACLE](https://github.com/LowyShin/KnowledgeBase/tree/master/wiki/ORACLE)
  * 同時10000Transaction以上・無限にユーザーを増加させたいならORACLEより強いDBMSはありません。しかしその分十分なDBMS知識なしでは逆効果になるので自身があったらおすすめします。
  * [ORACLE Active Duplicate](https://github.com/LowyShin/KnowledgeBase/blob/master/wiki/ORACLE/ORA-ActiveDuplicate.md)
  * [Basic Management](https://talklowy-jp.blogspot.com/2020/10/oracle-management-knowledge.html)
  * [Installation](https://github.com/LowyShin/KnowledgeBase/tree/master/wiki/ORACLEInstallTips)
  * [InstantClient](https://talklowy-jp.blogspot.com/2021/10/oracle-linuxcentos-instant-client.html)
  * [DDL](https://talklowy-jp.blogspot.com/2020/10/oracle-ddl-lowy-knowledgebase.html)
  * [ORACLETuning](https://github.com/LowyShin/KnowledgeBase/blob/master/wiki/ORACLE/ORACLETuning.md)
  * [Merge Into/Update Join](https://github.com/LowyShin/KnowledgeBase/blob/master/wiki/ORACLE/MERGE.md)
  * [Useful SQL](https://talklowy-jp.blogspot.com/2020/10/oracle-useful-sql.html)
  * [TableSpaceManagement](https://github.com/LowyShin/KnowledgeBase/blob/master/wiki/ORACLE/tablespace.md)
  * [datetime](https://github.com/LowyShin/KnowledgeBase/blob/master/wiki/ORACLE/ORAdatetime.md)
  * [Flashback](https://github.com/LowyShin/KnowledgeBase/blob/master/wiki/ORACLE/ORAFlashback.md)
  * [BackupRestore](https://talklowy-jp.blogspot.com/2021/02/oracle-backup-and-restore-lowy.html)
  * [Characterset(Official)](https://www.oracle.com/technetwork/jp/content/charcterset-250314-ja.pdf)
  * [DBMS STAT](https://github.com/LowyShin/KnowledgeBase/blob/master/wiki/ORACLE/ORADBMSSTAT.md)
* [MySQL](https://github.com/LowyShin/KnowledgeBase/tree/master/wiki/MySQL)
  * 同時4000トランザクション未満の3GB未満データでは一番軽く早いDBMSです。しかし容量と同時接続が増えるほど設計能力がパフォーマンスに直結するため拡張を考えるなら真剣に拡張設計から考慮することを推奨します。
  * [my.cnf](https://github.com/LowyShin/KnowledgeBase/wiki/my.cnf)
  * [Replication](https://talklowykr.blogspot.com/2021/03/mysql-replication.html)
  * [backup](https://github.com/LowyShin/KnowledgeBase/tree/master/wiki/MySQL)
  * [MMM-MultiMaster](https://talklowy-jp.blogspot.com/2014/08/mysql-mmm-multi-master-ha.html)
  * [semaphore bug](https://github.com/LowyShin/KnowledgeBase/blob/master/wiki/MySQL/semaphorebug.md)
* [mariadb](https://github.com/LowyShin/KnowledgeBase/tree/master/wiki/mariadb)
  * MySQLエンジンを使って分離されたDBMSですが、今はエンジンもかなり異なっておりスピードより拡張を考慮して発展し続いているDBMSです。4台以上の分散が必要な場合分散及び管理がより簡単にできますが、台数が増えても性能は上がることではないので分散設計は人の力に依存します。
* [Redis with MySQL](https://github.com/LowyShin/KnowledgeBase/blob/master/wiki/Redis/README.md)
  * DBMSのIO負荷を下げる中間DBMSとしてよく使われておりますが、KVS(Key Value Store)構造のメモリ保管モジュールなので色んな役割で使いこなすとすごい力になると思います。しかし、単純にCluster DB Cacheなどの意味で使ってしまうと逆に同期の問題で性能があまり出ないこともあるので十分知ってから使うことを推奨します。
* [Mongodb](https://github.com/LowyShin/KnowledgeBase/blob/master/wiki/mongodb)
  * ドキュメントデータベースとかに言われたりするHadoopと共にNoSQLの代表になりましたが、RDBMSではないのでRDBMSみたいにJoinをかけたりすると一般RDBMSよりもパフォーマンスが出ないこともあります。なのでNoSQLに入れるべきUnstructured(非構造)データを非正規化していかに高性能に使うかを考慮して設計しないと普通の大量テキストストレージになってしまうのでご注意を！
* [Apache-Drill](https://github.com/LowyShin/KnowledgeBase/wiki/Apache-Drill)
* [A5MK2-MultiDBMSTool](https://github.com/LowyShin/KnowledgeBase/wiki/A5MK2)
* [BI](https://github.com/LowyShin/KnowledgeBase/wiki/BI)
* [Referrals](https://github.com/LowyShin/KnowledgeBase/wiki/Referrals)
* [Kaggle: Your Machine Learning and Data Science Community](https://www.kaggle.com/)

### [BlockChain](https://github.com/LowyShin/KnowledgeBase/tree/master/wiki/blockchain)
* [BitCoin](https://ja.wikipedia.org/wiki/%E3%83%93%E3%83%83%E3%83%88%E3%82%B3%E3%82%A4%E3%83%B3)
  * [Source](https://github.com/bitcoin/bitcoin)
* [Ethereum](https://en.wikipedia.org/wiki/Ethereum)
  * [Source](https://github.com/ethereum)
* [Wallets](https://github.com/LowyShin/KnowledgeBase/tree/master/wiki/blockchain#wallets)
* [Mining](https://github.com/LowyShin/KnowledgeBase/blob/master/wiki/blockchain/README.md#mining)

### [Development](https://talklowy-jp.blogspot.com/2022/03/blog-post.html)

* [nodejs](https://github.com/LowyShin/KnowledgeBase/tree/master/wiki/nodejs)
* [Flutter](https://github.com/LowyShin/KnowledgeBase/tree/master/wiki/flutter)
* [DataVisual](https://observablehq.com/@d3/gallery)
* [Python](https://github.com/LowyShin/KnowledgeBase/wiki/Python)
* [Classic ASP](https://github.com/LowyShin/ClassicASP/wiki)
* [wsf/vbs/vba](https://github.com/LowyShin/ClassicASP/wiki/wsf)
* [WMI](WMI)
* [HTML](https://github.com/LowyShin/KnowledgeBase/wiki/HTML)
  * [HTML(kr)](https://talklowykr.blogspot.com/2021/01/html-1-html.html)
* [Chatbot](https://github.com/LowyShin/KnowledgeBase/blob/master/wiki/AI/Chatbot.md)
* [PHP](https://github.com/LowyShin/KnowledgeBase/blob/master/wiki/PHP/README.md)

### RPA(Robotic Process Automation)

* [WWF(Windows Workflow Foundation)](https://docs.microsoft.com/ja-jp/dotnet/framework/windows-workflow-foundation/)
  * 2005年9月に開催されたPDC（Professional Developers Conference）で発表されたマイクロソフトの次世代ワークフロー基盤のことである。
  * UiPath, AkabotなどにRPAエンジンを提供している。
* [Power Automate](https://powerautomate.microsoft.com/ja-jp/desktop/)
  * Microsoft社が提供するパソコン向けのRPAツール
* [UiPath(RPA)](https://github.com/LowyShin/lwrpa-uip-study-ja/wiki)
  * WWFをベースに500億以上投資を受けて全世界に急激に拡張している海外ソリューション
* [Akabot](https://akabot.com/)
  * UiPathと同じくWWFをベースにしたのでUiPathと全く同じUIを持っているソリューション。ベトナムのFPT社が開発
* [Automation Anywhere](https://www.automationanywhere.com/jp/)
* [Win Actor](https://winactor.com/)
  * NTTアドバンステクノロジ株式会社の日本専用RPAツール

### Tools

* [ezis - DBパフォーマンス分析ツール(日本語公式)](https://github.com/LowyShin/ezis-jp)
* [Juliaの自動微分パッケージ Zygote の紹介](https://pseudo-theory-of-everything.hatenablog.com/entry/2021/04/12/220015)
* [color code table](https://www.colordic.org/)
* [Canva - free Online Design tool](https://www.canva.com/)
* [vscode](https://github.com/LowyShin/KnowledgeBase/blob/master/wiki/vscode/README.md)
* [git(github)](https://github.com/LowyShin/KnowledgeBase/tree/master/wiki/git)
* [GoogleSheet](https://github.com/LowyShin/KnowledgeBase/wiki/GSheet)
* [WinAutomation(official)](https://docs.winautomation.com/V9_0/en/winautomation.html)
* [Excel](https://github.com/LowyShin/KnowledgeBase/tree/master/wiki/excel)
* [VNC](https://github.com/LowyShin/KnowledgeBase/wiki/VNC)
* [VPN](https://github.com/LowyShin/KnowledgeBase/wiki/VPN)
* [Note Tool](https://github.com/LowyShin/KnowledgeBase/wiki/Note-Tool)
* [Blog](https://github.com/LowyShin/KnowledgeBase/wiki/Blog)
* [google news alert](https://www.google.com/alerts#)
* [Online PDF to JPG](https://pdftoimage.com/ja/)
* [LoadTest](https://github.com/LowyShin/KnowledgeBase/blob/master/wiki/Tools/LoadTest.md)
" [putty](https://github.com/LowyShin/KnowledgeBase/tree/master/wiki/putty)

### Management

* [Shell/bash](https://github.com/LowyShin/KnowledgeBase/wiki/Shell)
* [crontab](https://github.com/LowyShin/KnowledgeBase/wiki/crontab)
* [PowerShell](https://github.com/LowyShin/KnowledgeBase/wiki/PowerShell)
* [Windows(DOS) batch](https://github.com/LowyShin/KnowledgeBase/wiki/WinBatch)
* [Wscript/wsf](https://github.com/LowyShin/KnowledgeBase/wiki/Wscript)
* [AWS](https://github.com/LowyShin/KnowledgeBase/tree/master/wiki/AWS)
  * [アベイラビリティーゾーンを使用できるかを確認する](https://aws.amazon.com/jp/premiumsupport/knowledge-center/vpc-find-availability-zone-options/)
* [Azure](https://github.com/LowyShin/KnowledgeBase/blob/master/wiki/azure/README.md)
  * [仮想マシン スケールセット を試す](https://www.cloudou.net/virtual-machine-scale-sets/vmss001/)
* [File Sync(rsync, scp...)](https://github.com/LowyShin/KnowledgeBase/wiki/Sync)
* [KnownPort(wikipedia)](https://en.wikipedia.org/wiki/List_of_TCP_and_UDP_port_numbers)

### Storage

* [The Top 13 Free and Open Source Storage Solutions](https://solutionsreview.com/data-storage/the-top-free-and-open-source-storage-solutions/)

### OS

* [CentOS(Linux)](https://talklowy-jp.blogspot.com/2021/04/centos-knowledgebase-giip.html)
* [Windows10](https://github.com/LowyShin/KnowledgeBase/blob/master/wiki/windows/windows10.md)
* Android
  * [Rooting app](https://talklowy-jp.blogspot.com/2020/10/android-rooting-app.html)
  * [adb shell](https://talklowy-jp.blogspot.com/2020/10/android-rooting-app.html)

### Hardware

* [Xeon CPU](https://github.com/LowyShin/KnowledgeBase/wiki/Xeon-CPU)
* [Paloalto FW](https://github.com/LowyShin/KnowledgeBase/blob/master/wiki/Hardware/Paloalto.md)
* [Cisco](https://github.com/LowyShin/KnowledgeBase/blob/master/wiki/Hardware/Cisco.md)
* [Dell](https://github.com/LowyShin/KnowledgeBase/blob/master/wiki/Hardware/Dell.md)


### Business

* [Startup checkpoint(jp)](https://github.com/LowyShin/KnowledgeBase/wiki/StartupChkJP)
* [スタートアップ企業リスト](https://startup-db.com/companies)
* [Dev Outsourcing](https://github.com/LowyShin/KnowledgeBase/blob/master/wiki/Business/DevOutsourcing.md)
* [Makeshop Reseller partner(jp)](https://www.makeshop.jp/partner/reseller_partner.html)
* [BINDupホームページ自動作成](https://bindup.jp/plan/)

### Job&Hire

* [Lancers(jp)](https://www.lancers.jp)

### Hobby

* [VR(VirutualReality)](https://github.com/LowyShin/KnowledgeBase/tree/master/wiki/vr)
  * Oculus Quest 2
* [Lithum-ion Battery](https://github.com/LowyShin/KnowledgeBase/blob/master/wiki/Hobby/Lithium-ion-Battery.md)
* [Ebike](https://github.com/LowyShin/KnowledgeBase/blob/master/wiki/Hobby/EBike.md)
* [Electronic goods](https://github.com/LowyShin/KnowledgeBase/wiki/Electronic-goods)
* [キズの付いたCDを修復する方法](https://www.wikihow.jp/%E3%82%AD%E3%82%BA%E3%81%AE%E4%BB%98%E3%81%84%E3%81%9FCD%E3%82%92%E4%BF%AE%E5%BE%A9%E3%81%99%E3%82%8B)
* [プラスチックについた傷を消す方法](https://www.wikihow.jp/%E3%83%97%E3%83%A9%E3%82%B9%E3%83%81%E3%83%83%E3%82%AF%E3%81%AB%E3%81%A4%E3%81%84%E3%81%9F%E5%82%B7%E3%82%92%E6%B6%88%E3%81%99)

### Lifestyle

* [Share House](https://github.com/LowyShin/KnowledgeBase/blob/master/wiki/Lifestyle/Sharehouse.md)

## Giip(RPA Engine)

* [giip docs](https://github.com/LowyShin/giip)
* [giip website](https://giipasp.azurewebsites.net)


* [基本からわかる！高性能×高可用性データベースシステムの作り方　第7回 バックアップ/リカバリ(2)RMANの基本](https://blogs.oracle.com/otnjp/post/kusakabe-007)
* [firewall-cmd](https://qiita.com/kenjjiijjii/items/1057af2dddc34022b09e)
* [PHP Get Site URL Protocol - http vs https](https://stackoverflow.com/questions/4503135/php-get-site-url-protocol-http-vs-https)
* [[GitHub] SSHの鍵を登録しパスワード入力を不要にする](https://blog.katsubemakito.net/git/github-ssh-keys)
* [Markdown 表Tableの基本記法](https://notepm.jp/help/markdown-table)
* [【図解】Excelでカーソル移動できない⁉︎ 対処法と便利な移動テクを徹底ガイド](https://mainichi.doda.jp/article/2019/10/28/1733.html#%E3%82%AB%E3%83%BC%E3%82%BD%E3%83%AB%E3%82%92%E7%A7%BB%E5%8B%95%E3%81%99%E3%82%8B%E3%81%A8%E7%94%BB%E9%9D%A2%E3%81%8C%E3%82%B9%E3%82%AF%E3%83%AD%E3%83%BC%E3%83%AB%E3%81%95%E3%82%8C%E3%81%A6%E3%81%97%E3%81%BE%E3%81%86%E3%81%A8%E3%81%8D%E3%81%AE%E5%AF%BE%E5%87%A6%E6%B3%95)
* [CentOS6.6にOpenSwanでIPsec](http://kumakake.com/linux/3475)
* [【 ip 】コマンド（基礎編）――ネットワークデバイスのIPアドレスを表示する](https://atmarkit.itmedia.co.jp/ait/articles/1709/22/news019.html)
* [Linux(CentOS 6) - yum installコマンドでtracerouteパッケージをインストールする](https://nobuneko.com/blog/archives/2013/05/linux_centos_6_yum_install_traceroute.html)

* [Flutter theme](https://flutterawesome.com/a-flutter-app-used-as-patient-monitoring-such-as-medicine-intake-reminder-and-schedulled-activities/)

* [node.js html内のjsファイルの読み込み](https://www.naka-sys.okinawa/nodejs-html-include/)
* [ゼロからはじめるExpress + Node.jsを使ったアプリ開発](https://qiita.com/nkjm/items/723990c518acfee6e473)
* [Node.js入門](https://www.tohoho-web.com/ex/nodejs.html#hello_web)
* [오라클 메모리 관련 정리](https://positivemh.tistory.com/493) 
