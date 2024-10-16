# TiDB

KV(Key Value)を使ったNoSQLのような保存方式でMySQLと同じSQLが使えるDBMS

## TTL

TTL은 데이터베이스에서 특정 데이터의 유효 기간을 설정하여, 그 기간이 지나면 자동으로 해당 데이터를 삭제하는 기능입니다. TiDB에서는 이 TTL 기능을 통해 데이터의 라이프사이클을 관리하고, 오래된 데이터를 자동으로 정리함으로써 스토리지 공간을 효율적으로 사용할 수 있습니다.

### 주요 기능 및 특징:

데이터 자동 만료 및 삭제: 지정한 시간이 지나면 데이터가 자동으로 삭제되어 수동으로 데이터 정리에 대한 부담을 줄여줍니다.

스토리지 최적화: 불필요한 데이터가 축적되는 것을 방지하여 스토리지 사용량을 줄이고, 성능을 향상시킵니다.

유연한 설정: 테이블 단위로 TTL을 설정할 수 있으며, 필요에 따라 TTL 값을 수정하거나 제거할 수 있습니다.

### 사용 방법:

테이블 생성 시 TTL 설정:

```sql
CREATE TABLE session_logs (
  session_id VARCHAR(255) PRIMARY KEY,
  user_id INT,
  activity TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) TTL = '7d';
```
위 예제에서는 session_logs 테이블에 7일의 TTL을 설정하였습니다. created_at 필드를 기준으로 데이터가 7일 후에 자동 삭제됩니다.

기존 테이블에 TTL 추가 또는 변경:

```sql
ALTER TABLE session_logs SET TTL = '14d';
```
이 명령을 통해 session_logs 테이블의 TTL을 14일로 변경할 수 있습니다.

### TTL 제거:

```sql
ALTER TABLE session_logs REMOVE TTL;
```
TTL 설정을 제거하여 자동 삭제 기능을 해제할 수 있습니다.

### 주의사항:

데이터 복구 불가: TTL에 의해 삭제된 데이터는 복구가 어렵기 때문에, 중요한 데이터에 대해선 신중하게 설정해야 합니다.

인덱스 및 파티셔닝 고려: TTL 기능을 사용할 때 인덱스나 파티셔닝과의 호환성을 확인하여 성능 저하를 방지해야 합니다.

백업 전략 수립: 자동 삭제로 인해 필요한 데이터까지 손실되지 않도록 정기적인 백업이 필요할 수 있습니다.

### 활용 사례:

로그 관리: 일정 기간 이후의 로그 데이터를 자동으로 삭제하여 로그 관리의 효율성을 높일 수 있습니다.

임시 데이터 관리: 세션 정보나 캐시와 같은 단기 데이터를 자동으로 정리하여 시스템 자원을 최적화합니다.

규제 준수: 데이터 보관 기간에 대한 법적 요구 사항을 만족시키기 위해 TTL을 활용할 수 있습니다.

TiDB의 TTL 기능은 데이터의 수명 관리를 자동화하여 운영 효율성을 높이고 스토리지 자원을 절약하는 데 유용합니다. 올바르게 활용하면 시스템의 성능 향상과 관리 비용 절감에 큰 도움이 됩니다.

### TTL 삭제 대상 데이터만 다른 테이블로 옮겨지게 설정

TiDB의 TTL(Time To Live) 기능은 특정 기간이 지나면 데이터가 자동으로 삭제되도록 설계되어 있습니다. 그러나 기본적으로 TTL에 의해 삭제될 데이터를 다른 테이블로 옮기는 기능은 제공되지 않습니다.

하지만 원하는 기능을 구현하기 위해 다음과 같은 방법을 고려해 볼 수 있습니다:

- 사용자 정의 데이터 이동 프로세스 구축:

- 스케줄러 사용: Cron과 같은 스케줄러를 사용하여 정기적으로 만료 예정 데이터를 조회하고, 해당 데이터를 다른 테이블로 복사한 후 원본 테이블에서 삭제하는 스크립트를 실행할 수 있습니다.
애플리케이션 레벨 처리: 애플리케이션 코드에서 데이터 생성 시 만료 시점을 계산하여, 만료되기 전에 데이터를 다른 테이블로 옮기는 로직을 추가할 수 있습니다.

- ETL 도구 활용:

TiDB와 호환되는 ETL(Extract, Transform, Load) 도구를 사용하여 만료 예정 데이터를 추출하고, 다른 테이블이나 스토리지로 옮길 수 있습니다.
예를 들어, Apache NiFi나 Apache Spark를 활용하여 데이터 이동 작업을 자동화할 수 있습니다.

