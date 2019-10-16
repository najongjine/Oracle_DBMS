select * from tbl_address;
select * from tbl_address where address is null;
insert into tbl_address(id,name,tel,address,chain,age)
values(6,'장보고','010-123-1234','부산','101',19);

update tbl_address set age=33
where id=3;

update tbl_address set age=0
where id=4;

update tbl_address set chain='001'
where id=1;
update tbl_address set chain='001'
where id=2;
update tbl_address set chain='002'
where id=3;
update tbl_address set chain='003'
where id=4;
update tbl_address set chain='003'
where id=5;

select id,name,address, chain,
decode(chain,'001','가족',decode(chain,'002','친구',decode(chain,'003','이웃'))) from tbl_address;

select id,name,address, chain,
decode(chain,'001','가족',decode(chain,'002','친구',decode(chain,'003','이웃'))) as 관계 from tbl_address
where 
decode(chain,'001','가족',decode(chain,'002','친구',decode(chain,'003','이웃'))) is null;

select id,name,address,chain,birth,age
from tbl_address;

insert into tbl_address(id,name,tel)
values(8,'양희은','010-611-6235');

select * from tbl_address order by id ASC;
select * from tbl_address order by name, address;
select * from tbl_address order by name DESC, address;
commit;
--리스트=레코드=row