--SET TERMOUT OFF
SET ECHO OFF

DROP TABLE cart;
DROP TABLE member;
DROP TABLE buyprod;
DROP TABLE prod;
DROP TABLE buyer;
DROP TABLE lprod;

-- 객체이름 30자 이내, 무조건 알파벳시작, 알파벳, 숫자, _,$ 
-- 객체이름은 무조건 대문자로 저장됨. 
CREATE TABLE lprod
(
  lprod_id  NUMBER(7)   NOT NULL,
  lprod_gu  CHAR(4)     NOT NULL,
  lprod_nm  VARCHAR2(40) NOT NULL,
  CONSTRAINT pk_lprod PRIMARY KEY (lprod_gu)
);


INSERT INTO lprod(lprod_id,lprod_gu,lprod_nm) VALUES(1,'P101','컴퓨터제품');
INSERT INTO lprod(lprod_id,lprod_gu,lprod_nm) VALUES(2,'P102','전자제품');
INSERT INTO lprod(lprod_id,lprod_gu,lprod_nm) VALUES(3,'P201','여성캐주얼');
INSERT INTO lprod(lprod_id,lprod_gu,lprod_nm) VALUES(4,'P202','남성캐주얼');
INSERT INTO lprod(lprod_id,lprod_gu,lprod_nm) VALUES(5,'P301','피혁잡화');
INSERT INTO lprod(lprod_id,lprod_gu,lprod_nm) VALUES(6,'P302','화장품');
INSERT INTO lprod(lprod_id,lprod_gu,lprod_nm) VALUES(7,'P401','음반/CD');
INSERT INTO lprod(lprod_id,lprod_gu,lprod_nm) VALUES(8,'P402','도서');
INSERT INTO lprod(lprod_id,lprod_gu,lprod_nm) VALUES(9,'P403','문구류');

/*
SELECT * FROM lprod

SELECT lprod_gu, lprod_nm FROM lprod
  WHERE lprod_gu > 'P201'
  order by  lprod_gu desc

SELECT lprod_gu, lprod_nm FROM lprod
  WHERE lprod_gu > 'P201'
  order by  lprod_nm desc

update lprod
  set lprod_nm='전자제품'
  WHERE lprod_gu='P102' 

delete FROM lprod
  WHERE lprod_gu = 'P202' 
*/

-- DROP TABLE buyer
 
CREATE TABLE buyer
(  buyer_id           CHAR(6)       NOT NULL,   --거래처코드 
   buyer_name         VARCHAR2(50)  NOT NULL,   --거래처명
   buyer_lgu          CHAR(4)       NOT NULL,   --취급상품대분류
   buyer_bank         VARCHAR2(40),            --은행
   buyer_bankno       VARCHAR2(40),             --계좌번호
   buyer_bankname     VARCHAR2(15),             --예금주
   buyer_zip          CHAR(7),                  --우편번호
   buyer_add1         VARCHAR2(100),             --주소1
   buyer_add2         VARCHAR2(80),             --주소2
   buyer_comtel       VARCHAR2(14)  NOT NULL,   --전화번호 
   buyer_fax          VARCHAR2(20)  NOT NULL    --fax번호 
);

 ALTER TABLE buyer add ( buyer_mail VARCHAR2(40) NOT NULL,
                         buyer_charger VARCHAR2(10),
                              buyer_telext VARCHAR2(2));


 ALTER TABLE buyer
   modify( buyer_name VARCHAR2(40));
 
 ALTER TABLE buyer
   add ( CONSTRAINT pk_buyer PRIMARY KEY(buyer_id),
           CONSTRAINT fr_buyer_lgu  foreign key(buyer_lgu) 
                               references lprod(lprod_gu) ); 

/*  
INSERT INTO buyer (buyer_id, buyer_name, buyer_lgu, buyer_bank, 
                   buyer_bankno, buyer_bankname, buyer_zip,
                   buyer_add1, buyer_add2, buyer_comtel, buyer_fax,
                   buyer_mail, buyer_charger)
*/

INSERT INTO buyer (buyer_id,buyer_name,buyer_lgu,buyer_bank,buyer_bankno,buyer_bankname,buyer_zip,buyer_add1,buyer_add2,buyer_comtel,buyer_fax,buyer_mail,buyer_charger)
  VALUES ('P10101','삼성컴퓨터','P101','주택은행','123-456-7890','이건상','135-972','서울 강남구 도곡2동현대비젼21','1125호','02-522-7890','02-522-7891','samcom@samsung.co.kr','송동구');
INSERT INTO buyer (buyer_id,buyer_name,buyer_lgu,buyer_bank,buyer_bankno,buyer_bankname,buyer_zip,buyer_add1,buyer_add2,buyer_comtel,buyer_fax,buyer_mail,buyer_charger)  
  VALUES ('P10102','삼보컴퓨터','P101','제일은행','732-702-195670','김현우','142-726','서울 강북구 미아6동 행전빌딩','2712호','02-632-5690','02-632-5699','sambo@sambo.co.kr','김서구');
INSERT INTO buyer (buyer_id,buyer_name,buyer_lgu,buyer_bank,buyer_bankno,buyer_bankname,buyer_zip,buyer_add1,buyer_add2,buyer_comtel,buyer_fax,buyer_mail,buyer_charger)
  VALUES ('P10103','현주컴퓨터','P101','국민은행','112-650-397811','심현주','404-260','인천 서구 마전동','157-899번지','032-233-7832','032-233-7833','hyunju@hyunju.com','강남구') ;
INSERT INTO buyer (buyer_id,buyer_name,buyer_lgu,buyer_bank,buyer_bankno,buyer_bankname,buyer_zip,buyer_add1,buyer_add2,buyer_comtel,buyer_fax,buyer_mail,buyer_charger)
  VALUES ('P10201','대우전자','P102','농협','222-333-567890','강대우','702-864','대구 북구 태전동','232번지','053-780-2356','053-780-2357','daewoo@daewoo.co.kr','성대우') ;
INSERT INTO buyer (buyer_id,buyer_name,buyer_lgu,buyer_bank,buyer_bankno,buyer_bankname,buyer_zip,buyer_add1,buyer_add2,buyer_comtel,buyer_fax,buyer_mail,buyer_charger)
  VALUES ('P10202','삼성전자','P102','외환은행','989-323-567898','박삼성','614-728','부산 부산진구 부전1동 동아빌딩','1708호','051-567-5312','051-567-5313','samsung@samsung.com','김인우');
INSERT INTO buyer (buyer_id,buyer_name,buyer_lgu,buyer_bank,buyer_bankno,buyer_bankname,buyer_zip,buyer_add1,buyer_add2,buyer_comtel,buyer_fax,buyer_mail,buyer_charger) 
  VALUES ('P20101','대현','P201','국민은행','688-323-567898','신대현','306-785','대전 대덕구 오정동 운암빌딩','508호','042-332-5123','042-332-5125','daehyun@daehyun.com','진대영');
INSERT INTO buyer (buyer_id,buyer_name,buyer_lgu,buyer_bank,buyer_bankno,buyer_bankname,buyer_zip,buyer_add1,buyer_add2,buyer_comtel,buyer_fax,buyer_mail,buyer_charger) 
  VALUES ('P20102','마르죠','P201','주택은행','123-777-7890','이마루','135-972','서울 강남구 도곡2동 현대비젼21','1211호','02-533-7890','02-533-5699','mar@marjo.co.kr','조현상')  ;
INSERT INTO buyer (buyer_id,buyer_name,buyer_lgu,buyer_bank,buyer_bankno,buyer_bankname,buyer_zip,buyer_add1,buyer_add2,buyer_comtel,buyer_fax,buyer_mail,buyer_charger)
  VALUES ('P20201','LG패션','P202','제일은행','732-702-556677','김애지','142-726','서울 강북구 미아6동 행전빌딩','5011호','02-332-5690','02-332-5699','lgfashion.co.kr','남지수');
INSERT INTO buyer (buyer_id,buyer_name,buyer_lgu,buyer_bank,buyer_bankno,buyer_bankname,buyer_zip,buyer_add1,buyer_add2,buyer_comtel,buyer_fax,buyer_mail,buyer_charger) 
  VALUES ('P20202','캠브리지','P202','국민은행','112-888-397811','안불이주','404-260','인천 서구 마전동','535-899번지','032-255-7832','032-255-7833','cambrige@cambrige.com','신일수');
INSERT INTO buyer (buyer_id,buyer_name,buyer_lgu,buyer_bank,buyer_bankno,buyer_bankname,buyer_zip,buyer_add1,buyer_add2,buyer_comtel,buyer_fax,buyer_mail,buyer_charger) 
  VALUES ('P30101','가파치','P301','농협','211-333-511890','김선아','702-864','대구 북구 태전동','555-66호','053-535-2356','053-535-2357','gapachi@gapachi.co.kr','이수나')  ;
INSERT INTO buyer (buyer_id,buyer_name,buyer_lgu,buyer_bank,buyer_bankno,buyer_bankname,buyer_zip,buyer_add1,buyer_add2,buyer_comtel,buyer_fax,buyer_mail,buyer_charger)
   VALUES ('P30201','한국화장품','P302','외환은행','333-355-568898','박한국','614-728','부산 부산진구 부전1동 동아빌딩','309호','051-212-5312','051-212-5313','hangook@hangook.com','김사우');
INSERT INTO buyer (buyer_id,buyer_name,buyer_lgu,buyer_bank,buyer_bankno,buyer_bankname,buyer_zip,buyer_add1,buyer_add2,buyer_comtel,buyer_fax,buyer_mail,buyer_charger)
  VALUES ('P30202','피리어스','P302','국민은행','677-888-569998','신상우','306-785','대전대덕구 오정동 운암빌딩','612호','042-222-5123','042-222-5125','pieoris@pieoris.com','이진영');
INSERT INTO buyer (buyer_id,buyer_name,buyer_lgu,buyer_bank,buyer_bankno,buyer_bankname,buyer_zip,buyer_add1,buyer_add2,buyer_comtel,buyer_fax,buyer_mail,buyer_charger)
  VALUES ('P30203','참존','P302','주택은행','555-777-567778','오참존','306-785','대전대덕구 오정동 운암빌딩','1007호','042-622-5123','042-622-5125','chamjon@chamjon.com','성애란');


CREATE TABLE  prod
(  prod_id             VARCHAR2(10)     NOT NULL,     -- 상품코드
   prod_name           VARCHAR2(40)     NOT NULL,     -- 상품명
   prod_lgu            CHAR(4 )         NOT NULL,     -- 상품분류
   prod_buyer          CHAR(6)          NOT NULL,     -- 공급업체(코드)
   prod_cost           NUMBER(10)       NOT NULL,     -- 매입가
   prod_price          NUMBER(10)       NOT NULL,     -- 소비자가
   prod_sale           NUMBER(10)       NOT NULL,     -- 판매가
   prod_outline        VARCHAR2(100)     NOT NULL,     -- 상품개략설명
   prod_detail         CLOB,                          -- 상품상세설명
   prod_img            VARCHAR2(40)     NOT NULL,     -- 이미지(소)
   prod_totalstock     NUMBER(10)       NOT NULL,     -- 재고수량
   prod_insdate        DATE,                          -- 신규일자(등록일)
   prod_properstock    NUMBER(10)       NOT NULL,     -- 안전재고수량
   prod_size           VARCHAR2(20),                  -- 크기
   prod_color          VARCHAR2(20),                  -- 색상
   prod_delivery       VARCHAR2(255),                 -- 배달특기사항
   prod_unit           VARCHAR2(6),                   -- 단위(수량)
   prod_qtyin          NUMBER(10),                    -- 총입고수량
   prod_qtysale        NUMBER(10),                    -- 총판매수량
   prod_mileage        NUMBER(10),                    -- 개당 마일리지 점수
   CONSTRAINT pk_prod_id PRIMARY KEY (prod_id),
   CONSTRAINT fr_prod_lgu FOREIGN KEY (prod_lgu) REFERENCES lprod(lprod_gu),
   CONSTRAINT fr_prod_buyer FOREIGN KEY (prod_buyer) REFERENCES buyer(buyer_id)  
);


INSERT INTO prod  (prod_id,prod_name,prod_lgu,prod_buyer,prod_cost,prod_price,prod_sale,prod_outline,prod_detail,prod_img,prod_totalstock,prod_insdate,prod_properstock,prod_size,prod_color,prod_delivery,prod_unit,prod_qtyin,prod_qtysale)
       VALUES ('P101000001','모니터 삼성전자15인치칼라','P101','P10101',210000,290000,230000,'평면모니터의 기적','우리기술의 개가','P101000001.gif',0,'2005-01-10',33,'15인치','','파손 주의','EA',0,0) ;
INSERT INTO prod  (prod_id,prod_name,prod_lgu,prod_buyer,prod_cost,prod_price,prod_sale,prod_outline,prod_detail,prod_img,prod_totalstock,prod_insdate,prod_properstock,prod_size,prod_color,prod_delivery,prod_unit,prod_qtyin,prod_qtysale)
       VALUES ('P101000002','모니터 삼성전자17인치칼라','P101','P10101',310000,390000,330000,'평면모니터의 기적','우리기술의 개가','P101000002.gif',0,'2005-01-10',23,'17인치','','파손 주의','EA',0,0) ;
INSERT INTO prod  (prod_id,prod_name,prod_lgu,prod_buyer,prod_cost,prod_price,prod_sale,prod_outline,prod_detail,prod_img,prod_totalstock,prod_insdate,prod_properstock,prod_size,prod_color,prod_delivery,prod_unit,prod_qtyin,prod_qtysale)
       VALUES ('P101000003','모니터 삼성전자19인치칼라','P101','P10101',410000,490000,430000,'평면모니터의 기적','우리기술의 개가','P101000003.gif',0,'2005-01-10',15,'19인치','','파손 주의','EA',0,0) ;
INSERT INTO prod  (prod_id,prod_name,prod_lgu,prod_buyer,prod_cost,prod_price,prod_sale,prod_outline,prod_detail,prod_img,prod_totalstock,prod_insdate,prod_properstock,prod_size,prod_color,prod_delivery,prod_unit,prod_qtyin,prod_qtysale)
       VALUES ('P101000004','삼보컴퓨터 P-III 600Mhz','P101','P10102',1150000,1780000,1330000,'쉬운 인터넷을.....','새로운 차원의 컴퓨터를.....','P101000004.gif',0,'2005-02-08',22,'','','파손 주의','EA',0,0) ;
INSERT INTO prod  (prod_id,prod_name,prod_lgu,prod_buyer,prod_cost,prod_price,prod_sale,prod_outline,prod_detail,prod_img,prod_totalstock,prod_insdate,prod_properstock,prod_size,prod_color,prod_delivery,prod_unit,prod_qtyin,prod_qtysale)
       VALUES ('P101000005','삼보컴퓨터 P-III 700Mhz','P101','P10102',2150000,2780000,2330000,'쉬운 인터넷을.....','새로운 차원의 컴퓨터를.....','P101000005.gif',0,'2005-02-08',31,'','','파손 주의','EA',0,0) ;
