## OS Version

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

## Permission

* If you have not permission of crontab edit
  * `vi /etc/security/access.conf`
  ```conf
  + : <loginname> : cron crond :0 tty1 tty2 tty3 tty4 tty5 tty6
  ```

## Links

* [giip Knowledgebase](https://github.com/LowyShin/KnowledgeBase/wiki)

* [for edit this page](https://github.com/LowyShin/KnowledgeBase/tree/master/wiki/CentOS/README.md)