select * FROM DUAL;
CREATE


--마이그레이션
--버전업, 업그래이드.
--하위버전에서 사용하던 데이터베이스(물리적, storage에 저장된 데이터들)를 상위버전 또는 다른회의 DBMS에서 사용할수 있도록 변환, 변경, 이전하는 것들.

--오라클 DBMS를(오라클DB, 오라클) 이용해서 DB관리 명령어를 연습하기 위해서
--연습용 데이터저장 공간을 생성을 한다.
--오라클에선 storage에 생성한 물리적 저장공간을 TableSpace라고 한다.
--기다 mySL,MSSQL등등의 DBMS들은 물리적 저장공간을 DataBase라고 한다.

--DDL명령을 사용해서 TableSapce를 생성한다.
--DDL 명령을 사용하는 사용자는? DBA.

--DDL명령에서 "생성한다" := CREATE
--물리적 SCHEMA를 생성한다.
CREATE TABLESPACE;
CREATE USER;
CREATE TABLE;/

--DDL 명령에서 삭세, 제거:= DROP
--DDL 명령에서 "변경":= AlLTER

--C:\BizWork\oracle\data
--C:/BizWork/oracle/data

--C:/BizWork/oracle/data 파일 이름으로 물리적 저장소를 생성한다.
--그 저장소 이름은 앞으로 USER1_db 라고 사용하겠다.
--초기 사이즈를 100M로 설정한다.
CREATE TABLESPACE user1_DB
DATAFILE 'C:/BizWork/oracle/data/user1.dbf'
SIZE 100M AUTOEXTEND ON NEXT 100K;


DROP TABLESPACE user1_DB
INCLUDING CONTENTS AND DATAFILES 
CASCADE CONSTRAINTS;

--비밀번호는 1234
--앞으로 user1으로 접속하여 데이터를 추가하면 그 데이터는 user1_db TableSpace에 저장하라.
CREATE USER user1 IDENTIFIED BY 1234
DEFAULT TABLESPACE user1_DB;

select * from ALL_USERS;

--DML의 select 명령은 데이터를 생성, 수정, 삭제한 후에 정상적으로
--수행되었나는 확인하는 용도로 사용된다.

--오라클에선 관리자가 새로운 사용자를 생성하면 아무런 권한도 없는 상태로 둔다.
--새로 생성된 상요자는 id,pass 를 입력해도 접속 자체가 되지 않는다.
--관리자는 새로 생성된 사용자에게 DBMS에 접속할수 있는 권한을 부여한다.
--권한과 관련된 명령어 셋을 DCL(Data Controll Language) 라고 한다.
--권한과 관련된 keyword는 2가지가 있음
--권한부여: GRANT
--권한 뺏기: REVOKE

--접속설정, 접속생성 권한을 user1에게 부여하라.
GRANT CREATE SESSION TO user1;

--user1 에게는 create session 권한만 부여했기 때문에
--여러 명령들을 사용하는게 거의 불가능 하다.
--오라클은 보안 정책으로 새로 생성된 사용자가 어떤 명령을 수행 하려면
--사용할수 있는 명령들을 일일이 부여 해 주어야 한다.

--오라클의 DBA 권한
--sysdba에 비해 상당히 제한적으로 부여된 권한으로
--일부 ddl명령, dml 명령, 일부 dcl 명령을 사용할수 있는 권한을 갖는다.
grant dba to user1;
revoke dba from user1;