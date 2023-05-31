USE AdventureWorks2019;

--1. Napisz zapytanie,kt�re wykorzystuje transakcj�(zaczynaj�),a nast�pnie aktualizuje cen� produktu o ProductID r�wnym
--680 w tabeli Production.Product o 10% i nast�pnie zatwierdza transakcj�.

BEGIN TRANSACTION;

UPDATE Production.Product
SET ListPrice = ListPrice * 1.1
WHERE ProductID = 680;

COMMIT TRANSACTION;

SELECT TOP 10 ListPrice FROM Production.Product WHERE ProductID = 680 ORDER BY ListPrice DESC;

--2 Napisz zapytanie, kt�re zaczyna transakcj�, usuwa produkt o ProductID r�wnym707 z tabeli Production.Product, 
--ale nast�pnie wycofuje transakcj�.
ALTER TABLE Sales.SpecialOfferProduct
DROP CONSTRAINT FK_SpecialOfferProduct_Product_ProductID;

ALTER TABLE Sales.SpecialOfferProduct
ADD CONSTRAINT FK_SpecialOfferProduct_Product_ProductID
FOREIGN KEY (ProductID)
REFERENCES Production.Product (ProductID)
ON DELETE CASCADE;
--
ALTER TABLE Production.TransactionHistory
DROP CONSTRAINT FK_TransactionHistory_Product_ProductID;

ALTER TABLE Production.TransactionHistory
ADD CONSTRAINT FK_TransactionHistory_Product_ProductID
FOREIGN KEY (ProductID)
REFERENCES Production.Product (ProductID)
ON DELETE CASCADE;
--
ALTER TABLE Production.ProductCostHistory
DROP CONSTRAINT FK_ProductCostHistory_Product_ProductID;

ALTER TABLE Production.ProductCostHistory
ADD CONSTRAINT FK_ProductCostHistory_Product_ProductID
FOREIGN KEY (ProductID)
REFERENCES Production.Product (ProductID)
ON DELETE CASCADE;
--
ALTER TABLE Production.ProductInventory
DROP CONSTRAINT FK_ProductInventory_Product_ProductID;

ALTER TABLE Production.ProductInventory
ADD CONSTRAINT FK_ProductInventory_Product_ProductID
FOREIGN KEY (ProductID)
REFERENCES Production.Product (ProductID)
ON DELETE CASCADE;
--
ALTER TABLE Production.ProductListPriceHistory
DROP CONSTRAINT FK_ProductListPriceHistory_Product_ProductID;

ALTER TABLE Production.ProductListPriceHistory
ADD CONSTRAINT FK_ProductListPriceHistory_Product_ProductID
FOREIGN KEY (ProductID)
REFERENCES Production.Product (ProductID)
ON DELETE CASCADE;
--
ALTER TABLE Production.ProductProductPhoto
DROP CONSTRAINT FK_ProductProductPhoto_Product_ProductID;

ALTER TABLE Production.ProductProductPhoto
ADD CONSTRAINT FK_ProductProductPhoto_Product_ProductID
FOREIGN KEY (ProductID)
REFERENCES Production.Product (ProductID)
ON DELETE CASCADE;
--
ALTER TABLE Purchasing.ProductVendor
DROP CONSTRAINT FK_ProductVendor_Product_ProductID;

ALTER TABLE Purchasing.ProductVendor
ADD CONSTRAINT FK_ProductVendor_Product_ProductID
FOREIGN KEY (ProductID)
REFERENCES Production.Product (ProductID)
ON DELETE CASCADE;
--
ALTER TABLE Purchasing.PurchaseOrderDetail
DROP CONSTRAINT FK_PurchaseOrderDetail_Product_ProductID;

ALTER TABLE Purchasing.PurchaseOrderDetail
ADD CONSTRAINT FK_PurchaseOrderDetail_Product_ProductID
FOREIGN KEY (ProductID)
REFERENCES Production.Product (ProductID)
ON DELETE CASCADE;


BEGIN TRANSACTION;

DELETE FROM Production.Product
WHERE ProductID = 707;

ROLLBACK TRANSACTION;

SELECT * FROM Production.Product WHERE ProductID = 707 

--3 Napisz zapytanie, kt�re zaczyna transakcj�, dodaje nowy produkt do tabeli Production.Product,
--a nast�pnie zatwierdza transakcj�.

SELECT * FROM Production.Product;

BEGIN TRANSACTION;

INSERT INTO Production.Product (Name,ProductNumber, SafetyStockLevel,ReorderPoint,StandardCost,DaysToManufacture,SellStartDate, Color, Size, ListPrice)
VALUES ('Produkt',20,1,2,3,4,'2008-04-30 00:00:00.000', 'Black', 'M', 22.03);

