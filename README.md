# SQL Data Analytics Project — MySQL

A comprehensive collection of SQL scripts for **data exploration, analytics, and reporting** — adapted from a SQL Server original into a fully working **MySQL 8.0+** implementation. These scripts cover database exploration, measures and metrics, time-based trends, cumulative analytics, ranking, segmentation, and consolidated reporting views.

This repository is designed to help data analysts and BI professionals quickly explore, segment, and analyze data within a relational database. Each script focuses on a specific analytical theme and demonstrates best practices for analytical SQL queries — joins, CTEs, window functions, and CASE-based segmentation.



---

## 📂 Repository Structure

```
sql-data-analytics-project/
│
├── datasets/                              # Source CSV files (star-schema gold layer)
│   ├── gold.dim_customers.csv
│   ├── gold.dim_products.csv
│   └── gold.fact_sales.csv
│
├── scripts/
│   ├── 00_init_database.sql               # Create database + load 3 CSVs
│   │
│   ├── exploratory_data_analysis/
│   │   ├── 01_database_exploration.sql
│   │   ├── 02_dimensions_exploration.sql
│   │   ├── 03_date_range_exploration.sql
│   │   ├── 04_measures_exploration.sql
│   │   ├── 05_magnitude_analysis.sql
│   │   └── 06_ranking_analysis.sql
│   │
│   ├── advanced_data_analytics/
│   │   ├── 07_change_over_time_analysis.sql
│   │   ├── 08_cumulative_analysis.sql
│   │   ├── 09_performance_analysis.sql
│   │   ├── 10_part_to_whole_analysis.sql
│   │   └── 11_data_segmentation.sql
│   │
│   └── reports/
│       ├── 12_report_customers.sql        # Customer 360 view
│       └── 13_report_products.sql         # Product performance view
│
├── docs/                                  # Diagrams / supporting documentation
│
├── LICENSE                                # MIT
└── README.md
```

---

## 🎯 Project Objective

The goal of this project is to **turn a clean star-schema dataset into business insights** using SQL. The dataset arrives in a ready-made gold layer (`dim_customers`, `dim_products`, `fact_sales`) — the analytics scripts then answer real business questions:

- How is revenue trending year-over-year and month-over-month?
- Which products and customers contribute the most to total sales?
- Which categories carry the business, and which lag behind?
- How do customers segment into VIP, Regular, and New buckets?
- Which products are at risk of being phased out?
- What does a full customer 360 / product 360 report look like?

---

## 🏛️ Data Model

The dataset uses a classic **star schema**:

```
        ┌──────────────────────┐
        │   gold.dim_customers │
        │  (customer details)  │
        └──────────┬───────────┘
                   │
                   │ customer_key
                   ▼
        ┌──────────────────────┐         ┌──────────────────────┐
        │    gold.fact_sales   │◄────────┤   gold.dim_products  │
        │   (transactions)     │ product │   (product details)  │
        └──────────────────────┘  _key   └──────────────────────┘
```

- **`dim_customers`** — One row per customer (customer key, name, country, gender, birthdate, etc.)
- **`dim_products`** — One row per active product (product key, category, subcategory, cost, etc.)
- **`fact_sales`** — One row per order line (foreign keys + sales amount, quantity, price, dates)

---

## 🚀 How to Run This Project

### Prerequisites
- MySQL 8.0+ (CTEs and window functions are required — this repo was built and tested on MySQL 9.7)
- MySQL Workbench (or any MySQL client)
- The three CSV files from the `datasets/` folder

### Setup steps

1. **Clone the repo:**
```bash
   git clone https://github.com/Aryan09092001/sql-data-analytics-project.git
```

2. **Update the CSV paths inside `scripts/00_init_database.sql`** so they point to where you saved the `datasets/` folder. Use forward slashes (`/`) in the path even on Windows.

3. **Enable `LOAD DATA LOCAL INFILE` in MySQL Workbench:**
   - Server side: run `SET GLOBAL local_infile = 1;`
   - Client side: in Workbench, go to **Database → Manage Connections → Advanced → Others** and add `OPT_LOCAL_INFILE=1`, then restart Workbench.

4. **Run `00_init_database.sql`** to create the database and load the data.

5. **Run any analysis script in the `scripts/` folder** to explore the data. Scripts are independent — they can be run in any order.

---

## 📜 Scripts Overview

### Exploratory Data Analysis (EDA)

| File | What it does |
| ---- | ------------ |
| `01_database_exploration.sql` | Lists databases, tables, and columns using `INFORMATION_SCHEMA` |
| `02_dimensions_exploration.sql` | Pulls unique values from dimension tables (countries, categories, etc.) |
| `03_date_range_exploration.sql` | Finds first/last order dates, customer age range |
| `04_measures_exploration.sql` | Calculates headline KPIs (total sales, total orders, total customers, average price) |
| `05_magnitude_analysis.sql` | Breaks down volumes by country, gender, category |
| `06_ranking_analysis.sql` | Top/bottom products and customers using `LIMIT` and `RANK() OVER` |

### Advanced Data Analytics

| File | What it does |
| ---- | ------------ |
| `07_change_over_time_analysis.sql` | Sales trends by year and by month (Year + Month, `DATE_FORMAT`) |
| `08_cumulative_analysis.sql` | Running totals and moving averages over time |
| `09_performance_analysis.sql` | Year-over-year product performance with `LAG()` and category averages |
| `10_part_to_whole_analysis.sql` | Each category's share of overall sales |
| `11_data_segmentation.sql` | Product cost bands and customer segmentation (VIP / Regular / New) |

### Reports

| File | What it does |
| ---- | ------------ |
| `12_report_customers.sql` | Creates `gold.report_customers` view — full customer 360 (age group, segment, recency, AOV, monthly spend) |
| `13_report_products.sql` | Creates `gold.report_products` view — full product performance (segment, recency, AOR, monthly revenue) |

---

## 🧠 SQL Techniques Demonstrated

- **CTEs** (`WITH ... AS (...)`) for multi-step query readability
- **Window functions:** `ROW_NUMBER`, `RANK`, `LAG`, `LEAD`, `SUM() OVER`, `AVG() OVER`
- **Conditional segmentation** with multi-branch `CASE WHEN`
- **Aggregate joins** (fact joined to dimensions, then grouped)
- **Date arithmetic** with `TIMESTAMPDIFF`, `DATE_FORMAT`, `DATE_SUB`
- **Part-to-whole** percentages via `value / SUM(value) OVER ()`
- **Surrogate keys** generated with `ROW_NUMBER() OVER`
- **Consolidated reporting views** (customer 360 / product 360)

---

