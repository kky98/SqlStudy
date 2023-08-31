/*
   �ּ����� 
   table ���̺� 
   1.���̺�� �÷����� �ִ� ũ��� 30 ����Ʈ
   2.���̺�� �÷������� ������ ����� �� ����.
   3.���̺�� �÷������� ����, ����, _, $, # �� 
     ����� �� ������ ù ���ڴ� ���ڸ� �� �� ����.
   4.�� ���̺� ��밡���� �÷��� �ִ� 255�� ���� 
*/
CREATE TABLE ex2_1(
    col1 CHAR(10)
   ,col2 VARCHAR2(10)  -- �÷��� , <--�� ���� 
   --�ϳ��� �÷����� �ϳ��� Ÿ�԰� ����� ����
);
-- INSERT ������ ���� 
INSERT INTO ex2_1(col1, col2)
VALUES('abc','abc');   -- ���ڿ��� '' <-- ���� ����ǥ�� ǥ�� 
-- SELECT ������ ��ȸ 
SELECT col1 
     , LENGTH(col1) -- char �� ������
     , col2
     , LENGTH(col2) -- varchar2�� ������ 
FROM ex2_1;  
-- ������ ���۾� (DML, Data Manipulation Language) 
-- ��ȸ SELECT, ���� INSERT, ���� UPDATE, ���� DELETE 
SELECT *  -- * ��ü �÷��� �ǹ���
FROM employees;
-- Ư�� �÷��� ��ȸ
SELECT emp_name  -- �÷��� ������ (,) �޸� 
     , email
FROM employees;
-- alias(��Ī, ����) as 
SELECT emp_name as nm   
     , hire_date hd    -- ��Ī�� as �� ���̰� ������ ����Ʈ�� �νĵ�
     , salary ����      -- �ѱ۵� ��� ���������� ���� ����
     , department_id "�μ� ���̵�" -- ���⸦ �����Ϸ��� "" <- ��� 
FROM employees;                   -- ����� �Ⱦ��°� ���� _ <- ���
-- �˻� ������ �ִٸ� where�� ���
SELECT emp_name
     , salary 
FROM employees
WHERE salary >= 12000 ;   -- salary�� 12000 �̻� 
-- �˻������� ��������� AND , OR �� ��� 
SELECT emp_name
     , salary 
     , department_id
FROM employees
WHERE salary >= 12000
AND   department_id = 90;
-- ���� ���� ORDER BY  default [ASC ��������],   ������������ ������ DESC
SELECT *
FROM departments
ORDER BY department_id;   -- ����Ʈ ASC 
SELECT *
FROM departments
ORDER BY department_id DESC; -- ��������

SELECT emp_name
     , salary
FROM employees
ORDER BY salary DESC, emp_name DESC;

SELECT emp_name  -- 1 
     , salary    -- 2 
FROM employees
ORDER BY 2 DESC, 1 DESC;

SELECT emp_name 
     , salary 
FROM employees
ORDER BY hire_date;
-- ���� ������ : + - * /
SELECT employee_id            as �������̵�
     , emp_name               as �����̸�
     , salary / 30            as �ϴ�
     , salary                 as ����
     , salary - salary * 0.1  as �Ǽ��ɾ�
     , salary * 12            as ����
FROM employees;
-- �� ������ 
SELECT * FROM employees WHERE salary = 2600; -- ����
SELECT * FROM employees WHERE salary <> 2600; -- ���� �ʴ�
SELECT * FROM employees WHERE salary != 2600; -- ���� �ʴ�
SELECT * FROM employees WHERE salary < 2600;  -- �̸�
SELECT * FROM employees WHERE salary > 2600;  -- �ʰ�
SELECT * FROM employees WHERE salary <= 2600;  -- ����
SELECT * FROM employees WHERE salary >= 2600;  -- �̻�

-- departments ���̺��� 30 �Ǵ� 60 �μ��� ��ȸ�Ͻÿ� 
SELECT *
FROM departments
WHERE department_id = 30
OR department_id = 60;

--PRODUCTS ���̺��� '��ǰ ���� �ݾ�(PROD_MIN_PRICE)'�� 
-- 30�� "�̻�" 50�� "�̸�"�� ��ǰ���, ī�װ�, �����ݾ��� ����Ͻÿ�
-- �������� prod_category ��������, prod_min_price �������� 
SELECT prod_name 
     , prod_category
     , prod_min_price
