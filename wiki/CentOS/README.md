## Hardware Information

* [CentOS　ハードウェア情報の取得](https://ex1.m-yabe.com/archives/1881)

* OS info
```
cat /etc/redhat-release 
cat /etc/issue
```

## Trouble shooting

* Cannot connect internet
  * `ping <gateway IP>`
    * if not returned, check `vi /etc/sysconfig/network-scripts/ifcfg-eth0`
  * `cat /etc/resolv.conf`
    * check DNS configuration. If is not set, put `nameserver 8.8.8.8` (Google DNS)
    * if change resolve.conf, execute `systemctl restart systemd-hostnamed`
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

### Tools

* ASCII Code changer : http://web-apps.nbookmark.com/ascii-converter/

## Links

* [giip Knowledgebase](https://github.com/LowyShin/KnowledgeBase/wiki)

* [for edit this page](https://github.com/LowyShin/KnowledgeBase/tree/master/wiki/CentOS/README.md)
