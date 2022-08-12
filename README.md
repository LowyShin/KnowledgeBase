[Translate this page?](https://translate.googleusercontent.com/translate_c?depth=1&hl=en&rurl=translate.google.com&sl=auto&sp=nmt4&tl=ja&u=https://github.com/LowyShin/KnowledgeBase&usg=ALkJrhgmYJ2j5I5KtTO5ROlKUAYf8bQMcw)

## [KnowledgeBase](https://github.com/LowyShin/KnowledgeBase/wiki)

* [Markdown](https://github.com/LowyShin/KnowledgeBase/tree/master/wiki/Markdown)
* [Real World PlantUML](https://real-world-plantuml.com/)
  * Draw diagram on Markdown and so on. 
* [PUML for Markdown](https://github.com/danielyaa5/puml-for-markdown)
  * Draw diagram on Markdown and so on. 

### Data(DBMS, NoSQL, Datascience)

* [CLoud RDBMS比較](https://cloud-textbook.com/50/)
* [MachineLearning(ML/AI)](https://github.com/LowyShin/KnowledgeBase/blob/master/wiki/AI/MachineLearning.md)
* [SQL Server](https://github.com/LowyShin/KnowledgeBase/blob/master/wiki/SQL-Server)
  * 同時5000Transaction程のDB負荷なら管理がしやすいSQL Serverをお勧めします。Azure SQLを使うと自動チューニング機能があってオンしておくと勝手にIndex Tuningを行います。（勝手にIndexがなくなったり作成されたり）データのアクセスパターンによって同じデータセットだとしても使うユーザーのパターンによってチューニングが変わるのでDBMSに詳しくない場合でも十分なパフォーマンスが保たれます。
  * [Ezis - RDBMS Monitoring](https://github.com/LowyShin/ezis-jp)

* [ORACLE](https://github.com/LowyShin/KnowledgeBase/tree/master/wiki/ORACLE)
  * [Ezis - RDBMS Monitoring](https://github.com/LowyShin/ezis-jp)
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
  * [dbvisitを利用したAWS上のRoacle Cluster](https://cosol.jp/techdb/2020/08/oracle-se2-multi-az-deploy-on-aws-ec2-using-dbvisit-standby/)

* [MySQL](https://github.com/LowyShin/KnowledgeBase/tree/master/wiki/MySQL)
  * 同時4000トランザクション未満の3GB未満データでは一番軽く早いDBMSです。しかし容量と同時接続が増えるほど設計能力がパフォーマンスに直結するため拡張を考えるなら真剣に拡張設計から考慮することを推奨します。
  * [Ezis - RDBMS Monitoring](https://github.com/LowyShin/ezis-jp)
  * [my.cnf](https://github.com/LowyShin/KnowledgeBase/wiki/my.cnf)
  * [Replication](https://talklowykr.blogspot.com/2021/03/mysql-replication.html)
  * [backup](https://github.com/LowyShin/KnowledgeBase/tree/master/wiki/MySQL)
  * [MMM-MultiMaster](https://talklowy-jp.blogspot.com/2014/08/mysql-mmm-multi-master-ha.html)
  * [semaphore bug](https://github.com/LowyShin/KnowledgeBase/blob/master/wiki/MySQL/semaphorebug.md)
* [mariadb](https://github.com/LowyShin/KnowledgeBase/tree/master/wiki/mariadb)
  * MySQLエンジンを使って分離されたDBMSですが、今はエンジンもかなり異なっておりスピードより拡張を考慮して発展し続いているDBMSです。4台以上の分散が必要な場合分散及び管理がより簡単にできますが、台数が増えても性能は上がることではないので分散設計は人の力に依存します。
  * [Ezis - RDBMS Monitoring](https://github.com/LowyShin/ezis-jp)

* [Redis with MySQL](https://github.com/LowyShin/KnowledgeBase/blob/master/wiki/Redis/README.md)
  * DBMSのIO負荷を下げる中間DBMSとしてよく使われておりますが、KVS(Key Value Store)構造のメモリ保管モジュールなので色んな役割で使いこなすとすごい力になると思います。しかし、単純にCluster DB Cacheなどの意味で使ってしまうと逆に同期の問題で性能があまり出ないこともあるので十分知ってから使うことを推奨します。
* [Mongodb](https://github.com/LowyShin/KnowledgeBase/blob/master/wiki/mongodb)
  * ドキュメントデータベースとかに言われたりするHadoopと共にNoSQLの代表になりましたが、RDBMSではないのでRDBMSみたいにJoinをかけたりすると一般RDBMSよりもパフォーマンスが出ないこともあります。なのでNoSQLに入れるべきUnstructured(非構造)データを非正規化していかに高性能に使うかを考慮して設計しないと普通の大量テキストストレージになってしまうのでご注意を！
* [Apache-Drill](https://github.com/LowyShin/KnowledgeBase/wiki/Apache-Drill)
  * Apache財団から推しているデータ抽出ツールでRDBMSとNoSQL、CSVなどのファイルデータなどをすべて一つのSQLで抽出できる強力なツールです。しかしインストールされたOSの言語とデータのCharactersetによって文字化けが多いので十分な工夫が必要です。NoSQLなどの非定型データとRDBMSのJoinが楽なのでデータ変換に時間をかけている場合は検討を推奨します。
  * Visualization機能がないのでもしレポート・グラフなどのビジュアル系が好みだったら[Tableau](https://github.com/LowyShin/KnowledgeBase/tree/master/wiki/tableau)をお勧めします。TableauはNoSQLとRDBMSのJoinまではできませんが、ある程度処理（Preparation, プレパレーションツール）をしたデータの分析及びグラフ出力には優れたツールです。
* [A5MK2-MultiDBMSTool](https://github.com/LowyShin/KnowledgeBase/wiki/A5MK2)
* [BI](https://github.com/LowyShin/KnowledgeBase/wiki/BI)
  * Tableau, Google Data Portal, Redash and BI, data visualization tools
* [Referrals](https://github.com/LowyShin/KnowledgeBase/wiki/Referrals)
* [Kaggle: Your Machine Learning and Data Science Community](https://www.kaggle.com/)

### [BlockChain](https://github.com/LowyShin/KnowledgeBase/tree/master/wiki/blockchain)

* [仮想通貨(Crypto Currency)]
  * [BitCoin](https://ja.wikipedia.org/wiki/%E3%83%93%E3%83%83%E3%83%88%E3%82%B3%E3%82%A4%E3%83%B3)
    * [Source](https://github.com/bitcoin/bitcoin)
  * [Ethereum](https://en.wikipedia.org/wiki/Ethereum)
    * [Source](https://github.com/ethereum)
* [Wallets](https://github.com/LowyShin/KnowledgeBase/tree/master/wiki/blockchain#wallets)
* [Mining](https://github.com/LowyShin/KnowledgeBase/blob/master/wiki/mining/README.md)
* [Exchanges()取引所]
  * [GMO Coin Z](https://coin.z.com/)
  * [Huobi](https://www.huobi.co.jp/)
  * [Liquid](https://www.liquid.com/)
* [コピートレードに気をつけろ！](https://github.com/LowyShin/KnowledgeBase/blob/master/wiki/blockchain/copytrade.md)

### [Development](https://talklowy-jp.blogspot.com/2022/03/blog-post.html)

* [nodejs](https://github.com/LowyShin/KnowledgeBase/tree/master/wiki/nodejs)
* [Flutter](https://github.com/LowyShin/KnowledgeBase/tree/master/wiki/flutter)
  * nodesjからインストールできるWeb/Android/iOSを一気に開発できるツール。コードの修正があまりいらなくnodejsからの様々な追加機能の活用ができる。
* [GAS(Google Apps Script)](https://github.com/LowyShin/KnowledgeBase/blob/master/wiki/google/google-apps-script.md)
  * Google SheetまたはGoogle Appsをスクリプトでプログラミングができる。
* [Reactに有利なベンチマークを作ってみた](https://qiita.com/uhyo/items/35cb243557df5e1a87fc)
  * Reactが高負荷状態でのレンダリングスピードが速いため複雑な開発が必要な場合には向いてるとのこと
* [DataVisual](https://observablehq.com/@d3/gallery)
* [Python](https://github.com/LowyShin/KnowledgeBase/wiki/Python)
* [Classic ASP](https://github.com/LowyShin/KB-ClassicASP/blob/master/README.md)
  * MicrosoftからC#の拡散のために強制サポート中止されて軽いVBベースのWeb用スクリプト言語。
  * 軽くて簡単なので今でも使っているサービスが多い
* [wsf/vbs/vba](https://github.com/LowyShin/KB-ClassicASP/wiki/wsf)
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
* [WinAutomation(official)](https://docs.winautomation.com/V9_0/en/winautomation.html)


### Tools

* [ezis - DBパフォーマンス分析ツール(日本語公式)](https://github.com/LowyShin/ezis-jp)
  * RDBMS(ORACLE, SQL Server, MySQL, Mariadb, PostgreSQL)のエンジンからデータを取得し、強力なパフォーマンス情報が収集できて過去時点に戻って原因分析などができるツール
* [wappalyzer - Analysis dev environment bu URL ](https://chrome.google.com/webstore/detail/wappalyzer-technology-pro/gppongmhjkpfnbhagpmjfkannfbllamg/related)
  * Chrome Add-onでWebサイトに接続して実行すると開発環境をすべて分析してくれる
  * ![wappalyzer](https://github.com/LowyShin/KnowledgeBase/blob/master/images/chrome/wappalyzer-giipasp.png)
* [Juliaの自動微分パッケージ Zygote の紹介](https://pseudo-theory-of-everything.hatenablog.com/entry/2021/04/12/220015)
* [color code table](https://www.colordic.org/)
  * HTML Color Code
* [Canva - free Online Design tool](https://www.canva.com/)
  * Photoshopと同じくらいのイメージリタッチなどができるツール
* [vscode](https://github.com/LowyShin/KnowledgeBase/blob/master/wiki/vscode/README.md)
  * Microsoft社から提供する強力な無料開発ツール。様々な言語の開発及びDBへの接続・モバイル仮想端末の起動・管理などこれ一本できるほど多いadd-onがある。
* [git(github)](https://github.com/LowyShin/KnowledgeBase/tree/master/wiki/git)
  * git・github関連のTip
* [GoogleSheet](https://github.com/LowyShin/KnowledgeBase/wiki/GSheet)
  * Google Sheet利用に便利な内容
* [Excel](https://github.com/LowyShin/KnowledgeBase/tree/master/wiki/excel)
* [VNC](https://github.com/LowyShin/KnowledgeBase/wiki/VNC)
* [VPN](https://github.com/LowyShin/KnowledgeBase/wiki/VPN)
* [Note Tool](https://github.com/LowyShin/KnowledgeBase/wiki/Note-Tool)
* [Blog](https://github.com/LowyShin/KnowledgeBase/wiki/Blog)
* [google news alert](https://www.google.com/alerts#)
* [Online PDF to JPG](https://pdftoimage.com/ja/)
* [LoadTest](https://github.com/LowyShin/KnowledgeBase/blob/master/wiki/Tools/LoadTest.md)
" [putty](https://github.com/LowyShin/KnowledgeBase/tree/master/wiki/putty)
* [VirtualBox](https://www.virtualbox.org/)
  * [MacOSでの新バージョンVirtual Box実行時mac verr_vm_driver_not_installed (-1908)回避](https://www.nemotos.net/?p=3707)

### Management

* [Shell/bash](https://github.com/LowyShin/KnowledgeBase/wiki/Shell)
* [crontab](https://github.com/LowyShin/KnowledgeBase/wiki/crontab)
* [Windows PowerShell](https://github.com/LowyShin/KnowledgeBase/tree/master/wiki/ps1)
* [Windows(DOS) batch](https://github.com/LowyShin/KnowledgeBase/wiki/WinBatch)
* [Wscript/wsf](https://github.com/LowyShin/KnowledgeBase/wiki/Wscript)
* [AWS](https://github.com/LowyShin/KnowledgeBase/tree/master/wiki/AWS)
  * [アベイラビリティーゾーンを使用できるかを確認する](https://aws.amazon.com/jp/premiumsupport/knowledge-center/vpc-find-availability-zone-options/)
* [Azure](https://github.com/LowyShin/KnowledgeBase/blob/master/wiki/azure/README.md)
  * [仮想マシン スケールセット を試す](https://www.cloudou.net/virtual-machine-scale-sets/vmss001/)
* [File Sync(rsync, scp...)](https://github.com/LowyShin/KnowledgeBase/wiki/Sync)
* [KnownPort(wikipedia)](https://en.wikipedia.org/wiki/List_of_TCP_and_UDP_port_numbers)

### Security

* [Trend Micro]()


### Storage

* [GFS(Google File System) Architecture](https://medium.com/geekculture/google-file-system-architecture-cdeabef3f1ea)
* [alluxio](https://www.alluxio.io/)
* [Ceph](https://ceph.io/)
* [apache cloudstack](https://cloudstack.apache.org/)
* [Free NAS](https://www.freenas.org/)
* [Apache Hadoop](https://hadoop.apache.org/)
* [lustre](http://lustre.org/)
* [openmediavault](https://www.openmediavault.org/)
  * openmediavault is the next generation network attached storage (NAS) solution based on Debian Linux. It contains services like SSH, (S)FTP, SMB/CIFS, DAAP media server, RSync, BitTorrent client and many more. Thanks to the modular design of the framework it can be enhanced via plugins.
* [openstack](https://www.openstack.org/)
* [pydio](https://pydio.com/)
* [raider](http://raider.sourceforge.net/)
  * 	Raider is a tool to automate linux software raid conversion.
It is able to convert a single linux system disk in to a software raid 1, 4, 5, 6 or 10 system in a two-pass simple command.
* [sheepdog](http://sheepdog.github.io/sheepdog/)
  * Sheepdog is a distributed object storage system for volume and container services and manages the disks and nodes intelligently. Sheepdog features ease of use, simplicity of code and can scale out to thousands of nodes.
  * ![sheepdog structure](http://sheepdog.github.io/sheepdog/_images/overview.png)
* [snapraid](http://www.snapraid.it/)
  * backup program for disk arrays. It stores parity information of your data and it recovers from up to six disk failures.

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
* [Apple M2 vs Intel Core i9-12900K](https://www.cpu-monkey.com/ja/compare_cpu-apple_m2-vs-intel_core_i9_12900k)
* [Rosetta 2のx86からarm64への変換はどのように動作するのか](https://www.infoq.com/jp/news/2021/01/rosetta-2-translation/)
* [[ARMv8-A](https://developer.arm.com/documentation/den0024/a/ARMv8-Models/ARMv8-A-Foundation-Platform)](https://developer.arm.com/documentation/den0024/a/ARMv8-Models/ARMv8-A-Foundation-Platform)
![ARMv8-A](https://github.com/LowyShin/KnowledgeBase/blob/master/images/tech/ARMv8-A-Architecture.svg)

### Japan Environment

* [livance Net(生保共同ネットワーク)](http://www.livance-net.com/content/index2.html)
* [JWNet(産業廃棄物電子マニフェスト)](https://www.jwnet.or.jp/jwnet/index.html)

### Business

* global
  * https://angel.co/
    * Remote Job and Startup Job Search | AngelList Talent
  * [Dev Outsourcing](https://github.com/LowyShin/KnowledgeBase/blob/master/wiki/Business/DevOutsourcing.md)
  * [flywire - easy payment gateway](https://www.flywire.com/)
* jp
  * [Startup checkpoint(jp)](https://github.com/LowyShin/KnowledgeBase/wiki/StartupChkJP)
  * [バーコード検索：JANコードの基礎知識から検索の仕方まで徹底解説](https://orange-operation.jp/pos/16452.html)
    * 日本の製品情報をバーコードで検索する方法とサイトの紹介
  * [スタートアップ企業リスト](https://startup-db.com/companies)
  * [中小企業向け補助金・総合支援サイト - ミラサポPlus - 経済産業省](https://mirasapo-plus.go.jp/subsidy/ithojo/)
    * IT導入補助金を活用して安くITを導入しましょう！
  * [Makeshop Reseller partner(jp)](https://www.makeshop.jp/partner/reseller_partner.html)
  * [BINDupホームページ自動作成](https://bindup.jp/plan/)
  * [日本法人検索(中小機構)](https://tdb.smrj.go.jp/corpinfo/corporate/search#o)
  * [法人関連オンライン簡単申請サービス - GVA](https://corporate.ai-con.lawyer/)
  * [WeWork Japan](https://ultimate-setsuko.com/business/wework/)
* kr
  * [for Korean](kr)

### Job&Hire

* [Lancers(jp)](https://www.lancers.jp)
  * 日本国内最大のフリーランサーが集まって仕事を依頼・受注するサービス。
* [Yahoo! 副業](https://sidejob.yahoo.co.jp/jobs)
* [LAPRAS Freelanceはフリーランス・副業エンジニア紹介](https://freelance.lapras.com/)
  * LAPRAS Freelance,LAPRAS株式会社,LAPRAS,ラプラス,ラプラス フリーランス,人工知能,HR Tech,laprasfreelance

### Hobby

* [VR(VirutualReality)](https://github.com/LowyShin/KnowledgeBase/tree/master/wiki/vr)
  * Oculus Quest 2
    * [Immersed](https://github.com/LowyShin/KnowledgeBase/blob/master/wiki/vr/immersed.md)
* [AR - A glimpse of the future through an augmented reality headset - Meron Gribetz](https://www.ted.com/talks/meron_gribetz_a_glimpse_of_the_future_through_an_augmented_reality_headset?language=en)
* [Lithum-ion Battery](https://github.com/LowyShin/KnowledgeBase/blob/master/wiki/Hobby/Lithium-ion-Battery.md)
* [Ebike](https://github.com/LowyShin/KnowledgeBase/blob/master/wiki/Hobby/EBike.md)
* [Fountain Pen ink cartridge guide](https://unsharpen.com/fountain-pen-cartridge-guide/)
* [住宅も3Dプリンターで価格革命](https://youtu.be/kTeysI5U-xw)
* [ロングセラー確実！？「iPhone SE」（第3世代）は買って損なしの圧倒的な安心感が魅力](https://github.com/LowyShin/KnowledgeBase/blob/master/wiki/Hobby/iphonese20220325.md)
* [Electronic goods](https://github.com/LowyShin/KnowledgeBase/wiki/Electronic-goods)
* [キズの付いたCDを修復する方法](https://www.wikihow.jp/%E3%82%AD%E3%82%BA%E3%81%AE%E4%BB%98%E3%81%84%E3%81%9FCD%E3%82%92%E4%BF%AE%E5%BE%A9%E3%81%99%E3%82%8B)
* [プラスチックについた傷を消す方法](https://www.wikihow.jp/%E3%83%97%E3%83%A9%E3%82%B9%E3%83%81%E3%83%83%E3%82%AF%E3%81%AB%E3%81%A4%E3%81%84%E3%81%9F%E5%82%B7%E3%82%92%E6%B6%88%E3%81%99)
* [aerodrone - 1万円台の高性能ドローン](https://get-aerodrone.com/)

### Crowd Funding

* [MAKUAKE](https://www.makuake.com/)
  * これまで世の中になかった新しい製品やサービスが毎日登場！作り手や担い手の想いを知り、応援の気持ちを込めた購入体験ができるサービスです。
* [CAPMFIRE](https://camp-fire.jp/)
  * 国内最大のクラウドファンディング。テクノロジー、ソーシャルグッド、ファッション、ローカル、飲食、音楽、アート、映画、ゲーム、アニメなど、掲載件数は42,000件以上。
* [READYFOR](https://readyfor.jp/)
  * READYFOR, レディーフォー, クラウドファンディング, ソーシャルファンディング, 資金調達, 米良はるか, クリエーター

### TED

* [How great leaders inspire action](https://www.ted.com/talks/simon_sinek_how_great_leaders_inspire_action)

### [Lifestyle](wiki/Lifestyle)

* [賃貸](https://github.com/LowyShin/KnowledgeBase/blob/master/wiki/Lifestyle/rentalhouse.md)
* [Share House](https://github.com/LowyShin/KnowledgeBase/blob/master/wiki/Lifestyle/Sharehouse.md)
* [一人お引越し - クロネコヤマト](https://www.008008.jp/moving/single/)
  * 福岡から東京まで引っ越しした場合相場が20万円ほどです（1人の場合）。クロネコヤマトのパレットに自分で詰め込めば4万円程でお引越しができます！
* [国際郵便マイページサービス](https://www.int-mypage.post.japanpost.jp/mypage/M010000.do)
  * 国際郵便の送り状登録及び印刷が簡単にできる郵便局公式サービス

## Giip(RPA Engine)

* [giip docs](https://github.com/LowyShin/giip)
* [giip website](https://giipasp.azurewebsites.net)


## Dictionary

* [BigEndian(ビッグエンディアン)](dic/b/bigendian.md)



## etc

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
