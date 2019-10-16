--EQ Join | Inner Join. Cartesian Product.
-- 두 테이블간에 완전 참조 무결성이 보장되는 경우
--왼쪽기준으로 오른쪽 테이블 참조.
select * from tbl_books B, tbl_genre G
where b.b_genre=g.g_code;

--EQ Join의 경우 두 테이블이 완전 참조 무결성 조건에 위배되는 경우 결과가 신뢰성을 잃는다.
/*
참조 무결성
--------------------------------------------------
원본Table(칼럼값)        =          참조Table(칼럼값)
------------------------------------------------
값이 있다              >>          반드시 있다
있을수도 있다           <<              있다
절대 있을수 없다        <<            없다
-------------------------------------------------

참조 무결성 조건은 테이블간에 EQ Join 실행했을때결과에 신뢰성을 보장하는 조건.
*/

--두 테이블간에 참조 무결성을 무시하고 JOIN 실행하기
--새로운 도서가 입고 되었는데 그동안 사용하던 장르와 완전 다른 분야이다.
--그래서 새로운 장르코드를 생성해서 010 이라고 사용하기로 결정을했다.
insert into tbl_books(b_isbn,b_title,b_comp,b_writer,b_genre)
values('979-009','아침형인간','하늘소식','이몽룡','010');
--만약 tbl_books 테이블하고, tbl_genre 테이블간에 참조무결성 조건을 설정해 두었더라면
--tbl_books 테이블에는 insert 를 수행하지 못한다.
--하지만, 아직 참조무결성 조건을 설정하지 않았기 때문에 insert가 가능하다.
--EQ Join으로 확인해보면 도서 리스트가 누락되어 출력되고, 신뢰성을 잃었다.

--left join
--left에 있는 table의 리스트는 모두 보여주고
--On 조건에 일치하는 값이 오른쪽 table에 있으면 값을 보이고,
--그렇지 않으면 null로 표현하라.
select * from tbl_books B
left join tbl_genre G
on B.b_genre=g.g_code order by b.b_isbn;

--tbl_books 테이블의 b_title 칼럼의 값이 '아침형인간'인 리스트를 보이되
--만약 b_genre 칼럼값과 일치하는 값이 tbl_genre의 g_code칼럼에 있으면
--리스트를 보여주고 그렇기 않으면 null이라고 표현하라.
select * from tbl_books B
left join tbl_genre G
on B.b_genre=g.g_code
where B.b_title='아침형인간';

select b.b_isbn,b.b_title,b.b_comp,b.b_writer,g.g_name from tbl_books B left join tbl_genre G
on B.b_genre=G.g_code
where b.b_title like 'SQL%' order by b.b_title;

select b.b_isbn,b.b_title,b.b_comp,b.b_writer,g.g_name from tbl_books B left join tbl_genre G
on B.b_genre=G.g_code
where g.g_name='장편소설';

update tbl_genre set g_name='장르 소설'
where g_code='003';

--tbl_books 리스트를 조회했더니 '장편소설인 장르 데이터가 3개가 있다.
--만약 tbl_books 테이블에 장르 칼럼을 이름으로 설정을 했더라면
--다음과 같은 update문을 실행해야할 것이다.
update tbl_books set b_genre='장르소설'
where b_genre='장편소설';
--이 update명령문은 위험함. 2개 이상의 레코드가 변경될수 있기 때문이다.
--이러한 이유로 테이블을 분리하고, 두 테이블을 Join하는 과정을 수행한다.
--001개의 테이블에 존재하는 데이터를 다수(2개)의 테이블로 분리하고
--Join을 수행할수 있도록 구조를 변결하는 작업을 데이터베이스 '제2정규화'라고 한다.