select D_CODE,D_NAME,D_CEO,D_TEL,D_ADDR
from tbl_dept;

select IO_SEQ,IO_DATE,IO_INOUT,IO_QTY,IO_PRICE,IO_TOTAL,IO_PCODE,IO_DCODE
from tbl_iolist;

select P_CODE,P_NAME,P_IPRICE,P_OPRICE,P_VAT
from tbl_product;

-- 제2 정규화 후 참조 무결성 설정하기.

alter table tbl_iolist
add constraint FK_PRODUCT
foreign key (io_pcode)
references tbl_product(p_code);

alter table tbl_iolist
add constraint FK_DEPT
foreign key (io_dcode)
references tbl_dept(D_CODE);

--1부터 x까지 연속된 값을 레코드로 추출.
select level from dual
connect by level <= 10;

select level from dual
connect by level <= &변수; -- oracle의 대치 연산자
select level * &시작 from dual connect by level <= &종료;
select (level-10) * -1 from dual connect by level < 10;

select IO_SEQ,IO_DATE,IO_INOUT,IO_QTY,IO_PRICE,IO_TOTAL,IO_PCODE,IO_DCODE
from tbl_iolist
where io_date between '&시작일자' and '&종료일자';

-- 문자열을 날짜 타입으로 변환
/*
2019-01-01 부터 2019-01-31 까지의 날짜값을 추출.
*/
SELECT to_date('20190101','YYYYMMDD') + level  from dual
connect by level <= to_date('2019-01-31','YYYY-MM-DD') - to_date('20190101','YYYYMMDD');

-- x 부터 y 까지 년과 월만 추출
-- add_months 날짜값에 월을 + 해서 숫자형 날짜값으로 변환
SELECT add_months(to_date('20190101','YYYYMMDD'),  level -1) from dual
connect by level <= to_date('2019-01-31','YYYY-MM-DD') - to_date('20190101','YYYYMMDD');

--기간을 지정하여 년-월 형태의 문자열을 생성하는 코드
select to_char(add_months(to_date('2019-0101','YYYY-MM-DD'),level-1),'YYYY-MM-DD') from dual
connect by level <=5;

select sysdate from dual;
select last_day(sysdate) from dual;

-- 현재 날짜가 포함된 달의 첫번째 날짜부터 말일까지 리스트 나타내기
select trunc(sysdate,'month')+(level -1) from dual connect by level <=(last_day(sysdate)) - TRUNC(SYSDATE,'month')+1;

select * from
tbl_iolist io,
(
select to_char(add_months(to_date('2018-01-01','YYYY-MM-DD'),level-1),'YYYY-MM-DD') from dual 
connect by level <=12
);
select to_char(add_months(to_date(io_date,'YYYY-MM-DD'),0),'YYYY-MM-DD') from tbl_iolist;

select substr(io_date,0,7) as io_월 , sum(io_total)
from tbl_iolist io
group by substr(io_date,0,7);

-- 월 리스트를 서브쿼리로 생성한 다음
-- 월리스트를 EQ Join을 실행해서 월별합계
select 월 , sum(io_total)
from tbl_iolist io,
(
select to_char(add_months(to_date('2018-01-01','YYYY-MM-DD'),level-1),'YYYY-MM-DD') as 월 from dual 
connect by level <=12
)
where 월=substr(io_date,0,7)
group by 월;

--1500000 ,12250
select min(io_total), max(io_total) from tbl_iolist;

-- subq 10000~1500000 까지 10000씩 증가하는 값을 생성
-- 각각의 값 범위 (예)1000~20000 까지의 합계와 개수를 연산
select sub.total, sum(io_total), count(io_total) from tbl_iolist,
(
select level * 10000 as total from dual connect by level <= 150
) sub where io_total >= sub.total and io_total < sub.total + 10000 and io_inout='매출'
group by total order by total;

select 점수, count(sc.sc_score) from tbl_score sc,
(
select level * 10 as 점수 from dual connect by level <= 10
) sub
where sc.sc_score >= 점수 and sc.sc_score <= 점수+10
group by 점수
order by 점수;

select 점수, count(sc.sc_score) from 
(
select level * 10 as 점수 from dual connect by level <= 10
) sub left join tbl_score sc
on sc.sc_score >= 점수 and sc.sc_score <= 점수+10
group by 점수
order by 점수;

