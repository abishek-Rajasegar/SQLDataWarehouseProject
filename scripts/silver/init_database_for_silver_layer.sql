/*
===================================================================================
Script Name  : Create_Silver_Layer.sql
Description  : This script creates the Silver Layer tables in the `silver` schema.
               It ensures that tables do not already exist before recreating them.
               The Silver Layer acts as a cleansed and transformed data layer,
               providing a structured foundation for analytics and reporting.

Tables Created:
---------------
    - silver.crm_cust_info       : Standardized customer information from CRM.
    - silver.crm_prd_info        : Cleaned and enriched product information from CRM.
    - silver.crm_sales_details   : Processed sales transactions from CRM.
    - silver.erp_loc_a101        : Normalized location data from ERP.
    - silver.erp_cust_az12       : Standardized customer demographics from ERP.
    - silver.erp_px_cat_g1v2     : Cleaned product category data from ERP.

Key Features:
-------------
- Ensures table recreation if they already exist.
- Implements data consistency rules for each table.
- Adds a `dwh_create_date` column with a default timestamp for auditing purposes.
- Uses appropriate data types to maintain integrity and optimize performance.

Execution:
----------
    Run this script before executing `Load_Silver_Procedure.sql`
===================================================================================
*/

IF OBJECT_ID('silver.crm_cust_info' , 'U') IS NOT NULL
	DROP TABLE silver.crm_cust_info;
GO
CREATE TABLE silver.crm_cust_info(
	cst_id				INT, 
	cst_key				NVARCHAR(50),
	cst_firstname		NVARCHAR(50),
	cst_lastname		NVARCHAR(50),
	cst_marital_status	NVARCHAR(50),
	cst_gndr			NVARCHAR(50),
	cst_create_date		DATE,
	dwh_create_date		DATETIME DEFAULT GETDATE(),
);


IF OBJECT_ID('silver.crm_prd_info' , 'U') IS NOT NULL
	DROP TABLE silver.crm_prd_info;
GO
CREATE TABLE silver.crm_prd_info(

	prd_id			INT,
	cat_id			NVARCHAR(50),
	prd_key			NVARCHAR(50),
	prd_nm			NVARCHAR(50),
	prd_cost		INT,
	prd_line		NVARCHAR(50),
	prd_start_dt	DATE,
	prd_end_dt		DATE,
	dwh_create_date		DATETIME DEFAULT GETDATE(),
);

IF OBJECT_ID('silver.crm_sales_details' , 'U') IS NOT NULL
	DROP TABLE silver.crm_sales_details;
GO
CREATE TABLE silver.crm_sales_details(
	
	sls_ord_num		NVARCHAR(50),
	sls_prd_key		NVARCHAr(50),
	sls_cst_id		INT,
	sls_ord_dt		DATE,
	sls_shp_dt		DATE,
	sls_due_dt		DATE,
	sls_sales		INT,
	sls_quantity	INT,
	sls_price		INT,
	dwh_create_date		DATETIME DEFAULT GETDATE(),
);

IF OBJECT_ID('silver.erp_loc_a101' , 'U') IS NOT NULL
	DROP TABLE silver.erp_loc_a101;
GO
CREATE TABLE silver.erp_loc_a101(
	cid		NVARCHAR(50),
	cntry	NVARCHAR(50),
	dwh_create_date		DATETIME DEFAULT GETDATE(),
);

IF OBJECT_ID('silver.erp_cust_az12' , 'U') IS NOT NULL
	DROP TABLE silver.erp_cust_az12;
GO
CREATE TABLE silver.erp_cust_az12(
	cid		NVARCHAR(50),
	bdate	DATE,
	gen		NVARCHAR(50),
	dwh_create_date		DATETIME DEFAULT GETDATE(),
);

IF OBJECT_ID('silver.erp_px_cat_g1v2' , 'U') IS NOT NULL
	DROP TABLE silver.erp_px_cat_g1v2;
GO
CREATE TABLE silver.erp_px_cat_g1v2(
	id				NVARCHAR(50),
	cat				NVARCHAR(50),
	subcat			NVARCHAR(50),
	maintenance		NVARCHAR(50),
	dwh_create_date		DATETIME DEFAULT GETDATE(),
);