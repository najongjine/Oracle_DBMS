--
commit;

create table tbl_iolist
(
io_seq	NUMBER	NOT NULL	Primary Key,
io_date	VARCHAR2(10)	NOT NULL	,
io_pname	nVARCHAR2(50)	NOT NULL,	
io_dname	nVARCHAR2(50)	NOT NULL,	
io_dceo	nVARCHAR2(20)		,
io_inout	NUMBER(1)	NOT NULL	,
io_qty	NUMBER	NOT NULL	,
io_price	NUMBER		,
io_amt	NUMBER		

);

update tbl_product
set p_oprice=round(p_oprice/10,0)*10;

alter table tbl_iolist
ADD io_pcode VARCHAR2(6);

--update 실행에서 유의사항: update을 수행하는 subq 의 select projection에는
--칼럼을 1개만 사용해야 한다.
--subq에서 나타나는 레코드 수도 반드시 1개만 나타나야 한다.

--매입매출 테이블 리스트를 나열하고
--각 요소의 상품이름을 subq로 전달.
--subq에서는 상품테이블로 부터 상품이름을 조회하여
--일치하는 레코드가 1개 나타나면 해당 레코드의 상품코드 칼럼의 값을
--매입매출 칼럼의 상품코드 칼럼에 업데이트 하라.
update tbl_iolist IO set io_pcode=
( select p_code from tbl_product P
where io.io_pname=p.p_name
);

--업데이트후에 검증: iolist와 product를 eq join 수행해서--누ㅠ락된 데이터가 없는지 확인ㅁ
select count(*) from tbl_iolist;
select count(*) from tbl_iolist, tbl_product
where io_pcode=p_code;
commit;

--매입매출테이블에서 상품이름 칼럼 제거
alter table tbl_iolist drop COLUMN io_pname;

/*
오라클에서 insert,update,delete을 수행한 직후에는 아직 데이터가 commit되지 않아서 살제 물리적 테이블이 저장이 되지 않은 상태이다.
이때는 rollback을 수행해서 CUD를 취소할수 있다.

단, DDL명령(create,alter,drop)을 수행하면 자동 commit이 된다.
대량의 insert,update,delete를 수행한 후 데이터 검증이 완료되면 commit을 수행하고 다음으로 진행하자.
*/

select count(*)
from tbl_iolist,tbl_product
where io_pcode=tbl_product.p_code;