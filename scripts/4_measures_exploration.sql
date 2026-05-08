/*
===============================================================================
Measures Exploration (Key Metrics)
===============================================================================
Purpose:
    - To compute aggregated figures (totals, averages, counts) for fast insights.
    - To surface high-level trends or unusual patterns in the data.
SQL Functions Used:
    - COUNT(), SUM(), AVG()
===============================================================================
*/
-- Compute the overall sales revenue
SELECT SUM(sales_amount) AS total_sales FROM gold.fact_sales;

-- Count how many units have been sold in total
SELECT SUM(quantity) AS total_quantity FROM gold.fact_sales;

-- Calculate the mean selling price across all sales
SELECT AVG(price) AS avg_price FROM gold.fact_sales;

-- Count every order line in the fact table
SELECT COUNT(order_number) AS total_orders FROM gold.fact_sales;
SELECT COUNT(DISTINCT order_number) AS total_orders FROM gold.fact_sales;

-- Count how many products exist in the catalog
SELECT COUNT(product_name) AS total_products FROM gold.dim_products;

-- Count how many customers exist in the customer dimension
SELECT COUNT(customer_key) AS total_customers FROM gold.dim_customers;

-- Count only the customers who have actually placed at least one order
SELECT COUNT(DISTINCT customer_key) AS total_customers FROM gold.fact_sales;

-- Build a single report combining all the key business metrics
SELECT 'Total Sales' AS measure_name, SUM(sales_amount) AS measure_value FROM gold.fact_sales
UNION ALL
SELECT 'Total Quantity', SUM(quantity) FROM gold.fact_sales
UNION ALL
SELECT 'Average Price', AVG(price) FROM gold.fact_sales
UNION ALL
SELECT 'Total Orders', COUNT(DISTINCT order_number) FROM gold.fact_sales
UNION ALL
SELECT 'Total Products', COUNT(DISTINCT product_name) FROM gold.dim_products
UNION ALL
SELECT 'Total Customers', COUNT(customer_key) FROM gold.dim_customers;
