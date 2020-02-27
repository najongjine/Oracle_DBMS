drop table tbl_cbt;
drop sequence seq_cbt;
create SEQUENCE SEQ_CBT
start with 1 INCREMENT by 1;

create TABLE tbl_cbt(
        CB_SEQ number primary key,
		CB_QUESTION nvarchar2(1000) not null unique,
		CB_ANSWER1 nvarchar2(1000) not null,
		CB_ANSWER2 nvarchar2(1000) ,
		CB_ANSWER3 nvarchar2(1000) ,
		CB_ANSWER4 nvarchar2(1000) ,
		CB_CORRECT_ANSWER nvarchar2(1000) not null
        );
        
insert into tbl_cbt (
CB_SEQ,
CB_QUESTION,
CB_ANSWER1,
CB_ANSWER2,
CB_ANSWER3,
CB_ANSWER4,
CB_CORRECT_ANSWER) values (
SEQ_CBT.nextval,
'데크(Deque)에 대한 설명으로 옳지 않은 것은?',
'입력 제한 데크는 Shelf이고, 출력 제한 테크는 Scroll이다.',
'삽입과 삭제가 리스트의 양쪽 끝에서 발생할 수 있는 자료 구조이다.',
'스택과 큐의 장점으로 구성한 것이다.',
'Double Ended Queue의 약자이다.',
'입력 제한 데크는 Shelf이고, 출력 제한 테크는 Scroll이다.'
);
commit;

insert into tbl_cbt (
CB_SEQ,
CB_QUESTION,
CB_ANSWER1,
CB_ANSWER2,
CB_ANSWER3,
CB_ANSWER4,
CB_CORRECT_ANSWER) values (
SEQ_CBT.nextval,
'관계해석에서 ‘for all : 모든 것에 대하여’의 의미를 나타내는 논리 기호는?',
'∃',
'∈',
'∀',
'U',
'∀'
);
commit;

insert into tbl_cbt (
CB_SEQ,
CB_QUESTION,
CB_ANSWER1,
CB_ANSWER2,
CB_ANSWER3,
CB_ANSWER4,
CB_CORRECT_ANSWER) values (
SEQ_CBT.nextval,
'관계해석에서 ‘for all : 모든 것에 대하여’의 의미를 나타내는 논리 기호는?',
'∃',
'∈',
'∀',
'U',
'∀'
);
commit;

insert into tbl_cbt (
CB_SEQ,
CB_QUESTION,
CB_ANSWER1,
CB_ANSWER2,
CB_ANSWER3,
CB_ANSWER4,
CB_CORRECT_ANSWER) values (
SEQ_CBT.nextval,
'순서가 A, B, C, D로 정해진 자료를 스택(stack)에 입력하였다가 출력한 결과로 옳지 않은 것은?',
'B, A, D, C',
'A, B, C, D',
'D, A, B, C',
'C, B, A, D',
'D, A, B, C'
);
commit;

insert into tbl_cbt (
CB_SEQ,
CB_QUESTION,
CB_ANSWER1,
CB_ANSWER2,
CB_ANSWER3,
CB_ANSWER4,
CB_CORRECT_ANSWER) values (
SEQ_CBT.nextval,
'DBMS의 필수기능 중 모든 응용 프로그램들이 요구하는 데이터 구조를 지원하기 이해 데이터베이스에 저장될 데이터 타입과 구조에 대한 정의, 이용 방식, 제약조건 등을 명시하는 기능은?',
'정의 기능',
'조작 기능',
'사상 기능',
'제어 기능',
'정의 기능'
);
commit;

insert into tbl_cbt (
CB_SEQ,
CB_QUESTION,
CB_ANSWER1,
CB_ANSWER2,
CB_ANSWER3,
CB_ANSWER4,
CB_CORRECT_ANSWER) values (
SEQ_CBT.nextval,
'데이터베이스의 상태를 변환시키기 위하여 논리적 기능을 수행하는 하나의 작업 단위를 무엇이라하는가?',
'프로시저',
'트랜잭션',
'모듈',
'도메인',
'트랜잭션'
);
commit;

