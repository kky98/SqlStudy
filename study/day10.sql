--�⺻ �Լ�, �����Լ�, ����, �ǻ��÷� 



/* �� VIEW 338p 
 �ϳ� �̻��� ���̺��� ������ ��ġ ���̺��� �� ó�� ����ϴ� ��ü 
 ���� �����ʹ� �並 �����ϴ� ���̺� ��� ������ ���̺�ó�� ��밡�� 
 ��� ���� :1. ���� ����ϴ� ������ SQL���� �Ź� �ۼ��� �ʿ� ���� ��� ����� ���
           2. ������ ���� ����(��� �÷��� �����͸� �������� ��õ ���̺� ���� �� ����.) 
*/
CREATE OR REPLACE VIEW emp_dept AS  -- �� ���� ���� 
SELECT a.employee_id 
     , a.emp_name
     , a.department_id
     , b.department_name
FROM employees a, departments b 
WHERE a.department_id = b.department_id;
-- system �������� java ������ �並 ���� �� �ִ� ���Ѻο� 
GRANT CREATE VIEW to java;  -- system�������� ����
SELECT *
FROM emp_dept;

-- �ٸ������� emp_dept �並 ��ȸ�Ҽ��ִ� ���� �ο�
GRANT SELECT ON emp_dept TO study; --java �������� ����

SELECT *
FROM java.emp_dept;-- study�������� ��ȸ �ٸ� �������� ��ȸ�Ҷ��� ��Ű��(����).�� or ���̺� 

/*  �� Ư¡
    * �ܼ� ��(���̺� 1���� ����)
    - �׷��Լ� ���Ұ�
    - dinstinct ��� �Ұ�
    - insert/update/delete ��밡��
    * ���� ��(���̺� �������� ����)
    - �׷� �Լ� ��밡��
    - dinstinct ��밡��
    - insert/update/delete �Ұ��� 
*/
-- �� ���� 
DROP VIEW emp_dept ; -- ������ ������������

/* �ó�� synonim : ���Ǿ�� ������ ��ü ������ ������ �̸��� ���� ���Ǿ ����°� 
   public synonim : ��� ����� ����
   private synonim : Ư�� ����ڸ� ���� 
   �ó�� ������ public�� �����ϸ� private �ó������ ������
   public �ó���� ���������� DBA �����ִ� ����ڸ� ���� 
   ��� ���� : 1.�������� ������� ���� �߿��� ������ ����� ���� ��Ī�� ���� 
              2.�������Ǽ� ���� ���̺��� ������ ����Ǿ ��Ī���� ����� �ߴٸ� 
                �ڵ� ������ ���ص���.   
*/
-- �ó�� ���� ���� �ο� 
GRANT CREATE SYNONYM to java; -- system �������� ���Ѻο� 
CREATE OR REPLACE SYNONYM empl FOR employees;
SELECT *
FROM empl;
GRANT SELECT ON empl TO study; -- ���Ǿ�� ���̺��� ��ȸ�� �� �ִ� ���Ѻο� 
SELECT *
FROM java.empl;
-- public SYNONYM dba������ �־����. 
CREATE OR REPLACE PUBLIC SYNONYM empl2 FOR java.employees; -- system �������� ����
SELECT *
FROM empl2;  -- � ���������� ��ȸ����(pulic �̱⶧��) 
             -- �� ���������� �ش� ���̺��� ��� ������ �ִ��� �� �� ����.(����)
--dba ���� public synonym ���� ���� 
DROP PUBLIC SYNONYM empl2; 

/* ������ SEQUENCE 348p : ��Ģ�� ���� �ڵ� ������ ��ȯ�ϴ� ��ü
   ������ : pk �� ����� �����Ͱ� ������� �������� ���� ��� 
         ex ) �Խ����� �Խñ۹�ȣ (1�� �����Ͽ� ~~ 999 ����)
   ��������.CURRVAL -- ���� ��������
   ��������.NEXTVAL -- ���� �������� 
*/ 
CREATE SEQUENCE my_seq1
INCREMENT BY 1    -- �������� 
START WITH   1    -- ���ۼ���
MINVALUE     1    -- �ּҰ�
MAXVALUE   9999999-- �ִ�
NOCYCLE           -- �ִ볪 �ּҰ��� �����ϸ� �������� ����Ʈ(nocycle)
NOCACHE ;         -- �޸𸮿� ������ ���� �̸� �Ҵ����� ���� ����Ʈ(nocache)
SELECT 
--       my_seq1.NEXTVAL
      my_seq1.CURRVAL
