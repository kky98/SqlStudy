/*
  ���� Ÿ�� (number) 
  number(p, s) p�� �Ҽ����� �������� ��� ��ȿ���� �ڸ����� �ǹ���.
               s�� �Ҽ��� �ڸ����� �ǹ���. (s�� ����Ʈ 0)
               s�� 2�̸� �Ҽ��� 2�ڸ� ���� �ݿø�.
               s�� ���� �̸� �Ҽ��� ���� ���� �ڸ�����ŭ �ݿø�
*/
-- ���̺� ���� 
DROP TABLE ex3_1;
-- ���̺� �⺻ �Ӽ����� ��ȸ (�÷���,Ÿ��,������)
DESC ex3_1; 

CREATE TABLE ex3_1(
    num1 number(3)      -- ���� 3�ڸ� 
   ,num2 number(3, 2)   -- ��ü ���� 1�ڸ� �Ҽ��� 2�ڸ� 
   ,num3 number(5,-2)   -- ���� �ڸ����� �ݿø�.��(7�ڸ�)
   ,num4 number   
);
INSERT INTO ex3_1 (num1) VALUES(0.7898); 
INSERT INTO ex3_1 (num1) VALUES(99.5);
INSERT INTO ex3_1 (num1) VALUES(1004);   -- ����
SELECT *
FROM ex3_1;
INSERT INTO ex3_1 (num2) VALUES(0.7898); 
INSERT INTO ex3_1 (num2) VALUES(1.2345); 
INSERT INTO ex3_1 (num2) VALUES(32);     -- ���� 

INSERT INTO ex3_1 (num3) VALUES(12345.2345); 
INSERT INTO ex3_1 (num3) VALUES(123459.2345); 
INSERT INTO ex3_1 (num3) VALUES(12345679.2345);  -- ���� ��ü 7�ڸ� 
/*
  ��¥ ������ Ÿ��(DATE[����Ͻú���], TIMESTAMP[����Ͻú��ʹи���])
*/
CREATE TABLE ex3_2(
     date1 DATE
    ,date2 TIMESTAMP
);
-- sysdate ����ð� dateŸ������, systimestamp ����ð� timestamp Ÿ������ 
INSERT INTO ex3_2 VALUES(SYSDATE, SYSTIMESTAMP);
SELECT *
FROM ex3_2;
CREATE TABLE ex3_3(
     user_id VARCHAR2(100)
    ,create_dt DATE DEFAULT SYSDATE
);
INSERT INTO ex3_3 (user_id) VALUES('a001');
SELECT *
FROM ex3_3;
/*
  ��������
  NOT NULL ���� ������� �ʰڴ�.
  UNIQUE   �ߺ��� ������� �ʰڴ�. 
  CHECK    Ư�� �����͸� �ްڴ� 
  PRIMARY KEY  �⺻Ű(�ϳ��� ���̺� 1���� ��������)
               �� ���� �����ϴ� �ĺ��ڷ� ��� PK�� �����ϸ� UNIQUE&NOT NULL �����
  FOREIGN KEY  �ܷ�Ű �ٸ����̺��� pk�� �����ϴ� Ű 
*/
CREATE TABLE ex3_4(
       mem_id VARCHAR2(100) NOT NULL UNIQUE
     , mem_nm VARCHAR2(100)
     , mem_email VARCHAR2(100) NOT NULL
     , CONSTRAINT uq_ex3_4 UNIQUE(mem_email) --�������� �̸��� �����ϰ������
);
INSERT INTO ex3_4(mem_id, mem_email) VALUES('a001', 'a001@gmail.com');
INSERT INTO ex3_4(mem_id, mem_email) VALUES('a001', 'a001@gmail.com'); --���� unique
INSERT INTO ex3_4(mem_nm) VALUES('�ؼ�'); -- ���� id, email notnull
SELECT * FROM ex3_4;
SELECT *
FROM user_constraints
WHERE constraint_name LIKE '%EX%';
-- check �������� 
CREATE TABLE ex3_5(
    nm varchar2(100) 
   ,age number
   ,gender varchar2(1) 
   ,CONSTRAINTS ck_ex3_5_age CHECK(age BETWEEN 1 AND 150)
   ,CONSTRAINTS ck_ex3_5_gender CHECK(gender IN('F','M'))
);
INSERT INTO ex3_5 VALUES ('�ؼ�', 10, 'M');
INSERT INTO ex3_5 VALUES ('�ؼ�', 10, 'A'); -- ���� F or M check 
INSERT INTO ex3_5 VALUES ('�ؼ�', 151, 'M'); -- ���� age ������ 
SELECT * FROM ex3_5;

