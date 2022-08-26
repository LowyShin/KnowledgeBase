始めに
前回紹介した方法は、管理者権限ユーザーの資格情報が利用者側に必要でした。
今回はタスクスケジューラのイベントトリガーを使用して、特権が必要な操作を任意のユーザーから実行させる方法を紹介します。なおイベントログとタスクスケジューラによる委任なので、PowerShell以外でも応用可能です。

サンプル
本コラムのサンプルスクリプトはこちらからダウンロードできます。使用する場合はC:¥Temp 直下に展開してください。

サンプルスクリプト

設定から実行までの流れ
今回は以下のステップで進めていきましょう。

設定から実行までの流れ

実行対象と配置先を決める
ここでいう実行対象は、スクリプトや実行ファイルなどです。
実行対象は、実行を依頼したユーザーとは別のユーザーのコンテキストで実行されるため、入力待ちが起こらないようする必要があります。
配置先や実行対象は、管理者のみ参照・実行権限のあるようにしましょう。さもないと、一般ユーザーが書き換えや差し替えをするだけで任意のコマンドやプログラムを実行できてしまいます。

イベントとタスクのパラメータを決める
トリガーとなるイベントに必要なパラメータ
イベントログの作成にNew-EventLog、出力のためにWrite-Eventlog コマンドレットを使用します。
タスクのイベントトリガーには「ログ」「ソース」「イベントID」が必要です。重複すると意図しないタイミングで発動してしまうので注意して設計しましょう。
今回使用するパラメータは以下の通りです。

パラメータ	概要	サンプルで使うパラメータ
LogName	イベントが書き込まれるログの名前。
例えばアプリケーションログならApplicationを指定します。新規に独自の名前を指定すると「アプリケーションとサービスログ」直下に用意されます。	Application
Source	ログソース名を指定します。
イベントビューアで見たときの「ソース」列、詳細における「Provider Name」に相当するパラメータです。	TestApp
EventId	イベントログのIDを指定します。
タスクのトリガーはログの名前、ログソース、イベントIDで指定するので重複しないようにします。	開始：1000
正常終了：1001
異常終了：1002
Message	イベントログのメッセージ。任意の内容を指定します。	開始：
ユーザー "<ユーザー名>" により、セキュリティログの取得開始が指示されました。
正常終了：
セキュリティログを "<パス>" に出力しました。
異常終了：
エラーメッセージ
EntryType	情報、エラー、警告など。任意。	開始：Information
正常終了：Information
異常終了：Warning
イベントは3種類用意しています。トリガーに一つ、結果に二つ使用しています。
イベントトリガーは実行が保証されません。正否がユーザーにわかるように通知する仕組みを入れるとよいでしょう。

タスクスケジューラ
タスクスケジューラで設定する項目は以下の通りです。

名前	タスクの名前	OutputSecurityLogs
タスクの実行時に使うユーザーアカウント	タスクの実行アカウント。
ここでは管理者権限を持ったユーザーを指定します。	NTAUTHORITY¥SYSTEM
トリガー	タスクの開始条件。
「イベント時」を指定します。	イベント時
　ログ：Application
　ソース：TestApp
　イベントID：1000
操作	タスクで実行する操作。	プログラム：PowerShell.exe
引数：-File "C:\temp\OutputSecurityLogs.ps1"
開始：C:\Temp
条件	タスクの実行条件。	「コンピューターAC電源で使用している場合のみタスクを開始する」のチェックを外す。
イベントソースを作成する
「管理者として実行」で起動してイベントソースを作成します。
作成には New-EventLog、削除はRemove-EventLogコマンドレットを使用します。

CreateEventSource.ps1

#Requires -RunAsAdministrator
# イベントソースの作成
# アプリケーションログに TestApp というイベントソースを追加する。管理者での実行が必要。
if($false -eq [System.Diagnostics.EventLog]::SourceExists("TestApp"))
{
    # イベントソースが無ければ作る
    New-EventLog -LogName "Application" -Source "TestApp"
}

