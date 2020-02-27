--
create tablespace bbs_final_ts
datafile 'c:/bizwork/oracle/data/bbs_final.dbf'
size 10m AUTOEXTEND on next 1k;

create user bbsfinal IDENTIFIED by bbsfinal
default tablespace bbs_final_ts;
grant dba to bbsfinal;