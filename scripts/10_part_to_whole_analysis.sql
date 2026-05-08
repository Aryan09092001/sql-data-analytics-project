/*
===============================================================================
Part-to-Whole Analysis
===============================================================================
Purpose:
    - To benchmark performance or metrics across dimensions or time windows.
    - To assess how categories stack up against one another.
    - Helpful for A/B testing scenarios or regional side-by-side comparisons.

SQL Functions Used:
    - SUM(), AVG(): Roll up values so they can be compared.
    - Window Functions: SUM() OVER() to compute totals across the full result.
===============================================================================
*/
-- Which categories contribute the most to overall sales?
WITH category_sales AS (
    SELECT
        p.category,
        SUM(f.sales_amount) AS total_sales
    FROM gold.fact_sales f
    LEFT JOIN gold.dim_products p
        ON p.product_key = f.product_key
    GROUP BY p.category
)
SELECT
    category,
    total_sales,
    SUM(total_sales) OVER () AS overall_sales,
    ROUND((CAST(total_sales AS FLOAT) / SUM(total_sales) OVER ()) * 100, 2) AS percentage_of_total
FROM category_sales
ORDER BY total_sales DESC;