FROM PRODUCTS
WHERE prod_min_price >= 30
AND   prod_min_price < 50
ORDER BY prod_category, prod_min_price DESC;
-- ǥ����:���ϴ� ǥ������ ����  CASE WHEN ����1 THEN �ش����Ǻ���ǥ��
--                                WHEN ����2 THEN �ش����Ǻ���ǥ��
--                           END AS ��Ī
SELECT cust_name, cust_gender
      ,CASE WHEN cust_gender = 'M' THEN '����'
            WHEN cust_gender = 'F' THEN '����'
            ELSE '??'
       END AS gender
FROM customers;


SELECT cust_name, cust_gender
      ,CASE WHEN cust_gender = 'M' THEN '����'
            ELSE '����'
       END AS gender
FROM customers;

SELECT employee_id
     , emp_name
     , CASE WHEN salary <= 5000 THEN 'C���'
            WHEN salary > 5000 AND salary <= 15000 THEN 'B���'
            ELSE 'A���'
        END as grade
FROM employees;
-- BETWEEN AND ���ǽ�
SELECT employee_id
    , salary
FROM employees   -- 2000 ~ 2500 
WHERE salary BETWEEN 2000 AND 2500;
-- IN ���ǽ�  or �� �ǹ� 
SELECT employee_id , salary, department_id
FROM employees
WHERE department_id IN(90, 80, 10);  -- 90 or 80 or 10 
-- ���ڿ� ������  ||  <-- +
SELECT emp_name || ':' || employee_id as �̸����
FROM employees;
-- ** ���� ��� LIKE
SELECT emp_name
FROM employees
WHERE emp_name LIKE 'A%';  -- A �� �����ϴ� 
SELECT emp_name
FROM employees
WHERE emp_name LIKE '%d';  -- d�� ������ 
SELECT emp_name
FROM employees
WHERE emp_name LIKE '%na%';  -- na�� ���ԵǾ��ִ� 
-- 
SELECT emp_name
FROM employees
WHERE department_id = :a
OR   department_id  = :b;  -- �ݷ� :�̸� <-- ���ε� 
                           -- ���� ���� �׽�Ʈ�غ��� ��� 
SELECT emp_name
FROM employees
WHERE emp_name LIKE '%'||:val||'%';    --   %��%

CREATE TABLE ex2_2 (
    nm VARCHAR2(20)
);
INSERT INTO ex2_2 VALUES('�浿');
INSERT INTO ex2_2 VALUES('ȫ�浿');
INSERT INTO ex2_2 VALUES('�浿ȫ');
INSERT INTO ex2_2 VALUES('ȫ�浿��');
-- ȫ��� �����ϴ� 3���� ��ȸ 
SELECT *
FROM ex2_2
--WHERE nm LIKE 'ȫ��%';
WHERE nm LIKE '__'; 
-- �ڸ� ���� ��Ȯ�ؾ� �Ҷ� _ <--��� (�����̵�1�ڸ��ǹ�)

CREATE TABLE students (
stu_id VARCHAR2(12)	/* �й� */
, stu_grade NUMBER(1)	/* �г� */
, stu_semester NUMBER(1)	/* �б� */
, stu_name VARCHAR2(10)	/* �л� �̸� */
, stu_birth VARCHAR2(10)	/* �л� ������� */
, stu_kor NUMBER(3)	/* ���� ���� */
, stu_eng NUMBER(3)	/* ���� ���� */
, stu_math NUMBER(3)	/* ���� ���� */
, CONSTRAINTS stu_pk PRIMARY KEY(stu_id, stu_grade, stu_semester)
);

SELECT *
FROM students;  -- 1�г� �达�� ��ȸ�Ͻÿ� 

SELECT stu_name
     , stu_grade 
     , (stu_kor + stu_eng + stu_math) / 3 as  subject_avg
FROM students
WHERE stu_grade =1
AND (stu_kor + stu_eng + stu_math) / 3  >= 90;


/*
    CUSTOMERS 
    ���� : Los Angeles
    ��ȥ : single
    ���� : ����
    1983 ���� �����
    �������� ����⵵ ��������, �̸� �������� 
*/


SELECT CUST_NAME               /*�� ��*/
     , CUST_GENDER             /*�� ����*/
     , CUST_YEAR_OF_BIRTH      /*�� ����⵵*/
     , CUST_MARITAL_STATUS     /*�� ��ȥ����*/ 
     , CUST_STREET_ADDRESS     /*�� �ּ�*/
FROM CUSTOMERS
WHERE CUST_CITY ='Los Angeles'
AND CUST_MARITAL_STATUS ='single'
AND CUST_YEAR_OF_BIRTH >= 1983
AND CUST_GENDER = 'F'
ORDER BY 3 DESC, 1 ;


--AND 









