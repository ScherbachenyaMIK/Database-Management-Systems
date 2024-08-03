USE Конференции_V2

ALTER TABLE Доклад
ADD CONSTRAINT FK_Авторы_ФИО
FOREIGN KEY (Авторы) REFERENCES Участник(ФИО);