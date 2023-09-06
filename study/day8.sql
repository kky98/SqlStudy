/* INNER JOIN 내부조인(동등조인) */
SELECT *
FROM 학생 ;
SELECT *
FROM 수강내역;

SELECT 학생.학번
     , 학생.이름
     , 학생.전공
     , 수강내역.수강내역번호 
     , 수강내역.과목번호
     , 과목.과목이름 
FROM 학생, 수강내역, 과목 
WHERE 학생.학번 = 수강내역.학번
AND   수강내역.과목번호 = 과목.과목번호 
AND   학생.이름 = '최숙경';

-- 최숙경의 수강 총학점을 출력하시오 
SELECT  학생.학번
      , 학생.이름
      , SUM(과목.학점) as 수강학점
FROM 학생, 수강내역, 과목 
WHERE 학생.학번 = 수강내역.학번
AND   수강내역.과목번호 = 과목.과목번호 
AND   학생.이름 = '최숙경'
GROUP BY 학생.학번
        ,학생.이름;
        
/* OUTER JOIN 외부조인
   어느 한쪽에 null 값을 포함시켜야 할때 
   (보통은 마스터테이블은 무조건 포함시켜야하면 아웃터조인을함)
*/        
SELECT  *
FROM 학생, 수강내역                       -- null을 포함시킬 테이블쪽
WHERE 학생.학번 = 수강내역.학번(+)    -- (+) <-- 한쪽에만 쓸수 있음 
AND  학생.이름 ='양지운';

-- 학생의 수강이력 건수, 총수강 학점을 출력하시오 
-- 모든학생 출력 null이면 0으로 
SELECT  학생.학번
      , 학생.이름
      , COUNT(수강내역.수강내역번호) as 수강내역건수
      , SUM(NVL(과목.학점,0)) as 수강학점
FROM 학생, 수강내역, 과목              
WHERE 학생.학번 = 수강내역.학번(+)
AND   수강내역.과목번호 = 과목.과목번호(+)
GROUP BY 학생.학번
       , 학생.이름
ORDER BY 3 DESC;


SELECT *
FROM 학생, 수강내역
WHERE 학생.학번 = 수강내역.학번 (+);


SELECT 학생.학번
     , 학생.이름
     , 학생.전공
     , 수강내역.수강내역번호 
     , (SELECT 과목이름   -- 스칼라 서브쿼리 (단일행 사용가능)
        FROM 과목 
        WHERE 과목번호 = 수강내역.과목번호) as 과목이름
FROM 학생, 수강내역
WHERE 학생.학번 = 수강내역.학번
AND   학생.이름 = '최숙경';

/* 학생의 전 공별 인원수를 출력하시오  */
SELECT 전공
     , COUNT(*) as 학생수
FROM 학생
GROUP BY 전공
ORDER BY 2 DESC;


/* 학생의 '평균평점' 보다 높은 학생을 출력하시오 */
SELECT 이름, 평점 
FROM 학생
WHERE 평점 >= (SELECT AVG(평점)
               FROM 학생)   -- 중첩 서브쿼리 
ORDER BY 2 DESC;

SELECT 이름, 평점 
FROM 학생
WHERE 평점 = (SELECT MAX(평점)
             FROM 학생);   -- 중첩 서브쿼리 
-- 수강내역이 없는 학생은? 
SELECT *
FROM 학생 
WHERE 학번 NOT IN (SELECT 학번
                   FROM 수강내역)
;
/* 인라인 뷰 (FROM절) 
   SELECT 문의 질의 결과를 마치 테이블처럼 사용 
*/
SELECT *
FROM (SELECT ROWNUM as rnum
            ,학번, 이름, 전공
      FROM 학생) a -- select문을 테이블처럼 사용 
WHERE a.rnum BETWEEN 2 AND 5;
SELECT *
FROM ( SELECT   ROWNUM as rnum
               , a.*
        FROM(  SELECT employee_id
                     , emp_name
                     , salary
                FROM employees
                WHERE emp_name LIKE 'K%'
                ORDER BY emp_name
             ) a
    )
WHERE rnum BETWEEN 1 AND 10;


/*학생중에 평점 높은 5명만 출력하시오 */
SELECT *
FROM(SELECT rownum as 순위
             , a.*
     FROM (  SELECT 이름
                   , 평점 
              FROM 학생
              ORDER BY 평점 DESC
           ) a
    )
WHERE 순위 = 3;
-- member, cart, prod 를 사용하여 
-- 고객별 카트사용횟수, 상품품목건수, 상품구매수량, 총구매금액을 출력하시오 
-- 구매이력이 없다면 0 <- 으로 출력되로록 
















SELECT a.mem_id
     , a.mem_name
     , COUNT(DISTINCT b.cart_no) 카트사용횟수
     , COUNT(c.prod_id)          상품품목건수
     , SUM(nvl(b.cart_qty,0))    상품구매수량
     , SUM(NVL(b.cart_qty * c.prod_sale, 0)) as 구매합산금액
FROM member a, cart b,prod c
WHERE a.mem_id = b.cart_member(+)
AND b.cart_prod = c.prod_id(+)
group by a.mem_id, a.mem_name
order by 6 desc;


SELECT *
FROM member a, cart b,prod c
WHERE a.mem_id = b.cart_member(+)
AND b.cart_prod = c.prod_id(+)
order by 6 desc;
/* ANSI OUTER JOIN */
SELECT a.mem_id
     , a.mem_name
     , COUNT(DISTINCT b.cart_no) 카트사용횟수 
     , COUNT(c.prod_id)          상품품목수 
FROM member a
LEFT OUTER JOIN cart b
ON(a.mem_id = b.cart_member)
LEFT OUTER JOIN prod c
ON(b.cart_prod = c.prod_id) 
GROUP BY a.mem_id
       , a.mem_name;









SELECT a.mem_id
     , a.mem_name
     , COUNT(DISTINCT b.cart_no) 카트사용횟수
     , COUNT(c.prod_id) 상품품목건수
     , SUM(nvl(b.cart_qty,0))  상품구매수량
     , SUM(NVL(b.cart_qty * c.prod_sale, 0)) as 구매합산금액
from member a
left join cart b
on (a.mem_id = b.cart_member)
left join prod c
on (b.cart_prod = c.prod_id)
group by a.mem_id, a.mem_name
order by 6 desc;






SELECT *
FROM employees;

SELECT *
FROM products ;

SELECT *
FROM sales;











        


