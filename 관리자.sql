--remark

--문자열이나 특수 데이터는 대소문자를 구별하는 경우도 있다. 이때는 대소문자 구분을 공지한다.
SELECT 30+40 FROM dual;
SELECT 30+40, 30*40, 40/2, 50-10 FROM dual;

SELECT '대한민국' FROM dual;

--|| 문자열 연결하기
SELECT '대한'||'민국' FROM dual;
SELECT '대한','민국','만세','KOREA' FROM dual;

SELECT * FROM dual;
SELECT * FROM v$database;