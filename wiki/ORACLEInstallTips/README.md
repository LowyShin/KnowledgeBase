## Oracle의 접속
```sh
export ORACLE_SID=HGJ
sqlplus / as sysdba
```

## 기초 지식

### 어느 DBMS를 고르나?

* MySQL
  * 3GB이하 테이블에서의 
* SQL Server
* ORACLE

### RAW Device vs. File system
* raw device
  * 쓰기 읽기시에 디스크 버퍼를 사용하지 않으므로 캐시를 사용하지 않는 IO에 대해서는 빠른 응답속도가 나온다. 그리고 disk buffer를 사용하지 않기 때문에 전원이 갑자기 단절되는 등의 사태에도 캐시 정보가 사라지는 등의 피해가 없다. 
  * OS에서 확인이 불가능하므로 어느정도 사용중이고 어떤 용도로 사용하는지 표시가 안된다. (포맷 안됨으로 나오기 때문에 fdisk해버리면 데이터 날라감)
* file system
  * OS에서 제공하는 파일 시스템을 이용하기 때문에 OS에서 관리가 편하다. 
  * Disk cache를 기본으로 사용하기 때문에 잦은 access에는 빠른 응답을 보일 수 있음
  * 전원이 나가는 경우 Cache상의 데이터는 유실 됨.

### Table Partitioning vs. Tablespace Partitioning

* Table Partitioning
  * Index를 걸지 않아도 scan시 partition의 조건 별로 나눠진 파일에서 검색하므로 index tuning이 없이도 IO가 줄어듬. 
  * 역으로 인덱스 튜닝을 하더라도 File IO가 증가하여 퍼포먼스 영향을 일으킴
  * 불필요한 데이터를 하루 단위로 partition 파일을 생성하므로 파티션 파일 삭제만으로 일괄 삭제가 가능
  * 고도의 shell 스크립팅이 필요하며, shell이 실패시 필요 영역에 대한 파티션파일이 없어 서비스 장애로 이어짐.
  * 5년마다 한 번씩 HW노후에 의한 마이그레이션시 많은 작업이 필요.
  * 운용 이력 및 매뉴얼이 없는 경우 히스토리를 몰라서 불필요한 영역파일이 생성되며 사용되지 않게 됨.
  * 일간 파일로 쪼개진 경우 range로 1년치를 select하게 되는 경우 365개의 파일을 open, close를 지속하여 성능이 저하됨. 
  * 여러개의 partition 파일을 join하게 되는 경우 메모리에 올려서 sorting을 해야 하므로 sorting부하가 커짐.

* Tablespace Partitioning
  * Index tuning에 따른 성능차이가 명확하게 나타남
  * 데이터 삭제시 file삭제보다는 느림
  * shell을 사용하는 운용이 필요없거나 아주 적음.
  * HW노후에 의한 마이그레이션시 exp(expdp)정도만으로 충분히 이전 가능.
  * 필요한 양 만큼만 tablespace를 증설하면 되므로 불필요한 영역이 최소화 됨
  * fragmentation 발생시 tablespace를 신설해서 이동하는 등의 조치로 성능저하를 줄이기 쉬움

### using shell

* ORACLE은 SQL Server와는 달리 운용을 위한 툴이 거의 서드파티에 의한 유료 툴로 이루어져 있어 OS의 shell 의존도가 상당히 높음.

* ORACLE서버간 복사를 위한 팁들..
  * https://talklowykr.blogspot.com/2020/07/oracle.html

  ```sql
  set long 100000
  set head off
  set feed on
  set wrap on
  set linesize 3200
  set pagesize 0
  set trimspool on
  set longchunksize 1024
  spool insertout.txt

  select dbms_metadata.get_dll('TABLE', 'MyTablename', 'MyOwner');

  exit
  ```

## Tuning

### Index tuning

