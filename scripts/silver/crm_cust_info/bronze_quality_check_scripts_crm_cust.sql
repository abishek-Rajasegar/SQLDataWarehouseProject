/***************************************************************************************
Script: Data Quality Check for `bronze.crm_cust_info` Table
Purpose: This script performs data quality checks on the `bronze.crm_cust_info` table to ensure:
         1. No duplicates or nulls in the primary key (`cst_id`).
         2. No nulls or unwanted leading/trailing spaces in string columns.
         3. Standardized and consistent values in categorical columns (`cst_marital_status`, `cst_gndr`).
Expectations:
         - No duplicates or nulls in the primary key.
         - No nulls or spaces in string columns.
         - Standardized values in categorical columns (e.g., "Single", "Married", "Male", "Female").

***************************************************************************************/

-- Check for nulls and duplicates in primary key in crm_cust_info 
-- Expectations: No results (no duplicates or nulls in the primary key)

SELECT 
    cst_id,
    COUNT(*) AS cst_count
FROM bronze.crm_cust_info
GROUP BY cst_id
HAVING COUNT(*) > 1 OR cst_id IS NULL; -- Check for duplicates and nulls in the primary key

---------------------------------------------------------------------------------------

-- Check for nulls and unwanted spaces in string columns 
-- Expectations: No results (no nulls or spaces in string columns)

-- Check for cst_firstname
SELECT 
    cst_firstname
FROM bronze.crm_cust_info
WHERE cst_firstname IS NULL OR cst_firstname != TRIM(cst_firstname); -- Check for nulls and spaces

-- Check for cst_lastname
SELECT 
    cst_lastname
FROM bronze.crm_cust_info
WHERE cst_lastname IS NULL OR cst_lastname != TRIM(cst_lastname); -- Check for nulls and spaces

-- Check for cst_gndr (gender)
SELECT 
    cst_gndr
FROM bronze.crm_cust_info
WHERE cst_gndr IS NULL OR cst_gndr != TRIM(cst_gndr); -- Check for nulls and spaces

-- Check for cst_marital_status
SELECT 
    cst_marital_status
FROM bronze.crm_cust_info
WHERE cst_marital_status IS NULL OR cst_marital_status != TRIM(cst_marital_status); -- Check for nulls and spaces

---------------------------------------------------------------------------------------

-- Check data standardization and consistency for cst_marital_status
-- Expectations: Standardized values (e.g., "Single", "Married", "Divorced", etc.)

SELECT 
    DISTINCT cst_marital_status
FROM bronze.crm_cust_info; -- Ensure values are standardized and consistent

---------------------------------------------------------------------------------------

-- Check data standardization and consistency for cst_gndr (gender)
-- Expectations: Standardized values (e.g., "Male", "Female", "Other", etc.)

SELECT 
    DISTINCT cst_gndr
FROM bronze.crm_cust_info; -- Ensure values are standardized and consistent