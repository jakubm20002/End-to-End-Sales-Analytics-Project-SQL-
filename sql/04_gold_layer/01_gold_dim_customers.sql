CREATE VIEW gold.dim_customers AS
	SELECT
		ROW_NUMBER() OVER(ORDER BY customer_id) customer_key,
		customer_id,
		company_name,
		city,
		country
	FROM silver.customer