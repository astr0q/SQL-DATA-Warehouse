/*
    Script: Bronze Layer Table Creation
    Purpose:
        - Drops and recreates all raw (bronze) layer tables in the DataWarehouse.
        - Ensures fresh ingestion targets for bulk loading CSV source files.
        - Uses NVARCHAR for text-heavy columns and DATE/INT where appropriate.
        - This layer stores raw, untransformed data exactly as received.

    Notes:
        - Existing tables are dropped if they exist to avoid conflicts.
        - Bronze is a "staging" schema: expect duplicates, dirty data, and minimal constraints.
*/

------------------------------------------------------
-- CRM Customer Info Table
------------------------------------------------------
IF OBJECT_ID('bronze.crm_cust_info', 'U') IS NOT NULL
    DROP TABLE bronze.crm_cust_info;

CREATE TABLE bronze.crm_cust_info (
    cst_id INT,                      -- Customer ID (numeric)
    cst_key NVARCHAR(50),            -- Business/customer key
    cst_firstname NVARCHAR(50),      -- First name
    cst_lastname NVARCHAR(50),       -- Last name
    cst_marital_status NVARCHAR(50), -- Marital status
    cst_gndr NVARCHAR(50),           -- Gender
    cst_create_date DATE             -- Creation date
);

------------------------------------------------------
-- CRM Product Info Table
------------------------------------------------------
IF OBJECT_ID('bronze.crm_prd_info', 'U') IS NOT NULL
    DROP TABLE bronze.crm_prd_info;

CREATE TABLE bronze.crm_prd_info (
    prd_id INT,                  -- Product ID (numeric)
    prd_key NVARCHAR(50),        -- Product key
    prd_nm NVARCHAR(50),         -- Product name
    prd_cost INT,                -- Product cost
    prd_line NVARCHAR(50),       -- Product line/category
    prd_start_dt DATE,           -- Start date
    prd_end_dt DATE              -- End date
);

------------------------------------------------------
-- CRM Sales Details Table
------------------------------------------------------
IF OBJECT_ID('bronze.crm_sales_details', 'U') IS NOT NULL
    DROP TABLE bronze.crm_sales_details;

CREATE TABLE bronze.crm_sales_details (
    sls_ord_num NVARCHAR(50),    -- Sales order number
    sls_prd_key NVARCHAR(50),    -- Product key (links to product)
    sls_cust_id INT,             -- Customer ID
    sls_order_dt INT,            -- Order date (as integer, e.g. YYYYMMDD)
    sls_ship_dt INT,             -- Ship date (as integer)
    sls_due_dt INT,              -- Due date (as integer)
    sls_sales INT,               -- Sales amount
    sls_quantity INT,            -- Quantity sold
    sls_price INT                -- Price per unit
    -- Note: removed extra trailing comma that caused syntax error
);

------------------------------------------------------
-- ERP Customer Table (cust_az12)
------------------------------------------------------
IF OBJECT_ID('bronze.erp_cust_az12', 'U') IS NOT NULL
    DROP TABLE bronze.erp_cust_az12;

CREATE TABLE bronze.erp_cust_az12 (
    cid NVARCHAR(50),    -- Customer identifier
    bdate DATE,          -- Birthdate
    gen NVARCHAR(50)     -- Gender
);

------------------------------------------------------
-- ERP Location Table (loc_a101)
------------------------------------------------------
IF OBJECT_ID('bronze.erp_loc_a101', 'U') IS NOT NULL
    DROP TABLE bronze.erp_loc_a101;

CREATE TABLE bronze.erp_loc_a101 (
    cid NVARCHAR(50),    -- Customer identifier (links back to cust_az12)
    cntry NVARCHAR(50)   -- Country
);

------------------------------------------------------
-- ERP Product Category Table (px_cat_g1v2)
------------------------------------------------------
IF OBJECT_ID('bronze.erp_px_cat_g1v2', 'U') IS NOT NULL
    DROP TABLE bronze.erp_px_cat_g1v2;

CREATE TABLE bronze.erp_px_cat_g1v2 (
    id NVARCHAR(50),         -- Product/category identifier (string to allow A101, B202, etc.)
    cat NVARCHAR(50),        -- Category
    subcat NVARCHAR(50),     -- Subcategory
    maintenance NVARCHAR(50) -- Maintenance indicator/details
);
