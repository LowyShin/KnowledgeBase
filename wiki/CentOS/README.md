## Hardware Information

* [CentOS　ハードウェア情報の取得](https://ex1.m-yabe.com/archives/1881)

* OS info
```
cat /etc/redhat-release 
cat /etc/issue
```

## Configuration

### LoginProfile

* Change directory color on ssh
  * cp /etc/DIR_COLORS ~/.dircolors
  * vi ~/.dircolors
   ```vim
   DIR 01;36       # directory
   LINK 36;01      # symbolic link 
   ```

* [How to Add User to root Group on CentOS 5/CentOS 6](https://webhostinggeeks.com/howto/how-to-add-user-to-root-group-on-centos-5-7/)

### Change hostname

```sh
hostnamectl set-hostname <HOSTNAME>
```

### SSHD

* [CentOS7でSSHのポート番号を変更する](https://qiita.com/fk_2000/items/019b62818e34be973227)

### firewalld

* Centos7
```sh
# Check enable firewall daemon
systemctl is-enabled firewalld

# Show status firewall daemon
systemctl status firewalld

# Stop firewall daemon
systemctl stop firewalld

# Start firewall daemon
systemctl start firewalld

# Disable firewall daemon
systemctl disable firewalld

# Enable firewall daemon
systemctl enable firewalld

```

### Network

* [Linuxのネットワークチーミング(Bonding)の設定【RHEL 6/CentOS 6】](https://tech-mmmm.blogspot.com/2016/05/linuxbonding.html)

## Trouble shooting

* See easy Network status
```
iftop
```

* Cannot connect internet
  * `ping <gateway IP>`
    * if not returned, check `vi /etc/sysconfig/network-scripts/ifcfg-eth0`
  * `cat /etc/resolv.conf`
    * check DNS configuration. If is not set, put `nameserver 8.8.8.8` (Google DNS)
    * if change resolve.conf, execute 
      * `systemctl restart systemd-hostnamed`
* ssh start fail
  ```
  Job for sshd.service failed because a configured resource limit was exceeded. See "systemctl status sshd.service" \"journalctl -xe" for details.
  ```
  * disable selinux
  ```sh
  sudo setenforce 0
  vi /etc/selinux/config
  ```
  * /etc/selinux/config
  ```conf
  SELINUX=disabled
  ```


## Permission

* If you have not permission of crontab edit
  * `vi /etc/security/access.conf`
  ```conf
  + : <loginname> : cron crond :0 tty1 tty2 tty3 tty4 tty5 tty6
  ```

## whereis

```sh
# all list
whereis -l

# target application
whereis mysql
```

### apache(httpd)

* [Apache logrotateによるログローテーションの設定](https://itsakura.com/centos-apache-log)

## memory cache clear
* https://www.shift-the-oracle.com/linux/utility/flush-buffer-cache.html
```sh
echo 1 > /proc/sys/vm/drop_caches
echo 2 > /proc/sys/vm/drop_caches
echo 3 > /proc/sys/vm/drop_caches
```
warning : This command is very dangerous that is memory clear physically.

## Register to service custom process

* [Systemdを使ってさくっと自作コマンドをサービス化してみる](https://qiita.com/DQNEO/items/0b5d0bc5d3cf407cb7ff)

## Journal

* [journalctl コマンドの使い方](https://qiita.com/hana_shin/items/96095571b7bf1b721255)
* ジャーナル保存領域の場所を指定する方法(-D <ジャーナル保存領域の場所>)
  * https://qiita.com/hana_shin/items/96095571b7bf1b721255

### configuration

* does not use tcp_tw_recycle : https://qiita.com/tmshn/items/b49f1b51bfc472968b30
* centos7 ip change(add) on cli : https://i-think-it.net/centos7-ip-setting/
* [CentOS6からの複数IP（secondary）設定方法](https://www.server-memo.net/centos-settings/network/nic-secondary.html)

### Tools

* ASCII Code changer : http://web-apps.nbookmark.com/ascii-converter/

* [firewall-cmd](https://qiita.com/kenjjiijjii/items/1057af2dddc34022b09e)
* [CentOS6.6にOpenSwanでIPsec](http://kumakake.com/linux/3475)
* [【 ip 】コマンド（基礎編）――ネットワークデバイスのIPアドレスを表示する](https://atmarkit.itmedia.co.jp/ait/articles/1709/22/news019.html)
* [Linux(CentOS 6) - yum installコマンドでtracerouteパッケージをインストールする](https://nobuneko.com/blog/archives/2013/05/linux_centos_6_yum_install_traceroute.html)
* [静的ルーティングの設定 - Linux](https://qiita.com/kooohei/items/b0931ae210911cc52adc)
* [RHEL 7でスタティック（静的）ルートを追加する4つの方法](https://minory.org/linux-static-route.html)
* [IP コマンドでの静的ルートの設定](https://access.redhat.com/documentation/ja-jp/red_hat_enterprise_linux/7/html/networking_guide/sec-configuring_static_routes_with_ip_commands)
* cp /etc/DIR_COLORS ~/.dircolors
  ```vim
  DIR 01;36       # directory
  LINK 36;01      # symbolic link 
  ```

### Ref Documents

* [centosでrawデバイスを使用する](https://qiita.com/kuritayu/items/c8af2b15f98f9679c2d9)
* [一般ユーザでもroot権限が必要なコマンドを実行できるようにする方法](https://qiita.com/hana_shin/items/fe077d8910dba449b840)

## Links

* [giip Knowledgebase](https://github.com/LowyShin/KnowledgeBase/wiki)

* [for edit this page](https://github.com/LowyShin/KnowledgeBase/tree/master/wiki/CentOS/README.md)
