/*
=====================================
Creation of Tables for Silver Layer
=====================================
WARNING:
In case of changing tables structure, the content will be deleted.
*/
--Customer Table Creation
IF OBJECT_ID('silver.customer', 'U') IS NOT NULL
	DROP TABLE silver.customer;
GO
CREATE TABLE silver.customer (
	customer_id NVARCHAR(50),
	company_name NVARCHAR(100),
	contact_name NVARCHAR(50),
	contact_title NVARCHAR(50),
	address NVARCHAR(100),
	city NVARCHAR(50),
	region NVARCHAR(50),
	postal_code NVARCHAR(50),
	country NVARCHAR(50),
	phone NVARCHAR(50),
	fax NVARCHAR(50)
);

--Supplier Table Creation
IF OBJECT_ID('silver.supplier', 'U') IS NOT NULL
	DROP TABLE silver.supplier;
GO
CREATE TABLE silver.supplier (
	supplier_id INT,
	company_name NVARCHAR(100),
	contact_name NVARCHAR(50),
	contact_title NVARCHAR(50),
	address NVARCHAR(100),
	city NVARCHAR(50),
	region NVARCHAR(50),
	postal_code NVARCHAR(50),
	country NVARCHAR(50),
	phone NVARCHAR(50),
	fax NVARCHAR(50),
	home_page NVARCHAR(255)
);

--Products Table Creation
IF OBJECT_ID('silver.products', 'U') IS NOT NULL
	DROP TABLE silver.products;
GO
CREATE TABLE silver.products (
	product_id INT,
	product_name NVARCHAR(100),
	supplier_id INT,
	category_id INT,
	quantity_per_unit NVARCHAR(100),
	unit_price NUMERIC(10,2),
	unit_stock INT,
	units_on_order INT,
	reorder_level INT,
	discontinued INT
);

--Category Table Creation
IF OBJECT_ID('silver.category', 'U') IS NOT NULL
	DROP TABLE silver.category;
GO
CREATE TABLE silver.category (
	category_id INT,
	category_name NVARCHAR(50),
	description NVARCHAR(100),
	picture NVARCHAR(MAX)
);

--Orders Table Creation
IF OBJECT_ID('silver.orders', 'U') IS NOT NULL
	DROP TABLE silver.orders;
GO
CREATE TABLE silver.orders (
	order_id INT,
	customer_id NVARCHAR(50),
	employee_id INT,
	order_date DATE,
	required_date DATE,
	shipped_date DATE,
	ship_via INT,
	freight NUMERIC(10,2),
	ship_name NVARCHAR(100),
	ship_address NVARCHAR(100),
	ship_city NVARCHAR(50),
	ship_region NVARCHAR(50),
	ship_postal_code NVARCHAR(50),
	ship_country NVARCHAR(50)
);

--Order Detail Table Creation
IF OBJECT_ID('silver.order_detail', 'U') IS NOT NULL
	DROP TABLE silver.order_detail;
GO
CREATE TABLE silver.order_detail (
	order_id INT,
	product_id INT,
	unit_price NUMERIC(10,2),
	quantity INT,
	discount NUMERIC(10,2)
)