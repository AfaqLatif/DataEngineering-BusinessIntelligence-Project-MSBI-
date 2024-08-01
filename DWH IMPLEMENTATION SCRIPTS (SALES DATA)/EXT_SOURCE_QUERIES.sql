select * from customers
;
SELECT * FROM employees
;
SELECT * FROM offices
;
SELECT * FROM orderdetails
;
SELECT * FROM orders
;
SELECT * FROM payments
;
-- SELECT * FROM products;
-- SELECT * FROM productlines;

-- -------------------------------------------------------------------------------------
SELECT * FROM productlines
;
SELECT distinct productLine FROM productlines
;
create table product_category as
SELECT 
 row_number() over(order by productLine) as productLineNumber,
 productLine,
 textDescription,
 htmlDescription,
 image
FROM productlines
;
-- ------------------------------------------------------------------------------------

select * from product_category
;
alter table product_category 
add constraint productLineNumber_PK 
primary key(productLineNumber) 
;
-- -------------------------------------------------------------------------------------

SELECT * FROM products
where productLine = 'Motorcycles'
;
alter table products add column productLineId int
;
update products p
set productLineId = (select productLineNumber from product_category pl
					 where p.productLine = pl.productLine)
;
alter table products drop foreign key products_ibfk_1
;
alter table products drop column productLine
;
alter table products modify column productLineId bigint
;

alter table product_category modify column productLineNumber bigint
;

alter table products 
add constraint productLineId_FK 
foreign key(productLineId) 
references product_category(productLineNumber)
;

-- -------------------------------------------------------------------------------------
select * from products
where productLineId = 2
;
select * from product_category
;
-- -------------------------------------------------------------------------------------


-- -------------------------------------------------------------------------------------
-- -------------------------------EXTRACTION HELP QUERIES--------------------------------
-- -------------------------------------------------------------------------------------

SELECT 
  CONCAT(COLUMN_NAME,',') 
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA = 'sales_db'
AND TABLE_NAME = 'PRODUCT_CATEGORY'
ORDER BY ORDINAL_POSITION
;

SELECT 
CAST(productLineNumber AS CHAR) AS productLineNumber,
productLine,
textDescription,
htmlDescription,
image
FROM product_category
;

-- -------------------------------------------------------------------------------------
