CREATE TABLE �������� (
    id_��������� INT PRIMARY KEY,
    ��� NVARCHAR(100),
    ����� NVARCHAR(100),
    email NVARCHAR(100),
    ��������� NVARCHAR(100),
    �����_���������� NVARCHAR(100),
    ����_�_����������� NVARCHAR(100)
);

CREATE TABLE ������ (
    id_������� INT PRIMARY KEY,
    �������� NVARCHAR(100),
    ������ TEXT
);

CREATE TABLE ��������� (
    id_��������� INT PRIMARY KEY,
    id_������� INT,
    FOREIGN KEY (id_�������) REFERENCES ������(id_�������)
);

CREATE TABLE ���������_��������� (
    id_��������� INT,
    id_��������� INT,
    PRIMARY KEY (id_���������, id_���������),
    FOREIGN KEY (id_���������) REFERENCES ���������(id_���������),
    FOREIGN KEY (id_���������) REFERENCES ��������(id_���������)
);
