CREATE VIEW gold.dim_orders AS
	SELECT
		order_id,
		dc.customer_key,
		dc.company_name,
		employee_id,
		order_date,
		required_date,
		shipped_date,
		ship_via AS ship_id,
		ship_city,
		ship_country	
	FROM silver.orders o
	INNER JOIN gold.dim_customers dc
	ON o.customer_id = dc.customer_id
