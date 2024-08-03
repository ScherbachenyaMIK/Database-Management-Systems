-- Список компаний с задолженностями выше 3000000
DECLARE @currentDate DATE = GETDATE();
SELECT 
    C.Company_name,
	SUM(CASE WHEN dbo.ScaleLoanAmount(@currentDate, Co.Contract_id) <= dbo.CalculateTotalPayments(Co.Contract_id, @currentDate) 
			THEN 0 
			ELSE dbo.ScaleLoanAmount(@currentDate, Co.Contract_id) - dbo.CalculateTotalPayments(Co.Contract_id, @currentDate)
			END) AS Debt
FROM Companies C
LEFT JOIN Contracts Co ON C.Code = Co.Company_Code
LEFT JOIN Loan_repayments L ON Co.Contract_id = L.Contract_id
GROUP BY C.Company_name
HAVING SUM(Co.Size) - COALESCE(SUM(L.Amount), 0) > 3000000;

-- Список договоров обновляющихся на этой неделе
SELECT *
FROM Contracts
WHERE DATEDIFF(DAY, '2023-06-06', Contract_Date) <= 7 AND DATEDIFF(DAY, '2023-06-06', Contract_Date) > 0;

-- Компании и списки их кредитов
SELECT C.Company_name,
    STUFF((SELECT ', ' + CAST(Co.Contract_id AS VARCHAR(MAX))
           FROM Contracts Co
           WHERE Co.Company_code = C.Code
           FOR XML PATH('')), 1, 2, '') AS Contracts
FROM Companies C
GROUP BY C.Company_name, C.Code
ORDER BY C.Code;

-- Cколько компании выплатили банку и дата последнего платежа
SELECT C.Company_name, SUM(L.Amount) AS Payments, MAX(L.Contract_date) AS Last_payment
FROM Companies C
JOIN Contracts Co ON C.Code = Co.Company_code
JOIN Loan_repayments L ON Co.Contract_id = L.Contract_id
GROUP BY C.Company_name, C.Code
ORDER BY C.Code;