-- bbsfinal

/*
오라클의 계층 쿼리
start with : 부모 결과값을 불러올 조건

connect by prior 조건
하위의 레코드를 모두 검색하면서 조건에 맞는 사항이 있으면
해당하는 레코드를 나열하라

order siblings by : connent by 로 나열된 레코드들을 그룹별로 묶어서 정렬하여 보여달라.
*/
select * from tbl_bbs
start with b_p_id=0
CONNECT by PRIOR b_id=b_p_id
order SIBLINGS by b_p_id;

select b_id,b_p_id,b_subject from tbl_bbs
start with b_p_id=0
CONNECT by PRIOR b_id=b_p_id
order SIBLINGS by b_p_id;

/*
sys_connect_by_path()
 start with, connect by 와 함께 사용되는 오라클 시스템 함수
 connect by에 의해 나열된 레코드의 각 라인마다
 현재 path상태가 어떻게 되는지를 연산하는 함수
 
 부모레코드 부터 child 레코드 순으로 연산을 수행하면서 
 부모제목>child 제목>...으로 연결하여 문자열을 생성하여
 보여달라
*/
select b_id,b_p_id,b_subject,
sys_connect_by_path(b_subject,'>') as depth_path
from tbl_bbs
start with b_p_id=0
CONNECT by PRIOR b_id=b_p_id
order SIBLINGS by b_p_id;


/*
level : 오라클의 시스템 변수(칼럼) connect by에 의해 나열된 각 레코드를 분석하여
 현재 계층이 몇단계 레벨인지를 알려주는 변수값.
*/
select b_id,b_p_id,b_subject,
level as 레벨
from tbl_bbs
start with b_p_id=0
CONNECT by PRIOR b_id=b_p_id
order SIBLINGS by b_p_id;


/*
connect by prior 의 조건식은 순서가 매우 중요하다
root.col = child.col
이론상으로 순서가 바뀌면(child.col = root.col) 역순으로 나타나야 하는게
그 결과가 상당히 예측이 어려운 경우가 많다.
start with 설정된 칼럼=root.col 으로 삼고
그 칼럼과 조건을 맺어 리스트를 조회할 칼럼을 child.col 으로 설정하면 
큰 어려움 없ㅎ이 결과를 도출할수 있다.
*/
select b_id,b_p_id,b_subject,
level as 레벨
from tbl_bbs
start with b_p_id=0
CONNECT by PRIOR b_p_id=b_id
order SIBLINGS by b_p_id;

/*
lpad(문자열,개수) '문자열'을 포함하여 개수만큼 길이의 문자열을 만들고
문자열의 개수가 부족하면 왼쪽에 빈칸을 채워넣어서
오른쪽으로 다시 정렬하라.

만약 level 값이 5이면
lpad('re:',5)
re:를 포함한 문자열을 생성하고 생성한 문자열 개수가 3개(re:)이므로
왼쪽에 빈칸 2칸을 포함하여 총 5개의 문자열로 생성해 준다.
*/
select b_id,b_p_id,b_subject,
lpad('re:', (level-1)*5) || b_subject as 제목
from tbl_bbs
start with b_p_id=0
CONNECT by PRIOR b_id=b_p_id
order SIBLINGS by b_p_id;

select c_id,c_p_id,c_b_id,c_writer,
lpad('re:', (level-1)*5) || c_subject as c_subject
from tbl_comment
where c_b_id=#{c_b_id}
start with c_p_id=0
CONNECT by PRIOR c_id=c_p_id
order SIBLINGS by c_p_id;

/*
connect by level < 값
1~값 -1 까지 리스트를 만들어라
*/

-- 9가 포함된 3자리수의 문자열을 만들고
-- 왼쪽에 빈칸이 있으면 A 문자열로 채워라
select lpad(9,3,'A') from dual;
select lpad('re:',0) from dual;
select lpad('re:',3)from dual;
select lpad('re:',5)from dual;

-- 전체 자리수를 9개로 만들고 이미 주어진 앞쪽의 re: 문자열을 반복적으로 표시하라.
select lpad('re:',3*3,'re:')from dual;

-- 1~10까지 10개의 리스트를 만들고
-- level 값에 3을 곱한 문자열을 생성한 후
-- re: 문자가 포함된 리스트를 만들어라
select lpad('re:',(level)*3,'re:') || '제목'
from dual connect by level <= 10;

select lpad('re:',(level-1)*3,'re:') || '제목'
from dual connect by level <= 10;