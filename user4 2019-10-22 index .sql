--
/*
오라클에서 random, seq 외에 사용할수 있는 pk값 생성하기
GUID:= global unique identified
32byte의 중복되지 않는 키값을 생성
GUID를 저장할때는 데이터 형식을 nvarchar2(125) 이상으로 지정해서 사용.
*/
insert into tbl_books(b_code,b_name)
values(sys_guid(),'guid prac');

/*
index:= 자주 select를 수행하는 칼럼이 있을경우 해담 칼럼을 index라는 object로 생성을 해 두면
해당 select를 수행할때 index를 먼저 조회하고
index로 부터 해당 데이터가 저장된 record의 주소를 얻고
주소를 통해서 table로부터 데이터를 가져와서 select 수행 속도를 높이는 기법.

PK는 자동으로 index로 설정이 됨.

많은양의 데이터를 insert할때는 index를 설정하지 말고 사용해야 한다.
index를 많이 설정하면 insert, update, delete을 수행할때 매우 비효율적으로 작동하고,
index object가 문제를 일으킨다.
*/
create index idx_name on tbl_books(b_name);
create index idx_name_writer on tbl_books(b_name,b_writer);
drop index idx_name_writer;

--index가 손상되면 drop 후 create