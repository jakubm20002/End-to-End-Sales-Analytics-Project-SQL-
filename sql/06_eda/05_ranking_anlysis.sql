/*
=================
Ranking Analysis
=================
*/

--Top 5 suppliers responsible for biggest revenue
SELECT
	*
FROM (
	SELECT
		ROW_NUMBER() OVER(ORDER BY SUM(sale_amount) DESC) rank_of_supplier,
		supplier_name,
		SUM(sale_amount) total_sales
	FROM gold.facts_sales fs
	INNER JOIN gold.dim_products dp
	ON fs.product_id = dp.product_id
	GROUP BY supplier_name
) t
WHERE rank_of_supplier <= 5;

--Top 5 worst performing customers
SELECT TOP(5)
	company_name,
	SUM(sale_amount) total_sales
FROM gold.facts_sales fs
INNER JOIN gold.dim_customers dc
ON fs.customer_key = dc.customer_key
GROUP BY company_name
ORDER BY SUM(sale_amount);

--Top 5 best performing customers
SELECT TOP(5)
	company_name,
	SUM(sale_amount) total_sales
FROM gold.facts_sales fs
INNER JOIN gold.dim_customers dc
ON fs.customer_key = dc.customer_key
GROUP BY company_name
ORDER BY SUM(sale_amount) DESC