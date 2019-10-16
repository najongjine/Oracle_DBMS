--
desc tbl_test_std;

--tbl_student 테이블을 테스트할때 
--원본 테이블을 손상하지 않고 테스트를 위하여 테이블 복제.
create table tbl_test_std
as 
select * from tbl_student;
/*
이름       널?       유형             
-------- -------- -------------- 
ST_NUM   NOT NULL VARCHAR2(3)    primary key
ST_NAME  NOT NULL NVARCHAR2(50)  
ST_TEL            VARCHAR2(20)   
ST_ADDR           NVARCHAR2(125) 
ST_GRADE          NUMBER(1)      
ST_DEPT           VARCHAR2(3)    

Table TBL_TEST_STD이(가) 생성되었습니다.

이름       널?       유형             
-------- -------- -------------- 
ST_NUM            VARCHAR2(3)    
ST_NAME  NOT NULL NVARCHAR2(50)  
ST_TEL            VARCHAR2(20)   
ST_ADDR           NVARCHAR2(125) 
ST_GRADE          NUMBER(1)      
ST_DEPT           VARCHAR2(3)  
*/

--테스트를 위해서 tbl_student 테이블을 tbl_test_std 테이블로 통짜 복제를 했는데
--테이블을 복제하면 데이터형식, 데이터들 그리고 notnull 등 일부는 그대로 복제가 되는데
--pk등 중요한 제약조건들은 무시되고 복제 되지 않는다.
--복제된 테이블에 제약조건 추가를 해야 한다.

--또는 테이블을 생성할 당시에는 제약조건들이 필요하지 않아서 작성하지 않았는데
--나중에 사용하다보니 제약조건들이 필요한 경우가 생겨서
--테이블을 새로 작성하지 않고 제약조건들만 추가하는 방법.

--1. not null 제약조건
--칼럼에 값이 없으면 insert가 실행되지 않도록 하는 제약조건
Alter table tbl_test_std modify(st_name nVARCHAR2(50) not null);
--값이 없는 레코드에 일단 값들을 채워 넣고(update을 실행한 후 명령을 수행해야 한다.

--2. unique 제약조건:= 중복값이 추가되지 않도록.
alter table tbl_test_std add unique(st_num);

--3. primary key 제약조건
--pk로 설정된 칼럼은 내부적으로 index라는 object가 생성됨.
--alter table을 사용해서 pk를 추가할때는 가급적 이름을 지정해 주는 것이 좋다.
--dbms에 따라 이름을 지정하지 않으면 실행이 안되는 경우도 있다.
--tbl_test_std 테이블에 key_st_num라는 이름으로 st_num 칼럼을 pk로 설정하라.
alter table tbl_test_std add constraint key_st_num primary key(st_num);

--pk를 다중칼럼으로 설정.
--alter table tbl_test_std add constraint key_st_num primary key(st_name,st_tel);

--4. check제약조건
--데이터를 추가할때 어떤 칼럼에 저장되는 데이터를 제한하고자 할때
--1~4까지 숫자만 저장하라. 그리고 제약조건 이름으로 st_grade_check라고 등록하라.
alter table tbl_test_std add constraint st_grade_check check (st_grade between 1 and 4);
--alter table tbl_test_std add constraint st_gender_check check (st_gender in ('남','여');

--contraint 이름을 지정하는 이유:= 이름이 지정되지 않으면 나중에 조건을 삭제할때 삭제가 아려워짐.

--5. unique 제약 조건을 삭제
--alter table tbl_test_std drop unique(st_num);

--6. check 제약조건 삭제
--cascade:=연관된 모든 조건을 같이 삭제.
--alter table tbl_test_std drop constraint st_grade_check cascade;

--7. 참조무결성 설정
--tbl_score2에 데이터를 추가하거나 학번을 변경할때
--tbl_test_std 테이블을 참조하여
--학번(s_num,st_num)와의 관계를 명확히 하여 eq join을 실행했을때 결과가 신뢰성을 보장하는 제약조건 설정.
/*
tbl_score           tbl_test_std
snum                st_num
잇다         ->         반드시 있다
있을수도 있다    <-       있다
절대없다        <-      없다.
*/
alter table tbl_score2
add constraint fk_std_score2 foreign key(s_num)
references tbl_test_std(st_num);