INSERT INTO prod  (prod_id,prod_name,prod_lgu,prod_buyer,prod_cost,prod_price,prod_sale,prod_outline,prod_detail,prod_img,prod_totalstock,prod_insdate,prod_properstock,prod_size,prod_color,prod_delivery,prod_unit,prod_qtyin,prod_qtysale)
       VALUES ('P101000006','삼보컴퓨터 P-III 800Mhz','P101','P10102',3150000,3780000,3330000,'쉬운 인터넷을.....','새로운 차원의 컴퓨터를.....','P101000006.gif',0,'2005-02-08',17,'','','파손 주의','EA',0,0) ;
INSERT INTO prod  (prod_id,prod_name,prod_lgu,prod_buyer,prod_cost,prod_price,prod_sale,prod_outline,prod_detail,prod_img,prod_totalstock,prod_insdate,prod_properstock,prod_size,prod_color,prod_delivery,prod_unit,prod_qtyin,prod_qtysale)
       VALUES ('P102000001','대우 칼라 TV 25인치','P102','P10201',690000,820000,720000,'집안에 영화관을.....','평면 브라운관의 새장.....','P102000001.gif',0,'2005-02-22',53,'25인치','흑색','파손 주의','EA',0,0) ;
INSERT INTO prod  (prod_id,prod_name,prod_lgu,prod_buyer,prod_cost,prod_price,prod_sale,prod_outline,prod_detail,prod_img,prod_totalstock,prod_insdate,prod_properstock,prod_size,prod_color,prod_delivery,prod_unit,prod_qtyin,prod_qtysale)
       VALUES ('P102000002','대우 칼라 TV 29인치','P102','P10201',890000,1020000,920000,'집안에 영화관을.....','평면 브라운관의 새장.....','P102000002.gif',0,'2005-02-22',21,'29인치','흑색','파손 주의','EA',0,0) ;
INSERT INTO prod  (prod_id,prod_name,prod_lgu,prod_buyer,prod_cost,prod_price,prod_sale,prod_outline,prod_detail,prod_img,prod_totalstock,prod_insdate,prod_properstock,prod_size,prod_color,prod_delivery,prod_unit,prod_qtyin,prod_qtysale)
       VALUES ('P102000003','삼성 칼라 TV 21인치','P102','P10202',590000,720000,620000,'집안에 영화관을.....','평면 브라운관의 새장.....','P102000003.gif',0,'2005-01-22',11,'21인치','은색','파손 주의','EA',0,0) ;
INSERT INTO prod  (prod_id,prod_name,prod_lgu,prod_buyer,prod_cost,prod_price,prod_sale,prod_outline,prod_detail,prod_img,prod_totalstock,prod_insdate,prod_properstock,prod_size,prod_color,prod_delivery,prod_unit,prod_qtyin,prod_qtysale)
       VALUES ('P102000004','삼성 칼라 TV 29인치','P102','P10202',990000,1120000,1020000,'집안에 영화관을.....','평면 브라운관의 새장.....','P102000004.gif',0,'2005-01-22',19,'29인치','은색','파손 주의','EA',0,0) ;
INSERT INTO prod  (prod_id,prod_name,prod_lgu,prod_buyer,prod_cost,prod_price,prod_sale,prod_outline,prod_detail,prod_img,prod_totalstock,prod_insdate,prod_properstock,prod_size,prod_color,prod_delivery,prod_unit,prod_qtyin,prod_qtysale)
       VALUES ('P102000005','삼성 칼라 TV 53인치','P102','P10202',1990000,2120000,2020000,'집안에 영화관을.....','평면 브라운관의 새장.....','P102000005.gif',0,'2005-01-22',8,'53인치','은색','파손 주의','EA',0,0) ;
INSERT INTO prod  (prod_id,prod_name,prod_lgu,prod_buyer,prod_cost,prod_price,prod_sale,prod_outline,prod_detail,prod_img,prod_totalstock,prod_insdate,prod_properstock,prod_size,prod_color,prod_delivery,prod_unit,prod_qtyin,prod_qtysale)
       VALUES ('P102000006','삼성 캠코더','P102','P10202',660000,880000,770000,'가족과 영화촬영을.....','레저와 함께.....','P102000006.gif',0,'2005-02-23',17,'','','파손 주의','EA',0,0) ;
INSERT INTO prod  (prod_id,prod_name,prod_lgu,prod_buyer,prod_cost,prod_price,prod_sale,prod_outline,prod_detail,prod_img,prod_totalstock,prod_insdate,prod_properstock,prod_size,prod_color,prod_delivery,prod_unit,prod_qtyin,prod_qtysale)
       VALUES ('P102000007','대우 VTR 6헤드','P102','P10201',550000,760000,610000,'선명한 화질','감동의 명화를.....','P102000007.gif',0,'2005-01-23',36,'','','파손 주의','EA',0,0) ;
INSERT INTO prod  (prod_id,prod_name,prod_lgu,prod_buyer,prod_cost,prod_price,prod_sale,prod_outline,prod_detail,prod_img,prod_totalstock,prod_insdate,prod_properstock,prod_size,prod_color,prod_delivery,prod_unit,prod_qtyin,prod_qtysale)
       VALUES ('P201000001','여성 봄 셔츠 1','P201','P20101',21000,42000,27000,'파릇한 봄을 위한','아름다운.....','P201000001.gif',0,'2005-01-09',9,'s','청색','세탁 주의','EA',0,0) ;
INSERT INTO prod  (prod_id,prod_name,prod_lgu,prod_buyer,prod_cost,prod_price,prod_sale,prod_outline,prod_detail,prod_img,prod_totalstock,prod_insdate,prod_properstock,prod_size,prod_color,prod_delivery,prod_unit,prod_qtyin,prod_qtysale)
       VALUES ('P201000002','여성 봄 셔츠 2','P201','P20101',22000,43000,28000,'파릇한 봄을 위한','아름다운.....','P201000002.gif',0,'2005-01-09',9,'M','흰색','세탁 주의','EA',0,0) ;
INSERT INTO prod  (prod_id,prod_name,prod_lgu,prod_buyer,prod_cost,prod_price,prod_sale,prod_outline,prod_detail,prod_img,prod_totalstock,prod_insdate,prod_properstock,prod_size,prod_color,prod_delivery,prod_unit,prod_qtyin,prod_qtysale)
       VALUES ('P201000003','여성 봄 셔츠 3','P201','P20101',23000,44000,29000,'파릇한 봄을 위한','아름다운.....','P201000003.gif',0,'2005-01-09',9,'L','감색','세탁 주의','EA',0,0) ;
INSERT INTO prod  (prod_id,prod_name,prod_lgu,prod_buyer,prod_cost,prod_price,prod_sale,prod_outline,prod_detail,prod_img,prod_totalstock,prod_insdate,prod_properstock,prod_size,prod_color,prod_delivery,prod_unit,prod_qtyin,prod_qtysale)
       VALUES ('P201000004','여성 여름 셔츠 1','P201','P20101',12000,21000,25000,'시원한 여름을 위한','아름다운.....','P201000004.gif',0,'2005-01-11',9,'s','청색','세탁 주의','EA',0,0) ;
INSERT INTO prod  (prod_id,prod_name,prod_lgu,prod_buyer,prod_cost,prod_price,prod_sale,prod_outline,prod_detail,prod_img,prod_totalstock,prod_insdate,prod_properstock,prod_size,prod_color,prod_delivery,prod_unit,prod_qtyin,prod_qtysale)
       VALUES ('P201000005','여성 여름 셔츠 2','P201','P20101',13000,22000,26000,'시원한 여름을 위한','아름다운.....','P201000005.gif',0,'2005-01-11',9,'M','흰색','세탁 주의','EA',0,0) ;
INSERT INTO prod  (prod_id,prod_name,prod_lgu,prod_buyer,prod_cost,prod_price,prod_sale,prod_outline,prod_detail,prod_img,prod_totalstock,prod_insdate,prod_properstock,prod_size,prod_color,prod_delivery,prod_unit,prod_qtyin,prod_qtysale)
       VALUES ('P201000006','여성 여름 셔츠 3','P201','P20101',14000,23000,27000,'시원한 여름을 위한','아름다운.....','P201000006.gif',0,'2005-01-11',9,'L','감색','세탁 주의','EA',0,0) ;
INSERT INTO prod  (prod_id,prod_name,prod_lgu,prod_buyer,prod_cost,prod_price,prod_sale,prod_outline,prod_detail,prod_img,prod_totalstock,prod_insdate,prod_properstock,prod_size,prod_color,prod_delivery,prod_unit,prod_qtyin,prod_qtysale)
       VALUES ('P201000007','여성 겨울 라운드 셔츠 1','P201','P20101',31000,45000,33000,'따뜻한 겨울을 위한','아름다운.....','P201000007.gif',0,'2005-01-25',9,'s','청색','세탁 주의','EA',0,0) ;
INSERT INTO prod  (prod_id,prod_name,prod_lgu,prod_buyer,prod_cost,prod_price,prod_sale,prod_outline,prod_detail,prod_img,prod_totalstock,prod_insdate,prod_properstock,prod_size,prod_color,prod_delivery,prod_unit,prod_qtyin,prod_qtysale)
       VALUES ('P201000008','여성 겨울 라운드 셔츠 2','P201','P20101',32000,46000,34000,'따뜻한 겨울을 위한','아름다운.....','P201000008.gif',0,'2005-01-25',9,'M','흰색','세탁 주의','EA',0,0) ;
INSERT INTO prod  (prod_id,prod_name,prod_lgu,prod_buyer,prod_cost,prod_price,prod_sale,prod_outline,prod_detail,prod_img,prod_totalstock,prod_insdate,prod_properstock,prod_size,prod_color,prod_delivery,prod_unit,prod_qtyin,prod_qtysale)
       VALUES ('P201000009','여성 겨울 라운드 셔츠 3','P201','P20101',33000,47000,35000,'따뜻한 겨울을 위한','아름다운.....','P201000009.gif',0,'2005-01-25',9,'L','감색','세탁 주의','EA',0,0) ;
INSERT INTO prod  (prod_id,prod_name,prod_lgu,prod_buyer,prod_cost,prod_price,prod_sale,prod_outline,prod_detail,prod_img,prod_totalstock,prod_insdate,prod_properstock,prod_size,prod_color,prod_delivery,prod_unit,prod_qtyin,prod_qtysale)
       VALUES ('P201000010','여성 청바지 1','P201','P20102',55000,66000,57000,'편리한 활동파를 위한','편리한.....','P201000010.gif',0,'2005-01-31',38,'30','','세탁 주의','EA',0,0) ;
INSERT INTO prod  (prod_id,prod_name,prod_lgu,prod_buyer,prod_cost,prod_price,prod_sale,prod_outline,prod_detail,prod_img,prod_totalstock,prod_insdate,prod_properstock,prod_size,prod_color,prod_delivery,prod_unit,prod_qtyin,prod_qtysale)
       VALUES ('P201000011','여성 청바지 2','P201','P20102',56000,67000,58000,'편리한 활동파를 위한','편리한.....','P201000011.gif',0,'2005-01-31',35,'32','','세탁 주의','EA',0,0) ;
INSERT INTO prod  (prod_id,prod_name,prod_lgu,prod_buyer,prod_cost,prod_price,prod_sale,prod_outline,prod_detail,prod_img,prod_totalstock,prod_insdate,prod_properstock,prod_size,prod_color,prod_delivery,prod_unit,prod_qtyin,prod_qtysale)
       VALUES ('P201000012','여성 청바지 3','P201','P20102',57000,68000,59000,'편리한 활동파를 위한','편리한.....','P201000012.gif',0,'2005-01-31',33,'34','','세탁 주의','EA',0,0) ;
INSERT INTO prod  (prod_id,prod_name,prod_lgu,prod_buyer,prod_cost,prod_price,prod_sale,prod_outline,prod_detail,prod_img,prod_totalstock,prod_insdate,prod_properstock,prod_size,prod_color,prod_delivery,prod_unit,prod_qtyin,prod_qtysale)
       VALUES ('P201000013','여성 봄 자켓 1','P201','P20101',110000,210000,170000,'편리한 활동파의 봄을 위한','아름다운.....','P201000013.gif',0,'2005-02-18',16,'66','청색','세탁 주의','EA',0,0) ;
INSERT INTO prod  (prod_id,prod_name,prod_lgu,prod_buyer,prod_cost,prod_price,prod_sale,prod_outline,prod_detail,prod_img,prod_totalstock,prod_insdate,prod_properstock,prod_size,prod_color,prod_delivery,prod_unit,prod_qtyin,prod_qtysale)
       VALUES ('P201000014','여성 봄 자켓 2','P201','P20101',120000,220000,180000,'편리한 활동파의 봄을 위한','아름다운.....','P201000014.gif',0,'2005-02-18',18,'77','흰색','세탁 주의','EA',0,0) ;
INSERT INTO prod  (prod_id,prod_name,prod_lgu,prod_buyer,prod_cost,prod_price,prod_sale,prod_outline,prod_detail,prod_img,prod_totalstock,prod_insdate,prod_properstock,prod_size,prod_color,prod_delivery,prod_unit,prod_qtyin,prod_qtysale)
       VALUES ('P201000015','여성 봄 자켓 3','P201','P20101',130000,230000,190000,'편리한 활동파의 봄을 위한','아름다운.....','P201000015.gif',0,'2005-02-18',17,'88','감색','세탁 주의','EA',0,0) ;
INSERT INTO prod  (prod_id,prod_name,prod_lgu,prod_buyer,prod_cost,prod_price,prod_sale,prod_outline,prod_detail,prod_img,prod_totalstock,prod_insdate,prod_properstock,prod_size,prod_color,prod_delivery,prod_unit,prod_qtyin,prod_qtysale)
       VALUES ('P201000016','여성 여름 자켓 1','P201','P20102',100000,160000,130000,'편리한 활동파의 여름을 위한','아름다운.....','P201000016.gif',0,'2005-02-21',12,'66','청색','세탁 주의','EA',0,0) ;
INSERT INTO prod  (prod_id,prod_name,prod_lgu,prod_buyer,prod_cost,prod_price,prod_sale,prod_outline,prod_detail,prod_img,prod_totalstock,prod_insdate,prod_properstock,prod_size,prod_color,prod_delivery,prod_unit,prod_qtyin,prod_qtysale)
       VALUES ('P201000017','여성 여름 자켓 2','P201','P20102',110000,170000,140000,'편리한 활동파의 여름을 위한','아름다운.....','P201000017.gif',0,'2005-02-21',21,'77','흰색','세탁 주의','EA',0,0) ;
INSERT INTO prod  (prod_id,prod_name,prod_lgu,prod_buyer,prod_cost,prod_price,prod_sale,prod_outline,prod_detail,prod_img,prod_totalstock,prod_insdate,prod_properstock,prod_size,prod_color,prod_delivery,prod_unit,prod_qtyin,prod_qtysale)
       VALUES ('P201000018','여성 여름 자켓 3','P201','P20102',120000,180000,150000,'편리한 활동파의 여름을 위한','아름다운.....','P201000018.gif',0,'2005-02-21',11,'77','감색','세탁 주의','EA',0,0) ;
INSERT INTO prod  (prod_id,prod_name,prod_lgu,prod_buyer,prod_cost,prod_price,prod_sale,prod_outline,prod_detail,prod_img,prod_totalstock,prod_insdate,prod_properstock,prod_size,prod_color,prod_delivery,prod_unit,prod_qtyin,prod_qtysale)
       VALUES ('P201000019','여성 겨울 자켓 1','P201','P20102',210000,270000,240000,'편리한 활동파의 따뜻한 겨울을 위한','아름다운.....','P201000019.gif',0,'2005-02-28',22,'66','청색','세탁 주의','EA',0,0) ;
