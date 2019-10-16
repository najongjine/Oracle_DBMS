--git hub에 프로잭트를 업로드할때 
--불필요한 파일, 비밀번호가 입력된 파일등
--업로드를 하지 않아야 될 파일들은
--git 폴더에 .gitignore 파일을 만들고 ($ vi .gitignore)
--파일의 이름, 폴더 이름들을 기록해 주면 된다.
--data/라고 기록하면 git폴더아래에 data폴더의 모든 파일을 업로드 되지 않는다.
--단, 최초에 프로젝트를 올릴때 .gitignore를 먼저 설정해 두어야 한다.
select * from tbl_student;
delete from tbl_student;

insert into tbl_student(st_num, st_name, st_addr, st_tel)
values('A0001','홍길동','서울특별시', '010-111-1111');
insert into tbl_student(st_num, st_name, st_addr, st_tel)
values('A0002','이몽룡','익산시', '010-211-1111');
insert into tbl_student(st_num, st_name, st_addr, st_tel)
values('A0003','성춘향','남원시', '010-311-1111');
insert into tbl_student(st_num, st_name, st_addr, st_tel)
values('A0004','장길산','부산시', '010-411-1111');
insert into tbl_student(st_num, st_name, st_addr, st_tel)
values('A0005','장보고','춘천시', '010-111-2111');
insert into tbl_student(st_num, st_name, st_addr, st_tel)
values('A0005','임꺽정','춘천시', '010-111-2111');

insert into tbl_student(st_num, st_name, st_addr, st_tel)
values('A0007','홍길동','부산광역시', '010-111-1111');

--DBMS의 임시저장소에 있는걸들을 실제 storage에 저장.
commit;

select st_num,st_name,st_tel 
from tbl_student;

--standard SQL
select st_num as 학번, st_name as 이름, st_tel as 전화번호, st_addr as 주소 from tbl_student;

--Oracle SQL
select st_num 학번, st_name 이름, st_tel 전화번호, st_addr 주소 from tbl_student;

select * from tbl_student where st_name='홍길동';
select st_num, st_name, st_tel from tbl_student where st_name='홍길동';
SELECT * FROM tbl_student where st_name='홍길동' AND st_addr='서울특별시';

select * from tbl_student where st_name='홍길동' OR st_addr='서울';


--칼럼들을 연결해서 한개의 문자열처럼 리스트를 보는 방법
select st_num || '+' || st_name || '+' || st_tel as 
from tbl_student;

select st_num || ' ' || st_name || ':' || st_tel as 
from tbl_student;

--중간문자열 검색. LIKE 키워드는 속도면에서 문제가 있음
select * from tbl_student where st_addr LIKE '서울%';
select * from tbl_student where st_addr LIKE '%시';

select * from tbl_student where st_tel>='010-111-0000' and st_tel<='010-333-9999';
select * from tbl_student where st_num >='A0003' and st_num<='A0006';
select * from tbl_student where st_num between 'A0003' and 'A0006';
select * from tbl_student where st_addr in('익산시','남원시','해남군');

--개체무결성: PK로 설정된 칼럼을 조건으로 하여 데이터를 조회하면 
--table에 데이터가 얼마가 저장되어있던 상관 없이 출력되는 리스트는 1개 이거나 없다.