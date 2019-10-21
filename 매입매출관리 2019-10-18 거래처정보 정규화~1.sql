--
select io_dname,io_dceo from tbl_iolist
group by io_dname,io_dceo;

--거래명이 같고, 대표자명이 다른 데이터를 uniq 설정하기.
--입력할때 거래명과 대표자명이 동시에 같은 데이터는 insert 막기.
create table tbl_dept
(d_code	VARCHAR2(5)		Primary Key,
d_name	nVARCHAR2(50)	NOT NULL	,
d_ceo	nVARCHAR2(50)	NOT NULL	,
d_tel	VARCHAR2(20)		,
d_addr	nVARCHAR2(125)		,
d_man	nVARCHAR2(50)	,
CONSTRAINT UQ_name_ceo unique(d_name,d_ceo)

);
alter table tbl_dept add CONSTRAINT  UQ_name_ceo unique (d_name,d_ceo);

select count(*) from tbl_dept;

--거래처명이 같고 ceo가 다른 거래처가 있는지 확인.
--같은 거래처명이 있는지 확인
select d_name,count(*) from tbl_dept
group by d_name
having count(*) > 1;

select count(*)
from tbl_iolist IO, tbl_dept DP
where io.io_dname=dp.d_name and io_dceo=d_ceo;

alter table tbl_iolist add io_dcode VARCHAR2(5);
commit;

update tbl_iolist
set io_dcode=(
select d_code from tbl_dept
where io_dname=d_name and io_dceo=d_ceo
);

select count(*) from tbl_iolist, tbl_dept
where io_dcode=d_code;
commit;

alter TABLE tbl_iolist
drop COLUMN io_dname;

ALTER TABLE tbl_iolist RENAME COLUMN io_dname TO io_dcode;
ALTER TABLE tbl_iolist RENAME COLUMN io_pname TO io_pcode;

/*
iolist를 제2정규화를 수행해서 상품정보와 거래처정보르,ㄹ table분리 완서ㅏㅇ
iolist의 단가(io_price)칼럼을 삭제하지 않고 유지하고있는 이유:
iolist의 매입,매출 단가는 실제로 상품이 매입,매출되는 시점에 변동될수 있다.
 기준수량 입출 할때와 건장수량 입출할때 밀어내기 입출할때는 단가가 달리 적용된다.
 기준단가(100새):1000, 권장수량(1000개):900, 밀어내기 단가(5000개) 700
 ikolist에는 실질적인 입출단가가 기록되어서 결산수행의 기준값으로 삼는다.: 실질적 결산내용
 
  회계상 재로,이익금을 계산할때는
  매입매출이 변동된 단가로 계산하게ㅐ 되면 상당히 어려운 연산들이 필요하다.
  그래서 회계상 계산을 할때 사용할 표준단가를 product에 저장해두고 사용한다.
  
  tbl_iolist.io_price는 현실에서 진짜 거래할때 구입하거나 판매한 금액.
  즉, 사기당하거나 사기치거나, 깍아주거나 한 동적금액.
  tbl_product의 iprice,oprice는 standard 금액. 정적금액.
*/

select * from tbl_iolist IO
left join tbl_product P
on io.io_pcode=p.p_code
left join tbl_dept D
on io.io_dcode=d.d_code
order by io.io_date,io.io_pcode;

create view view_iolist as
(
select IO_SEQ as SEQ,
IO_DATE as IODATE,
IO_INOUT as INOUT,
IO_DCODE as DCODE, 
D_NAME as DNAME,
IO_PCODE as PCODE,
P_NAME as PNAME,
D_CEO as DCEO,
D_TEL as DTEL,
IO_PRICE as PRICE,
P_IPRICE as IPRICE,
P_OPRICE as OPRICE,
IO_QTY as QTY,
IO_AMT as AMT
from tbl_iolist IO
left join tbl_product P
on io.io_pcode=p.p_code
left join tbl_dept D
on io.io_dcode=d.d_code
);
drop view view_iolist;
commit;

select decode(inout,'1','매입','2','매출'),
dcode,dname,dceo,
pcode,pname,
qty,price,amt
from view_iolist;

--1. decode를 사요ㅕㅇ해서 inout 칼럼값을 기준으로 매입,매출구분을 실행
--2. 매입과 매출 구분된 항목을 sum()으로 묶어주기
--3. sum()으로 묶이지 않은 dcode,dname 칼럼을 group by 절에 나열
select dcode, dname, sum(decode(inout,1,amt,0)) as 매입합계,
sum(decode(inout,2,amt,0)) as 매출합계
from view_iolist
group by dcode,dname
order by dcode;

select pname,dcode, dname, decode(inout,1,amt,0) as 매입,
decode(inout,2,amt,0) as 매출
from view_iolist;

--1. 거래일자 칼럼에서 년월만 추출 substr(칼럼,시작,개수)
--2. decode를 사용해서 inout에 따라서 매입매출 구분
--3. sum으로 묶기
--4. 월별 추출계산식을 gorup by에 지정.
--to_char() sql에서 일반적으로 화면보기용으로는 사용을 하되
-- 다른 언어와 연동되는 부분에서는 가급적 사용을 자제.
select substr(iodate,0,7) as 월,
to_char(sum(decode(inout,1,amt)),'999,999,999,999') as 매입합계,
to_char(sum(decode(inout,2,amt)),'999,999,999,999') as 매출합계
from view_iolist
group by substr(iodate,0,7)
order by substr(iodate,0,7);

select iodate,
to_char(sum(decode(inout,1,amt)),'999,999,999,999') as 매입합계,
to_char(sum(decode(inout,2,amt)),'999,999,999,999') as 매출합계
from view_iolist
group by iodate
order by iodate;

select SEQ, iodate, dname, pname,
decode(inout,1,amt,0) as 매입,
decode(inout,2,amt,0) as 매출
from view_iolist;

select sum(decode(inout,1,amt,0)) as 총매입합계,
sum(decode(inout,2,amt,0)) as 총매출합계
from view_iolist
where iodate between '2018-01-01' and '2018-12-31';

select iprice,oprice,
decode(inout,1,price,0) as 매입,
decode(inout,2,price,0) as 매출
from view_iolist;

--상품정보와 매입매출 테이블의 입출단가의 차액을 계산해보는 sql
select pcode,pname,iprice,
decode(inout,1,price,0) as 매입,
decode(inout,1,iprice,0)
-decode(inout,1,price,0) as 매입차액,
oprice,
decode(inout,2,price,0) as 매출,
decode(inout,2,oprice,0)-decode(inout,2,price,0) as 매출차액
from view_iolist;