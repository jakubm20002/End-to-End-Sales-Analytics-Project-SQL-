/*
=====================================
Creation of Tables for Bronze Layer
=====================================
All column types where selected based on visual observation of the files content.
Column names and their order is strictly as in original data files.
The clause IF provides easy way to alter tables in case of potential modifications.
WARNING:
In case of changing tables structure, the content will be deleted.
*/

--Customer Table Creation
IF OBJECT_ID('bronze.customer', 'U') IS NOT NULL
	DROP TABLE bronze.customer;
GO
CREATE TABLE bronze.customer (
	customerID NVARCHAR(50),
	companyName NVARCHAR(100),
	contactName NVARCHAR(50),
	contactTitle NVARCHAR(50),
	address NVARCHAR(100),
	city NVARCHAR(50),
	region NVARCHAR(50),
	postalCode NVARCHAR(50),
	country NVARCHAR(50),
	phone NVARCHAR(50),
	fax NVARCHAR(50)
);

--Supplier Table Creation
IF OBJECT_ID('bronze.supplier', 'U') IS NOT NULL
	DROP TABLE bronze.supplier;
GO
CREATE TABLE bronze.supplier (
	supplierID INT,
	companyName NVARCHAR(100),
	contactName NVARCHAR(50),
	contactTitle NVARCHAR(50),
	address NVARCHAR(100),
	city NVARCHAR(50),
	region NVARCHAR(50),
	postalCode NVARCHAR(50),
	country NVARCHAR(50),
	phone NVARCHAR(50),
	fax NVARCHAR(50),
	homePage NVARCHAR(255)
);

--Products Table Creation
IF OBJECT_ID('bronze.products', 'U') IS NOT NULL
	DROP TABLE bronze.products;
GO
CREATE TABLE bronze.products (
	productID INT,
	productName NVARCHAR(100),
	supplierID INT,
	categoryID INT,
	quantityPerUnit NVARCHAR(100),
	unitPrice NVARCHAR(50),
	unitStock INT,
	unitsOnOrder INT,
	reorderLevel INT,
	discontinued INT
);

--Category Table Creation
IF OBJECT_ID('bronze.category', 'U') IS NOT NULL
	DROP TABLE bronze.category;
GO
CREATE TABLE bronze.category (
	categoryID INT,
	categoryName NVARCHAR(50),
	description NVARCHAR(100),
	picture NVARCHAR(MAX)
);

--Orders Table Creation
IF OBJECT_ID('bronze.orders', 'U') IS NOT NULL
	DROP TABLE bronze.orders;
GO
CREATE TABLE bronze.orders (
	orderID INT,
	customerID NVARCHAR(50),
	employeeID INT,
	orderDate NVARCHAR(50),
	requiredDate NVARCHAR(50),
	shippedDate NVARCHAR(50),
	shipVia INT,
	freight NVARCHAR(50),
	shipName NVARCHAR(100),
	shipAddress NVARCHAR(100),
	shipCity NVARCHAR(50),
	shipRegion NVARCHAR(50),
	shipPostalCode NVARCHAR(50),
	shipCountry NVARCHAR(50)
);

--Order Detail Table Creation
IF OBJECT_ID('bronze.order_detail', 'U') IS NOT NULL
	DROP TABLE bronze.order_detail;
GO
CREATE TABLE bronze.order_detail (
	orderID INT,
	productID INT,
	unitPrice NVARCHAR(50),
	quantity INT,
	discount NVARCHAR(50)
)