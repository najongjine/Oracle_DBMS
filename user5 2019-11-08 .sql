--
create table tbl_memo(
m_seq number,
m_date VARCHAR2(10) not null,
m_time varchar2(8) not null,
m_auth NVARCHAR2(50) not null,
m_subject nvarchar2(125) not null,
m_text NVARCHAR2(1000),
m_flag VARCHAR2(1),
m_field NVARCHAR2(20),
m_ok VARCHAR2(1)
);
desc tbl_memo;
commit;
insert into tbl_memo(m_seq,m_date,m_time,m_auth,m_subject)
values(1,'2019-11-08','09:42:00','홍길동','메모작성');

insert into tbl_memo(m_seq,m_date,m_time,m_auth,m_subject)
values(SEQ_MEMO.nextval,'2019-11-08','09:42:00','홍길동','메모작성');

create SEQUENCE SEQ_MEMO
start with 1 INCREMENT by 1;

update tbl_memo
set m_auth='성춘향'
where m_seq=2;

create table tbl_iolist(
io_seq	number		Primary Key,
io_date	varchar2(10)	not null,	
io_pname	nvarchar2(25)	not null	,
io_dname	nvarchar2(25)	not null	,
io_dceo	nvarchar2(25)	not null	,
io_inout	nvarchar2(2)	not null	,
io_qty	number	not null	,
io_price	number		,
io_total	number		
);

create table tbl_product(
p_code	varchar2(5)		primary key,
p_name	nvarchar2(50)	not null	,
p_iprice	number		,
p_oprice	number		,
p_vat	varchar2(1)		
);

create table tbl_dept(
d_code	varchar2(5)		primary key,
d_name	nvarchar2(50)	not null	,
d_ceo	nvarchar2(50)	not null	,
d_tel	varchar2(20)		,
d_addr	nvarchar2(125)		
);

select count(*) from tbl_iolist;

select io_inout,count(*) from tbl_iolist
group by io_inout;

select io_inout,sum(io_total) from tbl_iolist
group by io_inout;

select decode(io_inout,'매입',io_total,0) 매입,
decode(io_inout,'매출',io_total,0) 매출
from tbl_iolist;

select 
sum(decode(io_inout,'매입',io_total,0) )as 매입,
sum(decode(io_inout,'매출',io_total,0) )as 매출
from tbl_iolist;

select 
SUBSTR(io_date,0,7) 월별,
sum(decode(io_inout,'매입',io_total,0) )as 매입,
sum(decode(io_inout,'매출',io_total,0) )as 매출
from tbl_iolist
group by SUBSTR(io_date,0,7);

select 
io_dname,
sum(decode(io_inout,'매입',io_total,0) )as 매입,
sum(decode(io_inout,'매출',io_total,0) )as 매출
from tbl_iolist
group by io_dname;

select 
io_dname, io_dceo,
sum(decode(io_inout,'매입',io_total,0) )as 매입,
sum(decode(io_inout,'매출',io_total,0) )as 매출
from tbl_iolist
group by io_dname, io_dceo;

--거레명세와 거래처정보 table을 join하여 확인하기
select * 
from tbl_iolist, tbl_dept
where io_dname=d_name and io_dceo=d_ceo;

select *
from tbl_iolist io
left join tbl_dept d
on io.io_dname=d.d_name and io.io_dceo=d.d_ceo;

select * from tbl_iolist io
left join tbl_dept d
on io.io_dcode = d.d_code;