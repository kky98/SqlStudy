/* 
     �μ��� ������ salary�� ������� ������ ����Ͻÿ� 
*/
SELECT *
FROM(  SELECT emp_name, salary, department_id
             , RANK() OVER(PARTITION BY department_id ORDER BY salary DESC) as rnk
        FROM employees
      )
WHERE rnk =1;

-- �л��� ������ ������ ���� ���� �л��� ������ ����Ͻÿ� 

SELECT *
FROM(
        SELECT a.*
             , RANK() OVER(PARTITION BY a.���� ORDER BY a.���� DESC) as rnk
             , RANK() OVER(ORDER BY a.���� DESC) as all_rnk
             , COUNT(*) OVER() as ��ü�л���
             , AVG(a.����) OVER() as ��ü���
        FROM �л� a 
    )
WHERE rnk = 1;
/*
     �ο�ս� ���� ���谪 ����
     partition by ���� window ���� Ȱ���Ͽ� ���� ���踦 �� �� ����.
     AVG,SUM,MAX,MIN,COUNT,RANK,DENSE_RANK, LAG, ROW_NUMBER...
     PARTITION BY �� : ��� ��� �׷� 
     ORDER BY     �� : ��� �׷쿡���� ����
     WINDOW       �� : ��Ƽ������ ���ҵ� �׷쿡 ���� �� ���� �׷����� ����
*/
-- CART, PROD ��ǰ�� prod_sale �հ��� ���� 10�� ��ǰ�� ����Ͻÿ� 


SELECT *
FROM (  SELECT c.*
             , RANK() OVER(ORDER BY sale_sum DESC) as rnk
        FROM ( SELECT a.cart_prod, b.prod_name   
                      ,SUM(b.prod_sale * a.cart_qty) as sale_sum
               FROM cart a, prod b
               WHERE a.cart_prod = b.prod_id
               GROUP BY a.cart_prod, b.prod_name
            ) C
    )
WHERE rnk <= 10;
-- �����Լ� + �м��Լ� (ǥ���Ŀ� �°� ����ϸ��)
SELECT *
FROM (  SELECT a.cart_prod, b.prod_name   
              ,RANK()OVER(ORDER BY SUM(b.prod_sale * a.cart_qty) DESC) as rnk
        FROM cart a, prod b
        WHERE a.cart_prod = b.prod_id
        GROUP BY a.cart_prod, b.prod_name
     )
WHERE rnk <= 10;
/*  
    NTILE(expr) ��Ƽ�Ǻ��� expr ��õ� ����ŭ ������ ����� ��ȯ 
    NTILE(3) 1 ~ 3 �� ���� ��ȯ(�����ϴ� ���� ��Ŷ �� �����) 
    NTILE(4)  -> 100/4 -> 25% �� ���� ���� 
*/
SELECT emp_name, salary, department_id 
      ,NTILE(2) OVER(PARTITION BY department_id ORDER BY salary DESC) group_num
      ,COUNT(*) OVER(PARTITION BY department_id) as �μ�������
FROM employees
WHERE department_id IN(30,60);
-- ��ü ������ �޿��� 10������ ���������� 1������ ���ϴ� ������ ��ȸ�Ͻÿ� 
SELECT emp_name, salary
     , NTILE(10) OVER(ORDER BY salary DESC) as ����
FROM employees; 

CREATE TABLE temp_team  AS
SELECT nm
     , NTILE(6) OVER(ORDER BY DBMS_RANDOM.VALUE ) as team
FROM tb_info;

SELECT DBMS_RANDOM.VALUE() as "0~1" -- ���� ��������
     , ROUND(DBMS_RANDOM.VALUE() * 10) as "0~10" -- ���� ��������
FROM dual;
-- 202301 ~202312 ���� �� 1000���� ������ ����  100 ~1000 ���� �� 
CREATE TABLE tb_sample AS
SELECT ROWNUM as seq
     , '2023' || LPAD(CEIL(ROWNUM/1000), 2, '0') as month
     , ROUND(DBMS_RANDOM.VALUE(100, 1000)) as amt
FROM dual
CONNECT BY LEVEL <= 12000;

SELECT DBMS_RANDOM.STRING('U', 5) -- ���ĺ� �빮�� 5�ڸ� �������� 
     , DBMS_RANDOM.STRING('L', 5) -- �ҹ���
     , DBMS_RANDOM.STRING('A', 5) -- ��ҹ���
     , DBMS_RANDOM.STRING('X', 5) -- ���ĺ� �빮�� & ����
     , DBMS_RANDOM.STRING('P', 5) -- ��ҹ���,����,Ư������
FROM dual;
--



SELECT *
FROM tb_sample;

--FROM- > WHERE -> GROUP BY -> HAVING  -> SELECT -> ORDER BY 
SELECT *
FROM temp_team;


SELECT nm
     , substr(mbti,1,1) as ������
     , substr(mbti,2,1) as �νĹ��
     , substr(mbti,3,1) as �Ǵ�
     , substr(mbti,4,1) as ��Ȱ���
FROM tb_info;

