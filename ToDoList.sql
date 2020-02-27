-- tbl_todolist

create table tbl_todolist(
td_seq	number		Primary Key,
td_date	varchar2(10)	not null,	
td_time	varchar2(8)	not null	,
td_subject	nvarchar2(125)	not null	,
td_text	nvarchar2(1000)		,
td_flag	varchar2(1)	default '1'	,
td_complete	varchar2(1)	default 'N'	,
td_alarm	varchar2(1)	default 'N'	

);