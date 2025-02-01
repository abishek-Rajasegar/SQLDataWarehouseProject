-- Check for nulls and duplicates in primary key in crm_prd_info 
-- Expectations : No results

	SELECT 
		prd_id,
		COUNT(*) as cst_count
	FROM bronze.crm_prd_info
	GROUP BY prd_id
	HAVING COUNT(*) > 1 OR prd_id IS NULL ; -- There are no duplicate and null in PK
	
---------------------------------------------------------------------------------------

-- Check for nulls and unwanted spaces in string columns 
-- Expectations : No results
	
	SELECT 
		prd_cost
	FROM bronze.crm_prd_info
	WHERE prd_cost IS NULL OR prd_cost < 0 --- there are null in prd cost
	
---------------------------------------------------------------------------------------

-- Check for nulls and unwanted spaces in string columns 
-- Expectations : No results
	
	SELECT 
	    DISTINCT prd_line
	FROM bronze.crm_prd_info -- use full form
	
---------------------------------------------------------------------------------------

-- Check for nulls and unwanted spaces in string columns 
-- Expectations : No results
	
	SELECT 
		*
	FROM bronze.crm_prd_info
	WHERE prd_end_dt < prd_start_dt -- there a dates where end date is smaller then start date
	
