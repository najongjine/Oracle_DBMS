--Master Detail Table 관계설정

create table tbl_master(
m_seq number primary key,
m_subject NVARCHAR2(1000) not null
);

create table tbl_detail(
d_seq number primary key,
d_m_seq number not null,
d_subject nvarchar2(1000) not null,
d_ok varchar2(1) default 'n'
);
commit;
create sequence seq_master
start with 1 increment by 1;
create sequence seq_detail
start with 1 increment by 1;

alter table tbl_detail add CONSTRAINT FK_MD
FOREIGN key (d_m_seq) REFERENCES tbl_master(m_seq);

insert into tbl_master(m_seq,m_subject)
values(seq_master.nextval,'다음중 OSI 7계층중 가장 하위 계층으로 맞는것은?');

insert into tbl_detail(d_seq,d_m_seq,d_subject)
values(seq_detail.nextval,1,'전송계층');
insert into tbl_detail(d_seq,d_m_seq,d_subject)
values(seq_detail.nextval,1,'세션계층');
insert into tbl_detail(d_seq,d_m_seq,d_subject,d_ok)
values(seq_detail.nextval,1,'물리계층','y');
insert into tbl_detail(d_seq,d_m_seq,d_subject)
values(seq_detail.nextval,1,'네트워크계층');

insert into tbl_master(m_seq,m_subject)
values(seq_master.nextval,'다음중 사용자의 데이터가 저장되는 메모리는?');
insert into tbl_detail(d_seq,d_m_seq,d_subject)
values(seq_detail.nextval,1,'Rom');
insert into tbl_detail(d_seq,d_m_seq,d_subject,d_ok)
values(seq_detail.nextval,1,'RAM','Y');
insert into tbl_detail(d_seq,d_m_seq,d_subject)
values(seq_detail.nextval,1,'Cache');
insert into tbl_detail(d_seq,d_m_seq,d_subject)
values(seq_detail.nextval,1,'Register');

select * from tbl_master,tbl_detail
where m_seq=d_m_seq;