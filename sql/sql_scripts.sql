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

/*Перевіряю чи є пропущені дані*/
SELECT 
    COUNT(*) AS total_rows,
    COUNT(*) - COUNT(CustomerId) AS missing_customer_id,
    COUNT(*) - COUNT(Surname) AS missing_surname,
    COUNT(*) - COUNT(CreditScore) AS missing_credit_score,
    COUNT(*) - COUNT(Geography) AS missing_geography,
    COUNT(*) - COUNT(Gender) AS missing_gender,
    COUNT(*) - COUNT(Age) AS missing_age,
    COUNT(*) - COUNT(Tenure) AS missing_tenure,
    COUNT(*) - COUNT(Balance) AS missing_balance,
    COUNT(*) - COUNT(NumOfProducts) AS missing_num_of_products,
    COUNT(*) - COUNT(HasCrCard) AS missing_has_cr_card,
    COUNT(*) - COUNT(IsActiveMember) AS missing_is_active_member,
    COUNT(*) - COUNT(EstimatedSalary) AS missing_estimated_salary,
    COUNT(*) - COUNT(Exited) AS missing_exited
FROM bank_churn;

-- Перевіряю чи є дублікати за CustomerId
SELECT CustomerId, COUNT(*) 
FROM bank_churn 
GROUP BY CustomerId 
HAVING COUNT(*) > 1;

--розподіл клієнтів за віковою групою та частка клієнтів кожної групи, що покинули банк
SELECT 
	CASE 
		WHEN age <= 25 THEN '<25'
		WHEN age >25 and age<=45 THEN '25-45'
		WHEN age > 45 and age<=60 THEN '46-60'
		ELSE '>60'
	END as age_group,
	COUNT (*) as total_count,
	COUNT(CASE WHEN Exited = true THEN 1 END) as exited_count,
	ROUND((SUM(CASE WHEN Exited = true THEN 1 ELSE 0 END) * 100.0 / COUNT(*)),2) as churn_rate_percentage
FROM bank_churn
GROUP BY age_group
ORDER BY churn_rate_percentage DESC;

--Аналіз відтоку клієнтів за статтю та країною
SELECT 
	geography,
	gender,
	COUNT(*) as total_count,
	COUNT(CASE WHEN Exited = true THEN 1 END) as exited_count,
	ROUND(AVG(Exited::INTEGER) * 100,2) as churn_rate_percentage
FROM bank_churn
	GROUP BY geography, gender
	ORDER BY churn_rate_percentage DESC;