- 파티셔닝 사용:

데이터의 생성 날짜나 만료 시점을 기준으로 테이블을 파티셔닝하면, 만료된 파티션을 통째로 다른 테이블로 옮기거나 백업한 후 드롭하는 방식으로 관리할 수 있습니다.
이 방법은 대용량 데이터에 대해 효율적으로 작동하며, 파티션 단위로 관리가 용이합니다.

- 주의사항 및 고려사항:

트랜잭션 일관성: 데이터 이동과 삭제 작업이 원자적으로 이루어지지 않을 수 있으므로, 데이터의 일관성을 유지하기 위한 추가적인 고려가 필요합니다.
성능 영향: 대량의 데이터를 이동하거나 삭제하는 작업은 시스템에 부하를 줄 수 있으므로, 비피크 시간대에 작업을 스케줄링하는 것이 좋습니다.
추가 개발 필요: 위의 방법들은 기본 기능이 아니기 때문에, 별도의 개발 및 유지 보수 노력이 필요합니다.

- 결론:

TiDB의 TTL 기능 자체로는 만료된 데이터를 다른 테이블로 자동 이동시키는 기능을 지원하지 않습니다. 그러나 스케줄러나 ETL 도구, 파티셔닝 등을 활용하여 원하는 동작을 구현할 수 있습니다. 이러한 방법을 적용할 때는 시스템 성능과 데이터 일관성에 주의를 기울여야 합니다.

## TiDB에서 지원하는 파티셔닝 유형

### 범위 파티셔닝 (Range Partitioning):

특정 열의 값 범위에 따라 데이터를 분할합니다.
예시:
```sql
CREATE TABLE orders (
  order_id INT,
  customer_id INT,
  order_date DATE,
  amount DECIMAL(10,2)
)
PARTITION BY RANGE ( YEAR(order_date) ) (
  PARTITION p2019 VALUES LESS THAN (2020),
  PARTITION p2020 VALUES LESS THAN (2021),
  PARTITION p2021 VALUES LESS THAN (2022)
);
```

### 해시 파티셔닝 (Hash Partitioning):

특정 열의 해시 값을 기반으로 데이터를 균등하게 분할합니다.
예시:
```sql
CREATE TABLE users (
  user_id INT,
  username VARCHAR(50)
)
PARTITION BY HASH(user_id) PARTITIONS 4;
```

### 키 파티셔닝 (Key Partitioning):

해시 파티셔닝과 유사하지만, MySQL의 내부 해시 함수를 사용합니다.
예시:
```sql
CREATE TABLE sessions (
  session_id VARCHAR(255),
  user_id INT
)
PARTITION BY KEY(user_id) PARTITIONS 4;
```

### 리스트 파티셔닝 (List Partitioning):

특정 열의 특정 값 목록에 따라 데이터를 분할합니다.
예시:
```sql
CREATE TABLE regions (
  region_id INT,
  country VARCHAR(50)
)
PARTITION BY LIST COLUMNS(country) (
  PARTITION pAsia VALUES IN ('Korea', 'China', 'Japan'),
  PARTITION pEurope VALUES IN ('France', 'Germany', 'Italy')
);
```

### 파티셔닝의 장점
- 데이터 관리 용이성: 파티션 단위로 데이터의 추가, 삭제, 백업 등이 가능하여 대용량 테이블 관리가 편리합니다.
성능 향상: 쿼리 시 관련 파티션만 스캔하므로, 검색 속도가 향상될 수 있습니다.
데이터 유지보수 효율성: 오래된 데이터를 포함한 파티션을 쉽게 제거하거나 아카이브할 수 있습니다.
- 사용 시 고려사항
  - 제약 조건: 파티션 키는 프라이머리 키나 인덱스 키와 일치해야 효율적입니다.
  - 제한 사항: 일부 복잡한 파티셔닝 전략은 TiDB에서 지원되지 않을 수 있으므로, 공식 문서를 참고해야 합니다.
  - 성능 테스트: 파티셔닝이 항상 성능을 향상시키는 것은 아니므로, 실제 워크로드에 대한 테스트가 필요합니다.
- 파티셔닝과 TTL의 조합
  파티셔닝을 활용하면 TTL 기능과 결합하여 만료된 데이터를 다른 테이블로 옮기는 작업을 간소화할 수 있습니다. 예를 들어, 날짜를 기준으로 파티셔닝된 테이블에서 특정 파티션을 다른 테이블로 이동하거나 백업한 후 삭제하는 방식으로 운영할 수 있습니다.

