/*
==============
Part to Whole Analysis
==============
*/

--Categories contribution to overall sales

WITH sales_by_category AS (
	SELECT
		category_id,
		category_name,
		SUM(sale_amount) total_sales
	FROM gold.facts_sales fs
	INNER JOIN gold.dim_products dp
	ON fs.product_id = dp.product_id
	GROUP BY category_id, category_name
)
SELECT
	category_id,
	category_name,
	total_sales AS category_sales,
	SUM(total_sales) OVER() overall_total_sales,
	CONCAT(ROUND(CAST(total_sales/SUM(total_sales) OVER() AS NUMERIC(10,2))*100, 2),'%') percentage_of_total_sales
FROM sales_by_category
ORDER BY total_sales DESC