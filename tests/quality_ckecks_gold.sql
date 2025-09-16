/*
===============================================================================
Data Quality Checks
===============================================================================

Purpose:
    This script validates the integrity, consistency, and accuracy of the 
    Gold Layer data. The checks focus on:
      - Ensuring uniqueness of surrogate keys in dimension tables.
      - Verifying referential integrity between fact and dimension tables.
      - Validating relationships in the data model to support analytics.

Usage:
    - Run this script as part of regular quality assurance.
    - Investigate and resolve any discrepancies returned by the checks.

===============================================================================
*/

-- ====================================================================
-- Dimension: gold.dim_customers
-- ====================================================================
-- Check: Uniqueness of Customer Key in gold.dim_customers
-- Expectation: Query should return no results

SELECT 
    customer_key,
    COUNT(*) AS duplicate_count
FROM gold.dim_customers
GROUP BY customer_key
HAVING COUNT(*) > 1;

-- ====================================================================
-- Checking 'gold.product_key'
-- ====================================================================
-- Check for Uniqueness of Product Key in gold.dim_products
-- Expectation: No results 
SELECT 
    product_key,
    COUNT(*) AS duplicate_count
FROM gold.dim_products
GROUP BY product_key
HAVING COUNT(*) > 1;

-- ====================================================================
-- Checking 'gold.fact_sales'
-- ====================================================================
-- Check the data model connectivity between fact and dimensions
SELECT * 
FROM gold.fact_sales f
LEFT JOIN gold.dim_customers c
ON c.customer_key = f.customer_key
LEFT JOIN gold.dim_products p
ON p.product_key = f.product_key
WHERE p.product_key IS NULL OR c.customer_key IS NULL  