/*  �־��� �׷�� ������ ���� row�� �ִ� ���� �����Ҷ� ���
    LAG(expr, offset, default_value)  ����ο��� �� ���� 
    LEAD(expr, offset, default_value) ����ο��� �� ����
*/
SELECT emp_name, department_id, salary
      ,LAG(emp_name, 1, '�������') OVER(PARTITION BY department_id
                                        ORDER BY salary DESC) as emp_lag
      ,LEAD(emp_name, 1, '���� ����') OVER(PARTITION BY department_id
                                        ORDER BY salary DESC) as emp_lead
FROM employees;

/*
      �л��� ������ �������� �Ѵܰ� ���� �л��� ������ ���̸� ����Ͻÿ� 
      ����  �̸�   ����  �����л��̸�   ���������� ���� 
      1��   �ؼ�   4.5   ����               0
      2��   �浿   4.3   �ؼ�              0.2
      3��   ����   3.0   �浿              1.3   
      LAG(emp_name, 1, '�������') �Ű�����1,3�� Ÿ���� ���ƾ���  
      �Ҽ��� 2° �ڸ����� �ݿø� 
*/
SELECT �̸�, ROUND(����,2) as                                    ������
     , LAG(�̸�,1,'����') OVER(ORDER BY ���� DESC)                �����л�
     , ROUND(LAG(����,1,����) OVER(ORDER BY ���� DESC) - ����,2)  ������������
FROM �л�;




SELECT �̸�
     , ROUND(����,2) as ����
     , LAG(�̸�, 1, '����') OVER(ORDER BY ���� DESC) �����л��̸�
     , ROUND(LAG(����, 1, ����) OVER(ORDER BY ���� DESC) - ����,2) ��������
FROM �л� ;




CREATE TABLE bbs (
 bbs_no	      NUMBER  PRIMARY KEY
,parent_no	  NUMBER
,bbs_title	  VARCHAR2(1000)  DEFAULT NULL  -- ����� ��� null
,bbs_content  VARCHAR2(4000)  NOT NULL
,author_id	  VARCHAR2(100)
,create_dt	  TIMESTAMP DEFAULT CURRENT_TIMESTAMP -- ����� ������ �ð�
,update_dt	  TIMESTAMP DEFAULT CURRENT_TIMESTAMP
,CONSTRAINT fk_prent FOREIGN KEY(parent_no) 
 REFERENCES bbs(bbs_no) ON DELETE CASCADE 
  -- �Խñ��� no�� �����ϰ� ���� ������ ������ ���� ���� 
,CONSTRAINT fk_user  FOREIGN KEY(author_id) 
 REFERENCES tb_user(user_id) ON DELETE CASCADE  -- ���� Ż��� ���� ���� 
);
-- �Խñ۹�ȣ ������ 
CREATE SEQUENCE bbs_seq START WITH 1 INCREMENT BY 1;

INSERT INTO bbs(bbs_no, bbs_title, bbs_content, author_id) 
VALUES(bbs_seq.NEXTVAL, '��������', '������ �ݿ��� �Դϴ�.!!!!','a001');
INSERT INTO bbs(bbs_no, bbs_title, bbs_content, author_id) 
VALUES(bbs_seq.NEXTVAL, '�Խñ�1', '�Խñ� 1�Դϴ�.','b001');
INSERT INTO bbs(bbs_no, parent_no, bbs_content, author_id) 
VALUES(bbs_seq.NEXTVAL, 1, '�� �������̿���...','x001');

-- ����� �ִ� �Խñ۰� �ش� �Խñ��� ����� ����Ͻÿ� 

select *
from bbs
START WITH bbs_no =1
CONNECT BY PRIOR bbs_no = parent_no;


SELECT level,a.*
FROM bbs a
START WITH bbs_no=1
CONNECT BY PRIOR a.bbs_no = a.parent_no
;



SELECT *
FROM tb_user;

SELECT *
FROM user_tab_columns
WHERE table_name = 'TB_USER';

SELECT user_id
     , user_nm
     , user_pw
     , user_mileage
FROM tb_user
WHERE user_id = 'a001';

INSERT INTO tb_user (user_id, user_nm, user_pw, create_dt)
VALUES (?,?,?, SYSDATE) ;

SELECT *
FROM tb_user;
SELECT   ROWNUM          as rnum
       , COUNT(*) OVER() as all_cnt
       , a.bbs_no        as bbs_no 
       , a.bbs_title     as bbs_title
       , a.author_id     as author_id
       , a.update_dt     as update_dt
FROM(   SELECT bbs_no, bbs_title, author_id  
             , TO_CHAR(update_dt,'YYMMDD HH24:MI:SS') as update_dt
        FROM bbs
        WHERE parent_no IS NULL
        ORDER BY update_dt DESC
     ) a 
;










select *
from tb_user;





SELECT *
FROM( 
SELECT c.*
     , RANK() OVER(ORDER BY sale_sum DESC) as rnk_sale
FROM (
        SELECT a.cart_prod   /*��ǰ���̵�*/
              ,b.prod_name   /*��ǰ�̸�*/
              ,SUM(a.cart_qty * b.prod_sale) as sale_sum
        FROM cart a 
            ,prod b
        WHERE a.cart_prod = b.prod_id
        GROUP BY a.cart_prod,b.prod_name
    )c
)
WHERE rnk_sale <=10
;
