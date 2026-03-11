/*
===========================================
Cleansing and loading data to silver layer
===========================================
*/
CREATE OR ALTER PROCEDURE silver.load_silver AS
BEGIN
	--Customer Data
	PRINT 'Customer Data Import';
	TRUNCATE TABLE silver.customer;

	INSERT INTO silver.customer (
		customer_id,
		company_name,
		contact_name,
		contact_title,
		address,
		city,
		region,
		postal_code,
		country,
		phone,
		fax
	)
	SELECT
		TRIM(customerID) customer_id,
		TRIM(companyName) company_name,
		TRIM(contactName) contact_name,
		TRIM(contactTitle) cotact_title,
		TRIM(address) address,
		TRIM(city) city,
		CASE
			WHEN region = 'NULL' OR region IS NULL THEN 'n/a'
			ELSE region
		END AS region,
		TRIM(postalCode) postal_code,
		CASE
			WHEN country = 'UK' THEN 'United Kingdom'
			WHEN country = 'USA' THEN 'United States'
			ELSE TRIM(country)
		END AS country,
		TRIM(phone) phone,
		CASE
			WHEN fax = 'NULL' THEN 'n/a'
			ELSE TRIM(fax)
		END AS fax
	FROM bronze.customer;

	--Supplier Data
	PRINT '--------------';
	PRINT 'Supplier Data Import';
	TRUNCATE TABLE silver.supplier;

	INSERT INTO silver.supplier (
		supplier_id,
		company_name,
		contact_name,
		contact_title,
		address,
		city,
		region,
		postal_code,
		country,
		phone,
		fax,
		home_page
	)
	SELECT
		supplierID,
		TRIM(companyName) company_name,
		TRIM(contactName) contact_name,
		TRIM(contactTitle) contact_title,
		TRIM(address) address,
		TRIM(city) city,
		CASE
			WHEN region = 'NULL' OR region IS NULL THEN 'n/a'
			ELSE region
		END AS region,
		TRIM(postalCode) postal_code,
		CASE
			WHEN country = 'UK' THEN 'United Kingdom'
			WHEN country = 'USA' THEN 'United States'
			ELSE TRIM(country)
		END AS country,
		TRIM(phone) phone,
		CASE
			WHEN fax = 'NULL' THEN 'n/a'
			ELSE TRIM(fax)
		END AS fax,
		CASE
			WHEN homePage = 'NULL' THEN 'n/a'
			ELSE TRIM(homePage)
		END AS home_page
	FROM bronze.supplier;

	--Products Data
	PRINT '--------------';
	PRINT 'Products Data Import';
	TRUNCATE TABLE silver.products;

	INSERT INTO silver.products (
		product_id,
		product_name,
		supplier_id,
		category_id,
		quantity_per_unit,
		unit_price,
		unit_stock,
		units_on_order,
		reorder_level,
		discontinued
	)
	SELECT
		productID,
		TRIM(productName) product_name,
		supplierID,
		categoryID,
		TRIM(quantityPerUnit) quantity_per_unit,
		unitPrice,
		unitStock,
		unitsOnOrder,
		reorderLevel,
		discontinued
	FROM bronze.products;

	--Category Data
	PRINT '--------------';
	PRINT 'Category Data Import';
	TRUNCATE TABLE silver.category;

	INSERT INTO silver.category (
		category_id,
		category_name,
		description,
		picture
	)
	SELECT
		categoryID,
		TRIM(categoryName) category_name,
		description,
		picture
	FROM bronze.category;

	--Orders Data
	PRINT '--------------';
	PRINT 'Orders Data Import';
	TRUNCATE TABLE silver.orders;

	INSERT INTO silver.orders (
		order_id,
		customer_id,
		employee_id,
		order_date,
		required_date,
		shipped_date,
		ship_via,
		freight,
		ship_name,
		ship_address,
		ship_city,
		ship_region,
		ship_postal_code,
		ship_country
	)
	SELECT
		orderID,
		TRIM(customerID) customer_id,
		employeeID,
		orderDate,
		requiredDate,
		shippedDate,
		shipVia,
		freight,
		TRIM(shipName) ship_name,
		TRIM(shipAddress) ship_address,
		TRIM(shipCity) ship_city,
		CASE
			WHEN shipRegion = 'NULL' THEN 'n/a'
			ELSE shipRegion
		END AS ship_region,
		CASE
			WHEN shipPostalCode = 'NULL' THEN 'n/a'
			ELSE shipPostalCode
		END AS ship_postal_code,
		CASE
			WHEN shipCountry = 'UK' THEN 'United Kingdom'
			WHEN shipCountry = 'USA' THEN 'United States'
			ELSE shipCountry
		END AS ship_country
	FROM bronze.orders
	WHERE orderID IS NOT NULL;

	--Order Detail Data
	PRINT '--------------';
	PRINT 'Order Detail Data Import';
	TRUNCATE TABLE silver.order_detail;

	INSERT INTO silver.order_detail (
		order_id,
		product_id,
		unit_price,
		quantity,
		discount
	)
	SELECT
		orderID,
		productID,
		unitPrice,
		quantity,
		discount
	FROM bronze.order_detail
END