INSERT INTO prod  (prod_id,prod_name,prod_lgu,prod_buyer,prod_cost,prod_price,prod_sale,prod_outline,prod_detail,prod_img,prod_totalstock,prod_insdate,prod_properstock,prod_size,prod_color,prod_delivery,prod_unit,prod_qtyin,prod_qtysale)
       VALUES ('P201000020','여성 겨울 자켓 2','P201','P20102',220000,280000,250000,'편리한 활동파의 따뜻한 겨울을 위한','아름다운.....','P201000020.gif',0,'2005-02-28',29,'77','흰색','세탁 주의','EA',0,0) ;
INSERT INTO prod  (prod_id,prod_name,prod_lgu,prod_buyer,prod_cost,prod_price,prod_sale,prod_outline,prod_detail,prod_img,prod_totalstock,prod_insdate,prod_properstock,prod_size,prod_color,prod_delivery,prod_unit,prod_qtyin,prod_qtysale)
       VALUES ('P201000021','여성 겨울 자켓 3','P201','P20102',230000,290000,260000,'편리한 활동파의 따뜻한 겨울을 위한','아름다운.....','P201000021.gif',0,'2005-02-28',19,'88','감색','세탁 주의','EA',0,0) ;
INSERT INTO prod  (prod_id,prod_name,prod_lgu,prod_buyer,prod_cost,prod_price,prod_sale,prod_outline,prod_detail,prod_img,prod_totalstock,prod_insdate,prod_properstock,prod_size,prod_color,prod_delivery,prod_unit,prod_qtyin,prod_qtysale)
       VALUES ('P202000001','남성 봄 셔츠 1','P202','P20201',10000,19000,15000,'파릇한 봄을 위한','아름다운.....','P202000001.gif',0,'2005-01-05',9,'M','청색','세탁 주의','EA',0,0) ;
INSERT INTO prod  (prod_id,prod_name,prod_lgu,prod_buyer,prod_cost,prod_price,prod_sale,prod_outline,prod_detail,prod_img,prod_totalstock,prod_insdate,prod_properstock,prod_size,prod_color,prod_delivery,prod_unit,prod_qtyin,prod_qtysale)
       VALUES ('P202000002','남성 봄 셔츠 2','P202','P20201',13000,22000,18000,'파릇한 봄을 위한','아름다운.....','P202000002.gif',0,'2005-01-05',9,'L','흰색','세탁 주의','EA',0,0) ;
INSERT INTO prod  (prod_id,prod_name,prod_lgu,prod_buyer,prod_cost,prod_price,prod_sale,prod_outline,prod_detail,prod_img,prod_totalstock,prod_insdate,prod_properstock,prod_size,prod_color,prod_delivery,prod_unit,prod_qtyin,prod_qtysale)
       VALUES ('P202000003','남성 봄 셔츠 3','P202','P20201',15000,24000,20000,'파릇한 봄을 위한','아름다운.....','P202000003.gif',0,'2005-01-05',9,'XL','감색','세탁 주의','EA',0,0) ;
INSERT INTO prod  (prod_id,prod_name,prod_lgu,prod_buyer,prod_cost,prod_price,prod_sale,prod_outline,prod_detail,prod_img,prod_totalstock,prod_insdate,prod_properstock,prod_size,prod_color,prod_delivery,prod_unit,prod_qtyin,prod_qtysale)
       VALUES ('P202000004','남성 여름 셔츠 1','P202','P20201',18000,28000,23000,'시원한 여름을 위한','아름다운.....','P202000004.gif',0,'2005-02-05',9,'M','청색','세탁 주의','EA',0,0) ;
INSERT INTO prod  (prod_id,prod_name,prod_lgu,prod_buyer,prod_cost,prod_price,prod_sale,prod_outline,prod_detail,prod_img,prod_totalstock,prod_insdate,prod_properstock,prod_size,prod_color,prod_delivery,prod_unit,prod_qtyin,prod_qtysale)
       VALUES ('P202000005','남성 여름 셔츠 2','P202','P20201',23000,33000,28000,'시원한 여름을 위한','아름다운.....','P202000005.gif',0,'2005-02-05',9,'L','흰색','세탁 주의','EA',0,0) ;
INSERT INTO prod  (prod_id,prod_name,prod_lgu,prod_buyer,prod_cost,prod_price,prod_sale,prod_outline,prod_detail,prod_img,prod_totalstock,prod_insdate,prod_properstock,prod_size,prod_color,prod_delivery,prod_unit,prod_qtyin,prod_qtysale)
       VALUES ('P202000006','남성 여름 셔츠 3','P202','P20201',28000,38000,33000,'시원한 여름을 위한','아름다운.....','P202000006.gif',0,'2005-02-05',9,'XL','감색','세탁 주의','EA',0,0) ;
INSERT INTO prod  (prod_id,prod_name,prod_lgu,prod_buyer,prod_cost,prod_price,prod_sale,prod_outline,prod_detail,prod_img,prod_totalstock,prod_insdate,prod_properstock,prod_size,prod_color,prod_delivery,prod_unit,prod_qtyin,prod_qtysale)
       VALUES ('P202000007','남성 겨울 라운드 셔츠 1','P202','P20201',25000,42000,31000,'따뜻한 겨울을 위한','아름다운.....','P202000007.gif',0,'2005-01-13',9,'M','청색','세탁 주의','EA',0,0) ;
INSERT INTO prod  (prod_id,prod_name,prod_lgu,prod_buyer,prod_cost,prod_price,prod_sale,prod_outline,prod_detail,prod_img,prod_totalstock,prod_insdate,prod_properstock,prod_size,prod_color,prod_delivery,prod_unit,prod_qtyin,prod_qtysale)
       VALUES ('P202000008','남성 겨울 라운드 셔츠 2','P202','P20201',27000,43000,33000,'따뜻한 겨울을 위한','아름다운.....','P202000008.gif',0,'2005-01-13',9,'L','흰색','세탁 주의','EA',0,0) ;
INSERT INTO prod  (prod_id,prod_name,prod_lgu,prod_buyer,prod_cost,prod_price,prod_sale,prod_outline,prod_detail,prod_img,prod_totalstock,prod_insdate,prod_properstock,prod_size,prod_color,prod_delivery,prod_unit,prod_qtyin,prod_qtysale)
       VALUES ('P202000009','남성 겨울 라운드 셔츠 3','P202','P20201',28500,44000,35000,'따뜻한 겨울을 위한','아름다운.....','P202000009.gif',0,'2005-01-13',9,'XL','감색','세탁 주의','EA',0,0) ;
INSERT INTO prod  (prod_id,prod_name,prod_lgu,prod_buyer,prod_cost,prod_price,prod_sale,prod_outline,prod_detail,prod_img,prod_totalstock,prod_insdate,prod_properstock,prod_size,prod_color,prod_delivery,prod_unit,prod_qtyin,prod_qtysale)
       VALUES ('P202000010','남성 청바지 1','P202','P20202',55000,66000,58000,'편리한 활동파를 위한','편리한.....','P202000010.gif',0,'2005-01-16',38,'30','','세탁 주의','EA',0,0) ;
INSERT INTO prod  (prod_id,prod_name,prod_lgu,prod_buyer,prod_cost,prod_price,prod_sale,prod_outline,prod_detail,prod_img,prod_totalstock,prod_insdate,prod_properstock,prod_size,prod_color,prod_delivery,prod_unit,prod_qtyin,prod_qtysale)
       VALUES ('P202000011','남성 청바지 2','P202','P20202',55000,66000,58000,'편리한 활동파를 위한','편리한.....','P202000011.gif',0,'2005-01-16',35,'32','','세탁 주의','EA',0,0) ;
INSERT INTO prod  (prod_id,prod_name,prod_lgu,prod_buyer,prod_cost,prod_price,prod_sale,prod_outline,prod_detail,prod_img,prod_totalstock,prod_insdate,prod_properstock,prod_size,prod_color,prod_delivery,prod_unit,prod_qtyin,prod_qtysale)
       VALUES ('P202000012','남성 청바지 3','P202','P20202',55000,66000,58000,'편리한 활동파를 위한','편리한.....','P202000012.gif',0,'2005-01-16',33,'34','','세탁 주의','EA',0,0) ;
INSERT INTO prod  (prod_id,prod_name,prod_lgu,prod_buyer,prod_cost,prod_price,prod_sale,prod_outline,prod_detail,prod_img,prod_totalstock,prod_insdate,prod_properstock,prod_size,prod_color,prod_delivery,prod_unit,prod_qtyin,prod_qtysale)
       VALUES ('P202000013','남성 봄 자켓 1','P202','P20201',110000,230000,150000,'편리한 활동파의 봄을 위한','아름다운.....','P202000013.gif',0,'2005-02-17',16,'M','청색','세탁 주의','EA',0,0) ;
INSERT INTO prod  (prod_id,prod_name,prod_lgu,prod_buyer,prod_cost,prod_price,prod_sale,prod_outline,prod_detail,prod_img,prod_totalstock,prod_insdate,prod_properstock,prod_size,prod_color,prod_delivery,prod_unit,prod_qtyin,prod_qtysale)
       VALUES ('P202000014','남성 봄 자켓 2','P202','P20201',120000,230000,160000,'편리한 활동파의 봄을 위한','아름다운.....','P202000014.gif',0,'2005-02-17',18,'L','흰색','세탁 주의','EA',0,0) ;
INSERT INTO prod  (prod_id,prod_name,prod_lgu,prod_buyer,prod_cost,prod_price,prod_sale,prod_outline,prod_detail,prod_img,prod_totalstock,prod_insdate,prod_properstock,prod_size,prod_color,prod_delivery,prod_unit,prod_qtyin,prod_qtysale)
       VALUES ('P202000015','남성 봄 자켓 3','P202','P20201',130000,230000,170000,'편리한 활동파의 봄을 위한','아름다운.....','P202000015.gif',0,'2005-02-17',17,'XL','감색','세탁 주의','EA',0,0) ;
INSERT INTO prod  (prod_id,prod_name,prod_lgu,prod_buyer,prod_cost,prod_price,prod_sale,prod_outline,prod_detail,prod_img,prod_totalstock,prod_insdate,prod_properstock,prod_size,prod_color,prod_delivery,prod_unit,prod_qtyin,prod_qtysale)
       VALUES ('P202000016','남성 여름 자켓 1','P202','P20202',99000,160000,130000,'편리한 활동파의 여름을 위한','아름다운.....','P202000016.gif',0,'2005-02-06',12,'M','청색','세탁 주의','EA',0,0); 
INSERT INTO prod  (prod_id,prod_name,prod_lgu,prod_buyer,prod_cost,prod_price,prod_sale,prod_outline,prod_detail,prod_img,prod_totalstock,prod_insdate,prod_properstock,prod_size,prod_color,prod_delivery,prod_unit,prod_qtyin,prod_qtysale)
       VALUES ('P202000017','남성 여름 자켓 2','P202','P20202',109000,170000,150000,'편리한 활동파의 여름을 위한','아름다운.....','P202000017.gif',0,'2005-02-06',21,'L','흰색','세탁 주의','EA',0,0) ;
INSERT INTO prod  (prod_id,prod_name,prod_lgu,prod_buyer,prod_cost,prod_price,prod_sale,prod_outline,prod_detail,prod_img,prod_totalstock,prod_insdate,prod_properstock,prod_size,prod_color,prod_delivery,prod_unit,prod_qtyin,prod_qtysale)
       VALUES ('P202000018','남성 여름 자켓 3','P202','P20202',159000,190000,170000,'편리한 활동파의 여름을 위한','아름다운.....','P202000018.gif',0,'2005-02-06',11,'XL','감색','세탁 주의','EA',0,0) ;
INSERT INTO prod  (prod_id,prod_name,prod_lgu,prod_buyer,prod_cost,prod_price,prod_sale,prod_outline,prod_detail,prod_img,prod_totalstock,prod_insdate,prod_properstock,prod_size,prod_color,prod_delivery,prod_unit,prod_qtyin,prod_qtysale)
       VALUES ('P202000019','남성 겨울 자켓 1','P202','P20202',210000,370000,280000,'편리한 활동파의 따뜻한 겨울을 위한','아름다운.....','P202000019.gif',0,'2005-02-20',22,'M','청색','세탁 주의','EA',0,0) ;
INSERT INTO prod  (prod_id,prod_name,prod_lgu,prod_buyer,prod_cost,prod_price,prod_sale,prod_outline,prod_detail,prod_img,prod_totalstock,prod_insdate,prod_properstock,prod_size,prod_color,prod_delivery,prod_unit,prod_qtyin,prod_qtysale)
       VALUES ('P202000020','남성 겨울 자켓 2','P202','P20202',220000,370000,290000,'편리한 활동파의 따뜻한 겨울을 위한','아름다운.....','P202000020.gif',0,'2005-02-20',29,'L','흰색','세탁 주의','EA',0,0); 
INSERT INTO prod  (prod_id,prod_name,prod_lgu,prod_buyer,prod_cost,prod_price,prod_sale,prod_outline,prod_detail,prod_img,prod_totalstock,prod_insdate,prod_properstock,prod_size,prod_color,prod_delivery,prod_unit,prod_qtyin,prod_qtysale)
       VALUES ('P202000021','남성 겨울 자켓 3','P202','P20202',230000,370000,300000,'편리한 활동파의 따뜻한 겨울을 위한','아름다운.....','P202000021.gif',0,'2005-02-20',19,'XL','감색','세탁 주의','EA',0,0) ;
INSERT INTO prod  (prod_id,prod_name,prod_lgu,prod_buyer,prod_cost,prod_price,prod_sale,prod_outline,prod_detail,prod_img,prod_totalstock,prod_insdate,prod_properstock,prod_size,prod_color,prod_delivery,prod_unit,prod_qtyin,prod_qtysale)
       VALUES ('P301000001','악어 가죽 혁대','P301','P30101',21000,41000,33000,'멋진 혁대를 선물로.....','진귀한 가죽으로 제작된.....','P301000001.gif',0,'2005-01-15',32,'','','','EA',0,0) ;
INSERT INTO prod  (prod_id,prod_name,prod_lgu,prod_buyer,prod_cost,prod_price,prod_sale,prod_outline,prod_detail,prod_img,prod_totalstock,prod_insdate,prod_properstock,prod_size,prod_color,prod_delivery,prod_unit,prod_qtyin,prod_qtysale)
       VALUES ('P301000002','물소 가죽 장지갑','P301','P30101',17000,37000,29000,'멋진 지갑을 선물로.....','진귀한 가죽으로 제작된.....','P301000002.gif',0,'2005-01-15',52,'','','','EA',0,0) ;
INSERT INTO prod  (prod_id,prod_name,prod_lgu,prod_buyer,prod_cost,prod_price,prod_sale,prod_outline,prod_detail,prod_img,prod_totalstock,prod_insdate,prod_properstock,prod_size,prod_color,prod_delivery,prod_unit,prod_qtyin,prod_qtysale)
       VALUES ('P301000003','여성용 손지갑','P301','P30101',22000,33000,26000,'멋진 지갑을 선물로.....','진귀한 가죽으로 제작된.....','P301000003.gif',0,'2005-02-15',22,'','','','EA',0,0) ;
