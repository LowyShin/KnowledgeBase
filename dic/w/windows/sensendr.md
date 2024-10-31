# SenseNdr.exe

## 概要

SenseというサービスはMsSense.exeから実行が出来てWindows Defender Advanced Threat Protection Service サービスが起動します。

これは`get-service sense`で稼働中の確認ができます。

その中でネットワークデバイスからのデータ収取にはSenseNdr.exeを起動して収集している模様です。

https://learn.microsoft.com/ja-jp/microsoft-365/security/defender-endpoint/device-discovery?view=o365-worldwide

エンドポイントはネットワーク内のイベントをパッシブに収集し、そこからデバイス情報を抽出します。

基本的な検出では、パッシブ ネットワーク データ収集に SenseNDR.exe バイナリが使用され、ネットワーク トラフィックは開始されません。

エンドポイントは、オンボードされたデバイスによって見られるすべてのネットワーク トラフィックからデータを抽出するだけです。 

基本的な検出では、ネットワーク内のアンマネージド エンドポイントの可視性が制限されます。


### 無効化

この機能の無効化することは可能です。

https://learn.microsoft.com/ja-jp/microsoft-365/security/defender-endpoint/device-discovery-faq?view=o365-worldwide

[ 高度な機能 ] ページでデバイス検出を無効にするオプションがあります。

ただし、ネットワーク内のアンマネージド デバイスの可視性は失われます。

SenseNDR.exeは、検出がオフになっているかどうかにかかわらず、オンボードされたデバイスで引き続き実行されることに注意してください。

ネットワーク上の新しく追加したデバイスの可視性が失われるのでサービス自体には問題ないと思われます。


→可視性というところを探してみたらMicrosoft 365 security consoleという管理ページがあってそのページへの可視性が失われるだけで他には影響がないようです。


https://www.channelpronetwork.com/blog/entry/new-microsoft-defender-enpoint-blog-endpoint-discovery-navigating-your-way-through
