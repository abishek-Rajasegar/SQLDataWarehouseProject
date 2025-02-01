/***************************************************************************************
Script: Validation for `silver.crm_cust_info` Table After Transformation
Purpose: This script validates the data quality of the `silver.crm_cust_info` table after transformation.
         It checks for:
         1. No duplicates or nulls in the primary key (`cst_id`).
         2. No unwanted spaces in string columns (`cst_firstname`, `cst_lastname`, `cst_gndr`, `cst_marital_status`).
         3. Standardized and consistent values in categorical columns (`cst_gndr`, `cst_marital_status`).
Expectations:
         - No duplicates or nulls in the primary key.
         - No spaces in string columns.
         - Standardized values in categorical columns (e.g., "Male", "Female", "Single", "Married").

***************************************************************************************/

-- Check for nulls and duplicates in primary key in `silver.crm_cust_info`
-- Expectations: No results (no duplicates or nulls in the primary key)

SELECT 
    cst_id,
    COUNT(*) AS cst_count
FROM silver.crm_cust_info
GROUP BY cst_id
HAVING COUNT(*) > 1 OR cst_id IS NULL; -- Check for duplicates and nulls in the primary key

---------------------------------------------------------------------------------------

-- Check for nulls and unwanted spaces in `cst_firstname` column
-- Expectations: No results (no spaces in `cst_firstname` column)

SELECT 
    cst_firstname
FROM silver.crm_cust_info
WHERE cst_firstname != TRIM(cst_firstname); -- Check for spaces in `cst_firstname` column

---------------------------------------------------------------------------------------

-- Check for nulls and unwanted spaces in `cst_lastname` column
-- Expectations: No results (no spaces in `cst_lastname` column)

SELECT 
    cst_lastname
FROM silver.crm_cust_info
WHERE cst_lastname != TRIM(cst_lastname); -- Check for spaces in `cst_lastname` column

---------------------------------------------------------------------------------------

-- Check for nulls and unwanted spaces in `cst_gndr` column
-- Expectations: No results (no spaces in `cst_gndr` column)

SELECT 
    cst_gndr
FROM silver.crm_cust_info
WHERE cst_gndr != TRIM(cst_gndr); -- Check for spaces in `cst_gndr` column

---------------------------------------------------------------------------------------

-- Check for nulls and unwanted spaces in `cst_marital_status` column
-- Expectations: No results (no spaces in `cst_marital_status` column)

SELECT 
    cst_marital_status
FROM silver.crm_cust_info
WHERE cst_marital_status != TRIM(cst_marital_status); -- Check for spaces in `cst_marital_status` column

---------------------------------------------------------------------------------------

-- Check for standardized values in `cst_marital_status` column
-- Expectations: Standardized values (e.g., "Single", "Married", "Divorced", etc.)

SELECT 
    DISTINCT cst_marital_status
FROM silver.crm_cust_info; -- Ensure values are standardized and consistent

---------------------------------------------------------------------------------------

-- Check for standardized values in `cst_gndr` column
-- Expectations: Standardized values (e.g., "Male", "Female", "Other", etc.)

SELECT 
    DISTINCT cst_gndr
FROM silver.crm_cust_info; -- Ensure values are standardized and consistent