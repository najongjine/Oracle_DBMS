--
/*
1. 실무에서 사용하던 엑셀 데이터
학생이름    학년  학과  취미
----------------------------------
홍길동     3     컹곰  낚시,등산,독서

2. 엑셀 데이터를 단순히 dbms 테이블로 구현
학생이름    학년  학과  취미1 2   3
----------------------------------
홍길동     3     컹곰  낚시,등산,독서

3. 제1 정규화가 수행된 table 스키마
학생이름    학년  학과  취미 
----------------------------------
홍길동     3     컹곰  낚시
홍길동     3     컹곰  등산
홍길동     3     컹곰  독서

제2 정규화:=
테이블의 고정값을 다른 테이블로 분리하고
테이블간의 join을 통해서 view 생성하도록
구조적 변경을 하는 작업
tbl_student
학생이름    학년  학과  취미 
----------------------------------
홍길동     3     컹곰  001
홍길동     3     컹곰  002
홍길동     3     컹곰  003

tbl_hobby
code        취미
-----------------------------------
001         낚시
002         등산
003         독서

tbl_dept
code    학과명     담임교수
001     컴공과 
002     정보통신과   
*/
/*
S_ID      NOT NULL NUMBER        
S_STD     NOT NULL NVARCHAR2(50) 
S_SUBJECT NOT NULL NVARCHAR2(50) 
S_SCORE   NOT NULL NUMBER(3)     
S_REM              NVARCHAR2(50) 

성적 일람표 table의 데이터중에서 과목항목을 제2정규화 작업 수행.

*/
--tbl_score에서 과목명만 추출하기
select s_subject from tbl_score
group by s_subject;
--추출된 과목명 데이터로 엑셀 파일 작업

create table tbl_subject (
sb_code	VARCHAR2(4)		PRIMARY KEY,
sb_name	nVARCHAR2(20)	NOT NULL	,
sb_pro	nVARCHAR2(20)		

);

--엑셀 데이터 임포트

--생성된
select * from tbl_score SC, tbl_subject SB
where sc.s_subject=sb.sb_name;

--tbl_score의 s_subject 칼럼에 있는 과목명을 코드로 변경.
--1. 임시로 칼럼을 하나 tbl_score 추가
--tbl_subject의 sb_code 칼럼과 구조형식이 같은 칼럼을 추가
alter table tbl_score add s_sbcode VARCHAR2(4);

--tbl_subject 테이블에서 과목명을 조회하여 해당하는
--과목코드를 tbl_score 테이블의 s_sbcode 칼럼에 update 수행하라.
update tbl_score SC
set s_sbcode=
(select sb_code from tbl_subject SB where sc.s_subject=sb.sb_name);
/*
for(sb:tbl_score){
    where(sb.s_subject==tbl_subject.sb_name){
        sb.s_sbcode=tbl_subject.s_code;
    }
}
*/
select sc.s_sbcode, sb.sb_code, sc.s_subject,  sb.sb_name
from tbl_score SC, tbl_subject SB
where sc.s_sbcode=sb.sb_code;
--table을 join할때 table들에 칼럼 이름이 같은 이름이 존재하면 반드시
--칼럼이 어떤 table에 있는 칼럼인지 명시를 해 주어야 오류가 발생하지 않음.
--그래서 table을 설계할때 가급적 접두사를 붙여서 만드는것이 좋고,
--그렇더라도 join을 할때 table alias를 설정하여 alias.column
--형식으로 작성하는것이 좋다.

--tbl_score의 s_subject 칼럼을 삭제
alter table tbl_score drop column s_subject;

--s_sbcode 칼럼 이름을 s_subject로 다시 변경
alter table tbl_score rename column s_sbcode to s_subject;