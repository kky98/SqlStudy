CREATE TABLE tb_user(
     user_id VARCHAR2(100) primary key 
    ,user_pw VARCHAR2(100)
    ,user_nm VARCHAR2(100)
    ,user_mail VARCHAR2(100)
    ,user_mileage NUMBER
    ,create_dt DATE
    ,update_dt DATE DEFAULT SYSDATE
    ,use_yn VARCHAR2(1) DEFAULT 'Y'
);

-- select ~ insert 로 tb_user 테이블에 데이터 삽입
INSERT INTO tb_user(user_id ,user_pw,user_nm,user_mail,user_mileage,create_dt)
SELECT mem_id, mem_pass, mem_name, mem_mail, mem_mileage, sysdate
FROM member;
commit;

SELECT user_id
     , user_pw
     , user_nm
     , user_mail
     , user_mileage
FROM tb_user         ;

INSERT INTO TB_USER(user_id
                  , user_pw
                  , user_nm
                  , user_mileage)
VALUES  ('a','a','a', 1)

;
SELECT *
FROM TB_USER;

UPDATE tb_user
SET user_nm = '팽하'     
WHERE user_id = 'lee001'; 
commit;








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



