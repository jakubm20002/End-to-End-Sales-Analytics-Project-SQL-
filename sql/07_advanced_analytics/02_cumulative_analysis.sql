--Running total sales over time (months)
SELECT
	order_month,
	sum_of_sales,
	SUM(sum_of_sales) OVER(ORDER BY order_month) cumulative_sales
FROM (
	SELECT
		DATETRUNC(month, order_date) order_month,
		SUM(sale_amount) sum_of_sales	
	FROM gold.facts_sales
	GROUP BY DATETRUNC(month, order_date)
) t;

-- Running total quantity over time (months)
WITH sum_of_quantity AS (
	SELECT
		DATETRUNC(month, order_date) order_month,
		SUM(quantity) total_quantity
	FROM gold.facts_sales
	GROUP BY DATETRUNC(month, order_date)
)
SELECT
	order_month,
	total_quantity,
	SUM(total_quantity) OVER(ORDER BY order_month) cumulative_quantity
FROM sum_of_quantity