* 인덱스 튜닝은 모든 튜닝의 70%
  * 단일인덱스(필드 하나)는 테이블 당 5개 정도가 좋음.
  * 복합인덱스(필드 두 개 이상)는 가급적 적게 잡음. 만약 첫 번째 필드명이 단일 인덱스와 중첩한다면 복합 인덱스를 생성한 뒤에 단일 인덱스를 삭제하는 것이 빠름. 
  * 인덱스가 많을 수록 select가 빨라지지만 insert, update, delete속도가 느려짐 양날의 검. 
  * replication의 경우 master는 insert, update, delete가 많기 때문에 index를 최소화 하고 slave에 인덱스를 많이 넣어 주는 것을 추천. 그에 따라 서버의 용도를 판단하는 것이 좋음. 
  * PK가 int형일 때가 가장 검색속도가 빠름.
  * PK또는 Clustered index에 필드를 많이 넣을 수록 insert, update, delete시에 물리적 재구성으로 인해 table lock으로 인한 dead lock이나 chain lock이 발생하기 쉬움
  * PK는 기본적으로 auto incremental형 으로 만들면 맨 마지막에 append형식으로 들어가기 때문에 insert, update, delete에 영향이 거의 없음. 
    * OS는 update라는 것은 chunk단위로 delete 후 insert를 하지만 append는 맨 마지막 address에 insert를 하는 것 만으로 처리 완료 되기 때문에 용량이 큰 데이터일 수록 성능 차이가 많이 남. 
    * PK데이터의 중간에 들어갈 수 밖에 없는 데이터의 경우 대량 sorting이 발생할 수 있기 때문에 성능에 영향이 심각해질 수 있음. (예, 게임의 아이템 취득이력을 날짜 역순으로 PK를 잡은 경우 6500만 건에서 insert에 3초 걸렸던 경우가 PK를 serial로 자동증가 숫자를 넣음으로 0.01초로 바뀜)
  * varchar형에 나중에 update된 데이터 길이가 길어진 경우 fragmentation이 발생하여 성능 저하가 발생함. 
    * 이 경우 rebuild index 및 rebuild table로 주기적으로 defragment를 해주어야 함. 

### memory tuning

* SGA/PGA 割り当て
    * https://blogs.oracle.com/otnjp/tsushima-hakushi-14

### config tuning

* ORA-27300
```sql
startup
/*
ORA-27154: post/wait create failed
ORA-27300: OS system dependent operation:semget failed with status: 28
ORA-27301: OS failure message: No space left on device
ORA-27302: failure occurred at: sskgpsemsper
*/
```
cat /etc/sysctl.conf | grep kernel.sem
kernel.sem = 250 32000 100 100
change..
kernel.sem = 512 32000 100 1358
해결됨..
부하테스트로 대량의 접속을 시도한 상태에서 shutdown -> startup을 하게되니 세마포어(semaphore) 부족 에러가 뜸. 
  * ref : https://software.fujitsu.com/jp/manual/manualfiles/m110009/b1x10033/03z200/b0033-00-02-01-01.html
  * https://www.ibm.com/support/knowledgecenter/ja/SSEPGG_10.5.0/com.ibm.db2.luw.qb.server.doc/doc/t0008238.html

vi /etc/sysctl.conf
```conf
# MSL, MNS, OPM, MNI
# MSN = MSL * MNI
# Recommend MSL = OPM
# kernel.sem = 5010 641280 5010 128
kernel.sem = 14010 32000 28010 128
#kernel.shmall = 268435456
# 240GB / 4096
# kernel.shmall = 62914560
# 180G / 4096
kernel.shmall = 47185920
kernel.shmmax = 193273528320

## result
ipcs -l
------ Messages Limits --------
max queues system wide = 32768
max size of message (bytes) = 65536
default max size of queue (bytes) = 65536

------ Shared Memory Limits --------
max number of segments = 4096
max seg size (kbytes) = 402653184
max total shared memory (kbytes) = 402653184
min seg size (bytes) = 1

------ Semaphore Limits --------
max number of arrays = 128
max semaphores per array = 14010
max semaphores system wide = 32000
max ops per semop call = 28010
semaphore max value = 32767
```

```sh
mount -o remount,size=384g /dev/shm
```
* Shared memory에 맞추어 temp 변경
  * https://stackoverflow.com/questions/55478037/ora-01034-oracle-not-available-ora-27101-shared-memory-realm-does-not-exist-li
