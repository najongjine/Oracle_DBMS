
create table tbl_addr(
    name varchar2(10), 
    addr VARCHAR2(125),
    tel VARCHAR2(20),
    age INT,
    chain VARCHAR2(20)
);

select * from tbl_addr;

insert into tbl_addr(name,addr,tel,age,chain)
values('홍길동','서울시','010-111-1111',33,'친구');

update tbl_addr
set addr='광주광역시';

delete from tbl_addr;