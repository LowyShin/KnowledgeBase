# Azure Event Hub

Azure Event Hubs はビッグ データ ストリーミング プラットフォームであり、毎秒数百万のイベントを受け取って処理できるイベント インジェスト サービスです。 Event Hubs では、分散されたソフトウェアやデバイスから生成されるイベント、データ、またはテレメトリを処理および格納できます。 

## Event Hub 基礎

### Event Hubの作成

1. [リソース グループを作成する](https://learn.microsoft.com/ja-jp/azure/event-hubs/event-hubs-create#create-a-resource-group)https://learn.microsoft.com/ja-jp/azure/event-hubs/event-hubs-create#create-a-resource-group

2. [Event Hubs 名前空間を作成します](https://learn.microsoft.com/ja-jp/azure/event-hubs/event-hubs-create#create-an-event-hubs-namespace)https://learn.microsoft.com/ja-jp/azure/event-hubs/event-hubs-create#create-an-event-hubs-namespace

3. [イベント ハブの作成](https://learn.microsoft.com/ja-jp/azure/event-hubs/event-hubs-create#create-an-event-hub)https://learn.microsoft.com/ja-jp/azure/event-hubs/event-hubs-create#create-an-event-hub

### バッチ イベントを送信する

ADF, ACI等異なる環境からのバッチが混ざっている場合実行状況を管理する必要ばあります。
この場合使いやすいのがイベントハブになります。イベントハブにデータを格納する方法もありますが、すでにDWまたは個別のSQL Databaseを使っている場合わざわざイベントハブにデータを格納せずにイベントだけ入れて監視する方法がいいと思います。

イベントの送信例
```sh
POST https://your-namespace.servicebus.windows.net/your-event-hub/messages?timeout=60&api-version=2014-01 HTTP/1.1  
Authorization: SharedAccessSignature sr=your-namespace.servicebus.windows.net&sig=your-sas-key&se=1456197782&skn=RootManageSharedAccessKey  
Content-Type: application/vnd.microsoft.servicebus.json  
Host: your-namespace.servicebus.windows.net  
  
[{"Body":"Message1", "UserProperties":{"Alert":"Strong Wind"}},{"Body":"Message2"},{"Body":"Message3"}]
```

- [イベント送信APIの説明](https://learn.microsoft.com/ja-jp/rest/api/eventhub/send-batch-events)
- [Pythonを利用したイベント送信及び受信](https://learn.microsoft.com/ja-jp/azure/event-hubs/event-hubs-python-get-started-send?tabs=passwordless%2Croles-azure-portal)


![AzureEventHub drawio](https://github.com/LowyShin/KnowledgeBase/assets/20239203/e009bfaf-9a4a-4ff0-bad3-bda9efe843da)


### おまけ

設定が複雑なのでシンプルに状態をストレージアカウントに入れてチェックするのもありです。

1. Batchが終わったらバッチの順番をテキストファイル化してアップロードする
   - https://learn.microsoft.com/en-us/azure/storage/blobs/storage-blob-upload-python
2. アップしたファイルを次のバッチがチェックしまだ前回のバッチが終了してなかったら1分待つ、の繰り返し。

