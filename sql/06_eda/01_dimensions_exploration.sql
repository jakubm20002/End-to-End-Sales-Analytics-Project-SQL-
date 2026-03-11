--Dimensions Exploration

--Customers countries of origin and shipment countries
SELECT DISTINCT
	ship_country,
	country AS customer_country
FROM gold.dim_orders o 
INNER JOIN gold.dim_customers c
ON o.customer_key = c.customer_key
WHERE o.ship_country = c.country
ORDER BY country;

-- List of suppliers
SELECT DISTINCT
	supplier_name
FROM gold.dim_products;

-- Suppliers countries of origin
SELECT DISTINCT
	supplier_country
FROM gold.dim_products;

--List of categories
SELECT DISTINCT
	category_name
FROM gold.dim_products


