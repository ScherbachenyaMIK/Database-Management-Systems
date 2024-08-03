USE �����������_V2

CREATE TABLE �������� (
    id_��������� INT PRIMARY KEY,
    ��� NVARCHAR(100) NOT NULL,
    ����� NVARCHAR(100) NOT NULL,
    email NVARCHAR(100) NOT NULL,
	����_�������� TIMESTAMP NOT NULL,
    ��������� NVARCHAR(100) NOT NULL,
    �����_���������� NVARCHAR(100) NOT NULL,
    ����_�_����������� NVARCHAR(100) NOT NULL
);

CREATE TABLE ������ (
    id_������� INT PRIMARY KEY,
    �������� NVARCHAR(100) NOT NULL,
    ������ TEXT NOT NULL
);

CREATE TABLE ��������� (
    id_��������� INT PRIMARY KEY,
    id_������� INT NOT NULL,
    FOREIGN KEY (id_�������) REFERENCES ������(id_�������)
);

CREATE TABLE ���������_��������� (
    id_��������� INT,
    id_��������� INT,
    PRIMARY KEY (id_���������, id_���������),
    FOREIGN KEY (id_���������) REFERENCES ���������(id_���������),
    FOREIGN KEY (id_���������) REFERENCES ��������(id_���������)
);

CREATE TABLE ������_������� (
    id_������� INT PRIMARY KEY,
    ���_������ NVARCHAR(100) NOT NULL,
    FOREIGN KEY (id_�������) REFERENCES ������(id_�������),
    FOREIGN KEY (���_������) REFERENCES ��������(���)
);