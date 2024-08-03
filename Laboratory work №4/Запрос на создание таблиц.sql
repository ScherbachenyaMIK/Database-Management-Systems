USE Dormitory

-- Создание таблицы "Ответственный персонал"
CREATE TABLE Ответственный_персонал (
    id BIGINT PRIMARY KEY,
    обязанности TINYINT NOT NULL,
    ФИО VARCHAR(100) NOT NULL,
    телефон CHAR(13) NOT NULL,
);

-- Создание уникального индекса для номера этажа
CREATE UNIQUE INDEX уникальный_индекс_обязанностей
ON Ответственный_персонал (обязанности)

-- Создание таблицы "Комнаты"
CREATE TABLE Комнаты (
    номер_комнаты SMALLINT PRIMARY KEY,
    номер_этажа TINYINT NOT NULL
	FOREIGN KEY (номер_этажа) REFERENCES Ответственный_персонал(обязанности)
);

-- Создание таблицы "Студенты"
CREATE TABLE Студенты (
    id BIGINT PRIMARY KEY,
    ФИО VARCHAR(100) NOT NULL,
    телефон CHAR(13) NOT NULL,
    комната SMALLINT NOT NULL,
    национальность VARCHAR(40),
    специальность VARCHAR(40) NOT NULL,
    FOREIGN KEY (комната) REFERENCES Комнаты(номер_комнаты)
);

-- Создание таблицы "Комната отдыха"
CREATE TABLE Комната_отдыха (
    номер_комнаты SMALLINT PRIMARY KEY,
    название VARCHAR(40) NOT NULL,
    описание TEXT
);

-- Создание таблицы связи "Ответственные студенты"
CREATE TABLE Ответственные_студенты (
    id_студента BIGINT,
    номер_комнаты SMALLINT,
    FOREIGN KEY (id_студента) REFERENCES Студенты(id),
    FOREIGN KEY (номер_комнаты) REFERENCES Комната_отдыха(номер_комнаты),
    PRIMARY KEY (id_студента, номер_комнаты)
);
