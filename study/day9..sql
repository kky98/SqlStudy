CREATE TABLE exp_goods_asia (
       country VARCHAR2(10),
       seq     NUMBER,
       goods   VARCHAR2(80));

INSERT INTO exp_goods_asia VALUES ('�ѱ�', 1, '�������� ������');
INSERT INTO exp_goods_asia VALUES ('�ѱ�', 2, '�ڵ���');
INSERT INTO exp_goods_asia VALUES ('�ѱ�', 3, '��������ȸ��');
INSERT INTO exp_goods_asia VALUES ('�ѱ�', 4, '����');
INSERT INTO exp_goods_asia VALUES ('�ѱ�', 5,  'LCD');
INSERT INTO exp_goods_asia VALUES ('�ѱ�', 6,  '�ڵ�����ǰ');
INSERT INTO exp_goods_asia VALUES ('�ѱ�', 7,  '�޴���ȭ');
INSERT INTO exp_goods_asia VALUES ('�ѱ�', 8,  'ȯ��źȭ����');
INSERT INTO exp_goods_asia VALUES ('�ѱ�', 9,  '�����۽ű� ���÷��� �μ�ǰ');
INSERT INTO exp_goods_asia VALUES ('�ѱ�', 10,  'ö �Ǵ� ���ձݰ�');

INSERT INTO exp_goods_asia VALUES ('�Ϻ�', 1, '�ڵ���');
INSERT INTO exp_goods_asia VALUES ('�Ϻ�', 2, '�ڵ�����ǰ');
INSERT INTO exp_goods_asia VALUES ('�Ϻ�', 3, '��������ȸ��');
INSERT INTO exp_goods_asia VALUES ('�Ϻ�', 4, '����');
INSERT INTO exp_goods_asia VALUES ('�Ϻ�', 5, '�ݵ�ü������');
INSERT INTO exp_goods_asia VALUES ('�Ϻ�', 6, 'ȭ����');
INSERT INTO exp_goods_asia VALUES ('�Ϻ�', 7, '�������� ������');
INSERT INTO exp_goods_asia VALUES ('�Ϻ�', 8, '�Ǽ����');
INSERT INTO exp_goods_asia VALUES ('�Ϻ�', 9, '���̿���, Ʈ��������');
INSERT INTO exp_goods_asia VALUES ('�Ϻ�', 10, '����');

COMMIT;

SELECT goods
FROM exp_goods_asia
WHERE country = '�ѱ�'
UNION  -- �ߺ� ���ŵ�.
SELECT goods
FROM exp_goods_asia
WHERE country = '�Ϻ�';


SELECT goods
FROM exp_goods_asia
WHERE country = '�ѱ�'
UNION ALL   -- ��ü ��� ����
SELECT goods
FROM exp_goods_asia
WHERE country = '�Ϻ�';


SELECT goods
FROM exp_goods_asia
WHERE country = '�ѱ�'
INTERSECT  -- ������
SELECT goods
FROM exp_goods_asia
WHERE country = '�Ϻ�';

SELECT goods
FROM exp_goods_asia
WHERE country = '�ѱ�'
MINUS  -- ������ 
SELECT goods
FROM exp_goods_asia
WHERE country = '�Ϻ�';
-- oracle ������ ��� �÷��� ���� Ÿ���� ���ƾ���.
-- ������ ������ select������ ��� 
SELECT TO_CHAR(department_id) as �μ� 
     , COUNT(*) �μ���������
FROM employees
GROUP BY department_id
UNION 
SELECT  '��ü'
      , COUNT(*)  as ��ü������
FROM employees;


DESC exp_goods_asia;
SELECT seq, goods
FROM exp_goods_asia
WHERE country = '�ѱ�'
UNION  -- �ߺ� ���ŵ�.
SELECT seq, goods
FROM exp_goods_asia
WHERE country = '�Ϻ�'
UNION 
SELECT 10, '��ǻ��'
FROM dual;
-- EXISTS �����ϴ��� ���ϴ��� 
-- ���� �����̶�� ��. 

-- job_history ���̺� �����ϴ� �μ� ���
SELECT a.department_id 
     , a.department_name 
FROM departments a
WHERE EXISTS (SELECT 1 -- select�� �ǹ̾��� where�� ���뿡 �ش�Ǵ�
                       -- �����Ͱ� �����ϴ����� üũ 
              FROM job_history b
              WHERE a.department_id = b.department_id);

-- job_history ���̺� �������� �ʴ� �μ� ���
SELECT a.department_id 
     , a.department_name 
FROM departments a
WHERE NOT EXISTS (SELECT * 
                  FROM job_history b
                  WHERE a.department_id = b.department_id);
