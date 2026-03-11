CREATE VIEW gold.dim_products AS
	SELECT
		product_id,
		product_name,
		p.supplier_id,
		s.company_name AS supplier_name,
		s.city AS supplier_city,
		s.country AS supplier_country,
		p.category_id,
		c.category_name,
		unit_price,
		unit_stock,
		units_on_order,
		reorder_level,
		discontinued
	FROM silver.products p
	INNER JOIN silver.supplier s
	ON p.supplier_id = s.supplier_id
	INNER JOIN silver.category c
	ON p.category_id = c.category_id