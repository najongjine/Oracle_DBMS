--
create table tbl_bbs(
bs_id number PRIMARY key,
bs_date VARCHAR2(10) not null,
bs_time VARCHAR(10) not null,
bs_writer NVARCHAR2(20) not null,
bs_subject NVARCHAR2(125) not null,
bs_text NVARCHAR2(1000) not null,
bs_count number
);
create sequence seq_bbs
start with 1 INCREMENT by 1;

update tbl_bbs