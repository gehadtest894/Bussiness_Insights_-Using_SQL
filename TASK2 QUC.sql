--1. GROUP BY 
USE AdventureWorksLT2022
--Q1. Display the number of products for each color.
SELECT Color ,COUNT(*) AS PRODUCTNUM 
FROM SaLeslT.Product
GROUP BY  Color;

--Q2. Display the average list price of products for each color.  
SELECT Color ,AVG(listprice) AS AVGPRICE
FROM SaLeslT.Product
GROUP BY Color;
--Q3. Display the minimum and maximum list price for each ProductCategoryID. 
SELECT ProductCategoryID,MIN(listprice) AS minimum, MAX(listprice)AS maximum
FROM SaLeslT.Product
GROUP BY ProductCategoryID;
--Q4. Display the number of products in each ProductCategoryID.
SELECT ProductCategoryID, COUNT(*)AS PROBUCTNUM
FROM SaLeslT.Product
GROUP BY ProductCategoryID;
--Q5. Display the number of sales orders for each CustomerID. 
SELECT CustomerID, COUNT(SalesOrderNumber) AS SALESNUM
FROM [SalesLT].[SalesOrderHeader]
GROUP BY CustomerID;
--Q6. Display the total value of orders for each CustomerID. 
SELECT CustomerID, SUM( totalDue) AS TOTALDUE
FROM [SalesLT].[SalesOrderHeader]
GROUP BY CustomerID;

----------2. HAVING -----------
--Q7. Display the colors that have more than 10 products.

SELECT Color, COUNT(*) AS PRODUCTNUM
FROM SaLeslT.Product
GROUP BY Color
HAVING COUNT(*) > 10;
--Q8. Display the ProductCategoryID values that have more than 5 products.  
SELECT ProductCategoryID, COUNT(*) AS ProductCategoryNUM 
FROM SaLeslT.Product
GROUP BY ProductCategoryID
HAVING COUNT(*)>5;

--Q9. Display the colors whose average product list price is greater than 500. 
SELECT Color, AVG(listprice) AS AVGLIST   
FROM SaLeslT.Product
GROUP BY  Color
HAVING  AVG(listprice)>500;
--Q10. Display the customers who have placed more than one sales order. 
SELECT CustomerID, COUNT ( SalesOrderID)AS SALES
FROM [SalesLT].[SalesOrderHeader]
GROUP BY CustomerID
HAVING COUNT ( SalesOrderID) >1;
--Q11. Display the customers whose total order value is greater than 10,000. 
SELECT CustomerID, SUM(totalDue)AS TOTALDUE
FROM [SalesLT].[SalesOrderHeader]
GROUP BY CustomerID
HAVING SUM(totalDue)> 10000;
--Q12. Use WHERE to include only products with ListPrice greater than 100, then display only colors that have more 
--than 5 of those products. 
SELECT Color, COUNT(*) AS PROCOUNT 
FROM SaLeslT.Product
WHERE ListPrice>100
GROUP BY Color
HAVING COUNT(*)>5;

----------3. INNER JOIN -----------
--Q13. Display each customer's first name, last name, SalesOrderID, and OrderDate.

SELECT C. FirstName,C. LastName , S.SalesOrderID,S.OrderDate
FROM SalesLT.Customer C
INNER JOIN SalesLT.SalesOrderHeader S
ON C. CustomerID = S.CustomerID;

--Q14. Display each product name with the ordered quantity and unit price from SalesOrderDetail.

SELECT P.Name,S.OrderQty,S.UnitPrice
FROM SalesLT.Product P
INNER JOIN  SalesLT.SalesOrderDetail S
ON P.ProductID=S.ProductID;
--Q15. Display each product name with its product category name.
SELECT P.Name, C.Name
FROM SalesLT.Product P
INNER JOIN SalesLT.ProductCategory C
ON P.ProductCategoryID= C.ProductCategoryID

