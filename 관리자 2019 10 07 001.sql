--

create TABLESPACE user3_db
datafile '/bizwork/oracle/data/user3.dbf'
size 10m AUTOEXTEND on next 1k;

create user user3 identified by 1234
default tablespace user3_db;

--개념스키마
--DBMS차원에서 바라본 schema.
--논리적인 개념으로 table등과 같은 저장소 object를 모아놓은 그룹.

--오라클에서는 user가 개념 schema 역활을 수행.