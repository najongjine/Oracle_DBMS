create table tbl_cbt(
cb_seq	NUMBER		PRIMARY key,
cb_question	nVARCHAR2(125)	NOT NULL	,
cb_answer1	nVARCHAR2(50)	NOT NULL	,
cb_answer2	nVARCHAR2(50)	NOT NULL	,
cb_answer3	nVARCHAR2(50)	NOT NULL,	
cb_answer4	nVARCHAR2(50)	NOT NULL,	
cb_correct_answer nVARCHAR2(50)	NOT NULL	
);
commit;
