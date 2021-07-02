## Oracle의 접속
```sh
export ORACLE_SID=MySID
sqlplus / as sysdba
```
```sql
-- 일반적인 시작
startup;
-- 강제 종료
shutdown immediate
/*
 디스크만 마운트 한채로 서비스는 OFF상태로 기동. 
나중에 database기동을 추가로 해야함. 
관리 목적으로 기동하는 경우 사용
*/
STARTUP MOUNT;
-- 데이터베이스 기동
ALTER DATABASE OPEN;

```

## 기초 지식

### RDBMS는 배열 연산

많은 개발자들이 Sequential한 사고를 하기 때문에 DBMS에 쿼리를 날릴 경우도 마찬가지로 한 줄씩 읽어서 처리하지 않느냐 라는 생각으로 SQL을 접근하지만, RDBMS엔진은 필요한 데이터를 배열로 넣고 연산대상을 배열로 넣은 뒤에 계산을 하면 한 번의 연산으로 배열의 결과가 나오기 때문에 빠른 처리가 가능함. 

연산을 위한 베이스 배열과 연산식 배열을 얼마나 잘 만드느냐가 DBMS의 활용 능력의 차이!

### 어느 DBMS를 고르나?

* MySQL
  * 3GB이하 테이블에서의 Random acess속도가 제일 빠름.
  * Open source이기 때문에 완전한 parameter tuning에 대한 정보가 없고 community등에서 경험을 공개한 내용을 기반으로 튜닝을 해야함. 
  * 3rd party툴이 많아 필요한 모듈만 설치하여 운영하는 경우 낮은 사양에서는 타 DBMS에 비해 고성능을 발휘함. 
  * 서버간 Network handshake성능이 높지 않아 서버간 통신을 할 때는 connection pool을 이용하여 established상태를 유지하는 것이 성능 개선에 도움이 됨.
  * 서버당 3000query/sec 정도를 기준으로 운용하는 것을 권장.
  * Procedure는 후반에 제공이 시작되었기 때문에 parsing 및 cache 성능 등이 타 DBMS에 비해 떨어짐(Session당 동일 Procedure는 별도 메모리 영역에서 parsing을 한다는 기술이 있음)
* PostrgreSQL
  * MySQL보다 오히려 ORACLE에 가까운 툴 사용성 및 성능을 제공.
  * Network handshake성능이 MySQL의 약 5배 정도 나오기 때문에 web이나 mobile기반의 요청당 connection을 걸어야 하는 경우 압도적인 성능이 나옴.
* SQL Server
  * 쿼리당 코스트가 가장 저렴함. (모든 DBMS를 동일 스펙(8C 16G)으로 HW를 장만한 뒤에 초당 쿼리수를 들인 HW, SW비용으로 나눈 금액 )
  * Advisor등으로 현재 사용패턴에 따른 성능 개선을 위한 조정 제안 등 경험이 부족한 DBA도 일정 이상의 성능을 낼 수 있는 툴을 기본으로 제공
  * SP(Stored Procedure)의 성능이 강력하여 View보다 select용도로 사용하는 경우가 많음.
* ORACLE
  * 64CPU, 128GBMemory 이상의 머신에서 가장 성능이 좋음.
  * AIX의 경우 1Board = 1CPU이기 때문에 CPU당 퍼포먼스 저하가 없지만, x86의 경우 Multi Core는 코어계수 0.75만큼의 효율 저하가 있고, Hyper threading을 하지 않는 것을 추천
  * Disk IO를 세세하게 컨트롤 할 수 있는 파라미터를 정할 수 있어 HW에 지식이 풍부할 수록 성능을 더욱 끌어올릴 수 있음.
  * Procedure에서 select 결과를 출력하는 기능이 없음.
  * First commit구조로 쿼리를 날리면 이미 Disk까지 반영되고, rollback을 하는 경우 redo log를 기반으로 롤백이 disk단위로 이루어지기 때문에 commit속도가 빠르고 rollback속도가 느림.

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

### SAS vs. SATA

* SAS
  * Disk에 controller가 없거나 disabled된 상태로 제조되어 SCSI컨트롤러가 없으면 CPU와 통신이 안되는 디스크 방식. 
  * SCSI컨트롤러가 CPU의 IO처리를 대행하기 때문에 DISK IO가 발생하더라도 CPU는 5%이상 올라가지 않음. 
  * 수요가 적기 때문에 제조단가가 SATA보다 저렴함에도 불구하고 가격은 높음.
* SATA
  * Disk에 controller가 들어있기 때문에 직접 CPU와 통신이 가능하여 중간에 SCSI컨트롤러 등이 없어도 사용가능. 
  * CPU가 모든 Disk의 IO를 관리하기 때문에 Disk IO가 늘어나면 CPU 처리량도 늘어 Disk IO때문에 CPU가 100%가 될 수 있음. 
  * 역으로 CPU의 부하 때문에 Disk IO퍼포먼스가 저하될 수 있음.

