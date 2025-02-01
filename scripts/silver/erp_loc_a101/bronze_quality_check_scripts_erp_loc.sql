/***************************************************************************************
Script: Data Quality Check for `bronze.erp_loc_a101` Table
Purpose: This script performs data quality checks on the `bronze.erp_loc_a101` table to ensure:
         1. Consistency with `silver.crm_cust_info` (matching `cid` with `cst_key`).
         2. No nulls in the primary key (`cid`).
         3. No nulls or blanks in `cntry` (country) column.
         4. Standardized values in `cntry` column.
Expectations:
         - No mismatched IDs between `bronze.erp_loc_a101` and `silver.crm_cust_info`.
         - No nulls in the primary key.
         - No nulls or blanks in `cntry` column.
         - Standardized values in `cntry` column.
Author: [Your Name]
Date: [Date]
***************************************************************************************/

-- Check for mismatched IDs between `bronze.erp_loc_a101` and `silver.crm_cust_info`
-- Expectations: No results (all IDs should match)

SELECT 
    cid,
    cntry
FROM bronze.erp_loc_a101
WHERE cid NOT IN (SELECT cst_key FROM silver.crm_cust_info); -- Check for mismatched IDs

---------------------------------------------------------------------------------------

-- Check for nulls in the primary key (`cid`)
-- Expectations: No results (no nulls in the primary key)

SELECT 
    cid,
    cntry
FROM bronze.erp_loc_a101
WHERE cid IS NULL; -- Check for nulls in the primary key

---------------------------------------------------------------------------------------

-- Check for nulls or blanks in `cntry` column
-- Expectations: No results (no nulls or blanks in `cntry` column)

SELECT 
    cid,
    cntry
FROM bronze.erp_loc_a101
WHERE cntry IS NULL OR cntry = ''; -- Check for nulls or blanks in `cntry` column

---------------------------------------------------------------------------------------

-- Check for standardized values in `cntry` column
-- Expectations: Standardized values (e.g., no inconsistencies)

SELECT 
    DISTINCT cntry
FROM bronze.erp_loc_a101; -- Check for standardized values in `cntry` column