/*
======================
Customer Silver Table Check
======================
*/

--Counting Nulls or empty spaces in customer_id column
--Expected result: 0
--Checking for empty spaces is caused by NVARCHAR data type of customer_id column.
SELECT 
	COUNT(*) AS null_customer_id
FROM silver.customer
WHERE customer_id IS NULL
OR TRIM(customer_id) = '';

--Checking for duplicates in customer_id column
--Expected result: no results
SELECT 
	customer_id,
	COUNT(*) count_id
FROM silver.customer
GROUP BY customer_id
HAVING COUNT(customer_id) > 1;

--======================
--Products Silver Table Check
--======================

--Counting Nulls in product_id column
--Expected result: 0
SELECT 
	COUNT(*) AS count_id
FROM silver.products
WHERE product_id IS NULL;

--Checking for duplicates in product_id column
--Expected result: no results
SELECT 
	product_id,
	COUNT(*) count_id
FROM silver.products
GROUP BY product_id
HAVING COUNT(product_id) > 1;

--Checking Foreign Keys in silver.products table
--Expected result: no results
SELECT * FROM silver.products p
LEFT JOIN silver.supplier s
ON p.supplier_id = s.supplier_id
WHERE s.supplier_id IS NULL;

--Expected result: no results
SELECT * FROM silver.products p
LEFT JOIN silver.category c
ON p.category_id = c.category_id
WHERE c.category_id IS NULL;

--Checking for negative values
--Expected result: no results
SELECT
	unit_price,
	unit_stock,
	units_on_order,
	reorder_level
FROM silver.products
WHERE unit_price < 0
OR unit_stock < 0
OR units_on_order < 0 
OR reorder_level <0;

--======================
--Category Silver Table Check
--======================

--Counting Nulls in category_id column
--Expected result: 0
SELECT 
	COUNT(*) AS count_id
FROM silver.category
WHERE category_id IS NULL;

--Checking for duplicates in category_id column
--Expected result: no results
SELECT 
	category_id,
	COUNT(*) count_id
FROM silver.category
GROUP BY category_id
HAVING COUNT(category_id) > 1;

--======================
--Supplier Silver Table Check
--======================

--Counting Nulls in supplier_id column
--Expected result: 0
SELECT 
	COUNT(*) AS count_id
FROM silver.supplier
WHERE supplier_id IS NULL;

--Checking for duplicates in supplier_id column
--Expected result: no results
SELECT 
	supplier_id,
	COUNT(*) count_id
FROM silver.supplier
GROUP BY supplier_id
HAVING COUNT(supplier_id) > 1;

--======================
--Orders Silver Table Check
--======================

--Counting Rows
--Expected row count lower than bronze due to removal of 30 null records detected in bronze layer
SELECT 
	COUNT(*) AS row_count
FROM silver.orders;

--Counting Nulls in order_id column
--Expected result: 0
SELECT 
	COUNT(*) AS count_id
FROM silver.orders
WHERE order_id IS NULL;

--Checking for duplicates in order_id column
--Expected result: no results
SELECT 
	order_id,
	COUNT(*) count_id
FROM silver.orders
GROUP BY order_id
HAVING COUNT(order_id) > 1;

--Checking dates extremes
--Expected result: All dates between 1995-01-01 and 2000-01-01
--Boundary dates based on observed dates in files (all dates in late 1990s)
SELECT
	MAX(order_date) max_order_date,
	MIN(order_date) min_order_date,
	MAX(required_date) max_required_date,
	MIN(required_date) min_required_date,
	MAX(shipped_date) max_shipped_date,
	MIN(shipped_date) min_shipped_date
FROM silver.orders;

--======================
--Order Detail Silver Table Check
--======================

--Counting Nulls in order_id and product_id column
--Expected result: 0
SELECT 
	COUNT(*) AS count_id
FROM silver.order_detail
WHERE order_id IS NULL
OR product_id IS NULL;

--Checking for duplicates based on order_id and product_id combination
--Expected result: no results
SELECT
	order_id,
	product_id,
	COUNT(*)
FROM silver.order_detail
GROUP BY order_id, product_id
HAVING COUNT(*) > 1;

--Checking Foreign Key in silver.order_detail table
--Expected result: no results
SELECT * FROM silver.order_detail od
LEFT JOIN silver.products p
ON od.product_id = p.product_id
WHERE p.product_id IS NULL;

--Checking for negative values for unit_price, quantity or discount
--Expected result: no results
SELECT
	unit_price,
	quantity,
	discount
FROM silver.order_detail
WHERE unit_price < 0 OR quantity < 0 OR discount < 0 OR discount > 1