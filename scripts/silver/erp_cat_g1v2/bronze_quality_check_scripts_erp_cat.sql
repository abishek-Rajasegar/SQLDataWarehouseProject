-- Check if the ids of silver.crm_prd_info is present in bronze.erp_px_cat_g1v2
-- Expectations : No results
	
	SELECT 
		   id
		 , cat
		 , subcat
		 , maintenance
	FROM bronze.erp_px_cat_g1v2
	WHERE id not in (select prd_key from silver.crm_prd_info) --- these ids are not matching

---------------------------------------------------------------------------------------
-- check null in id

	SELECT 
		   id
		 , cat
		 , subcat
		 , maintenance
	FROM bronze.erp_px_cat_g1v2
	WHERE id IS NULL -- there are no null cid

---------------------------------------------------------------------------------------
-- checking for null in cat columns
	SELECT 
		   id
		 , cat
		 , subcat
		 , maintenance
	FROM bronze.erp_px_cat_g1v2
	WHERE cat != TRIM(cat) --- thre are no extra spaces

---------------------------------------------------------------------------------------
-- checking for quality of subcat columns
	
	SELECT 
		   id
		 , cat
		 , subcat
		 , maintenance
	FROM bronze.erp_px_cat_g1v2
	WHERE subcat != TRIM(subcat) --- thre are no extra spaces

---------------------------------------------------------------------------------------
-- checking for quality of subcat columns
	
	SELECT 
		   id
		 , cat
		 , subcat
		 , maintenance
	FROM bronze.erp_px_cat_g1v2
	WHERE maintenance != TRIM(maintenance) --- thre are no extra spaces

---------------------------------------------------------------------------------------
-- checking for quality of cat columns
	
	SELECT 
		   DISTINCT cat
	FROM bronze.erp_px_cat_g1v2 --- the quality is good

---------------------------------------------------------------------------------------
-- checking for quality of subcat columns
	
	SELECT 
		   DISTINCT subcat
	FROM bronze.erp_px_cat_g1v2 --- the quality is good

---------------------------------------------------------------------------------------
-- checking for quality of maintenance columns
	
	SELECT 
		   DISTINCT maintenance
	FROM bronze.erp_px_cat_g1v2 --- the quality is good