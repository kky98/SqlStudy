SELECT *
FROM employees;

SELECT *
FROM departments;
-- inner join 내부조인(동등조인이라고도 함) 
-- 각 컬럼에 동일한 값이 있을때 결합 
SELECT employees.emp_name
     , departments.department_name
FROM employees, departments
WHERE employees.department_id = departments.department_id;

-- 테이블 별칭 
SELECT emp_name        -- 어느한쪽에만 있는 컬럼은 별칭 안써도됨
     , department_name
     , a.department_id  -- 동일한 컬럼명이 있을때는 어느 한쪽을 표시해야함.
FROM employees a, departments b 
WHERE a.department_id = b.department_id;

SELECT *
FROM member;
SELECT *
FROM cart;

-- member 김은대씨의 카트(구매이력)이력을 출력하시오 
SELECT member.mem_name
     , cart.cart_no
     , cart.cart_prod
     , cart.cart_qty
FROM member, cart
WHERE  member.mem_id = cart.cart_member
AND member.mem_name ='김은대';
/* ANSI JOIN : American National Standards Institute
               미국 표준 SQL 문법형태 (구문이 길어서 실무에서 잘 안씀)
*/
SELECT member.mem_name
     , cart.cart_no
     , cart.cart_prod
     , cart.cart_qty
FROM member 
INNER JOIN cart
ON(member.mem_id = cart.cart_member)
WHERE member.mem_name = '김은대';
-- 상품 정보 출력 
SELECT member.mem_name, member.mem_id, cart.cart_member
     , cart.cart_no
     , cart.cart_prod , prod.prod_id
     , cart.cart_qty
     , prod.prod_name 
     , prod.prod_sale
FROM member, cart, prod
WHERE  member.mem_id = cart.cart_member
AND    cart.cart_prod = prod.prod_id
AND member.mem_name ='김은대';

-- 김은대씨가 구매한 전체 상품의 합계 금액은? 
-- cart cart_qty  <-- 상품 구매 수량 
-- prod prod_sale <-- 상품 판매가격    
SELECT member.mem_name
     , member.mem_id
     , SUM(cart.cart_qty *  prod.prod_sale ) as 합계금액
FROM member, cart, prod
WHERE  member.mem_id = cart.cart_member
AND    cart.cart_prod = prod.prod_id
AND member.mem_name ='김은대'
GROUP BY member.mem_name, member.mem_id;


SELECT member.mem_name
     , member.mem_id
     , SUM(cart.cart_qty *  prod.prod_sale ) as 합계금액
FROM member INNER JOIN cart
ON (member.mem_id = cart.cart_member)
INNER JOIN prod
ON (cart.cart_prod = prod.prod_id)
WHERE member.mem_name ='김은대'
GROUP BY member.mem_name, member.mem_id;
-- employees, jobs 테이블을 활용하여 
-- salary가 15000 이상인 직원의 사번, 이름, salary, 직업 아이디, 직업명을 출력하시오 
SELECT employee_id, emp_name, salary, job_id
FROM employees;
SELECT job_id, job_title
FROM jobs;

SELECT a.employee_id   /*사번*/
     , a.emp_name      /*이름*/
     , a.salary        /*봉급*/
     , b.job_title     /*직업명*/
FROM employees a       --직원테이블
   , jobs b            --직업테이블
WHERE a.job_id = b.job_id
AND   a.salary >= 15000;



SELECT employees.employee_id
     , employees.emp_name
     , employees.salary
     , jobs.job_id
     , jobs.job_title
FROM employees, jobs
WHERE employees.job_id = jobs.job_id
AND  employees.salary >= 15000;

/* 서브쿼리 (쿼리안에 쿼리)
   1.스칼라 서브쿼리 (select 절)
   2.인라인 뷰 (from절)
   3.중첩 쿼리 (where절)
*/
-- 스칼라 서브쿼리는 단일행 반환
-- 보통 코드값에 이름을 가져올때 많이 사용 
-- 주의할점은 메인쿼리테이블의 행 건수 만큼 서브쿼리를 조회하기 때문에 
-- 서브쿼리의 테이블의 건수가 많으면 자원을 많이 사용하게됨.
-- (위와 같은 경우 조인을 이용하는게 더 좋음)
SELECT a.emp_name
     , (SELECT department_name 
        FROM departments
        WHERE department_id = a.department_id) as dep_name
     , a.job_id
     , (SELECT job_title
        FROM jobs
        WHERE job_id = a.job_id) as job_name
FROM employees a;
-- 중첩서브쿼리 
-- 전체 직원의 봉급평균 보다 봉급이 큰 직원만 출력하시오 
SELECT emp_name
     , salary
FROM employees
WHERE  salary >= (SELECT AVG(salary)
                  FROM employees);
SELECT emp_name
     , salary
FROM employees
WHERE  salary >= 6461.831775700934579439252336448598130841;


-- 동시에 2개이상의 컬럼 값이 같은 껀 조회 
SELECT employee_id, emp_name, job_id
FROM employees
WHERE (employee_id, job_id) IN (SELECT employee_id, job_id
                                FROM job_history);
                                
SELECT * 
FROM member;
-- cart사용 이력이 없는 회원을 조회하시오 
SELECT cart_member
FROM cart;

SELECT * 
FROM member
WHERE mem_id NOT IN(SELECT cart_member
                    FROM cart);
SELECT * 
FROM member
WHERE mem_id NOT IN('a001', 'b001');

-- member  중에서 전체 회원의 마일리지 평균값 이상인 회원만 조회하시오 
-- 정렬 (마일리지 내림차순)

SELECT mem_name, mem_job, mem_mileage
FROM member
WHERE mem_mileage >= (SELECT AVG(mem_mileage)
                      FROM member)
ORDER BY 3 desc;






SELECT a.emp_name
     , a.department_id
     , a.job_id
FROM employees a;

SELECT department_name
FROM departments
WHERE department_id =10;


-- 최숙경학생의 수강이력의 건수는? 



SELECT  학생.이름
      , 학생.학번
      , count(*) 수강건수 
FROM 학생, 수강내역
WHERE 학생.학번 = 수강내역.학번
AND 학생.이름 = '최숙경'
GROUP BY  학생.이름
        , 학생.학번;




