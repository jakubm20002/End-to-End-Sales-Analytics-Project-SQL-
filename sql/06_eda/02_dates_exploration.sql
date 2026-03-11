-- Dates exploration

SELECT 
	MIN(order_date) first_order,
	MAX(order_date) last_order,
	DATEDIFF(month, MIN(order_date), MAX(order_date)) order_activity_months,
	MIN(shipped_date) first_shipment,
	MAX(shipped_date) last_shipment,
	DATEDIFF(month, MIN(shipped_date), MAX(shipped_date)) shipment_activity_months
FROM gold.facts_sales;

SELECT
	MIN(DATEDIFF(day, order_date, shipped_date)) fastest_shipping,
	MAX(DATEDIFF(day, order_date, shipped_date)) slowest_shipping,
	AVG(DATEDIFF(day, order_date, shipped_date)) average_shipping_time
FROM gold.facts_sales
WHERE shipped_date IS NOT NULL

SELECT
	COUNT(*) total_orders,
	SUM(CASE WHEN shipped_date IS NULL THEN 1 ELSE 0 END) not_shipped,
	SUM(CASE WHEN shipped_date IS NOT NULL THEN 1 ELSE 0 END) shipped
FROM gold.dim_orders
