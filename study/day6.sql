SELECT mbti
     , COUNT(*) as cnt
FROM tb_info
GROUP BY mbti
ORDER BY 2 DESC;

SELECT hobby 
     , COUNT(*) as cnt 
FROM tb_info
GROUP BY hobby
ORDER BY 2 DESC;

/* �����Լ� ��� �����͸� Ư�� �׷����� ���� ���� �׷쿡 ����
   ����, ���, �ִ�, �ּڰ� ���� ���ϴ� �Լ� .
   COUNT(expr) �ο� ���� ��ȯ�ϴ� �����Լ�.
*/
SELECT COUNT(*)                      -- null����
     , COUNT(department_id)          -- default ALL
     , COUNT(ALL department_id)      -- �ߺ� ���� null X
     , COUNT(DISTINCT department_id) -- �ߺ����� 
     , COUNT(employee_id)
FROM employees;

SELECT SUM(salary)           -- �հ�
     , ROUND(AVG(salary),2)  -- ���
     , MAX(salary)           -- �ִ�
     , MIN(salary)           -- �ּ� 
FROM employees;


SELECT department_id
     , SUM(salary)           -- �հ�
     , ROUND(AVG(salary),2)  -- ���
     , MAX(salary)           -- �ִ�
     , MIN(salary)           -- �ּ� 
FROM employees 
GROUP BY department_id
ORDER BY 1 ;
-- 50�� �μ��� �ִ�, �ּ� �޿��� ����Ͻÿ� 
SELECT MIN(salary)
     , MAX(salary)
FROM employees
WHERE department_id = 50;

-- member���̺��� Ȱ���Ͽ� 
-- ȸ���� ������ ȸ������ ����Ͻÿ� 
-- ����(ȸ���� ��������)
SELECT mem_job
     , COUNT(mem_id) as cnt
FROM member
GROUP BY mem_job
ORDER BY 2 DESC;



-- 2013�⵵ �Ⱓ�� �� �����ܾ�
SELECT period
     , SUM(loan_jan_amt) as ���ܾ�
FROM kor_loan_status
WHERE period LIKE '2013%'
GROUP BY period
ORDER BY 1 ;

SELECT count(*)
FROM kor_loan_status;

-- 2013�⵵ ������ �Ѵ����ܾ�
SELECT region
     , SUM(loan_jan_amt) as ���ܾ�
FROM kor_loan_status
WHERE period LIKE '2013%'
GROUP BY region
ORDER BY 1 ;

-- 2013�⵵ ������, ���������� �Ѵ����ܾ�
-- select ���� ���� �÷��� �����Լ��� �����ϰ� 
-- group by ���� ���ԵǾ����. 
SELECT region
     , gubun
     , SUM(loan_jan_amt) as ���ܾ�
FROM kor_loan_status
WHERE period LIKE '2013%'
GROUP BY region, gubun
ORDER BY 1 ;
-- �⵵�� ������ ������ �� �հ�
SELECT SUBSTR(period, 1, 4) as �⵵
     , region
     , SUM(loan_jan_amt)    as ���ܾ�
FROM kor_loan_status
GROUP BY SUBSTR(period, 1, 4), region
ORDER BY 1;


-- employees �������� �Ի�⵵�� �������� ����Ͻÿ� 
DESC employees;
-- �׷��� ����� �����Ϳ� ���� �˻������� ������ 
-- HAVING ��� 
-- �Ի������� 10�� �̻��� �⵵�� ������ 
-- **** select �� ������� 
-- from -> where -> group by -> having -> select -> order by
SELECT TO_CHAR(hire_date,'YYYY') as �Ի�⵵
     , COUNT(employee_id) as ������ 
FROM employees
GROUP BY TO_CHAR(hire_date,'YYYY')
HAVING COUNT(employee_id)>= 10
ORDER BY 1 ;

-- member ���̺��� Ȱ���Ͽ� 
-- ������ ���ϸ��� ��ձݾ��� ���Ͻÿ� 
-- (�Ҽ��� 2° �ڸ����� �ݿø��Ͽ� ���)
-- (1)���� ��ո��ϸ��� �������� 
-- (2)��� ���ϸ����� 3000�̻��� �����͸� ���
SELECT mem_job
     , ROUND(AVG(mem_mileage),2) as avg_mileage
FROM member
GROUP BY mem_job
HAVING ROUND(AVG(mem_mileage),2) >= 3000
ORDER BY 2 DESC;
--------------------------
-- ������ ���ϸ����� �հ� ���ϸ��� ��ü�հ踦 ����Ͻÿ� 
SELECT NVL(mem_job,'�հ�') as ����
     , COUNT(mem_id)    as ȸ����
     , SUM(mem_mileage) as �հ�
FROM member
GROUP BY ROLLUP(mem_job); -- �Ѿ� ���ƿø��ٶ�� ������ 
                          -- �������� ���� �����.

--products ��ǰ���̺��� ī�װ��� ��ǰ���� 
--��ü ��ǰ ���� ����Ͻÿ� 

SELECT NVL(prod_category,'�� ��') as ī�װ�
     , prod_subcategory  as  ����ī�װ�
     , COUNT(prod_id) as ��ǰ�� 
FROM products
GROUP BY ROLLUP(prod_category, prod_subcategory) ;


SELECT SUBSTR(period, 1, 4) as �⵵
     , region
     , SUM(loan_jan_amt)    as ���ܾ�
FROM kor_loan_status
GROUP BY ROLLUP(SUBSTR(period, 1, 4), region)
ORDER BY 1;
SELECT cust_id
     , cust_name
     , cust_gender 
     , cust_year_of_birth
FROM customers;

-- �⵵�� ȸ������ ����Ͻÿ� ��(��, �� �����Ͽ��� )
SELECT  cust_year_of_birth 
       ,SUM(DECODE(cust_gender,'M', 1, 0))  as ���� 
       ,SUM(DECODE(cust_gender,'F', 1, 0))  as ���� 
FROM customers
GROUP BY ROLLUP(cust_year_of_birth)
ORDER BY 1;





SELECT count(* )
FROM customers;
WHERE cust_year_of_birth = 1913;


SELECT substr(mbti,1,1)
     , count(*)
FROM tb_info
GROUP BY substr(mbti,1,1);


--������ �� �⵵�� �������ܾ��� ���ϴ� ������ �ۼ��� ����.(kor_loan_status)





SELECT REGION,
       SUM(CASE WHEN PERIOD LIKE '2011%' THEN LOAN_JAN_AMT ELSE 0 END)  AMT_2011,
       SUM(CASE WHEN PERIOD LIKE '2012%'  THEN LOAN_JAN_AMT ELSE 0 END) AMT_2012, 
       SUM(CASE WHEN PERIOD LIKE '2013%'  THEN LOAN_JAN_AMT ELSE 0 END) AMT_2013 
 FROM KOR_LOAN_STATUS
GROUP BY ROLLUP(REGION);




--\\DESKTOP-DVPTLC6




SELECT TO_CHAR(hire_date,'YYYY') as �Ի�⵵
     , COUNT(employee_id) as ������
FROM employees
GROUP BY TO_CHAR(hire_date,'YYYY')
ORDER BY 1;


DESC kor_loan_status;






















