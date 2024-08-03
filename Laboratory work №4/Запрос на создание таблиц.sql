USE Dormitory

-- �������� ������� "������������� ��������"
CREATE TABLE �������������_�������� (
    id BIGINT PRIMARY KEY,
    ����������� TINYINT NOT NULL,
    ��� VARCHAR(100) NOT NULL,
    ������� CHAR(13) NOT NULL,
);

-- �������� ����������� ������� ��� ������ �����
CREATE UNIQUE INDEX ����������_������_������������
ON �������������_�������� (�����������)

-- �������� ������� "�������"
CREATE TABLE ������� (
    �����_������� SMALLINT PRIMARY KEY,
    �����_����� TINYINT NOT NULL
	FOREIGN KEY (�����_�����) REFERENCES �������������_��������(�����������)
);

-- �������� ������� "��������"
CREATE TABLE �������� (
    id BIGINT PRIMARY KEY,
    ��� VARCHAR(100) NOT NULL,
    ������� CHAR(13) NOT NULL,
    ������� SMALLINT NOT NULL,
    �������������� VARCHAR(40),
    ������������� VARCHAR(40) NOT NULL,
    FOREIGN KEY (�������) REFERENCES �������(�����_�������)
);

-- �������� ������� "������� ������"
CREATE TABLE �������_������ (
    �����_������� SMALLINT PRIMARY KEY,
    �������� VARCHAR(40) NOT NULL,
    �������� TEXT
);

-- �������� ������� ����� "������������� ��������"
CREATE TABLE �������������_�������� (
    id_�������� BIGINT,
    �����_������� SMALLINT,
    FOREIGN KEY (id_��������) REFERENCES ��������(id),
    FOREIGN KEY (�����_�������) REFERENCES �������_������(�����_�������),
    PRIMARY KEY (id_��������, �����_�������)
);
