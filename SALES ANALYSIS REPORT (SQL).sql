
-- A detailed analysis performed on top of sales data of XYZ company.
-- This includes Customer, Product, Employee, Location, Date, Year, and Month base analysis

-----------------------------------------------------------------------------------------------
-- ------------------------------CUSTOMER ANALYSIS---------------------------------------------
-----------------------------------------------------------------------------------------------
-- TOP 10 CUSTOMERS BY SALES

SELECT TOP 10 
  C.CUSTOMERNUMBER, C.CUSTOMERNAME, SUM(OD.PRICE) AS TOTAL_SALES
FROM CUSTOMERS C
JOIN ORDERS O 
ON C.CUSTOMERNUMBER = O.CUSTOMERNUMBER
JOIN ORDER_DETAILS OD 
ON O.ORDERNUMBER = OD.ORDERNUMBER
GROUP BY C.CUSTOMERNUMBER, C.CUSTOMERNAME
ORDER BY TOTAL_SALES DESC
;

-----------------------------------------------------------------------------------------------
-- CUSTOMER PURCHASE FREQUENCY

SELECT
  C.CUSTOMERNUMBER, C.CUSTOMERNAME, COUNT(O.ORDERNUMBER) AS TOTAL_ORDERS
FROM CUSTOMERS C
JOIN ORDERS O 
ON C.CUSTOMERNUMBER = O.CUSTOMERNUMBER
GROUP BY C.CUSTOMERNUMBER, C.CUSTOMERNAME
ORDER BY TOTAL_ORDERS DESC
;

-----------------------------------------------------------------------------------------------
-- ------------------------------PRODUCT ANALYSIS----------------------------------------------
-----------------------------------------------------------------------------------------------
-- TOP 10 BEST SELLING PRODUCTS

SELECT TOP 10
  P.PRODUCTCODE, P.PRODUCTNAME, SUM(OD.QUANTITYORDERED) AS TOTAL_QUANTITY_SOLD
FROM PRODUCTS P
JOIN ORDER_DETAILS OD 
ON P.PRODUCTCODE = OD.PRODUCTCODE
GROUP BY P.PRODUCTCODE, P.PRODUCTNAME
ORDER BY TOTAL_QUANTITY_SOLD DESC
;

-----------------------------------------------------------------------------------------------
-- BOTTOM 10 SELLING PRODUCTS

SELECT TOP 10
  P.PRODUCTCODE, P.PRODUCTNAME, SUM(OD.QUANTITYORDERED) AS TOTAL_QUANTITY_SOLD
FROM PRODUCTS P
JOIN ORDER_DETAILS OD 
ON P.PRODUCTCODE = OD.PRODUCTCODE
GROUP BY P.PRODUCTCODE, P.PRODUCTNAME
ORDER BY TOTAL_QUANTITY_SOLD ASC
;

-----------------------------------------------------------------------------------------------
-- PRODUCT SALES REVENUE

SELECT 
  P.PRODUCTCODE, P.PRODUCTNAME, SUM(OD.QUANTITYORDERED * OD.PRICEEACH) AS TOTAL_REVENUE
FROM PRODUCTS P
JOIN ORDER_DETAILS OD 
ON P.PRODUCTCODE = OD.PRODUCTCODE
GROUP BY P.PRODUCTCODE, P.PRODUCTNAME
ORDER BY TOTAL_REVENUE ASC
;

-----------------------------------------------------------------------------------------------
-- ------------------------------SALES TRENDS--------------------------------------------------
-----------------------------------------------------------------------------------------------
-- MONTHLY SALES TREND

SELECT 
  MONTH(D.THEDATE) AS MONTH, SUM(OD.PRICE) AS TOTAL_SALES
FROM DATES D
JOIN ORDERS O 
ON D.THEDATE = O.ORDERDATE
JOIN ORDER_DETAILS OD 
ON O.ORDERNUMBER = OD.ORDERNUMBER
GROUP BY MONTH(D.THEDATE)
ORDER BY MONTH
;

SELECT 
  YEAR(D.THEDATE) AS YEAR,MONTH(D.THEDATE) AS MONTH, SUM(OD.PRICE) AS TOTAL_SALES
FROM DATES D
JOIN ORDERS O 
ON D.THEDATE = O.ORDERDATE
JOIN ORDER_DETAILS OD 
ON O.ORDERNUMBER = OD.ORDERNUMBER
GROUP BY YEAR(D.THEDATE),MONTH(D.THEDATE)
ORDER BY YEAR,MONTH
;

-----------------------------------------------------------------------------------------------
-- YEARLY SALES TREND

