--
create tablespace grade_db
datafile '/bizwork/oracle/data/drade.dbf'
size 10m autoextend on next 10k;

create user grade identified by grade
default tablespace grade_db;
grant DBA to grade;

alter user grade identified by grade;

select * from all_users where username='GRADE';