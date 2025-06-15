/*Створюю таблицю в PostgreSQL*/

CREATE TABLE bank_churn (
	CustomerId INTEGER PRIMARY KEY,
    Surname VARCHAR(50),
    CreditScore INTEGER,
    Geography VARCHAR(50),
    Gender VARCHAR(10),
    Age INTEGER,
    Tenure INTEGER,
    Balance NUMERIC(15, 2),
    NumOfProducts INTEGER,
    HasCrCard BOOLEAN,
    IsActiveMember BOOLEAN,
    EstimatedSalary NUMERIC(15, 2),
    Exited BOOLEAN
);

/*З допомогою опції Import/Export Data... імпортую CSV-файл у таблицю*/

/*Перевіряю чи таблиця створена і дані імпортовані.*/

SELECT * 
FROM bank_churn
LIMIT 5;

/**/
