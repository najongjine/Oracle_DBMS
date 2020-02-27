/*
두 테이블이 FK로 참조관계가 설정되어 있기 때문에 EQ Join을 사용할수 있다.
*/
select 
RB_SEQ,
RB_MID,
RB_BCODE,
b_name as rb_bname,
RB_DATE,
RB_STIME,
RB_RTIME,
RB_SUBJECT,
RB_TEXT,
RB_STAR
from tbl_read_book R,tbl_books B
where r.rb_bcode=b.b_code
;