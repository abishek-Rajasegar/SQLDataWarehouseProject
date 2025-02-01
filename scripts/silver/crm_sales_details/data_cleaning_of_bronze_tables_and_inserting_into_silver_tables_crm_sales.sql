-- Data cleaning for crm_sales_details

TRUNCATE TABLE silver.crm_sales_details;
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