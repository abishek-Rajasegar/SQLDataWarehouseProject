/*
===================================================================================
Script Name  : DataWarehouse_Setup.sql
Description  : Implementing a stored procedure (bronze.load_bronze) to automate bulk data import.

Bulk Load Procedure:
--------------------
The procedure `bronze.load_bronze` is designed to:
    - Truncate existing data in Bronze tables before loading new data.
    - Bulk insert data from CSV files into the respective Bronze tables.
    - Provide execution time statistics for each table's data load.
    - Handle errors gracefully with informative error messages.

Tables Loaded:
--------------
    - bronze.crm_cust_info      : Customer information from CRM.
    - bronze.crm_prd_info       : Product details from CRM.
    - bronze.crm_sales_details  : Sales transactions from CRM.
    - bronze.erp_loc_a101       : Location data from ERP.
    - bronze.erp_cust_az12      : Customer demographic data from ERP.
    - bronze.erp_px_cat_g1v2    : Product category and maintenance details from ERP.

Execution:
----------
    The stored procedure can be executed using:
    EXECUTE bronze.load_bronze;

===================================================================================
*/
CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
	DECLARE @start_time DATETIME , @end_time DATETIME, @load_start_time DATETIME, @load_end_time DATETIME;
	BEGIN TRY 
		PRINT '===================================================================================';
		PRINT 'Loading data into Bronze layer';
		PRINT '===================================================================================';
	
		PRINT '------------------------------------------------------------------------------------';
		PRINT 'Loading data for crm tables in Bronze layer';
		PRINT '------------------------------------------------------------------------------------';

		SET @load_start_time = GETDATE();
		PRINT '';
		SET @start_time = GETDATE();
		PRINT '>> Truncating Table : bronze.crm_cust_info';
		TRUNCATE TABLE bronze.crm_cust_info;
		PRINT '>> Inserting data into : bronze.crm_cust_info';
		BULK INSERT bronze.crm_cust_info
		FROM 'C:\Users\Abi\Desktop\SQLDataWarehouseProject\datasets\source_crm\cust_info.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK  
		); 
		SET @end_time = GETDATE();
		PRINT 'Time take : '+ CAST(DATEDIFF(second, @start_time , @end_time) AS VARCHAR) + ' seconds';

		PRINT '';
		SET @start_time = GETDATE();
		PRINT '>> Truncating Table : bronze.crm_prd_info';
		TRUNCATE TABLE bronze.crm_prd_info
		PRINT '>> Inserting data into : bronze.crm_prd_info';
		BULK INSERT bronze.crm_prd_info
		FROM 'C:\Users\Abi\Desktop\SQLDataWarehouseProject\datasets\source_crm\prd_info.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK  
		);
		SET @end_time = GETDATE();
		PRINT 'Time take : '+ CAST(DATEDIFF(second, @start_time , @end_time) AS VARCHAR) + ' seconds';

		PRINT '';
		SET @start_time = GETDATE();
		PRINT '>> Truncating Table : bronze.crm_sales_details';
		TRUNCATE TABLE bronze.crm_sales_details
		PRINT '>> Inserting data into : bronze.crm_sales_details';
		BULK INSERT bronze.crm_sales_details
		FROM 'C:\Users\Abi\Desktop\SQLDataWarehouseProject\datasets\source_crm\sales_details.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK  
		);
		SET @end_time = GETDATE();
		PRINT 'Time take : '+ CAST(DATEDIFF(second, @start_time , @end_time) AS VARCHAR) + ' seconds';

		PRINT '------------------------------------------------------------------------------------';
		PRINT 'Loading data for erp tables in Bronze layer';
		PRINT '------------------------------------------------------------------------------------';
		
		PRINT '';
		SET @start_time = GETDATE();
		PRINT '>> Truncating Table : bronze.erp_cust_az12';
		TRUNCATE TABLE bronze.erp_cust_az12
		PRINT '>> Inserting data into : bronze.erp_cust_az12';
		BULK INSERT bronze.erp_cust_az12
		FROM 'C:\Users\Abi\Desktop\SQLDataWarehouseProject\datasets\source_erp\CUST_AZ12.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK  
		);
		SET @end_time = GETDATE();
		PRINT 'Time take : '+ CAST(DATEDIFF(second, @start_time , @end_time) AS VARCHAR) + ' seconds';

		PRINT '';
		SET @start_time = GETDATE();
		PRINT '>> Truncating Table : bronze.erp_loc_a101';
		TRUNCATE TABLE bronze.erp_loc_a101 
		PRINT '>> Inserting data into : bronze.erp_loc_a101';
		BULK INSERT bronze.erp_loc_a101
		FROM 'C:\Users\Abi\Desktop\SQLDataWarehouseProject\datasets\source_erp\LOC_A101.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK  
		);
		SET @end_time = GETDATE();
		PRINT 'Time take : '+ CAST(DATEDIFF(second, @start_time , @end_time) AS VARCHAR) + ' seconds';

		PRINT '';
		SET @start_time = GETDATE();
		PRINT '>> Truncating Table : bronze.erp_px_cat_g1v2';
		TRUNCATE TABLE bronze.erp_px_cat_g1v2  
		PRINT '>> Inserting data into : bronze.erp_px_cat_g1v2';
		BULK INSERT bronze.erp_px_cat_g1v2
		FROM 'C:\Users\Abi\Desktop\SQLDataWarehouseProject\datasets\source_erp\PX_CAT_G1V2.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK  
		);
		SET @end_time = GETDATE();
		PRINT 'Time take : '+ CAST(DATEDIFF(second, @start_time , @end_time) AS VARCHAR) + ' seconds';

		SET @load_end_time = GETDATE();
		PRINT ''
		PRINT  '===================================================================================';
		PRINT '>>Total time taken to load all the tables :' + CAST(DATEDIFF(MILLISECOND ,@load_start_time , @load_end_time) AS VARCHAR) + ' seconds'
		PRINT  '===================================================================================';
	END TRY
	BEGIN CATCH
		PRINT  '===================================================================================';
		PRINT 'ERROR OCCURED DRING LOADING DATA INTO BRONZE LAYER'
		PRINT 'Error Message' + ERROR_MESSAGE();
		PRINT 'Error Number' + CAST(ERROR_NUMBER() AS VARCHAR);
		PRINT  '===================================================================================';
	END CATCH
END

EXECUTE bronze.load_bronze;






















