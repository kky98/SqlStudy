/* ȸ���� īƮ ���Ƚ���� ���帹�� 
   ���� �������� ���� ������ ����Ͻÿ�(�����̷����ִ�) */
SELECT max(cnt) as max_cnt
     , min(cnt) as min_cnt
FROM(  SELECT a.mem_id, a.mem_name, count(distinct b.cart_no) cnt
        FROM member a
            ,cart b
        WHERE a.mem_id = b.cart_member 
        GROUP BY a.mem_id, a.mem_name
     );
     
SELECT *
FROM(SELECT a.mem_id, a.mem_name, count(distinct b.cart_no) cnt
     FROM member a
         ,cart b
     WHERE a.mem_id = b.cart_member 
     GROUP BY a.mem_id, a.mem_name  )   
WHERE cnt = (SELECT min(cnt) as min_cnt
            FROM(  SELECT a.mem_id, a.mem_name, count(distinct b.cart_no) cnt
                    FROM member a
                        ,cart b
                    WHERE a.mem_id = b.cart_member 
                    GROUP BY a.mem_id, a.mem_name
                 )
            ) 
OR    cnt = (
            SELECT max(cnt) as max_cnt
            FROM(  SELECT a.mem_id, a.mem_name, count(distinct b.cart_no) cnt
                    FROM member a
                        ,cart b
                    WHERE a.mem_id = b.cart_member 
                    GROUP BY a.mem_id, a.mem_name
                 )
            );

-- WITH 
WITH T1 AS (SELECT a.mem_id, a.mem_name, count(distinct b.cart_no) cnt
            FROM member a
                ,cart b
            WHERE a.mem_id = b.cart_member 
            GROUP BY a.mem_id, a.mem_name
)  
, T2 AS(
           SELECT MAX(T1.cnt) as max_cnt, MIN(T1.cnt) as min_cnt
           FROM T1
) 
SELECT T1.mem_id, T1.mem_name, T1.cnt
FROM T1, T2
WHERE T1.cnt = T2.max_cnt
OR    T1.cnt = T2.min_cnt;

WITH A as(
   SELECT *
   FROM member
)
SELECT *
FROM a;

------- 
WITH T1 as (SELECT a.�̸�, a.�й�, a.�б�, b.����������ȣ, b.�����ȣ 
            FROM �л� a, �������� b
            WHERE a.�й� = b.�й�(+)
)
, T2 as (  
           SELECT T1.�̸�, T1.�й�, COUNT(T1.����������ȣ)as �����̷°Ǽ�
           FROM T1
           GROUP BY T1.�̸�, T1.�й�
)
, T3 as (
           SELECT T1.�̸�, T1.�й�, SUM(����.����) as ��ü��������
           FROM T1, ���� 
           WHERE T1.�����ȣ = ����.�����ȣ(+)
           GROUP BY T1.�̸�, T1.�й�
)
SELECT t1.�й�,t1.�̸�, max(t2.�����̷°Ǽ�), max(t3.��ü��������)
FROM t1, t2, t3
WHERE t1.�й� = t2.�й�
AND   t1.�й� = t3.�й�
GROUP BY t1.�й�,t1.�̸�;

