# Database

클라우드 기술이 나오면서 DFS(distributed file system)위에서의 데이터 구조는 기존 RDBMS(Relational database management system)에서의 구조와는 명백하게 달라지고 있다. 

NoSQL의 출현으로 방대한 시퀀셜 데이터는 RDBMS를 능가하는 성능과 가격으로 자리를 잡게 되어, 
RDBMS는 용량이 큰 로그성 데이터를 모두 뺏기게 되었다. 
하지만 원래부터 DW같은 통계 정보를 위한 데이터가 아닌 이상 불필요하게 RDBMS에 때려 넣는 것은 무의미 하기 때문에 
NoSQL의 시장이 커졌다고 해서 RDBMS 시장이 줄어든 것은 아니다. 
게다가 NoSQL등의 영향으로 데이터를 File이 아닌 Managed Storage에 저장하는 성향이 나오면서 오히려 RDBMS의 역할이 중요해지고 있다. 

RDBMS와 NoSQL의 가장 큰 특징은

- RDBMS는 JOIN등의 데이터와의 연계에 강하다. NoSQL을 JOIN하려면 많은 성능을 포기하여야 한다. 4개 정도의 테이블 조인으로 NoSQL은 사용할 수 없을 정도라고 
할 정도로 속도는 저하된다. 
- NoSQL은 테이블 설계를 변경하지 않고도 자유롭게 필드를 추가할 수 있다. 문제는 Name필드나 Name1필드나 NameEng 필드처럼 작업자에 의해서 
다양한 필드가 만들어지면 검색할 수 없는 문제가 발생하기 때문에 관리가 훨씬 중요해진다. 