TiDB는 다양한 파티셔닝 기능을 제공하여 대용량 데이터베이스의 성능 최적화와 관리 효율성을 높일 수 있습니다. 파티셔닝을 적절히 활용하면 데이터의 수명 주기를 효과적으로 관리하고, 특정 요구 사항에 맞는 데이터 아키텍처를 설계할 수 있습니다.

## TiDB에서 날짜를 기준으로 파티셔닝된 테이블에서 특정 파티션을 다른 테이블로 자동으로 이동하는 방법

### 파티션 교환(Partition Exchange) 기능 활용
TiDB는 ALTER TABLE ... EXCHANGE PARTITION 문을 지원하여 테이블과 파티션 간의 데이터를 교환할 수 있습니다. 이를 통해 특정 파티션의 데이터를 다른 테이블로 이동할 수 있습니다.

예시:

```sql
-- 교환 대상 테이블 생성 (원본 파티션과 동일한 구조로)
CREATE TABLE archive_table LIKE original_table;

-- 특정 파티션을 다른 테이블과 교환
ALTER TABLE original_table
EXCHANGE PARTITION partition_name WITH TABLE archive_table;
```
주의사항:

테이블 구조 동일성: 교환 대상 테이블(archive_table)은 원본 테이블(original_table)의 파티션과 완전히 동일한 테이블 구조를 가져야 합니다.
인덱스 및 제약 조건: 인덱스, 제약 조건 등 모든 스키마 요소가 동일해야 합니다.
빈 테이블 사용: 교환 대상 테이블은 비어 있어야 합니다.

### 스크립트와 스케줄러를 통한 자동화
자동화를 위해 스크립트를 작성하고 시스템 스케줄러(cron 등)를 사용하여 정기적으로 실행할 수 있습니다.

단계:

SQL 스크립트 작성:

교환할 파티션을 결정하는 로직을 포함합니다.
예를 들어, 30일 이상 된 데이터가 있는 파티션을 선택합니다.

```sql
-- 예시 스크립트
SET @partition_to_exchange = 'p202201';
SET @archive_table = CONCAT('archive_', @partition_to_exchange);

CREATE TABLE IF NOT EXISTS @archive_table LIKE original_table;

ALTER TABLE original_table
EXCHANGE PARTITION @partition_to_exchange WITH TABLE @archive_table;
```
스크립트 자동화:

위의 SQL 스크립트를 실행하는 셸 스크립트를 작성합니다.
```bash
#!/bin/bash
mysql -u username -p'password' -D database_name < /path/to/sql_script.sql
```

스케줄러 설정:

cron을 사용하여 스크립트를 정기적으로 실행하도록 설정합니다.
```bash
0 2 * * * /path/to/script.sh
```

### 파티션 추가 및 삭제 자동화
파티션을 교환한 후 오래된 파티션을 삭제하고 새로운 파티션을 추가하는 과정도 자동화할 수 있습니다.

단계:

파티션 삭제:

```sql
ALTER TABLE original_table DROP PARTITION partition_name;
```

새 파티션 추가:

```sql
ALTER TABLE original_table ADD PARTITION (
  PARTITION partition_new VALUES LESS THAN (TO_DAYS('2022-02-01'))
);
```

전체 과정 자동화:

위의 SQL 명령어들을 하나의 스크립트로 작성하여 스케줄러로 실행합니다.

### ETL 도구 활용
Apache NiFi, Airflow, 또는 자체 개발한 ETL 스크립트를 사용하여 데이터 이동과 파티션 관리를 자동화할 수 있습니다.

- 장점:
  - 복잡한 로직을 시각적으로 관리 가능
  - 다양한 데이터 소스와 연동 용이

- 단점:
  - 초기 설정과 학습에 시간이 필요
  - 추가적인 시스템 자원 소모

### TiDB의 내부 기능 활용
TiDB는 MySQL과 호환되지만, 특정 기능이나 버전에 따라 일부 차이가 있을 수 있습니다. TiDB의 최신 문서를 참고하여 내부 스케줄링 기능이나 작업 예약 기능을 활용할 수 있는지 확인합니다.

- 주의사항
  - 데이터 일관성: 파티션 교환 시 트랜잭션과 데이터 일관성을 유지해야 합니다.
  - 백업: 중요한 데이터를 이동하거나 삭제하기 전에 전체 백업을 권장합니다.
  - 테스트 환경에서 검증: 프로덕션 환경에 적용하기 전에 테스트 환경에서 충분히 검증합니다.
  - 성능 영향 최소화: 시스템 부하를 고려하여 비활성 시간대에 작업을 스케줄링합니다.

