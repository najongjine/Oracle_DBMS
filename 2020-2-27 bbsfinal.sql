create SEQUENCE seq_bbs
start with 1 increment by 1;

/*
오라클에는 *LOB 형태의 칼럼타입이 있다
CLOB: 대용량 문자열을 저장하는 칼럼
BLOB: 대용량의 바이너리 타입을 저장하는 칼럼 최대 4GB
BFILE: 대용량의 바이너리 파일데이터를 인코딩하여 저장 4GB
*/
alter table tbl_bbs drop COLUMN b_content;

-- varhcar2를 clob로 변경하고자 할때
-- 1 새로운 임시 칼럼을 만들고
alter table tbl_bbs add(b_content CLOB);

-- 2. 기존 칼럼 데이터를 새로만든
update tbl_bbs set b_contentb=b_content;

-- 3.기존 칼럼을 삭제하고
alter table tbl_bbs drop column b_content;

-- 4. 새로만든 임시 칼럼을 기존 칼럼 이름으로 변경
alter table tbl_bbs rename COLUMN b_content_b to b_content;

alter table tbl_bbs MODIFY(b_content CLOB);