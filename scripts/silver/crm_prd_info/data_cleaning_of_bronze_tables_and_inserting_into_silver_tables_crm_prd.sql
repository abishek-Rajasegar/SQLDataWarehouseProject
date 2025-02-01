/***************************************************************************************
Script: Data Cleaning and Insertion for `bronze.crm_prd_info` into `silver.crm_prd_info`
Purpose: This script cleans the data from the `bronze.crm_prd_info` table and inserts it into the `silver.crm_prd_info` table.
         Cleaning steps include:
         1. Handling null values in `prd_cost` by replacing them with 0.
         2. Standardizing categorical values in `prd_line` (e.g., "M" to "Mountain").
         3. Deriving `cat_id` and `prd_key` from `prd_key`.
         4. Ensuring valid date ranges and type casting for date columns.
Expectations:
         - Cleaned and standardized data in the `silver.crm_prd_info` table.
         - No nulls or invalid values in numeric columns.
         - Standardized values in categorical columns.

***************************************************************************************/

-- Data cleaning for crm_prd_info
TRUNCATE TABLE silver.crm_prd_info;
INSERT INTO silver.crm_prd_info (
    prd_id,
    cat_id,
    prd_key,
    prd_nm,
    prd_cost,
    prd_line,
    prd_start_dt,
    prd_end_dt
)
SELECT 
    prd_id,
    REPLACE(LEFT(prd_key, 5), '-', '_') AS cat_id,  -- Derived column
    SUBSTRING(prd_key, 7, LEN(prd_key)) AS prd_key, -- Derived column
    prd_nm,
    ISNULL(prd_cost, 0) AS prd_cost,                -- Handle null values
    CASE UPPER(TRIM(prd_line))
        WHEN 'M' THEN 'Mountain'
        WHEN 'R' THEN 'Road'
        WHEN 'S' THEN 'Other Sales'
        WHEN 'T' THEN 'Touring'
    END AS prd_line,                                -- Standardize values
    CAST(prd_start_dt AS DATE) AS prd_start_dt,     -- Type casting
    CAST(LEAD(prd_start_dt) OVER(PARTITION BY prd_key ORDER BY prd_start_dt) - 1 AS DATE) AS prd_end_dt
FROM bronze.crm_prd_info;