FROM dual;
DROP SEQUENCE my_seq1;
CREATE TABLE temp_tb(
     seq NUMBER
    ,dt  TIMESTAMP DEFAULT SYSTIMESTAMP
);
INSERT INTO temp_tb(seq) VALUES(my_seq1.NEXTVAL);
SELECT *
FROM temp_tb;
drop table temp_tb;

SELECT NVL(MAX(seq),0)+1 
FROM temp_tb;
INSERT INTO temp_tb(seq) VALUES((SELECT NVL(MAX(seq),0)+1 
                                 FROM temp_tb));
SELECT *
FROM temp_tb;

SELECT  TO_CHAR(SYSDATE, 'YYYYMMDD') || LPAD(NVL(MAX(seq),0)+1 , 4, '0')
FROM temp_tb;

/* MERGE��  oracle 10g ���� ��밡��
   Ư�� ���ǿ� ���� INSERT or UPDATE DELETE ���� 
*/
-- �������ǰǰ� ������ �ִٸ� ������ 3���� 
--                   ���ٸ� ���� 
SELECT *
FROM ����;
INSERT INTO ���� (�����ȣ, �����̸�, ����) VALUES(509,'�������ǰǰ�',2);
MERGE INTO ���� a
USING dual            -- �񱳴�����̺� (dual�� into���̺�� ������)
ON(a.�����̸� = '�������ǰǰ�')
WHEN MATCHED THEN     -- on�� ������ �����Ҷ�
  UPDATE SET a.���� = 3
WHEN NOT MATCHED THEN -- on���ǿ� �������� ������ 
 INSERT (a.�����ȣ, a.�����̸�, a.����)
 VALUES (509, '�������ǰǰ�', 2);
 
/* SELECT ��  ��Ȯ and �ӵ� */ 
SELECT a.employee_id
     , (SELECT emp_name
        FROM employees
        WHERE employee_id = a.employee_id)
     , a.cust_id
     , (SELECT cust_name
         FROM customers
         WHERE cust_id = a.cust_id)
     , count(*)
FROM sales a
GROUP BY a.cust_id, a.employee_id
ORDER BY 3 DESC;


-- 2000�⵵ �Ǹſ��� ����Ͻÿ� (�Ǹűݾ��� ����)
-- employees, sales ���̺� ��� �Ǹűݾ�(amount_sold) �Ǹż���(quantity_sold)
 
 
 
 
 SELECT (select emp_name 
        from employees 
        where employee_id = a.employee_id ) as �̸� 
      , a.employee_id  as ��� 
      , to_char(�Ǹűݾ�,'999,999,999.99') as �Ǹűݾ�
      , a.�Ǹż���
FROM (SELECT employee_id 
           , sum(amount_sold)   as �Ǹűݾ�
           , sum(quantity_sold) as �Ǹż���
      FROM sales
      WHERE to_char(sales_date,'YYYY') = '2000'
      GROUP BY employee_id
      ORDER BY 2 desc
      ) a
WHERE rownum = 1
;
 
 SELECT  employee_id 
       , SUM(amount_sold)   as �Ǹűݾ�
       , SUM(quantity_sold) as �Ǹż���
       , COUNT(*)
  FROM sales
  WHERE to_char(sales_date,'YYYY') = '2000'
  GROUP BY employee_id
  ORDER BY 2 desc;
 

 SELECT  employee_id 
       , amount_sold   as �Ǹűݾ�
       , quantity_sold as �Ǹż���
       , to_char(sales_date,'YYYY')
       , sales_date
  FROM sales
  WHERE to_char(sales_date,'YYYY') = '2000'

  ORDER BY 2 desc;











--��ȹ���� ��� �޿����� ���� �޴� ������ ���� �μ��� ����Ͻÿ�

SELECT *
FROM  sales a
    , customers b
    , countries c
WHERE a.cust_id = b.cust_id
AND   b.country_id = c.country_id;