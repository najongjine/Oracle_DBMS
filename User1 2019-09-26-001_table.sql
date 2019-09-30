--table 명명 패턴 tbl_
--(x) byte 단위임
--char칼럼에 순수 숫자로만 되어있는 데이터를 저장할 경우 약간의 문제를 일으킴.
-- 오라클DB에는 문자열로 저장이 되는데, 프로그래밍 언어에서는 숫자로 인식해버림.
--요즘엔 걍 nVARCHAR2로 통일됨. 한글의 문자열길이를 뽑아내면 논리적 오류가 일어남.
--숫자는 NUMBER로 통일
create table tbl_student(
    st_num CHAR(5),
    st_name nVARCHAR2(20), --최대 4000클가까지 가능
    st_addr nVARCHAR2(125),
    st_tel VARCHAR2(20),
    st_grade NUMBER(1), --int는 NUMBER(38) 으로 변환되어 생성된다.
    st_dept VARCHAR2(10),
    st_age NUMBER(3)
);
insert into tbl_student(st_num,st_name,st_addr)
values('00001','성춘향','익산시');
insert into tbl_student(st_num,st_name,st_addr)
values('00001','성춘향','남원시');
select * from tbl_student;

drop table tbl_student;


--scenario~
--tbl_student에 많은 학생의 데이터를 추가하다 보니 학번이 0100인 학생의 데이터가 2번 추가가 되었다.
--이후에 tbl_student테이블에서 0100의 학생 데이터를 조회 했더니
--데이터가 2개가 조회 되었다.
--이 학생의 데이터인지 알수인지 알기가 매우 어려워 진다.
--여러가지 데이터를 다시 검증 해야만 어떤 데이터가 정상적 데이터인지 확인할수 있다.
--이러한 문제가 발생하지 않도록 미리 무언가 조치를 취해줘야 하는데
--DB에서는 이런 문제가 발생하지 않도록 설정을 할수 있다.
--이런 설정을 "제약조건" 설정 이라고 한다.

--tbl_student table에는 "절대 학번이 동일한 데이터가 2개이상 없어야 한다."
--라는 제약조건을 설정해 두어야 한다 == UNIQUE
create table tbl_student(
--PRIMARY KEY는 key가 됨과 동시에, uniq + not null 조건을 동시에 가지게 된다.
    st_num char(5) primary key, --중복배재,중복금지 + null 금지(pk 있으면 생략해도 됨)
    st_name nvarchar2(20) not null,
    st_addr nvarchar2(125),
    st_tel nvarchar2(20) not null,
    st_grade NUMBER(1), 
    st_dept nvarchar2(10),
    st_age NUMBER(3)
);
insert into tbl_student(st_num,st_name,st_tel,st_addr,st_age,st_dept)
values('00001','성춘향','010-111','강원도',22,'문과');
insert into tbl_student(st_num,st_name,st_tel,st_addr,st_age,st_dept)
values('00002','홍길동','010-211','남원시',22,'컴과');
insert into tbl_student(st_num,st_name,st_tel,st_addr,st_age,st_dept)
values('00003','이몽룡','010-311','익산시',22,'이과');
insert into tbl_student(st_num,st_name,st_tel,st_addr,st_age,st_dept)
values('00004','장보고','010-411','해남군',22,'문과');
insert into tbl_student(st_num,st_name,st_tel,st_addr,st_age,st_dept)
values('00005','임꺽정','010-511','함경도',22,'체과');

insert into tbl_student(st_num,st_name,st_tel) --unique constraint is violated
values('00001','이몽룡','010-112');
insert into tbl_student(st_num,st_tel)
values('20001','010-111');
insert into tbl_student(st_num,st_name,st_tel)
values('20011','이몽룡','23442');
select * from tbl_student;
describe tbl_student;
select * from dba_tables
where owner='user1';

drop table tbl_student;