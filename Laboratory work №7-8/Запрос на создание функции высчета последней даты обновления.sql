-- Создание функции на поиск ближайшей даты обновления процентов по кредиту
CREATE FUNCTION GetNearestContractUpdateDate 
(
    @Contract_Date DATE,
    @Current_Date DATE
)
RETURNS DATE
AS
BEGIN
    DECLARE @NextUpdateDate DATE;
    
    IF @Current_Date > @Contract_Date
    BEGIN
        SET @NextUpdateDate = @Contract_Date;
        
        WHILE @NextUpdateDate < @Current_Date
        BEGIN
            SET @NextUpdateDate = DATEADD(MONTH, 1, @NextUpdateDate);
        END;
        
        RETURN DATEADD(MONTH, -1, @NextUpdateDate);
    END
    ELSE
    BEGIN
        RETURN @Contract_Date;
    END;
	RETURN @Contract_Date;
END;
