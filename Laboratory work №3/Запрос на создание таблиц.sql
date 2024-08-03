CREATE TABLE Участник (
    id_участника INT PRIMARY KEY,
    ФИО NVARCHAR(100),
    Адрес NVARCHAR(100),
    email NVARCHAR(100),
    Должность NVARCHAR(100),
    Место_проживания NVARCHAR(100),
    Роль_в_конференции NVARCHAR(100)
);

CREATE TABLE Доклад (
    id_доклада INT PRIMARY KEY,
    Название NVARCHAR(100),
    Резюме TEXT
);

CREATE TABLE Заседание (
    id_заседания INT PRIMARY KEY,
    id_доклада INT,
    FOREIGN KEY (id_доклада) REFERENCES Доклад(id_доклада)
);

CREATE TABLE Участники_заседания (
    id_заседания INT,
    id_участника INT,
    PRIMARY KEY (id_заседания, id_участника),
    FOREIGN KEY (id_заседания) REFERENCES Заседание(id_заседания),
    FOREIGN KEY (id_участника) REFERENCES Участник(id_участника)
);
