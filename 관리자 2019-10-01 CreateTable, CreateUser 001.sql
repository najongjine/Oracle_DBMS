
--directory 구분문자는 /사용.
--맨앞에 /만 사용하면 c:/와 같은의미.
create tablespace user2_DB --tablespace 이름지정. 다른 BDMS에서는 tablespace 대신 database 키워드 씀.
datafile '/BizWork/oracle/data/user2.dbf' --실제데이터가 저장되는곳
size 10m AUTOEXTEND ON NEXT 10k;

create user user2 identified by 1234
default tablespace user2_DB; --default tablespace를 지정하지 않으면 DBMS system 영역에 저장해버림.

--11gXE 환경에서는 보안문제가 크지 않아서, 걍 사용자에게 DBA권한을 줘버림. 실습의 편의섬.
--system에 관련된 정보를 조회할수 있는 권한.
--DDL 명령을 활용하여 자신의 영역에 table등 DB Object생성, 삭제, 변경할수 있는 권한.
--DML 명령을 활용하여 데이터를 관리(조작)을 할수있는 권한.
--일부 DCL명령을 사용할수 있는 권한.
grant DBA to user2;