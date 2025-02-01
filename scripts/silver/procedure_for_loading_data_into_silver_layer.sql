/*
===================================================================================
Script Name  : Load_Silver_Procedure.sql
Description  : This script defines and executes the `silver.load_silver` procedure,
               which transforms and loads data from the Bronze layer into the Silver layer.
               It includes:
               1. Data cleaning and standardization.
               2. Remove Deduplication and filtering of the latest records.
               3. Type conversions and data enrichment.
               4. Error handling and execution time logging.

Data Transformations:
---------------------
- Standardizes gender, marital status, and country names.
- Removes duplicates using the latest available records.
- Handles null values and ensures data integrity.
- Computes derived columns such as category IDs and product keys.

Tables Loaded:
--------------
    - silver.crm_cust_info       : Cleansed customer data from CRM.
    - silver.crm_prd_info        : Standardized product details from CRM.
    - silver.crm_sales_details   : Validated sales transaction data from CRM.
    - silver.erp_px_cat_g1v2     : Product category and maintenance records from ERP.
    - silver.erp_cust_az12       : Customer demographic information from ERP.
    - silver.erp_loc_a101        : Location and country standardization for ERP data.

Execution:
----------
    The stored procedure can be executed using:
    EXEC silver.load_silver;

===================================================================================
*/