実行対象を配置する
決めた配置先にスクリプトを配置します。本番環境であれば、アクセス権の設定と確認も忘れずに。
今回はこちらのサンプルを用意しました。管理者権限が必要なセキュリティログを取得し、C:\Temp\SecurityLog.csv に出力します。サンプルなのでスクリプトも同じC:¥Temp に配置しています。
なおPowerShellのコンソールから直接このサンプルを実行する場合、[System.Environment]::Exit()の部分でPowerShellが終了してしまうので、試しに実行したい場合はコメントアウトしたり Return で置き換えてください。

C:\Temp\OutputSecurityLogs.ps1

try {
    $PATH = "C:\Temp\SecurityLog.csv"
    # セキュリティログの上から10件を出力する。
    # 管理者権限がない場合は例外が発生する。
    $Log = Get-WinEvent -LogName Security -Max 10 -ErrorAction Stop
    $Log | Export-CSV -Path $PATH -NoTypeInformation -Encoding Default
 
    # 完了のログを記録
    Write-EventLog -LogName Application -Source TestApp -EventId 1001 -EntryType Information -Message "セキュリティログを `"$PATH`" に出力しました。"
 
    # こうすると、PowerShell.exe の結果として設定されるため、タスクスケジューラの「前回の実行結果」に反映される。
    # コンソール実行の場合ここでウィンドウが閉じてしまうので注意。
    [System.Environment]::Exit(0)
}
catch {
    Write-Host $_
    Write-EventLog -LogName Application -Source TestApp -EventId 1002 -EntryType Warning -Message ($_ | Out-String)
    [System.Environment]::Exit(-1)
}

cのtemp

セキュリティ設定

タスクを作成する
複数台に展開するのであれば、タスクスケジューラのGUIで作成後にエクスポートします。今回はこの方法についても軽く触れます。
まずはGUIでの設定から。

GUIでタスク作成
全般タブの「タスクの実行時に使うユーザーアカウント」は SYSTEM とするのが一番単純なので、今回はこれを採用しています。

全般タブ

もし特定のユーザーを指定する場合はパスワードの記録が必要となります。一方、エクスポートしたXMLにはパスワードは含まれません。インポートやそれを確定するときに必要になります。
「トリガー」には、ユーザーに発行させるイベントの情報を設定します。

トリガータブ

「操作」は実行対象を指定します。今回はPowerShell.exeとスクリプトファイルです。引数の方に実行対象となるスクリプトを指定します。

操作タブ

タスクの「条件」タブですが、特に重たい処理をするのでなければ「電源」の項目のチェックを外しておくとよいでしょう。
在宅だとケーブルが抜けていたり、本体に差しているType-Cケーブルが正規の電源につながっていないために電流が足りなかったりといった状態はよくあります。

条件タブ

最後にOKを押せば確定。個別のユーザーを実行アカウントに指定していた場合はパスワードの入力が求められます。

タスクXMLのエクスポート
出来上がったタスクをエクスポートします。一台だけで使用するならこの手順は不要です。

タスクのエクスポート

XMLの編集
その後、必要に応じて保存されたXMLを編集します。
作成者をユーザー名にしたくないなら「Author」を修正。ユーザーを個別で指定した場合SIDが使用されますが、ローカルアカウントの場合これが端末ごとに不一致になるので「UserId」をユーザー名に修正したりします。保存の際にUTF-16とするのを忘れずに。今回はビルトインアカウント「SYSTEM」を使うのでSIDのままでもよいでしょう。

XML

タスクXMLのインポート
タスクスケジューラのGUIを使用してXMLをインポートする場合は右ペインの「タスクのインポート」でインポートします。「タスクXMLに、書式設定が正しくない値または範囲外の値が含まれています。」というエラーが出る場合は「ユーザーまたはグループの変更」で同じユーザーアカウントを指定します。今回はOutputSecurityLogs.xmlを指定します。

タスクのインポート

PowerShellであれば以下のように登録します。今回のようにSYSTEMアカウントなどパスワード不要な場合、UserとPasswordの指定は不要です。フォルダ配下なら TaskPath パラメータを追加してください。

RegisterTask.ps1

# タスクの登録：
# あらかじめエクスポートしたタスクのXMLファイルの内容に加え、ユーザー名とパスワードを平文で指定する。
# なおXMLにもユーザー名とタスク名が含まれるが、このコマンドで上書きされる。
# エクスポートしたXMLにSIDが含まれたままの場合、WORKGROUP環境などユーザ名は同じでもSIDが違うといったこともある。
# その場合、ここでユーザ名や正しいSIDに置き換える。
$xml = Get-Content -LiteralPath "C:\Temp\OutputSecurityLogs.xml" -RAW
$TaskName = Split-Path ([xml]$xml).Task.RegistrationInfo.URI -Leaf
$TaskPath = Split-Path ([xml]$xml).Task.RegistrationInfo.URI -Parent
# $UserName = ([xml]$xml).Task.Principals.Principal.UserID # ユーザ指定やパスワードが必要なら追加
Register-ScheduledTask `
    -XML $xml `
    -TaskName  $TaskName `
    -TaskPath $TaskPath `
#    -User $UserName `  # ユーザ指定が必要なら追加
#    -Password "平文パスワード" # パスワードが必要なら追加

ユーザーから実行する
イベントログに書き込む
標準ユーザーからイベントログを書き出します。PowerShellを開いて以下のように発行します。

# イベントログの発行
# LogName : Application
# Source  : TestApp
# EventId : 1000
# のログを出力します。
$msg = 'ユーザ"'+(whoami)+'"により、セキュリティログの取得開始が指示されました。'
Write-EventLog -LogName Application -Source TestApp -EventId 1000 -Message $msg

その後イベントログが出ているか確認しましょう。ログはGet-EventLogまたはGet-WinEventで取得できます。

# タスクスケジューラが動いて、 EventId 1001(成功)または 1002(失敗) のログが記録されます。
# 少し待ってから確認。StartTime 以降のイベントのみを対象とします。
Start-Sleep 5
Get-EventLog -LogName Application -Source TestApp -InstanceId 1001,1002 -After $StartTime | Format-List

Get-EventLog と Get-WinEvent はオプションや扱えるイベントログの種類などが違います。evtxファイルとなっているログを扱えるかどうかや検索条件などの違いもあるので、適したものを選択してください。

さて。うまくいけば、ID(Get-WinEventの場合は InstanceId)が1001のログが見つかります。メッセージに書かれたCSVを開けば、システムアカウントで実行された結果の書かれたCSVが確認できるはずです。

結果

ところでエンドユーザーにPowerShellを操作してもらうのは大変なので、ダブルクリックで動くバッチをTIPSとサンプルとして作成しました。サンプルの GetSecurityLogs.bat を実行すると、イベントログを発行してタスクの完了を待ち、結果を表示します。

終わりに
タスクスケジューラを使用して、標準アカウントから管理者の処理を実行する方法を紹介しました。
シンクライアント端末のように、ユーザーは管理者権限を持たせないという設計はよくあるのですが、実際運用してみると「この機能のためだけに管理者権限が欲しい」「UACの画面が邪魔」とったことがあります。
そんな時、管理者権限を一律付与したりUACを無効にする前に、こんな手法も検討してみてはいかがでしょうか。
昨今は標準ユーザーではなく、管理者権限を付与した状態でサードパーティーで監視するというケースが多々あることかと思いますが、今回紹介する方法はスタンドアロンかつWindows標準の機能で実現できます。
ちなみに私は、WORKGROUP環境のシンクライアント端末のトラブルシュートを、エンドユーザーで実行する仕組みに使ったりしました。
参考になれば幸いです。

TIPSなど
解説のテンポが悪くなりそうなTIPSなどをまとめました。

PowerShellを用いたタスクのエクスポート
もしたくさんのタスクを作ったのなら、スクリプトでまとめてエクスポートした方が楽でしょう。Get-ScheduledTask と Export-ScheduledTask コマンドを使用してXMLのテキストを取得し、それをUTF-16で保存します。
以下はタスク名に「Update」を含むタスクをXMLで保存する例です。

# タスクをまとめてエクスポートする例。
# タスク名に「Update」を含むタスク一覧を確認し、それを「C:\Temp\Tasks\パス\タスク名.XML」に保存します。
 
$TaskList = Get-ScheduledTask -TaskName "*Update*"
 
# 確認
$TaskList | Format-Table -AutoSize
 
# 保存
foreach ($t in $TaskList) 
{
    Write-Host "$($t.TaskPath)$($t.TaskName) 処理開始 "
    
    # XMLを取得。
    # 本来はパイプでも動くはずだが、一部タスクで「パラメーターが間違っています」エラーが出ることが。
    #$xml = $t | Export-ScheduledTask -ea stop
    $xml = Export-ScheduledTask -TaskPath $t.TaskPath -TaskName $t.TaskName -EA Stop
 
    $FolderPath = Join-Path -Path "C:\Temp\Tasks" -ChildPath $t.TaskPath
 
    if($false -eq (Test-Path -LiteralPath $FolderPath))
    {
        # パスが無ければ作る
        $null = New-Item -Path $FolderPath -ItemType Directory -Force -EA Stop
    }
 
    $FullPath = $FolderPath + $t.TaskName + ".xml"
 
    # UTF-16で保存
    $xml | Out-File -LiteralPath $FullPath -Encoding Unicode -EA Stop
}

バッチファイルにPowerShellを組み込んだサンプル
PowerShellだとダブルクリックで開くといったことはできず、ExecutionPolicyの設定などちょっと煩雑。そこで、PowerShellのコードをバッチファイルに埋め込んでしまおう…そんなサンプルです。サンプルコードの GetSecurityLogs.bat を実行するとイベントログを発行してタスクの完了を待ち、結果を表示します。
バッチファイルにPowerShellのコードを書き込むテクニックについては様々な人が研究しているようです。皆さんそれぞれ特徴があるので、見ていて興味深いものがあります。
バッチファイルは、エンコードをDefault(日本語版環境ならSJIS)にする必要があるのでその点は要注意です。

GetSecurityLogs.bat

@(echo '> NUL
echo off)
 
PowerShell.exe -Nologo -Noprofile -ExecutionPolicy RemoteSigned -Command "Invoke-Expression (Get-Content -Path \"%~f0\" -RAW)"
 
exit /b 0
') | Out-Null
##### ここからPowerShellスクリプト #####
# 処理の完了を待つ条件
 
# イベント発行
$StartTime = Get-Date
Write-Host "セキュリティログの取得を開始します…"
$msg='ユーザ"'+(whoami)+'"により、セキュリティログの取得開始が指示されました。'
Write-Eventlog -LogName Application -Source TestApp -EventId 1000 -EntryType Information -Message $msg
 
# イベント発行後に来る完了ログを待つ。
# 処理は10秒もかからないはずなので過ぎたらタイムアウト。
# 検索は先ほど発行したイベント以降のイベントだけを対象とする。
$GetEventLogParams =@{
    LogName = "Application"
    Source  = "TestApp"
    After   = $StartTime
}
 
while((Get-Date) -le $StartTime.AddSeconds(10))
{
    Start-Sleep 1
    $Event = Get-EventLog @GetEventLogParams
    
    $SucceededEvent = $Event | Where-Object{$_.InstanceId -eq 1001}
    $FailedEvent     = $Event | Where-Object{$_.InstanceId -eq 1002}
 
    if($null -ne $SucceededEvent)
    {
        # 見つけたファイルをメモ帳で開く。
        # 期待されるメッセージ「セキュリティログを "Path" に出力しました。」からダブルクオート内を抽出。
        # Match で比較すると、True/False が返る以外に自動変数 $Matches にその結果が入る。
        $null = $SucceededEvent.Message -match '(".+")'
        $Path = $Matches[0]
        Notepad.exe $Path
        break
    }
    elseif($null -ne $FailedEvent)
    {
        # エラーメッセージを表示する
        Write-Host "エラーが発生しました。"
        Write-Host $FailedEvent.Message
        Timeout 10
        break
    }
}
if($null -eq $SucceededEvent -and $null -eq $FailedEvent)
{
    # 時間切れ。発行したイベントが処理されなかった。
    Write-Host "ログの取得待ちがタイムアウトしました。"
    Timeout 10
}

※文章中の商品名、会社名、団体名は、各社の商標または登録商標です。