insert into tbl_cbt (
CB_SEQ,
CB_QUESTION,
CB_ANSWER1,
CB_ANSWER2,
CB_ANSWER3,
CB_ANSWER4,
CB_CORRECT_ANSWER) values (
SEQ_CBT.nextval,
'조직이나 기업체의 중심이 되는 업무시스템에서 모아진 정보를 일관된 스키마로 저장한 저장소를 의미하는 것은?',
'Data Warehouse',
'Data Mining',
'Classificaition',
'Clustering',
'Data Warehouse'
);
commit;

insert into tbl_cbt (
CB_SEQ,
CB_QUESTION,
CB_ANSWER1,
CB_ANSWER2,
CB_ANSWER3,
CB_ANSWER4,
CB_CORRECT_ANSWER) values (
SEQ_CBT.nextval,
'정규화 과정 중 BCNF에서 4NF가 되기 위한 조건은?',
'조인 종속성 이용',
'다치 종속 제거',
'이행적 함수 종속 제거',
'결정자이면서 후보키가 아닌 함수 종속 제거',
'다치 종속 제거'
);
commit;

insert into tbl_cbt (
CB_SEQ,
CB_QUESTION,
CB_ANSWER1,
CB_ANSWER2,
CB_ANSWER3,
CB_ANSWER4,
CB_CORRECT_ANSWER) values (
SEQ_CBT.nextval,
'Which of the following is not a property of the transaction to ensure integrity of the data?',
'isolation',
'autonomy',
'durability',
'consistency',
'autonomy'
);
commit;

insert into tbl_cbt (
CB_SEQ,
CB_QUESTION,
CB_ANSWER1,
CB_ANSWER2,
CB_ANSWER3,
CB_ANSWER4,
CB_CORRECT_ANSWER) values (
SEQ_CBT.nextval,
'속성(attribute)에 대한 설명으로 틀린 것은?',
'속성은 개체의 특성을 기술한다.',
'속성은 데이터베이스를 구성하는 가장 작은 논리적 단위이다.',
'속성은 파일 구조상 데이터 항목 또는 데이터 필드에 해당된다.',
'속성의 수를 “cardinality" 라고 한다.',
'속성의 수를 “cardinality" 라고 한다.'
);
commit;

insert into tbl_cbt (
CB_SEQ,
CB_QUESTION,
CB_ANSWER1,
CB_ANSWER2,
CB_ANSWER3,
CB_ANSWER4,
CB_CORRECT_ANSWER) values (
SEQ_CBT.nextval,
'데이터베이스 설계시 논리적 설계 단계에 대한 설명으로 옳지 않은 것은?',
'사용자의 요구에 대한 트랜잭션을 모델링한다.',
'트랜잭션 인터페이스를 설계한다.',
'관계형 데이터베이스에서는 테이블을 설계하는 단계이다.',
'DBMS에 맞는 논리적 스키마를 설계한다.',
'사용자의 요구에 대한 트랜잭션을 모델링한다.'
);
commit;

insert into tbl_cbt (
CB_SEQ,
CB_QUESTION,
CB_ANSWER1,
CB_ANSWER2,
CB_ANSWER3,
CB_ANSWER4,
CB_CORRECT_ANSWER) values (
SEQ_CBT.nextval,
'병행제어의 목적으로 옳지 않은 것은?',
'사용자에 대한 응답시간 최소화',
'시스템 활용도 최대화',
'데이터베이스 일관성 유지',
'데이터베이스 공유도 최소화',
'데이터베이스 공유도 최소화'
);
commit;

insert into tbl_cbt (
CB_SEQ,
CB_QUESTION,
CB_ANSWER1,
CB_ANSWER2,
CB_ANSWER3,
CB_ANSWER4,
CB_CORRECT_ANSWER) values (
SEQ_CBT.nextval,
'Which is not in the three-schema architecture?',
'internal schema',
'conceptual schema',
'extemal schema',
'procedural schema',
'procedural schema'
);
commit;

