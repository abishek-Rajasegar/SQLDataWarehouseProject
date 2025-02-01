/***************************************************************************************
Script: Data Cleaning and Insertion for `bronze.crm_cust_info` into `silver.crm_cust_info`
Purpose: This script cleans the data from the `bronze.crm_cust_info` table and inserts it into the `silver.crm_cust_info` table.
         Cleaning steps include:
         1. Trimming whitespace from string columns.
         2. Standardizing categorical values (e.g., "F" to "Female", "M" to "Male").
         3. Removing duplicates by keeping the latest record based on `cst_create_date`.
         4. Ensuring no null values in the primary key (`cst_id`).
Expectations:
         - Cleaned and standardized data in the `silver.crm_cust_info` table.
         - No duplicates or nulls in the primary key.

***************************************************************************************/

-- Data cleaning for crm_cust_info
TRUNCATE TABLE silver.crm_cust_info;
INSERT INTO silver.crm_cust_info 
(
    cst_id,
    cst_key,
    cst_firstname,
    cst_lastname,
    cst_gndr,
    cst_marital_status,
    cst_create_date
)
SELECT 
    cst_id,
    cst_key,
    TRIM(cst_firstname) AS cst_firstname,  -- Trim whitespace
    TRIM(cst_lastname) AS cst_lastname,    -- Trim whitespace
    CASE 
        WHEN UPPER(TRIM(cst_gndr)) = 'F' THEN 'Female'
        WHEN UPPER(TRIM(cst_gndr)) = 'M' THEN 'Male'
        ELSE 'n/a'
    END AS cst_gndr,                       -- Standardize gender values
    CASE 
        WHEN UPPER(TRIM(cst_marital_status)) = 'S' THEN 'Single'
        WHEN UPPER(TRIM(cst_marital_status)) = 'M' THEN 'Married'
        ELSE 'n/a'
    END AS cst_marital_status,             -- Standardize marital status values
    cst_create_date
FROM 
(
    SELECT 
        *,
        ROW_NUMBER() OVER(PARTITION BY cst_id ORDER BY cst_create_date DESC) AS flag_last
    FROM bronze.crm_cust_info
    WHERE cst_id IS NOT NULL  -- Remove null values in primary key
) T 
WHERE flag_last = 1; -- Keep only the latest record for duplicates