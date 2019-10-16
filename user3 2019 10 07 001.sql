--
commit;
create table tbl_books(
    b_isbn	VARCHAR2(13)		PRIMARY KEY,
    b_title	nVARCHAR2(50)	NOT NULL	,
    b_comp	nVARCHAR2(50)	NOT NULL	,
    b_writer	nVARCHAR2(50)	NOT NULL	,
    b_price	NUMBER(5)		,
    b_year	VARCHAR2(10)		,
    b_genre	VARCHAR2(3)		

);

insert into tbl_books(b_isbn, b_title, b_comp,b_writer,b_price)
values('979-001','오라클 프로그래밍','생능출판사','서진수',30000);
insert into tbl_books(b_isbn, b_title, b_comp,b_writer,b_price)
values('979-002','Do It 자바','이지퍼블리싱','박은종',25000);
insert into tbl_books(b_isbn, b_title, b_comp,b_writer,b_price)
values('979-003','SQL 활용','교육부','교육부',10000);
insert into tbl_books(b_isbn, b_title, b_comp,b_writer,b_price)
values('979-004','무궁화꽃이 피었습니다','새움','김진명',15000);
insert into tbl_books(b_isbn, b_title, b_comp,b_writer,b_price)
values('979-005','직지','쌤앤파커스','김진명',12600);
insert into tbl_books(b_isbn,b_title,b_comp,b_writer,b_price)
values('978-801','effective JAVA','Addison','Joshua Bloch',159000);
select * from tbl_books ORDER by b_isbn;

alter table tbl_books--자리수가 적으면 데이터가 잘릴수 있음. 타입을 변경하면 데이터가 소실 될수 있다.(ex: CHAR to VARCHAR2)
modify(b_price number(7));
alter table tbl_books
add(b_remark nVARCHAR2(125));
alter table tbl_books
drop column b_remark;
alter table tbl_books--Java 프로그래밍 CRUD에서 문제가 생길수 있다.
rename column b_remark to b_rem;
alter user user3 identified by 1234;--비밀번호 변경.

create table tbl_genre(
    g_code	VARCHAR2(3)		PRIMARY KEY,
    g_name	nVARCHAR2(15)	NOT NULL	,
    g_remark	nVARCHAR2(125)		
);

insert into tbl_genre(g_code,g_name)
values('001','프로그래밍');
insert into tbl_genre(g_code,g_name)
values('002','데이터베이스');
insert into tbl_genre(g_code,g_name)
values('003','장편소설');

alter table tbl_books modify(b_genre nVARCHAR2(10));

update tbl_books
set b_genre='데이터베이스'
where b_isbn='979-001';
update tbl_books
set b_genre='데이터베이스'
where b_isbn='979-003';
update tbl_books
set b_genre='장편소설'
where b_isbn='979-004';
update tbl_books
set b_genre='프로그래밍'
where b_isbn='979-002';
update tbl_books
set b_genre='장편소설'
where b_isbn='979-005';
update tbl_books
set b_genre='프로그래밍'
where b_isbn='978-801';

update tbl_books
set b_genre='장르소설'
where b_genre='장편소설';

insert into tbl_books(b_isbn,b_title,b_comp,b_writer,b_price,b_genre)
values ('979-006','황태자비 납치사건','새움','김진명',25000,'장르소설');

select * from tbl_genre;
select * from tbl_books;
update tbl_books 
set b_genre='002'
where b_genre='데이터베이스';

update tbl_books
set b_genre='001'
where b_genre='프로그래밍';

update tbl_books
set b_genre='003'
where b_genre='장편소설';

--Join
select * from tbl_books,tbl_genre
where tbl_books.b_genre=tbl_genre.g_code;

select tbl_books.b_isbn,tbl_books.b_title,tbl_books.b_comp,tbl_books.b_writer,tbl_books.b_genre,
tbl_genre.g_name
from tbl_books,tbl_genre
where tbl_books.b_genre=tbl_genre.g_code;

--Table Alias 설정
select B.b_isbn,B.b_title,B.b_comp,B.b_writer,B.b_genre,
G.g_name
from tbl_books B,tbl_genre G --ANSI 구조에선 AS를 붙여줘야함
where B.b_genre=G.g_code;

insert into tbl_books(b_isbn,b_title,b_comp,b_writer,b_genre)
values('979-007','자바의 정석','도울출판','남궁성','004');

--완전Join | EQ Join. 결과를 Cartesian(*) 이라고 표현한다.
select * from [table1,[table2]
where table1.col=table2.col;