SELECT *
FROM employees;

SELECT *
FROM departments;
-- inner join ��������(���������̶�� ��) 
-- �� �÷��� ������ ���� ������ ���� 
SELECT employees.emp_name
     , departments.department_name
FROM employees, departments
WHERE employees.department_id = departments.department_id;

-- ���̺� ��Ī 
SELECT emp_name        -- ������ʿ��� �ִ� �÷��� ��Ī �Ƚᵵ��
     , department_name
     , a.department_id  -- ������ �÷����� �������� ��� ������ ǥ���ؾ���.
FROM employees a, departments b 
WHERE a.department_id = b.department_id;

SELECT *
FROM member;
SELECT *
FROM cart;

-- member �����뾾�� īƮ(�����̷�)�̷��� ����Ͻÿ� 
SELECT member.mem_name
     , cart.cart_no
     , cart.cart_prod
     , cart.cart_qty
FROM member, cart
WHERE  member.mem_id = cart.cart_member
AND member.mem_name ='������';
/* ANSI JOIN : American National Standards Institute
               �̱� ǥ�� SQL �������� (������ �� �ǹ����� �� �Ⱦ�)
*/
SELECT member.mem_name
     , cart.cart_no
     , cart.cart_prod
     , cart.cart_qty
FROM member 
INNER JOIN cart
ON(member.mem_id = cart.cart_member)
WHERE member.mem_name = '������';
-- ��ǰ ���� ��� 
SELECT member.mem_name, member.mem_id, cart.cart_member
     , cart.cart_no
     , cart.cart_prod , prod.prod_id
     , cart.cart_qty
     , prod.prod_name 
     , prod.prod_sale
FROM member, cart, prod
WHERE  member.mem_id = cart.cart_member
AND    cart.cart_prod = prod.prod_id
AND member.mem_name ='������';

-- �����뾾�� ������ ��ü ��ǰ�� �հ� �ݾ���? 
-- cart cart_qty  <-- ��ǰ ���� ���� 
-- prod prod_sale <-- ��ǰ �ǸŰ���    
SELECT member.mem_name
     , member.mem_id
     , SUM(cart.cart_qty *  prod.prod_sale ) as �հ�ݾ�
FROM member, cart, prod
WHERE  member.mem_id = cart.cart_member
AND    cart.cart_prod = prod.prod_id
AND member.mem_name ='������'
GROUP BY member.mem_name, member.mem_id;


SELECT member.mem_name
     , member.mem_id
     , SUM(cart.cart_qty *  prod.prod_sale ) as �հ�ݾ�
FROM member INNER JOIN cart
ON (member.mem_id = cart.cart_member)
INNER JOIN prod
ON (cart.cart_prod = prod.prod_id)
WHERE member.mem_name ='������'
GROUP BY member.mem_name, member.mem_id;
-- employees, jobs ���̺��� Ȱ���Ͽ� 
-- salary�� 15000 �̻��� ������ ���, �̸�, salary, ���� ���̵�, �������� ����Ͻÿ� 
SELECT employee_id, emp_name, salary, job_id
FROM employees;
SELECT job_id, job_title
FROM jobs;

SELECT a.employee_id   /*���*/
     , a.emp_name      /*�̸�*/
     , a.salary        /*����*/
     , b.job_title     /*������*/
FROM employees a       --�������̺�
   , jobs b            --�������̺�
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

/* �������� (�����ȿ� ����)
   1.��Į�� �������� (select ��)
   2.�ζ��� �� (from��)
   3.��ø ���� (where��)
*/
-- ��Į�� ���������� ������ ��ȯ
-- ���� �ڵ尪�� �̸��� �����ö� ���� ��� 
-- ���������� �����������̺��� �� �Ǽ� ��ŭ ���������� ��ȸ�ϱ� ������ 
-- ���������� ���̺��� �Ǽ��� ������ �ڿ��� ���� ����ϰԵ�.
-- (���� ���� ��� ������ �̿��ϴ°� �� ����)
SELECT a.emp_name
     , (SELECT department_name 
        FROM departments
        WHERE department_id = a.department_id) as dep_name
     , a.job_id
     , (SELECT job_title
        FROM jobs
        WHERE job_id = a.job_id) as job_name
FROM employees a;
-- ��ø�������� 
-- ��ü ������ ������� ���� ������ ū ������ ����Ͻÿ� 
SELECT emp_name
     , salary
FROM employees
WHERE  salary >= (SELECT AVG(salary)
                  FROM employees);
SELECT emp_name
     , salary
FROM employees
WHERE  salary >= 6461.831775700934579439252336448598130841;


-- ���ÿ� 2���̻��� �÷� ���� ���� �� ��ȸ 
SELECT employee_id, emp_name, job_id
FROM employees
WHERE (employee_id, job_id) IN (SELECT employee_id, job_id
                                FROM job_history);
                                
SELECT * 
FROM member;
-- cart��� �̷��� ���� ȸ���� ��ȸ�Ͻÿ� 
SELECT cart_member
FROM cart;

SELECT * 
FROM member
WHERE mem_id NOT IN(SELECT cart_member
                    FROM cart);
SELECT * 
FROM member
WHERE mem_id NOT IN('a001', 'b001');

-- member  �߿��� ��ü ȸ���� ���ϸ��� ��հ� �̻��� ȸ���� ��ȸ�Ͻÿ� 
-- ���� (���ϸ��� ��������)

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


-- �ּ����л��� �����̷��� �Ǽ���? 



SELECT  �л�.�̸�
      , �л�.�й�
      , count(*) �����Ǽ� 
FROM �л�, ��������
WHERE �л�.�й� = ��������.�й�
AND �л�.�̸� = '�ּ���'
GROUP BY  �л�.�̸�
        , �л�.�й�;




