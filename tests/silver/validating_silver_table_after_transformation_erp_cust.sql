-- Check for nulls and duplicates in primary key in erp_cust_az12 
-- Expectations : No results

	SELECT 
		  cid 
		, bdate
		, gen
	FROM silver.erp_cust_az12
	WHERE cid not in (select cst_key from silver.crm_cust_info) --- these ids are matcing because of NAS

---------------------------------------------------------------------------------------
-- check for wrong dates in bdate column

	SELECT 
		  cid 
		, bdate
		, gen
	FROM silver.erp_cust_az12
	WHERE bdate >= GETDATE()  -- there are not future bdate

---------------------------------------------------------------------------------------
-- checking for null in gender columns
	SELECT 
		  cid 
		, bdate
		, gen
	FROM silver.erp_cust_az12
	WHERE gen IS NULL  --- There are no null values