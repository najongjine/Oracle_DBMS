create tablespace new_grade_db
datafile '/bizwork/oracle/data/new_grade.dbf'
size 100m AUTOEXTEND on next 100k;

create user new_grade IDENTIFIED by grade;
grant dba to new_grade;