CREATE OR ALTER PROCEDURE silver.load_silver AS
	DECLARE 
		@query_start_time DATETIME, @query_end_time DATETIME 
	  , @load_start_time DATETIME, @load_end_time DATETIME;
	BEGIN
		BEGIN TRY
			SET @load_start_time = GETDATE();
			PRINT '====================================================================='
			PRINT 'Loading data into silver layer'
			PRINT '====================================================================='

			PRINT ''

			PRINT '---------------------------------------------------------------------'
			PRINT 'Loading data for crm tables in silver layer'
			PRINT '---------------------------------------------------------------------'

			SET @query_start_time = GETDATE();
			PRINT ''
			PRINT '>> Truncating Table : silver.crm_cust_info';
			TRUNCATE TABLE silver.crm_cust_info;
			PRINT '>> Loading Data into the table : silver.crm_cust_info';
			INSERT INTO silver.crm_cust_info 
			(
					cst_id 
				, cst_key
				, cst_firstname
				, cst_lastname
				, cst_gndr
				, cst_marital_status
				, cst_create_date
			)
			SELECT 
				  cst_id 
				, cst_key
				, TRIM(cst_firstname) AS cst_firstname  -- data consistency
				, TRIM(cst_lastname) AS cst_lastname -- data consistency
				, CASE 
					WHEN UPPER(TRIM(cst_gndr)) = 'F' THEN 'Female'
					WHEN UPPER(TRIM(cst_gndr)) = 'M' THEN 'Male'
					ELSE 'n/a'
					END as cst_gndr
				, CASE 
					WHEN UPPER(TRIM(cst_marital_status)) = 'S' THEN 'Single' -- data standardization
					WHEN UPPER(TRIM(cst_marital_status)) = 'M' THEN 'Married'  -- data standardization
					ELSE 'n/a'
					END as cst_marital_status
				, cst_create_date
			FROM 
			(
				SELECT 
					*,
					ROW_NUMBER() OVER(PARTITION BY cst_id ORDER BY cst_create_date DESC) as flag_last
				FROM bronze.crm_cust_info
				WHERE cst_id IS NOT NULL  -- Aremoving null values
			) T WHERE flag_last = 1; -- getting only the latest data for avoiding duplicates
			SET @query_end_time = GETDATE();
			PRINT 'Time taken to load data is : ' + CAST(DATEDIFF(SECOND, @query_start_time , @query_end_time) AS VARCHAR) + ' Second';

			SET @query_start_time = GETDATE();
			PRINT ''
			PRINT '>> Truncating Table : silver.crm_prd_info';
			TRUNCATE TABLE silver.crm_prd_info;
			PRINT '>> Loading Data into the table : silver.crm_prd_info';
			INSERT INTO silver.crm_prd_info  (
					prd_id
				, cat_id
				, prd_key
				, prd_nm
				, prd_cost
				, prd_line
				, prd_start_dt
				, prd_end_dt
			)
			SELECT 
					prd_id
				, REPLACE(LEFT(prd_key,5),'-','_') AS cat_id  -- derived colum
				, SUBSTRING(prd_key , 7 , LEN(prd_key)) AS prd_key  -- derived colum
				, prd_nm
				, ISNULL(prd_cost,0) AS prd_cost -- handling null values
				, CASE UPPER(TRIM(prd_line))
					WHEN 'M' THEN 'Mountain'
					WHEN 'R' THEN 'Road'
					WHEN 'S' THEN 'Other Sales'
					WHEN 'T' THEN 'Touring'
					END AS prd_line -- make the names descriptive
				, CAST(prd_start_dt AS DATE) AS prd_start_dt  -- type casting and enrichment
				, CAST(LEAD(prd_start_dt) OVER(PARTITION BY prd_key ORDER BY prd_start_dt)-1 AS DATE) as prd_end_dt
			FROM bronze.crm_prd_info;
			SET @query_end_time = GETDATE();
			PRINT 'Time taken to load data is : ' + CAST(DATEDIFF(SECOND, @query_start_time , @query_end_time) AS VARCHAR) + ' Second';


			SET @query_start_time = GETDATE();
			PRINT ''
			PRINT '>> Truncating Table : silver.crm_sales_details';
			TRUNCATE TABLE silver.crm_sales_details;
			PRINT '>> Loading Data into the table : silver.crm_sales_details';
			INSERT INTO silver.crm_sales_details(
	
					sls_ord_num
					, sls_prd_key
					, sls_cst_id
					, sls_ord_dt
					, sls_shp_dt
					, sls_due_dt
					, sls_sales
					, sls_quantity
					, sls_price

			)
			SELECT 
					sls_ord_num
				, sls_prd_key
				, sls_cst_id
				, CASE WHEN sls_ord_dt < 0 OR LEN(sls_ord_dt) != 8 THEN NULL ELSE CAST(CAST(sls_ord_dt AS varchar) AS DATE) END sls_ord_dt
 				, CASE WHEN sls_shp_dt < 0 OR LEN(sls_shp_dt) != 8 THEN NULL ELSE CAST(CAST(sls_shp_dt AS varchar) AS DATE) END sls_shp_dt
				, CASE WHEN sls_due_dt < 0 OR LEN(sls_due_dt) != 8 THEN NULL ELSE CAST(CAST(sls_due_dt AS varchar) AS DATE) END sls_due_dt
				, CASE 
					WHEN
						sls_sales IS NULL OR sls_sales <= 0 
						OR sls_sales != sls_quantity * ABS(sls_price) THEN  sls_quantity * sls_price
						ELSE sls_sales 
					END AS sls_sales
				, sls_quantity
				, CASE
					WHEN sls_price IS NULL OR sls_price <= 0
					THEN sls_sales / NULLIF(sls_quantity , 0)
					ELSE sls_price 
					END AS sls_price
			FROM bronze.crm_sales_details;
			SET @query_end_time = GETDATE();
			PRINT 'Time taken to load data is : ' + CAST(DATEDIFF(SECOND, @query_start_time , @query_end_time) AS VARCHAR) + ' Second';

			PRINT ''
			PRINT '---------------------------------------------------------------------'
			PRINT 'Loading data for erp tables in silver layer'
			PRINT '---------------------------------------------------------------------'

			SET @query_start_time = GETDATE()
			PRINT ''
			PRINT '>> Truncating Table : silver.erp_px_cat_g1v2';
			TRUNCATE TABLE silver.erp_px_cat_g1v2;
			PRINT '>> Loading Data into the table : silver.erp_px_cat_g1v2';
			INSERT INTO silver.erp_px_cat_g1v2 (
					id
				, cat
				, subcat
				, maintenance
			)
			SELECT 
					id
				, cat
				, subcat
				, maintenance
			FROM bronze.erp_px_cat_g1v2;
			SET @query_end_time = GETDATE();
			PRINT 'Time taken to load data is : ' + CAST(DATEDIFF(SECOND, @query_start_time , @query_end_time) AS VARCHAR) + ' Second';

			SET @query_start_time = GETDATE()
			PRINT ''
			PRINT '>> Truncating Table : silver.erp_cust_az12';
			TRUNCATE TABLE silver.erp_cust_az12;
			PRINT '>> Loading Data into the table : silver.erp_cust_az12';
			INSERT INTO silver.erp_cust_az12(
				cid,
				bdate,
				gen
			)
			SELECT 
					CASE 
						WHEN cid LIKE 'NAS%' THEN SUBSTRING(cid , 4 , LEN(cid)) 
						ELSE cid 
					END AS cid
				, CASE 
					WHEN bdate > GETDATE() THEN NULL ELSE bdate 
					END AS bdate
				, CASE 
						WHEN UPPER(TRIM(gen)) IN ('F','FEMALE') THEN 'Female'
						WHEN UPPER(TRIM(gen)) IN ('M','MALE') THEN 'Male'
					ELSE 'n/a' END AS gen
			FROM bronze.erp_cust_az12;
			SET @query_end_time = GETDATE();
			PRINT 'Time taken to load data is : ' + CAST(DATEDIFF(SECOND, @query_start_time , @query_end_time) AS VARCHAR) + ' Second';


			SET @query_start_time = GETDATE()
			PRINT ''
			PRINT '>> Truncating Table : silver.erp_loc_a101';
			TRUNCATE TABLE silver.erp_loc_a101;
			PRINT '>> Loading Data into the table : silver.erp_loc_a101';
			INSERT INTO silver.erp_loc_a101 (
					cid
				, cntry
			)
			SELECT 
					REPLACE(cid,'-','') AS cid -- formatting the cid
				, CASE	
					WHEN UPPER(TRIM(cntry)) IN ('US', 'UNITED STATES' , 'USA') THEN 'United States'
					WHEN UPPER(TRIM(cntry)) IN ('DE', 'GERMANY') THEN 'Germany'
					WHEN UPPER(TRIM(cntry)) IS NULL OR cntry = '' THEN 'n/a' 
					ELSE cntry -- data standardization
					END AS cntry
			FROM bronze.erp_loc_a101;
			SET @query_end_time = GETDATE();
			PRINT 'Time taken to load data is : ' + CAST(DATEDIFF(SECOND, @query_start_time , @query_end_time) AS VARCHAR) + ' Second';

			SET @load_end_time = GETDATE();
			PRINT ''
			PRINT 'Time taken for full load : ' + CAST(DATEDIFF(SECOND, @load_start_time , @load_end_time) AS VARCHAR) + ' Second';

		END TRY
		BEGIN CATCH
			PRINT '====================================================================='
			PRINT 'Error occured when loading data into silver layer'
			PRINT 'Error Message : ' + ERROR_MESSAGE()
			PRINT 'Error Number : ' + CAST(ERROR_NUMBER() AS VARCHAR)
			PRINT '====================================================================='
		END CATCH
	END;


EXEC silver.load_silver;