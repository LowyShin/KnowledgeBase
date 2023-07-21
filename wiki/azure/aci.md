# Azure Container Instance(ACI)

Linux Container Serviceと呼ばれる隔離された環境を提供するサービスから出発したコンテナサービスはAzureの場合はACIにAWSの場合は Amazon ECSなどで提供されています。

コンテナはそもそも異なるアプリケーション環境を一つのOS上で稼働させサーバー台数を減らす目的で開発されていたのでその根本的な機能をしておいたら活用範囲が分かると思います。

![Linux Container Service](https://www.redhat.com/rhdc/managed-files/what-is-a-container.png)

最近コンテナサービスに合わせられるような環境も増えてきたのでnode14とnode16を同時に起動させたりすることがしやすくなっています。この環境を丸ごと動かすことで既存のOSを丸ごとコピーするより遥かに少ない容量と展開リソースで最近VMより使われるようになりました。

コンテナサービスが必要な場合はこの記事をそのまま見ながら似たようなサービスと比べるのをお勧めします。
しかし自動化の管理だけを目的としてコンテナサービスは道具の一部だと思った方は[バッチっサービス](azurebatch.md)をご覧ください。

Azure Container Apps の条件に当てはまらなかったりそれほど多くの機能を必要としないような、単体で動くシンプルなアプリケーションやバッチ処理に適したサービスです。
公式ドキュメントのAzure Container Instancesによると、「オンデマンドで Hyper-V 分離コンテナーの単一ポッドが提供されます。」と説明されています。また、スケーリング・負荷分散(ロードバランシング)・証明書などの機能も提供されません。
Azure Container Instances はあくまで単一ポッドなので、複数コンテナの連携・オートスケーリングなどが必要な場合は Azure Kubernetes Service を使用して、間接的に Azure Container Instances を利用する方法が最適です。Kubernetes API への直接アクセスが必要ない場合は Azure Container Apps の利用が良いでしょう。

- 他のコンテナと連携が必要ない
- スケーリング・負荷分散(ロードバランシング)・証明書の機能が必要ない
- 単一で動くシンプルなアプリケーション
- バッチ処理

<table style="font-size: 0.7em; table-layout: fixed; width: 100%;">
    <tr style="background-color: #eee;">
        <td style="width: 10%;"></td>
        <td><a href="https://azure.microsoft.com/ja-jp/products/app-service/web/">Web App</a></td>
        <td><a href="https://azure.microsoft.com/ja-jp/products/functions/#overview">Azure Functions</a></td>
        <td><a href="https://azure.microsoft.com/ja-jp/products/container-instances/#overview">ACI</a></td>
        <td><a href="https://azure.microsoft.com/ja-jp/products/container-apps/#overview">ACA</a></td>
        <td><a href="https://azure.microsoft.com/ja-jp/products/kubernetes-service/#overview">AKS</a></td>
    </tr>
    <tr>
        <td>コンテナ以外のデプロイ手法</td>
        <td>ZIPデプロイ、Gitデプロイ等（ネイティブサポート言語のみ）</td>
        <td>一部のネイティブサポート言語に加えカスタムハンドラーにより別言語にも対応</td>
        <td>✖</td>
        <td>✖</td>
        <td>✖</td>
    </tr>
    <tr>
        <td>コンテナ利用時のプラン制約</td>
        <td>なし（F1でも可能）</td>
        <td>従量課金プラン不可（PremiumもしくはApp Service Planが必須）</td>
        <td>なし</td>
        <td>なし</td>
        <td>なし</td>
    </tr>
    <tr>
        <td>Windowsコンテナ</td>
        <td>対応</td>
        <td>✖</td>
        <td>対応</td>
        <td>✖</td>
        <td>対応</td>
    </tr>
    <tr>
        <td>マルチコンテナ</td>
        <td>
            docker-compose（プレビュー）<br>
            <a target="_blank" href="https://learn.microsoft.com/ja-jp/azure/app-service/configure-custom-container?pivots=container-linux#preview-limitations">App Serviceの機能制限あり</a><br>
            <a target="_blank" href="https://learn.microsoft.com/ja-jp/azure/app-service/configure-custom-container?pivots=container-linux#unsupported-options">docker-composeの機能制限あり</a>
        </td>
        <td>✖</td>
        <td>・Yamlテンプレート<br>・ARMテンプレート<br>・docker-compose（機能制約あり）</td>
        <td>対応</td>
        <td>対応</td>
    </tr>
    <tr>
        <td>0へのスケーリング</td>
        <td>✖</td>
        <td>✖</td>
        <td>✖（スケーリング自体に非対応）</td>
        <td>対応</td>
        <td>△（Userプールのみ0までスケーリング可能、cluster全体の停止オプションは別途あり）</td>
    </tr>
    <tr>
        <td>目的</td>
        <td>連続起動</td>
        <td>
            エフェメラルだが、コンテナ含む従量課金プラン対象外の機能利用時の課金は連続的<br>
            <a target="_blank" href="https://learn.microsoft.com/ja-jp/azure/azure-functions/functions-premium-plan?tabs=portal#billing">「すべての Premium プランには、常に 1 つ以上のアクティブな (課金された) インスタンスがあります。」</a>
        </td>
        <td>連続起動・エフェメラル（連続起動すると同一条件のWeb App for Containersより高くなりがち）</td>
        <td>連続起動・エフェメラル（連続起動時はACIより高額）</td>
        <td>連続起動・エフェメラル</td>
    </tr>
    <tr>
        <td>実行時間制限</td>
        <td>なし</td>
        <td>
            従量課金：最大10min<br>Premium：規定30min、
            <a target="_blank" href="https://learn.microsoft.com/ja-jp/azure/azure-functions/functions-premium-plan?tabs=portal#longer-run-duration">
                設定により無制限（60min保証）
            </a>
        </td>
        <td>無制限</td>
        <td>無制限</td>
        <td>無制限</td>
    </tr>
    <tr>
        <td>Kubernetes</td>
        <td>✖</td>
        <td>✖</td>
        <td>✖</td>
        <td>△（Kubernetesが内部で動いているがユーザーはKubernetes APIにアクセスできない）</td>
        <td>対応</td>
    </tr>
    <tr>
        <td>課金単位</td>
        <td>1時間あたり</td>
        <td>1秒あたり（従量課金プラン）</td>
        <td>1時間あたり</td>
        <td>1秒あたり</td>
        <td>1時間あたり</td>
    </tr>
    <tr>
        <td>無料枠</td>
        <td>無料プランあり</td>
        <td>従量課金プランのみ<br>40万GB秒<br>100万回の実行</td>
        <td>なし</td>
        <td>18万vCPU秒<br>36万GiB秒<br>200万リクエスト</td>
        <td>なし</td>
    </tr>
    <tr>
        <td>料金</td>
        <td>Free<br>Basic: 約2,000円/月<br>Std: 約12,000円/月<br>Prem: 約13,000円/月</td>
        <td>Premium: 常時稼働インスタンス1台のみで約26,000円/月</td>
        <td>RAM: 約600円/月･GiB<br>vCPU: 約5300円/月<br>別途GPUコンテナーあり</td>
        <td>RAM: 約1,100円/月･GiB<br>vCPU: 約9,000円/月<br>アイドル時は割引料金</td>
        <td>1番安いStandard B2sを1台で運用してもVMSSだけで約6,000円/月</td>
    </tr>
    <tr style="background-color: #eee;">
        <td style="width: 10%;"></td>
        <td>Web App</td>
        <td>Functions App</td>
        <td>ACI</td>
        <td>ACA</td>
        <td>AKS</td>
    </tr>
</table>

## 関連性高い機能

### Azure Container Apps

[Kubernetes](https://github.com/LowyShin/KnowledgeBase/blob/master/dic/k/kuubernetes.md) の機能や Dapr・KEDA・envoy などのオープンソースのテクノロジーを活かして、Kubernetes スタイルのアプリやマイクロサービスを作るのに向いたサービスです。
サービス自体は Kubernetes 基盤で構築されていますが、Kubernetes API への直接アクセスは提供されません。
Kubernetes の機能を活かしたいが 1 から構築する必要性・知見がない中で、ある程度ベストプラクティスに沿いたい場合に向いています。
汎用的なので、迷ったらこれでいいかなと思います。

- 汎用コンテナ
- 多くののマイクロサービスと関わるアプリケーション
- イベント駆動型アプリケーションアーキテクチャ
- 実行時間の長いプロセス

### Azure App Service

App Serviceの設定中コンテナを利用してAppを構成できる設定があります。ACIの設定をしてDeployすることができてサーバーレスコンテナサービスになります。
Web アプリケーションのためのサービスです。
フルマネージドで Web サイトや Web API を構築したいときに向いています。
Windows/Linux ベースで .NET、.NET Core、Java、Ruby、Node.js、PHP、Python から環境を選択します。
バックグラウンドタスクも同じインスタンス内で追加料金なしで実行可能です。

- Web サイト
- Web API

### Azure Kubernetes Service

[Kubernetes](https://github.com/LowyShin/KnowledgeBase/blob/master/dic/k/kuubernetes.md)はDockerコンテナをGUIで管理がしやすくしたOpen Sourceツールです。管理がしやすいためAzureとAWSで取り入れサービスとして提供しています。
KubernetesはK8Sとも言われるですが、それはKと後8文字の英語とSがついてK8Sと呼んだりしてます。
Azure で Kubernetes をフル活用したい場合に最適なサービスです。
一番の特徴は Kubernetes API への直接アクセスがサポートされていることです。Kubernetes をフルマネージドで使用できます。
その代わり、クラスターの構成と運用はユーザーの制御と責任の範囲内となるため、クラウドサービスの利点が一部損なわれることには注意しましょう。

- フルマネージドで Kubernetes を使用したい
- Kubernetes API への直接アクセスが必要

### Azure Functions

サーバレスでサービスとしての関数(FaaS)です。イベント駆動型のアプリケーションを構築する場合に最適なサービスです。
スケーリングがしやすかったり、イベント駆動型アプリケーションを構築出来たりなど Azure Container Apps と似ていますが、一時的な関数実行を行う用途に最適化されています。
Azure Functions で作成したコードは基本的にコンテナイメージとしても使用できるので、後から環境を変えたい場合にも再利用しやすいというメリットもあります。
プランが 2 種類あり、デフォルトは従量課金プランでは、コールドスタート・最大実行時間が 10 分など制限があります。それに対して Premium プランは、設定で最大実行時間を無制限(60 分保証)に出来たり、常にウォーム状態に維持できるなど制限の緩和ができます。
どちらのプランも一時的な関数としての用途を基本としていますので、実行時間が比較的短い(最大 60 分未満)コンテナでイベント駆動型のアプリケーションを構築したい場合に良い選択肢です。

- サーバレスでコンテナアプリケーションを構築・運用
- 一時的に使用する関数
- 1 度の実行時間が短い(60 分未満)

### [Azure Red Hat OpenShift](https://github.com/LowyShin/KnowledgeBase/blob/master/dic/o/openshift.md)

OpenShift とは、Red Hat社が提供しているエンタープライズ対応のKubernetesコンテナプラットフォームで、Docker、Kubernetes、Dockerレジストリなどで構成されるCaaS(Container as a Service)基盤です。

Azure Red Hat OpenShift は Azure 上で OpenShift を使用したい場合に最適なサービスです。
ソースコード管理・ビルド・デプロイ・スケーリング・正常性の管理は、OpenShift の機能で自動的に行うことが出来ます。
レジストリ・ネットワーク・ストレージ・CI/CD は組み込みの機能を使うこともできますし、独自のものを使用することもできます。
元から OpenShift を使用して運用していたり、Kubernetes を本格的に運用する前提で、CI/CD ツールや長期のサポートなど、必要な他のツールや保守サービスも一通りほしい場合に便利です。

- システムを OpenShift で運用している
- Kubernetes を中心とした本格的な開発・運用
- CI/CD など他ツール一式を同時に導入したい
- Kubernetes を含めたツールの長期サポートがほしい

### Azure Spring Cloud

既存の Spring Boot のアプリケーションのコードを変更せずに Azure にデプロイしたい場合に最適なサービスです。
Spring bbot の実行環境を一から構築する必要がないのがメリットです。また、監視やブルー/グリーンデプロイなどもあります。
Spring Boot を使用する際は、コードを変更したりコンテナ用の構成管理ファイルを作成するわけではないので、コンテナを使用するような感覚はありませんが、内部的には専用の Kubernetes クラスターで管理されるようです。
参考 | Azure Spring Cloud では、アプリケーションがどのようにホストされますか?

- コードを変更せずに Spring boot アプリケーションをデプロイしたい
- コンテナ技術のノウハウなしにコンテナのメリットを享受したい

### [Azure Batch](https://azure.microsoft.com/ja-jp/products/batch)

Azure Batchとは、CPU・メモリなど多くのコンピュータリソースを必要とする大規模なバッチジョブを、Azure上で効率的に処理するための実行基盤です。Azure Batchを使用することで、下記のバッチジョブを効率的に実行することが可能になります。

- 大規模な並列処理を行うバッチジョブ
- 大量のマシンリソースを必要とする科学計算等の高負荷なバッチジョブ（ハイパフォーマンス・コンピューティング：HPC）

Azure Batchで管理された仮想マシン上で実行するようにスケジュールを設定し、バッチジョブの要件に合わせて仮想マシンを自動的にスケールさせながら大量のマシンリソースを要するバッチジョブを処理していきます。

## Reference

- [Azure Batch](https://github.com/LowyShin/KnowledgeBase/blob/master/wiki/azure/azurebatch.md)

