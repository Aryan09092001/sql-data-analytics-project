/*
=============================================================
Create Database and Schemas
=============================================================
Script Purpose:
    This script creates a new database named 'DataWarehouseAnalytics' after
    checking if it already exists. If the database exists, it is dropped and
    recreated. Additionally, this script sets up a "schema" called gold
    (which in MySQL is just another database).

WARNING:
    Running this script will drop the entire 'DataWarehouseAnalytics' database
    if it exists. All data in the database will be permanently deleted.
    Proceed with caution and ensure you have proper backups before running.

MySQL note:
    SQL Server uses a database (DataWarehouseAnalytics) that contains a
    schema (gold). MySQL has no schemas-inside-databases concept, so we
    simply create one database called 'gold' that holds all three tables.
    The 'DataWarehouseAnalytics' wrapper database is created for naming
    consistency but is otherwise unused.

    SQL Server's BULK INSERT becomes LOAD DATA LOCAL INFILE in MySQL.
    Make sure local_infile is enabled on both server and client side
    before running the load section.
=============================================================
*/

-- =============================================================
-- Drop and recreate the 'DataWarehouseAnalytics' database
-- =============================================================
DROP DATABASE IF EXISTS DataWarehouseAnalytics;
CREATE DATABASE DataWarehouseAnalytics;

-- =============================================================
-- Create the 'gold' schema (a separate database in MySQL)
-- =============================================================
DROP DATABASE IF EXISTS gold;
CREATE DATABASE gold;

USE gold;

-- =============================================================
-- Create gold.dim_customers
-- =============================================================
CREATE TABLE gold.dim_customers (
    customer_key    INT,
    customer_id     INT,
    customer_number VARCHAR(50),
    first_name      VARCHAR(50),
    last_name       VARCHAR(50),
    country         VARCHAR(50),
    marital_status  VARCHAR(50),
    gender          VARCHAR(50),
    birthdate       DATE,
    create_date     DATE
);

-- =============================================================
-- Create gold.dim_products
-- =============================================================
CREATE TABLE gold.dim_products (
    product_key     INT,
    product_id      INT,
    product_number  VARCHAR(50),
    product_name    VARCHAR(50),
    category_id     VARCHAR(50),
    category        VARCHAR(50),
    subcategory     VARCHAR(50),
    maintenance     VARCHAR(50),
    cost            INT,
    product_line    VARCHAR(50),
    start_date      DATE
);

-- =============================================================
-- Create gold.fact_sales
-- =============================================================
CREATE TABLE gold.fact_sales (
    order_number    VARCHAR(50),
    product_key     INT,
    customer_key    INT,
    order_date      DATE,
    shipping_date   DATE,
    due_date        DATE,
    sales_amount    INT,
    quantity        TINYINT,
    price           INT
);

-- =============================================================
-- Enable local file loading (required for LOAD DATA LOCAL INFILE)
-- =============================================================
SET GLOBAL local_infile = 1;
SET SESSION sql_mode = '';

-- =============================================================
-- Load data into gold.dim_customers
-- =============================================================
TRUNCATE TABLE gold.dim_customers;

LOAD DATA LOCAL INFILE 'F:/SQL/data_analytics_project/sql-data-analytics-project-main/sql-data-analytics-project-main/datasets/csv-files/gold.dim_customers.csv'
INTO TABLE gold.dim_customers
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

-- =============================================================
-- Load data into gold.dim_products
-- =============================================================
TRUNCATE TABLE gold.dim_products;

LOAD DATA LOCAL INFILE 'F:/SQL/data_analytics_project/sql-data-analytics-project-main/sql-data-analytics-project-main/datasets/csv-files/gold.dim_products.csv'
INTO TABLE gold.dim_products
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

-- =============================================================
-- Load data into gold.fact_sales
-- =============================================================
TRUNCATE TABLE gold.fact_sales;

LOAD DATA LOCAL INFILE 'F:/SQL/data_analytics_project/sql-data-analytics-project-main/sql-data-analytics-project-main/datasets/csv-files/gold.fact_sales.csv'
INTO TABLE gold.fact_sales
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

-- =============================================================
-- Verify the load
-- =============================================================
SELECT 'dim_customers' AS table_name, COUNT(*) AS rows_loaded FROM gold.dim_customers
UNION ALL
SELECT 'dim_products', COUNT(*) FROM gold.dim_products
UNION ALL
SELECT 'fact_sales',   COUNT(*) FROM gold.fact_sales;
