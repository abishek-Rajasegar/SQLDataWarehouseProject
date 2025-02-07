**SQLDataWarehouseProject**

Welcome to the SQL Data Warehouse Project, a modern and scalable data warehousing solution designed to handle large volumes of data, transform it into actionable insights, and enable analytics and machine learning. This project leverages the Extract, Transform, and Store (ETS) processes, robust data modeling, and advanced analytics capabilities.

------------------------------------------------------------------------------------------------------------------------------------------------------------------

**Key Components:**

Sources: Data ingestion from CRM and ERP systems.

File types: CSV files.

Interface: Files in folders.

------------------------------------------------------------------------------------------------------------------------------------------------------------------

**Bronze Layer:**

Purpose: Store raw data as-is.

Object Type: Tables.

Load Mechanism: Batch processing, full load, truncate & insert.

Transformations: None.

Data Model: None.

------------------------------------------------------------------------------------------------------------------------------------------------------------------

**Silver Layer:**

Purpose: Clean and standardize data.

Object Type: Tables.

Load Mechanism: Batch processing, full load, truncate & insert.

Transformations: Data cleansing, standardization, normalization, derived columns, enrichment.

Data Model: None.

------------------------------------------------------------------------------------------------------------------------------------------------------------------

**Gold Layer:**

Purpose: Provide business-ready data.

Object Type: Views.

Load Mechanism: None (data is queried directly).

Transformations: Data integrations, aggregations, and business logic.

Data Model: Star schema, flat tables, aggregated tables.

------------------------------------------------------------------------------------------------------------------------------------------------------------------

**Consume:**

Tools for analytics and reporting, including:

Business Intelligence tools (e.g., Power BI, Tableau).

Ad-hoc SQL queries.

------------------------------------------------------------------------------------------------------------------------------------------------------------------

**Data Catalog: Gold Layer Tables**

------------------------------------------------------------------------------------------------------------------------------------------------------------------

Overview

The Gold Layer consists of curated, clean, and structured data optimized for analytics and reporting. This layer provides a foundation for data modeling and business intelligence.

1. dimension_customer

Description:

This table contains a deduplicated, enriched view of customer details, integrating information from multiple source systems.

Columns:

Column Name

Data Type

Description

customer_key

INT

Surrogate key uniquely identifying each customer.

customer_id

STRING

Original customer identifier from source systems.

customer_number

STRING

Business-specific customer number.

first_name

STRING

Customer's first name.

last_name

STRING

Customer's last name.

country

STRING

Customer's country.

marital_status

STRING

Customer's marital status.

gender

STRING

Customer's gender, derived from multiple sources.

birthdate

DATE

Customer's birthdate, where available.

created_date

DATE

The date the customer record was created.

Source Tables:

silver.crm_cust_info

silver.erp_cust_az12

silver.erp_loc_a101

2. dimension_product

Description:

This table provides a unified view of product information, ensuring consistency across all analytical models.

Columns:

Column Name

Data Type

Description

product_key

INT

Surrogate key uniquely identifying each product.

product_id

STRING

Original product identifier from source systems.

product_number

STRING

Business-specific product number.

product_name

STRING

Name of the product.

category_id

STRING

Identifier for the product category.

category

STRING

Category name.

subcategory

STRING

Subcategory name.

maintenance

STRING

Indicates if the product requires maintenance.

product_cost

DECIMAL

Cost of the product.

product_line

STRING

Line of business the product belongs to.

start_date

DATE

The date the product was first available.

Source Tables:

silver.crm_prd_info

silver.erp_px_cat_g1v2

Filters:

Excludes products where prd_end_dt is not null (ensures only active products are included).

3. fact_sales

Description:

This table records sales transactions, linking customers, products, and order details for analysis.

Columns:

Column Name

Data Type

Description

order_number

STRING

Unique identifier for each sales order.

product_key

INT

Foreign key linking to dimension_product.

customer_key

INT

Foreign key linking to dimension_customer.

order_date

DATE

Date when the order was placed.

shipping_date

DATE

Date when the order was shipped.

due_date

DATE

Expected delivery date of the order.

sales

DECIMAL

Total revenue from the order.

quantity

INT

Number of units sold.

price

DECIMAL

Price per unit of product.

Source Tables:

silver.crm_sales_details

gold.dimension_product

gold.dimension_customer

Relationships & Data Model

Fact Table (fact_sales) contains transactions and links to:

dimension_customer (via customer_key)

dimension_product (via product_key)

Surrogate keys (customer_key and product_key) ensure optimized joins and improve query performance.

Business Benefits:

Provides a single source of truth for reporting.

Enables easy integration into BI tools and data marts.

Facilitates efficient aggregations, drill-downs, and trend analysis.

Notes & Best Practices

All dimension tables use surrogate keys to optimize joins.

The gold layer ensures only the latest, cleanest, and business-ready data is available.

Historical data is retained in the silver layer for traceability.

This data catalog serves as documentation for analysts, engineers, and business users, ensuring clarity on the data available for decision-making.

Machine learning integrations.

------------------------------------------------------------------------------------------------------------------------------------------------------------------
