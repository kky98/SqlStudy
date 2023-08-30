-----------1번 문제 ---------------------------------------------------
--1988년 이후 출생자의 직업이 의사,자영업 고객을 출력하시오 (어린 고객부터 출력)
desc customer;
SELECT *
FROM customer
WHERE 1=1
AND TO_NUMBER(SUBSTR(birth,1, 4)) >= 1988
AND job IN('의사','자영업');
--aND eamil = '';
--aND eamil = '';
---------------------------------------------------------------------
-----------2번 문제 ---------------------------------------------------
--'강남구'에 사는 고객의 이름, 전화번호를 출력하시오 
---------------------------------------------------------------------
SELECT a.customer_name
     , a.phone_number
FROM customer a
   , address b
WHERE a.zip_code = b.zip_code
AND b.address_detail = '강남구';
----------3번 문제 ---------------------------------------------------
--CUSTOMER에 있는 회원의 직업별 회원의 수를 출력하시오 (직업 NULL은 제외)
---------------------------------------------------------------------
SELECT job
    , count(*) as cnt
FROM customer
WHERE job IS NOT NULL
GROUP BY job
ORDER BY 2 DESC;
----------4-1번 문제 ---------------------------------------------------
-- 가장 많이 가입(처음등록)한 요일과 건수를 출력하시오 
---------------------------------------------------------------------
SELECT *
FROM (
        SELECT TO_CHAR(first_reg_date, 'day') as 요일
             , COUNT(*) as cnt
        FROM customer
        GROUP BY TO_CHAR(first_reg_date, 'day')
        ORDER BY 2 DESC
      )
WHERE rownum <= 1;
----------4-2번 문제 ---------------------------------------------------
-- 남녀 인원수를 출력하시오 
---------------------------------------------------------------------
SELECT NVL(gender,'합계') as gender
     , count(*) as cnt
FROM(
        SELECT DECODE(sex_code,'M','남자','F','여자','미등록') as gender
        FROM customer
     )
GROUP BY ROLLUP(gender)
;
-- grouping_id : group  by 절에서 그룹화를 진행할 때, 여러 컬럼에 대한 
--                         서브 토탈을 쉽게 구별하기 위한 함수
SELECT CASE WHEN sex_code ='F' THEN '여자'
            WHEN sex_code ='M' THEN '남자'
            WHEN sex_code IS NULL AND groupid =0 THEN '미등록'
            ELSE '합계'
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

----------5번 문제 ---------------------------------------------------
--월별 예약 취소 건수를 출력하시오 (많은 달 부터 출력)
---------------------------------------------------------------------
SELECT TO_CHAR(TO_DATE(reserv_date),'MM') as 월
    , COUNT(*) as 취소건수
FROM reservation
WHERE cancel = 'Y'
GROUP BY TO_CHAR(TO_DATE(reserv_date),'MM')
ORDER BY 2 desc;
desc reservation;
----------6번 문제 ---------------------------------------------------
 -- 전체 상품별 '상품이름', '상품매출' 을 내림차순으로 구하시오 
-----------------------------------------------------------------------------
SELECT *
FROM item;
SELECT  b.product_name
      , SUM(a.sales) as 상품매출
FROM order_info a 
    ,item b 
WHERE a.item_id = b.item_id
GROUP BY a.item_id
       , b.product_name
ORDER BY 2 DESC;
---------- 7번 문제 ---------------------------------------------------
-- 모든상품의 월별 매출액을 구하시오 
-- 매출월, SPECIAL_SET, PASTA, PIZZA, SEA_FOOD, STEAK, SALAD_BAR, SALAD, SANDWICH, WINE, JUICE
----------------------------------------------------------------------------
SELECT SUBSTR(a.reserv_date,1,6) as 매출월
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

---------- 8번 문제 ---------------------------------------------------
-- 월별 온라인_전용 상품 매출액을 일요일부터 월요일까지 구분해 출력하시오 
-- 날짜, 상품명, 일요일, 월요일, 화요일, 수요일, 목요일, 금요일, 토요일의 매출을 구하시오 
----------------------------------------------------------------------------
SELECT 매출월
     , 상품이름
     , SUM(DECODE(요일, '일요일', sales, 0)) as 일요일
     , SUM(DECODE(요일, '월요일', sales, 0)) as 월요일
FROM ( 
        SELECT SUBSTR(a.reserv_date,1,6)             as 매출월
             , c.product_desc                        as 상품이름
             , TO_CHAR(TO_DATE(a.reserv_date),'day') as 요일
             , b.sales
        FROM reservation a, order_info b, item c
        WHERE a.reserv_no = b.reserv_no 
        AND   b.item_id = c.item_id
        AND   c.product_desc = '온라인_전용상품'
       )
GROUP BY 매출월, 상품이름;
---------- 9번 문제 ----------------------------------------------------
--매출이력이 있는 고객의 주소, 우편번호, 해당지역 고객수를 출력하시오
----------------------------------------------------------------------------
SELECT t2.address_detail as 주소
     , count(*)          as 회원수
FROM (  SELECT DISTINCT a.customer_id, a.zip_code
        FROM customer a, reservation b, order_info c
        WHERE a.customer_id= b.customer_id
        AND   b.reserv_no = c.reserv_no 
      ) T1 , address T2
WHERE t1.zip_code = t2.zip_code
GROUP BY t1.zip_code, t2.address_detail
ORDER BY 2 DESC;

-------------------------------------
--- 고객별 지점(branch) 방문횟수와 방문객의 합을 출력
--  방문횟수가 4번 이상만 출력하시오 (예약취소건 제외) 정렬(방문횟수 내림, 방문객수 내림)
SELECT *
FROM customer;

SELECT a.customer_id , a.customer_name, b.branch
     , COUNT(b.branch) as 방문횟수
     , SUM(b.visitor_cnt) as 방문고객수
FROM customer a, reservation b
WHERE a.customer_id = b.customer_id
AND b.cancel = 'N'
GROUP BY a.customer_id, a.customer_name, b.branch
HAVING COUNT(b.branch) >= 4
ORDER BY 4 DESC, 5 DESC;
-- 가장 방문을 많이 한 고객의 그동한 구매한 품목별 합산금액을 출력하시오  


SELECT customer_id
FROM (
        SELECT a.customer_id , a.customer_name, b.branch
             , COUNT(b.branch) as 방문횟수
             , SUM(b.visitor_cnt) as 방문고객수
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
---구매이력합계
SELECT (SELECT product_name FROM item WHERE item_id = a.item_id) as category
     , SUM(a.sales) as 구매합계
FROM order_info a
WHERE a.reserv_no IN( 2017111303,2017110702)
GROUP BY a.item_id;

SELECT (SELECT product_name FROM item WHERE item_id = a.item_id) as category
     , SUM(a.sales) as 구매합계
FROM order_info a
WHERE a.reserv_no IN (SELECT reserv_no 
                        FROM reservation 
                        WHERE cancel = 'N'
                        AND customer_id =(SELECT customer_id
                                            FROM (
                                                    SELECT a.customer_id , a.customer_name, b.branch
                                                         , COUNT(b.branch) as 방문횟수
                                                         , SUM(b.visitor_cnt) as 방문고객수
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
     , COUNT(b.branch)    as 지점방문횟수
     , SUM(b.visitor_cnt) as 방문객수
FROM customer a, reservation b
WHERE a.customer_id = b.customer_id
AND   b.cancel = 'N'
GROUP BY a.customer_id, a.customer_name, b.branch
HAVING COUNT(b.branch) >= 4
ORDER BY 4 DESC, 5 DESC;






