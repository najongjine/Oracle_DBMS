--
create table tbl_test(
    num NVARCHAR2(20) not null unique primary key,
    name NVARCHAR2(50) not null,
    age NUMBER(3) not null
);

drop table tbl_test;