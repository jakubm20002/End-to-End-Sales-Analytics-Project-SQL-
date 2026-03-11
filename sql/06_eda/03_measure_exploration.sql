/*
====================
Measure Exploration
====================
*/

-- Total sales amount
SELECT
	SUM(sale_amount) total_sales
FROM gold.facts_sales;

--Total items quantity sold
SELECT
	SUM(quantity) total_quantity
FROM gold.facts_sales;

--Average selling price
SELECT
	CAST(AVG(unit_price) AS NUMERIC(10,2)) average_price
FROM gold.facts_sales

--Total number of orders
SELECT
	COUNT(*) total_orders
FROM gold.dim_orders;

--Total number of products
SELECT
	COUNT(*) total_products
FROM gold.dim_products;

--Total number of customers
SELECT
	COUNT(*) total_customers
FROM gold.dim_customers;

--Total number of customers without any orders
SELECT
	COUNT(c.customer_key) customers_without_orders
FROM gold.dim_customers c
LEFT JOIN gold.facts_sales fs
ON fs.customer_key = c.customer_key
WHERE fs.customer_key IS NULL;

/*
===========================
Holistic report of measurements
===========================
*/

SELECT
	'Total Sales' AS measure_name,
	SUM(sale_amount) AS measure_value
FROM gold.facts_sales
UNION ALL
SELECT
	'Total Quantity',
	SUM(quantity)
FROM gold.facts_sales
UNION ALL
SELECT
	'Average Price',
	CAST(AVG(unit_price) AS NUMERIC(10,2))
FROM gold.facts_sales
UNION ALL
SELECT
	'Total Orders',
	COUNT(*)
FROM gold.dim_orders
UNION ALL
SELECT
	'Total Products',
	COUNT(*)
FROM gold.dim_products
UNION ALL
SELECT
	'Total Customers',
	COUNT(*)
FROM gold.dim_customers
UNION ALL
SELECT
	'Customers without orders',
	COUNT(c.customer_key)
FROM gold.dim_customers c
LEFT JOIN gold.facts_sales fs
ON fs.customer_key = c.customer_key
WHERE fs.customer_key IS NULL