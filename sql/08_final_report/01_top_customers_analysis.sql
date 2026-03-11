/*
=================================
Providing informations about our top customers
=================================
Details:
- How much revenue did the "top" 20% of customers generate?
- Which countries do these 20% come from?
- What is their average lifespan?
- What is their average number of orders?
- What is average discount we provide for these customers?
*/
WITH basic_informations AS (
	SELECT
		order_id,
		fs.customer_key,
		discount,
		order_date,
		sale_amount,
		company_name,
		country
	FROM gold.facts_sales fs
	INNER JOIN gold.dim_customers dc
	ON fs.customer_key = dc.customer_key
), aggregations AS (
	SELECT
		customer_key,
		company_name,
		country,
		SUM(sale_amount) AS sales_by_customer,
		COUNT(*) AS number_of_orders_by_customer,
		MIN(order_date) AS first_order,
		MAX(order_date) AS last_order,
		DATEDIFF(month, MIN(order_date), MAX(order_date)) customer_lifespan_in_months
	FROM basic_informations
	GROUP BY
		customer_key,
		company_name,
		country
), top_customers AS (
	SELECT
		customer_key,
		company_name,
		country,
		sales_by_customer,
		overall_sales
	FROM (
		SELECT
			customer_key,
			company_name,
			country,
			sales_by_customer,
			CUME_DIST() OVER(ORDER BY sales_by_customer DESC) AS flag,
			SUM(sales_by_customer) OVER() AS overall_sales
		FROM aggregations
	) t
	WHERE flag <= 0.2
), top_segment_metrics AS (
	SELECT
        -- per customer metrics
        (SELECT AVG(customer_lifespan_in_months)
         FROM aggregations a
         JOIN top_customers tc
           ON a.customer_key = tc.customer_key) AS average_lifespan,

        (SELECT AVG(number_of_orders_by_customer)
         FROM aggregations a
         JOIN top_customers tc
           ON a.customer_key = tc.customer_key) AS average_orders,

        -- weighted discount
        (SELECT AVG(bi.discount)
         FROM basic_informations bi
         JOIN top_customers tc
           ON bi.customer_key = tc.customer_key) AS average_discount_weighted
)
SELECT
	customer_key,
	company_name,
	country,
	sales_by_customer,
	overall_sales,
	SUM(sales_by_customer) OVER() AS premium_sales,
	SUM(sales_by_customer) OVER()/overall_sales AS premium_sales_share,
	average_lifespan,
	average_orders,
	average_discount_weighted
FROM top_customers
CROSS JOIN top_segment_metrics
