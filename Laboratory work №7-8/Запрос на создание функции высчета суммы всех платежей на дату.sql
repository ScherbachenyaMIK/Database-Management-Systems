-- �������� ������� ��� ������� ����� ���� �������� �� ������� �� ����
CREATE FUNCTION CalculateTotalPayments
(
    @contractId BIGINT,
    @date DATE
)
RETURNS DECIMAL(18, 2)
AS
BEGIN
    DECLARE @totalAmount DECIMAL(18, 2);

    -- ������� ����� ���� ������ �� ��������� �� �������� ����
    SELECT @totalAmount = SUM(Amount)
    FROM Loan_repayments
    WHERE Contract_id = @contractId
    AND Contract_date <= @date;

    -- ���� ��� ������ �� ���������, ���������� 0
    IF @totalAmount IS NULL
    BEGIN
        SET @totalAmount = 0;
    END

    RETURN @totalAmount;
END;
