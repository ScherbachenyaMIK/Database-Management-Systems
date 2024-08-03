-- �������� ������� ��� ���������� ���������� �������, ��������� � ���������� ��������
CREATE FUNCTION CalculateMonthsPassed
(
    @contractDate DATE,
    @currentDate DATE
)
RETURNS INT
AS
BEGIN
    DECLARE @monthsPassed INT;

    SET @monthsPassed = DATEDIFF(MONTH, @contractDate, @currentDate);

    RETURN @monthsPassed;
END;