/*
    foreing key ���� �����ϴ� ���̺��� �÷��� �⺻Ű�� ���� �Ǿ��־����.
    primary key�� �� ���̺� 1��, key�� ������ 1 ~ n���� ����Ű�� �������� 
*/
CREATE TABLE dep(
    deptno NUMBER(3) CONSTRAINT dep_pk_deptno PRIMARY KEY ,
    deptname VARCHAR2(20) ,
    floor NUMBER(5)
);

CREATE TABLE emp(
    empno NUMBER(5) CONSTRAINT emp_pk_employee PRIMARY KEY ,
    empname VARCHAR2(20) ,
    title VARCHAR2(20) ,
    dno NUMBER(3) CONSTRAINT emp_fk_dno REFERENCES dep(deptno),
    salary NUMBER(10)
);
COMMIT;

INSERT INTO DEP (DEPTNO, DEPTNAME, FLOOR) VALUES (1, '����', 8);
INSERT INTO DEP (DEPTNO, DEPTNAME, FLOOR) VALUES (2, '��ȹ', 10);
INSERT INTO DEP (DEPTNO, DEPTNAME, FLOOR) VALUES (3, '����', 9);
INSERT INTO DEP (DEPTNO, DEPTNAME, FLOOR) VALUES (4, 'DB', 2);


INSERT INTO EMP (EMPNO, EMPNAME, TITLE, DNO, SALARY) VALUES (2106, '��â��', '�븮', 2, 2000000);
INSERT INTO EMP (EMPNO, EMPNAME, TITLE, DNO, SALARY) VALUES (3426, '�ڿ���', '����', 3, 2500000);
INSERT INTO EMP (EMPNO, EMPNAME, TITLE, DNO, SALARY) VALUES (3011, '�̼���', '����', 1, 3000000);
INSERT INTO EMP (EMPNO, EMPNAME, TITLE, DNO, SALARY) VALUES (1003, '������', '�븮', 1, 2000000);
INSERT INTO EMP (EMPNO, EMPNAME, TITLE, DNO, SALARY) VALUES (3427, '����ö', '���', 3, 1500000);

INSERT INTO EMP (EMPNO, EMPNAME, TITLE, DNO, SALARY) VALUES (3428, '�ؼ�', '���', 4, 1500000);
--���������� �ݿ� 
COMMIT;
--��� 
ROLLBACK;

SELECT *
FROM emp;
SELECT *
FROM dep;
-- �����ϰ� �ִ� ���̺��� �ֱ⶧���� �׳� drop�� �ȵ�.
-- �������� ���� �� ���̺� ���� 
drop table dep cascade constraints;

SELECT emp.empname
     , emp.title
     , dep.deptname
FROM emp, dep
WHERE emp.dno = dep.deptno
AND emp.empname = '�̼���';  -- join �ڿ��� ��ﳻ�� ���̺� ���踦 �δ� ���










CREATE TABLE tb_info ( 
    info_no NUMBER(3) PRIMARY KEY ,
    pc_no varchar2(10) UNIQUE NOT NULL ,
    nm VARCHAR2(20) ,
    email VARCHAR2(50) ,
    hobby VARCHAR2(1000),
    mbti  VARCHAR2(4)
);


