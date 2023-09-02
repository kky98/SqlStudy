/*  TABLE 수정 ALTER
*/
CREATE TABLE ex4_1(
        irum VARCHAR2(100) NOT NULL
      , point NUMBER(5)
      , gender CHAR(1)
      , reg_date DATE
);
DESC ex4_1;
-- 컬럼명 수정 
ALTER TABLE ex4_1 RENAME COLUMN irum TO nm;
-- 타입 수정 (타입 수정시 테이블에 데이터가 있다면 주의해야함)
ALTER TABLE ex4_1 MODIFY point NUMBER(10) ;
-- 제약조건 추가 
ALTER TABLE ex4_1 ADD CONSTRAINT pk_ex4 PRIMARY KEY(nm);
-- 컬럼 추가 
ALTER TABLE ex4_1 ADD hp VARCHAR2(20); 
-- 컬럼 삭제 
ALTER TABLE ex4_1 DROP COLUMN hp;

-------------테이블 comment 
COMMENT ON TABLE tb_info IS '우리반';
COMMENT ON COLUMN tb_info.info_no IS '출석번호' ;
COMMENT ON COLUMN tb_info.pc_no IS '컴퓨터번호' ;
COMMENT ON COLUMN tb_info.nm IS '이름' ;
COMMENT ON COLUMN tb_info.email IS '이메일' ;
COMMENT ON COLUMN tb_info.hobby IS '취미' ;
COMMENT ON COLUMN tb_info.mbti IS '브릭스유형지표' ;

SELECT *
FROM all_tab_comments  -- 테이블 코멘트 
WHERE OWNER ='JAVA';
SELECT *
FROM all_col_comments
WHERE comments LIKE '%이름%' ;
--WHERE comments LIKE '%이름%';
/* INSERT 데이터 삽입 (DML문)
   1.기본형태 컬럼명 기술 
*/
CREATE TABLE ex4_2(
    val1 VARCHAR2(10)
   ,val2 NUMBER
   ,val3 DATE
);
-- 입력 컬럼을 다 작성 
INSERT INTO ex4_2(val1 , val2, val3)
VALUES ('hi', 10, SYSDATE);  -- 문자열 '' number타입은 숫자
INSERT INTO ex4_2(val3, val2)
VALUES (SYSDATE, 10);        -- 위에 작성한 컬럼 순서대로 
                             -- value도 INSERT 
SELECT * FROM ex4_2;
-- 테이블 전체에 대해 데이터를 삽입할때는 컬럼명 안써도 됨.
INSERT INTO ex4_2
VALUES ('hello', 20, SYSDATE);
INSERT INTO ex4_2
VALUES ( 20, SYSDATE); -- 오류 
CREATE TABLE ex4_3(
    emp_id NUMBER
   ,emp_name VARCHAR2(1000)
);
-- SELECT ~ INSERT 
INSERT INTO ex4_3(emp_id, emp_name)
SELECT employee_id
     , emp_name
FROM employees
WHERE salary > 5000;
SELECT * FROM ex4_3;
-- 테이블 복사 
CREATE TABLE ex4_4 AS 
SELECT nm, email
FROM tb_info
;
SELECT * 
FROM ex4_4;
/* UPDATE 데이터 수정 */
SELECT *
FROM tb_info;

UPDATE tb_info
SET hobby ='공부'
  , email = 'abc@gmail.com'
WHERE INFO_NO =1;

-- 192.168.0.41
SELECT *
FROM tb_info;
/* DELETE 데이터 삭제 */
SELECT *
FROM ex4_4;
DELETE ex4_4 ;  -- 전체 삭제 

DELETE ex4_4
WHERE nm ='예준서';

-- 중복제거 데이터 보기 
SELECT DISTINCT prod_category
FROM products;
-- 의사컬럼 (테이블에는 없지만 있는것 처럼 사용)
SELECT  ROWNUM    
      , emp_name
      , email
FROM employees
WHERE ROWNUM <= 5;
-- NULL  (IS NULL or IS NOT NULL)
SELECT *
FROM employees
--WHERE manager_id = NULL; -- 
WHERE manager_id IS NULL;

SELECT *
FROM departments
WHERE department_id IN (30, 60);
SELECT *
FROM departments
WHERE department_id NOT IN (30, 60);

SELECT nm 
     , mbti
     ,INSTR(mbti,'E')
     , CASE WHEN INSTR(mbti,'E') = 1 THEN '외향형'
            ELSE '내향형'
       END as 에너지방향
FROM tb_info
;
/*
  oracle 데이터베이스 내장함수 
  문자관련 
*/
SELECT LOWER('I like mac') as lowers
     , UPPER('I like mac') as uppers
     , INITCAP('I like mac') as initcaps  -- 단어 첫글짜 대문자
FROM dual;  -- 임시테이블 

SELECT *
FROM employees
WHERE UPPER(emp_name) LIKE '%'||UPPER('donald')||'%';

-- SUBSTR (char, pos, len) 대상문자열 char의 pos 번째부터 
-- len 길이 만큼 자른뒤 반환 
-- pos 값으로 0 이오면 디폴트 값 1 즉 첫번째 문자열
-- 음수가 오면 문자열의 맨 끝에서 시작한 상대적 위치 
-- len 값이 생략되면 pos 번째 문자부터 나머지 모든 문자를 반환 
SELECT SUBSTR('ABCD EFG',1, 4)
     , SUBSTR('ABCD EFG',-3, 3)
     , SUBSTR('ABCD EFG',-3, 1)
     , SUBSTR('ABCD EFG',5)
FROM dual;
/*INSTR 대상 문자열에서 찾을 문자열의 위치*/
SELECT INSTR('내가 만약 외로울 때면, 내가 만약 괴로울 때면','만약') --디폴트 1,1
     , INSTR('내가 만약 외로울 때면, 내가 만약 괴로울 때면','만약',5)
     , INSTR('내가 만약 외로울 때면, 내가 만약 괴로울 때면','만약',1,2)
     , INSTR('내가 만약 외로울 때면, 내가 만약 괴로울 때면','나') -- 없으면 0 
FROM dual;

-- 고객의 이메일 주소의 이름과 도메인을 분리하여 출력하시오 
-- ex leeapgil@gmail.com -> id : leeapgil, domain:gmail.com

SELECT cust_name
     , cust_email
     , SUBSTR(cust_email, 1, INSTR(cust_email, '@') -1 )  as id
     , SUBSTR(cust_email,  INSTR(cust_email, '@') + 1) as domain
FROM customers; 



select cust_id
     , cust_name
     , cust_email
     , SUBSTR(cust_email, 1 ,INSTR(cust_email,'@')-1) as id
     , SUBSTR(cust_email, INSTR(cust_email,'@')+1) as domain
FROM customers;







SELECT  nm
      , mbti
      , CASE WHEN INSTR(mbti,'E') = 0 THEN '내향형' 
        ELSE '외향형'
        END as 에너지방향
     , CASE WHEN SUBSTR(mbti,2,1) = 'N' THEN '직관형' 
       ELSE '감각형'
       END as 인식방식
     , CASE WHEN mbti LIKE '%T%' THEN '사고형' 
       ELSE '감정형'
       END as 판단형
     , CASE WHEN INSTR(mbti,'J') = 0 THEN '자율형' 
       ELSE '계획형'
       END as 생활양식
FROM tb_info;


























