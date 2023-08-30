-----------1�� ���� ---------------------------------------------------
--1988�� ���� ������� ������ �ǻ�,�ڿ��� ���� ����Ͻÿ� (� ������ ���)
desc customer;
SELECT *
FROM customer
WHERE 1=1
AND TO_NUMBER(SUBSTR(birth,1, 4)) >= 1988
AND job IN('�ǻ�','�ڿ���');
--aND eamil = '';
--aND eamil = '';
---------------------------------------------------------------------
-----------2�� ���� ---------------------------------------------------
--'������'�� ��� ���� �̸�, ��ȭ��ȣ�� ����Ͻÿ� 
---------------------------------------------------------------------
SELECT a.customer_name
     , a.phone_number
FROM customer a
   , address b
WHERE a.zip_code = b.zip_code
AND b.address_detail = '������';
----------3�� ���� ---------------------------------------------------
--CUSTOMER�� �ִ� ȸ���� ������ ȸ���� ���� ����Ͻÿ� (���� NULL�� ����)
---------------------------------------------------------------------
SELECT job
    , count(*) as cnt
FROM customer
WHERE job IS NOT NULL
GROUP BY job
ORDER BY 2 DESC;
----------4-1�� ���� ---------------------------------------------------
-- ���� ���� ����(ó�����)�� ���ϰ� �Ǽ��� ����Ͻÿ� 
---------------------------------------------------------------------
SELECT *
FROM (
        SELECT TO_CHAR(first_reg_date, 'day') as ����
             , COUNT(*) as cnt
        FROM customer
        GROUP BY TO_CHAR(first_reg_date, 'day')
        ORDER BY 2 DESC
      )
WHERE rownum <= 1;
----------4-2�� ���� ---------------------------------------------------
-- ���� �ο����� ����Ͻÿ� 
---------------------------------------------------------------------
SELECT NVL(gender,'�հ�') as gender
     , count(*) as cnt
FROM(
        SELECT DECODE(sex_code,'M','����','F','����','�̵��') as gender
        FROM customer
     )
GROUP BY ROLLUP(gender)
;
-- grouping_id : group  by ������ �׷�ȭ�� ������ ��, ���� �÷��� ���� 
--                         ���� ��Ż�� ���� �����ϱ� ���� �Լ�
SELECT CASE WHEN sex_code ='F' THEN '����'
            WHEN sex_code ='M' THEN '����'
            WHEN sex_code IS NULL AND groupid =0 THEN '�̵��'
            ELSE '�հ�'
        END as gender
      ,cnt 
FROM(  SELECT sex_code , grouping_id(sex_code) as groupid, count(*) as cnt
        FROM customer
        GROUP BY ROLLUP(sex_code)
     );





SELECT job, sex_code
     , grouping_id(job, sex_code) as groupid
     , count(*) as cnt
FROM customer
WHERE job IS NOT NULL
AND sex_code IS NOT NULL
GROUP BY  ROLLUP(job, sex_code)
ORDER BY 1, 2 ;

----------5�� ���� ---------------------------------------------------
--���� ���� ��� �Ǽ��� ����Ͻÿ� (���� �� ���� ���)
---------------------------------------------------------------------
SELECT TO_CHAR(TO_DATE(reserv_date),'MM') as ��
    , COUNT(*) as ��ҰǼ�
FROM reservation
WHERE cancel = 'Y'
GROUP BY TO_CHAR(TO_DATE(reserv_date),'MM')
ORDER BY 2 desc;
desc reservation;
----------6�� ���� ---------------------------------------------------
 -- ��ü ��ǰ�� '��ǰ�̸�', '��ǰ����' �� ������������ ���Ͻÿ� 
-----------------------------------------------------------------------------
SELECT *
FROM item;
SELECT  b.product_name
      , SUM(a.sales) as ��ǰ����
FROM order_info a 
    ,item b 
WHERE a.item_id = b.item_id
GROUP BY a.item_id
       , b.product_name
ORDER BY 2 DESC;
---------- 7�� ���� ---------------------------------------------------
-- ����ǰ�� ���� ������� ���Ͻÿ� 
-- �����, SPECIAL_SET, PASTA, PIZZA, SEA_FOOD, STEAK, SALAD_BAR, SALAD, SANDWICH, WINE, JUICE
----------------------------------------------------------------------------
SELECT SUBSTR(a.reserv_date,1,6) as �����
     , SUM(DECODE(b.item_id,'M0001',b.sales, 0)) as SPECIAL_SET
     , SUM(DECODE(b.item_id,'M0002',b.sales, 0)) as PASTA
     , SUM(DECODE(b.item_id,'M0003',b.sales, 0)) as PIZZA
     , SUM(DECODE(b.item_id,'M0004',b.sales, 0)) as SEA_FOOD
FROM reservation a
   , order_info b
WHERE a.reserv_no = b.reserv_no
GROUP BY SUBSTR(a.reserv_date,1,6)
;

