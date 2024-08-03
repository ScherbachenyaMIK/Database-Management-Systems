USE Credits;

-- Создание таблицы "Companies"
CREATE TABLE Companies (
    Code BIGINT PRIMARY KEY,
    Company_name NVARCHAR(255) NOT NULL
);

-- Создание таблицы "Contract_Templates"
CREATE TABLE Contract_Templates (
    Code BIGINT PRIMARY KEY,
    Repayment_period INT NOT NULL,
    Year_percentage DECIMAL(5,2) NOT NULL
);

-- Создание таблицы "Contracts"
CREATE TABLE Contracts (
    Contract_id BIGINT PRIMARY KEY,
    Company_code BIGINT NOT NULL,
    Contract_code BIGINT NOT NULL,
    Size DECIMAL(18,2) NOT NULL,
    Contract_date DATE NOT NULL,
    FOREIGN KEY (Company_code) REFERENCES Companies(Code),
    FOREIGN KEY (Contract_code) REFERENCES Contract_Templates(Code)
);

-- Создание таблицы "Loan_repayments"
CREATE TABLE Loan_repayments (
    Repayment_id BIGINT PRIMARY KEY,
    Contract_id BIGINT NOT NULL,
    Amount DECIMAL(18,2) NOT NULL,
    Contract_date DATE NOT NULL,
    FOREIGN KEY (Contract_id) REFERENCES Contracts(Contract_id)
);

-- Добавление поля для таблицы "Contract_Templates"
ALTER TABLE Contract_Templates
ADD Type_of_percentage NCHAR(15) NOT NULL;

-- Добавление поля для таблицы "Contract_Templates"
ALTER TABLE Contract_Templates
ADD Penalty_percentage DECIMAL(5,2) NOT NULL;