### HDD vs. SSD

* HDD
  * 전통 디스크 방식으로 가성비 및 내구성이 좋아 범용으로 사용
  * 일반적으로 6Gbps 정도가 최대 성능이며 RPM에 따라 처리속도 차이가 남. 디스크의 안쪽과 밖의 RPM에 따른 처리량이 달라 ORACLE등에서는 sparse table등을 만들어 RPM에 따른 효율 저하를 막는 기술 등에 따라 효율이 달라짐.
* SSD
  * FLASH NAND메모리에 저장하는 방식으로 기존 메모리와는 달리 전력이 끊겨도 보관되는 성질을 활용한 저장장치
  * RPM에 무관하고 Board Clock에 비례하여 IO속도가 나옴. 
  * Read는 보통 HDD의 6~12배, write는 MLC의 경우 1.5배이상, SLC의 경우 6배이상 성능이 나옴.
  * Write가 많은 경우 SLC를 채용하는 것을 추천하고 검색엔진 등 Read가 많은 서비스라면 MLC로도 충분함. 
  * SATA타입으로 제조 되기 때문에 CPU영향을 받게 되고 경우에 따라서는 Write 성능 저하 요인이 겹치면 MLC의 경우 HDD 정도의 IO성능이 나오기도 함. 

## Installation

### Preparing

* Server
  * Install JDK
  * Install VNC Server
* PC
  * Install VNC Client

* Connect VNC client

### Install ORACLE server application

* VNC
  * Run terminal
  * User Add
  ```sh
  groupadd –g 501 dba
  groupadd –g 502 oinstall
  useradd –g dba –G oinstall –u 501 oracle
  passwd oracle

  # change user
  su - oracle
  ```
  * Change bash profile
    * `~/.bash_profile`
    ```conf
    ORACLE_SID=HGJ; export ORACLE_SID
    ORACLE_BASE=/oracle/11.2.0; export ORACLE_BASE
    ORACLE_HOME=/oracle/11.2.0/OraHome1; export ORACLE_HOME
    #ORACLE_SID=xxxx; export ORACLE_SID
    PATH=$PATH:$ORACLE_HOME/bin

    export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$ORACLE_HOME/lib
    export ORA_NLS33=$ORACLE_HOME/ocommon/nls/admin/data
    ORACLE_TERM=xterm; export ORACLE_TERM
    NLS_LANG=AMERICAN_AMERICA.UTF8;export NLS_LANG
    PATH=$PATH:$ORACLE_HOME/bin:$ORACLE_HOME/OPatch:
    export PATH
    # DISPLAY=:3;export DISPLAY
    ```
  * change owner for oracle dir
    ```sh
    chown -R oracle:dba /oracle
    ```

  * Run installer on terminal
    ```sh
    ./runInstaller
    ```
    * VNC경유로 DISPLAY설정이 안되어 있으면 java error 발생
    * JRE에러라고 떠도 NHN에서 받았으면 JRE설치 되어 있으니 재설치 필요 없음
    * ORACLE_BASE : /oracle/11.2.0
    * ORACLE_HOME : /oracle/11.2.0/OraHome1
      * ORACLE_HOME 은 자동생성되므로 디렉토리가 존재하지 않아야 함.

    * 설치 중 Kernel parameter fix 하라고 메시지가 뜨는데 ignore all안됨. 다른 ssh 창을 띄워서 fix스크립트 실행
    ```sh
    /tmp/CVU_11.2.0.3.0_oracle]# ./runfixup.sh
    ```
    * package인스톨
      ```sh
      yum install -y libaio-*
      yum install -y compat-libstdc*
      yum install -y elfutils-libelf-devel
      ```
    * pdksh-5.2.14 error -> ignore all 체크하고 진행
      * 무시해도 된다고 공식 기록
        * https://docs.oracle.com/cd/E16338_01/relnotes.112/b56294/toc.htm
    * 마지막에 스크립트 fail뜨면 orainstRoot.sh 실행
      ```sh
      /oracle/oraInventory/orainstRoot.sh
      ```
    * 설치 윈도우에 돌아와서 retry하면 성공 뜸.
    * root.sh 실행
      ```sh
      /oracle/11.2.0/OraHome1/root.sh
      ```
      * bin dir : /usr/bin


### Configuration

