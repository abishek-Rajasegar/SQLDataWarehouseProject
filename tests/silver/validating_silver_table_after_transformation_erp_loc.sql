-- Check for nulls and duplicates in primary key in erp_loc_a101 
-- Expectations : No results

	SELECT 
		   cid 
		 , cntry
	FROM silver.erp_loc_a101
	WHERE cid not in (select cst_key from silver.crm_cust_info) --- these ids are matcing

---------------------------------------------------------------------------------------
-- check null in cid

	SELECT 
		   cid 
		 , cntry
	FROM silver.erp_loc_a101
	WHERE cid is null  -- there are no null cid

---------------------------------------------------------------------------------------
-- checking for null in cntry columns
	
	SELECT 
		   cid 
		 , cntry
	FROM silver.erp_loc_a101
	WHERE cntry is null  -- there are no null cntry

---------------------------------------------------------------------------------------
-- checking for quality of cntry columns
	
	SELECT 
		  DISTINCT cntry
	FROM silver.erp_loc_a101 -- The data quality if good
