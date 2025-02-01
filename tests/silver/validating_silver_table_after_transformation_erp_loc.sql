/***************************************************************************************
Script: Validation for `silver.erp_loc_a101` Table After Transformation
Purpose: This script validates the data quality of the `silver.erp_loc_a101` table after transformation.
         It checks for:
         1. Consistency with `silver.crm_cust_info` (matching `cid` with `cst_key`).
         2. No nulls in the primary key (`cid`).
         3. No nulls or blanks in `cntry` (country) column.
         4. Standardized values in `cntry` column.
Expectations:
         - No mismatched IDs between `silver.erp_loc_a101` and `silver.crm_cust_info`.
         - No nulls in the primary key.
         - No nulls or blanks in `cntry` column.
         - Standardized values in `cntry` column.

***************************************************************************************/

-- Check for mismatched IDs between `silver.erp_loc_a101` and `silver.crm_cust_info`
-- Expectations: No results (all IDs should match)

SELECT 
    cid,
    cntry
FROM silver.erp_loc_a101
WHERE cid NOT IN (SELECT cst_key FROM silver.crm_cust_info); -- Check for mismatched IDs

---------------------------------------------------------------------------------------

-- Check for nulls in the primary key (`cid`)
-- Expectations: No results (no nulls in the primary key)

SELECT 
    cid,
    cntry
FROM silver.erp_loc_a101
WHERE cid IS NULL; -- Check for nulls in the primary key

---------------------------------------------------------------------------------------

-- Check for nulls or blanks in `cntry` column
-- Expectations: No results (no nulls or blanks in `cntry` column)

SELECT 
    cid,
    cntry
FROM silver.erp_loc_a101
WHERE cntry IS NULL OR cntry = ''; -- Check for nulls or blanks in `cnt