* tnsnames.ora
* listner.ora
  * netca(GUI) 실행
    ```sh
    /oracle/11.2.0/OraHome1/bin/netca
    ```
    * listener sample
    ```conf
    HGJLSNR23 =
      (DESCRIPTION =
        (ADDRESS_LIST =
        (ADDRESS = (PROTOCOL=TCP)(HOST=10.1.0.1)(PORT=1521))
        )
      )

    SID_LIST_HGJLSNR23 =
      (SID_LIST =
        (SID_DESC =
          (GLOBAL_DBNAME = HGJ)
          (ORACLE_HOME = /oracle/11.2.0/OraHome1)
          (SID_NAME = mysid)
        )
      )
    ```
* Create Database
  * Create datadir
  ```sh
  mkdir -p /data2
  ```
  * run database management GUI
  ```sh
  /OraHome/bin/dbca
  # input password
  ```
  * Database : dbname
  * SID : dbsid
  * Database Credentials
    * Same PWD : `dbadminpwd`
  * Datafile : `/data2/oradata`
  * Fast Recovery 
    * Area : `/data1/fast_recovery_area`
    * Size : `5000`MBytes
  * Database Components > Standard Database Components
    * check `Oracle XML DB` only
  * Enable Archiving
    * Archive Log Dest : /data1/ARCH1/HGJDB1
  * Memory
    * Size : `120000`MB(23%)
    * Check Use Automatic Memory Management
  * Sizing
    * Process : `3000`
  * Character Sets
    * choose from the list of character sets
      * uncheck Show recommended character sets only
      * Select `US7ASCII`
        * recommended UTF-8
  * Connection Mode
    * Shared Server : `100`
  * Datafiles
    * File Size : `10240`MB
  * Redo Log Group1~3
    * File Size : `1024`MB
    * Dir : `/data2/oradata/{DB_UNIQUE_NAME}/`
    * Add Member : redo1x.rdo
      * Dir : `/data3/oradata/{DB_UNIQUE_NAME}/`
  * 完了すると`spfile<SID>.ora`というファイルが自動作成される
    * controlfiles位置
      * `/data2/oradata/<SID>/control01.ctl`
      * `/data1/fast_recovery_area/<SID>/control02.ctl`
  * ps -ef で`oracle<SID>`が稼働中のことを確認

