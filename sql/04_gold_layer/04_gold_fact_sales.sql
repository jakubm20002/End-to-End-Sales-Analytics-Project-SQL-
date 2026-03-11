CREATE VIEW gold.facts_sales AS
	SELECT
		od.order_id,
		od.product_id,
		o.customer_key,
		o.order_date,
		o.required_date,
		o.shipped_date,
		od.unit_price,
		od.quantity,
		od.discount,
		CAST((od.unit_price * od.quantity *(1 - discount)) AS NUMERIC(10,2)) sale_amount
	FROM silver.order_detail od
	INNER JOIN gold.dim_orders o
	ON od.order_id = o.order_id
	

