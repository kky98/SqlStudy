/*  TABLE ���� ALTER
*/
CREATE TABLE ex4_1(
        irum VARCHAR2(100) NOT NULL
      , point NUMBER(5)
      , gender CHAR(1)
      , reg_date DATE
);
DESC ex4_1;
-- �÷��� ���� 
ALTER TABLE ex4_1 RENAME COLUMN irum TO nm;
-- Ÿ�� ���� (Ÿ�� ������ ���̺� �����Ͱ� �ִٸ� �����ؾ���)
ALTER TABLE ex4_1 MODIFY point NUMBER(10) ;
-- �������� �߰� 
ALTER TABLE ex4_1 ADD CONSTRAINT pk_ex4 PRIMARY KEY(nm);
-- �÷� �߰� 
ALTER TABLE ex4_1 ADD hp VARCHAR2(20); 
-- �÷� ���� 
ALTER TABLE ex4_1 DROP COLUMN hp;

-------------���̺� comment 
COMMENT ON TABLE tb_info IS '�츮��';
COMMENT ON COLUMN tb_info.info_no IS '�⼮��ȣ' ;
COMMENT ON COLUMN tb_info.pc_no IS '��ǻ�͹�ȣ' ;
COMMENT ON COLUMN tb_info.nm IS '�̸�' ;
COMMENT ON COLUMN tb_info.email IS '�̸���' ;
COMMENT ON COLUMN tb_info.hobby IS '���' ;
COMMENT ON COLUMN tb_info.mbti IS '�긯��������ǥ' ;

SELECT *
FROM all_tab_comments  -- ���̺� �ڸ�Ʈ 
WHERE OWNER ='JAVA';
SELECT *
FROM all_col_comments
WHERE comments LIKE '%�̸�%' ;
--WHERE comments LIKE '%�̸�%';
/* INSERT ������ ���� (DML��)
   1.�⺻���� �÷��� ��� 
*/
CREATE TABLE ex4_2(
    val1 VARCHAR2(10)
   ,val2 NUMBER
   ,val3 DATE
);
-- �Է� �÷��� �� �ۼ� 
INSERT INTO ex4_2(val1 , val2, val3)
VALUES ('hi', 10, SYSDATE);  -- ���ڿ� '' numberŸ���� ����
INSERT INTO ex4_2(val3, val2)
VALUES (SYSDATE, 10);        -- ���� �ۼ��� �÷� ������� 
                             -- value�� INSERT 
SELECT * FROM ex4_2;
-- ���̺� ��ü�� ���� �����͸� �����Ҷ��� �÷��� �Ƚᵵ ��.
INSERT INTO ex4_2
VALUES ('hello', 20, SYSDATE);
INSERT INTO ex4_2
VALUES ( 20, SYSDATE); -- ���� 
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
-- ���̺� ���� 
CREATE TABLE ex4_4 AS 
SELECT nm, email
FROM tb_info
;
SELECT * 
FROM ex4_4;
/* UPDATE ������ ���� */
SELECT *
FROM tb_info;

UPDATE tb_info
SET hobby ='����'
  , email = 'abc@gmail.com'
WHERE INFO_NO =1;

-- 192.168.0.41
SELECT *
FROM tb_info;
/* DELETE ������ ���� */
SELECT *
FROM ex4_4;
DELETE ex4_4 ;  -- ��ü ���� 

DELETE ex4_4
WHERE nm ='���ؼ�';

-- �ߺ����� ������ ���� 
SELECT DISTINCT prod_category
FROM products;
-- �ǻ��÷� (���̺��� ������ �ִ°� ó�� ���)
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
     , CASE WHEN INSTR(mbti,'E') = 1 THEN '������'
            ELSE '������'
       END as ����������
FROM tb_info
;
/*
  oracle �����ͺ��̽� �����Լ� 
  ���ڰ��� 
*/
SELECT LOWER('I like mac') as lowers
     , UPPER('I like mac') as uppers
     , INITCAP('I like mac') as initcaps  -- �ܾ� ù��¥ �빮��
FROM dual;  -- �ӽ����̺� 

SELECT *
FROM employees
WHERE UPPER(emp_name) LIKE '%'||UPPER('donald')||'%';

-- SUBSTR (char, pos, len) ����ڿ� char�� pos ��°���� 
-- len ���� ��ŭ �ڸ��� ��ȯ 
-- pos ������ 0 �̿��� ����Ʈ �� 1 �� ù��° ���ڿ�
-- ������ ���� ���ڿ��� �� ������ ������ ����� ��ġ 
-- len ���� �����Ǹ� pos ��° ���ں��� ������ ��� ���ڸ� ��ȯ 
SELECT SUBSTR('ABCD EFG',1, 4)
     , SUBSTR('ABCD EFG',-3, 3)
     , SUBSTR('ABCD EFG',-3, 1)
     , SUBSTR('ABCD EFG',5)
FROM dual;
/*INSTR ��� ���ڿ����� ã�� ���ڿ��� ��ġ*/
SELECT INSTR('���� ���� �ܷο� ����, ���� ���� ���ο� ����','����') --����Ʈ 1,1
     , INSTR('���� ���� �ܷο� ����, ���� ���� ���ο� ����','����',5)
     , INSTR('���� ���� �ܷο� ����, ���� ���� ���ο� ����','����',1,2)
     , INSTR('���� ���� �ܷο� ����, ���� ���� ���ο� ����','��') -- ������ 0 
FROM dual;

-- ���� �̸��� �ּ��� �̸��� �������� �и��Ͽ� ����Ͻÿ� 
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
      , CASE WHEN INSTR(mbti,'E') = 0 THEN '������' 
        ELSE '������'
        END as ����������
     , CASE WHEN SUBSTR(mbti,2,1) = 'N' THEN '������' 
       ELSE '������'
       END as �νĹ��
     , CASE WHEN mbti LIKE '%T%' THEN '�����' 
       ELSE '������'
       END as �Ǵ���
     , CASE WHEN INSTR(mbti,'J') = 0 THEN '������' 
       ELSE '��ȹ��'
       END as ��Ȱ���
FROM tb_info;


























