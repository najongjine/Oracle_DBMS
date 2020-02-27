create table tbl_bloodTest(
bld_seq number primary key,
bld_name NVARCHAR2(50) not null,
bld_normalMin number ,
bld_normalMax number ,
bld_overNormal NVARCHAR2(1000),
bld_belowNormal NVARCHAR2(1000)
);
drop table tbl_bloodTest;

create table tbl_simpleDiagnosis(
sdg_seq number primary key,
sdg_imgURL NVARCHAR2(1000),
sdg_name NVARCHAR2(1000),
sdg_explanation NVARCHAR2(1000)
);
drop table tbl_simpleDiagnosis;

create SEQUENCE seq_bloodtest
start with 1 INCREMENT by 1;

create SEQUENCE seq_simpleDiagnosis
start with 1 INCREMENT by 1;

insert into tbl_bloodtest(BLD_SEQ,
BLD_NAME,
BLD_NORMALMIN,
BLD_NORMALMAX,
BLD_OVERNORMAL,
BLD_BELOWNORMAL) values(
seq_bloodtest.nextval,
'RBC',
5.5,
8.5,
'증가 : 탈수, 심폐질환, 다혈구혈증, 쇼크, 신장암, 구토, 설사등 의심',
'감소는 실혈성 빈혈, 용혈 (약물, 신수종, 양파등) 적혈구 생산불량, 골수억제 의심'
);

insert into tbl_bloodtest(BLD_SEQ,
BLD_NAME,
BLD_NORMALMIN,
BLD_NORMALMAX,
BLD_OVERNORMAL,
BLD_BELOWNORMAL) values(
seq_bloodtest.nextval,
'Hemoglobin(HB)',
12,
18,
'적혈구의 산소 운반능력 판정 낮으면 산소를 제대로 운반하지 못하게 됨.',
'감소: 빈혈, 출혈, 철 결핍 의미'
);

insert into tbl_bloodtest(BLD_SEQ,
BLD_NAME,
BLD_NORMALMIN,
BLD_NORMALMAX,
BLD_OVERNORMAL,
BLD_BELOWNORMAL) values(
seq_bloodtest.nextval,
'Hematocrit(Hct)',
37,
55,
'감소: 탈수 판정 /25%이하면 심각한 빈혈- 수혈필요',
null
);

insert into tbl_bloodtest(BLD_SEQ,
BLD_NAME,
BLD_NORMALMIN,
BLD_NORMALMAX,
BLD_OVERNORMAL,
BLD_BELOWNORMAL) values(
seq_bloodtest.nextval,
'Platelet',
200,
500,
'혈소판의 개수가 적으면 지혈작용에 문제가 있다. - 잦은출혈',
null
);

insert into tbl_bloodtest(BLD_SEQ,
BLD_NAME,
BLD_NORMALMIN,
BLD_NORMALMAX,
BLD_OVERNORMAL,
BLD_BELOWNORMAL) values(
seq_bloodtest.nextval,
'MPV',
6.7,
11.1,
'증가 : 혈소판 파괴 – 염증성 잘 질환, 백혈병, 골수',
'감소: 재생불량성 빈혈, 혈소판 수치가 정상이면서 MPV가 낮은 경우는 만성신부전증일 경우가 있다.'
);