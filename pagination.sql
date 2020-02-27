--pagination을 위한 oracle sql
/*
MySQL: limit라는 속성으로 쉽게 구현 가능함
mssql: offset과 limit 라는 속성이 있다.

오라클은 개발자,DBA가 limit들을 수행하지 않아도 엔진자체에서 optimizer 기능이 있어서 어느정도는 자체 커버가 된다.
selectAll 을 하더라도 보통 200개 단위로 구분하여 fetch를 수행하는 기능이 담겨있다.
select * orderby를 사용할경우 상당히 무리하게 작동한다.

하지만 오라클에서는 order by와 where절을 같이 사용하지만 않으면 자체 opt 엔진이 나름대로 방법으로 정렬을 수행한다.
PK로 orderby를 수행하면 성능이 괜찬음

오라클 pagination에서는 정렬따로, where따로 만들어서 사용을 한다.
sub query를 사용하여 sql을 만든다
*/

select * from tbl_product order by p_code desc;
--오라클의 힌트라는 기능
/*
index_desc([table][index이름])
[index이름]으로 설정된 인덱스를 사용하여 내림차순 정렬한후 보여달라
first_rows := 우선적으로 앞쪽에 있는 레코드들을 먼저 보여달라
데이터가 많을때 순서가 앞에있는 레코드를 먼저찾는 옵ㅌ키마이저 알고리즘을 작동시켜라

from에 테이블대신 다른 select 쿼리를 사용한 sql 작성
from 절에 사용한 select inline view 라고 한다.

이 방식은 cursor로 구현한 pagination
*/
select /* + first_rows */ rownum,ip. * from
(
select /*+ index_desc(p) */ * from tbl_product p --inline view
)ip
where rownum<=10;

/*
first_rows:= where 절에서 rownum의 가상칼럼 값을 n이하로 설정하면
처음부터 n까지 데이터를 가져오는데 최소비용을 투입하는 알고리즘을 작동하여라
하는 의미.

first_rows 힌트는 무조건 table의 첫번째 레코드부터 최적화 알고리즘을
작동시키도록 구조가 만들어져 있어서 시작값을 where로 제한하면
first_rows는 작동하지 않는다.
9i 이하에서는 cost base로 옵티마이져 실행
10 이상에서ㅕ는 index가 없거나 레코드 개수가 현저히 적으면 오히려 옵티마이져를 하지 않은것보다 늦게 나오는 경우가 있다.

first_rows(int) 옵티마이저를 제한
10 이상에서는 first_rows_10,first_rows_100,first_rows_1000 형식으로 작성해야 좀더 효율적으로작동이 된다.

사용자에게 입력받아서 테스트하는 코드
*/
select * from
(
select /* + first_rows */ rownum as num,ip. * from
(
select /*+ index_desc(p) */ * from tbl_product p --inline view
)ip
where rownum<= &Last_No
) tbl
where num >= &First_No;