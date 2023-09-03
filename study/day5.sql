/*
    공백제거 TRIM :양쪽, LTRIM : 왼쪽, RTRIM :오른쪽 
    문자열길이 맞추기    LPAD   ; 왼쪽부터, RPAD :오른쪽 부터 
*/
SELECT LTRIM(' ABC ') 
     , RTRIM(' ABC ') 
     , TRIM(' ABC ') 
FROM dual;
-- LPAD(1, 5, '0')  -> 00001   입력이 50이면 -> 00050 
SELECT LPAD(123, 5, '0')
     , LPAD(12310, 5, '0')
     , LPAD(1, 5, '0')
     , LPAD(111111, 5, '0') -- 주의 출력이 무조건 2번째 매개변수 길이 만큼 
     , RPAD(1, 5, '+')
FROM dual;
-- ** REPLACE 
SELECT REPLACE('나는 너를 모르는데 너는 나를 알겠는가?','나는','너를') rep
     , TRANSLATE('나는 너를 모르는데 너는 나를 알겠는가?','나는','너를') trn
FROM dual;
-- LENGTH 문자열길이, LENGTHB 크기
SELECT LENGTH('대한민국')
     , LENGTHB('대한민국')  -- 한글 1글자 3byte
     , LENGTH('1234') 
     , LENGTHB('1234')     -- 영문,숫자 1byte
FROM dual;

/*날짜 함수 */
SELECT SYSDATE
     , SYSTIMESTAMP  -- 현재시간 
FROM dual;
-- ADD_MONTHS 월 + -
SELECT ADD_MONTHS(SYSDATE, 1)
     , ADD_MONTHS(SYSDATE, -1)
FROM dual;
-- LAST_DAY, NEXT_DAY
SELECT LAST_DAY(SYSDATE)
      , NEXT_DAY(SYSDATE, '금요일')
      , NEXT_DAY(SYSDATE, '토요일')
      , SYSDATE + 1  - SYSDATE   as days
      , SYSDATE - 2
FROM dual;
-- 이번달은 몇일 남았을까요?



SELECT  'd-day:' || (LAST_DAY(SYSDATE)- SYSDATE) || '일' as d_day
FROM dual;
/*  숫자함수 (매개변수 숫자형) 
    ABS :절대값
    ROUND 반올림
    TRUNC 버림 
*/
SELECT ABS(-10)
     , ABS(10)
     , ROUND(10.155, 1)
     , ROUND(10.155, 2)
     , ROUND(10.999)  -- 디폴트 o
     , TRUNC(114.999, 1) 
FROM dual;
/*  MOD(m, n) m을 n으로 나누었을때 나머지 반환 */
--  SQRT 제곱근 반환
SELECT MOD(4, 2) 
     , MOD(5, 2)
     , SQRT(4)
FROM dual;
/* 변환 TO_CAHR : 문자형으로 , TO_NUMBER :숫자형으로, TO_DATE : 날짜형으로*/
SELECT TO_CHAR(1234566, '999,999,999')
     , TO_CHAR(SYSDATE, 'YYYY-MM-DD')
     , TO_CHAR(SYSDATE, 'YYYYMMDD')
     , TO_CHAR(SYSDATE, 'YYYYMMDD HH:MI:SS')
     , TO_CHAR(SYSDATE, 'YYYYMMDD HH12:MI:SS')
     , TO_CHAR(SYSDATE, 'YYYYMMDD HH24:MI:SS')
     , TO_CHAR(SYSDATE, 'day')
     , TO_CHAR(SYSDATE, 'YYYY')
     , TO_CHAR(SYSDATE, 'dd')
     , TO_CHAR(SYSDATE, 'd')
FROM dual;

SELECT TO_DATE('230713', 'YYMMDD')
        -- TO_DATE는 날짜 데이터타입으로 형변환 
        -- 입력 포멧과 동일하게 표현해야 DATE로 바뀜 
      ,TO_DATE('2023 08 12 10:00:00', 'YYYY MM DD HH24:MI:SS') 
FROM dual;
CREATE TABLE tb_myday(
      title VARCHAR2(200)
     ,d_day DATE 
);
INSERT INTO tb_myday VALUES ('종료일', '20231226');
INSERT INTO tb_myday VALUES ('종료일', '2023.12.26');
INSERT INTO tb_myday VALUES ('종료일', '23.12.26');
INSERT INTO tb_myday VALUES ('종료일', '23|12|26');
INSERT INTO tb_myday VALUES ('종료일', '23|12|26 18');
INSERT INTO tb_myday VALUES ('종료일', TO_DATE('231226 18','YYMMDD HH24'));

CREATE TABLE ex5_1 (
     seq VARCHAR2(100)
    ,seq2 NUMBER
);
INSERT INTO ex5_1 VALUES('1234','1234');
INSERT INTO ex5_1 VALUES('99','99');
INSERT INTO ex5_1 VALUES('123456','123456');
DESC ex5_1;
SELECT *
FROM ex5_1
ORDER by TO_NUMBER(seq) desc;

SELECT *
FROM students;
-- students 테이블을 활용하여 '학번','학생이름','나이'를 출력하시오 
--
SELECT stu_id, stu_name, TO_DATE(stu_birth,'RRMMDD') 
      ,stu_birth
FROM students;



desc customers;
SELECT cust_name, cust_year_of_birth
     , TO_CHAR(SYSDATE, 'YYYY') - cust_year_of_birth as 나이
FROM customers
ORDER BY 나이 asc;

-- 입력된 두자리 연도 값이 50 ~ 이상이면 20세기로 해서 
--                      49 이하면 21 세기로 해석. 
SELECT stu_name, TO_DATE(stu_birth,'YYMMDD')
     , TO_CHAR(TO_DATE(stu_birth,'YYMMDD'),'YYYY')
     , TO_DATE(stu_birth, 'RRMMDD')
     , TO_CHAR(TO_DATE(stu_birth, 'RRMMDD'),'YYYY')
FROM students;

-- employees 의 hire_date 컬럼을 활용하여 근속 년수를 출력하시오 
-- 근속연수 내림차순, 이름 오름차순

SELECT emp_name     
     , hire_date
     , TO_CHAR(hire_date,'YYYY') as 입사년도
     , TO_CHAR(SYSDATE,'YYYY') - TO_CHAR(hire_date,'YYYY') as 근속연수
     , SYSDATE - hire_date
FROM employees
ORDER BY 근속연수 desc , 1;

-- null관련
--** NVL(null, 변환값)
SELECT emp_name, salary, commission_pct
     , salary * NVL(commission_pct,0)  
FROM employees;
-- DECODE 변환 (case와 유사함)
SELECT cust_id, cust_name
      --      대상건     ,값, 같으면, 그밖에)
     , DECODE(cust_gender,'M','남자','여자') as gender
       --      대상건     ,값, 같으면, 값2, 같으면, '그밖에'
     , DECODE(cust_gender,'M','남자','F','여자','??') as gender2
FROM customers;
/*
 고객 테이블(CUSTOMERS)에는 
 고객의 출생년도(cust_year_of_birth) 컬럼이 있다. 
 현재일 기준으로 이 컬럼을 활용해 30대, 40대, 50대를 구분해 출력하고, 
 나머지 연령대는 '기타'로 출력하는 쿼리를 작성해보자. 
 */
 
 
 SELECT count(*)
 FROM customers;
