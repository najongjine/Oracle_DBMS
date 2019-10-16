--

select '1' as num, '홍길동' as name, '컴공과' as dept from dual;

--간단한 연산을 table을 대상으로 하면 저장된 데이터 개수만큼 반복되어 싱핼이된다.
--1개의 레코드만 가진 dummy table을 준비해두고 이 테이블을활용하여 코드를 실행.
select '1' as num, '홍길동' as name, '컴공과' as dept from tbl_student;


--uion:= 여러 테이블을 select해서 생성된 view 결과를 묶어서 마치 하나의 결과처럼 보고자 할때 사용.
--테이블의 결과를 결합하여 하나의 view처럼 보여주ㅠ는 형식
/*
Uion               Union ALL
중복데이터 배제    무조건 결합
내부적으로 sort
slow
*/
select '1' as num, '홍길동' as name, '컴공과' as dept from dual
union all select '2' as num, '이몽룡' as name, '컴공과' as dept from dual
union all select '3' as num, '성춘향' as name, '컴공과' as dept from dual
union all select '4' as num, '임꺽정' as name, '컴공과' as dept from dual
union all select '5' as num, '장보고' as name, '컴공과' as dept from dual;

--실제 사용하는 dbms에 물리적인 테이블을 생성하지 않고 가상의 데이터를 만들어서 사용하고자 할때
--임시로 테이블 구조와 데이터를 생성하여 테스트 용도로 사용하는 명령군.
--이 명령군을 사용할때 union 키워드를 사용함.
select * from tbl_score;
select '===' as 학번,'====' as 국어,'====' as 영어,'====' as 수학 from dual
union all select '학번' as 학번,'국어' as 국어,'영어' as 영어,'수학' as 수학 from dual
union all select '===' as 학번,'====' as 국어,'====' as 영어,'====' as 수학 from dual
union all select s_num as 학번, to_char(s_kor,'999') as 국어, to_char(s_eng ,'999') as 영어, to_char(s_math,'999') as 수학 from tbl_score
union all select '-----' as 학번,'----' as 국어,'----' as 영어,'----' as 수학 from dual
union all select '총점', to_char(sum(s_kor),'99999') as 국어, to_char(sum(s_eng) ,'99999') as 영어, to_char(sum(s_math),'99999') as 수학 from tbl_score;

--to_char(값,형식):= 숫자형 자료를 문자열형 자료로 변환시키는 cascading 함수
--:9: 숫자자릿수를 나타내는 형식, 실제 출력되는 값의 자리수만큼 개수를 지정해야 한다. to_char(123,'99999') -> 123
--0: 숫자자리수를 나타내느 형식, 실제 출력되는 값보다 자릿수가 많으면 나머지는 0으로 채움. to_char(123,'00000') -> 00123
--YYYY:연도
--RRRR:연도
--MM:월형식
--DD:일형식
--MI:분
--SS:초
--to_char(날자값,'YYYY  MM DD HH MI SS')
--sysdate: 오라클에서 현재 컴휴터의 시간과 날짜를 가져오는 시스템 변수
select to_char(sysdate, 'YYYY-MM-DD, HH:MI:SS') from dual;

--임시로 사용할 테이블 생성
--sql 테스트등을 위해 임시로 테이블을 생성하는 오라클 sql
with tbl_temp as
(
select '1' as num, '홍길동' as name from dual
union all select '2' as num, '이몽룡' as name from dual
union all select '3' as num, '성춘향' as name from dual
union all select '4' as num, '임꺽정' as name from dual
union all select '5' as num, '장보고' as name from dual
)
select * from tbl_temp;

--표준 sql에서 사용하는 가장 간단한 subquery
--어떤 table의 결과를 from으로 받아서 다시 select를 수행하는 sql
select * from (
select '1' as num, '홍길동' as name from dual
union all select '2' as num, '이몽룡' as name from dual
union all select '3' as num, '성춘향' as name from dual
union all select '4' as num, '임꺽정' as name from dual
union all select '5' as num, '장보고' as name from dual
);

with tbl_temp as
(
select '1' as num, '홍길동' as name from dual
union all select '2' as num, '이몽룡' as name from dual
union all select '3' as num, '성춘향' as name from dual
union all select '4' as num, '임꺽정' as name from dual
union all select '5' as num, '장보고' as name from dual
)
select * from tbl_temp
where num in('3','1','5')
order by num;

select * from tbl_student
where st_name in('기운성','남동예','내세원','길한수','방채호','배재호');

--1. sub query
--where절에 사용하는 subq
--subq 중에 가장많이 사용하는것
--중첩(서브)쿼리하고도 한다.
with tbl_temp as
(
select '기은성' as name from dual
union all select '남동예' as name from dual
union all select  '내세원' as name from dual
union all select  '방채호' as name from dual
union all select  '배재호' as name from dual
)
select * from tbl_student
where st_name in (select name from tbl_temp);
/*
where 절에 포함된 select를 싱행: select name from tbl_temp
'기운성','남동예','내세원','방채호','배재호' 리스트를ㅇ 생성하고
where in ('기운성','남동예','내세원','방채호','배재호') 코드를 생성한다.

그리고 이 where 절을 사용해서 tbl_studentd의 데이터를 조회한다.
*/

--2. from절에 포함되는 subq
--인라인뷰라고 하며 다른 table 결과를 from 절에서 사용하는 것.
--여러 table을 결합하여 나오는 결과값들을 모아서 하ㅓ나의 쿼리로 연결하여
--view로 보여주기 위한 squery
--EQ join 을 대신해서 사용하기도 함.
select * from
(select * from tbl_student where st_grade=1);

select * from tbl_score2 SC, tbl_student ST
where sc.s_num=st.st_num;

--단순한 join을 이용해서 보여ㅛ주기 오려운 복잡한 통계, 집계들을 사용할때
--먼저 subq 에서 통계,집계등을 계산하고
-- 그 결과와 main table을 join 하고자 할때
select * from tbl_student ST,
(select sc.s_num,sc.s_kor+sc.s_eng,sc.s_math from tbl_score SC) sc_s
where st.st_num=sc_s.s_num;

--3.select sub
--스칼라 서브쿼리
-- 1,2 쿼리와 달리 subq에서는 절대 list를 출력하면 안된다.
--subq에서는 단 1줄의 record만 결과로 나와야 한다.
--가. tbl_student 테이블을 for()반복문으로 반복하기
--나. tbl_student의 st_num 컬럼값을 sub쿼리에 전달
--  subq는 마치 method처럼 작동
--다. subq에서 where 절을 실행하여 데이터를 추출
--라. sum(s_kor+s_eng+s_math)를 실행하여
--마.결과를 return
--바. main에서 st_num, 리턴받은 결과 형식으로 표시
select st_num,
(select sum(s_kor+s_eng+s_math) from tbl_score SC
where st.st_num=sc.s_num
) from tbl_student ST;

select sc_num,
(select sum(s_kor+s_eng+s_math) from tbl_score SC
where sc_main.s_num=sc.s_num
) as 총점 from tbl_score sc_main;