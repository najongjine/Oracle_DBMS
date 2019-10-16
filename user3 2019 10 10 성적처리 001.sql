--
create table tbl_student(
st_num	VARCHAR2(3)		Primary Key,
st_name	nVARCHAR2(50)	not null	,
st_tel	VARCHAR2(20)		,
st_addr	nVARCHAR2(125)		,
st_grade	NUMBER(1)		,
st_dept	VARCHAR2(3)		
);
select * from tbl_student;
select * from tbl_score;

insert into tbl_score(s_num,s_kor,s_eng,s_math)
values('008',78,99,99);

select sc.s_num,st.st_name,sc.s_eng,sc.s_kor,sc.s_math from tbl_score SC, tbl_student ST
where sc.s_num=st.st_num;

select sc.s_num,st.st_name,sc.s_eng,sc.s_kor,sc.s_math from tbl_score SC
left join tbl_student ST
on sc.s_num=st.st_num;

select sc.s_num,st.st_name,sc.s_eng,sc.s_kor,sc.s_math,
sc.s_eng+sc.s_kor+sc.s_math as 총점,
round((sc.s_eng+sc.s_kor+sc.s_math)/3) as 평균
from tbl_score SC
left join tbl_student ST
on sc.s_num=st.st_num;

select * from tbl_score2;

select sc.s_num,st.st_name,sc.s_dept,sc.s_eng,sc.s_kor,sc.s_math,
sc.s_eng+sc.s_kor+sc.s_math as 총점,
round((sc.s_eng+sc.s_kor+sc.s_math)/3) as 평균
from tbl_score2 SC
left join tbl_student ST
on sc.s_num=st.st_num;

insert into tbl_dept(d_num,d_name,d_pro)
values('001','컴퓨터공학','홍길동');
insert into tbl_dept(d_num,d_name,d_pro)
values('002','영문학과','성춘향');
insert into tbl_dept(d_num,d_name,d_pro)
values('003','경영학','임꺽정');
insert into tbl_dept(d_num,d_name,d_pro)
values('004','정치경제','장보고');
insert into tbl_dept(d_num,d_name,d_pro)
values('005','군사학','이순신');

alter table tbl_dept modify (d_pro nVARCHAR2(3));
SELECT sc.s_num,dp.d_name,dp.d_pro from tbl_score2 SC
left join tbl_dept DP
on sc.s_dept=dp.d_num;

--성적 테이블과 학생 테이블과 학과 테이블을 연계하여
-- 학생, 학과 이름을 같이 조회하고 싶다.
select sc.s_num,st.st_name,sc.s_dept,dp.d_name,dp.d_pro,sc.s_eng,sc.s_kor,sc.s_math,
sc.s_eng+sc.s_kor+sc.s_math as 총점,
round((sc.s_eng+sc.s_kor+sc.s_math)/3) as 평균
from tbl_score2 SC
left join tbl_student ST
on sc.s_num=st.st_num
left join tbl_dept DP
on sc.s_dept=dp.d_num;
--하지만 이런 긴 쿼리문은 코딩할때 개 힘들다.
select sc.s_num,st.st_name,sc.s_dept,dp.d_name,dp.d_pro,sc.s_eng,sc.s_kor,sc.s_math,
sc.s_eng+sc.s_kor+sc.s_math as 총점,
round((sc.s_eng+sc.s_kor+sc.s_math)/3) as 평균
from tbl_score2 SC
left join tbl_student ST
on sc.s_num=st.st_num
left join tbl_dept DP
on sc.s_dept=dp.d_num
where dp.d_name='컴퓨터공학';

--view object.
create view view_score as (
select sc.s_num,st.st_name,sc.s_dept,dp.d_name,dp.d_pro,sc.s_eng,sc.s_kor,sc.s_math,
sc.s_eng+sc.s_kor+sc.s_math as 총점,
round((sc.s_eng+sc.s_kor+sc.s_math)/3) as 평균
from tbl_score2 SC
left join tbl_student ST
on sc.s_num=st.st_num
left join tbl_dept DP
on sc.s_dept=dp.d_num
);
--dbms는 실제 table에서 view object에 설정된 sql문을실행하여 겨ㅑㄹ과를 보여준다.
--실제 데이터는 가지고 있지 않고, 물리적 table로부터 데이터를 가져와서
--보여주는 가상의 table.
--단, ivew 만들기 위한 sql문에는 order by를 수행할수 없다.
select * from view_score order by s_num;
--한번 view로 생성을 해 두면 마치 물리적 table이 있는것과 같이 작동을 하며
--slect문의 다양한 옵션들을 사용하여 데이터를 조회할수 있다.

select * from view_score where 평균 between 70 and 90;
select * from view_score where s_dept in('001','003')
order by d_name;
select * from view_score
where d_name like '컴퓨터%';
select * from view_score where d_name like '%공학';

--값과 값을 견결하여 하나의 문자열처럼 출력하기
select s_num || ':' || st_name from view_score;

select * from view_score
where d_name like '컴퓨터' || '%';

select DISTINCT s_dept,d_name from view_score order by s_dept;

--group by 특정 칼럼을 기준으로 하여 집계를 할때 사용하는 명령 절.
--1.학과별로 국어 점수의 총점을 계산하고싶다.
--각 학과별로 그룹으로 묶고 국어점수의 총점을 계산한후
-- 학과 번호 순으로 보여달라. 부분합 집계.
select s_dept, d_name,d_pro, sum(s_kor) from view_score group by s_dept,d_name,d_pro order by s_dept;
--group by로 묶어서 부분합을 보고자 할때
--기준으로 하는 칼럼 외에 select문에 나열된 칼러들 중
--집계함수로 감싸지 않은 칼럼들은 group by 절 다음에 나열을 해 주어야 한ㅁ다.

--학번,학과코드로 묶어서 보여주는 데이터는 의미없는 명령문이다.
--gorup by로 묶어서 집계를 낼때는 어떤 칼럼들을 묶을것인지에 대한
--많은 고민을 해야한다.
select s_num,s_dept, d_name,d_pro, sum(s_kor) from view_score group by s_num,s_dept,d_name,d_pro order by s_dept;

select s_dept, d_name,d_pro, sum(s_kor)as국어총점, sum(s_eng) as 영어총점, sum(s_math) as 수학총점 
from view_score where d_name in('컴퓨터공학','영어영문')
group by s_dept,d_name,d_pro order by s_dept;
--gorup by를 실행할때 조건을 부여하는 방법
--where 조건을 부여하는 방법 having 조건을 부여하는 방법.