INSERT INTO prod  (prod_id,prod_name,prod_lgu,prod_buyer,prod_cost,prod_price,prod_sale,prod_outline,prod_detail,prod_img,prod_totalstock,prod_insdate,prod_properstock,prod_size,prod_color,prod_delivery,prod_unit,prod_qtyin,prod_qtysale)
       VALUES ('P301000004','여성용 캐쥬얼 벨트','P301','P30101',27000,37000,29000,'멋진 벨트를 선물로.....','진귀한 가죽으로 제작된.....','P301000004.gif',0,'2005-02-15',21,'','','','EA',0,0) ;
INSERT INTO prod  (prod_id,prod_name,prod_lgu,prod_buyer,prod_cost,prod_price,prod_sale,prod_outline,prod_detail,prod_img,prod_totalstock,prod_insdate,prod_properstock,prod_size,prod_color,prod_delivery,prod_unit,prod_qtyin,prod_qtysale)
       VALUES ('P302000001','향수 NO 5','P302','P30201',89000,110000,93000,'향기를 동반한.....','다정함을 향기와 함께.....','P302000001.gif',0,'2005-01-24',11,'','','','EA',0,0) ;
INSERT INTO prod  (prod_id,prod_name,prod_lgu,prod_buyer,prod_cost,prod_price,prod_sale,prod_outline,prod_detail,prod_img,prod_totalstock,prod_insdate,prod_properstock,prod_size,prod_color,prod_delivery,prod_unit,prod_qtyin,prod_qtysale)
       VALUES ('P302000002','샤넬 NO 7','P302','P30201',99000,120000,103000,'향기를 동반한.....','다정함을 향기와 함께.....','P302000002.gif',0,'2005-01-24',17,'','','','EA',0,0); 
INSERT INTO prod  (prod_id,prod_name,prod_lgu,prod_buyer,prod_cost,prod_price,prod_sale,prod_outline,prod_detail,prod_img,prod_totalstock,prod_insdate,prod_properstock,prod_size,prod_color,prod_delivery,prod_unit,prod_qtyin,prod_qtysale)
       VALUES ('P302000003','남성용 스킨','P302','P30201',19000,32000,21000,'세안후 바르는.....','은은한 향기와 함께.....','P302000003.gif',0,'2005-01-24',21,'','','','EA',0,0) ;
INSERT INTO prod  (prod_id,prod_name,prod_lgu,prod_buyer,prod_cost,prod_price,prod_sale,prod_outline,prod_detail,prod_img,prod_totalstock,prod_insdate,prod_properstock,prod_size,prod_color,prod_delivery,prod_unit,prod_qtyin,prod_qtysale)
       VALUES ('P302000004','남성용 로숀','P302','P30201',21000,33000,23000,'세안후 바르는.....','은은한 향기와 함께.....','P302000004.gif',0,'2005-02-12',19,'','','','EA',0,0) ;
INSERT INTO prod  (prod_id,prod_name,prod_lgu,prod_buyer,prod_cost,prod_price,prod_sale,prod_outline,prod_detail,prod_img,prod_totalstock,prod_insdate,prod_properstock,prod_size,prod_color,prod_delivery,prod_unit,prod_qtyin,prod_qtysale)
       VALUES ('P302000005','여성용 스킨','P302','P30201',18000,31000,20000,'세안후 바르는.....','은은한 향기와 함께.....','P302000005.gif',0,'2005-02-12',21,'','','','EA',0,0) ;
INSERT INTO prod  (prod_id,prod_name,prod_lgu,prod_buyer,prod_cost,prod_price,prod_sale,prod_outline,prod_detail,prod_img,prod_totalstock,prod_insdate,prod_properstock,prod_size,prod_color,prod_delivery,prod_unit,prod_qtyin,prod_qtysale)
       VALUES ('P302000006','여성용 로숀','P302','P30201',20000,32000,22000,'세안후 바르는.....','은은한 향기와 함께.....','P302000006.gif',0,'2005-02-12',19,'','','','EA',0,0) ;
INSERT INTO prod  (prod_id,prod_name,prod_lgu,prod_buyer,prod_cost,prod_price,prod_sale,prod_outline,prod_detail,prod_img,prod_totalstock,prod_insdate,prod_properstock,prod_size,prod_color,prod_delivery,prod_unit,prod_qtyin,prod_qtysale)
       VALUES ('P302000011','남성 향수','P302','P30202',59000,70000,63000,'좋은 향기를 동반한.....','다정함을 향기와 함께.....','P302000011.gif',0,'2005-01-13',21,'','','','EA',0,0) ;
INSERT INTO prod  (prod_id,prod_name,prod_lgu,prod_buyer,prod_cost,prod_price,prod_sale,prod_outline,prod_detail,prod_img,prod_totalstock,prod_insdate,prod_properstock,prod_size,prod_color,prod_delivery,prod_unit,prod_qtyin,prod_qtysale)
       VALUES ('P302000012','여성 향수','P302','P30202',89000,110000,93000,'좋은향기를 동반한.....','다정함을 향기와 함께.....','P302000012.gif',0,'2005-01-13',27,'','','','EA',0,0) ;
INSERT INTO prod  (prod_id,prod_name,prod_lgu,prod_buyer,prod_cost,prod_price,prod_sale,prod_outline,prod_detail,prod_img,prod_totalstock,prod_insdate,prod_properstock,prod_size,prod_color,prod_delivery,prod_unit,prod_qtyin,prod_qtysale)
       VALUES ('P302000013','립스틱','P302','P30202',17000,27000,23000,'세안후 바르는 좋은.....','은은한 향기와 함께.....','P302000013.gif',0,'2005-01-13',11,'','','','EA',0,0) ;
INSERT INTO prod  (prod_id,prod_name,prod_lgu,prod_buyer,prod_cost,prod_price,prod_sale,prod_outline,prod_detail,prod_img,prod_totalstock,prod_insdate,prod_properstock,prod_size,prod_color,prod_delivery,prod_unit,prod_qtyin,prod_qtysale)
       VALUES ('P302000014','면도크림','P302','P30202',25000,32000,26000,'세안후 바르는 좋은.....','은은한 향기와 함께.....','P302000014.gif',0,'2005-01-14',29,'','','','EA',0,0) ;
INSERT INTO prod  (prod_id,prod_name,prod_lgu,prod_buyer,prod_cost,prod_price,prod_sale,prod_outline,prod_detail,prod_img,prod_totalstock,prod_insdate,prod_properstock,prod_size,prod_color,prod_delivery,prod_unit,prod_qtyin,prod_qtysale)
       VALUES ('P302000015','화운데이션','P302','P30202',22000,32000,23000,'세안후 바르는 좋은.....','은은한 향기와 함께.....','P302000015.gif',0,'2005-01-14',15,'','','','EA',0,0) ;
INSERT INTO prod  (prod_id,prod_name,prod_lgu,prod_buyer,prod_cost,prod_price,prod_sale,prod_outline,prod_detail,prod_img,prod_totalstock,prod_insdate,prod_properstock,prod_size,prod_color,prod_delivery,prod_unit,prod_qtyin,prod_qtysale)
       VALUES ('P302000016','머드팩','P302','P30202',120000,220000,172000,'세안후 바르는 좋은.....','은은한 향기와 함께.....','P302000016.gif',0,'2005-01-14',32,'','','','EA',0,0) ;
INSERT INTO prod  (prod_id,prod_name,prod_lgu,prod_buyer,prod_cost,prod_price,prod_sale,prod_outline,prod_detail,prod_img,prod_totalstock,prod_insdate,prod_properstock,prod_size,prod_color,prod_delivery,prod_unit,prod_qtyin,prod_qtysale)
       VALUES ('P302000021','참존 기초화장품','P302','P30203',23500,37500,26000,'피부를 산뜻하게.....','다정함을 향기와 함께.....','P302000021.gif',0,'2005-01-28',25,'','','','EA',0,0) ;
INSERT INTO prod  (prod_id,prod_name,prod_lgu,prod_buyer,prod_cost,prod_price,prod_sale,prod_outline,prod_detail,prod_img,prod_totalstock,prod_insdate,prod_properstock,prod_size,prod_color,prod_delivery,prod_unit,prod_qtyin,prod_qtysale)
       VALUES ('P302000022','참존 여성 향수','P302','P30203',78500,98500,83000,'좋은향기와 피부를 산뜻하게.....','다정함을 향기와 함께.....','P302000022.gif',0,'2005-01-28',53,'','','','EA',0,0) ;
INSERT INTO prod  (prod_id,prod_name,prod_lgu,prod_buyer,prod_cost,prod_price,prod_sale,prod_outline,prod_detail,prod_img,prod_totalstock,prod_insdate,prod_properstock,prod_size,prod_color,prod_delivery,prod_unit,prod_qtyin,prod_qtysale)
       VALUES ('P302000023','참존 립스틱','P302','P30203',21500,26500,22500,'좋은 피부를 산뜻하게.....','은은한 향기와 함께.....','P302000023.gif',0,'2005-01-28',17,'','','','EA',0,0) ;


CREATE TABLE  buyprod
(  buy_date  DATE           NOT NULL,             -- 입고일자
   buy_prod  VARCHAR2(10)   NOT NULL,             -- 상품코드
   buy_qty   NUMBER(10)     NOT NULL,             -- 매입수량
   buy_cost  NUMBER(10)     NOT NULL,             -- 매입단가
   CONSTRAINT pk_buyprod PRIMARY KEY (buy_date,buy_prod), 
   CONSTRAINT fr_buy_prod FOREIGN KEY (buy_prod) REFERENCES prod(prod_id)
);

