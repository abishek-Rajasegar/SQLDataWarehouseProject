-- Data cleaning for crm_cust_info
TRUNCATE TABLE silver.crm_cust_info;
INSERT INTO silver.crm_cust_info 
(
	  cst_id 
	, cst_key
	, cst_firstname
	, cst_lastname
	, cst_gndr
	, cst_marital_status
	, cst_create_date
)
SELECT 
	  cst_id 
	, cst_key
	, TRIM(cst_firstname) AS cst_firstname  -- data consistency
	, TRIM(cst_lastname) AS cst_lastname -- data consistency
	, CASE 
		WHEN UPPER(TRIM(cst_gndr)) = 'F' THEN 'Female'
		WHEN UPPER(TRIM(cst_gndr)) = 'M' THEN 'Male'
		ELSE 'n/a'
		END as cst_gndr
	, CASE 
		WHEN UPPER(TRIM(cst_marital_status)) = 'S' THEN 'Single' -- data standardization
		WHEN UPPER(TRIM(cst_marital_status)) = 'M' THEN 'Married'  -- data standardization
		ELSE 'n/a'
		END as cst_marital_status
	, cst_create_date
FROM 
(
	SELECT 
		*,
		ROW_NUMBER() OVER(PARTITION BY cst_id ORDER BY cst_create_date DESC) as flag_last
	FROM bronze.crm_cust_info
	WHERE cst_id IS NOT NULL  -- Aremoving null values
) T WHERE flag_last = 1; -- getting only the latest data for duplicates

----------------------------------------------------------------------------------------------
-- Data cleaning for crm_prd_info