SELECT 
  YEAR(D.THEDATE) AS YEAR, SUM(OD.PRICE) AS TOTAL_SALES
FROM DATES D
JOIN ORDERS O 
ON D.THEDATE = O.ORDERDATE
JOIN ORDER_DETAILS OD 
ON O.ORDERNUMBER = OD.ORDERNUMBER
GROUP BY YEAR(D.THEDATE)
ORDER BY YEAR
;

-----------------------------------------------------------------------------------------------
-- ------------------------------EMPLOYEE PERFORMANCE------------------------------------------
-----------------------------------------------------------------------------------------------
-- TOP 10 SALES EMPLOYEES

SELECT TOP 10 
  E.EMPLOYEENUMBER, CONCAT(E.FIRSTNAME,' ',E.LASTNAME) AS EMPLOYEENAME, SUM(OD.PRICE) AS TOTAL_SALES
FROM EMPLOYEES E
JOIN ORDER_DETAILS OD 
ON E.EMPLOYEENUMBER = OD.EMPLOYEENUMBER
GROUP BY E.EMPLOYEENUMBER, CONCAT(E.FIRSTNAME,' ',E.LASTNAME)
ORDER BY TOTAL_SALES DESC
;

-----------------------------------------------------------------------------------------------
-- EMPLOYEE ORDER COUNT

SELECT 
  E.EMPLOYEENUMBER, CONCAT(E.FIRSTNAME,' ',E.LASTNAME) AS EMPLOYEENAME, COUNT(O.ORDERNUMBER) AS TOTAL_ORDERS
FROM EMPLOYEES E
JOIN ORDERS O
ON E.EMPLOYEENUMBER = O.EMPLOYEENUMBER
GROUP BY E.EMPLOYEENUMBER, CONCAT(E.FIRSTNAME,' ',E.LASTNAME) 
ORDER BY TOTAL_ORDERS DESC
;

-----------------------------------------------------------------------------------------------
-- ------------------------------REGIONAL ANALYSIS---------------------------------------------
-----------------------------------------------------------------------------------------------
-- SALES AND ORDERS BY OFFICE LOCATION

SELECT 
  O.OFFICECODE, O.ADDRESSLINE1 AS OFFICE_LOCATION, SUM(OD.PRICE) AS TOTAL_SALES, COUNT(DISTINCT OD.ORDERNUMBER) AS NUMBER_OF_ORDERS
FROM OFFICES O
JOIN ORDER_DETAILS OD 
ON O.OFFICECODE = OD.OFFICECODE
GROUP BY O.OFFICECODE, O.ADDRESSLINE1
ORDER BY TOTAL_SALES DESC
;

-----------------------------------------------------------------------------------------------
-- ------------------------------DATE ANALYSIS-------------------------------------------------
-----------------------------------------------------------------------------------------------
-- SALES ON WEEKDAYS VS WEEKENDS

SELECT 
  CASE WHEN DATEPART(DW,D.TheDate) IN (1,7) THEN 'WEEKEND'
       ELSE 'WEEKDAY'
    END AS DAY_TYPE,
  SUM(OD.PRICE) AS TOTAL_SALES
FROM DATES D
JOIN ORDERS O ON D.TheDate = O.ORDERDATE
JOIN ORDER_DETAILS OD ON O.ORDERNUMBER = OD.ORDERNUMBER
GROUP BY 
  CASE WHEN DATEPART(DW,D.TheDate) IN (1,7) THEN 'WEEKEND'
       ELSE 'WEEKDAY'
    END 
;

-----------------------------------------------------------------------------------------------
-- SALES BY QUARTER

SELECT 
  QUARTER,TOTAL_SALES
FROM (
SELECT 
  CONCAT('Q', DATEPART(QUARTER, D.THEDATE), ' ', DATEPART(YEAR, D.THEDATE)) AS QUARTER, 
  DATEPART(YEAR, D.THEDATE) AS Y,
  DATEPART(QUARTER, D.THEDATE) AS Q,
  SUM(OD.PRICE) AS TOTAL_SALES
FROM DATES D
JOIN ORDERS O 
ON D.THEDATE = O.ORDERDATE
JOIN ORDER_DETAILS OD 
ON O.ORDERNUMBER = OD.ORDERNUMBER
GROUP BY CONCAT('Q', DATEPART(QUARTER, D.THEDATE), ' ', DATEPART(YEAR, D.THEDATE)),DATEPART(YEAR, D.THEDATE), DATEPART(QUARTER, D.THEDATE)
-- ORDER BY DATEPART(YEAR, D.THEDATE), DATEPART(QUARTER, D.THEDATE)
-- ORDER BY QUARTER
) CON
ORDER BY Y,Q
;
