-- �������� �������������
CREATE VIEW �������������_���������_��������� AS
SELECT p.id_���������, p.���, p.�����, p.email, p.���������, p.����_�_�����������, p.�����_����������, f.id_��������� 
FROM �������� p
JOIN ���������_��������� pf ON p.id_��������� = pf.id_���������
JOIN ��������� f ON pf.id_��������� = f.id_���������
WHERE f.id_��������� <= 3