INSERT INTO buyprod(buy_date,buy_prod,buy_qty,buy_cost) VALUES('2005-01-08','P202000001',18,10000);
INSERT INTO buyprod(buy_date,buy_prod,buy_qty,buy_cost) VALUES('2005-01-08','P202000002',19,13000);
INSERT INTO buyprod(buy_date,buy_prod,buy_qty,buy_cost) VALUES('2005-01-08','P202000003',11,15000);
INSERT INTO buyprod(buy_date,buy_prod,buy_qty,buy_cost) VALUES('2005-01-12','P201000001',21,21000);
INSERT INTO buyprod(buy_date,buy_prod,buy_qty,buy_cost) VALUES('2005-01-12','P201000002',13,22000);
INSERT INTO buyprod(buy_date,buy_prod,buy_qty,buy_cost) VALUES('2005-01-12','P201000003',15,23000);
INSERT INTO buyprod(buy_date,buy_prod,buy_qty,buy_cost) VALUES('2005-01-13','P101000001',22,210000);
INSERT INTO buyprod(buy_date,buy_prod,buy_qty,buy_cost) VALUES('2005-01-13','P101000002',23,310000);
INSERT INTO buyprod(buy_date,buy_prod,buy_qty,buy_cost) VALUES('2005-01-13','P101000003',21,410000);
INSERT INTO buyprod(buy_date,buy_prod,buy_qty,buy_cost) VALUES('2005-01-14','P201000004',15,12000);
INSERT INTO buyprod(buy_date,buy_prod,buy_qty,buy_cost) VALUES('2005-01-14','P201000005',32,13000);
INSERT INTO buyprod(buy_date,buy_prod,buy_qty,buy_cost) VALUES('2005-01-14','P201000006',11,14000);
INSERT INTO buyprod(buy_date,buy_prod,buy_qty,buy_cost) VALUES('2005-01-16','P202000007',22,25000);
INSERT INTO buyprod(buy_date,buy_prod,buy_qty,buy_cost) VALUES('2005-01-16','P202000008',33,27000);
INSERT INTO buyprod(buy_date,buy_prod,buy_qty,buy_cost) VALUES('2005-01-16','P202000009',14,28500);
INSERT INTO buyprod(buy_date,buy_prod,buy_qty,buy_cost) VALUES('2005-01-16','P302000011',125,59000);
INSERT INTO buyprod(buy_date,buy_prod,buy_qty,buy_cost) VALUES('2005-01-16','P302000012',16,89000);
INSERT INTO buyprod(buy_date,buy_prod,buy_qty,buy_cost) VALUES('2005-01-16','P302000013',13,17000);
INSERT INTO buyprod(buy_date,buy_prod,buy_qty,buy_cost) VALUES('2005-01-17','P302000014',21,25000);
INSERT INTO buyprod(buy_date,buy_prod,buy_qty,buy_cost) VALUES('2005-01-17','P302000015',33,22000);
INSERT INTO buyprod(buy_date,buy_prod,buy_qty,buy_cost) VALUES('2005-01-17','P302000016',17,120000);
INSERT INTO buyprod(buy_date,buy_prod,buy_qty,buy_cost) VALUES('2005-01-18','P301000001',15,21000);
INSERT INTO buyprod(buy_date,buy_prod,buy_qty,buy_cost) VALUES('2005-01-18','P301000002',19,17000);
INSERT INTO buyprod(buy_date,buy_prod,buy_qty,buy_cost) VALUES('2005-01-19','P202000010',21,55000);
INSERT INTO buyprod(buy_date,buy_prod,buy_qty,buy_cost) VALUES('2005-01-19','P202000011',91,55000);
INSERT INTO buyprod(buy_date,buy_prod,buy_qty,buy_cost) VALUES('2005-01-19','P202000012',15,55000);
INSERT INTO buyprod(buy_date,buy_prod,buy_qty,buy_cost) VALUES('2005-01-25','P102000003',11,590000);
INSERT INTO buyprod(buy_date,buy_prod,buy_qty,buy_cost) VALUES('2005-01-25','P102000004',13,990000);
INSERT INTO buyprod(buy_date,buy_prod,buy_qty,buy_cost) VALUES('2005-01-25','P102000005',22,1990000);
INSERT INTO buyprod(buy_date,buy_prod,buy_qty,buy_cost) VALUES('2005-01-26','P102000007',52,550000);
INSERT INTO buyprod(buy_date,buy_prod,buy_qty,buy_cost) VALUES('2005-01-27','P302000001',253,89000);
INSERT INTO buyprod(buy_date,buy_prod,buy_qty,buy_cost) VALUES('2005-01-27','P302000002',31,99000);
INSERT INTO buyprod(buy_date,buy_prod,buy_qty,buy_cost) VALUES('2005-01-27','P302000003',197,19000);
INSERT INTO buyprod(buy_date,buy_prod,buy_qty,buy_cost) VALUES('2005-01-28','P201000007',19,31000);
INSERT INTO buyprod(buy_date,buy_prod,buy_qty,buy_cost) VALUES('2005-01-28','P201000008',22,32000);
INSERT INTO buyprod(buy_date,buy_prod,buy_qty,buy_cost) VALUES('2005-01-28','P201000009',26,33000);
INSERT INTO buyprod(buy_date,buy_prod,buy_qty,buy_cost) VALUES('2005-01-31','P302000021',23,23500);
INSERT INTO buyprod(buy_date,buy_prod,buy_qty,buy_cost) VALUES('2005-01-31','P302000022',17,78500);
INSERT INTO buyprod(buy_date,buy_prod,buy_qty,buy_cost) VALUES('2005-01-31','P302000023',15,21500);
INSERT INTO buyprod(buy_date,buy_prod,buy_qty,buy_cost) VALUES('2005-02-03','P201000010',23,55000);
INSERT INTO buyprod(buy_date,buy_prod,buy_qty,buy_cost) VALUES('2005-02-03','P201000011',21,56000);
INSERT INTO buyprod(buy_date,buy_prod,buy_qty,buy_cost) VALUES('2005-02-03','P201000012',55,57000);
INSERT INTO buyprod(buy_date,buy_prod,buy_qty,buy_cost) VALUES('2005-02-08','P202000004',12,18000);
INSERT INTO buyprod(buy_date,buy_prod,buy_qty,buy_cost) VALUES('2005-02-08','P202000005',19,23000);
INSERT INTO buyprod(buy_date,buy_prod,buy_qty,buy_cost) VALUES('2005-02-08','P202000006',28,28000);
INSERT INTO buyprod(buy_date,buy_prod,buy_qty,buy_cost) VALUES('2005-02-09','P202000016',22,99000);
INSERT INTO buyprod(buy_date,buy_prod,buy_qty,buy_cost) VALUES('2005-02-09','P202000017',41,109000);
INSERT INTO buyprod(buy_date,buy_prod,buy_qty,buy_cost) VALUES('2005-02-09','P202000018',21,159000);
INSERT INTO buyprod(buy_date,buy_prod,buy_qty,buy_cost) VALUES('2005-02-11','P101000004',11,1150000);
INSERT INTO buyprod(buy_date,buy_prod,buy_qty,buy_cost) VALUES('2005-02-11','P101000005',10,2150000);
INSERT INTO buyprod(buy_date,buy_prod,buy_qty,buy_cost) VALUES('2005-02-11','P101000006',9,3150000);
INSERT INTO buyprod(buy_date,buy_prod,buy_qty,buy_cost) VALUES('2005-02-15','P302000004',33,21000);
INSERT INTO buyprod(buy_date,buy_prod,buy_qty,buy_cost) VALUES('2005-02-15','P302000005',191,18000);
INSERT INTO buyprod(buy_date,buy_prod,buy_qty,buy_cost) VALUES('2005-02-15','P302000006',39,20000);
INSERT INTO buyprod(buy_date,buy_prod,buy_qty,buy_cost) VALUES('2005-02-18','P301000003',46,22000);
INSERT INTO buyprod(buy_date,buy_prod,buy_qty,buy_cost) VALUES('2005-02-18','P301000004',41,27000);
INSERT INTO buyprod(buy_date,buy_prod,buy_qty,buy_cost) VALUES('2005-02-20','P202000013',16,110000);
INSERT INTO buyprod(buy_date,buy_prod,buy_qty,buy_cost) VALUES('2005-02-20','P202000014',18,120000);
INSERT INTO buyprod(buy_date,buy_prod,buy_qty,buy_cost) VALUES('2005-02-20','P202000015',13,130000);
INSERT INTO buyprod(buy_date,buy_prod,buy_qty,buy_cost) VALUES('2005-02-21','P201000013',16,110000);
INSERT INTO buyprod(buy_date,buy_prod,buy_qty,buy_cost) VALUES('2005-02-21','P201000014',28,120000);
INSERT INTO buyprod(buy_date,buy_prod,buy_qty,buy_cost) VALUES('2005-02-21','P201000015',25,130000);
INSERT INTO buyprod(buy_date,buy_prod,buy_qty,buy_cost) VALUES('2005-02-23','P202000019',22,210000);
INSERT INTO buyprod(buy_date,buy_prod,buy_qty,buy_cost) VALUES('2005-02-23','P202000020',19,220000);
INSERT INTO buyprod(buy_date,buy_prod,buy_qty,buy_cost) VALUES('2005-02-23','P202000021',13,230000);
INSERT INTO buyprod(buy_date,buy_prod,buy_qty,buy_cost) VALUES('2005-02-25','P102000001',15,690000);
INSERT INTO buyprod(buy_date,buy_prod,buy_qty,buy_cost) VALUES('2005-02-25','P102000002',12,890000);
INSERT INTO buyprod(buy_date,buy_prod,buy_qty,buy_cost) VALUES('2005-02-26','P102000006',13,660000);
INSERT INTO buyprod(buy_date,buy_prod,buy_qty,buy_cost) VALUES('2005-03-02','P201000016',725,100000);
INSERT INTO buyprod(buy_date,buy_prod,buy_qty,buy_cost) VALUES('2005-03-02','P201000017',341,110000);
INSERT INTO buyprod(buy_date,buy_prod,buy_qty,buy_cost) VALUES('2005-03-02','P201000018',111,120000);
INSERT INTO buyprod(buy_date,buy_prod,buy_qty,buy_cost) VALUES('2005-03-03','P201000019',16,210000);
INSERT INTO buyprod(buy_date,buy_prod,buy_qty,buy_cost) VALUES('2005-03-03','P201000020',39,220000);
INSERT INTO buyprod(buy_date,buy_prod,buy_qty,buy_cost) VALUES('2005-03-03','P201000021',32,230000);
INSERT INTO buyprod(buy_date,buy_prod,buy_qty,buy_cost) VALUES('2005-04-16','P202000001',12,10000);
INSERT INTO buyprod(buy_date,buy_prod,buy_qty,buy_cost) VALUES('2005-04-16','P202000002',13,13000);
INSERT INTO buyprod(buy_date,buy_prod,buy_qty,buy_cost) VALUES('2005-04-16','P202000003',5,15000);
INSERT INTO buyprod(buy_date,buy_prod,buy_qty,buy_cost) VALUES('2005-04-20','P201000001',15,21000);
INSERT INTO buyprod(buy_date,buy_prod,buy_qty,buy_cost) VALUES('2005-04-20','P201000002',7,22000);
INSERT INTO buyprod(buy_date,buy_prod,buy_qty,buy_cost) VALUES('2005-04-20','P201000003',9,23000);
INSERT INTO buyprod(buy_date,buy_prod,buy_qty,buy_cost) VALUES('2005-04-21','P101000001',16,210000);
INSERT INTO buyprod(buy_date,buy_prod,buy_qty,buy_cost) VALUES('2005-04-21','P101000002',17,310000);
INSERT INTO buyprod(buy_date,buy_prod,buy_qty,buy_cost) VALUES('2005-04-21','P101000003',15,410000);
INSERT INTO buyprod(buy_date,buy_prod,buy_qty,buy_cost) VALUES('2005-04-22','P201000004',9,12000);
INSERT INTO buyprod(buy_date,buy_prod,buy_qty,buy_cost) VALUES('2005-04-22','P201000005',26,13000);
INSERT INTO buyprod(buy_date,buy_prod,buy_qty,buy_cost) VALUES('2005-04-22','P201000006',5,14000);
INSERT INTO buyprod(buy_date,buy_prod,buy_qty,buy_cost) VALUES('2005-04-24','P202000007',16,25000);
INSERT INTO buyprod(buy_date,buy_prod,buy_qty,buy_cost) VALUES('2005-04-24','P202000008',27,27000);
INSERT INTO buyprod(buy_date,buy_prod,buy_qty,buy_cost) VALUES('2005-04-24','P202000009',8,28500);
INSERT INTO buyprod(buy_date,buy_prod,buy_qty,buy_cost) VALUES('2005-04-24','P302000011',19,59000);
INSERT INTO buyprod(buy_date,buy_prod,buy_qty,buy_cost) VALUES('2005-04-24','P302000012',10,89000);
INSERT INTO buyprod(buy_date,buy_prod,buy_qty,buy_cost) VALUES('2005-04-24','P302000013',7,17000);
INSERT INTO buyprod(buy_date,buy_prod,buy_qty,buy_cost) VALUES('2005-04-25','P302000014',15,25000);
INSERT INTO buyprod(buy_date,buy_prod,buy_qty,buy_cost) VALUES('2005-04-25','P302000015',27,22000);
INSERT INTO buyprod(buy_date,buy_prod,buy_qty,buy_cost) VALUES('2005-04-25','P302000016',11,120000);
INSERT INTO buyprod(buy_date,buy_prod,buy_qty,buy_cost) VALUES('2005-04-26','P301000001',9,21000);
INSERT INTO buyprod(buy_date,buy_prod,buy_qty,buy_cost) VALUES('2005-04-26','P301000002',13,17000);
INSERT INTO buyprod(buy_date,buy_prod,buy_qty,buy_cost) VALUES('2005-04-27','P202000010',15,55000);
INSERT INTO buyprod(buy_date,buy_prod,buy_qty,buy_cost) VALUES('2005-04-27','P202000011',25,55000);
INSERT INTO buyprod(buy_date,buy_prod,buy_qty,buy_cost) VALUES('2005-04-27','P202000012',9,55000);
INSERT INTO buyprod(buy_date,buy_prod,buy_qty,buy_cost) VALUES('2005-05-03','P102000003',5,590000);
INSERT INTO buyprod(buy_date,buy_prod,buy_qty,buy_cost) VALUES('2005-05-03','P102000004',7,990000);
INSERT INTO buyprod(buy_date,buy_prod,buy_qty,buy_cost) VALUES('2005-05-03','P102000005',16,1990000);
INSERT INTO buyprod(buy_date,buy_prod,buy_qty,buy_cost) VALUES('2005-05-04','P102000007',46,550000);
INSERT INTO buyprod(buy_date,buy_prod,buy_qty,buy_cost) VALUES('2005-05-05','P302000001',17,89000);
INSERT INTO buyprod(buy_date,buy_prod,buy_qty,buy_cost) VALUES('2005-05-05','P302000002',25,99000);
INSERT INTO buyprod(buy_date,buy_prod,buy_qty,buy_cost) VALUES('2005-05-05','P302000003',11,19000);
INSERT INTO buyprod(buy_date,buy_prod,buy_qty,buy_cost) VALUES('2005-05-06','P201000007',13,31000);
INSERT INTO buyprod(buy_date,buy_prod,buy_qty,buy_cost) VALUES('2005-05-06','P201000008',16,32000);
INSERT INTO buyprod(buy_date,buy_prod,buy_qty,buy_cost) VALUES('2005-05-06','P201000009',20,33000);
INSERT INTO buyprod(buy_date,buy_prod,buy_qty,buy_cost) VALUES('2005-05-09','P302000021',17,23500);
INSERT INTO buyprod(buy_date,buy_prod,buy_qty,buy_cost) VALUES('2005-05-09','P302000022',11,78500);
INSERT INTO buyprod(buy_date,buy_prod,buy_qty,buy_cost) VALUES('2005-05-09','P302000023',9,21500);
INSERT INTO buyprod(buy_date,buy_prod,buy_qty,buy_cost) VALUES('2005-05-12','P201000010',17,55000);
INSERT INTO buyprod(buy_date,buy_prod,buy_qty,buy_cost) VALUES('2005-05-12','P201000011',15,56000);
INSERT INTO buyprod(buy_date,buy_prod,buy_qty,buy_cost) VALUES('2005-05-12','P201000012',49,57000);
INSERT INTO buyprod(buy_date,buy_prod,buy_qty,buy_cost) VALUES('2005-05-17','P202000004',6,18000);
INSERT INTO buyprod(buy_date,buy_prod,buy_qty,buy_cost) VALUES('2005-05-17','P202000005',13,23000);
INSERT INTO buyprod(buy_date,buy_prod,buy_qty,buy_cost) VALUES('2005-05-17','P202000006',22,28000);
INSERT INTO buyprod(buy_date,buy_prod,buy_qty,buy_cost) VALUES('2005-05-18','P202000016',16,99000);
INSERT INTO buyprod(buy_date,buy_prod,buy_qty,buy_cost) VALUES('2005-05-18','P202000017',35,109000);
INSERT INTO buyprod(buy_date,buy_prod,buy_qty,buy_cost) VALUES('2005-05-18','P202000018',15,159000);
INSERT INTO buyprod(buy_date,buy_prod,buy_qty,buy_cost) VALUES('2005-05-20','P101000004',5,1150000);
INSERT INTO buyprod(buy_date,buy_prod,buy_qty,buy_cost) VALUES('2005-05-20','P101000005',4,2150000);
INSERT INTO buyprod(buy_date,buy_prod,buy_qty,buy_cost) VALUES('2005-05-20','P101000006',3,3150000);
INSERT INTO buyprod(buy_date,buy_prod,buy_qty,buy_cost) VALUES('2005-05-24','P302000004',27,21000);
INSERT INTO buyprod(buy_date,buy_prod,buy_qty,buy_cost) VALUES('2005-05-24','P302000005',25,18000);
INSERT INTO buyprod(buy_date,buy_prod,buy_qty,buy_cost) VALUES('2005-05-24','P302000006',33,20000);
INSERT INTO buyprod(buy_date,buy_prod,buy_qty,buy_cost) VALUES('2005-05-27','P301000003',40,22000);
INSERT INTO buyprod(buy_date,buy_prod,buy_qty,buy_cost) VALUES('2005-05-27','P301000004',35,27000);
INSERT INTO buyprod(buy_date,buy_prod,buy_qty,buy_cost) VALUES('2005-05-29','P202000013',10,110000);
INSERT INTO buyprod(buy_date,buy_prod,buy_qty,buy_cost) VALUES('2005-05-29','P202000014',12,120000);
INSERT INTO buyprod(buy_date,buy_prod,buy_qty,buy_cost) VALUES('2005-05-29','P202000015',7,130000);
INSERT INTO buyprod(buy_date,buy_prod,buy_qty,buy_cost) VALUES('2005-05-30','P201000013',10,110000);
INSERT INTO buyprod(buy_date,buy_prod,buy_qty,buy_cost) VALUES('2005-05-30','P201000014',22,120000);
INSERT INTO buyprod(buy_date,buy_prod,buy_qty,buy_cost) VALUES('2005-05-30','P201000015',19,130000);
INSERT INTO buyprod(buy_date,buy_prod,buy_qty,buy_cost) VALUES('2005-06-01','P202000019',16,210000);
INSERT INTO buyprod(buy_date,buy_prod,buy_qty,buy_cost) VALUES('2005-06-01','P202000020',13,220000);
INSERT INTO buyprod(buy_date,buy_prod,buy_qty,buy_cost) VALUES('2005-06-01','P202000021',7,230000);
INSERT INTO buyprod(buy_date,buy_prod,buy_qty,buy_cost) VALUES('2005-06-03','P102000001',9,690000);
INSERT INTO buyprod(buy_date,buy_prod,buy_qty,buy_cost) VALUES('2005-06-03','P102000002',6,890000);
INSERT INTO buyprod(buy_date,buy_prod,buy_qty,buy_cost) VALUES('2005-06-04','P102000006',7,660000);
INSERT INTO buyprod(buy_date,buy_prod,buy_qty,buy_cost) VALUES('2005-06-09','P201000016',19,100000);
INSERT INTO buyprod(buy_date,buy_prod,buy_qty,buy_cost) VALUES('2005-06-09','P201000017',35,110000);
INSERT INTO buyprod(buy_date,buy_prod,buy_qty,buy_cost) VALUES('2005-06-09','P201000018',25,120000);
INSERT INTO buyprod(buy_date,buy_prod,buy_qty,buy_cost) VALUES('2005-06-10','P201000019',10,210000);
INSERT INTO buyprod(buy_date,buy_prod,buy_qty,buy_cost) VALUES('2005-06-10','P201000020',33,220000);
INSERT INTO buyprod(buy_date,buy_prod,buy_qty,buy_cost) VALUES('2005-06-10','P201000021',26,230000);


