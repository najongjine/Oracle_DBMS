--상품정보 제2 정규화
select io_pname
from tbl_iolist
group by io_pname
order by io_pname;

create table tbl_product(
p_code	VARCHAR2(6)	NOT NULL	Primary Key,
p_name	nVARCHAR2(50)	NOT NULL	,
p_iprice	NUMBER		,
p_oprice	NUMBER		
);
select io_inout,count(*)
from tbl_iolist IO, tbl_product P
where io.io_pname=p.p_name
group by io.io_inout;

select io_inout,io.io_pname,io.io_price,count(*)
from tbl_iolist IO, tbl_product P
where io.io_pname=p.p_name
and io.io_inout=1
group by io.io_inout,io.io_pname,io.io_price;

update tbl_product P
set p_iprice=
(select max( io.io_price) from tbl_iolist IO
where io_inout=1 and p.p_name=io.io_pname

);
update tbl_product P
set p_oprice=
(select max( io.io_price) from tbl_iolist IO
where io_inout=2 and p.p_name=io.io_pname
);
commit;
--상품거래정보에서 상품정보 매입, 매출단가를 생성했더니
--null인 값이 있다.
--어떤상품은 매입만, 어떤 상품은 매출만 된 경우임.

/*
매입단가에서 매출단가 생성하기
공산품일 경우 매입단가의 약 %18를 더해서 매출단가를 계산.
그리고 여기에 %10의 vat을 붙여서 다시 계산.
(매입단가+(매입단가*0.18)) * 1.1

매출단가에서 매입단가 생성하기
매출단가에서 부가세를 제외하고
그 금액에서 %18를 빼서 매입단가를 계산

(매출단가 / 1.1) -((매출단가 /1.1) * 0.18)
매입단가=(매출단가/1.1) * 0.82
*/
update tbl_product
set p_oprice=
round((p_iprice + (p_iprice * 0.18))*1.1)
where p_oprice is null;

update tbl_product
set p_iprice=
round((p_oprice/1.1) * 0.82)
where p_iprice is null;

update tbl_product
set p_iprice=round(p_iprice,0),p_oprice=round(p_oprice,0);

--상품테이블 매출단가의 원단위 자르기
--매입매출 테이블과 연결하기