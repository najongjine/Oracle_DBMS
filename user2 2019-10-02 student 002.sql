--
create table tbl_student(

    st_num	VARCHAR2(5)	NOT NULL	PRIMARY KEY,
    st_name	nVARCHAR2(30)	NOT NULL,
    st_addr	nVARCHAR2(125),
    st_grade	NUMBER(1),
    st_height	NUMBER(3),
    st_weight	NUMBER(3),
    st_nick	nVARCHAR2(20),
    st_nick_rem	nVARCHAR2(50)	,	
    st_dep_no	VARCHAR(3)	NOT NULL
);

insert into tbl_student(st_num,st_name,st_dep_no,st_grade)
values('A0001','홍길동','001',1);
insert into tbl_student(st_num,st_name,st_dep_no,st_grade)
values('A0002','이몽룡','001',3);
insert into tbl_student(st_num,st_name,st_dep_no,st_grade)
values('A0003','성춘향','002',2);
insert into tbl_student(st_num,st_name,st_dep_no,st_grade)
values('A0004','임꺽정','003',4);
insert into tbl_student(st_num,st_name,st_dep_no,st_grade)
values('A0005','장보고','003',3);
insert into tbl_student(st_num,st_name,st_grade,st_dep_no)
values('A0006','성춘향',2,'001');

select * from tbl_student order by st_name;
select * from tbl_student where st_num between 'A0002' and 'A0004';
select * from tbl_student where st_grade=2;
select * from tbl_student where st_num between 'A0002' and 'A0004' order by st_name;
select * from tbl_student where st_num between 'A0002' and 'A0004' order by st_grade DESC;
select max(st_height) from tbl_student;

update tbl_student set st_addr='광주광역시' where st_num='A0003';
update tbl_student set st_addr='익산시' where st_num='A0002';
update tbl_student set st_addr='서울특별시' where st_num='A0001';
commit;
--RecordSet | ResultSet:= select명령이 실행된후 보여지는 리스트.