--Q16. Display each sales order with the city and country of its shipping address. 
SELECT S.SalesOrderID,A.City,A.CountryRegion
FROM SalesLT.SalesOrderHeader AS S
INNER JOIN SalesLT.Address A
ON S.BillToAddressID=A.AddressID

--Q17. Display SalesOrderID, product name, ordered quantity, and unit price by joining SalesOrderDetail with 
--Product. 
SELECT P.Name,D.SalesOrderID, D.OrderQty,D.UnitPrice
FROM SalesLT.SalesOrderDetail AS D
INNER JOIN SalesLT.Product AS P
ON D.ProductID=P.ProductID

---------4. LEFT JOIN ------------
--Q18. Display all customers and their SalesOrderID values, including customers who have never placed an order. 
SELECT H.SalesOrderID,C.FirstName,C.LastName
FROM SalesLT.Customer AS C
LEFT JOIN SalesLT.SalesOrderHeader AS H
ON C.CustomerID=H.CustomerID;

--Q19. Display all product categories and the products that belong to them, including categories with no products.
SELECT P.Name,C.Name,P.ProductID,C.ProductCategoryID
FROM SalesLT.ProductCategory AS C
LEFT JOIN SalesLT.Product AS P
ON C.ProductCategoryID=P.ProductCategoryID;


--Q20. Display all products and any matching SalesOrderDetail rows, including products that have never been 
--ordered.
SELECT P.Name,P.ProductID, D.SalesOrderID,D.OrderQty,D.UnitPrice
FROM SalesLT.Product AS P
LEFT JOIN SalesLT.SalesOrderDetail AS D
ON P.ProductID =P.ProductID;

--Q21. Display all addresses and any matching CustomerAddress rows, including addresses that are not assigned to 
--a customer. 
SELECT A.AddressID,A.AddressLine1,A.City,C.CustomerID,C.AddressType
FROM SalesLT.Address AS A
LEFT JOIN SalesLT.CustomerAddress AS C
ON A.AddressID=C.AddressID;

--Q22. Using LEFT JOIN, display only customers who have never placed a sales order. 
SELECT C.CustomerID,C.FirstName,C.LastName
FROM SalesLT.Customer AS C
LEFT JOIN SalesLT.SalesOrderHeader AS H 
ON C.CustomerID=H.CustomerID
WHERE H.SalesOrderID IS NOT NULL;

-----5. RIGHT JOIN --------
--Q23. Using RIGHT JOIN, display all customers and any matching SalesOrderID values. 
SELECT C.CustomerID,C.FirstName,C.LastName,S.SalesOrderID
FROM SalesLT.SalesOrderHeader AS S
RIGHT JOIN SalesLT.Customer AS C
ON S.CustomerID=C.CustomerID;
 

--Q24. Using RIGHT JOIN, display all product categories and any matching products.   

SELECT 
    C.ProductCategoryID,
    C.Name  ,
    P.ProductID,
    P.Name 
FROM SalesLT.Product AS P
RIGHT JOIN SalesLT.ProductCategory AS C
    ON P.ProductCategoryID = C.ProductCategoryID;
--Q25. Using RIGHT JOIN, display all products and any matching SalesOrderDetail rows. 

SELECT 
    P.ProductID,
    P.Name AS ProductName,
    D.SalesOrderID,
    D.OrderQty,
    D.UnitPrice
FROM SalesLT.SalesOrderDetail AS D
RIGHT JOIN SalesLT.Product AS P
    ON D.ProductID = P.ProductID;
--Q26. Using RIGHT JOIN, display all addresses and any matching CustomerAddress rows. 
SELECT 
    A.AddressID,
    A.AddressLine1,
    A.City,
    C.CustomerID,
    C.AddressType
FROM SalesLT.CustomerAddress AS C
RIGHT JOIN SalesLT.Address AS A
    ON C.AddressID = A.AddressID;

  -----  6. FULL OUTER JOIN -----
