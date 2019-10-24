--
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