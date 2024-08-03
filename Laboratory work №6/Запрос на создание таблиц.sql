USE Конференции_V2

CREATE TABLE Участник (
    id_участника INT PRIMARY KEY,
    ФИО NVARCHAR(100) NOT NULL,
    Адрес NVARCHAR(100) NOT NULL,
    email NVARCHAR(100) NOT NULL,
	Дата_рождения TIMESTAMP NOT NULL,
    Должность NVARCHAR(100) NOT NULL,
    Место_проживания NVARCHAR(100) NOT NULL,
    Роль_в_конференции NVARCHAR(100) NOT NULL
);

CREATE TABLE Доклад (
    id_доклада INT PRIMARY KEY,
    Название NVARCHAR(100) NOT NULL,
    Резюме TEXT NOT NULL
);

CREATE TABLE Заседание (
    id_заседания INT PRIMARY KEY,
    id_доклада INT NOT NULL,
    FOREIGN KEY (id_доклада) REFERENCES Доклад(id_доклада)
);

CREATE TABLE Участники_заседания (
    id_заседания INT,
    id_участника INT,
    PRIMARY KEY (id_заседания, id_участника),
    FOREIGN KEY (id_заседания) REFERENCES Заседание(id_заседания),
    FOREIGN KEY (id_участника) REFERENCES Участник(id_участника)
);

CREATE TABLE Авторы_доклада (
    id_доклада INT PRIMARY KEY,
    ФИО_автора NVARCHAR(100) NOT NULL,
    FOREIGN KEY (id_доклада) REFERENCES Доклад(id_доклада),
    FOREIGN KEY (ФИО_автора) REFERENCES Участник(ФИО)
);