--Q27. Use FULL OUTER JOIN to display customers and sales orders, keeping unmatched rows from both tables.
SELECT C.CustomerID,C.FirstName,C.LastName,O.SalesOrderID,O.OrderDate,O.TotalDue
FROM SalesLT.Customer AS C
FULL OUTER JOIN SalesLT.SalesOrderHeader AS O
    ON C.CustomerID = O.CustomerID;
--Q28. Use FULL OUTER JOIN to display product categories and products, keeping unmatched rows from both 
--tables.  
SELECT C.ProductCategoryID,C.Name AS CategoryName,P.ProductID,P.Name AS ProductName
FROM SalesLT.ProductCategory AS C
FULL OUTER JOIN SalesLT.Product AS P
    ON C.ProductCategoryID = P.ProductCategoryID;

--Q29. Use FULL OUTER JOIN to display products and SalesOrderDetail rows, keeping unmatched rows from both 
--tables. 
SELECT  P.ProductID,P.Name AS ProductName, D.SalesOrderID, D.OrderQty, D.UnitPrice
FROM SalesLT.Product AS P
FULL OUTER JOIN SalesLT.SalesOrderDetail AS D
    ON P.ProductID = D.ProductID;
--Q30. Using a FULL OUTER JOIN between Customer and SalesOrderHeader, display only rows that do not have a 
--match on one side
SELECT C.CustomerID,C.FirstName, C.LastName, O.SalesOrderID, O.TotalDue
FROM SalesLT.Customer AS C
FULL OUTER JOIN SalesLT.SalesOrderHeader AS O
    ON C.CustomerID = O.CustomerID
WHERE C.CustomerID IS NULL 
   OR O.CustomerID IS NULL;

   -------7. SUBQUERY IN WHERE -------
--Q31. Display products whose ListPrice is greater than the average ListPrice of all products. 
SELECT  ListPrice, Name,ProductID
FROM SalesLT.Product
WHERE ListPrice> (SELECT AVG(ListPrice)FROM SalesLT.Product);
--Q32. Display the product or products that have the highest ListPrice. 
SELECT ProductID,Name,ListPrice
FROM SalesLT.Product
WHERE ListPrice = (
    SELECT MAX(ListPrice) 
    FROM SalesLT.Product);

--Q33. Using a subquery with IN, display customers who have placed at least one sales order. 
SELECT CustomerID,FirstName,LastName
FROM SalesLT.Customer
WHERE CustomerID IN (
    SELECT CustomerID 
    FROM SalesLT.SalesOrderHeader);


--Q34. Using a subquery with NOT EXISTS, display customers who have never placed a sales order. 
SELECT C.CustomerID,C.FirstName,C.LastName
FROM SalesLT.Customer AS C
WHERE NOT EXISTS (
    SELECT 1 
    FROM SalesLT.SalesOrderHeader AS O
    WHERE O.CustomerID = C.CustomerID);

--Q35. Display products that belong to a product category whose name contains the word 'Bikes'. Use a subquery in 
--WHERE. 
SELECT ProductID,Name, ProductCategoryID
FROM SalesLT.Product
WHERE ProductCategoryID IN (
    SELECT ProductCategoryID 
    FROM SalesLT.ProductCategory
    WHERE Name LIKE '%Bikes%');


--Q36. Display sales orders whose TotalDue is greater than the average TotalDue of all sales orders.
SELECT SalesOrderID,OrderDate,TotalDue
FROM SalesLT.SalesOrderHeader
WHERE TotalDue > (
    SELECT AVG(TotalDue) 
    FROM SalesLT.SalesOrderHeader);

   ------- 8. SUBQUERY IN FROM ------------
--Q37. Create a subquery in FROM that calculates total order value for each CustomerID, then display its result.
SELECT 
    CustOrders.CustomerID,
    CustOrders.TotalOrderValue
