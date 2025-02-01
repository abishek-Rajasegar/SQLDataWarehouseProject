/***************************************************************************************
Script: Validation for `silver.erp_px_cat_g1v2` Table After Transformation
Purpose: This script validates the data quality of the `silver.erp_px_cat_g1v2` table after transformation.
         It checks for:
         1. Consistency with `silver.crm_prd_info` (matching `id` with `prd_key`).
         2. No nulls in the primary key (`id`).
         3. No unwanted spaces in string columns (`cat`, `subcat`, `maintenance`).
         4. Standardized and consistent values in categorical columns.
Expectations:
         - No mismatched IDs between `silver.erp_px_cat_g1v2` and `silver.crm_prd_info`.
         - No nulls in the primary key.
         - No spaces in string columns.
         - Standardized values in categorical columns.

***************************************************************************************/

-- Check for mismatched IDs between `silver.erp_px_cat_g1v2` and `silver.crm_prd_info`
-- Expectations: No results (all IDs should match)

SELECT 
    id,
    cat,
    subcat,
    maintenance
FROM silver.erp_px_cat_g1v2
WHERE id NOT IN (SELECT prd_key FROM silver.crm_prd_info); -- Check for mismatched IDs

---------------------------------------------------------------------------------------

-- Check for nulls in the primary key (`id`)
-- Expectations: No results (no nulls in the primary key)

SELECT 
    id,
    cat,
    subcat,
    maintenance
FROM silver.erp_px_cat_g1v2
WHERE id IS NULL; -- Check for nulls in the primary key

---------------------------------------------------------------------------------------

-- Check for unwanted spaces in `cat` column
-- Expectations: No results (no spaces in `cat` column)

SELECT 
    id,
    cat,
    subcat,
    maintenance
FROM silver.erp_px_cat_g1v2
WHERE cat != TRIM(cat); -- Check for spaces in `cat` column

---------------------------------------------------------------------------------------

-- Check for unwanted spaces in `subcat` column
-- Expectations: No results (no spaces in `subcat` column)

SELECT 
    id,
    cat,
    subcat,
    maintenance
FROM silver.erp_px_cat_g1v2
WHERE subcat != TRIM(subcat); -- Check for spaces in `subcat` column

---------------------------------------------------------------------------------------

-- Check for unwanted spaces in `maintenance` column
-- Expectations: No results (no spaces in `maintenance` column)

SELECT 
    id,
    cat,
    subcat,
    maintenance
FROM silver.erp_px_cat_g1v2
WHERE maintenance != TRIM(maintenance); -- Check for spaces in `maintenance` column

---------------------------------------------------------------------------------------

-- Check for standardized values in `cat` column
-- Expectations: Standardized values (e.g., no inconsistencies)

SELECT 
    DISTINCT cat
FROM silver.erp_px_cat_g1v2; -- Check for standardized values in `cat` column

---------------------------------------------------------------------------------------

-- Check for standardized values in `subcat` column
-- Expectations: Standardized values (e.g., no inconsistencies)

SELECT 
    DISTINCT subcat
FROM silver.erp_px_cat_g1v2; -- Check for standardized values in `subcat` column

---------------------------------------------------------------------------------------

-- Check for standardized values in `maintenance` column
-- Expectations: Standardized values (e.g., no inconsistencies)

SELECT 
    DISTINCT maintenance
FROM silver.erp_px_cat_g1v2; -- Check for standardized values in `maintenance` column