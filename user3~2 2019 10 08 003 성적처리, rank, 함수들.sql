--
create table tbl_score(
    s_num	VARCHAR2(3)		Primary Key,
    s_kor	NUMBER(3)		,
    s_eng	NUMBER(3)		,
    s_math	NUMBER(3)		

);
create table tbl_score2(
s_num	VARCHAR2(3)		Primary Key,
s_dept	VARCHAR2(3)		,
s_kor	NUMBER(3)		,
s_eng	NUMBER(3)		,
s_math	NUMBER(3)		

);
create table tbl_dept(
d_num	VARCHAR2(3)		Primary Key,
d_name	VARCHAR2(20)		,
d_pro	VARCHAR2(3)		

);

describe tbl_score;

insert into tbl_score(s_num,s_kor,s_eng,s_math)
values('001',90,90,70);
insert into tbl_score(s_num,s_kor,s_eng,s_math)
values('002',90,90,70);
insert into tbl_score(s_num,s_kor,s_eng,s_math)
values('003',90,90,70);
insert into tbl_score(s_num,s_kor,s_eng,s_math)
values('004',90,90,70);
insert into tbl_score(s_num,s_kor,s_eng,s_math)
values('005',90,90,70);
insert into tbl_score(s_num,s_kor,s_eng,s_math)
values('006',90,90,70);
insert into tbl_score(s_num,s_kor,s_eng,s_math)
values('007',90,90,70);

select * from tbl_score;

select s_kor,s_eng,s_math,
s_kor+s_eng,s_math as 총점,
(s_kor+s_eng+s_math)/3 as 평균 from tbl_score;

update tbl_score 
set s_kor=round(DBMS_Random.value(50,100),0),
s_eng=round(DBMS_Random.value(50,100),0),
s_math=round(DBMS_Random.value(50,100),0);

update tbl_score
set s_math=100
where s_num='003';

select s_num,s_kor,s_eng,s_math,
s_kor+s_eng+s_math as 총점,
round((s_kor+s_eng+s_math)/3,1) as 평균
from tbl_score
where (s_kor+s_eng+s_math)/3 >=80;

select s_num,s_kor,s_eng,s_math,
s_kor+s_eng+s_math as 총점,
round((s_kor+s_eng+s_math)/3,1) as 평균
from tbl_score
where (s_kor+s_eng+s_math)/3 between 70 and 80;

--통계,집계 함수
--SUM(),AVG(),MAX(),MIN(),COUNT()
select sum(s_kor) as 국어총점 from tbl_score;

select count(*) from tbl_score;

select max(s_kor+s_eng+s_math) as 최고점 from tbl_score;

select s_num,s_kor,s_eng,s_math,
s_kor+s_eng+s_math as 총점,
rank(s_kor+s_eng+s_math) as 석차
from tbl_score;

--(s_kor+s_eng+s_math)를 계산하고
--계산 결과를 내림차순으로 정렬하고
--순서대로 값을 매겨라.
select s_num, s_kor+s_eng+s_math as 총점,
rank() over(order by (s_kor+s_eng+s_math) desc) as 석차
from tbl_score order by s_num;

--중복값 석차 처리도 하라.
select s_num, s_kor+s_eng+s_math as 총점,
dense_rank() over(order by (s_kor+s_eng+s_math) desc) as 석차
from tbl_score;