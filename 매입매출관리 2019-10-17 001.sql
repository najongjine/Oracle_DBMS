--
create table tbl_iolist(
io_seq	NUMBER	NOT NULL	Primary Key,
io_date	VARCHAR2(10)	NOT NULL	,
io_pname	nVARCHAR2(50)	NOT NULL	,
io_dname	nVARCHAR2(50)	NOT NULL	,
io_dceo	nVARCHAR2(20)		,
io_inout	NUMBER(1)	NOT NULL	,
io_qty	NUMBER	NOT NULL	,
io_price	NUMBER		,
io_amt	NUMBER		

);
commit;

select io_inout, count(*) from tbl_iolist
group by io_inout;

select decode(io_inout, 1, '매입','매출')as 구분,
count(*) from tbl_iolist
group by decode(io_inout,1,'매입','매출');

--decode(column,value,T result, value2, T result2...)
select decode(io_inout, 1, '매입',2,'매출')as 구분,
count(*) from tbl_iolist
group by decode(io_inout,1,'매입',2,'매출');

select decode(io_inout,1,'매입',
decode(io_inout,2,'매출'))
from tbl_iolist
group by io_inout;

select decode(io_inout, 1, '매입',2,'매출') as 거래구분,
sum(decode(io_inout,1,io_amt,0)) as 매입합계,
sum(decode(io_inout,2,io_amt,0))as 매출합계
from tbl_iolist
group by decode(io_inout,1,'매입',2,'매출');

select sum(decode(io_inout,1,io_amt,0)) as 매입합계,
sum(decode(io_inout,2,io_amt,0))as 매출합계
from tbl_iolist;

select io_date,sum(decode(io_inout,1,io_amt,0)) as 매입합계,
sum(decode(io_inout,2,io_amt,0))as 매출합계
from tbl_iolist
group by io_date;

--Left:표준 sql에서 왼쪽부터 문자열 자르기
--right: 오른쪽부터 문자열 자르기
--mid(문자열,시작,개수): 중간 문자열 자르기
select substr(io_date,0,7) as 월,
sum(decode(io_inout,1,io_amt,0)) as 매입합계,
sum(decode(io_inout,2,io_amt,0))as 매출합계,
sum(decode(io_inout,2,io_amt,0))-sum(decode(io_inout,1,io_amt,0)) as 마진
from tbl_iolist
group by substr(io_date,0,7)
order by substr(io_date,0,7);
