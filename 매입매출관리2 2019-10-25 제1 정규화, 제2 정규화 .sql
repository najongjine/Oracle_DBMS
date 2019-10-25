/*
제 1 정규화는 칼럼 하나당 원소값이 아니거나, null값이 많이 나올때 칼럼을 튜플 안으로 넣어주자
제 2 정규화는 중복값이 의심되면 그 테이블을 분리해서 코드로 만들어 주자
*/

select io_inout, count(*) tbl_iolist
from tbl_iolist
group by io_inout;

-- 제 1 정규화:= 칼럼을 튜플로 넣어 버리는것
-- 제 2 정규화:= 중복 가능성 있는 데이터를 다른 테이블로 분리
select io_pname,avg(decode(io_inout,'매입',io_price)) as 매입단가,
avg(decode(io_inout,'매출',io_price)) as 매출단가
from tbl_iolist
where io_inout='매입'
group by io_pname
order by io_pname;

select io_pname from tbl_iolist
group by io_pname;

create table tbl_product(
p_code	varchar2(5)		primary key,
p_name	nvarchar2(50)	not null	,
p_iprice	number		,
p_oprice	number		,
p_vat	varchar2(1)		
);
commit;
select count(*) from tbl_iolist, tbl_product
where io_pname=p_name;

alter table tbl_iolist
add io_pcode varchar2(5);

-- 매입매출 테이블 전체를 펼쳐두고
-- 각 레코드에서 상품이름을 추출하여
-- 상품테이블의 select 문으로 주입하고
--상품 테이블에서 해당 상품 이름으로 where 조건을 실행하여
-- 나타나는 상품 고드를 매입매출 테이블의 상품코드 칼럼에 업데이트 실행하라.
update tbl_iolist
set io_pcode=
(select p_code from tbl_product
where io_pname=p_name
);

select * from tbl_iolist, tbl_product
where io_pcode=p_code;

alter table tbl_iolist drop COLUMN io_pname;

select io_dname, io_dceo
from tbl_iolist
group by io_dname,io_dceo;

-- 전화번호 만들기 수식
-- ="010-"&TEXT(RANDBETWEEN(1000,9999),"0000")&"-"&TEXT(RANDBETWEEN(1000,9999),"0000")

create table tbl_dept(
d_code	varchar2(5)		primary key,
d_name	nvarchar2(50)	not null	,
d_ceo	nvarchar2(50)	not null	,
d_tel	varchar2(20)		,
d_addr	nvarchar2(125)		
);

select count(*) from tbl_dept;

alter table tbl_iolist
add io_dcode varchar2(5);

select count(*)
from tbl_iolist,tbl_dept
where io_dname=d_name and io_dceo=d_ceo;

update tbl_iolist
set io_dcode=
-- update subq에선 반드시 1개의 레코드만 추출되도록 where 조건이 성립되어야 한다.
(select d_code from tbl_dept
where io_dname=d_name and io_dceo=d_ceo
);
commit;

alter table tbl_iolist
drop COLUMN io_dname;
alter table tbl_iolist
drop COLUMN io_dceo;

drop view view_iolist;
create view view_iolist as (
select IO_SEQ,
IO_DATE,
IO_INOUT,
IO_DCODE ,

D_NAME as io_dname,
D_CEO as io_dceo,
D_TEL as io_dtel,
D_ADDR as io_daddr,
IO_PCODE,

P_NAME as io_pname,
P_IPRICE as io_iprice,
P_OPRICE as io_oprice,
P_VAT as io_vat,
IO_QTY,
IO_PRICE,
IO_TOTAL
from tbl_iolist IO
left join tbl_product P
on io.io_pcode=p.p_code
left join tbl_dept D
on io.io_dcode=d.d_ceo
);
commit;