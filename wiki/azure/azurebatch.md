# Azure Batch

公式 : https://azure.microsoft.com/ja-jp/products/batch

### 特徴

- 何十台、何百台から何千台もの仮想マシンに拡張可能
- データのステージングおよびコンピューティング パイプラインの実行
- キュー内の作業の自動スケール機能
- クラウド対応のバッチ アプリケーションと HPC アプリケーション
- Linux または Windows を選択してジョブを実行可能
- 資本投資せずに使用分のみ従量課金


## Azure における統合と自動化の適切なサービスを選ぶ

### [Microsoft Power Automate](https://make.powerautomate.com/) (旧称 Microsoft Flow)
### [Azure Logic Apps](https://azure.microsoft.com/ja-jp/products/logic-apps/)
### [Azure Functions](https://azure.microsoft.com/ja-jp/products/functions/)
### [Azure App Service WebJobs](https://learn.microsoft.com/ja-jp/azure/app-service/webjobs-create)

## 比較

### Microsoft Power Automate vs. Azure Logic Apps

Power Automate と Azure Logic Apps はどちらも、ワークフローを作成できる "デザイナー第一" の統合サービスです。 どちらのサービスも、各種の SaaS アプリケーションやエンタープライズ アプリケーションと統合されます。

<table>
<thead>
<tr>
<th></th>
<th>Power Automate</th>
<th>Logic Apps</th>
</tr>
</thead>
<tbody>
<tr>
<td><strong>ユーザー</strong></td>
<td>オフィスの従業員、ビジネス ユーザー、SharePoint 管理者</td>
<td>インテグレーター、開発者、IT プロフェッショナル</td>
</tr>
<tr>
<td><strong>シナリオ</strong></td>
<td>セルフ サービス</td>
<td>高度な統合</td>
</tr>
<tr>
<td><strong>デザイン ツール</strong></td>
<td>ブラウザー上とモバイル アプリ、UI のみ</td>
<td>コード ビューを利用できるブラウザー上、<a href="https://learn.microsoft.com/ja-jp/azure/logic-apps/quickstart-create-logic-apps-visual-studio-code" data-linktype="relative-path">Visual Studio Code</a>、<a href="https://learn.microsoft.com/ja-jp/azure/logic-apps/quickstart-create-logic-apps-with-visual-studio" data-linktype="relative-path">Visual Studio</a></td>
</tr>
<tr>
<td><strong>アプリケーション ライフサイクル管理 (ALM)</strong></td>
<td>Power Platform には、DevOps および <a href="https://learn.microsoft.com/ja-jp/power-platform/alm/devops-github-actions" data-linktype="absolute-path">GitHub Actions</a> と連携して、ALM サイクルで自動化されたパイプラインを構築できる<a href="https://learn.microsoft.com/ja-jp/power-platform/alm/tools-apps-used-alm" data-linktype="absolute-path">ツールが用意されています(ALM, Application Lifecycle Management)</a>。</td>
<td>Azure DevOps: <a href="https://learn.microsoft.com/ja-jp/azure/logic-apps/logic-apps-azure-resource-manager-templates-overview" data-linktype="relative-path">Azure Resource Manager</a> におけるソース管理、テスト、サポート、自動化、管理</td>
</tr>
<tr>
<td><strong>管理者向けエクスペリエンス</strong></td>
<td>Microsoft Power Automate 環境とデータ損失防止 (DLP) ポリシーの管理、ライセンスの追跡: <a href="https://admin.powerplatform.microsoft.com" data-linktype="external">管理センター</a></td>
<td>リソース グループ、接続、アクセス管理、およびログ記録の管理: <a href="https://portal.azure.com" data-linktype="external">Azure Portal</a></td>
</tr>
<tr>
<td><strong>Security</strong></td>
<td>Microsoft 365 セキュリティ監査ログ、DLP、機密データの<a href="https://wikipedia.org/wiki/Data_at_rest#Encryption" data-linktype="external">保存時の暗号化</a></td>
<td>Azure によるセキュリティ保証: <a href="https://www.microsoft.com/en-us/trustcenter/Security/AzureSecurity" data-linktype="external">Azure セキュリティ</a>、<a href="https://azure.microsoft.com/services/security-center/" data-linktype="external">Microsoft Defender for Cloud</a>、<a href="https://azure.microsoft.com/blog/azure-audit-logs-ux-refresh/" data-linktype="external">監査ログ</a></td>
</tr>
</tbody>
</table>

### Azure Functions vs. Azure Logic Apps

