SELECT department_id
       -- level ���󿭷μ� Ʈ�� ������ � �ܰ����� ��Ÿ���� ������
     , LPAD(' ', 3 * (level-1)) || department_name as �μ���
--     , parent_id
     , level
FROM departments
START WITH parent_id IS NULL                -- ���� 
CONNECT BY PRIOR department_id = parent_id  -- ������ ��� ��������(����)
;
-- departments ���̺� 230 IT��������ũ ���� �μ��� 
--                     280 IT�������� �������ּ��� ^^




SELECT MAX(department_id)+10
FROM departments;

INSERT INTO departments (department_id, department_name, parent_id)
VALUES (280, 'IT������', 230);


commit;


/*������ �������� ������ �Ϸ��� SIBLINGS BY�� �߰��ؾ���.*/
SELECT department_id
     , LPAD(' ', 3 * (level-1)) || department_name as �μ���
     , parent_id
     , level
FROM departments
START WITH parent_id IS NULL                -- ���� 
CONNECT BY PRIOR department_id = parent_id
ORDER SIBLINGS BY department_name; -- SIBLINGS ���ÿ��� ���� �÷����θ� ���İ���

-- ���������� ���� �Լ� 
SELECT department_id
 , LPAD(' ', 3 * (level-1)) || department_name as �μ���
 , level 
 , CONNECT_BY_ISLEAF  -- ����������1, �ڽ��� ������0
 , SYS_CONNECT_BY_PATH(department_name, '>')-- ��Ʈ ��忡�� �ڽ������ ��������
 , CONNECT_BY_ISCYCLE  -- ���ѷ����� ������ ã����
 -- (�ڽ��� �ִµ� ���ڽ� �ο찡 �θ��̸� 1, �ƴϸ� 0 
FROM departments
START WITH parent_id IS NULL                -- ���� 
CONNECT BY NOCYCLE PRIOR department_id = parent_id
;
-- ���ѷ����ɸ����� ����
UPDATE departments
SET parent_id = 10
WHERE department_id = 30; 



SELECT department_id
 , LPAD(' ', 3 * (level-1)) || department_name as �μ���
 , level 
 , CONNECT_BY_ISCYCLE 
FROM departments
START WITH parent_id = 30                -- ���� 
CONNECT BY NOCYCLE PRIOR department_id = parent_id
;




SELECT employee_id
     , emp_name
     , manager_id
FROM employees
WHERE manager_id IS NULL;   

-- �������� �������踦 ����Ͻÿ� (���� ������ �̸� ��������)
SELECT employee_id
 , LPAD(' ', 3 * (level-1)) || emp_name as ������
 , SYS_CONNECT_BY_PATH(emp_name, '>') as ��������
FROM employees
START WITH manager_id IS NULL                -- ���� 
CONNECT BY PRIOR employee_id = manager_id
ORDER SIBLINGS BY emp_name 
;
/*
���̺��� ����,������ �μ�Ʈ �� ����Ͻÿ� 
�̻���	����	                    1
�����	   ����	                2
������	      ����	            3
�����	         ����	        4
�̴븮	            �븮	        5
�ֻ��	               ���	    6
�����	               ���	    6
�ڰ���	         ����	        4
��븮	            �븮	        5
�ֻ��	               ���	    6
*/
create table �� (
  ���̵� number
 ,�̸� varchar2(10)
 ,��å varchar2(10)
 ,�������̵� number
);

insert into �� values(1,'�̻���', '����', null);
insert into �� values(2,'�����', '����',1);
insert into �� values(3,'������', '����',2);
insert into �� values(4,'�����', '����',3);
insert into �� values(5,'�ڰ���', '����',3);
insert into �� values(6,'�̴븮', '�븮',4);
insert into �� values(7,'��븮', '�븮',5);
insert into �� values(8,'�ֻ��', '���',6);
insert into �� values(9,'�����', '���',6);
insert into �� values(10,'�ֻ��', '���',7);

commit;


SELECT 
       �̸�
     , LPAD(' ' , 3 * (LEVEL-1)) || ��å as ��å
     , LEVEL
     , ���̵�
     , �������̵�
  FROM ��
  START WITH �������̵� IS NULL                  --< �����ǿ� �´� �ο���� ������.
  CONNECT BY PRIOR ���̵�  = �������̵�; 
  
  
  
SELECT period 
    ,  sum(loan_jan_amt) as �����հ�
FROM kor_loan_status
WHERE substr(period, 1, 4) = 2013
GROUP BY period;
/*  level�� ����-���μ� (connect by ���� �Բ� ���)
    ������ �����Ͱ� �ʿ��Ҷ� ���̻��.
*/
-- 2013�� 1 ~12�� ������
SELECT  '2013' || LPAD(LEVEL,2,'0') as ���
FROM dual
CONNECT BY LEVEL <=12;

SELECT a.��� 
     , NVL(b.�����հ�,0) as �����հ�
FROM (SELECT  '2013' || LPAD(LEVEL,2,'0') as ���
        FROM dual
        CONNECT BY LEVEL <=12
      ) a
    , (SELECT   period  as ���
            ,  sum(loan_jan_amt) as �����հ�
        FROM kor_loan_status
        WHERE substr(period, 1, 4) = 2013
        GROUP BY period
     ) b
WHERE a.��� = b.���(+)
ORDER BY 1;

-- 202301~202312 

SELECT TO_CHAR(SYSDATE,'YYYY')||LPAD(LEVEL, 2, '0') AS YEAR 
FROM DUAL CONNECT BY LEVEL <= 12;
-- �̹��� 1�Ϻ��� ������������ ���
-- (�� �ش� select���� �����޿� ����� �ش���� ������������ ��µǵ���)
-- 20230801
-- 20230802
-- 20230803
-- ...
-- 20230831

SELECT TO_CHAR(SYSDATE,'YYYYMM') || LPAD(LEVEL,2,'0') as �����
  FROM DUAL
CONNECT BY LEVEL <= (SELECT TO_CHAR(LAST_DAY(sysdate),'DD')
                     FROM dual)
;
  
  
SELECT distinct to_char(mem_bir,'MM')
FROM member;

SELECT to_char(mem_bir,'MM') as ��
     , count(*)              as ȸ����
FROM member
GROUP BY to_char(mem_bir,'MM') 
ORDER BY 1;

SELECT LPAD(level,2,'0') as ��
FROM dual
CONNECT BY LEVEL <=12;

-- member ȸ���� ����(mem_bir) �� ���� ȸ������ ����Ͻÿ� (������ ��������)

SELECT a.�� || '��'   as ����_��
     , NVL(b.ȸ����,0) as ȸ����
FROM (SELECT LPAD(level,2,'0') as ��
        FROM dual
        CONNECT BY LEVEL <=12)a
   , (SELECT to_char(mem_bir,'MM') as ��
             , count(*)              as ȸ����
        FROM member
        GROUP BY to_char(mem_bir,'MM') 
        ORDER BY 1)b
WHERE a.�� = b.��(+)
UNION 
SELECT '�հ�'
     , COUNT(*) 
FROM member;
ORDER BY a.��;
  
  