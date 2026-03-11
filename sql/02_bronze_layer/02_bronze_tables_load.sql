/*
====================================
Inserting Data Into Tables
====================================
Creating procedure for future usement
All files were imported from a local disc.
The addition of CODEPAGE = '65001' was necessary to fix loading of corrupted signs.
*/
CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
	--Customer Data
	TRUNCATE TABLE bronze.customer;
	
	BULK INSERT bronze.customer
	FROM 'C:\Users\serds\OneDrive\Desktop\CSV Files\customer.csv'
	WITH (
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		CODEPAGE = '65001',
		TABLOCK
		);

	--Supplier Data
	TRUNCATE TABLE bronze.supplier
	
	BULK INSERT bronze.supplier
	FROM 'C:\Users\serds\OneDrive\Desktop\CSV Files\supplier.csv'
	WITH (
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		CODEPAGE = '65001',
		TABLOCK
		);
	--Products Data
	TRUNCATE TABLE bronze.products
	
	BULK INSERT bronze.products
	FROM 'C:\Users\serds\OneDrive\Desktop\CSV Files\product.csv'
	WITH (
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		CODEPAGE = '65001',
		TABLOCK
		);

	--Category Data
	TRUNCATE TABLE bronze.category
	
	BULK INSERT bronze.category
	FROM 'C:\Users\serds\OneDrive\Desktop\CSV Files\category.csv'
	WITH (
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		CODEPAGE = '65001',
		TABLOCK
		);

	--Orders Data
	TRUNCATE TABLE bronze.orders
	
	BULK INSERT bronze.orders
	FROM 'C:\Users\serds\OneDrive\Desktop\CSV Files\order_updated.csv'
	WITH (
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		CODEPAGE = '65001',
		TABLOCK
		);

	--Order Detail Data
	TRUNCATE TABLE bronze.order_detail
	
	BULK INSERT bronze.order_detail
	FROM 'C:\Users\serds\OneDrive\Desktop\CSV Files\order_detail.csv'
	WITH (
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		CODEPAGE = '65001',
		TABLOCK
		)
END