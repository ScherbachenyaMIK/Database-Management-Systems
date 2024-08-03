DECLARE @currentDate DATE = GETDATE();
SELECT 
	C.Company_name, 
	COUNT(Co.Contract_id) AS Count_Of_Credits, 
	SUM(CASE WHEN dbo.ScaleLoanAmount(@currentDate, Co.Contract_id) <= dbo.CalculateTotalPayments(Co.Contract_id, @currentDate) 
			THEN 1 
			ELSE 0 
			END) AS Count_Of_Paid_Credits,
	SUM(CASE WHEN dbo.ScaleLoanAmount(@currentDate, Co.Contract_id) <= dbo.CalculateTotalPayments(Co.Contract_id, @currentDate) 
			THEN 0 
			ELSE 1 
			END) AS Count_Of_Non_Paid_Credits,
	SUM(CASE WHEN dbo.ScaleLoanAmount(@currentDate, Co.Contract_id) <= dbo.CalculateTotalPayments(Co.Contract_id, @currentDate) 
			THEN 0 
			ELSE dbo.ScaleLoanAmount(@currentDate, Co.Contract_id) - dbo.CalculateTotalPayments(Co.Contract_id, @currentDate)
			END) AS Debt
FROM Companies C
JOIN Contracts Co ON C.Code = Co.Company_code
GROUP BY ROLLUP(C.Company_name);
