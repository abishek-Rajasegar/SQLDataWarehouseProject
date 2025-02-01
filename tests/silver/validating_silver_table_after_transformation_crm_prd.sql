/***************************************************************************************
Script: Validation for `silver.crm_prd_info` Table After Transformation
Purpose: This script validates the data quality of the `silver.crm_prd_info` table after transformation.
         It checks for:
         1. No duplicates or nulls in the primary key (`prd_id`).
         2. No nulls or invalid values in numeric columns (`prd_cost`).
         3. No invalid date ranges (`prd_end_dt` >= `prd_start_dt`).
         4. Standardized and consistent values in categorical columns (`prd_line`).
Expectations:
         - No duplicates or nulls in the primary key.
         - No nulls or negative values in `prd_cost`.
         - Valid date ranges (`prd_end_dt` >= `prd_start_dt`).
         - Standardized values in `prd_line` (e.g., "Mountain", "Road", etc.).

***************************************************************************************/

-- Check for nulls and duplicates in primary key in `silver.crm_prd_info`
-- Expectations: No results (no duplicates or nulls in the primary key)

SELECT 
    prd_id,
    COUNT(*) AS prd_count
FROM silver.crm_prd_info
GROUP BY prd_id
HAVING COUNT(*) > 1 OR prd_id IS NULL; -- Check for duplicates and nulls in the primary key

---------------------------------------------------------------------------------------

-- Check for nulls and invalid values in `prd_cost` column
-- Expectations: No results (no nulls or negative values in `prd_cost`)

SELECT 
    prd_cost
FROM silver.crm_prd_info
WHERE prd_cost IS NULL OR prd_cost < 0; -- Check for nulls and negative values

---------------------------------------------------------------------------------------

-- Check for standardized values in `prd_line` column
-- Expectations: Standardized values (e.g., "Mountain", "Road", etc.)

SELECT 
    DISTINCT prd_line
FROM silver.crm_prd_info; -- Ensure values are standardized and consistent

---------------------------------------------------------------------------------------

-- Check for invalid date ranges (`prd_end_dt` < `prd_start_dt`)
-- Expectations: No results (valid date ranges)

SELECT 
    *
FROM silver.crm_prd_info
WHERE prd_end_dt < prd_start_dt; -- Check for invalid date ranges