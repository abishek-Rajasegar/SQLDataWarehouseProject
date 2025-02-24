/*
===================================================================================
Description  : Gold Layer Views
Author       : Abishek R
Description  : This script defines the Gold Layer views for the Data Warehouse.
               The Gold Layer consists of refined, business-ready data optimized for reporting and analytics.
            It includes:
                1. Dimension tables for Customers and Products, ensuring clean and structured reference data.
                2. A Fact table for Sales, linking transactional data to relevant dimensions for analysis.
                These views support business intelligence, dashboards, and data analysis.

===================================================================================
*/

CREATE VIEW gold.dimension_customer AS     
    SELECT 
        RoW_NUMBER() OVER(ORDER BY cst_id) AS customer_key ,
        ci.cst_id AS customer_id ,
        ci.cst_key AS customer_number ,
        ci.cst_firstname AS first_name ,
        ci.cst_lastname AS last_name , 
        la.cntry AS country ,
        ci.cst_marital_status AS marital_status ,
        CASE WHEN ci.cst_gndr != 'n/a' THEN ci.cst_gndr ELSE COALESCE(ca.gen,'n/a') END AS gender ,
        ca.bdate AS birthdate ,
        ci.cst_create_date AS created_date
    FROM DataWarehouse.silver.crm_cust_info ci
    LEFT JOIN DataWarehouse.silver.erp_cust_az12 ca ON ci.cst_key = ca.cid
    LEFT JOIN DataWarehouse.silver.erp_loc_a101 la on ci.cst_key = la.cid

GO

CREATE OR ALTER VIEW gold.dimension_product AS
SELECT 
    ROW_NUMBER() OVER(ORDER BY pi.prd_start_dt , pi.prd_key) AS product_key,
    pi.prd_id AS product_id,
    pi.prd_key AS product_number,
    pi.prd_nm AS product_name,
    pi.cat_id AS category_id,
    pc.cat AS category,
    pc.subcat AS subcategory,
    pc.maintenance AS maintenance,
    pi.prd_cost AS product_cost,
    pi.prd_line AS product_line,
    pi.prd_start_dt AS start_date
FROM DataWarehouse.silver.crm_prd_info pi
LEFT JOIN DataWarehouse.silver.erp_px_cat_g1v2 pc on pi.cat_id = pc.id
WHERE prd_end_dt IS NULL  -- Filter out old data and have only the new data

GO

CREATE OR ALTER VIEW gold.fact_sales AS
    SELECT 
        sd.sls_ord_num AS order_number,
        pr.product_key ,
        cs.customer_key,
        sd.sls_ord_dt AS order_date,
        sd.sls_shp_dt AS shipping_date,
        sd.sls_due_dt AS due_date,
        sd.sls_sales AS sales, 
        sd.sls_quantity AS quantity ,
        sd.sls_price AS price 
    FROM DataWarehouse.silver.crm_sales_details sd
    LEFT JOIN DataWarehouse.gold.dimension_product pr ON sd.sls_prd_key = pr.product_number
    LEFT JOIN DataWarehouse.gold.dimension_customer cs on sd.sls_cst_id = cs.customer_id

