create table tbl_bbs(
b_id	NUMBER		Primary Key,
b_p_id	NUMBER		,
b_date_time	VARCHAR2(30)	not null	,
b_writer	nVARCHAR2(30)	not null	,
b_subject	nVARCHAR2(125)	not null	,
b_content	nVARCHAR2(2000)		,
b_file	nVARCHAR2(125)		

);