Azure Functions では、コードを記述したり [Durable Functions 拡張機能](https://learn.microsoft.com/ja-jp/azure/azure-functions/durable/durable-functions-overview?tabs=csharp-inproc)を使用したりすることによって、オーケストレーションを開発します。 Azure Logic Apps では、GUI を使用するか構成ファイルを編集することによってオーケストレーションを作成します。

<table>
<thead>
<tr>
<th></th>
<th>Durable Functions</th>
<th>Azure Logic Apps</th>
</tr>
</thead>
<tbody>
<tr>
<td><strong>開発</strong></td>
<td>コード第一 (命令型)</td>
<td>デザイナー第一 (宣言型)</td>
</tr>
<tr>
<td><strong>接続</strong></td>
<td><a href="https://learn.microsoft.com/ja-jp/azure/azure-functions/functions-triggers-bindings?tabs=csharp#supported-bindings" data-linktype="relative-path">ビルトインのバインド (約 10 種類)</a> およびカスタム バインド (コードを記述)</td>
<td><a href="https://learn.microsoft.com/ja-jp/connectors/connector-reference/connector-reference-logicapps-connectors" data-linktype="absolute-path">コネクタの豊富なコレクション</a>、
  <a href="https://learn.microsoft.com/ja-jp/azure/logic-apps/logic-apps-enterprise-integration-overview" data-linktype="relative-path">Enterprise Integration Pack (B2B のシナリオ向け)</a>、
  <a href="https://learn.microsoft.com/ja-jp/connectors/custom-connectors/" data-linktype="absolute-path">カスタム コネクタの構築</a></td>
</tr>
<tr>
<td><strong>アクション</strong></td>
<td>個々のアクティビティは Azure 関数 (アクティビティ関数のコードを記述する)</td>
<td><a href="https://learn.microsoft.com/ja-jp/connectors/connector-reference/connector-reference-logicapps-connectors" data-linktype="absolute-path">既製のアクションの豊富なコレクション</a></td>
</tr>
<tr>
<td><strong>Monitoring</strong></td>
<td><a href="https://learn.microsoft.com/ja-jp/azure/azure-monitor/app/app-insights-overview?tabs=net" data-linktype="relative-path">Azure Application Insights</a></td>
<td><a href="https://learn.microsoft.com/ja-jp/azure/logic-apps/quickstart-create-example-consumption-workflow" data-linktype="relative-path">Azure portal</a>、
  <a href="https://learn.microsoft.com/ja-jp/azure/logic-apps/monitor-workflows-collect-diagnostic-data?tabs=consumption" data-linktype="relative-path">Azure Monitor ログ</a>、
  <a href="https://learn.microsoft.com/ja-jp/azure/logic-apps/healthy-unhealthy-resource" data-linktype="relative-path">Microsoft Defender for Cloud</a></td>
</tr>
<tr>
<td><strong>管理</strong></td>
<td><a href="https://learn.microsoft.com/ja-jp/azure/azure-functions/durable/durable-functions-http-api" data-linktype="relative-path">REST API</a>、
  <a href="https://learn.microsoft.com/ja-jp/visualstudio/azure/vs-azure-tools-resources-managing-with-cloud-explorer?view=vs-2019" data-linktype="absolute-path">Visual Studio</a></td>
<td><a href="https://learn.microsoft.com/ja-jp/azure/logic-apps/quickstart-create-example-consumption-workflow" data-linktype="relative-path">Azure Portal</a>、
  <a href="https://learn.microsoft.com/ja-jp/rest/api/logic/" data-linktype="absolute-path">REST API</a>、
  <a href="https://learn.microsoft.com/ja-jp/powershell/module/az.logicapp/?view=azps-10.1.0" data-linktype="absolute-path">PowerShell</a>、
  <a href="https://learn.microsoft.com/ja-jp/azure/logic-apps/manage-logic-apps-with-visual-studio" data-linktype="relative-path">Visual Studio</a></td>
</tr>
<tr>
<td><strong>実行コンテキスト</strong></td>
<td><a href="https://learn.microsoft.com/ja-jp/azure/azure-functions/functions-kubernetes-keda" data-linktype="relative-path">ローカル</a>またはクラウドで実行できます</td>
<td>Azure、ローカル、またはオンプレミスで実行されます。 詳細については、「<a href="https://learn.microsoft.com/ja-jp/azure/logic-apps/logic-apps-overview#resource-environment-differences" data-linktype="relative-path">Azure Logic Apps とは</a>」を参照してください。</td>
</tr>
</tbody>
</table>

### Azure Functions vs. WebJobs

<table>
<thead>
<tr>
<th></th>
<th>関数</th>
<th>WebJobs と WebJobs SDK</th>
</tr>
</thead>
<tbody>
<tr>
<td><strong><a href="https://azure.microsoft.com/solutions/serverless/" data-linktype="external">サーバーレスのアプリ モデル</a>と
  <a href="https://learn.microsoft.com/ja-jp/azure/azure-functions/event-driven-scaling?tabs=azure-cli" data-linktype="relative-path">自動スケーリング</a></strong></td>
<td>✔</td>
<td></td>
</tr>
<tr>
<td><strong><a href="https://learn.microsoft.com/ja-jp/azure/azure-functions/functions-get-started?pivots=programming-language-csharp" data-linktype="relative-path">ブラウザーでの開発とテスト</a></strong></td>
<td>✔</td>
<td></td>
</tr>
<tr>
<td><strong><a href="https://learn.microsoft.com/ja-jp/azure/azure-functions/consumption-plan" data-linktype="relative-path">従量課金制の価格</a></strong></td>
<td>✔</td>
<td></td>
</tr>
<tr>
<td><strong><a href="https://learn.microsoft.com/ja-jp/azure/azure-functions/functions-twitter-email" data-linktype="relative-path">Logic Apps との統合</a></strong></td>
<td>✔</td>
<td></td>
</tr>
<tr>
<td><strong>イベントのトリガー</strong></td>
<td><a href="https://learn.microsoft.com/ja-jp/azure/azure-functions/functions-bindings-timer?tabs=python-v2%2Cin-process&pivots=programming-language-csharp" data-linktype="relative-path">Timer</a><br>
  <a href="https://learn.microsoft.com/ja-jp/azure/azure-functions/functions-bindings-storage-blob?tabs=in-process%2Cextensionv5%2Cextensionv3&pivots=programming-language-csharp" data-linktype="relative-path">Azure Storage キューと BLOB</a><br>
  <a href="https://learn.microsoft.com/ja-jp/azure/azure-functions/functions-bindings-service-bus?tabs=in-process%2Cextensionv5%2Cextensionv3&pivots=programming-language-csharp" data-linktype="relative-path">Azure Service Bus のキューとトピック</a><br>
  <a href="https://learn.microsoft.com/ja-jp/azure/azure-functions/functions-bindings-cosmosdb?tabs=csharp" data-linktype="relative-path">Azure Cosmos DB</a><br>
  <a href="https://learn.microsoft.com/ja-jp/azure/azure-functions/functions-bindings-event-hubs?tabs=in-process%2Cextensionv5&pivots=programming-language-csharp" data-linktype="relative-path">Azure Event Hubs</a><br>
  <a href="https://learn.microsoft.com/ja-jp/azure/azure-functions/functions-bindings-http-webhook?tabs=in-process%2Cfunctionsv2&pivots=programming-language-csharp" data-linktype="relative-path">HTTP/WebHook (GitHub、Slack)</a><br>
  <a href="https://learn.microsoft.com/ja-jp/azure/azure-functions/functions-bindings-event-grid?tabs=in-process%2Cextensionv3&pivots=programming-language-csharp" data-linktype="relative-path">Azure Event Grid</a></td>
<td><a href="https://learn.microsoft.com/ja-jp/azure/azure-functions/functions-bindings-timer?tabs=python-v2%2Cin-process&pivots=programming-language-csharp" data-linktype="relative-path">Timer</a><br>
  <a href="https://learn.microsoft.com/ja-jp/azure/azure-functions/functions-bindings-storage-blob?tabs=in-process%2Cextensionv5%2Cextensionv3&pivots=programming-language-csharp" data-linktype="relative-path">Azure Storage キューと BLOB</a><br>
  <a href="https://learn.microsoft.com/ja-jp/azure/azure-functions/functions-bindings-service-bus?tabs=in-process%2Cextensionv5%2Cextensionv3&pivots=programming-language-csharp" data-linktype="relative-path">Azure Service Bus のキューとトピック</a><br>
  <a href="https://learn.microsoft.com/ja-jp/azure/azure-functions/functions-bindings-cosmosdb?tabs=csharp" data-linktype="relative-path">Azure Cosmos DB</a><br>
  <a href="https://learn.microsoft.com/ja-jp/azure/azure-functions/functions-bindings-event-hubs?tabs=in-process%2Cextensionv5&pivots=programming-language-csharp" data-linktype="relative-path">Azure Event Hubs</a><br>
  <a href="https://github.com/Azure/azure-webjobs-sdk-extensions/blob/master/src/WebJobs.Extensions/Extensions/Files/FileTriggerAttribute.cs" data-linktype="external">ファイル システム</a></td>
</tr>
<tr>
<td><strong>サポートされている言語</strong></td>
<td>C#<br>F#<br>JavaScript<br>Java<br>Python<br>PowerShell</td>
<td>C#<sup>1</sup></td>
</tr>
<tr>
<td><strong>パッケージ マネージャー</strong></td>
<td>npm と NuGet</td>
<td>NuGet<sup>2</sup></td>
</tr>
</tbody>
</table>


### Azure Functions は、Azure App Service WebJobs よりも開発者の生産性を向上させます。 また、プログラミング言語、開発環境、Azure サービスの統合、および価格に関して、より多くのオプションが提供されます。 ほとんどの場合、それが最適な選択肢になるでしょう。

WebJobs が最適な選択肢となるシナリオは 2 つです。それらを次に示します。

- イベントをリッスンするコード (JobHost オブジェクト) をより細かく制御する必要がある。 Functions では、JobHost ファイルで JobHost の動作をカスタマイズする方法に限りがあります。 JSON ファイル内の文字列で指定できる範囲を超えた作業も、ときには必要になります。 たとえば、Azure Storage のカスタム再試行ポリシーを構成できるのは、WebJobs SDK だけです。
- コード スニペットの実行対象の App Service アプリがあり、そのコード スニペットをアプリと同じ Azure DevOps 環境で管理したい。

その他のシナリオで、Azure またはサードパーティのサービスと連携するコード スニペットを実行する場合は、WebJobs と WebJobs SDK の組み合わせよりも、Azure Functions を選ぶようにしてください。



## Reference