insert into tbl_cbt (
CB_SEQ,
CB_QUESTION,
CB_ANSWER1,
CB_ANSWER2,
CB_ANSWER3,
CB_ANSWER4,
CB_CORRECT_ANSWER) values (
SEQ_CBT.nextval,
'시스템 카탈로그에 대한 설명으로 틀린 것은?',
'시스템 카탈로그는 DBMS가 스스로 생성하고 유지하는 데이터베이스 내의 특별한 테이블들의 집합체이다.',
'일반 사용자도 SQL을 이용하여 시스템 카탈로그를 직접 갱신할 수 있다.',
'DBMS는 자동적으로 시스템 카탈로그 테이블들의 행을 삽입, 삭제, 수정한다.',
'시스템 카탈로그는 데이터베이스 구조에 관한 메타 데이터를 포함한다.',
'일반 사용자도 SQL을 이용하여 시스템 카탈로그를 직접 갱신할 수 있다.'
);
commit;

insert into tbl_cbt (
CB_SEQ,
CB_QUESTION,
CB_ANSWER1,
CB_ANSWER2,
CB_ANSWER3,
CB_ANSWER4,
CB_CORRECT_ANSWER) values (
SEQ_CBT.nextval,
'SSD(Solid State Drive)에서 하나의 셀에 3비트의 정보를 저장하는 방식은?',
'ALC',
'MLC',
'SLC',
'TLC',
'TLC'
);
commit;

insert into tbl_cbt (
CB_SEQ,
CB_QUESTION,
CB_ANSWER1,
CB_ANSWER2,
CB_ANSWER3,
CB_ANSWER4,
CB_CORRECT_ANSWER) values (
SEQ_CBT.nextval,
'CISC 구조와 RISC 구조를 비교하였을 때, RISC 구조의 특징으로 가장 옳지 않은 것은?',
'명령어가 복잡하다.',
'프로그램 길이가 길다.',
'래지스터 갯수가 많다.',
'파이프라인 구현이 용이하다.',
'명령어가 복잡하다.'
);
commit;

insert into tbl_cbt (
CB_SEQ,
CB_QUESTION,
CB_ANSWER1,
CB_ANSWER2,
CB_ANSWER3,
CB_ANSWER4,
CB_CORRECT_ANSWER) values (
SEQ_CBT.nextval,
'CPU 클록이 100MHz일 때 인출 사이클(fetch cycle)에 소요되는 시간은? (단, 인출사이클은 3개의 마이크로명령어들로 구성된다.)',
'3ns',
'30ns',
'33ns',
'300ns',
'30ns'
);
commit;

insert into tbl_cbt (
CB_SEQ,
CB_QUESTION,
CB_ANSWER1,
CB_ANSWER2,
CB_ANSWER3,
CB_ANSWER4,
CB_CORRECT_ANSWER) values (
SEQ_CBT.nextval,
'Flynn의 컴퓨터 구조 분류에서 여러 개의 처리기에서 수행되는 인스트럭은 서로 다르나 전체적으로 하나의 데이터 스트림을 가지는 형태는?',
'MIMD',
'MISD',
'SIMD',
'SISD',
'MISD'
);
commit;

insert into tbl_cbt (
CB_SEQ,
CB_QUESTION,
CB_ANSWER1,
CB_ANSWER2,
CB_ANSWER3,
CB_ANSWER4,
CB_CORRECT_ANSWER) values (
SEQ_CBT.nextval,
'캐시메모리에서 특정 내용을 찾는 방식 중 매핑 방식에 주로 사용되는 메모리는?',
'Flash memory',
'Associative memory',
'Virtual memory',
'Stack memory',
'Associative memory'
);
commit;

insert into tbl_cbt (
CB_SEQ,
CB_QUESTION,
CB_ANSWER1,
CB_ANSWER2,
CB_ANSWER3,
CB_ANSWER4,
CB_CORRECT_ANSWER) values (
SEQ_CBT.nextval,
'0-번지 명령형(zero-address instruction format)을 갖는 컴퓨터 구조 원리는?',
'An accumulator extension register',
'Virtual memory architecture',
'Stack architecture',
'Micro-programming',
'Stack architecture'
);
commit;

insert into tbl_cbt (
CB_SEQ,
CB_QUESTION,
CB_ANSWER1,
CB_ANSWER2,
CB_ANSWER3,
CB_ANSWER4,
CB_CORRECT_ANSWER) values (
SEQ_CBT.nextval,
'다음 중 롬(Rom)내에 기억시켜 둘 필요가 없는 정보는?',
'bootatrap loader',
'microprogram',
'display character code',
'source program',
'source program'
);
commit;