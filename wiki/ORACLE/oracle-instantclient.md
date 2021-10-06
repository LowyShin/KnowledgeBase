# ORACLE INSTANT CLIENT

Instant client 19.3バージョンは11.2以後のバージョンのORACLEに接続できます。 その以前のバージョンなら専用のクライアントをダウンロードする必要があります。

https://www.oracle.com/database/technologies/instant-client/linux-x86-64-downloads.html


## ORACLE instant client inatall on CentOS using yum

1. Update yum repository
```sh
cd /etc/yum.repos.d
wget http://yum.oracle.com/public-yum-ol7.repo
```
2. import GPG key
```sh
wget http://yum.oracle.com/RPM-GPG-KEY-oracle-ol7
rpm --import RPM-GPG-KEY-oracle-ol7 
```

3. Enable oracle instantclient repository
```sh
yum install -y yum-utils
yum-config-manager --enable ol7_oracle_instantclient
```
4. yum install
```sh
yum -y install oracle-instantclient19.3-basic oracle-instantclient19.3-devel oracle-instantclient19.3-jdbc oracle-instantclient19.3-sqlplus
```
5. check installed packages
```sh
yum list oracle-instantclient*
```

6. set environment
```sh
echo "export ORACLE_HOME=/usr/lib/oracle/19.3/client64/lib/" >~/profile_oracle.sh
echo "export LD_LIBRARY_PATH=/usr/lib/oracle/19.3/client64/lib/" >>~/profile_oracle.sh

sh ~/profile_oracle.sh
```

7. test client
```sh
sqlplus LOGON/PASSWD@192.168.11.51:1521/INSTANCENAME
```

### References

* [ORACLE](https://github.com/LowyShin/KnowledgeBase/tree/master/wiki/ORACLE)
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
  * [Replication](https://github.com/LowyShin/KnowledgeBase/blob/master/wiki/ORACLE/ORAReplication.md)
  * [Characterset(Official)](https://www.oracle.com/technetwork/jp/content/charcterset-250314-ja.pdf)
  * [DBMS STAT](https://github.com/LowyShin/KnowledgeBase/blob/master/wiki/ORACLE/ORADBMSSTAT.md)

* [for Edit](https://github.com/LowyShin/KnowledgeBase/edit/master/wiki/ORACLE/oracle-instantclient.md)