FROM (
    SELECT 
        CustomerID,
        SUM(TotalDue) AS TotalOrderValue
    FROM SalesLT.SalesOrderHeader
    GROUP BY CustomerID
) AS CustOrders;

--Q38. Using a subquery in FROM, display customers whose total order value is greater than 10,000. 
SELECT 
    CustOrders.CustomerID,
    CustOrders.TotalOrderValue
FROM (
    SELECT 
        CustomerID,
        SUM(TotalDue) AS TotalOrderValue
    FROM SalesLT.SalesOrderHeader
    GROUP BY CustomerID
) AS CustOrders
WHERE CustOrders.TotalOrderValue > 10000;
--Q39. Create a subquery in FROM that calculates the average ListPrice for each ProductCategoryID, then display 
--categories whose average price is greater than 500. 
SELECT 
    CatAvg.ProductCategoryID,
    CatAvg.AvgListPrice
FROM (
    SELECT 
        ProductCategoryID,
        AVG(ListPrice) AS AvgListPrice
    FROM SalesLT.Product
    GROUP BY ProductCategoryID
) AS CatAvg
WHERE CatAvg.AvgListPrice > 500;
--Q40. Create a subquery in FROM that counts products for each color, then display the result ordered from the 
--largest count to the smallest. 
SELECT 
    ColorCounts.Color,
    ColorCounts.ProductCount
FROM (
    SELECT 
        ISNULL(Color, 'No Color') AS Color,
        COUNT(*) AS ProductCount
    FROM SalesLT.Product
    GROUP BY Color
) AS ColorCounts
ORDER BY ColorCounts.ProductCount DESC;

----------9. FINAL MIXED PRACTICE -----------
--Q41. Display each product category name and the number of products in that category. 
SELECT 
    C.Name AS CategoryName,
    COUNT(P.ProductID) AS ProductCount
FROM SalesLT.ProductCategory AS C
LEFT JOIN SalesLT.Product AS P
    ON C.ProductCategoryID = P.ProductCategoryID
GROUP BY C.Name;

--Q42. Display product category names that contain more than 10 products. 
SELECT 
    C.Name AS CategoryName,
    COUNT(P.ProductID) AS ProductCount
FROM SalesLT.ProductCategory AS C
INNER JOIN SalesLT.Product AS P
    ON C.ProductCategoryID = P.ProductCategoryID
GROUP BY C.Name
HAVING COUNT(P.ProductID) > 10;
--Q43. Display each customer's name and the number of sales orders they have placed, including customers with 
--zero orders. 
SELECT C.CustomerID,C.FirstName,C.LastName,
    COUNT(O.SalesOrderID) AS OrderCount
FROM SalesLT.Customer AS C
LEFT JOIN SalesLT.SalesOrderHeader AS O
    ON C.CustomerID = O.CustomerID
GROUP BY C.CustomerID, C.FirstName, C.LastName;
--Q44. Display customers who have placed more than one sales order, showing their name and order count. 
SELECT C.CustomerID, C.FirstName, C.LastName,
    COUNT(O.SalesOrderID) AS OrderCount
FROM SalesLT.Customer AS C
INNER JOIN SalesLT.SalesOrderHeader AS O
    ON C.CustomerID = O.CustomerID
GROUP BY C.CustomerID, C.FirstName, C.LastName
HAVING COUNT(O.SalesOrderID) > 1;

--Q45. Display each customer and their total sales amount, but only for customers whose total sales amount is 
--greater than 10,000. 
SELECT  C.CustomerID, C.FirstName, C.LastName,
    SUM(O.TotalDue) AS TotalSales
FROM SalesLT.Customer AS C
INNER JOIN SalesLT.SalesOrderHeader AS O
    ON C.CustomerID = O.CustomerID
GROUP BY C.CustomerID, C.FirstName, C.LastName
HAVING SUM(O.TotalDue) > 10000;