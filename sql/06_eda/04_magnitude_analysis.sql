/*
=========================
Magnitude Analysis
=========================
*/

--Total customers by country
SELECT
	country,
	COUNT(*) total_customers
FROM gold.dim_customers
GROUP BY country
ORDER BY COUNT(*) DESC;

--Total sales by country
SELECT
	country,
	SUM(sale_amount) total_sales
FROM gold.facts_sales fs 
INNER JOIN gold.dim_customers dc
ON fs.customer_key = dc.customer_key
GROUP BY country
ORDER BY SUM(sale_amount) DESC;

--Total orders by country
SELECT
	country,
	COUNT(*) total_orders
FROM gold.dim_orders o
INNER JOIN gold.dim_customers c
ON o.customer_key = c.customer_key
GROUP BY country
ORDER BY COUNT(*) DESC;

--Products by category
SELECT
	category_name,
	COUNT(*) total_products
FROM gold.dim_products
GROUP BY category_name
ORDER BY COUNT(*) DESC;

--Total sales by category
SELECT
	category_name,
	SUM(sale_amount) total_sales
FROM gold.facts_sales fs
INNER JOIN gold.dim_products dp
ON fs.product_id = dp.product_id
GROUP BY category_name
ORDER BY SUM(sale_amount) DESC
