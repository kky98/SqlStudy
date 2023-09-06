/* INNER JOIN ��������(��������) */
SELECT *
FROM �л� ;
SELECT *
FROM ��������;

SELECT �л�.�й�
     , �л�.�̸�
     , �л�.����
     , ��������.����������ȣ 
     , ��������.�����ȣ
     , ����.�����̸� 
FROM �л�, ��������, ���� 
WHERE �л�.�й� = ��������.�й�
AND   ��������.�����ȣ = ����.�����ȣ 
AND   �л�.�̸� = '�ּ���';

-- �ּ����� ���� �������� ����Ͻÿ� 
SELECT  �л�.�й�
      , �л�.�̸�
      , SUM(����.����) as ��������
FROM �л�, ��������, ���� 
WHERE �л�.�й� = ��������.�й�
AND   ��������.�����ȣ = ����.�����ȣ 
AND   �л�.�̸� = '�ּ���'
GROUP BY �л�.�й�
        ,�л�.�̸�;
        
/* OUTER JOIN �ܺ�����
   ��� ���ʿ� null ���� ���Խ��Ѿ� �Ҷ� 
   (������ ���������̺��� ������ ���Խ��Ѿ��ϸ� �ƿ�����������)
*/        
SELECT  *
FROM �л�, ��������                       -- null�� ���Խ�ų ���̺���
WHERE �л�.�й� = ��������.�й�(+)    -- (+) <-- ���ʿ��� ���� ���� 
AND  �л�.�̸� ='������';

-- �л��� �����̷� �Ǽ�, �Ѽ��� ������ ����Ͻÿ� 
-- ����л� ��� null�̸� 0���� 
SELECT  �л�.�й�
      , �л�.�̸�
      , COUNT(��������.����������ȣ) as ���������Ǽ�
      , SUM(NVL(����.����,0)) as ��������
FROM �л�, ��������, ����              
WHERE �л�.�й� = ��������.�й�(+)
AND   ��������.�����ȣ = ����.�����ȣ(+)
GROUP BY �л�.�й�
       , �л�.�̸�
ORDER BY 3 DESC;


SELECT *
FROM �л�, ��������
WHERE �л�.�й� = ��������.�й� (+);


SELECT �л�.�й�
     , �л�.�̸�
     , �л�.����
     , ��������.����������ȣ 
     , (SELECT �����̸�   -- ��Į�� �������� (������ ��밡��)
        FROM ���� 
        WHERE �����ȣ = ��������.�����ȣ) as �����̸�
FROM �л�, ��������
WHERE �л�.�й� = ��������.�й�
AND   �л�.�̸� = '�ּ���';

/* �л��� �� ���� �ο����� ����Ͻÿ�  */
SELECT ����
     , COUNT(*) as �л���
FROM �л�
GROUP BY ����
ORDER BY 2 DESC;


/* �л��� '�������' ���� ���� �л��� ����Ͻÿ� */
SELECT �̸�, ���� 
FROM �л�
WHERE ���� >= (SELECT AVG(����)
               FROM �л�)   -- ��ø �������� 
ORDER BY 2 DESC;

SELECT �̸�, ���� 
FROM �л�
WHERE ���� = (SELECT MAX(����)
             FROM �л�);   -- ��ø �������� 
-- ���������� ���� �л���? 
SELECT *
FROM �л� 
WHERE �й� NOT IN (SELECT �й�
                   FROM ��������)
;
/* �ζ��� �� (FROM��) 
   SELECT ���� ���� ����� ��ġ ���̺�ó�� ��� 
*/
SELECT *
FROM (SELECT ROWNUM as rnum
            ,�й�, �̸�, ����
      FROM �л�) a -- select���� ���̺�ó�� ��� 
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


/*�л��߿� ���� ���� 5�� ����Ͻÿ� */
SELECT *
FROM(SELECT rownum as ����
             , a.*
     FROM (  SELECT �̸�
                   , ���� 
              FROM �л�
              ORDER BY ���� DESC
           ) a
    )
WHERE ���� = 3;
-- member, cart, prod �� ����Ͽ� 
-- ���� īƮ���Ƚ��, ��ǰǰ��Ǽ�, ��ǰ���ż���, �ѱ��űݾ��� ����Ͻÿ� 
-- �����̷��� ���ٸ� 0 <- ���� ��µǷη� 
















SELECT a.mem_id
     , a.mem_name
     , COUNT(DISTINCT b.cart_no) īƮ���Ƚ��
     , COUNT(c.prod_id)          ��ǰǰ��Ǽ�
     , SUM(nvl(b.cart_qty,0))    ��ǰ���ż���
     , SUM(NVL(b.cart_qty * c.prod_sale, 0)) as �����ջ�ݾ�
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
     , COUNT(DISTINCT b.cart_no) īƮ���Ƚ�� 
     , COUNT(c.prod_id)          ��ǰǰ��� 
FROM member a
LEFT OUTER JOIN cart b
ON(a.mem_id = b.cart_member)
LEFT OUTER JOIN prod c
ON(b.cart_prod = c.prod_id) 
GROUP BY a.mem_id
       , a.mem_name;









SELECT a.mem_id
     , a.mem_name
     , COUNT(DISTINCT b.cart_no) īƮ���Ƚ��
     , COUNT(c.prod_id) ��ǰǰ��Ǽ�
     , SUM(nvl(b.cart_qty,0))  ��ǰ���ż���
     , SUM(NVL(b.cart_qty * c.prod_sale, 0)) as �����ջ�ݾ�
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











        


