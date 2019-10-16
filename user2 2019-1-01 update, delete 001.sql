--update, delete
create table tbl_address(
    name NVARCHAR2(20) not null,
    tel VARCHAR2(20) not null,
    address NVARCHAR2(125),
    chain NVARCHAR2(10),
    rem NVARCHAR2(125),
    birth NVARCHAR2(10),
    age NUMBER(3)
);

insert into tbl_address(name,tel)
values('홍길동','서울특별시');

select * from tbl_address;

insert into tbl_address(name,tel)
values('이몽룡','익산시');
insert into tbl_address(name,tel)
values('성춘향','함경남도');
insert into tbl_address(name,tel)
values('임꺽정','부산광역시');
commit;
update tbl_address set address='서울특별시'; --재난을 초래함

--commit 완료후 실행해 줘야함
rollback;

update tbl_address set address='서울특별시'
where name='홍길동';
update tbl_address set tel='010-111-1111'
where name='홍길동';

update tbl_address set address='익산시'
where name='이몽룡';

update tbl_address set address='함경남도'
where name='성춘향';
commit;

insert into tbl_address(name,tel)
values('홍길동','서울특별시');

drop table tbl_address;
create table tbl_address(
    id NUMBER(10) primary key,
    name NVARCHAR2(20) not null,
    tel VARCHAR2(20) not null,
    address NVARCHAR2(125),
    chain NVARCHAR2(10),
    rem NVARCHAR2(125),
    birth NVARCHAR2(10),
    age NUMBER(3)
);

insert into tbl_address(id,name,tel)
values(5,'성춘향','익산시');
select * from tbl_address;

update tbl_address set address='서울특별시'
where id=1;
update tbl_address set address='광주광역시'
where id=2;
update tbl_address set address='부산광역시'
where id=3;
commit;

delete from tbl_address;
--연습이라서 rollback 실행함
rollback;

select * from tbl_address where name='성춘향';
delete from tbl_address where id=5;

--DB운영중 제일 중요한거
--1. 백업.
--1-1. 복구: 백업해둔 데이터를 사용중인 시스템에 다시 설치. 복구는 시간이 ㅈㄹ 걸림. 100% 복구 보장 못함.
--2. 로그기록 복구: insert, update, delete  명령들이 수행될때 수행되는 모든 명령들을 별도의 ㅏ일로 기록해두고
-- 로그를 다시 역으로 추적하여 복구하는 방법
--3. 이중화, 삼중화: 똑같은 하드웨어+시스템+SW 다른지역에 설치하고, 메인 시스템에 모든것을 bk하드웨어+시스템+SW에 다 복제함.
-- 재난 발생시 메인을 끊어버리고 bk을 활성

--데이터센터(data warehouse): 대량의 데이터베이스를 운영하는 서버 시스템들을 모아서 통합 관리하는 곳.