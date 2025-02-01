/***************************************************************************************
Script: Data Cleaning and Insertion for `bronze.erp_loc_a101` into `silver.erp_loc_a101`
Purpose: This script cleans the data from the `bronze.erp_loc_a101` table and inserts it into the `silver.erp_loc_a101` table.
         Cleaning steps include:
         1. Formatting `cid` column by removing hyphens.
         2. Standardizing values in `cntry` (country) column.
Expectations:
         - Cleaned and standardized data in the `silver.erp_loc_a101` table.
         - No nulls or blanks in `cntry` column.
         - Standardized values in `cntry` column.

***************************************************************************************/

-- Data cleaning for erp_loc_a101
TRUNCATE TABLE silver.erp_loc_a101;
INSERT INTO silver.erp_loc_a101 (
    cid,
    cntry
)
SELECT 
    REPLACE(cid, '-', '') AS cid, -- Remove hyphens from `cid`
    CASE 
        WHEN UPPER(TRIM(cntry)) IN ('US', 'UNITED STATES', 'USA') THEN 'United States'
        WHEN UPPER(TRIM(cntry)) IN ('DE', 'GERMANY') THEN 'Germany'
        WHEN UPPER(TRIM(cntry)) IS NULL OR cntry = '' THEN 'n/a'
        ELSE cntry 
    END AS cntry -- Standardize country values
FROM bronze.erp_loc_a101;