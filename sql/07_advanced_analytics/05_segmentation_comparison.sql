/*
==============================
Segmentation comparison
==============================
*/
SELECT
	segmentation,
	COUNT(*) AS number_of_customers,
	SUM(total_revenue) AS total_revenue
FROM gold.percentile_based_segmentation
GROUP BY segmentation
ORDER BY total_revenue DESC;

SELECT
	segmentation,
	COUNT(*) AS number_of_customers,
	SUM(total_revenue) AS total_revenue
FROM gold.revenue_based_segmentation
GROUP BY segmentation
ORDER BY total_revenue DESC