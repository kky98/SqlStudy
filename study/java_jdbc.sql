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

-- select ~ insert �� tb_user ���̺� ������ ����
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
SET user_nm = '����'     
WHERE user_id = 'lee001'; 
commit;








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



