/***************************************************************************************
Script: Data Cleaning and Insertion for `bronze.erp_px_cat_g1v2` into `silver.erp_px_cat_g1v2`
Purpose: This script cleans the data from the `bronze.erp_px_cat_g1v2` table and inserts it into the `silver.erp_px_cat_g1v2` table.
         Cleaning steps include:
         1. Trimming whitespace from string columns.
         2. Ensuring no null values in the primary key (`id`).
Expectations:
         - Cleaned and standardized data in the `silver.erp_px_cat_g1v2` table.
         - No nulls in the primary key.

***************************************************************************************/

-- Data cleaning for erp_px_cat_g1v2
TRUNCATE TABLE silver.erp_px_cat_g1v2;
INSERT INTO silver.erp_px_cat_g1v2 (
    id,
    cat,
    subcat,
    maintenance
)
SELECT 
    id,
    TRIM(cat) AS cat,          -- Trim whitespace
    TRIM(subcat) AS subcat,    -- Trim whitespace
    TRIM(maintenance) AS maintenance -- Trim whitespace
FROM bronze.erp_px_cat_g1v2;