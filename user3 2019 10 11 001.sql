--
select * from tbl_student;
commit;
--table과 view의 차이
/*
table                   View
실제 저장된 데이터      가상의 데이터
CRUD 모두 가능          테이블로부터 select 실행한후 보여주는 형태
                        Read(select)만 가능. 보기전용
*/

select * 
FROM tbl_score SC
left join tbl_student ST
on sc.s_num=ST.st_num;

select st.st_num,st.st_name,st.st_dept,
dp.d_name,dp.d_pro
from tbl_student ST
left join tbl_dept DP
on st.st_dept=dp.d_num;

--뷰로 생성할때는 order by 절을 삭제.
--create view [name] as 키워드 추가
create view view_st_dept as(
select st.st_num 학번,st.st_name 이름,st.st_dept 학과코드,
dp.d_name 학과이름,dp.d_pro 담임교수
from tbl_student ST
left join tbl_dept DP
on st.st_dept=dp.d_num
);

select 학과코드,학과이름,count(학과코드)
from view_st_dept group by 학과코드,학과이름;
order by 학과이름;

--1. 전체 데이터에서 학과코드별로 묶어서, 학과 코드가 무엇인지 list
--2. list 내에서 포함된 학생수를 계산하여 보기.
-->>학과 코드별 부분 합(개수) 계산하기.
select 학과코드, 학과이름, count(학과코드)
from view_st_dept
group by 학과코드, 학과이름
order by count(학과코드);

select 학번, 이름, count(*)
from view_st_dept
group by 학번,이름;

--학과별로 학생수를 계산을 하고
--학생수가 20명 이상인 과만 보고싶다.
--집계를 계산후 결과에 대한 조건 설정
select 학과코드,학과이름,count(*)
from view_st_dept
group by 학과코드,학과이름
having count(*) >=20;


select 학과코드,학과이름,count(8)
from view_st_dept
group by 학과코드,학과이름
having 학과이름='컴퓨터공학';
--having 절은 gorup by가 이루어지고, 집계함수가 계산된 후
--조건을 설정하여 리스트를 추출하는 부분이다.
--이 경우 원본 데이터를 먼저 group하는 연산이 수행되고
--그 결과에 대하여 조건을 설정한다.
--만약 어떤 기존의 칼럼을 기준으로 조건을 설정 하려면
--having이 아닌 where 에서 조건을 설정하여
--추출되는 list 개수를 줄이고
--추출된 list만 가지고 gorup,집계 함수 연산을 수행하는것이
--sql 수행효율 면에서 매우 유리하다.
select 학과코드,학과이름,count(*)
from view_st_dept --1
where 학과이름='컴퓨터공학' --2
group by 학과코드,학과이름; --3

create view view_sc_st as(
select sc.s_num 학번,st.st_name 이름,st.st_dept 학과코드,sc.s_kor 국어,sc.s_eng 영어,sc.s_math 수학
from tbl_score SC
left join tbl_student ST
on sc.s_num=st.st_num
);
select * from view_sc_st;

select sc.학번,sc."이름",sc.학과코드,dp.학과이름,
sc."국어",sc."영어",sc."수학"
from view_sc_st SC
left join view_st_dept DP
on sc.학과코드=dp.학과코드;
--2개의 view를 join 했더니 결과가 이상하게 되었다.

create view view_성적일람표 as(
select sc.s_num as 학번,st.st_name as 학생이름,dp.d_num as 학과코드, dp.d_name as 학과이름,dp.d_pro as 담임교수,
sc.s_kor as 국어,sc.s_eng as 영어,sc.s_math as 수학,
sc.s_kor+sc.s_eng+sc.s_math as 총점,
round((sc.s_kor+sc.s_eng+sc.s_math)/3) as 평균,
rank() over(order by(sc.s_kor+sc.s_eng+sc.s_math) desc) as 석차
from tbl_score SC
left join tbl_student ST
on sc.s_num=st.st_num
left join tbl_dept DP
on st.st_dept=dp.d_num
);
select * from view_성적일람표 order by 학과이름;

select sum(국어),sum(영어),sum(수학) from view_성적일람표;

select 학과이름,sum(국어),sum(영어),sum(수학) 
from view_성적일람표
group by 학과이름;

select 학과이름,sum(국어),sum(영어),sum(수학),sum(총점) as 전체총점, round(avg(평균),1) as 전체평균
from view_성적일람표
where 학과이름 in('영어영문','군사학')
group by 학과이름;

select 학과이름,sum(국어),sum(영어),sum(수학),sum(총점) as 전체총점, round(avg(평균),1) as 전체평균
from view_성적일람표
group by 학과이름
having round(avg(평균),1)>=75;

select 학과코드,학과이름,sum(국어),sum(영어),sum(수학),sum(총점) as 전체총점, round(avg(평균),1) as 전체평균
from view_성적일람표
where 학과코드 between '002' and '005'
group by 학과코드,학과이름;

select 학과코드,학과이름,
count(*) 학생수, max(총점) as 최고점, min(총점) as 최저점, sum(총점), round(avg(평균),1)
from view_성적일람표
group by 학과코드,학과이름;