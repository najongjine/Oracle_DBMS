--
desc tbl_score;
/*
S_ID      NOT NULL NUMBER        
S_STD     NOT NULL NVARCHAR2(50) 
S_SCORE   NOT NULL NUMBER(3)     
S_REM              NVARCHAR2(50) 
S_SUBJECT          VARCHAR2(4)   

학생정보 칼럼을 제2 정규화
score 테이블에는 학생이름이 일반적인 문자열로 저장이 되었다.
일반적인 문자열로 저장된 경우 학생이름을 변경해야할 경우가 발생하면
update tbl_score set s_std='이몽룡'
where s_std='이멍룡' 과 같은 방식으로 칼럼 update 명령을 수행할 것이다.
하지만 dbms의 update 권장 패턴에서는 여러개의 레코드를 수정하는것을 지양하도록 한다.
또한 만약 학생정보에 다른 정보를 포함하고 싶을때는
tbl_score 테이블에 칼럼을 추가하는 등의 방식으로 처리해야 하는데
이 방식또한 좋은 방식이 아니다.
그래서 학생정보 테이블을 생성하고 학생코드를 만들어준 다음
score table의 s_std칼럼의 값을 학생코드로 변경하여
제2 정규화를 수행하고자 한다.

단! tbl_score에 저장된 학생이름이 동명이인이 없다라고 가정한다.

*/
--1.tbl_score 테이블로부터 학생 이름을 추출하여 table로 생성
select s_std from tbl_score group by s_std;
--2질의 결과를 모두 선택하여 엑셀 파일로 복사
--학생정보 입력
--4. 학생정보 table 생성
create table tbl_student(
st_num	VARCHAR2(5)		Primary Key,
st_name	nVARCHAR2(50)	not null	,
st_tel	VARCHAR2(20)		,
st_addr	nVARCHAR2(125)		,
st_grade	NUMBER(1)	not null	,
st_dept	VARCHAR2(5)	not null	

);
drop table tbl_student;
--6.tbl_score 테이블의 s_std칼럼의 값을 학생이름-> 학번으로 변경.
--가. 임시 칼럼을 생성.
alter table tbl_score
add s_stcode varchar2(5);

--나. tbl_student와 tbl_score를 연결해서
-- tbl_student의 학번정보를 tbl_score에 등록
select count(*) from tbl_score SC, tbl_student ST
where sc.s_std=st.st_name;

update tbl_score sc
set sc.s_stcode=(select st.st_num from tbl_student ST where st.st_name=sc.s_std);

select sc.s_stcode,st.st_num,sc.s_std,st.st_name
from tbl_score sc, tbl_student ST
where sc.s_stcode=st.st_num;

--7. tbl_score의 s_std 칼럼을 삭제하고,
-- s_stcode 칼럼을 s_std칼럼으로 이름 변경
alter table tbl_score drop column s_std;
alter table tbl_score rename column s_stcode to s_std;

select * from tbl_score SC
left join tbl_student ST
on sc.s_std=st.st_num
left join tbl_subject SB
on sc.s_subject=sb.sb_code
order by st.st_name, sb.sb_name;

create table tbl_dept(
d_num	VARCHAR2(5)		Primary Key,
d_name	VARCHAR2(30)	not null	,
d_pro	VARCHAR2(20)		,
d_tel	VARCHAR2(20)		

);

commit;
select count(*) from tbl_dept;

drop view view_score;
create view view_score as
(
select sc.s_id,
sc.s_std,st.st_name,st.st_grade,
st.st_dept,dp.d_name,dp.d_tel,
sc.s_subject,sb.sb_name,
sc.s_score
from tbl_score SC
left join tbl_student ST
on sc.s_std=st.st_num
left join tbl_subject SB
on sc.s_subject=sb.sb_code
left join tbl_dept DP
on st.st_dept=dp.d_num
);

select * from tbl_subject;

/*
decode==if
decode(column,value,T_result)
if(column==value) T_result
else null
*/

create view view_score_pv as
(
select s_std,st_name,d_name,st_grade,
sum(decode(s_subject,'S001',s_score)) as	과학,
sum(decode(s_subject,'S002',s_score)) as	수학,
sum(decode(s_subject,'S003',s_score)) as	국어,
sum(decode(s_subject,'S004',s_score)) as	국사,
sum(decode(s_subject,'S005',s_score)) as	미술,
sum(decode(s_subject,'S006',s_score)) as	영어,
sum(s_score) as 총점,
round(avg(s_score),1) as 평균,
rank() over(order by sum(s_score) desc) as 석차
from view_score
group by s_std, st_name,d_name,st_grade
);

select * from tbl_subject;
select *
from
(
select s_std,st_name,d_name,st_grade,s_subject,s_score from view_score
)
pivot(
sum(s_score)
for s_subject
in(
'S001' as	과학,
'S002' as	수학,
'S003' as	국어,
'S004' as	국사,
'S005' as	미술,
'S006' as	영어
)
);

--제2 정규화가 완료ㅕ된 4개의 table을 서로 relation 설정
--(참조무결성 제약조건 설정)
alter table tbl_score
add constraint fk_score_subject
foreign key(s_subject)
references tbl_subject(sb_code);

alter table tbl_score
add constraint fk_score_student
foreign key(s_std)
references tbl_student(st_num);

alter table tbl_student
add constraint fk_student_dept
foreign key(st_dept)
references tbl_dept(d_num);