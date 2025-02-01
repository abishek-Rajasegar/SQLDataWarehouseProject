/***************************************************************************************
Script: Data Quality Check for `bronze.erp_px_cat_g1v2` Table
Purpose: This script performs data quality checks on the `bronze.erp_px_cat_g1v2` table to ensure:
         1. Consistency with `silver.crm_prd_info` (matching `id` with `prd_key`).
         2. No nulls in the primary key (`id`).
         3. No unwanted spaces in string columns (`cat`, `subcat`, `maintenance`).
         4. Standardized and consistent values in categorical columns.
Expectations:
         - No mismatched IDs between `bronze.erp_px_cat_g1v2` and `silver.crm_prd_info`.
         - No nulls in the primary key.
         - No spaces in string columns.
         - Standardized values in categorical columns.

***************************************************************************************/

-- Check if the ids of silver.crm_prd_info are present in bronze.erp_px_cat_g1v2
-- Expectations: No results (all IDs should match)

SELECT 
    id,
    cat,
    subcat,
    maintenance
FROM bronze.erp_px_cat_g1v2
WHERE id NOT IN (SELECT prd_key FROM silver.crm_prd_info); -- Check for mismatched IDs

---------------------------------------------------------------------------------------

-- Check for nulls in the primary key (`id`)
-- Expectations: No results (no nulls in the primary key)

SELECT 
    id,
    cat,
    subcat,
    maintenance
FROM bronze.erp_px_cat_g1v2
WHERE id IS NULL; -- Check for nulls in the primary key

---------------------------------------------------------------------------------------

-- Check for unwanted spaces in `cat` column
-- Expectations: No results (no spaces in `cat` column)

SELECT 
    id,
    cat,
    subcat,
    maintenance
FROM bronze.erp_px_cat_g1v2
WHERE cat != TRIM(cat); -- Check for spaces in `cat` column

---------------------------------------------------------------------------------------

-- Check for unwanted spaces in `subcat` column
-- Expectations: No results (no spaces in `subcat` column)

SELECT 
    id,
    cat,
    subcat,
    maintenance
FROM bronze.erp_px_cat_g1v2
WHERE subcat != TRIM(subcat); -- Check for spaces in `subcat` column

---------------------------------------------------------------------------------------

-- Check for unwanted spaces in `maintenance` column
-- Expectations: No results (no spaces in `maintenance` column)

SELECT 
    id,
    cat,
    subcat,
    maintenance
FROM bronze.erp_px_cat_g1v2
WHERE maintenance != TRIM(maintenance); -- Check for spaces in `maintenance` column

---------------------------------------------------------------------------------------

-- Check for standardized values in `cat` column
-- Expectations: Standardized values (e.g., no inconsistencies)

SELECT 
    DISTINCT cat
FROM bronze.erp_px_cat_g1v2; -- Check for standardized values in `cat` column

---------------------------------------------------------------------------------------

-- Check for standardized values in `subcat` column
-- Expectations: Standardized values (e.g., no inconsistencies)

SELECT 
    DISTINCT subcat
FROM bronze.erp_px_cat_g1v2; -- Check for standardized values in `subcat` column

---------------------------------------------------------------------------------------

-- Check for standardized values in `maintenance` column
-- Expectations: Standardized values (e.g., no inconsistencies)

SELECT 
    DISTINCT maintenance
FROM bronze.erp_px_cat_g1v2; -- Check for standardized values in `maintenance` column