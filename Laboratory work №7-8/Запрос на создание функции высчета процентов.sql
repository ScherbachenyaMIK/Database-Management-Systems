-- Создание функции для масштабирования суммы кредита по процентам
CREATE FUNCTION ScaleLoanAmount
(
    @currentDate DATE,
    @contractId BIGINT
)
RETURNS DECIMAL(18,2)
AS
BEGIN
    DECLARE @scaledAmount DECIMAL(18,2);
    DECLARE @typeOfPercentage NCHAR(15);
	DECLARE @repaymentPeriod INT;
	DECLARE @contractDate DATE;
    DECLARE @monthPercentage DECIMAL(5,2);
	DECLARE @contractPenalty DECIMAL(5,2);

    -- Получаем информацию о контракте
    SELECT 
	@typeOfPercentage = Ct.Type_of_percentage, 
	@monthPercentage = Ct.Year_percentage / 12, 
	@repaymentPeriod = Ct.Repayment_period, 
	@contractDate = Co.Contract_date,
	@contractPenalty = Ct.Penalty_percentage
    FROM Contracts Co
    JOIN Contract_Templates Ct ON Co.Contract_code = Ct.Code
    WHERE Co.Contract_id = @contractId;

    -- Вычисляем количество прошедших месяцев
    DECLARE @monthsPassed INT;
	SET @monthsPassed = dbo.CalculateMonthsPassed(@contractDate, @currentDate);

	IF @monthsPassed < 0 OR @contractDate > @currentDate
	BEGIN
		RETURN 0;
	END
	IF @monthsPassed = 0 AND @contractDate <= @currentDate
	BEGIN
		RETURN (SELECT Size FROM Contracts WHERE Contract_id = @contractId);
	END
	IF @monthsPassed > @repaymentPeriod
	BEGIN
		DECLARE @nowDATE DATE = DATEADD(MONTH, @repaymentPeriod, @contractDate);
		SET @scaledAmount = dbo.ScaleLoanAmount(@nowDATE, @contractId);
		WHILE @scaledAmount >= dbo.CalculateTotalPayments(@contractId, @nowDATE) AND @nowDATE <= @currentDate
        BEGIN
            SET @nowDATE = DATEADD(MONTH, 1, @nowDATE);
			SET @scaledAmount = @scaledAmount * (1 + @contractPenalty / 100);
        END;

		RETURN @scaledAmount;
	END

	DECLARE @totalInterest DECIMAL(18,2);
	DECLARE @nearestDate DATE = dbo.GetNearestContractUpdateDate(@contractDate, @currentDate);
    SET @totalInterest = dbo.ScaleLoanAmount(@nearestDate, @contractId);

	IF MONTH(@nearestDate) = MONTH(@currentDate) 
			AND YEAR(@nearestDate) = YEAR(@currentDate)
	BEGIN
		RETURN @totalInterest
	END

    -- Масштабируем сумму кредита в зависимости от типа процентной ставки
    IF @typeOfPercentage = N'fixed' -- фиксированная ставка
    BEGIN
        SET @scaledAmount = @totalInterest + (SELECT Size FROM Contracts WHERE Contract_id = @contractId) * (@monthPercentage / 100);
    END
    ELSE -- дифференцированная ставка
    BEGIN
		IF @totalInterest - dbo.CalculateTotalPayments(@contractId, @currentDate) < 0
		BEGIN
			SET @scaledAmount = @totalInterest;
		END
		ELSE
		BEGIN
			SET @scaledAmount = (@totalInterest - dbo.CalculateTotalPayments(@contractId, @currentDate)) * 
					(1 + @monthPercentage / 100) + dbo.CalculateTotalPayments(@contractId, @currentDate);
		END
    END

	-- Вычисляем штраф
    SET @totalInterest = dbo.CalculateTotalPayments(@contractId, @currentDate);

	IF @totalInterest < @scaledAmount / @repaymentPeriod * @monthsPassed
	BEGIN
		SET @scaledAmount = @scaledAmount * (1 + @contractPenalty / 100);
	END

    RETURN @scaledAmount;
END;
