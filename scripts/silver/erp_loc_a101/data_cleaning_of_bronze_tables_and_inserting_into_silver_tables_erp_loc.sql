-- Data cleaning for crp_cust
TRUNCATE TABLE silver.erp_loc_a101;
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





