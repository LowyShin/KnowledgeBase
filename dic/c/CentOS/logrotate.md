# CentOS Log Rotation 設定

CentOSにはデフォルトで **logrotate** というログローテーション機能が備わっています。logrotate は特定のログファイルを自動的に圧縮、削除、またはアーカイブして、ディスクスペースを節約し、ログ管理を効率的に行います。

## Logrotate 設定例

例えば、`/var/log/myapp/` というディレクトリにあるログファイルを週に1回ローテーションし、30日経過した古いログを削除する設定を `logrotate` で行う場合、次のような設定ファイルを作成します。

### 1. 設定ファイルの作成

新しい設定ファイルを `/etc/logrotate.d/myapp` に作成します。

```bash
sudo vi /etc/logrotate.d/myapp
```

- `/etc/logrotate.d/myapp`の内容
```conf
/var/log/myapp/*.log {
    weekly                 # 週に一度ローテーション
    missingok              # ログファイルがなくてもエラーにしない
    rotate 4               # 4週間分のログを保持
    compress               # ログを圧縮
    delaycompress          # 次回のローテーションまで圧縮を遅らせる
    notifempty             # ログが空の場合はローテーションしない
    create 0640 root root  # 新しいログファイルのパーミッションと所有者
    dateext                # ローテート後のファイルに日付を付与
    olddir /var/log/myapp/old # 古いログを移動するディレクトリ
    postrotate             # ローテーション後に実行されるスクリプト
        systemctl restart myapp.service
    endscript
}
```

### 2. 設定オプションの解説

- weekly: 週に1回ログをローテーション。
- rotate 4: ローテートされたログファイルを4つ保持し、それ以上古いものは削除。
- compress: ローテートされたログファイルをgzipで圧縮。
- delaycompress: ローテーション直後のログは圧縮せず、次のローテーション時に圧縮する。
- notifempty: 空のログファイルはローテートしない。
- create 0640 root root: 新しいログファイルの作成時に指定のパーミッション（0640）と所有者（root）で作成。
- olddir /var/log/myapp/old: 古いログファイルを指定したディレクトリに移動。
- postrotateとendscript: ローテーション後にサービスを再起動するコマンドを実行。

### 3. Logrotateの動作確認

設定が正しいかどうかを確認するためには、手動でlogrotateを実行できます。

```bash
sudo logrotate -d /etc/logrotate.conf
```
-d オプションはデバッグモードで、実際には何も変更しませんが、設定に問題がないかを確認できます。問題がなければ次に手動実行も可能です。

```bash
sudo logrotate /etc/logrotate.conf
```

### Cronによる定期実行
logrotate は自動的にCronによって毎日実行されます。/etc/cron.daily/logrotate というスクリプトがすでに存在しており、このスクリプトによってlogrotateが定期的に実行されます。
