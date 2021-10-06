# ORACLE INSTANT CLIENT

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
