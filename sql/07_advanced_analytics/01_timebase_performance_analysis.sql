--Average sales in each month compared to overall average monthly sales

WITH monthly_average_sales AS (
	SELECT
		order_month,
		AVG(total_sales) AS average_sales_in_each_month
	FROM (
		SELECT
			YEAR(order_date) AS order_year,
			MONTH(order_date) AS order_month,
			SUM(quantity) AS total_quantity,
			SUM(sale_amount) AS total_sales
		FROM gold.facts_sales
		GROUP BY YEAR(order_date), MONTH(order_date)
	) t
	GROUP BY order_month
), average_sales AS (
	SELECT
		AVG(avg_sales) AS overall_average_monthly_sales
	FROM (
		SELECT
			DATETRUNC(month, order_date) m,
			SUM(sale_amount) avg_sales
		FROM gold.facts_sales
		GROUP BY DATETRUNC(month, order_date)
	) t
), comparison AS (
	SELECT
		order_month,
		average_sales_in_each_month,
		overall_average_monthly_sales,
		average_sales_in_each_month/overall_average_monthly_sales AS seasonality_index
	FROM monthly_average_sales
	CROSS JOIN average_sales
) 
SELECT
	order_month,
	CAST(average_sales_in_each_month AS NUMERIC(10,2)) AS average_sales_in_each_month,
	CAST(overall_average_monthly_sales AS NUMERIC(10,2)) AS overall_average_monthly_sales,
	CAST(seasonality_index AS NUMERIC(10,2)) AS seasonality_index,
	CASE
		WHEN seasonality_index > 1 THEN 'Above average'
		WHEN seasonality_index = 1 THEN 'Average'
		ELSE 'Below average'
	END AS seasonality_flag
FROM comparison
ORDER BY order_month;

--Sales dynamics month by month
SELECT
	order_year,
	order_month,
	total_sales,
	LAG(total_sales) OVER(ORDER BY order_year, order_month) AS previous_month_sales,
	CAST(total_sales/LAG(total_sales) OVER(ORDER BY order_year, order_month) AS NUMERIC(10,2)) AS sales_dynamics,
	CASE
		WHEN total_sales/LAG(total_sales) OVER(ORDER BY order_year, order_month) > 1 THEN 'Growth'
		WHEN total_sales/LAG(total_sales) OVER(ORDER BY order_year, order_month) = 1 THEN 'No change'
		WHEN total_sales/LAG(total_sales) OVER(ORDER BY order_year, order_month) IS NULL THEN 'n/a'
		ELSE 'Decline'
	END AS dynamic_flag
FROM (
	SELECT
		YEAR(order_date) AS order_year,
		MONTH(order_date) AS order_month,
		SUM(sale_amount) AS total_sales
	FROM gold.facts_sales
	GROUP BY YEAR(order_date), MONTH(order_date)
) t