TiDB에서 날짜 기반으로 파티셔닝된 테이블의 특정 파티션을 다른 테이블로 자동 이동하려면 파티션 교환 기능과 스크립트 자동화를 결합하여 구현할 수 있습니다. 이를 통해 데이터 아카이빙과 오래된 데이터 관리가 효율적으로 이루어질 수 있습니다.

## TiDBで1か月単位のパーティションテーブルを自動管理

### 1. パーティションテーブルの作成
**RANGE PARTITION**を使用して、月ごとのパーティションを設定します。

```sql
CREATE TABLE orders (
  order_id INT NOT NULL,
  customer_id INT NOT NULL,
  order_date DATE NOT NULL,
  amount DECIMAL(10, 2),
  PRIMARY KEY (order_id, order_date)
) PARTITION BY RANGE (TO_DAYS(order_date)) (
  PARTITION p202310 VALUES LESS THAN (TO_DAYS('2023-11-01')),
  PARTITION p202311 VALUES LESS THAN (TO_DAYS('2023-12-01'))
);
```
- ポイント:
  - TO_DAYS(): DATE型を日数に変換し、RANGEによるパーティションを可能にします。
  - プライマリキーにパーティションキーが含まれる必要がある点に注意してください。

### 2. 月ごとのパーティション自動追加
新しい月が始まるたびに、新しいパーティションを追加するSQLを自動で実行する方法を考えます。

SQL: 新しいパーティションの追加
```sql
SET @next_month = DATE_FORMAT(CURRENT_DATE + INTERVAL 1 MONTH, '%Y-%m-01');
SET @next_next_month = DATE_FORMAT(CURRENT_DATE + INTERVAL 2 MONTH, '%Y-%m-01');

SET @sql = CONCAT(
  'ALTER TABLE orders ADD PARTITION (',
  'PARTITION p', DATE_FORMAT(@next_month, '%Y%m'),
  ' VALUES LESS THAN (TO_DAYS(''', @next_next_month, ''')))'
);

PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;
```
このスクリプトは、翌月分のパーティションを動的に作成します。毎月の始まりにこのSQLを実行することで、パーティションの追加を自動化できます。

### 3. 自動化のためのCronジョブ設定
毎月1日の深夜に上記のSQLを自動実行するよう、cronジョブを設定します。

手順:
- 上記のSQLを**add_partition.sql**というファイルに保存します。

- 次のようなシェルスクリプトを作成します。

```bash
#!/bin/bash
mysql -u <username> -p<password> -D <database_name> < /path/to/add_partition.sql
```
- cronにジョブを追加します。

```bash
0 0 1 * * /path/to/script.sh
```
上記の設定は、毎月1日の深夜0時にスクリプトを実行します。

### 4. 古いパーティションの削除
たとえば、6か月以上前の古いパーティションを削除する場合、次のようにSQLを設定できます。

SQL: 古いパーティションの削除
```sql
SET @old_partition = DATE_FORMAT(CURRENT_DATE - INTERVAL 6 MONTH, '%Y%m');

SET @sql = CONCAT(
  'ALTER TABLE orders DROP PARTITION p', @old_partition
);

PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;
```
このSQLも定期的に実行して、古いデータを自動で削除することができます。

### 5. パフォーマンス上の注意点
- インデックス管理:
  - パーティションテーブルではインデックスの設計が重要です。適切に設計しないとクエリ性能に悪影響を与える可能性があります。
- パーティションプルーニング:
  - TiDBはクエリ時に必要なパーティションのみをスキャンする「パーティションプルーニング」をサポートします。クエリに**パーティションキー（order_date）**を含めることで性能を向上させます。

TiDBで月ごとのパーティションテーブルを管理するには、以下のプロセスを自動化するのが効果的です。

- 新しいパーティションの自動追加：ALTER TABLE文を毎月実行。
- 古いパーティションの自動削除：定期的に古いデータを削除。
- cronを使ったSQL実行の自動化。

これにより、TiDBのパーティションテーブルを効率的に運用できます。さらに、必要に応じてバックアップ戦略も計画することをお勧めします。

## Ref

- [TiDB ドキュメント - パーティションテーブル](https://docs.pingcap.com/ja/tidb/stable/partitioned-table)
  - https://docs.pingcap.com/ja/tidb/stable/partitioned-table
