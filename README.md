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