/*  WITH �� 
    ��Ī���� ����� select���� �ٸ� �������� ������ ����
    �ݺ��Ǵ� ���������� 1���� ����ó�� ��밡�� 
    ��������� Ʃ�׽� ���� ���
    **����
    - temp��� �ӽ� ���̺��� ����ؼ� ��ð� �ɸ��� ���� ����� �����ؼ� 
      ������(����)������ �ݺ��ǰ� �Ǽ������� ���̺��� ��ȸ�Ҷ� ������ ����. 
    oracle 9���� �̻󿡼� ������.
    - �������� ���� ������ ����.
    **���� 
    - �޸𸮿� ��ȸ����� �÷����� ����ϱ� ������ ������ ���ɿ� ������ �ټ�����.
    - WITH�� �����ϴ� ������Ʈ�� �ֱ� ������(Ȯ�� �� ���)
*/
---------------------------------------
-- 2000�⵵ ��Ż������ ����� ����� ���� ū ���� ��� ������� 
-- '���', '�����'�� ����Ͻÿ� (�Ҽ��� �ݿø�)
SELECT cust_id, sales_month, amount_sold 
FROM sales;
SELECT cust_id, country_id 
FROM customers;
SELECT country_id, country_name
FROM countries;
SELECT *
FROM (
        SELECT a.sales_month
             , round(avg(a.amount_sold)) as month_avg
        FROM sales a, customers b, countries c
        WHERE a.cust_id = b.cust_id
        AND   b.country_id = c.country_id
        AND   a.sales_month LIKE '2000%'
        AND   c.country_name = 'Italy'
        GROUP BY a.sales_month
    )
WHERE month_avg > (
                    SELECT round(avg(a.amount_sold)) as year_avg
                    FROM sales a, customers b, countries c
                    WHERE a.cust_id = b.cust_id
                    AND   b.country_id = c.country_id
                    AND   a.sales_month LIKE '2000%'
                    AND   c.country_name = 'Italy'
                    );

---- with 
WITH T1 as (
        SELECT a.sales_month
             , a.amount_sold
        FROM sales a, customers b, countries c
        WHERE a.cust_id = b.cust_id
        AND   b.country_id = c.country_id
        AND   a.sales_month LIKE '2000%'
        AND   c.country_name = 'Italy'
)
, T2 as (
            SELECT AVG(t1.amount_sold) as year_avg
            FROM t1
)
, T3 as (
            SELECT  t1.sales_month
                  , AVG(t1.amount_sold) as month_avg
            FROM t1
            GROUP BY t1.sales_month
)
SELECT t3.sales_month
      ,t3.month_avg
FROM t2, t3
WHERE t3.month_avg > t2.year_avg;





SELECT round(avg(a.amount_sold)) as year_avg
FROM sales a, customers b, countries c
WHERE a.cust_id = b.cust_id
AND   b.country_id = c.country_id
AND   a.sales_month LIKE '2000%'
AND   c.country_name = 'Italy';





WITH T1 as (
           SELECT a.sales_month, a.amount_sold
           FROM sales a,
                customers b,
                countries c
          WHERE a.sales_month BETWEEN '200001' AND '200012'
            AND a.cust_id = b.CUST_ID
            AND b.COUNTRY_ID = c.COUNTRY_ID
            AND c.COUNTRY_NAME = 'Italy'     
)
, T2 AS (
          SELECT t1.sales_month, ROUND(AVG(t1.amount_sold)) as month_avg
           FROM t1
           GROUP BY t1.sales_month
), T3 AS ( SELECT AVG(t1.amount_sold) as year_avg
           FROM t1
)
SELECT T2.sales_month
     , T2.month_avg
FROM T2, T3
WHERE T2.month_avg > T3.year_avg;


SELECT a.* 
  FROM ( SELECT a.sales_month, ROUND(AVG(a.amount_sold)) AS month_avg
           FROM sales a,
                customers b,
                countries c
          WHERE a.sales_month BETWEEN '200001' AND '200012'
            AND a.cust_id = b.CUST_ID
            AND b.COUNTRY_ID = c.COUNTRY_ID
            AND c.COUNTRY_NAME = 'Italy'     
          GROUP BY a.sales_month  
       )  a,
       ( SELECT ROUND(AVG(a.amount_sold)) AS year_avg
           FROM sales a,
                customers b,
                countries c
          WHERE a.sales_month BETWEEN '200001' AND '200012'
            AND a.cust_id = b.CUST_ID
            AND b.COUNTRY_ID = c.COUNTRY_ID
            AND c.COUNTRY_NAME = 'Italy'       
       ) b
 WHERE a.month_avg > b.year_avg ;





            
            
            
            
            
            
