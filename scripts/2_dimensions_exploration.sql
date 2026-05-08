/*
===============================================================================
Dimensions Exploration
===============================================================================
Purpose:
    - To examine the contents and layout of the dimension tables.

SQL Functions Used:
    - DISTINCT
    - ORDER BY
===============================================================================
*/
-- Pull the unique set of countries where our customers are based
SELECT DISTINCT 
    country 
FROM gold.dim_customers
ORDER BY country;

-- Pull the unique combinations of category, subcategory, and product name
SELECT DISTINCT 
    category, 
    subcategory, 
    product_name 
FROM gold.dim_products
ORDER BY category, subcategory, product_name;