-- 오라클에서 숫자를 연속된 값의 리스트로 만들때
select level from dual connect by level <= 변수;

-- sc_subject 칼럼에 들어있는 과목명 리스트
select * from
(select sc_name, sc_subject, sc_score from tbl_score)
pivot (
    sum(sc_score)
    for sc_subject in(
    '국어' as 국어,
    '과학' as 과학,
    '영어' as 영어,
    '수학' as 수학,
    '국사' as 국사,
    '미술' as 미술
    )
);

select sc_stcode,
sum(decode(sc_sbcode,'S0001',sc_score)) as 과학,
sum(decode(sc_sbcode,'S0003',sc_score)) as 국어,
sum(decode(sc_sbcode,'S0006',sc_score)) as 영어,
sum(decode(sc_sbcode,'S0002',sc_score)) as 수학,
sum(decode(sc_sbcode,'S0004',sc_score)) as 국사,
sum(decode(sc_sbcode,'S0005',sc_score)) as 미술
from tbl_score
group by sc_stcode;

select sc_stcode, 
sum(case when sc_sbcode='S0001' then sc_score end) as 과학,
sum(case when sc_sbcode='S0002' then sc_score end) as 수학,
sum(case when sc_sbcode='S0003' then sc_score end) as 국어,
sum(case when sc_sbcode='S0004' then sc_score end) as 국사,
sum(case when sc_sbcode='S0005' then sc_score end) as 미술,
sum(case when sc_sbcode='S0006' then sc_score end) as 영어
from tbl_score
group by sc_stcode;

select io_inout,
sum(decode(io_inout,'매입',io_total,0)) as '매입',
sum(decode(io_inout,'매출',io_total,0)) as '매출'
from tbl_iolist
group by io_inout;

select
sum(decode(io_inout,'매입',io_total)) as 매입,
sum(decode(io_inout,'매출',io_total)) as 매출
from tbl_iolist;

select
sum(decode(io_inout,'매입',io_total,0)) as 매입,
sum(decode(io_inout,'매출',io_total,0)) as 매출,
sum(decode(io_inout,'매출',io_total,0))-
sum(decode(io_inout,'매입',io_total,0)) as 마진
from tbl_iolist;

select
substr(io_date,0,7),
sum(decode(io_inout,'매입',io_total,0)) as 매입,
sum(decode(io_inout,'매출',io_total,0)) as 매출
from tbl_iolist
group by substr(io_date,0,7);

--거래처별로 매입매출 집계
--거래처테이블과 join
select
io.io_dcode,d.d_name,d.d_ceo,d.d_tel,
sum(decode(io_inout,'매입',io_total,0)) as 매입,
sum(decode(io_inout,'매출',io_total,0)) as 매출
from  tbl_iolist io
left join tbl_dept D
on io.io_dcode=d.d_code
group by io.io_dcode,d.d_code,d.d_name,d.d_ceo,d.d_tel;

select
io.io_dcode,d.d_name || d.d_ceo || d.d_tel,
sum(decode(io_inout,'매입',io_total,0)) as 매입,
sum(decode(io_inout,'매출',io_total,0)) as 매출
from  tbl_iolist io
left join tbl_dept D
on io.io_dcode=d.d_code
group by io.io_dcode,d.d_name || d.d_ceo || d.d_tel
having sum(decode(io_inout,'매입',io_total,0)) > 10000;

select io_date, io_pcode, p_name,
decode(io_inout,'매입',io_price) as 매입단가,
decode(io_inout,'매입',io_total) as 매입합계,
decode(io_inout,'매출',io_price) as 매출단가,
decode(io_inout,'매출',io_total) as 매출합계
from tbl_iolist, tbl_product
where io_pcode=p_code
order by io_date;

select io_date, io_dcode, d_name, io_pcode,p_name,
decode(io_inout,'매입',io_price) as 매입단가,
decode(io_inout,'매입',io_total) as 매입합계,
decode(io_inout,'매출',io_price) as 매출단가,
decode(io_inout,'매출',io_total) as 매출합계
from tbl_iolist 
left join tbl_product
on io_pcode=p_code
left join tbl_dept
on io_dcode=d_code
order by io_date;

