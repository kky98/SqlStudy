/* 
     부서별 직원의 salary가 가장높은 직원을 출력하시오 
*/
SELECT *
FROM(  SELECT emp_name, salary, department_id
             , RANK() OVER(PARTITION BY department_id ORDER BY salary DESC) as rnk
        FROM employees
      )
WHERE rnk =1;

-- 학생중 전공별 평점이 가장 높은 학생의 정보를 출력하시오 

SELECT *
FROM(
        SELECT a.*
             , RANK() OVER(PARTITION BY a.전공 ORDER BY a.평점 DESC) as rnk
             , RANK() OVER(ORDER BY a.평점 DESC) as all_rnk
             , COUNT(*) OVER() as 전체학생수
             , AVG(a.평점) OVER() as 전체평균
        FROM 학생 a 
    )
WHERE rnk = 1;
/*
     로우손실 없이 집계값 산출
     partition by 에서 window 절을 활용하여 세부 집계를 할 수 있음.
     AVG,SUM,MAX,MIN,COUNT,RANK,DENSE_RANK, LAG, ROW_NUMBER...
     PARTITION BY 절 : 계산 대상 그룹 
     ORDER BY     절 : 대상 그룹에대한 정렬
     WINDOW       절 : 파티션으로 분할된 그룹에 대해 더 상세한 그룹으로 분할
*/
-- CART, PROD 물품별 prod_sale 합계의 상위 10등 상품을 출력하시오 


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
-- 집계함수 + 분석함수 (표현식에 맞게 사용하면됨)
SELECT *
FROM (  SELECT a.cart_prod, b.prod_name   
              ,RANK()OVER(ORDER BY SUM(b.prod_sale * a.cart_qty) DESC) as rnk
        FROM cart a, prod b
        WHERE a.cart_prod = b.prod_id
        GROUP BY a.cart_prod, b.prod_name
     )
WHERE rnk <= 10;
/*  
    NTILE(expr) 파티션별로 expr 명시된 값만큼 분할한 결과를 반환 
    NTILE(3) 1 ~ 3 의 수를 반환(분할하는 수를 버킷 수 라고함) 
    NTILE(4)  -> 100/4 -> 25% 로 행을 분할 
*/
SELECT emp_name, salary, department_id 
      ,NTILE(2) OVER(PARTITION BY department_id ORDER BY salary DESC) group_num
      ,COUNT(*) OVER(PARTITION BY department_id) as 부서직원수
FROM employees
WHERE department_id IN(30,60);
-- 전체 직원의 급여를 10분위로 나누었을때 1분위에 속하는 직원을 조회하시오 
SELECT emp_name, salary
     , NTILE(10) OVER(ORDER BY salary DESC) as 분위
FROM employees; 

CREATE TABLE temp_team  AS
SELECT nm
     , NTILE(6) OVER(ORDER BY DBMS_RANDOM.VALUE ) as team
FROM tb_info;

SELECT DBMS_RANDOM.VALUE() as "0~1" -- 난수 랜덤생성
     , ROUND(DBMS_RANDOM.VALUE() * 10) as "0~10" -- 정수 랜덤생성
FROM dual;
-- 202301 ~202312 까지 월 1000건의 데이터 생성  100 ~1000 사이 값 
CREATE TABLE tb_sample AS
SELECT ROWNUM as seq
     , '2023' || LPAD(CEIL(ROWNUM/1000), 2, '0') as month
     , ROUND(DBMS_RANDOM.VALUE(100, 1000)) as amt
FROM dual
CONNECT BY LEVEL <= 12000;

SELECT DBMS_RANDOM.STRING('U', 5) -- 알파벳 대문자 5자리 랜덤생성 
     , DBMS_RANDOM.STRING('L', 5) -- 소문자
     , DBMS_RANDOM.STRING('A', 5) -- 대소문자
     , DBMS_RANDOM.STRING('X', 5) -- 알파벳 대문자 & 숫자
     , DBMS_RANDOM.STRING('P', 5) -- 대소문자,숫자,특수문자
FROM dual;
--



SELECT *
FROM tb_sample;

--FROM- > WHERE -> GROUP BY -> HAVING  -> SELECT -> ORDER BY 
SELECT *
FROM temp_team;


