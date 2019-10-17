--
create tablespace iolist_DB
datafile '/bizwork/oracle/data/iolist.dbf'
size 50m AUTOEXTEND on next 10k;

create user iolist identified by iolist
default TABLESPACE iolist_DB;

grant dba to iolist;
commit;