* kernel parameter
  ```conf
  kernel.sem = 14010 32000 28010 128
  #kernel.shmall = 268435456
  # 240GB / 4096
  # kernel.shmall = 62914560
  # 180G / 4096
  kernel.shmall = 47185920
  kernel.shmmax = 193273528320
  ```

  * result
    ```sh
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
  * https://docs.oracle.com/cd/E11882_01/install.112/e47689/pre_install.htm#LADBI1187

### Restoredata

* create user
  * 필요한 user생성
* create tablespace
  * Disk IO를 보면서 부하가 적은 위치를 기준으로 설정.
  * Table과 INDEX는 모두 분리하여 작성하는 것이 좋음. 
  * 하나의 TBS도 파티션을 구분해 주는 것이 성능에 좋음. 
  * 너무 TBS사이즈를 작게 하면 FILE IO가 빈번하게 일어나기 때문에 역효과. 테이블 사이즈를 보면서 적절하게 만들 필요가 있음.
  * 하나의 TBS에 두 개 이상 파일을 작성(2개 이상인 경우 파일 손실시 자동 복구 됨.)
* impdp
  * User, Permission, Table, Data는 자동 생성되나 Tablespace는 자동생성되지 않기 때문에 먼저 생성해두지 않으면 에러 발생.
    * User를 생성하지 않으면 permission에러는 나지만 데이터에 이상 없음
  * impdp를 두 번 실행하면 데이터가 두 번 들어감(PK로 violation error가 뜨는 데이터는 한 번만 들어감)
* make database link

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

![PGA/SGA](https://cdn.app.compendium.com/uploads/user/e7c690e8-6ff9-102a-ac6d-e4aebca50425/58f63907-7d91-40f6-9575-59b695ec6b39/Image/43c40f14ad05634bdc5b9d2b0939f554/img_tsushima_120124_01.gif)

* SGA/PGA 割り当て
  * SGA : System Global Area
    * redo_log_buffer
      * rolback등에 필요한 데이터 보관 영역이므로 보통 하루에서 일주일 정도 데이터가 보관될 양을 추천
    * db_cache_size(buffer cache)
      * parsing된 쿼리를 보관하거나 실행된 쿼리결과를 보관하는 등 가장 많이 사용되는 영역으로 이 영역이 부족하면 swap이 늘어나면서 성능저하에 직결됨.
    * shared_pool
      * background process 및 기타 세션별 프로세싱 영역이므로 충분히 크게 잡아주지 않으면 query가 끝나지 않거나 메모리 부족으로 쿼리 실행 실패 문제가 발생할 수 있음.
    * large_pool
      * shared_pool과 같은 용도로 사용되는데 주로 처리 결과 및 공용 서버 설정(요즘 같은 익명성 대규모 유저를 받는 경우)의 UGA데이터, RMAN정보 및 parallel옵션을 준 쿼리 결과가 우선 저장되면 shared_pool은 재사용하는 경우가 많지만 large_pool은 삭제되지 않고 지속적인 보관이 되어 memory fragmentation이 shared_pool보다 적게 발생하기 때문에 크게 잡고 많이 사용하는 것이 좋음.
    * java_pool
      * JAVA계열 프로세스용으로 거의 사용하지 않으므로 크게 잡지 않아도 됨. JDBC등으로 연결된다고 java_pool을 사용하는 것이 아니고 ORACLE에서 자체적으로 사용하는 것.
    * stream_pool, etc
  * PGA : Program Global Area
    * UGA : User Global Area
      * 유저별 temporary tablespace 영역 및 전용 서버 설정으로 유저별 영역을 만들 때 사용하 영역으로 요즘 처럼 대규모 익명 유저가 접속하는 서비스의 설계시 실제로 사용은 많이 하지 않음. 대부분 SGA에서 사용하기 때문에 User session에서만 가져야 하는 내용이 적기 때문에 많은 영역을 설정하지 않아도 됨
    * Stack영역
  * https://blogs.oracle.com/otnjp/tsushima-hakushi-14

### config tuning

* awr/ash report
```sh
sqlplus / as sysdba @?/rdbms/admin/awrrpt
sqlplus / as sysdba @?/rdbms/admin/ashrpt
```
* enq: TX - row lock contention
  * update등으로 인한 row lock이 발생하면서 chain lock 상태
    * iostat을 보더라도 disk사용율이 높지 않은 경우에도 발생할 수 있음. 이는 단일 IO대기 성능 이슈로 발생할 수 있기 때문에 단일IO대기로 나머지 모든 queue가 대기하게 되면 iostat의 disk사용률은 낮은 채로 wait만 늘어나게 됨.
      * SAS와 SATA의 병렬 처리 이슈도 원인의 가능성 있음.
* OS Memory 튜닝
```
ORA-01034: ORACLE not available
ORA-27102: out of memory
Linux-x86_64 Error: 12: Cannot allocate memory
```
  * ORACLE은 OS상의 메모리를 SHM(Semaphore)영역을 먼저 할당하고 OS 및 어플리케이션 영역을 할당한 뒤에 남은 메모리에서 ORACLE 프로세스에 할당함.
  * 만약 SHM + App + SGA + PGA가 물리 메모리보다 크게 잡혀있으면 SGA + PGA가 나중에 할당되기 때문에 cannot allocate memory 메시지가 뜸.
  * 512GB메모리인 경우 
    * SHM : 252GB
    * PGA : 64GB
    * SGA : 178GB

* ORA-27300
  * SHM(Semaphore)설정 문제로 인한 대량 처리 불가.
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
# MSL(SHM식별자 별 최대 SHM 수), MNS(시스템 전체 SHM수), OPM(SHM콜 당 최대 연산자 수), MNI(시스템 전체 SHM식별자 수)
# SEMMNS = MSL * MNI
# Recommend MSL = OPM
# kernel.sem = 5010 641280 5010 128
kernel.sem = 14010 1793280 14010 128
#kernel.shmall = 268435456
# 240GB(SGA+PGA) / 4096
# kernel.shmall = 62914560
# 180G(SAG) / 4096
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

### using shell

* ORACLE은 SQL Server와는 달리 운용을 위한 툴이 거의 서드파티에 의한 유료 툴로 이루어져 있어 OS의 shell 의존도가 상당히 높음.

* Shell용 SQL
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
  * long : 한 필드에 표시되는 문자 수. 적으면 내용이 중간에 잘린다. 
  * head off : 필드명을 없앤다. 
  * feed on : 한 필드 내의 줄넘김을 표시한다. off면 한줄만 표시되면서 다음 줄 이후는 잘린다. 
  * wrap on : ?? 기억이;;
  * linesize 3200 : 한 줄에 3200글자까지 지원.. 이게 작으면 오른쪽이 잘린다. 
  * pagesize 0 : 한 줄에 표현하는 페이지.. 숫자가 커도 별로 의미 없이 공백만 생기므로 0으로 설정
  * trimsppo on : 이건 그냥 붙여봤는데 아직 테스트 안함.
  * lognchunksize 1024 : 오른쪽 글자 잘림을 막아줌(linesize가 있어도 잘리는 경우 이것까지 넣으니까 다음줄로 * 안넘어가고 옆으로 잘 붙어준다.)
  * spool filename.sql : filename.sql 파일로 출력해준다. 
  * Ref : https://talklowykr.blogspot.com/2020/07/oracle.html