CREATE TABLE  member
(  mem_id                VARCHAR2(15)   NOT NULL,   -- 회원ID  
   mem_pass              VARCHAR2(15)   NOT NULL,   -- 비밀번호
   mem_name              VARCHAR2(20)   NOT NULL,   -- 성명
   mem_regno1            CHAR(6)        NOT NULL,   -- 주민등록번호앞6자리
   mem_regno2            CHAR(7)        NOT NULL,   -- 주민등록번호뒤7자리
   mem_bir               DATE,                      -- 생일
   mem_zip               CHAR(7)        NOT NULL,   -- 우편번호
   mem_add1              VARCHAR2(100)  NOT NULL,   -- 주소1
   mem_add2              VARCHAR2(80)   NOT NULL,   -- 주소2
   mem_hometel           VARCHAR2(14)   NOT NULL,   -- 집전화번호                                
   mem_comtel            VARCHAR2(14)   NOT NULL,   -- 회사전화번호                              
   mem_hp                VARCHAR2(15),              -- 이동전화
   mem_mail              VARCHAR2(40)   NOT NULL,   -- E-mail주소
   mem_job               VARCHAR2(40),              -- 직업
   mem_like              VARCHAR2(40),              -- 취미
   mem_memorial          VARCHAR2(40),              -- 기념일명
   mem_memorialday       DATE,                      -- 기념일날짜
   mem_mileage           NUMBER(10),                -- 마일리지              
   mem_delete            VARCHAR2(1),               -- 삭제여부
   CONSTRAINT pk_mem_id PRIMARY KEY (mem_id) 
);

INSERT INTO member (mem_id,mem_pass,mem_name,mem_regno1,mem_regno2,mem_bir,mem_zip,mem_add1,mem_add2,mem_hometel,
                    mem_comtel,mem_hp,mem_mail,mem_job,mem_like,mem_memorial,mem_memorialday,mem_mileage,mem_delete)
       VALUES ('a001','asdfasdf','김은대','760115','1406420','1976-01-15','135-972','대전시 동구 용운동','222-2번지','042-621-4615',
               '042-621-4615','011-621-4615','pyoedab@lycos.co.kr','주부','수영','결혼기념일','1999-01-12',1000,'');
INSERT INTO member (mem_id,mem_pass,mem_name,mem_regno1,mem_regno2,mem_bir,mem_zip,mem_add1,mem_add2,mem_hometel,
                    mem_comtel,mem_hp,mem_mail,mem_job,mem_like,mem_memorial,mem_memorialday,mem_mileage,mem_delete)
       VALUES ('b001','1004','이쁜이','741004','2900000','1974-01-07','700-030','서울시 천사동 예쁜마을','1004-29','02-888-9999',
               '02-888-9999','016-888-9999','engelcd@pretty.net','회사원','수영','아버님생신','1999-02-12',2300,'');
INSERT INTO member (mem_id,mem_pass,mem_name,mem_regno1,mem_regno2,mem_bir,mem_zip,mem_add1,mem_add2,mem_hometel,
                    mem_comtel,mem_hp,mem_mail,mem_job,mem_like,mem_memorial,mem_memorialday,mem_mileage,mem_delete)
       VALUES ('c001','7777','신용환','740124','1400716','1974-01-24','407-817','대전광역시 중구 대흥동','477-9','042-123-5678',
               '042-123-5678','011-123-5678','kyh01e@hanmail.net','교사','독서','아내생일','1999-03-12',3500,'');
INSERT INTO member (mem_id,mem_pass,mem_name,mem_regno1,mem_regno2,mem_bir,mem_zip,mem_add1,mem_add2,mem_hometel,
                    mem_comtel,mem_hp,mem_mail,mem_job,mem_like,mem_memorial,mem_memorialday,mem_mileage,mem_delete)
       VALUES ('d001','123joy','성윤미','460409','2000000','1946-04-09','501-705','대전시 중구 하늘동 ','땅 3번지','042-222-8877',
               '042-222-8877','019-222-8877','dbs81f@hanmail.net','공무원','볼링','결혼기념일','1999-04-12',1700,'');
INSERT INTO member (mem_id,mem_pass,mem_name,mem_regno1,mem_regno2,mem_bir,mem_zip,mem_add1,mem_add2,mem_hometel,
                    mem_comtel,mem_hp,mem_mail,mem_job,mem_like,mem_memorial,mem_memorialday,mem_mileage,mem_delete)
       VALUES ('e001','00000000','이혜나','750501','2406017','1975-05-01','617-800','대전시 대덕구 읍내동','혜강아파트','042-432-8901',
               '042-432-8901','011-432-8901','bosiang@hanmail.net','농업','당구','아버님생신','1999-05-12',6500,'');
INSERT INTO member (mem_id,mem_pass,mem_name,mem_regno1,mem_regno2,mem_bir,mem_zip,mem_add1,mem_add2,mem_hometel,
                    mem_comtel,mem_hp,mem_mail,mem_job,mem_like,mem_memorial,mem_memorialday,mem_mileage,mem_delete)
       VALUES ('f001','12345678','신영남','751228','1459919','1972-11-04','140-706','대전광역시 대흥동','65-33 303호','042-253-2121',
               '042-253-2121','011-253-2121','SUPER-KHG@HANMAIL.NET','주부','볼링','아내생일','1999-06-12',2700,'');
INSERT INTO member (mem_id,mem_pass,mem_name,mem_regno1,mem_regno2,mem_bir,mem_zip,mem_add1,mem_add2,mem_hometel,
                    mem_comtel,mem_hp,mem_mail,mem_job,mem_like,mem_memorial,mem_memorialday,mem_mileage,mem_delete)
       VALUES ('g001','1456','송경희','771111','2403414','1965-01-01','339-841','충남금산군 제원면','심내리123-1','0412-356-3578',
               '0412-356-3578','017-356-3578','lim052@hanmail.net','주부','스키','결혼기념일','1999-07-12',800,'');
INSERT INTO member (mem_id,mem_pass,mem_name,mem_regno1,mem_regno2,mem_bir,mem_zip,mem_add1,mem_add2,mem_hometel,
                    mem_comtel,mem_hp,mem_mail,mem_job,mem_like,mem_memorial,mem_memorialday,mem_mileage,mem_delete)
       VALUES ('h001','9999','라준호','740728','1455822','1967-03-01','339-841','충남 논산시 양촌면','산직3구 345','042-522-1679',
               '042-522-1679','019-522-1679','wingl7@hanmail.net','회사원','독서','아내생일','1999-08-12',1500,'');
INSERT INTO member (mem_id,mem_pass,mem_name,mem_regno1,mem_regno2,mem_bir,mem_zip,mem_add1,mem_add2,mem_hometel,
                    mem_comtel,mem_hp,mem_mail,mem_job,mem_like,mem_memorial,mem_memorialday,mem_mileage,mem_delete)
       VALUES ('i001','1111','최지현','741220','2384719','1974-12-20','306-702','대전시 동구 가양1동','768-12','042-614-6914',
               '042-614-6914','017-614-6914','pan@orgio.net','공무원','등산','남편생일','1999-09-12',900,'');
INSERT INTO member (mem_id,mem_pass,mem_name,mem_regno1,mem_regno2,mem_bir,mem_zip,mem_add1,mem_add2,mem_hometel,
                    mem_comtel,mem_hp,mem_mail,mem_job,mem_like,mem_memorial,mem_memorialday,mem_mileage,mem_delete)
       VALUES ('j001','6262','김윤희','751019','2448920','1975-11-21','306-702','대전시 서구 삼천동','한신아파트305동309호','042-332-8976',
               '042-332-8976','018-332-8976','maxsys@hanmail.net','농업','개그','결혼기념일','1999-10-12',1100,'');
INSERT INTO member (mem_id,mem_pass,mem_name,mem_regno1,mem_regno2,mem_bir,mem_zip,mem_add1,mem_add2,mem_hometel,
                    mem_comtel,mem_hp,mem_mail,mem_job,mem_like,mem_memorial,mem_memorialday,mem_mileage,mem_delete)
       VALUES ('k001','7227','오철희','620123','1449311','1962-01-23','306-702','대전시 대덕구 대화동','34-567','042-157-8765',
               '042-157-8765','016-157-8765','equus@orgio.net','자영업','서예','아내생일','1999-11-12',3700,'');
INSERT INTO member (mem_id,mem_pass,mem_name,mem_regno1,mem_regno2,mem_bir,mem_zip,mem_add1,mem_add2,mem_hometel,
                    mem_comtel,mem_hp,mem_mail,mem_job,mem_like,mem_memorial,mem_memorialday,mem_mileage,mem_delete)
       VALUES ('l001','12345678','구길동','881214','1234566','1988-12-14','339-841','충남금산군 금산읍',' 하리35-322','0412-322-8865',
               '0412-322-8865','016-322-8865','email815@hanmail.co.kr','자영업','바둑','결혼기념일','1999-12-12',5300,'');
INSERT INTO member (mem_id,mem_pass,mem_name,mem_regno1,mem_regno2,mem_bir,mem_zip,mem_add1,mem_add2,mem_hometel,
                    mem_comtel,mem_hp,mem_mail,mem_job,mem_like,mem_memorial,mem_memorialday,mem_mileage,mem_delete)
       VALUES ('m001','pass','박지은','750315','2555555','1975-03-15','306-702','대전광역시 서구 갈마동','인성아파트 234동 907호','042-252-0675',
               '042-252-0675','016-252-0675','happy@hanmail.net','은행원','등산','아버님생신','1999-12-12',1300,'');
INSERT INTO member (mem_id,mem_pass,mem_name,mem_regno1,mem_regno2,mem_bir,mem_zip,mem_add1,mem_add2,mem_hometel,
                    mem_comtel,mem_hp,mem_mail,mem_job,mem_like,mem_memorial,mem_memorialday,mem_mileage,mem_delete)
       VALUES ('n001','1111','탁원재','750323','1011014','1975-03-23','306-702','대전시 동구 자양동','32-23','042-632-2176',
               '042-632-2176','019-632-2176','ping75@unitel.co.kr','축산업','낚시','결혼기념일','1999-02-12',2700,'');
INSERT INTO member (mem_id,mem_pass,mem_name,mem_regno1,mem_regno2,mem_bir,mem_zip,mem_add1,mem_add2,mem_hometel,
                    mem_comtel,mem_hp,mem_mail,mem_job,mem_like,mem_memorial,mem_memorialday,mem_mileage,mem_delete)
       VALUES ('o001','0909','배인정','780930','2447619','1978-09-30','306-702','대전시 서구 갈마동','경성아파트502동1101호','042-622-5971',
               '042-622-5971','011-622-5971','tar-song@hanmail.net','회사원','등산','어머님생신','1999-03-12',2600,'');
INSERT INTO member (mem_id,mem_pass,mem_name,mem_regno1,mem_regno2,mem_bir,mem_zip,mem_add1,mem_add2,mem_hometel,
                    mem_comtel,mem_hp,mem_mail,mem_job,mem_like,mem_memorial,mem_memorialday,mem_mileage,mem_delete)
       VALUES ('p001','sahra3','오성순','730805','2458323','1973-08-05','306-702','대전유성구송강동','한솔아파트 703동 407호','042-810-7658',
               '042-810-7658','017-810-7658','sahra235@intz.com','공무원','독서','남편생일','1999-05-12',2200,'');
INSERT INTO member (mem_id,mem_pass,mem_name,mem_regno1,mem_regno2,mem_bir,mem_zip,mem_add1,mem_add2,mem_hometel,
                    mem_comtel,mem_hp,mem_mail,mem_job,mem_like,mem_memorial,mem_memorialday,mem_mileage,mem_delete)
       VALUES ('q001','0000','육평회','721020','1402722','1972-10-20','306-702','대구광역시 대덕구 중리동','678-43','042-823-2359',
               '042-823-2359','017-823-2359','kph@hanmail.net','자영업','만화','결혼기념일','1999-06-12',1500,'');
INSERT INTO member (mem_id,mem_pass,mem_name,mem_regno1,mem_regno2,mem_bir,mem_zip,mem_add1,mem_add2,mem_hometel,
                    mem_comtel,mem_hp,mem_mail,mem_job,mem_like,mem_memorial,mem_memorialday,mem_mileage,mem_delete)
       VALUES ('r001','park1005','정은실','770120','2382532','1976-11-26','306-702','대전시 동구 용전동','321-25','042-533-8768',
               '042-533-8768','016-533-8768','econie@hanmail.net','학생','장기','어머님생신','1999-07-12',700,'');
INSERT INTO member (mem_id,mem_pass,mem_name,mem_regno1,mem_regno2,mem_bir,mem_zip,mem_add1,mem_add2,mem_hometel,
                    mem_comtel,mem_hp,mem_mail,mem_job,mem_like,mem_memorial,mem_memorialday,mem_mileage,mem_delete)
       VALUES ('s001','0819','안은정','770819','2459927','1977-10-01','306-702','대구광역시 서구 탄방동','산호아파트 107동 802호','042-222-8155',
               '042-222-8155','019-222-8155','songej@hanmail.net','공무원','바둑','결혼기념일','1999-07-12',3200,'');
INSERT INTO member (mem_id,mem_pass,mem_name,mem_regno1,mem_regno2,mem_bir,mem_zip,mem_add1,mem_add2,mem_hometel,
                    mem_comtel,mem_hp,mem_mail,mem_job,mem_like,mem_memorial,mem_memorialday,mem_mileage,mem_delete)
       VALUES ('t001','0506','성원태','760506','1454731','1976-05-06','306-702','대전광역시 중구 유천동','한사랑아파트 302동 504호','042-272-8657',
               '042-272-8657','011-272-8657','bob6@hanmail.net','학생','카레이싱','결혼기념일','1999-08-12',2200,'');
INSERT INTO member (mem_id,mem_pass,mem_name,mem_regno1,mem_regno2,mem_bir,mem_zip,mem_add1,mem_add2,mem_hometel,
                    mem_comtel,mem_hp,mem_mail,mem_job,mem_like,mem_memorial,mem_memorialday,mem_mileage,mem_delete)
       VALUES ('u001','1000','김성욱','731010','1460111','1973-10-10','306-702','대전시 동구 용전동','76-54','042-273-9056',
               '042-273-9056','018-273-9056','pss576@orgio.net','주부','영화감상','결혼기념일','1999-07-12',2700,'');
INSERT INTO member (mem_id,mem_pass,mem_name,mem_regno1,mem_regno2,mem_bir,mem_zip,mem_add1,mem_add2,mem_hometel,
                    mem_comtel,mem_hp,mem_mail,mem_job,mem_like,mem_memorial,mem_memorialday,mem_mileage,mem_delete)
       VALUES ('v001','00001111','이진영','520131','2402712','1952-01-31','306-702','대전시 동구 용전동','566-39번지','042-240-8766',
               '042-240-8766','017-240-8766','gagsong@orgio.net','자영업','낚시','남편생일','1999-09-12',4300,'');
INSERT INTO member (mem_id,mem_pass,mem_name,mem_regno1,mem_regno2,mem_bir,mem_zip,mem_add1,mem_add2,mem_hometel,
                    mem_comtel,mem_hp,mem_mail,mem_job,mem_like,mem_memorial,mem_memorialday,mem_mileage,mem_delete)
       VALUES ('w001','12341234','김형모','631213','1111111','1963-12-13','306-702','대전시 대덕구 연축동','23-43','02-345-9877',
               '02-345-9877','011-345-9877','songone@hanmail.net','학생','등산','결혼기념일','1999-11-12',2700,'');
