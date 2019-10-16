--
select * from v$database;

--현재 상요자가 접근(CRUD) 할수있는 table 목록
select * from tab;
select * from user_tables; --(사용자 권한에 따라 tab과 다른 리스트가 출력되기도 함)

--DBA급 이상의 사용자가 전체 table리스트를 확인할수 있는 명령
select * from all_tables;

-- 테이블 구조(create table을 생성했을때의 모양)
describe tbl_books;

