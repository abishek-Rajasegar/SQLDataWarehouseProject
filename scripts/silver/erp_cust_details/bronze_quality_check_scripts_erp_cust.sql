-- Check for nulls and duplicates in primary key in erp_cust_az12 
-- Expectations : No results

	SELECT 
		  cid 
		, bdate
		, gen
	FROM bronze.erp_cust_az12
	WHERE cid not in (select cst_key from silver.crm_cust_info) --- these ids are not matcing because of NAS

---------------------------------------------------------------------------------------
-- check for wrong dates in bdate column

	SELECT 
		  cid 
		, bdate
		, gen
	FROM bronze.erp_cust_az12
	WHERE bdate >= GETDATE()

---------------------------------------------------------------------------------------
-- checking for null in gender columns
	SELECT 
		  cid 
		, bdate
		, gen
	FROM bronze.erp_cust_az12
	WHERE gen IS NULL  --- There are null values