COMMIT TRANSACTION;

--4 Napisz zapytanie, kt�re zaczyna transakcj� i aktualizuje StandardCost wszystkich produkt�w w tabeli Production.Product o 10%,
--je�eli suma wszystkich StandardCost poaktualizacji nie przekracza 50000. W przeciwnym razie zapytanie powinno wycofa� transakcj�

BEGIN TRANSACTION;

DECLARE @TotalCost MONEY;

UPDATE Production.Product
SET StandardCost = StandardCost * 1.1;

SET @TotalCost = (SELECT SUM(StandardCost) FROM Production.Product);

IF @TotalCost <= 50000
BEGIN
    COMMIT TRANSACTION;
END
ELSE
BEGIN
    ROLLBACK TRANSACTION;
END

--5 Napisz zapytanie SQL, kt�re zaczyna transakcj� i pr�buje doda� nowy produkt do tabeli Production.Product. 
--Je�li ProductNumber ju� istnieje w tabeli, zapytanie powinno wycofa� transakcj�.

BEGIN TRANSACTION;

DECLARE @ProductNumber NVARCHAR(25) = '20';

INSERT INTO Production.Product (Name,ProductNumber, SafetyStockLevel,ReorderPoint,StandardCost,DaysToManufacture,SellStartDate, Color, Size, ListPrice)
VALUES ('Produkt23',@ProductNumber,1,2,3,4,'2008-04-30 00:00:00.000', 'Black', 'M', 22.03);

IF EXISTS (SELECT 1 FROM Production.Product WHERE ProductNumber = @ProductNumber)
BEGIN
    ROLLBACK TRANSACTION;
    PRINT 'Produkt z numerem ' + @ProductNumber + ' istnieje :((((';
END
ELSE
BEGIN
  
    COMMIT TRANSACTION;
    PRINT 'Doda�e� produkt z numerem'+ @ProductNumber;
END

SELECT * FROM Production.Product WHERE Name LIKE 'Pro%';

--6 Napisz zapytanie SQL, kt�re zaczyna transakcj� i aktualizuje warto�� OrderQty dla ka�dego zam�wienia w tabeli Sales.SalesOrderDetail. 
--Je�eli kt�ry kolwiek z zam�wie� ma OrderQty r�wn� 0,zapytanie powinno wycofa� transakcj�.

BEGIN TRANSACTION;
 
 UPDATE Sales.SalesOrderDetail
    SET OrderQty = OrderQty + 1;

IF EXISTS (SELECT 1 FROM Sales.SalesOrderDetail WHERE OrderQty = 0)
BEGIN
    ROLLBACK TRANSACTION;
    PRINT 'Istnieje zamowienie z OrderQty rownym 0.';
END
ELSE
BEGIN
   
    COMMIT TRANSACTION;
    PRINT 'Zaktualizowano.';
END

SELECT * FROM Sales.SalesOrderDetail;
--7 Napisz zapytanie SQL, kt�re zaczyna transakcj� i usuwa wszystkie produkty, kt�rych StandardCost jest wy�szy ni� 
-- �redni koszt wszystkich produkt�w w tabeli Production.Product. Je�eli liczba produkt�w do usuni�cia przekracza 10,
--zapytanie powinno wycofa� transakcj�
--
ALTER TABLE Production.WorkOrder
DROP CONSTRAINT FK_WorkOrder_Product_ProductID;

ALTER TABLE Production.WorkOrder
ADD CONSTRAINT FK_WorkOrder_Product_ProductID
FOREIGN KEY (ProductID)
REFERENCES Production.Product (ProductID)
ON DELETE CASCADE;
--
ALTER TABLE Production.WorkOrderRouting
DROP CONSTRAINT FK_WorkOrderRouting_WorkOrder_WorkOrderID;

ALTER TABLE Production.WorkOrderRouting
ADD CONSTRAINT FK_WorkOrderRouting_WorkOrder_WorkOrderID
FOREIGN KEY (ProductID)
REFERENCES Production.Product (ProductID)
ON DELETE CASCADE;
--


BEGIN TRANSACTION;

DECLARE @AverageCost money;
SET @AverageCost = (SELECT AVG(StandardCost) FROM Production.Product);

DELETE FROM Production.Product
WHERE StandardCost > @AverageCost;

IF @@ROWCOUNT > 10 --zmienna przechowujaca liczbe usunientych wierszy
BEGIN
    ROLLBACK TRANSACTION;
    PRINT 'Liczba prodoktow do usuniencia przekroczyla 10.';
END
ELSE
BEGIN
    COMMIT TRANSACTION;
    PRINT 'Usuniento produkty.';
END

