# BigBasket Sales & Operations SQL Analysis Project

## Project Overview

This project is an end-to-end SQL-based data analysis project built using a BigBasket-style grocery delivery dataset. The purpose of the project is to simulate how SQL is used in real business environments to analyze sales, customers, inventory, delivery operations, marketing performance, and customer feedback.

The focus of this project is on solving practical, business-driven problems using SQL rather than writing isolated practice queries. The analysis aims to generate insights that can help teams make better decisions in areas such as retail operations, supply chain management, and customer experience.

---

## Dataset Description

The dataset consists of multiple Excel files, each representing a different part of a grocery delivery business:

* Customer information and demographics
* Orders and order-level details
* Order items and product-level sales
* Product catalog and pricing details
* Inventory and stock movement records
* Delivery performance and delay metrics
* Marketing campaign performance
* Customer feedback and sentiment data

All raw dataset files are stored in the `data/` folder. These files were imported into MySQL using a Python-based automation process.

---

## Tools & Technologies Used

* MySQL for database creation and analysis
* Python (Pandas, SQLAlchemy) for automated data ingestion
* Git and GitHub for version control and project hosting
* Excel / CSV files as the raw data source

---

## Database Design

The database consists of nine interrelated tables:

* customers
* orders
* order_items
* products
* inventory
* inventory_new
* delivery_performance
* marketing_performance
* customer_feedback

Primary keys and foreign keys were defined to maintain data integrity and enable accurate joins across multiple tables.

---

## Data Ingestion

All Excel and CSV files were imported into MySQL using a Python script built with Pandas and SQLAlchemy. This approach avoids manual imports and ensures the data loading process is repeatable and scalable.

Script location:

```
/scripts/import_data.py
```

---

## Key Business Questions Answered

Some of the real-world questions answered in this project include:

* Who are the top revenue-generating customers?
* Which products and categories contribute the most to revenue?
* Which products generate high revenue but low sales volume?
* Which products are at risk of stock-out based on inventory levels?
* Which products have damaged stock exceeding acceptable limits?
* Does delivery distance have an impact on delivery delays?
* Which delivery partners have the highest average delivery time?
* What percentage of orders are delivered late?
* Which areas receive the highest negative customer feedback?
* Which marketing campaigns generate the best return on ad spend?

All queries and solutions are documented in:

```
/sql/business_queries.sql
```

---

## SQL Concepts Used

* Table joins
* Aggregation functions such as SUM, AVG, and COUNT
* Subqueries
* Common Table Expressions (CTEs)
* Window functions including RANK and DENSE_RANK
* CASE statements
* Date and time functions
* GROUP BY and HAVING clauses

---


## Key Takeaways

This project demonstrates the ability to work with a multi-table relational database, translate business questions into SQL queries, and analyze sales, operations, inventory, and customer behavior using structured data.

---

## Author

Rahul Pardeshi
Aspiring Data Analyst | SQL | Python