INSERT INTO member (mem_id,mem_pass,mem_name,mem_regno1,mem_regno2,mem_bir,mem_zip,mem_add1,mem_add2,mem_hometel,
                    mem_comtel,mem_hp,mem_mail,mem_job,mem_like,mem_memorial,mem_memorialday,mem_mileage,mem_delete)
       VALUES ('x001','0000','진현경','770319','2110222','1977-03-19','306-702','대전광역시 동구 오정동','43-26','042-223-8767',
               '042-223-8767','019-223-8767','happysong@hanmail.net','주부','독서','결혼기념일','1999-02-12',8700,'');


CREATE TABLE  cart
(
   cart_member      VARCHAR2(15)    NOT NULL,       -- 회원ID
   cart_no          CHAR(13)        NOT NULL,       -- 주문번호
   cart_prod        VARCHAR2(10)    NOT NULL,       -- 상품코드
   cart_qty         NUMBER(8)       NOT NULL,       -- 수량
   CONSTRAINT pk_cart PRIMARY KEY (cart_no,cart_prod),
   CONSTRAINT fr_cart_member FOREIGN KEY (cart_member) REFERENCES member(mem_id),
   CONSTRAINT fr_cart_prod   FOREIGN KEY (cart_prod)   REFERENCES prod(prod_id)
);


