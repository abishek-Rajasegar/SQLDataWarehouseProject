-- quality checking for silver.erp_px_cat_g1v2

	SELECT 
		   id
		 , cat
		 , subcat
		 , maintenance
	FROM silver.erp_px_cat_g1v2
	WHERE id not in (select prd_key from silver.crm_prd_info) --- these ids are not matching

---------------------------------------------------------------------------------------
-- check null in id

	SELECT 
		   id
		 , cat
		 , subcat
		 , maintenance
	FROM silver.erp_px_cat_g1v2
	WHERE id IS NULL -- there are no null cid

---------------------------------------------------------------------------------------
-- checking for null in cat columns
	SELECT 
		   id
		 , cat
		 , subcat
		 , maintenance
	FROM silver.erp_px_cat_g1v2
	WHERE cat != TRIM(cat) --- thre are no extra spaces

---------------------------------------------------------------------------------------
-- checking for quality of subcat columns
	
	SELECT 
		   id
		 , cat
		 , subcat
		 , maintenance
	FROM silver.erp_px_cat_g1v2
	WHERE subcat != TRIM(subcat) --- thre are no extra spaces

---------------------------------------------------------------------------------------
-- checking for quality of subcat columns
	
	SELECT 
		   id
		 , cat
		 , subcat
		 , maintenance
	FROM silver.erp_px_cat_g1v2
	WHERE maintenance != TRIM(maintenance) --- thre are no extra spaces

---------------------------------------------------------------------------------------
-- checking for quality of cat columns
	
	SELECT 
		   DISTINCT cat
	FROM silver.erp_px_cat_g1v2 --- the quality is good

---------------------------------------------------------------------------------------
-- checking for quality of subcat columns
	
	SELECT 
		   DISTINCT subcat
	FROM silver.erp_px_cat_g1v2 --- the quality is good

---------------------------------------------------------------------------------------
-- checking for quality of maintenance columns
	
	SELECT 
		   DISTINCT maintenance
	FROM silver.erp_px_cat_g1v2 --- the quality is good