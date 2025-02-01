-- Data cleaning for crm_prd_info
TRUNCATE TABLE silver.crm_prd_info;
INSERT INTO silver.crm_prd_info  (
	  prd_id
	, cat_id
	, prd_key
	, prd_nm
	, prd_cost
	, prd_line
	, prd_start_dt
	, prd_end_dt
)
SELECT 
	  prd_id
	, REPLACE(LEFT(prd_key,5),'-','_') AS cat_id  -- derived colum
	, SUBSTRING(prd_key , 7 , LEN(prd_key)) AS prd_key  -- derived colum
	, prd_nm
	, ISNULL(prd_cost,0) AS prd_cost -- handling null values
	, CASE UPPER(TRIM(prd_line))
		WHEN 'M' THEN 'Mountain'
		WHEN 'R' THEN 'Road'
		WHEN 'S' THEN 'Other Sales'
		WHEN 'T' THEN 'Touring'
	 END AS prd_line -- make the names descriptive
	, CAST(prd_start_dt AS DATE) AS prd_start_dt  -- type casting and enrichment
	, CAST(LEAD(prd_start_dt) OVER(PARTITION BY prd_key ORDER BY prd_start_dt)-1 AS DATE) as prd_end_dt
FROM bronze.crm_prd_info
