CREATE TABLE ���ǳ��� (
     ���ǳ�����ȣ NUMBER(3)
    ,������ȣ NUMBER(3)
    ,�����ȣ NUMBER(3)
    ,���ǽ� VARCHAR2(10)
    ,����  NUMBER(3)
    ,�����ο� NUMBER(5)
    ,��� date
);

CREATE TABLE ���� (
     �����ȣ NUMBER(3)
    ,�����̸� VARCHAR2(50)
    ,���� NUMBER(3)
);

CREATE TABLE ���� (
     ������ȣ NUMBER(3)
    ,�����̸� VARCHAR2(20)
    ,���� VARCHAR2(50)
    ,���� VARCHAR2(50)
    ,�ּ� VARCHAR2(100)
);

CREATE TABLE �������� (
    ����������ȣ NUMBER(3)
    ,�й� NUMBER(10)
    ,�����ȣ NUMBER(3)
    ,���ǽ� VARCHAR2(10)
    ,���� NUMBER(3)
    ,������� VARCHAR(10)
    ,��� DATE 
);

CREATE TABLE �л� (
     �й� NUMBER(10)
    ,�̸� VARCHAR2(50)
    ,�ּ� VARCHAR2(100)
    ,���� VARCHAR2(50)
    ,������ VARCHAR2(500)
    ,������� DATE
    ,�б� NUMBER(3)
    ,���� NUMBER
);


COMMIT;



/*       ���ǳ���, ����, ����, ��������, �л� ���̺��� ����ð� �Ʒ��� ���� ���� ������ �� �� 
        (1)'�л�' ���̺��� PK Ű��  '�й�'���� ����ش� 
        (2)'��������' ���̺��� PK Ű�� '����������ȣ'�� ����ش� 
        (3)'����' ���̺��� PK Ű�� '�����ȣ'�� ����ش� 
        (4)'����' ���̺��� PK Ű�� '������ȣ'�� ����ش�
        (5)'���ǳ���'�� PK�� '���ǳ�����ȣ'�� ����ش�. 

        (6)'�л�' ���̺��� PK�� '��������' ���̺��� '�й�' �÷��� �����Ѵ� FK Ű ����
        (7)'����' ���̺��� PK�� '��������' ���̺��� '�����ȣ' �÷��� �����Ѵ� FK Ű ���� 
        (8)'����' ���̺��� PK�� '���ǳ���' ���̺��� '������ȣ' �÷��� �����Ѵ� FK Ű ����
        (9)'����' ���̺��� PK�� '���ǳ���' ���̺��� '�����ȣ' �÷��� �����Ѵ� FK Ű ����
            �� ���̺� ���� �����͸� ����Ʈ 

    ex) ALTER TABLE �л� ADD CONSTRAINT PK_�л�_�й� PRIMARY KEY (�й�);
        
        ALTER TABLE �������� 
        ADD CONSTRAINT FK_�л�_�й� FOREIGN KEY(�й�)
        REFERENCES �л�(�й�);

*/

ALTER TABLE �л� ADD CONSTRAINT PK_�л�_�й� PRIMARY KEY (�й�);
ALTER TABLE �������� ADD CONSTRAINT PK_��������_����������ȣ PRIMARY KEY (����������ȣ);
ALTER TABLE ���� ADD CONSTRAINT PK_���񳻿�_�����ȣ PRIMARY KEY (�����ȣ);
ALTER TABLE ���� ADD CONSTRAINT PK_����_������ȣ PRIMARY KEY (������ȣ);

ALTER TABLE �������� 
ADD CONSTRAINT FK_�л�_�й� FOREIGN KEY(�й�)
REFERENCES �л�(�й�);

ALTER TABLE �������� 
ADD CONSTRAINT FK_����_�����ȣ FOREIGN KEY(�����ȣ)
REFERENCES ����(�����ȣ);

ALTER TABLE ���ǳ��� 
ADD CONSTRAINT FK_����_������ȣ FOREIGN KEY(������ȣ)
REFERENCES ����(������ȣ);

ALTER TABLE ���ǳ��� 
ADD CONSTRAINT FK_����_�����ȣ2 FOREIGN KEY(�����ȣ)
REFERENCES ����(�����ȣ);



COMMIT;