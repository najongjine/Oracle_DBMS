--
/*
도서정보를 추가하는데 isbn과 별도로 자체적으로 일련번호를 부여하여 관리를 하겠다.
1~ 입력 순서대로 번호를 부여하겠다.

기존에 입력된 번호와 새로운 번호를 사용해서 데이터를 입력한다.

데이터를 입력할때 일련번호를 기억하기 싫다.
항상 새로운 번호로 일련번호를 생성하여 데이터를 추가할수 있도록 해 달라.

입력된 데이터중에서 b_price는 숫자값인데
값이 없이 추가가되면 null이 된다. 
이럴경우 프로그래밍 언어에서 데이터를 가져다 사용할때 문제가 됨.
그럴경우 자동으로 0ㅇ,로 채우게하자.
*/

create table tbl_books(
b_code VARCHAR2(5) primary key,
b_name nVARCHAR2(50) not null,
b_comp NVARCHAR2(50),
b_writer NVARCHAR2(20),
b_price NUMBER default 0
);

insert into tbl_books(b_code,b_name,b_comp,b_writer)
values(1,'자바입문','이지퍼블','박은종');
insert into tbl_books(b_code,b_name,b_comp,b_writer,b_price)
values(2,'오라클','생능','서진수',35000);
INSERT into tbl_books(b_code,b_name)
values(round(dbms_random.value(100_000_000,9_999_999_999),0),'연습도서');

/*
sequence 객체: auto increament 대체용으로도 쓰임.
*/
drop SEQUENCE seq_books;
create sequence seq_books
start with 1 increment by 1;

select seq_books.nextval from dual;

insert into tbl_books(b_code,b_name)
values(seq_books.nextval,'seq prac');

--기존에 생성된 테이블에 seq 적용하기
/*
1. 기존 데이터의 seq 칼럼의 최대값이 얼마냐 확인: 589
2. 새로운 시퀀스를 생성할때 srat with:600으로 설정.
*/
create SEQUENCE seq_iolist
start with 600 increment by 1;

--start with 값을 잘못 설정했을경우:
alter sequence seq_iolist increment BY 600;
select seq_iolist.nextval from dual;
alter SEQUENCE seq_iolist increment by 1;
-- or just drop the seq table and recreate
drop sequence seq_iolist;

select seq_books.currval from dual;

/*
도서코드를 b0001형식으로 일련번호를 만들고 싶다.
B0001
*/
--to_char(val,'0000'):자릿수를 4개, 공백부분은 0으로.
--to_char(val,'9999'):자릿수를 4개, 남는 부분은 공백.
insert into tbl_books(b_code,b_name)
values('B'||trim(to_char(SEQ_BOOKS.nextval,'0000')),'seq pract');

--오라클의 고정길이문자열 생성
/*
원래값이 숫자형일경우 to_char(val, format)

원래값이 다양한 형일경우
lpad(val,max_length,채움문자)
*/
select lpad(30,10,'*') from dual;
select rpad(30,10,'A') from dual;

commit;
update tbl_books
set b_price=round(DBMS_RANDOM.value(1000,50000));