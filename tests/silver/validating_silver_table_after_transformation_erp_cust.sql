/***************************************************************************************
Script: Validation for `silver.erp_cust_az12` Table After Transformation
Purpose: This script validates the data quality of the `silver.erp_cust_az12` table after transformation.
         It checks for:
         1. Consistency with `silver.crm_cust_info` (matching `cid` with `cst_key`).
         2. No invalid dates in `bdate` column.
         3. No nulls in `gen` (gender) column.
Expectations:
         - No mismatched IDs between `silver.erp_cust_az12` and `silver.crm_cust_info`.
         - No invalid dates in `bdate` column.
         - No nulls in `gen` column.
Author: [Your Name]
Date: [Date]
***************************************************************************************/

-- Check for mismatched IDs between `silver.erp_cust_az12` and `silver.crm_cust_info`
-- Expectations: No results (all IDs should match)

SELECT 
    cid,
    bdate,
    gen
FROM silver.erp_cust_az12
WHERE cid NOT IN (SELECT cst_key FROM silver.crm_cust_info); -- Check for mismatched IDs

---------------------------------------------------------------------------------------

-- Check for invalid dates in `bdate` column
-- Expectations: No results (no future dates in `bdate` column)

SELECT 
    cid,
    bdate,
    gen
FROM silver.erp_cust_az12
WHERE bdate >= GETDATE(); -- Check for invalid dates

---------------------------------------------------------------------------------------

-- Check for nulls in `gen` (gender) column
-- Expectations: No results (no nulls in `gen` column)

SELECT 
    cid,
    bdate,
    gen
FROM silver.erp_cust_az12
WHERE gen IS NULL; -- Check for nulls in `gen` column