-- address 테이블 생성
CREATE TABLE address ( 
	zip_code		  VARCHAR2(6),
	address_detail	  VARCHAR2(20));
	
ALTER TABLE address ADD CONSTRAINT pk_zip_code PRIMARY KEY (zip_code);


-- customer 테이블 생성
CREATE TABLE customer ( 
	customer_id		  VARCHAR2(10),
	customer_name	  VARCHAR2(20),
	phone_number	  VARCHAR2(15),
	email			  VARCHAR2(20),
	first_reg_date	  DATE,
	sex_code		  VARCHAR2(2),
	birth			  VARCHAR2(8),
	job               VARCHAR2(20),
	zip_code		  VARCHAR2(6));

ALTER TABLE customer ADD CONSTRAINT pk_customer PRIMARY KEY (customer_id);
ALTER TABLE customer ADD CONSTRAINT fk_customer_zip_code FOREIGN KEY (zip_code) REFERENCES address (zip_code);


-- item 테이블 생성
CREATE TABLE item ( 
	item_id			VARCHAR2(10),
	product_name	VARCHAR2(30),
	product_desc	VARCHAR2(50),
	category_id		VARCHAR2(10),
	price			NUMBER(10,0));
	
ALTER TABLE item ADD CONSTRAINT pk_item PRIMARY KEY (item_id);


-- reservation 테이블 생성
CREATE TABLE reservation ( 
	reserv_no	    VARCHAR2(30),
	reserv_date	    VARCHAR2(8),
	reserv_time	    VARCHAR2(4),
	customer_id	    VARCHAR2(10) CONSTRAINT nn_reservation_customer_id NOT NULL enable,
	branch		    VARCHAR2(20),
	visitor_cnt	    NUMBER(3,0),
    cancel 		    VARCHAR2(1));

ALTER TABLE reservation ADD CONSTRAINT pk_reservation PRIMARY KEY (reserv_no);
ALTER TABLE reservation ADD CONSTRAINT fk_reservation_customer_id FOREIGN KEY (customer_id) REFERENCES customer (customer_id);


-- order_info 테이블 생성
CREATE TABLE order_info ( 
	order_no	    VARCHAR2(30),
	item_id		    VARCHAR2(10),
	reserv_no	    VARCHAR2(30),
	quantity	    NUMBER(3,0),
    sales           NUMBER(10,0));

ALTER TABLE order_info ADD CONSTRAINT pk_order_info PRIMARY KEY (order_no, item_id);
ALTER TABLE order_info ADD CONSTRAINT fk_order_info_item_id FOREIGN KEY (item_id) REFERENCES item (item_id);
ALTER TABLE order_info ADD CONSTRAINT fk_order_info_reserv_no FOREIGN KEY (reserv_no) REFERENCES reservation (reserv_no);	
