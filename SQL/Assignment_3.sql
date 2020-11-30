-- E1-Q1
SELECT 
    `Name`
FROM
    product
WHERE
    ProductSubcategoryID IN (SELECT 
            ProductSubcategoryID
        FROM
            productsubcategory
        WHERE
            `Name` = 'Saddles');

-- E1-Q2
SELECT 
    `Name`
FROM
    product
WHERE
    ProductSubcategoryID IN (SELECT 
            ProductSubcategoryID
        FROM
            productsubcategory
        WHERE
            `Name` LIKE 'Bo%');

-- E1-Q3
SELECT 
    `Name`
FROM
    product
WHERE
    ListPrice = (SELECT 
            MIN(ListPrice)
        FROM
            product
        WHERE
            ProductSubcategoryID IN (SELECT 
                    ProductSubcategoryID
                FROM
                    productsubcategory
                WHERE
                    `Name` = 'Touring Bikes'));
                    
-- E2-Q1
SELECT 
    C.`Name` AS COUNTRY, S.`Name` AS PROVINCE
FROM
    countryregion C
        JOIN
    stateprovince S ON C.CountryRegionCode = S.CountryRegionCode;
    
-- E2-Q2
SELECT 
    C.`Name` AS COUNTRY, S.`Name` AS PROVINCE
FROM
    countryregion C
        JOIN
    stateprovince S ON C.CountryRegionCode = S.CountryRegionCode
WHERE
    C.`Name` IN ('Germany' , 'Canada');
    
-- E2-Q3
SELECT 
    SOD.SalesOrderID,
    SOD.OrderDate,
    SOD.SalesPersonID,
    SP.Bonus,
    SP.SalesYTD
FROM
    salesorderheader SOD
        JOIN
    salesperson SP ON SOD.SalesPersonID = SP.SalesPersonID;

-- E2-Q4
WITH ORDER_SALE AS (
SELECT 
    SOD.SalesOrderID,
    SOD.OrderDate,
	SOD.SalesPersonID,
    SP.Bonus,
    SP.SalesYTD
FROM
    salesorderheader SOD
        JOIN
    salesperson SP ON SOD.SalesPersonID = SP.SalesPersonID)
SELECT
	O.SalesOrderID,
    O.OrderDate,
    E.Title,
	O.Bonus,
    O.SalesYTD
FROM
	ORDER_SALE O
		JOIN
	employee E ON O.SalesPersonID = E.EmployeeID;