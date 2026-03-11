/*
=====================================
Checking the correctness of connections between views
=====================================
*/

--Expected result: no results
SELECT
	*
FROM gold.facts_sales fs
LEFT JOIN gold.dim_customers dc
ON fs.customer_key = dc.customer_key
WHERE dc.customer_key IS NULL;

--Expected result: no results
SELECT
	*
FROM gold.facts_sales fs
LEFT JOIN gold.dim_products dp
ON fs.product_id= dp.product_id
WHERE dp.product_id IS NULL;

--Expected result: no results
SELECT
	*
FROM gold.facts_sales fs
LEFT JOIN gold.dim_orders o
ON fs.order_id = o.order_id
WHERE o.order_id IS NULL;