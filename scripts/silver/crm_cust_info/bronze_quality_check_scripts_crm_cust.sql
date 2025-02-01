-- Check for nulls and duplicates in primary key in crm_cust_info 
-- Expectations : No results

	SELECT 
		cst_id,
		COUNT(*) as cst_count
	FROM bronze.crm_cust_info
	GROUP BY cst_id
	HAVING COUNT(*) > 1 OR cst_id IS NULL ; -- There are duplicate and null in PK
	
---------------------------------------------------------------------------------------

-- Check for nulls and unwanted spaces in string columns 
-- Expectations : No results
	
	SELECT 
		cst_firstname
	FROM bronze.crm_cust_info
	WHERE cst_firstname != TRIM(cst_firstname); --- space is there
	
---------------------------------------------------------------------------------------

-- Check for nulls and unwanted spaces in string columns 
-- Expectations : No results
	
	SELECT 
		cst_lastname
	FROM bronze.crm_cust_info
	WHERE cst_lastname != TRIM(cst_lastname); --- space is there
	
---------------------------------------------------------------------------------------

-- Check for nulls and unwanted spaces in string columns 
-- Expectations : No results
	
	SELECT 
		cst_gndr
	FROM bronze.crm_cust_info
	WHERE cst_gndr != TRIM(cst_gndr); --- space is not there

---------------------------------------------------------------------------------------

-- Check for nulls and unwanted spaces in string columns 
-- Expectations : No results
	
	SELECT 
		cst_marital_status
	FROM bronze.crm_cust_info
	WHERE cst_marital_status != TRIM(cst_marital_status); --- space is not there

---------------------------------------------------------------------------------------

-- Check data standardization and Consistency

	SELECT 
		DISTINCT cst_marital_status
	FROM bronze.crm_cust_info -- Always use full name 

---------------------------------------------------------------------------------------

-- Check data standardization and Consistency

	SELECT 
		DISTINCT cst_gndr
	FROM bronze.crm_cust_info  -- Always use full name 


