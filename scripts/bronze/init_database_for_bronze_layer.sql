/*
===================================================================================
Script Name  : DataWarehouse_Setup.sql 
Description  : Creating Bronze layer tables to store raw data from various sources.
===================================================================================

Bronze Layer:
-------------
The Bronze schema stores raw data from different operational sources such as CRM and ERP.
The following tables are created:
    - bronze.crm_cust_info      : Customer information from CRM.
    - bronze.crm_prd_info       : Product details from CRM.
    - bronze.crm_sales_details  : Sales transactions from CRM.
    - bronze.erp_loc_a101       : Location data from ERP.
    - bronze.erp_cust_az12      : Customer demographic data from ERP.
    - bronze.erp_px_cat_g1v2    : Product category and maintenance details from ERP.
===================================================================================
*/


IF OBJECT_ID('bronze.crm_cust_info' , 'U') IS NOT NULL
	DROP TABLE bronze.crm_cust_info;
GO
CREATE TABLE bronze.crm_cust_info(
	cst_id				INT, 
	cst_key				NVARCHAR(50),
	cst_firstname		NVARCHAR(50),
	cst_lastname		NVARCHAR(50),
	cst_marital_status	NVARCHAR(50),
	cst_gndr			NVARCHAR(50),
	cst_create_date		DATE
);


IF OBJECT_ID('bronze.crm_prd_info' , 'U') IS NOT NULL
	DROP TABLE bronze.crm_prd_info;
GO
CREATE TABLE bronze.crm_prd_info(

	prd_id			INT,
	prd_key			NVARCHAR(50),
	prd_nm			NVARCHAR(50),
	prd_cost		INT,
	prd_line		NVARCHAR(50),
	prd_start_dt	DATETIME,
	prd_end_dt		DATETIME
);

IF OBJECT_ID('bronze.crm_sales_details' , 'U') IS NOT NULL
	DROP TABLE bronze.crm_sales_details;
GO
CREATE TABLE bronze.crm_sales_details(
	
	sls_ord_num		NVARCHAR(50),
	sls_prd_key		NVARCHAr(50),
	sls_cst_id		INT,
	sls_ord_dt		INT,
	sls_shp_dt		INT,
	sls_due_dt		INT,
	sls_sales		INT,
	sls_quantity	INT,
	sls_price		INT
);

IF OBJECT_ID('bronze.erp_loc_a101' , 'U') IS NOT NULL
	DROP TABLE bronze.erp_loc_a101;
GO
CREATE TABLE bronze.erp_loc_a101(
	cid		NVARCHAR(50),
	cntry	NVARCHAR(50)
);

IF OBJECT_ID('bronze.erp_cust_az12' , 'U') IS NOT NULL
	DROP TABLE bronze.erp_cust_az12;
GO
CREATE TABLE bronze.erp_cust_az12(
	cid		NVARCHAR(50),
	bdate	DATE,
	gen		NVARCHAR(50)
);

IF OBJECT_ID('bronze.erp_px_cat_g1v2' , 'U') IS NOT NULL
	DROP TABLE bronze.erp_px_cat_g1v2;
GO
CREATE TABLE bronze.erp_px_cat_g1v2(
	id				NVARCHAR(50),
	cat				NVARCHAR(50),
	subcat			NVARCHAR(50),
	maintenance		NVARCHAR(50)
);