/*
=======================================
Revenue-Based Segmentation
=======================================

Semgentation of customers:
	High-Value Clients - over 30 000 worth of revenue
	Mid-Value Clients - between 10 000 and 30 000
	Low-Value Clients - less then 10 000
*/
CREATE VIEW gold.revenue_based_segmentation AS
	SELECT
		customer_key,
		total_revenue,
		CASE
			WHEN total_revenue > 30000 THEN 'High-Value Client'
			WHEN total_revenue BETWEEN 10000 AND 30000 THEN 'Mid-Value Client'
			ELSE 'Low-Value Client'
		END AS segmentation
	FROM (
		SELECT
			customer_key,
			SUM(sale_amount) total_revenue
		FROM gold.facts_sales
		GROUP BY customer_key
	) t
;
/*
======================================
Percentile-Based Segmentation
======================================
Semgentation of customers:
	Top customer - top 20%
	Mid customer - mid 60%
	Low customer - bottom 20%
*/
CREATE VIEW gold.percentile_based_segmentation AS
	WITH ranking AS (
		SELECT
			CUME_DIST() OVER(ORDER BY total_revenue DESC) rank_of_customer,
			customer_key,
			total_revenue
		FROM (
			SELECT
				customer_key,
				SUM(sale_amount) total_revenue
			FROM gold.facts_sales
			GROUP BY customer_key
		) t
	)
	SELECT
		customer_key,
		total_revenue,
		CASE
			WHEN rank_of_customer <= 0.2 THEN 'Top customer'
			WHEN rank_of_customer > 0.2 AND rank_of_customer <= 0.8 THEN 'Mid customer'
			ELSE 'Low customer'
		END AS segmentation
	FROM ranking