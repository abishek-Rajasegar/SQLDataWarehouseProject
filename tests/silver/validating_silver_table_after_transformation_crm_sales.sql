-- Check for nulls and duplicates in primary key in crm_cust_info 
-- Expectations : No results

	SELECT 
		  sls_ord_num
		, sls_prd_key
		, sls_cst_id
		, sls_ord_dt
		, sls_shp_dt
		, sls_due_dt
		, sls_sales
		, sls_quantity
		, sls_price
	FROM silver.crm_sales_details
	WHERE sls_ord_num != TRIM(sls_ord_num); -- There are no blanks in the rows 
	
---------------------------------------------------------------------------------------

-- Check for unwanted data table
-- Expectations : No results

	SELECT 
		  sls_ord_num
		, sls_prd_key
		, sls_cst_id
		, sls_ord_dt
		, sls_shp_dt
		, sls_due_dt
		, sls_sales
		, sls_quantity
		, sls_price
	FROM silver.crm_sales_details
	WHERE sls_prd_key NOT IN (SELECT prd_key FROM silver.crm_prd_info);  -- both tables have same key 
	
---------------------------------------------------------------------------------------

-- Check for unwanted data table
-- Expectations : No results

	SELECT 
		  sls_ord_num
		, sls_prd_key
		, sls_cst_id
		, sls_ord_dt
		, sls_shp_dt
		, sls_due_dt
		, sls_sales
		, sls_quantity
		, sls_price
	FROM silver.crm_sales_details
	WHERE sls_cst_id NOT IN (SELECT cst_id FROM silver.crm_cust_info);  -- both tables have same key
	
---------------------------------------------------------------------------------------

-- Check for quauity of date column
-- Expectations : quality should be correct
	
	SELECT 
		  sls_ord_num
		, sls_prd_key
		, sls_cst_id
		, sls_ord_dt
		, sls_shp_dt
		, sls_due_dt
		, sls_sales
		, sls_quantity
		, sls_price
	FROM silver.crm_sales_details
	WHERE 
		sls_shp_dt < 0 
		OR LEN(sls_shp_dt) != 8
		OR sls_shp_dt > 20500101
		OR sls_shp_dt < 19000101; -- there are zeros in the date


---------------------------------------------------------------------------------------

-- Check for correctness of date column
-- Expectations : quality should be correct

	SELECT 
		  sls_ord_num
		, sls_prd_key
		, sls_cst_id
		, sls_ord_dt
		, sls_shp_dt
		, sls_due_dt
		, sls_sales
		, sls_quantity
		, sls_price
	FROM silver.crm_sales_details
	WHERE 
		sls_shp_dt < sls_ord_dt OR sls_ord_dt > sls_due_dt  -- no issues


---------------------------------------------------------------------------------------

	SELECT 
	 sls_ord_num
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
	ELSE sls_price END AS sls_price
	FROM silver.crm_sales_details
	WHERE sls_sales != sls_quantity * sls_price -- there are null values