SELECT *
FROM order_info;

---------- 8�� ���� ---------------------------------------------------
-- ���� �¶���_���� ��ǰ ������� �Ͽ��Ϻ��� �����ϱ��� ������ ����Ͻÿ� 
-- ��¥, ��ǰ��, �Ͽ���, ������, ȭ����, ������, �����, �ݿ���, ������� ������ ���Ͻÿ� 
----------------------------------------------------------------------------
SELECT �����
     , ��ǰ�̸�
     , SUM(DECODE(����, '�Ͽ���', sales, 0)) as �Ͽ���
     , SUM(DECODE(����, '������', sales, 0)) as ������
FROM ( 
        SELECT SUBSTR(a.reserv_date,1,6)             as �����
             , c.product_desc                        as ��ǰ�̸�
             , TO_CHAR(TO_DATE(a.reserv_date),'day') as ����
             , b.sales
        FROM reservation a, order_info b, item c
        WHERE a.reserv_no = b.reserv_no 
        AND   b.item_id = c.item_id
        AND   c.product_desc = '�¶���_�����ǰ'
       )
GROUP BY �����, ��ǰ�̸�;
---------- 9�� ���� ----------------------------------------------------
--�����̷��� �ִ� ���� �ּ�, �����ȣ, �ش����� ������ ����Ͻÿ�
----------------------------------------------------------------------------
SELECT t2.address_detail as �ּ�
     , count(*)          as ȸ����
FROM (  SELECT DISTINCT a.customer_id, a.zip_code
        FROM customer a, reservation b, order_info c
        WHERE a.customer_id= b.customer_id
        AND   b.reserv_no = c.reserv_no 
      ) T1 , address T2
WHERE t1.zip_code = t2.zip_code
GROUP BY t1.zip_code, t2.address_detail
ORDER BY 2 DESC;

-------------------------------------
--- ���� ����(branch) �湮Ƚ���� �湮���� ���� ���
--  �湮Ƚ���� 4�� �̻� ����Ͻÿ� (������Ұ� ����) ����(�湮Ƚ�� ����, �湮���� ����)
SELECT *
FROM customer;

SELECT a.customer_id , a.customer_name, b.branch
     , COUNT(b.branch) as �湮Ƚ��
     , SUM(b.visitor_cnt) as �湮����
FROM customer a, reservation b
WHERE a.customer_id = b.customer_id
AND b.cancel = 'N'
GROUP BY a.customer_id, a.customer_name, b.branch
HAVING COUNT(b.branch) >= 4
ORDER BY 4 DESC, 5 DESC;
-- ���� �湮�� ���� �� ���� �׵��� ������ ǰ�� �ջ�ݾ��� ����Ͻÿ�  


SELECT customer_id
FROM (
        SELECT a.customer_id , a.customer_name, b.branch
             , COUNT(b.branch) as �湮Ƚ��
             , SUM(b.visitor_cnt) as �湮����
        FROM customer a, reservation b
        WHERE a.customer_id = b.customer_id
        AND b.cancel = 'N'
        GROUP BY a.customer_id, a.customer_name, b.branch
        ORDER BY 4 DESC, 5 DESC
       )
WHERE rownum <=1 ;
-- W1338910
SELECT reserv_no 
FROM reservation 
WHERE cancel = 'N'
AND customer_id ='W1338910';
---�����̷��հ�
SELECT (SELECT product_name FROM item WHERE item_id = a.item_id) as category
     , SUM(a.sales) as �����հ�
FROM order_info a
WHERE a.reserv_no IN( 2017111303,2017110702)
GROUP BY a.item_id;

SELECT (SELECT product_name FROM item WHERE item_id = a.item_id) as category
     , SUM(a.sales) as �����հ�
FROM order_info a
WHERE a.reserv_no IN (SELECT reserv_no 
                        FROM reservation 
                        WHERE cancel = 'N'
                        AND customer_id =(SELECT customer_id
                                            FROM (
                                                    SELECT a.customer_id , a.customer_name, b.branch
                                                         , COUNT(b.branch) as �湮Ƚ��
                                                         , SUM(b.visitor_cnt) as �湮����
                                                    FROM customer a, reservation b
                                                    WHERE a.customer_id = b.customer_id
                                                    AND b.cancel = 'N'
                                                    GROUP BY a.customer_id, a.customer_name, b.branch
                                                    ORDER BY 4 DESC, 5 DESC
                                                   )
                                            WHERE rownum <=1 )
                        )
GROUP BY a.item_id;







SELECT a.customer_id
     , a.customer_name
     , b.branch
     , COUNT(b.branch)    as �����湮Ƚ��
     , SUM(b.visitor_cnt) as �湮����
FROM customer a, reservation b
WHERE a.customer_id = b.customer_id
AND   b.cancel = 'N'
GROUP BY a.customer_id, a.customer_name, b.branch
HAVING COUNT(b.branch) >= 4
ORDER BY 4 DESC, 5 DESC;






