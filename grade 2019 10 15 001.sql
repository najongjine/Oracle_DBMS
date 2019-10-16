--별도로 constraint 추가방식
--간혹 표준 sql pk 지정방식이 안되는 DBMS가 있다.
--이 방식은 다수의 칼럼으로 pk를 지정할때도 사용함.
create table tbl_score(
s_id	NUMBER		,
s_std	nVARCHAR2(50)	NOT NULL,	
s_subject	nVARCHAR2(50)	NOT NULL	,
s_score	NUMBER(3)	NOT NULL	,
s_rem	nVARCHAR2(50),		
constraint pk_score primary key(s_id)
);
commit;
select * from tbl_score;

--학생별로 총점, 평균
--1. 학생(s_std)데이터가 같은 레코드를 묶기
--2. 묶여진 그룹내에서 총점과 평균 계산.
select s_std,sum(s_score) as 총점,round(avg(s_score)) as 평균
from tbl_score
group by s_std;

select s_subject from tbl_score group by s_subject;

/*
과학
수학
국어
국사
미술
영어
*/
/*
성적 테이블을
각 과목 이름으로 칼럼을 만들어서 생성을 하면
데이터를 추가하거나, 단순 조회를 할때는 상당히 편리하게 사용할수 있다.
하지만, 사용중에 과목이 추가되거나 과목명이 변경되는 경우
테이블의 칼럼을 변경해야 하는 상황이 발생한다.
테이블의 칼럼을 변경하는 것은 dbms입장에서나 사용자 입장에서
많은 비용을 지불해야 한다.
테이블의 칼럼을 변경하는 일은 매우 신중해야 한다.

그래서 실제 데이터는 고정된 칼럼으로 생성된 테이블에 저장을 하고
view로 확인을할때 pivot 방식으로 펼쳐보면
마치 실제 테이블에 칼럼이 존재하는 것처럼 사용을 할수있는 장점이 있다.
*/
select s_std as 학생,
sum(decode(s_subject,'과학',s_score)) as 과학,
sum(decode(s_subject,'국사',s_score)) as 국사,
sum(decode(s_subject,'국어',s_score)) as 국어,
sum(decode(s_subject,'수학',s_score)) as 수학,
sum(decode(s_subject,'미술',s_score)) as 미술,
sum(decode(s_subject,'영어',s_score)) as 영어
from tbl_score
--where s_std='갈한수'
group by s_std
order by s_std;

--오라클 11g 이후에 사용하는 pivot 전용 문법
--main from 절에 subq를 사용해서 테이블을 지정해야 한다.
select * 
from
(select s_std,s_subject,s_score from tbl_score)
pivot(
sum(s_score) -- 칼럼 이름별로 분리하여 표시할 데이터
for s_subject in( --묶어서 펼칠 칼럼 이름
'과학' as 과학, --펼쳤을때 보여질 칼럼 이름 목록
'수학' as 수학,
'국어' as 국어,
'국사' as 국사,
'미술' as 미술,
'영어' as 영어
)
);
create view view_score as(
select s_std as 학생,
sum(decode(s_subject,'과학',s_score)) as 과학,
sum(decode(s_subject,'국사',s_score)) as 국사,
sum(decode(s_subject,'국어',s_score)) as 국어,
sum(decode(s_subject,'수학',s_score)) as 수학,
sum(decode(s_subject,'미술',s_score)) as 미술,
sum(decode(s_subject,'영어',s_score)) as 영어,
sum(s_score) as 총점,
round(avg(s_score)) as 평균,
rank() over (order by sum(s_score) desc) as 석차
from tbl_score
group by s_std
);