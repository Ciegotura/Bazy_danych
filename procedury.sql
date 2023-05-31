USE AdventureWorks2019;
--1 Napisz procedur� wypisuj�c� do konsoli ci�g Fibonacciego. 
--Procedura musi przyjmowa� jako argument wej�ciowy liczb� n. 
--Generowanie ci�gu Fibonacciego musi zosta� zaimplementowane jako osobna funkcja,wywo�ywana przez procedur�.
CREATE FUNCTION fib(@n INT)
RETURNS @Values TABLE (id INT,Number INT)
AS
BEGIN
    DECLARE @intCounter as INT = 1;
	DECLARE @Fib1 as INT = 0;
	DECLARE @Fib2 as INT = 1;
	DECLARE @sum as INT;
	INSERT INTO @Values (id,Number) VALUES (@intCounter,1);
WHILE @intCounter <= @n-1
BEGIN
SET @sum = @Fib1 + @Fib2;
INSERT INTO @Values (id,Number) VALUES (@intCounter+1,@sum);
SET @IntCounter = @IntCounter + 1;

SET @Fib1 = @Fib2
SET @Fib2 = @sum
END;
RETURN;
END;

DROP FUNCTION dbo.fib

SELECT * FROM dbo.fib(10);


CREATE PROCEDURE dbo.fibo
@n INT
AS
BEGIN

DECLARE @Attribute INT
DECLARE @COUNTER as INT = 0

WHILE @Counter <= @n
BEGIN
    SELECT @Attribute = Number
    FROM dbo.fib(10)
    WHERE id = @Counter

    PRINT @Attribute

    SET @Counter = @Counter + 1
END
END;

DROP PROCEDURE dbo.fibo

EXEC dbo.fibo @n = 10;

--2 Napisz trigger DML, kt�ry po wprowadzeniu danych do tabeli 
--Personszmodyfikuje nazwisko tak, aby by�o napisane du�ymi literami.
SELECT * FROM Person.Person;

SELECT DISTINCT LastName FROM Person.Person;
SELECT TOP 10 BusinessEntityID FROM Person.Person;
INSERT INTO Person.Person (BusinessEntityID,PersonType, FirstName,LastName) VALUES (1,'EM','Piotr','Aaa');

CREATE TRIGGER per 
ON Person.Person
AFTER UPDATE
AS
	UPDATE Person.Person
	SET LastName = UPPER(LastName)
	WHERE LastName IN (SELECT LastName From inserted);

DROP TRIGGER dbo.per

INSERT INTO Person.BusinessEntity(rowguid) VALUES(NEWID());

INSERT INTO Person.Person (BusinessEntityID,PersonType,NameStyle, FirstName,LastName,EmailPromotion) VALUES (20778,'EM',0,'Piotr','Aaa',1);
SELECT LastName FROM Person.Person;
--Przygotuj trigger �taxRateMonitoring�, kt�ry wy�wietli komunikat o b��dzie, 
--je�eli nast�pi zmiana warto�ci w polu �TaxRate�o wi�cej ni� 30%.

CREATE TRIGGER TaxRateMonitoring 
ON Sales.SalesTaxRate
AFTER UPDATE
AS
DECLARE @TaxRateOld as SMALLMONEY
DECLARE @NewTaxRate as SMALLMONEY
SELECT @TaxRateOld = TaxRate FROM deleted
SELECT @NewTaxRate = TaxRate FROM inserted
IF @NewTaxRate > @TaxRateOld*1.3
THROW 50000, 'Jest wiecej niz 30%',1;


UPDATE Sales.SalesTaxRate SET TaxRate = TaxRate*2;

