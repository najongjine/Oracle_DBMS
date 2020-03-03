create table tbl_comment(
c_id	NUMBER		Primary Key,
c_b_id	NUMBER	not null	,
c_p_id	NUMBER	,
c_date_time	VARCHAR2(30)	not null	,
c_writer	nVARCHAR2(30)	not null	,
c_subject	nVARCHAR2(125)	not null	
);
drop table tbl_comment;
create sequence seq_comment
start with 1 INCREMENT by 1;

delete from tbl_bbs;
drop SEQUENCE seq_bbs;
create SEQUENCE seq_bbs
start with 50 INCREMENT by 1;