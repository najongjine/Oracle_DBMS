--
/*
tablespace 생성.
이름: user4_db
datafile: '/bizwork/oracle/data/user4.dbf'
초기용량: 10mb 자동확장: 10kb
*/

/*
사용자생성.
ID: user4
PW: user4
default tablesapce user4_db
*/

create tablespace user4_db
datafile '/bizwork/oracle/data/user4.dbf'
size 10m AUTOEXTEND on next 10k
;

create user user4 IDENTIFIED by user4
default tablespace user4_db;

--data가 많은 table이 있는 경우 tablespace를변경하면 문제가 있다.
alter user user4 default tablespace user4_db;

--기존 tablepsace에 있는 table들을 수동으로 다른 talbespace로 옮기기.
alter table tbl_student move tablespace user4;

alter user user4 identified by user4;
grant dba to user4;