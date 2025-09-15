/*
    Procedure: bronze.load_bronze
    Purpose:
        - Loads raw CSV data into the Bronze schema tables.
        - Handles both CRM and ERP source datasets.
        - Truncates (clears) existing data before reloading fresh files.
        - Acts as the main ingestion step of the ETL pipeline.

    Notes:
        - Uses BULK INSERT for fast CSV ingestion.
        - Assumes CSV files exist at the specified file paths.
        - CSVs must have headers (skipped using FIRSTROW = 2).
        - Bronze layer is "raw landing zone": data may contain duplicates or dirty values.
    Usage:
          EXEC bronze.load_bronze;
*/

CREATE OR ALTER PROCEDURE bronze.load_bronze
AS
BEGIN
    ----------------------------------------------------------
    -- Section 1: Log Start
    ----------------------------------------------------------
    PRINT '===========================================';
    PRINT 'Loading Bronze Layer';
    PRINT '===========================================';

    ----------------------------------------------------------
    -- Section 2: Load CRM Tables
    ----------------------------------------------------------
    PRINT '===========================================';
    PRINT 'Loading CRM Tables';
    PRINT '===========================================';

    -- CRM Customer Info
    TRUNCATE TABLE bronze.crm_cust_info;
    BULK INSERT bronze.crm_cust_info
    FROM 'C:\Users\USER\Desktop\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
    WITH (
        FIRSTROW = 2,            -- Skip header
        FIELDTERMINATOR = ',',   -- CSV delimiter
        TABLOCK                  -- Faster load
    );

    -- CRM Product Info
    TRUNCATE TABLE bronze.crm_prd_info;
    BULK INSERT bronze.crm_prd_info
    FROM 'C:\Users\USER\Desktop\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
    WITH (
        FIRSTROW = 2,
        FIELDTERMINATOR = ',',
        TABLOCK
    );

    -- CRM Sales Details
    TRUNCATE TABLE bronze.crm_sales_details;
    BULK INSERT bronze.crm_sales_details
    FROM 'C:\Users\USER\Desktop\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
    WITH (
        FIRSTROW = 2,
        FIELDTERMINATOR = ',',
        TABLOCK
    );

    ----------------------------------------------------------
    -- Section 3: Load ERP Tables
    ----------------------------------------------------------
    PRINT '===========================================';
    PRINT 'Loading ERP Tables';
    PRINT '===========================================';

    -- ERP Customer (AZ12)
    TRUNCATE TABLE bronze.erp_cust_az12;
    BULK INSERT bronze.erp_cust_az12
    FROM 'C:\Users\USER\Desktop\sql-data-warehouse-project\datasets\source_erp\cust_az12.csv'
    WITH (
        FIRSTROW = 2,
        FIELDTERMINATOR = ',',
        TABLOCK
    );

    -- ERP Location (A101)
    TRUNCATE TABLE bronze.erp_loc_a101;
    BULK INSERT bronze.erp_loc_a101
    FROM 'C:\Users\USER\Desktop\sql-data-warehouse-project\datasets\source_erp\loc_a101.csv'
    WITH (
        FIRSTROW = 2,
        FIELDTERMINATOR = ',',
        TABLOCK
    );

    -- ERP Product Category (G1V2)
    TRUNCATE TABLE bronze.erp_px_cat_g1v2;
    BULK INSERT bronze.erp_px_cat_g1v2
    FROM 'C:\Users\USER\Desktop\sql-data-warehouse-project\datasets\source_erp\px_cat_g1v2.csv'
    WITH (
        FIRSTROW = 2,
        FIELDTERMINATOR = ',',
        TABLOCK
    );

    ----------------------------------------------------------
    -- Section 4: Log Completion
    ----------------------------------------------------------
    PRINT '===========================================';
    PRINT 'Bronze Load Completed Successfully';
    PRINT '===========================================';
END;
GO
