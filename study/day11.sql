SELECT department_id
       -- level 가상열로서 트리 내에서 어떤 단계인지 나타내는 정수값
     , LPAD(' ', 3 * (level-1)) || department_name as 부서명
--     , parent_id
     , level
FROM departments
START WITH parent_id IS NULL                -- 시작 
CONNECT BY PRIOR department_id = parent_id  -- 계층을 어떻게 연결할지(조건)
;
-- departments 테이블에 230 IT헬프데스크 하위 부서로 
--                     280 IT원격팀을 삽입해주세요 ^^




SELECT MAX(department_id)+10
FROM departments;

INSERT INTO departments (department_id, department_name, parent_id)
VALUES (280, 'IT원격팀', 230);


commit;


/*계층형 쿼리에서 정렬을 하려면 SIBLINGS BY를 추가해야함.*/
SELECT department_id
     , LPAD(' ', 3 * (level-1)) || department_name as 부서명
     , parent_id
     , level
FROM departments
START WITH parent_id IS NULL                -- 시작 
CONNECT BY PRIOR department_id = parent_id
ORDER SIBLINGS BY department_name; -- SIBLINGS 사용시에는 실제 컬럼으로만 정렬가능

-- 계층형쿼리 관련 함수 
SELECT department_id
 , LPAD(' ', 3 * (level-1)) || department_name as 부서명
 , level 
 , CONNECT_BY_ISLEAF  -- 마지막노드면1, 자식이 있으면0
 , SYS_CONNECT_BY_PATH(department_name, '>')-- 루트 노드에서 자신행까지 연결정보
 , CONNECT_BY_ISCYCLE  -- 무한루프의 원인을 찾을때
 -- (자식이 있는데 그자식 로우가 부모이면 1, 아니면 0 
FROM departments
START WITH parent_id IS NULL                -- 시작 
CONNECT BY NOCYCLE PRIOR department_id = parent_id
;
-- 무한루프걸리도록 수정
UPDATE departments
SET parent_id = 10
WHERE department_id = 30; 



SELECT department_id
 , LPAD(' ', 3 * (level-1)) || department_name as 부서명
 , level 
 , CONNECT_BY_ISCYCLE 
FROM departments
START WITH parent_id = 30                -- 시작 
CONNECT BY NOCYCLE PRIOR department_id = parent_id
;




SELECT employee_id
     , emp_name
     , manager_id
FROM employees
WHERE manager_id IS NULL;   

-- 직원간의 계층관계를 출력하시오 (정렬 직원명 이름 오름차순)
SELECT employee_id
 , LPAD(' ', 3 * (level-1)) || emp_name as 직원명
 , SYS_CONNECT_BY_PATH(emp_name, '>') as 관리관계
FROM employees
START WITH manager_id IS NULL                -- 시작 
CONNECT BY PRIOR employee_id = manager_id
ORDER SIBLINGS BY emp_name 
;
/*
테이블을 생성,데이터 인서트 후 출력하시오 
이사장	사장	                    1
김부장	   부장	                2
서차장	      차장	            3
장과장	         과장	        4
이대리	            대리	        5
최사원	               사원	    6
강사원	               사원	    6
박과장	         과장	        4
김대리	            대리	        5
주사원	               사원	    6
*/
create table 팀 (
  아이디 number
 ,이름 varchar2(10)
 ,직책 varchar2(10)
 ,상위아이디 number
);

insert into 팀 values(1,'이사장', '사장', null);
insert into 팀 values(2,'김부장', '부장',1);
insert into 팀 values(3,'서차장', '차장',2);
insert into 팀 values(4,'장과장', '과장',3);
insert into 팀 values(5,'박과장', '과장',3);
insert into 팀 values(6,'이대리', '대리',4);
insert into 팀 values(7,'김대리', '대리',5);
insert into 팀 values(8,'최사원', '사원',6);
insert into 팀 values(9,'강사원', '사원',6);
insert into 팀 values(10,'주사원', '사원',7);

commit;


SELECT 
       이름
     , LPAD(' ' , 3 * (LEVEL-1)) || 직책 as 직책
     , LEVEL
     , 아이디
     , 상위아이디
  FROM 팀
  START WITH 상위아이디 IS NULL                  --< 이조건에 맞는 로우부터 시작함.
  CONNECT BY PRIOR 아이디  = 상위아이디; 
  
  
  
SELECT period 
    ,  sum(loan_jan_amt) as 대출합계
FROM kor_loan_status
WHERE substr(period, 1, 4) = 2013
GROUP BY period;
/*  level은 가상-열로서 (connect by 절과 함께 사용)
    임의의 데이터가 필요할때 많이사용.
*/
-- 2013년 1 ~12월 데이터
SELECT  '2013' || LPAD(LEVEL,2,'0') as 년월
FROM dual
CONNECT BY LEVEL <=12;

SELECT a.년월 
     , NVL(b.대출합계,0) as 대출합계
FROM (SELECT  '2013' || LPAD(LEVEL,2,'0') as 년월
        FROM dual
        CONNECT BY LEVEL <=12
      ) a
    , (SELECT   period  as 년월
            ,  sum(loan_jan_amt) as 대출합계
        FROM kor_loan_status
        WHERE substr(period, 1, 4) = 2013
        GROUP BY period
     ) b
WHERE a.년월 = b.년월(+)
ORDER BY 1;

-- 202301~202312 

SELECT TO_CHAR(SYSDATE,'YYYY')||LPAD(LEVEL, 2, '0') AS YEAR 
FROM DUAL CONNECT BY LEVEL <= 12;
-- 이번달 1일부터 마지막날까지 출력
-- (단 해당 select문을 다음달에 실행시 해당월의 마지막날까지 출력되도록)
-- 20230801
-- 20230802
-- 20230803
-- ...
-- 20230831

SELECT TO_CHAR(SYSDATE,'YYYYMM') || LPAD(LEVEL,2,'0') as 년월일
  FROM DUAL
CONNECT BY LEVEL <= (SELECT TO_CHAR(LAST_DAY(sysdate),'DD')
                     FROM dual)
;
  
  
SELECT distinct to_char(mem_bir,'MM')
FROM member;

SELECT to_char(mem_bir,'MM') as 월
     , count(*)              as 회원수
FROM member
GROUP BY to_char(mem_bir,'MM') 
ORDER BY 1;

SELECT LPAD(level,2,'0') as 월
FROM dual
CONNECT BY LEVEL <=12;

-- member 회원의 생일(mem_bir) 의 월별 회원수를 출력하시오 (모든월이 나오도록)

SELECT a.월 || '월'   as 생일_월
     , NVL(b.회원수,0) as 회원수
FROM (SELECT LPAD(level,2,'0') as 월
        FROM dual
        CONNECT BY LEVEL <=12)a
   , (SELECT to_char(mem_bir,'MM') as 월
             , count(*)              as 회원수
        FROM member
        GROUP BY to_char(mem_bir,'MM') 
        ORDER BY 1)b
WHERE a.월 = b.월(+)
UNION 
SELECT '합계'
     , COUNT(*) 
FROM member;
ORDER BY a.월;
  
  