/*
======================
Customer Bronze Table Check
======================
*/

--Counting Rows
--Expected rows from source file: 91
SELECT 
	COUNT(*) AS row_count
FROM bronze.customer;

--Counting Nulls or empty spaces in customerID column
--Expected result: 0
--Checking for empty spaces is caused by NVARCHAR data type of customerID column.
SELECT 
	COUNT(*) AS null_customerID
FROM bronze.customer
WHERE customerID IS NULL
OR TRIM(customerID) = '';

--Checking for duplicates in customer ID column
--Expected result: no result
SELECT 
	customerID,
	COUNT(*) count_id
FROM bronze.customer
GROUP BY customerID
HAVING COUNT(customerID) > 1;

--======================
--Products Bronze Table Check
--======================

--Counting Rows
--Expected rows from source file: 77
SELECT 
	COUNT(*) AS row_count
FROM bronze.products;

--Counting Nulls in productID column
--Expected result: 0
SELECT 
	COUNT(*) AS count_id
FROM bronze.products
WHERE productID IS NULL;

--Checking for duplicates in productID column
--Expected result: none
SELECT 
	productID,
	COUNT(*) count_id
FROM bronze.products
GROUP BY productID
HAVING COUNT(productID) > 1;

--======================
--Category Bronze Table Check
--======================

--Counting Rows
--Expected rows from source file: 8
SELECT 
	COUNT(*) AS row_count
FROM bronze.category;

--Counting Nulls in categoryID column
--Expected result: 0
SELECT 
	COUNT(*) AS count_id
FROM bronze.category
WHERE categoryID IS NULL;

--Checking for duplicates in categoryID column
--Expected result: none
SELECT 
	categoryID,
	COUNT(*) count_id
FROM bronze.category
GROUP BY categoryID
HAVING COUNT(categoryID) > 1;

--======================
--Supplier Bronze Table Check
--======================

--Counting Rows
--Expected rows from source file: 29
SELECT 
	COUNT(*) AS row_count
FROM bronze.supplier;

--Counting Nulls in supplierID column
--Expected result: 0
SELECT 
	COUNT(*) AS count_id
FROM bronze.supplier
WHERE supplierID IS NULL;

--Checking for duplicates in supplierID column
--Expected result: no result
SELECT 
	supplierID,
	COUNT(*) count_id
FROM bronze.supplier
GROUP BY supplierID
HAVING COUNT(supplierID) > 1;

--======================
--Orders Bronze Table Check
--======================

--Counting Rows
--Expected rows from source file: 800
SELECT 
	COUNT(*) AS row_count
FROM bronze.orders;

--Counting Nulls in orderID column
--Expected result: 0
SELECT 
	COUNT(*) AS count_id
FROM bronze.orders
WHERE orderID IS NULL;

--Checking for duplicates in orderID column
--Expected result: none
SELECT 
	orderID,
	COUNT(*) count_id
FROM bronze.orders
GROUP BY orderID
HAVING COUNT(orderID) > 1;

--======================
--Order Detail Bronze Table Check
--======================

--Counting Rows
--Expected rows from source file: 2062
SELECT 
	COUNT(*) AS row_count
FROM bronze.order_detail;

--Counting Nulls in orderID column
--Expected result: 0
SELECT 
	COUNT(*) AS count_id
FROM bronze.order_detail
WHERE orderID IS NULL;

--Checking for duplicates based on orderID and productID combination
--Expected result: no results
SELECT
	orderID,
	productID,
	COUNT(*)
FROM bronze.order_detail
GROUP BY orderID, productID
HAVING COUNT(*) > 1