/***************************************************************************************
Script: Data Cleaning and Insertion for `bronze.erp_cust_az12` into `silver.erp_cust_az12`
Purpose: This script cleans the data from the `bronze.erp_cust_az12` table and inserts it into the `silver.erp_cust_az12` table.
         Cleaning steps include:
         1. Removing "NAS" prefix from `cid` column.
         2. Handling invalid dates in `bdate` column.
         3. Standardizing values in `gen` (gender) column.
Expectations:
         - Cleaned and standardized data in the `silver.erp_cust_az12` table.
         - No invalid dates in `bdate` column.
         - Standardized values in `gen` column.
***************************************************************************************/

-- Data cleaning for erp_cust_az12
TRUNCATE TABLE silver.erp_cust_az12;
INSERT INTO silver.erp_cust_az12 (
    cid,
    bdate,
    gen
)
SELECT 
    CASE 
        WHEN cid LIKE 'NAS%' THEN SUBSTRING(cid, 4, LEN(cid)) 
        ELSE cid 
    END AS cid, -- Remove "NAS" prefix
    CASE 
        WHEN bdate > GETDATE() THEN NULL 
        ELSE bdate 
    END AS bdate, -- Handle invalid dates
    CASE 
        WHEN UPPER(TRIM(gen)) IN ('F', 'FEMALE') THEN 'Female'
        WHEN UPPER(TRIM(gen)) IN ('M', 'MALE') THEN 'Male'
        ELSE 'n/a' 
    END AS gen -- Standardize gender values
FROM bronze.erp_cust_az12;