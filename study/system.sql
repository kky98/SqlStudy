-- �ּ� ctrl + / 
-- ���� ����� (oracle 11g ���� ������ ## �� �ٿ�����.)
-- ���� ��Ÿ�Ϸ� ��������� ���� �Ʒ� ��ũ��Ʈ�� �������.
ALTER SESSION SET "_ORACLE_SCRIPT"=true; 
-- ���๮�� ; <--������ �ν���.
-- ������ ctrl + enter or ���� ��ư 
-- ����ڸ� :java , ��й�ȣ : oracle
CREATE USER java IDENTIFIED BY oracle;
-- ���� ����
GRANT CONNECT, RESOURCE TO java;
-- ���̺� �����̽� ���� ���� 
GRANT UNLIMITED TABLESPACE TO java;


-- �������� �� ������ imp 
-- ���� java/oracle�� ����

