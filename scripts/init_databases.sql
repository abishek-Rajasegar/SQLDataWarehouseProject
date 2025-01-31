/*
===================================================================================
Script Name  : DataWarehouse_Setup.sql
Author       : Abishek R
Description  : This script initializes the Data Warehouse environment by:
               1. Dropping the existing 'DataWarehouse' database if it exists.
               2. Creating a new 'DataWarehouse' database.
               3. Defining schema layers (Bronze, Silver, and Gold) to structure data processing.
===================================================================================
*/

USE master;
GO

IF EXISTS( SELECT 1 FROM sys.databases WHERE name = 'DataWarehouse') 
BEGIN 
	ALTER DATABASE DataWarehouse SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
	DROP DATABASE DataWarehouse
END;
GO

-- crate database "datawarehouse"
CREATE DATABASE DataWarehouse;
GO

-- switch to new database
USE DataWarehouse;
GO

-- create to new schema for each layer

CREATE SCHEMA bronze;
GO
CREATE SCHEMA silver;
GO
CREATE SCHEMA gold;
