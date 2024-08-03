DECLARE @currentDate DATE = GETDATE();
SELECT 
	C.Company_name,
	Co.Contract_id,
	Co.Contract_date,
	Co.Size,
	Ct.Year_percentage,
	Ct.Type_of_percentage,
	Ct.Repayment_period,
	Ct.Penalty_percentage,
	dbo.ScaleLoanAmount(@currentDate, Co.Contract_id) AS Must_be_paid,
	dbo.CalculateTotalPayments(Co.Contract_id, @currentDate) AS Paid,
	CASE WHEN dbo.ScaleLoanAmount(@currentDate, Co.Contract_id) <= dbo.CalculateTotalPayments(Co.Contract_id, @currentDate) 
			THEN 0 
			ELSE dbo.ScaleLoanAmount(@currentDate, Co.Contract_id) - dbo.CalculateTotalPayments(Co.Contract_id, @currentDate)
			END AS Debt
FROM Companies C
JOIN Contracts Co ON C.Code = Co.Company_code
JOIN Contract_Templates Ct ON Co.Contract_code = Ct.Code
--GROUP BY GROUPING SETS (
--	(C.Company_name,
--	C.Code,
--	Co.Contract_id,
--	Co.Contract_date,
--	Co.Size,
--	Ct.Year_percentage,
--	Ct.Type_of_percentage,
--	Ct.Repayment_period,
--	Ct.Penalty_percentage),
--	(), (), ()
--	)
ORDER BY C.Code;