/***************************************************************************************
Script: Validation for `silver.crm_sales_details` Table After Transformation
Purpose: This script validates the data quality of the `silver.crm_sales_details` table after transformation.
         It checks for:
         1. No nulls or invalid values in key columns (`sls_ord_num`, `sls_prd_key`, `sls_cst_id`).
         2. Consistency with related tables (`silver.crm_prd_info`, `silver.crm_cust_info`).
         3. Valid date ranges (`sls_shp_dt` >= `sls_ord_dt`, `sls_due_dt` >= `sls_ord_dt`).
         4. Correctness of numeric calculations (`sls_sales` = `sls_quantity` * `sls_price`).
Expectations:
         - No nulls or invalid values in key columns.
         - Consistency with related tables.
         - Valid date ranges and numeric calculations.

***************************************************************************************/

-- Check for nulls and invalid values in key columns
-- Expectations: No results (no nulls or invalid values)

SELECT 
    sls_ord_num,
    sls_prd_key,
    sls_cst_id,
    sls_ord_dt,
    sls_shp_dt,
    sls_due_dt,
    sls_sales,
    sls_quantity,
    sls_price
FROM silver.crm_sales_details
WHERE sls_ord_num IS NULL OR sls_prd_key IS NULL OR sls_cst_id IS NULL; -- Check for nulls in key columns

---------------------------------------------------------------------------------------

-- Check for consistency with `silver.crm_prd_info`
-- Expectations: No results (all `sls_prd_key` values should exist in `silver.crm_prd_info`)

SELECT 
    sls_ord_num,
    sls_prd_key,
    sls_cst_id,
    sls_ord_dt,
    sls_shp_dt,
    sls_due_dt,
    sls_sales,
    sls_quantity,
    sls_price
FROM silver.crm_sales_details
WHERE sls_prd_key NOT IN (SELECT prd_key FROM silver.crm_prd_info); -- Check consistency with `silver.crm_prd_info`

---------------------------------------------------------------------------------------

-- Check for consistency with `silver.crm_cust_info`
-- Expectations: No results (all `sls_cst_id` values should exist in `silver.crm_cust_info`)

SELECT 
    sls_ord_num,
    sls_prd_key,
    sls_cst_id,
    sls_ord_dt,
    sls_shp_dt,
    sls_due_dt,
    sls_sales,
    sls_quantity,
    sls_price
FROM silver.crm_sales_details
WHERE sls_cst_id NOT IN (SELECT cst_id FROM silver.crm_cust_info); -- Check consistency with `silver.crm_cust_info`

---------------------------------------------------------------------------------------

-- Check for valid date ranges
-- Expectations: No results (valid date ranges)

SELECT 
    sls_ord_num,
    sls_prd_key,
    sls_cst_id,
    sls_ord_dt,
    sls_shp_dt,
    sls_due_dt,
    sls_sales,
    sls_quantity,
    sls_price
FROM silver.crm_sales_details
WHERE sls_shp_dt < sls_ord_dt OR sls_ord_dt > sls_due_dt; -- Check for invalid date ranges

---------------------------------------------------------------------------------------

-- Check for correctness of numeric calculations
-- Expectations: No results (correct calculations)

SELECT 
    sls_ord_num,
    CASE 
        WHEN sls_sales IS NULL OR sls_sales <= 0 OR sls_sales != sls_quantity * ABS(sls_price) 
        THEN sls_quantity * sls_price
        ELSE sls_sales 
    END AS sls_sales,
    sls_quantity,
    CASE
        WHEN sls_price IS NULL OR sls_price <= 0
        THEN sls_sales / NULLIF(sls_quantity, 0)
        ELSE sls_price 
    END AS sls_price
FROM silver.crm_sales_details
WHERE sls_sales != sls_quantity * sls_price; -- Check for incorrect calculations