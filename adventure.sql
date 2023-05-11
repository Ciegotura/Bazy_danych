USE AdventureWorks2019;

--a)Wykorzystuj¹c wyra¿enie CTE zbuduj zapytanie, które znajdzie informacje na temat stawki 
--pracownika oraz jego danych, a nastêpnie zapisze je do tabeli tymczasowej 
--TempEmployeeInfo. Rozwi¹¿ w oparciu o AdventureWorks.

--select
SELECT p.FirstName, p.LastName, e.Rate, j.JobTitle
FROM Person.Person p
JOIN HumanResources.EmployeePayHistory e ON e.BusinessEntityID = p.BusinessEntityID
JOIN HumanResources.Employee j ON j.BusinessEntityID = p.BusinessEntityID;

--CTE
WITH EmployeeInfo AS (
SELECT p.FirstName, p.LastName, e.Rate, j.JobTitle
FROM Person.Person p
JOIN HumanResources.EmployeePayHistory e ON e.BusinessEntityID = p.BusinessEntityID
JOIN HumanResources.Employee j ON j.BusinessEntityID = p.BusinessEntityID
)
SELECT *
INTO TempEmployeeInfo
FROM EmployeeInfo;

SELECT * FROM TempEmployeeInfo;

--b) Uzyskaj informacje na tematprzychodówze sprzeda¿y wed³ug firmy i kontaktu (za pomoc¹ 
--CTEi bazy AdventureWorksL). Wynik powinien wygl¹daæ nastêpuj¹co:
USE AdventureWorksLT2019;


--fff
WITH SalesData AS (
    SELECT
        CONCAT(c.CompanyName,' (', pp.FirstName, ' ', pp.LastName,')') AS CompanyContact,
        SUM(d.OrderQty * d.UnitPrice) AS Revenue
    FROM SalesLT.SalesOrderHeader AS h
    JOIN SalesLT.Customer AS c ON h.CustomerID = c.CustomerID
    JOIN SalesLT.SalesOrderDetail AS d ON h.SalesOrderID = d.SalesOrderID
	JOIN AdventureWorks2019.Person.EmailAddress AS p ON SUBSTRING(c.SalesPerson, CHARINDEX('\', c.SalesPerson) + 1, LEN(c.SalesPerson)) = 
	LEFT(p.EmailAddress, CHARINDEX('@', p.EmailAddress) - 1)
    JOIN AdventureWorks2019.Person.Person AS pp ON p.BusinessEntityID = pp.BusinessEntityID --to trzeba tu poprawic wim jak

    GROUP BY CONCAT(c.CompanyName,' (', pp.FirstName, ' ', pp.LastName,')') --c.CompanyName --, CONCAT(pp.FirstName, ' ', pp.LastName)
)
SELECT 
    CompanyContact, 
    Revenue 
FROM SalesData 
ORDER BY Revenue DESC;

--SELECT * FROM SalesLT.Customer
--SELECT * FROM AdventureWorks2019.Person.Person
--SELECT * FROM AdventureWorks2019.Person.EmailAddress

--SELECT * FROM AdventureWorks2019.Person.EmailAddress p WHERE p.EmailAddress LIKE 'jae0%';  --dobra po tym zmaczuje

--SELECT * FROM SalesLT.Customer s WHERE s.SalesPerson LIKE '%jae0';

--SELECT * FROM AdventureWorks2019.Person.EmailAddress p WHERE LEFT(p.EmailAddress, CHARINDEX('@', p.EmailAddress) - 1) = 'pamela0';
--SELECT * FROM SalesLT.Customer c WHERE SUBSTRING(c.SalesPerson, CHARINDEX('\', c.SalesPerson) + 1, LEN(c.SalesPerson)) = 'pamela0'; -- to jest git

--c)Napisz zapytanie, które zwróci wartoœæ sprzeda¿y dla poszczególnych kategorii produktów.
--Wykorzystaj CTE i bazê AdventureWorksLT



USE AdventureWorksLT2019;

SELECT * FROM SalesLT.ProductCategory; --NAME, ProductCategoryID
SELECT * FROM SalesLT.Product; --productCategoryID, 

WITH CategorySalesInfo AS (
SELECT pc.Name AS Category, SUM(p.ListPrice) AS SalesValue
FROM SalesLT.ProductCategory pc 
JOIN SalesLT.Product p ON p.ProductCategoryID = pc.ProductCategoryID
GROUP BY pc.Name
)
SELECT *
INTO TempCategorySalesInfo
FROM CategorySalesInfo;

SELECT * FROM TempCategorySalesInfo;