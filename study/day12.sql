/* 회원중 카트 사용횟수가 가장많은 
   고객과 가장적은 고객의 정보를 출력하시오(구매이력이있는) */
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
WITH T1 as (SELECT a.이름, a.학번, a.학기, b.수강내역번호, b.과목번호 
            FROM 학생 a, 수강내역 b
            WHERE a.학번 = b.학번(+)
)
, T2 as (  
           SELECT T1.이름, T1.학번, COUNT(T1.수강내역번호)as 수강이력건수
           FROM T1
           GROUP BY T1.이름, T1.학번
)
, T3 as (
           SELECT T1.이름, T1.학번, SUM(과목.학점) as 전체수강학점
           FROM T1, 과목 
           WHERE T1.과목번호 = 과목.과목번호(+)
           GROUP BY T1.이름, T1.학번
)
SELECT t1.학번,t1.이름, max(t2.수강이력건수), max(t3.전체수강학점)
FROM t1, t2, t3
WHERE t1.학번 = t2.학번
AND   t1.학번 = t3.학번
GROUP BY t1.학번,t1.이름;

/*  WITH 절 
    별칭으로 사용한 select문을 다른 구문에서 참조가 가능
    반복되는 서브쿼리를 1개로 변수처럼 사용가능 
    통계쿼리나 튜닝시 많이 사용
    **장점
    - temp라는 임시 테이블을 사용해서 장시간 걸리는 쿼리 결과를 저장해서 
      엑세스(접근)때문에 반복되고 건수가많은 테이블을 조회할때 성능이 좋다. 
    oracle 9버전 이상에서 지원함.
    - 가독성이 좋은 장점이 있음.
    **단점 
    - 메모리에 조회결과를 올려놓고 사용하기 때문에 오히려 성능에 문제를 줄수있음.
    - WITH를 제한하는 프로젝트도 있기 때문에(확인 후 사용)
*/
---------------------------------------
-- 2000년도 이탈리아의 연평균 매출액 보다 큰 월의 평균 매출액의 
-- '년월', '매출액'을 출력하시오 (소수점 반올림)
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





            
            
            
            
            
            