-- ���������� ���� �л� ��ȸ 
SELECT *
FROM �л� a
WHERE NOT EXISTS (SELECT * 
                  FROM �������� b
                  WHERE b.�й� = a.�й�); 
                  
/*  ���� ǥ���� '�˻�','ġȯ'�ϴ� ������ �����ϰ� ó���� �� �ֵ��� �ϴ� ����.
    oracle�� 10g���� ��� 
    (JAVA, Python, JS �� ����ǥ���� ��밡��)���ݾ� �ٸ�
    .(dot) or [] �� ��� ���� 1���ڸ� �ǹ���
    ^ <-- �������ǹ��� ^[0-9] <-- ���ڷ� �����ϴ�
    [^0-9] <-- ���ȣ ���� ^ <-- not�� �ǹ��� 
*/         
-- REGEXP_LIKE : ���Խ� ������ �˻�
SELECT *
FROM member
WHERE  REGEXP_LIKE(mem_comtel, '^..-');
-- ������ 3�� ���� �� @ ���� ��ȸ (abc@gmail.com) 
/* �ݺ������� 
  * : 0�� �̻�
  + : 1�� �̻�
  ? : 0,1��
  {n} : n�� 
  {n,} : �� �̻�
  {n, m} : n�� �̻� m�� ���� 
*/
SELECT *
FROM member
WHERE  REGEXP_LIKE(mem_mail, '^[a-zA-Z]{3,5}@');


-- mem_add2 ���ڶ��⹮�� ������ �����͸� ����Ͻÿ� 
SELECT mem_name
     , mem_add2
FROM member
--WHERE  REGEXP_LIKE(mem_add2, '. .'); -- ��� ���ڵ�
--WHERE  REGEXP_LIKE(mem_add2, '[��-��] [0-9]'); -- �ѱ�
WHERE  REGEXP_LIKE(mem_add2, '[��-��]$'); -- �ѱ۷� ������ $ -> ����������

--�ѱ۸� �ִ� �ּҰ˻�
SELECT mem_name
     , mem_add2
FROM member
WHERE  REGEXP_LIKE(mem_add2, '^[��-��]+$');
-- �ѱ��� ���� �ּҰ˻� 
SELECT mem_name
      ,mem_add2
FROM member
--WHERE REGEXP_LIKE(mem_add2,'^[^��-��]*$');
WHERE NOT REGEXP_LIKE(mem_add2,'[��-��]');
-- | <-- �Ǵ� 
-- () <-- ���ϱ׷� 
-- J�� �����ϸ�, ����° ���ڰ� M�Ǵ� N�� �����̸� ��ȸ 
SELECT emp_name
FROM employees
WHERE REGEXP_LIKE(emp_name, '^J.(n|m)');
-- REGEXP_SUBSTR ����ǥ���� ������ ��ġ�ϴ� ���ڿ� ��ȯ 
-- �̸��� @�� �������� �հ� �� �� ����Ͻÿ� 
                             --����, ������ġ, ��Ī����
SELECT REGEXP_SUBSTR(mem_mail, '[^@]+', 1, 1) as mem_id
     , REGEXP_SUBSTR(mem_mail, '[^@]+', 1, 2) as mem_domain
FROM member;
SELECT REGEXP_SUBSTR('A-B-C', '[^-]+', 1, 1) as a
     , REGEXP_SUBSTR('A-B-C', '[^-]+', 1, 2) as b
     , REGEXP_SUBSTR('A-B-C', '[^-]+', 1, 3) as c
FROM dual;

SELECT REGEXP_SUBSTR('pang su hi 1234', '[0-9]')   -- default 1,1
     , REGEXP_SUBSTR('pang su hi 1234', '[^0-9]')
     , REGEXP_SUBSTR('pang su hi 1234', '[^0-9]+')
FROM dual;

 -- ���⸦ �������� 2��° �����ϴ� �ּҸ� ����Ͻÿ�
SELECT  REGEXP_SUBSTR(mem_add1,'[^ ]+',1,2) as �߰�  
      , REGEXP_SUBSTR(mem_add1,'[��-��]+',1,2) as �߰�2  
FROM member;


SELECT *
FROM (
        SELECT 'abcd1234' as id FROM dual
        UNION 
        SELECT 'Abcd123456' as id FROM dual
        UNION 
        SELECT 'A1234' as id FROM dual
        UNION 
        SELECT 'A123456789cdefg' as id FROM dual
      )
      -- 8 ~ 14 ���� �ؽ�Ʈ �����ϴ� ������ ���
WHERE REGEXP_LIKE(id, '^.{8,14}$') 
;

 SELECT length('A123456789cdefg') as id FROM dual;





          
                 




