/*
===============================================================================
Date Range Exploration 
===============================================================================
Purpose:
    - To identify the time spans covered by our key data points.
    - To get a sense of how far back the historical data reaches.
SQL Functions Used:
    - MIN(), MAX(), TIMESTAMPDIFF()
===============================================================================
*/
-- Find the earliest and latest order dates, plus the total span in months
SELECT 
    MIN(order_date) AS first_order_date,
    MAX(order_date) AS last_order_date,
    TIMESTAMPDIFF(MONTH, MIN(order_date), MAX(order_date)) AS order_range_months
FROM gold.fact_sales;

-- Identify the oldest and youngest customer based on birthdate
SELECT
    MIN(birthdate) AS oldest_birthdate,
    TIMESTAMPDIFF(YEAR, MIN(birthdate), CURRENT_DATE) AS oldest_age,
    MAX(birthdate) AS youngest_birthdate,
    TIMESTAMPDIFF(YEAR, MAX(birthdate), CURRENT_DATE) AS youngest_age
FROM gold.dim_customers;