SELECT nm
     , substr(mbti,1,1) as 에너지
     , substr(mbti,2,1) as 인식방식
     , substr(mbti,3,1) as 판단
     , substr(mbti,4,1) as 생활양식
FROM tb_info;

/*  주어진 그룹과 순서에 따라 row에 있는 값을 참조할때 사용
    LAG(expr, offset, default_value)  선행로우의 값 참조 
    LEAD(expr, offset, default_value) 후행로우의 값 참조
*/
SELECT emp_name, department_id, salary
      ,LAG(emp_name, 1, '가장높음') OVER(PARTITION BY department_id
                                        ORDER BY salary DESC) as emp_lag
      ,LEAD(emp_name, 1, '가장 낮음') OVER(PARTITION BY department_id
                                        ORDER BY salary DESC) as emp_lead
FROM employees;

/*
      학생의 평점을 기준으로 한단계 위의 학생의 평점과 차이를 출력하시오 
      순위  이름   평점  상위학생이름   상위평점과 차이 
      1등   팽수   4.5   없음               0
      2등   길동   4.3   팽수              0.2
      3등   동길   3.0   길동              1.3   
      LAG(emp_name, 1, '가장높음') 매개변수1,3의 타입이 같아야함  
      소수점 2째 자리까지 반올림 
*/
SELECT 이름, ROUND(평점,2) as                                    내평점
     , LAG(이름,1,'없음') OVER(ORDER BY 평점 DESC)                상위학생
     , ROUND(LAG(평점,1,평점) OVER(ORDER BY 평점 DESC) - 평점,2)  상위평점차이
FROM 학생;




SELECT 이름
     , ROUND(평점,2) as 평점
     , LAG(이름, 1, '없음') OVER(ORDER BY 평점 DESC) 상위학생이름
     , ROUND(LAG(평점, 1, 평점) OVER(ORDER BY 평점 DESC) - 평점,2) 평점차이
FROM 학생 ;




CREATE TABLE bbs (
 bbs_no	      NUMBER  PRIMARY KEY
,parent_no	  NUMBER
,bbs_title	  VARCHAR2(1000)  DEFAULT NULL  -- 댓글의 경우 null
,bbs_content  VARCHAR2(4000)  NOT NULL
,author_id	  VARCHAR2(100)
,create_dt	  TIMESTAMP DEFAULT CURRENT_TIMESTAMP -- 사용자 세션의 시간
,update_dt	  TIMESTAMP DEFAULT CURRENT_TIMESTAMP
,CONSTRAINT fk_prent FOREIGN KEY(parent_no) 
 REFERENCES bbs(bbs_no) ON DELETE CASCADE 
  -- 게시글의 no를 참조하고 참조 데이터 삭제시 같이 삭제 
,CONSTRAINT fk_user  FOREIGN KEY(author_id) 
 REFERENCES tb_user(user_id) ON DELETE CASCADE  -- 유저 탈퇴시 같이 삭제 
);
-- 게시글번호 시퀀스 
CREATE SEQUENCE bbs_seq START WITH 1 INCREMENT BY 1;

INSERT INTO bbs(bbs_no, bbs_title, bbs_content, author_id) 
VALUES(bbs_seq.NEXTVAL, '공지사항', '오늘은 금요일 입니다.!!!!','a001');
INSERT INTO bbs(bbs_no, bbs_title, bbs_content, author_id) 
VALUES(bbs_seq.NEXTVAL, '게시글1', '게시글 1입니다.','b001');
INSERT INTO bbs(bbs_no, parent_no, bbs_content, author_id) 
VALUES(bbs_seq.NEXTVAL, 1, '곧 월요일이예요...','x001');

-- 댓글이 있는 게시글과 해당 게시글의 댓글을 출력하시오 

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
        SELECT a.cart_prod   /*상품아이디*/
              ,b.prod_name   /*상품이름*/
              ,SUM(a.cart_qty * b.prod_sale) as sale_sum
        FROM cart a 
            ,prod b
        WHERE a.cart_prod = b.prod_id
        GROUP BY a.cart_prod,b.prod_name
    )c
)
WHERE rnk_sale <=10
;
