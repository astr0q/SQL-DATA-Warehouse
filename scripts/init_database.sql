/* 
    Script: Data Warehouse Initialization Script
    Purpose: 
        - Ensures a clean setup of the "DataWarehouse" database.
        - Drops the database if it already exists.
        - Recreates it with three schemas: bronze, silver, gold.
    Usage:
        Run this script in SQL Server Management Studio (SSMS) 
        or another SQL client connected to the SQL Server instance.
*/

USE master;  
GO  

-- Check if the "DataWarehouse" database already exists
IF EXISTS (SELECT 1 FROM sys.databases WHERE name = 'DataWarehouse')
BEGIN  
    -- Set database to single-user mode, immediately rolling back other connections
    ALTER DATABASE DataWarehouse SET SINGLE_USER WITH ROLLBACK IMMEDIATE;  

    -- Drop the database to allow clean recreation
    DROP DATABASE DataWarehouse;  
END;  
GO  

-- Create a fresh "DataWarehouse" database
CREATE DATABASE DataWarehouse;  
GO  

-- Switch context to the new "DataWarehouse" database
USE DataWarehouse;  
GO  

-- Create schema for raw/ingested data
CREATE SCHEMA bronze;  
GO  

-- Create schema for cleansed/standardized data
CREATE SCHEMA silver;  
GO  

-- Create schema for curated/final data models
CREATE SCHEMA gold;  
GO  