INSERT INTO cart(cart_member,cart_no,cart_prod,cart_qty) VALUES ('a001','2005040100001','P101000001',5) ;
INSERT INTO cart(cart_member,cart_no,cart_prod,cart_qty) VALUES ('a001','2005040100001','P201000018',16) ;
INSERT INTO cart(cart_member,cart_no,cart_prod,cart_qty) VALUES ('a001','2005040100001','P302000003',7) ;
INSERT INTO cart(cart_member,cart_no,cart_prod,cart_qty) VALUES ('t001','2005040100002','P302000004',2) ;
INSERT INTO cart(cart_member,cart_no,cart_prod,cart_qty) VALUES ('t001','2005040100002','P101000002',2) ;
INSERT INTO cart(cart_member,cart_no,cart_prod,cart_qty) VALUES ('w001','2005040100003','P201000019',2) ;
INSERT INTO cart(cart_member,cart_no,cart_prod,cart_qty) VALUES ('w001','2005040100003','P302000005',9) ;
INSERT INTO cart(cart_member,cart_no,cart_prod,cart_qty) VALUES ('w001','2005040100003','P201000020',21) ;
INSERT INTO cart(cart_member,cart_no,cart_prod,cart_qty) VALUES ('w001','2005040100003','P101000003',3) ;
INSERT INTO cart(cart_member,cart_no,cart_prod,cart_qty) VALUES ('r001','2005040500001','P302000006',2) ;
INSERT INTO cart(cart_member,cart_no,cart_prod,cart_qty) VALUES ('r001','2005040500001','P101000004',2) ;
INSERT INTO cart(cart_member,cart_no,cart_prod,cart_qty) VALUES ('r001','2005040500001','P201000021',2) ;
INSERT INTO cart(cart_member,cart_no,cart_prod,cart_qty) VALUES ('q001','2005040500002','P302000011',11) ;
INSERT INTO cart(cart_member,cart_no,cart_prod,cart_qty) VALUES ('q001','2005040500002','P202000001',12) ;
INSERT INTO cart(cart_member,cart_no,cart_prod,cart_qty) VALUES ('q001','2005040500002','P101000005',4) ;
INSERT INTO cart(cart_member,cart_no,cart_prod,cart_qty) VALUES ('p001','2005040600001','P101000006',2) ;
INSERT INTO cart(cart_member,cart_no,cart_prod,cart_qty) VALUES ('p001','2005040600001','P202000002',2) ;
INSERT INTO cart(cart_member,cart_no,cart_prod,cart_qty) VALUES ('o001','2005040600002','P302000013',9) ;
INSERT INTO cart(cart_member,cart_no,cart_prod,cart_qty) VALUES ('o001','2005040600002','P202000003',9) ;
INSERT INTO cart(cart_member,cart_no,cart_prod,cart_qty) VALUES ('o001','2005040600002','P102000001',6) ;
INSERT INTO cart(cart_member,cart_no,cart_prod,cart_qty) VALUES ('f001','2005040800001','P302000014',2) ;
INSERT INTO cart(cart_member,cart_no,cart_prod,cart_qty) VALUES ('f001','2005040800001','P102000002',2) ;
INSERT INTO cart(cart_member,cart_no,cart_prod,cart_qty) VALUES ('f001','2005040800001','P202000004',2) ;
INSERT INTO cart(cart_member,cart_no,cart_prod,cart_qty) VALUES ('m001','2005040800002','P302000015',8) ;
INSERT INTO cart(cart_member,cart_no,cart_prod,cart_qty) VALUES ('m001','2005040800002','P202000005',8) ;
INSERT INTO cart(cart_member,cart_no,cart_prod,cart_qty) VALUES ('m001','2005040800002','P102000003',9) ;
INSERT INTO cart(cart_member,cart_no,cart_prod,cart_qty) VALUES ('l001','2005041000001','P302000016',2) ;
INSERT INTO cart(cart_member,cart_no,cart_prod,cart_qty) VALUES ('l001','2005041000001','P102000004',2) ;
INSERT INTO cart(cart_member,cart_no,cart_prod,cart_qty) VALUES ('l001','2005041000001','P202000006',2) ;
INSERT INTO cart(cart_member,cart_no,cart_prod,cart_qty) VALUES ('f001','2005041000002','P202000007',7) ;
INSERT INTO cart(cart_member,cart_no,cart_prod,cart_qty) VALUES ('f001','2005041000002','P102000005',8) ;
INSERT INTO cart(cart_member,cart_no,cart_prod,cart_qty) VALUES ('f001','2005041000002','P302000021',7) ;
INSERT INTO cart(cart_member,cart_no,cart_prod,cart_qty) VALUES ('j001','2005041200001','P302000022',2) ;
INSERT INTO cart(cart_member,cart_no,cart_prod,cart_qty) VALUES ('j001','2005041200001','P202000008',2) ;
INSERT INTO cart(cart_member,cart_no,cart_prod,cart_qty) VALUES ('j001','2005041200001','P102000006',2) ;
INSERT INTO cart(cart_member,cart_no,cart_prod,cart_qty) VALUES ('j001','2005041200001','P202000009',6) ;
INSERT INTO cart(cart_member,cart_no,cart_prod,cart_qty) VALUES ('m001','2005041200002','P102000007',7) ;
INSERT INTO cart(cart_member,cart_no,cart_prod,cart_qty) VALUES ('m001','2005041200002','P302000023',6) ;
INSERT INTO cart(cart_member,cart_no,cart_prod,cart_qty) VALUES ('m001','2005041200002','P202000010',2) ;
INSERT INTO cart(cart_member,cart_no,cart_prod,cart_qty) VALUES ('f001','2005041500001','P201000001',2) ;
INSERT INTO cart(cart_member,cart_no,cart_prod,cart_qty) VALUES ('f001','2005041500001','P302000001',2) ;
INSERT INTO cart(cart_member,cart_no,cart_prod,cart_qty) VALUES ('j001','2005041500002','P202000011',5) ;
INSERT INTO cart(cart_member,cart_no,cart_prod,cart_qty) VALUES ('j001','2005041500002','P201000002',5) ;
INSERT INTO cart(cart_member,cart_no,cart_prod,cart_qty) VALUES ('j001','2005041500002','P302000002',5) ;
INSERT INTO cart(cart_member,cart_no,cart_prod,cart_qty) VALUES ('f001','2005041600001','P302000003',2) ;
INSERT INTO cart(cart_member,cart_no,cart_prod,cart_qty) VALUES ('f001','2005041600001','P201000003',2) ;
INSERT INTO cart(cart_member,cart_no,cart_prod,cart_qty) VALUES ('f001','2005041600001','P202000012',2) ;
INSERT INTO cart(cart_member,cart_no,cart_prod,cart_qty) VALUES ('e001','2005041600002','P302000004',4) ;
INSERT INTO cart(cart_member,cart_no,cart_prod,cart_qty) VALUES ('e001','2005041600002','P201000004',3) ;
INSERT INTO cart(cart_member,cart_no,cart_prod,cart_qty) VALUES ('e001','2005041600002','P202000013',4) ;
INSERT INTO cart(cart_member,cart_no,cart_prod,cart_qty) VALUES ('d001','2005041800001','P302000005',2) ;
INSERT INTO cart(cart_member,cart_no,cart_prod,cart_qty) VALUES ('d001','2005041800001','P201000005',2) ;
INSERT INTO cart(cart_member,cart_no,cart_prod,cart_qty) VALUES ('d001','2005041800001','P202000014',2) ;
INSERT INTO cart(cart_member,cart_no,cart_prod,cart_qty) VALUES ('c001','2005041800002','P302000006',3) ;
INSERT INTO cart(cart_member,cart_no,cart_prod,cart_qty) VALUES ('c001','2005041800002','P201000006',1) ;
INSERT INTO cart(cart_member,cart_no,cart_prod,cart_qty) VALUES ('c001','2005041800002','P202000015',3) ;
INSERT INTO cart(cart_member,cart_no,cart_prod,cart_qty) VALUES ('b001','2005042000001','P302000011',2) ;
INSERT INTO cart(cart_member,cart_no,cart_prod,cart_qty) VALUES ('b001','2005042000001','P201000007',2) ;
INSERT INTO cart(cart_member,cart_no,cart_prod,cart_qty) VALUES ('b001','2005042000001','P202000016',2) ;
INSERT INTO cart(cart_member,cart_no,cart_prod,cart_qty) VALUES ('b001','2005042000001','P202000017',1) ;
INSERT INTO cart(cart_member,cart_no,cart_prod,cart_qty) VALUES ('b001','2005042000001','P201000008',5) ;
INSERT INTO cart(cart_member,cart_no,cart_prod,cart_qty) VALUES ('c001','2005042000002','P202000018',2) ;
INSERT INTO cart(cart_member,cart_no,cart_prod,cart_qty) VALUES ('c001','2005042000002','P201000009',2) ;
INSERT INTO cart(cart_member,cart_no,cart_prod,cart_qty) VALUES ('c001','2005042000002','P202000019',2) ;
INSERT INTO cart(cart_member,cart_no,cart_prod,cart_qty) VALUES ('c001','2005042000002','P201000010',4) ;
INSERT INTO cart(cart_member,cart_no,cart_prod,cart_qty) VALUES ('c001','2005042000002','P202000020',2) ;
INSERT INTO cart(cart_member,cart_no,cart_prod,cart_qty) VALUES ('x001','2005042400001','P201000011',2) ;
INSERT INTO cart(cart_member,cart_no,cart_prod,cart_qty) VALUES ('x001','2005042400001','P202000021',4) ;
INSERT INTO cart(cart_member,cart_no,cart_prod,cart_qty) VALUES ('x001','2005042400001','P201000012',3) ;
INSERT INTO cart(cart_member,cart_no,cart_prod,cart_qty) VALUES ('e001','2005042400002','P301000001',2) ;
INSERT INTO cart(cart_member,cart_no,cart_prod,cart_qty) VALUES ('e001','2005042400002','P201000013',2) ;
INSERT INTO cart(cart_member,cart_no,cart_prod,cart_qty) VALUES ('e001','2005042400002','P301000002',5) ;
INSERT INTO cart(cart_member,cart_no,cart_prod,cart_qty) VALUES ('e001','2005042400002','P201000014',13) ;
INSERT INTO cart(cart_member,cart_no,cart_prod,cart_qty) VALUES ('c001','2005042800001','P301000003',2) ;
INSERT INTO cart(cart_member,cart_no,cart_prod,cart_qty) VALUES ('c001','2005042800001','P201000015',2) ;
INSERT INTO cart(cart_member,cart_no,cart_prod,cart_qty) VALUES ('b001','2005042800002','P302000001',6) ;
INSERT INTO cart(cart_member,cart_no,cart_prod,cart_qty) VALUES ('b001','2005042800002','P201000016',15) ;
INSERT INTO cart(cart_member,cart_no,cart_prod,cart_qty) VALUES ('b001','2005042800002','P302000002',2) ;
INSERT INTO cart(cart_member,cart_no,cart_prod,cart_qty) VALUES ('b001','2005042800002','P201000017',2) ;
INSERT INTO cart(cart_member,cart_no,cart_prod,cart_qty) VALUES ('b001','2005050100001','P201000013',5) ;
INSERT INTO cart(cart_member,cart_no,cart_prod,cart_qty) VALUES ('b001','2005050100001','P301000002',5) ;
INSERT INTO cart(cart_member,cart_no,cart_prod,cart_qty) VALUES ('c001','2005050100002','P301000003',6) ;
INSERT INTO cart(cart_member,cart_no,cart_prod,cart_qty) VALUES ('c001','2005050100002','P201000014',3) ;
INSERT INTO cart(cart_member,cart_no,cart_prod,cart_qty) VALUES ('c001','2005050100002','P201000015',7) ;
INSERT INTO cart(cart_member,cart_no,cart_prod,cart_qty) VALUES ('d001','2005050300001','P302000001',4) ;
INSERT INTO cart(cart_member,cart_no,cart_prod,cart_qty) VALUES ('d001','2005050300001','P302000002',3) ;
INSERT INTO cart(cart_member,cart_no,cart_prod,cart_qty) VALUES ('e001','2005050300002','P201000016',8) ;
INSERT INTO cart(cart_member,cart_no,cart_prod,cart_qty) VALUES ('e001','2005050300002','P201000017',21) ;
INSERT INTO cart(cart_member,cart_no,cart_prod,cart_qty) VALUES ('g001','2005050500001','P302000003',4) ;
INSERT INTO cart(cart_member,cart_no,cart_prod,cart_qty) VALUES ('g001','2005050500001','P201000018',11) ;
INSERT INTO cart(cart_member,cart_no,cart_prod,cart_qty) VALUES ('g001','2005050500001','P302000004',3) ;
INSERT INTO cart(cart_member,cart_no,cart_prod,cart_qty) VALUES ('a001','2005050500002','P201000019',12) ;
INSERT INTO cart(cart_member,cart_no,cart_prod,cart_qty) VALUES ('a001','2005050700001','P302000005',5) ;
INSERT INTO cart(cart_member,cart_no,cart_prod,cart_qty) VALUES ('a001','2005050700001','P101000001',3) ;
INSERT INTO cart(cart_member,cart_no,cart_prod,cart_qty) VALUES ('a001','2005050700001','P101000002',1) ;
INSERT INTO cart(cart_member,cart_no,cart_prod,cart_qty) VALUES ('b001','2005050700002','P201000020',2) ;
INSERT INTO cart(cart_member,cart_no,cart_prod,cart_qty) VALUES ('b001','2005050700002','P302000006',6) ;
INSERT INTO cart(cart_member,cart_no,cart_prod,cart_qty) VALUES ('b001','2005050700002','P302000011',7) ;
INSERT INTO cart(cart_member,cart_no,cart_prod,cart_qty) VALUES ('c001','2005051000001','P201000021',5) ;
INSERT INTO cart(cart_member,cart_no,cart_prod,cart_qty) VALUES ('c001','2005051000001','P101000003',2) ;
INSERT INTO cart(cart_member,cart_no,cart_prod,cart_qty) VALUES ('c001','2005051000001','P101000004',4) ;
INSERT INTO cart(cart_member,cart_no,cart_prod,cart_qty) VALUES ('d001','2005051000002','P202000001',6) ;
INSERT INTO cart(cart_member,cart_no,cart_prod,cart_qty) VALUES ('d001','2005051000002','P302000012',8) ;
INSERT INTO cart(cart_member,cart_no,cart_prod,cart_qty) VALUES ('d001','2005051000002','P302000013',3) ;
INSERT INTO cart(cart_member,cart_no,cart_prod,cart_qty) VALUES ('d001','2005051000002','P101000005',5) ;
INSERT INTO cart(cart_member,cart_no,cart_prod,cart_qty) VALUES ('d001','2005051000002','P202000002',7) ;
INSERT INTO cart(cart_member,cart_no,cart_prod,cart_qty) VALUES ('f001','2005051200001','P101000006',6) ;
INSERT INTO cart(cart_member,cart_no,cart_prod,cart_qty) VALUES ('f001','2005051200001','P202000003',8) ;
INSERT INTO cart(cart_member,cart_no,cart_prod,cart_qty) VALUES ('f001','2005051200001','P302000014',4) ;
INSERT INTO cart(cart_member,cart_no,cart_prod,cart_qty) VALUES ('f001','2005051200001','P302000015',5) ;
INSERT INTO cart(cart_member,cart_no,cart_prod,cart_qty) VALUES ('f001','2005051200001','P102000001',1) ;
INSERT INTO cart(cart_member,cart_no,cart_prod,cart_qty) VALUES ('g001','2005051300001','P202000004',9) ;
INSERT INTO cart(cart_member,cart_no,cart_prod,cart_qty) VALUES ('g001','2005051300001','P102000002',2) ;
INSERT INTO cart(cart_member,cart_no,cart_prod,cart_qty) VALUES ('g001','2005051300001','P202000005',11) ;
INSERT INTO cart(cart_member,cart_no,cart_prod,cart_qty) VALUES ('g001','2005051300001','P302000016',6) ;
INSERT INTO cart(cart_member,cart_no,cart_prod,cart_qty) VALUES ('g001','2005051300001','P302000021',3) ;
INSERT INTO cart(cart_member,cart_no,cart_prod,cart_qty) VALUES ('i001','2005051500001','P102000003',3) ;
INSERT INTO cart(cart_member,cart_no,cart_prod,cart_qty) VALUES ('i001','2005051500001','P202000006',12) ;
INSERT INTO cart(cart_member,cart_no,cart_prod,cart_qty) VALUES ('j001','2005051600001','P102000004',4) ;
INSERT INTO cart(cart_member,cart_no,cart_prod,cart_qty) VALUES ('j001','2005051600001','P202000007',17) ;
INSERT INTO cart(cart_member,cart_no,cart_prod,cart_qty) VALUES ('j001','2005051600001','P302000022',1) ;
INSERT INTO cart(cart_member,cart_no,cart_prod,cart_qty) VALUES ('k001','2005051600002','P302000023',3) ;
INSERT INTO cart(cart_member,cart_no,cart_prod,cart_qty) VALUES ('k001','2005051600002','P102000005',5) ;
INSERT INTO cart(cart_member,cart_no,cart_prod,cart_qty) VALUES ('k001','2005051600002','P202000008',21) ;
INSERT INTO cart(cart_member,cart_no,cart_prod,cart_qty) VALUES ('k001','2005051600002','P102000006',6) ;
INSERT INTO cart(cart_member,cart_no,cart_prod,cart_qty) VALUES ('k001','2005051600002','P202000009',13) ;
INSERT INTO cart(cart_member,cart_no,cart_prod,cart_qty) VALUES ('l001','2005051800001','P302000001',4) ;
INSERT INTO cart(cart_member,cart_no,cart_prod,cart_qty) VALUES ('l001','2005051800001','P302000002',6) ;
INSERT INTO cart(cart_member,cart_no,cart_prod,cart_qty) VALUES ('m001','2005051800002','P102000007',3) ;
INSERT INTO cart(cart_member,cart_no,cart_prod,cart_qty) VALUES ('m001','2005051800002','P202000010',23) ;
INSERT INTO cart(cart_member,cart_no,cart_prod,cart_qty) VALUES ('m001','2005051800002','P201000001',5) ;
INSERT INTO cart(cart_member,cart_no,cart_prod,cart_qty) VALUES ('m001','2005051800002','P202000011',25) ;
INSERT INTO cart(cart_member,cart_no,cart_prod,cart_qty) VALUES ('m001','2005051800002','P302000003',7) ;
INSERT INTO cart(cart_member,cart_no,cart_prod,cart_qty) VALUES ('m001','2005051800002','P302000004',2) ;
INSERT INTO cart(cart_member,cart_no,cart_prod,cart_qty) VALUES ('o001','2005052100001','P201000002',2) ;
INSERT INTO cart(cart_member,cart_no,cart_prod,cart_qty) VALUES ('o001','2005052100001','P202000012',5) ;
INSERT INTO cart(cart_member,cart_no,cart_prod,cart_qty) VALUES ('o001','2005052100001','P201000003',5) ;
INSERT INTO cart(cart_member,cart_no,cart_prod,cart_qty) VALUES ('p001','2005052100002','P202000013',7) ;
INSERT INTO cart(cart_member,cart_no,cart_prod,cart_qty) VALUES ('p001','2005052100002','P302000005',3) ;
INSERT INTO cart(cart_member,cart_no,cart_prod,cart_qty) VALUES ('p001','2005052100002','P302000006',1) ;
INSERT INTO cart(cart_member,cart_no,cart_prod,cart_qty) VALUES ('p001','2005052100002','P201000004',6) ;
INSERT INTO cart(cart_member,cart_no,cart_prod,cart_qty) VALUES ('p001','2005052100002','P202000014',6) ;
INSERT INTO cart(cart_member,cart_no,cart_prod,cart_qty) VALUES ('r001','2005052400001','P201000005',2) ;
INSERT INTO cart(cart_member,cart_no,cart_prod,cart_qty) VALUES ('r001','2005052400001','P202000015',5) ;
INSERT INTO cart(cart_member,cart_no,cart_prod,cart_qty) VALUES ('r001','2005052400001','P302000011',4) ;
INSERT INTO cart(cart_member,cart_no,cart_prod,cart_qty) VALUES ('s001','2005052500001','P302000012',2) ;
INSERT INTO cart(cart_member,cart_no,cart_prod,cart_qty) VALUES ('s001','2005052500001','P201000006',3) ;
INSERT INTO cart(cart_member,cart_no,cart_prod,cart_qty) VALUES ('s001','2005052500001','P202000016',4) ;
INSERT INTO cart(cart_member,cart_no,cart_prod,cart_qty) VALUES ('t001','2005052500002','P201000007',1) ;
INSERT INTO cart(cart_member,cart_no,cart_prod,cart_qty) VALUES ('t001','2005052500002','P202000017',3) ;
INSERT INTO cart(cart_member,cart_no,cart_prod,cart_qty) VALUES ('t001','2005052500002','P201000008',6) ;
INSERT INTO cart(cart_member,cart_no,cart_prod,cart_qty) VALUES ('t001','2005052500002','P202000018',2) ; 
INSERT INTO cart(cart_member,cart_no,cart_prod,cart_qty) VALUES ('v001','2005052800001','P201000009',3) ; 
INSERT INTO cart(cart_member,cart_no,cart_prod,cart_qty) VALUES ('v001','2005052800001','P202000019',1) ; 
INSERT INTO cart(cart_member,cart_no,cart_prod,cart_qty) VALUES ('w001','2005052900001','P201000010',2) ; 
INSERT INTO cart(cart_member,cart_no,cart_prod,cart_qty) VALUES ('w001','2005052900001','P202000020',9) ; 
INSERT INTO cart(cart_member,cart_no,cart_prod,cart_qty) VALUES ('w001','2005052900001','P201000011',3) ; 
INSERT INTO cart(cart_member,cart_no,cart_prod,cart_qty) VALUES ('x001','2005052900002','P202000021',8) ; 
INSERT INTO cart(cart_member,cart_no,cart_prod,cart_qty) VALUES ('x001','2005052900002','P201000012',4) ; 
INSERT INTO cart(cart_member,cart_no,cart_prod,cart_qty) VALUES ('x001','2005052900002','P301000001',7) ; 
INSERT INTO cart(cart_member,cart_no,cart_prod,cart_qty) VALUES ('a001','2005060500001','P302000013',2) ; 
INSERT INTO cart(cart_member,cart_no,cart_prod,cart_qty) VALUES ('a001','2005060500001','P302000014',11);  
INSERT INTO cart(cart_member,cart_no,cart_prod,cart_qty) VALUES ('a001','2005060500001','P302000015',2) ; 
INSERT INTO cart(cart_member,cart_no,cart_prod,cart_qty) VALUES ('b001','2005060600001','P302000016',9) ; 
INSERT INTO cart(cart_member,cart_no,cart_prod,cart_qty) VALUES ('b001','2005060600001','P302000021',2) ; 
INSERT INTO cart(cart_member,cart_no,cart_prod,cart_qty) VALUES ('b001','2005060600001','P302000022',8) ; 
INSERT INTO cart(cart_member,cart_no,cart_prod,cart_qty) VALUES ('c001','2005061200001','P302000023',2) ; 
INSERT INTO cart(cart_member,cart_no,cart_prod,cart_qty) VALUES ('c001','2005061200001','P302000001',7) ; 
INSERT INTO cart(cart_member,cart_no,cart_prod,cart_qty) VALUES ('d001','2005061300001','P302000002',2) ; 
INSERT INTO cart(cart_member,cart_no,cart_prod,cart_qty) VALUES ('d001','2005061300001','P302000003',6) ; 
INSERT INTO cart(cart_member,cart_no,cart_prod,cart_qty) VALUES ('e001','2005061300002','P302000004',2) ; 
INSERT INTO cart(cart_member,cart_no,cart_prod,cart_qty) VALUES ('e001','2005061300002','P302000005',5) ; 
INSERT INTO cart(cart_member,cart_no,cart_prod,cart_qty) VALUES ('e001','2005062100001','P302000006',2) ; 
INSERT INTO cart(cart_member,cart_no,cart_prod,cart_qty) VALUES ('e001','2005062100001','P302000011',4) ; 
INSERT INTO cart(cart_member,cart_no,cart_prod,cart_qty) VALUES ('f001','2005062100002','P302000012',2) ; 
INSERT INTO cart(cart_member,cart_no,cart_prod,cart_qty) VALUES ('f001','2005062500001','P302000013',3) ; 
INSERT INTO cart(cart_member,cart_no,cart_prod,cart_qty) VALUES ('f001','2005062500001','P302000014',2) ; 
INSERT INTO cart(cart_member,cart_no,cart_prod,cart_qty) VALUES ('f001','2005062500001','P302000015',1) ; 
INSERT INTO cart(cart_member,cart_no,cart_prod,cart_qty) VALUES ('b001','2005070100001','P201000013',5) ; 
INSERT INTO cart(cart_member,cart_no,cart_prod,cart_qty) VALUES ('b001','2005070100001','P301000002',5) ; 
INSERT INTO cart(cart_member,cart_no,cart_prod,cart_qty) VALUES ('c001','2005070100002','P301000003',6) ; 
INSERT INTO cart(cart_member,cart_no,cart_prod,cart_qty) VALUES ('c001','2005070100002','P201000014',3) ; 
INSERT INTO cart(cart_member,cart_no,cart_prod,cart_qty) VALUES ('c001','2005070100002','P201000015',7) ; 
INSERT INTO cart(cart_member,cart_no,cart_prod,cart_qty) VALUES ('d001','2005070300001','P302000001',4) ; 
INSERT INTO cart(cart_member,cart_no,cart_prod,cart_qty) VALUES ('d001','2005070300001','P302000002',3) ; 
INSERT INTO cart(cart_member,cart_no,cart_prod,cart_qty) VALUES ('e001','2005070300002','P201000016',8) ; 
INSERT INTO cart(cart_member,cart_no,cart_prod,cart_qty) VALUES ('e001','2005070300002','P201000017',21);  
INSERT INTO cart(cart_member,cart_no,cart_prod,cart_qty) VALUES ('g001','2005070800001','P101000001',3) ; 
INSERT INTO cart(cart_member,cart_no,cart_prod,cart_qty) VALUES ('g001','2005070800001','P101000002',1) ; 
INSERT INTO cart(cart_member,cart_no,cart_prod,cart_qty) VALUES ('r001','2005070800002','P101000003',2) ; 
INSERT INTO cart(cart_member,cart_no,cart_prod,cart_qty) VALUES ('h001','2005071100001','P101000005',5) ; 
INSERT INTO cart(cart_member,cart_no,cart_prod,cart_qty) VALUES ('r001','2005071100002','P101000006',6) ; 
INSERT INTO cart(cart_member,cart_no,cart_prod,cart_qty) VALUES ('i001','2005071900001','P102000001',1) ; 
INSERT INTO cart(cart_member,cart_no,cart_prod,cart_qty) VALUES ('i001','2005071900001','P102000002',2) ; 
INSERT INTO cart(cart_member,cart_no,cart_prod,cart_qty) VALUES ('i001','2005071900001','P102000003',3) ; 
INSERT INTO cart(cart_member,cart_no,cart_prod,cart_qty) VALUES ('u001','2005071900002','P102000004',4) ; 
INSERT INTO cart(cart_member,cart_no,cart_prod,cart_qty) VALUES ('u001','2005071900002','P102000005',5) ; 
INSERT INTO cart(cart_member,cart_no,cart_prod,cart_qty) VALUES ('j001','2005072800001','P102000006',6) ; 
INSERT INTO cart(cart_member,cart_no,cart_prod,cart_qty) VALUES ('j001','2005072800001','P102000003',3) ; 
INSERT INTO cart(cart_member,cart_no,cart_prod,cart_qty) VALUES ('q001','2005072800002','P102000004',4) ; 
INSERT INTO cart(cart_member,cart_no,cart_prod,cart_qty) VALUES ('q001','2005072800002','P102000005',5) ; 
INSERT INTO cart(cart_member,cart_no,cart_prod,cart_qty) VALUES ('c001','2005072800003','P301000003',2) ; 
INSERT INTO cart(cart_member,cart_no,cart_prod,cart_qty) VALUES ('c001','2005072800003','P201000015',2) ; 
INSERT INTO cart(cart_member,cart_no,cart_prod,cart_qty) VALUES ('b001','2005072800004','P302000001',6) ; 
INSERT INTO cart(cart_member,cart_no,cart_prod,cart_qty) VALUES ('b001','2005072800004','P201000016',15);  
INSERT INTO cart(cart_member,cart_no,cart_prod,cart_qty) VALUES ('b001','2005072800004','P302000002',2) ; 
INSERT INTO cart(cart_member,cart_no,cart_prod,cart_qty) VALUES ('b001','2005072800004','P201000017',2) ;

COMMIT;

SET TERMOUT ON
SET ECHO ON