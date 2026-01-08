Part 3 Overview – Data Warehouse and Analytics

Part 3 focuses on building a dimensional data warehouse for FlexiMart to support historical sales analysis and executive-level reporting. Traditional transactional databases are optimized for day-to-day operations, but not for trend analysis, aggregations, or drill-down reporting. To solve this, students must design and implement a star schema and perform OLAP-style analytics on sales data.

This part is divided into three major tasks:

1. Star Schema Design Documentation

Students create star_schema_design.md to define the dimensional model for sales analytics. The schema centers around a fact table (fact_sales) capturing transactional sales metrics such as quantities, prices, discounts, and totals. It links to descriptive dimension tables for dates, products, and customers. The documentation explains the schema grain (line-item transactional level), use of surrogate keys, and how the model enables multi-level analysis (such as drill-down from year → quarter → month). A data flow example illustrates how operational data transforms into dimensional facts and dimensions.

2. Data Warehouse Implementation

Using the provided schema, students populate a new fleximart_dw database with realistic sample data. Inserts are written in warehouse_data.sql for all dimensions and facts, including 30+ dates, 15+ products, 12+ customers, and 40+ fact sales rows. This ensures adequate coverage for time-series and performance analytics. The goal is to produce referentially correct and business-realistic datasets that reflect seasonal patterns, diverse pricing, and varied customer demographics.

3. OLAP Analytics Queries

Finally, students implement analytical SQL queries in analytics_queries.sql to answer real business scenarios. These include time-based drill-down analysis (year → quarter → month), product performance ranking (with revenue contribution percentages), and customer segmentation based on total spending. These queries demonstrate core OLAP operations such as grouping, window functions, aggregation, percentage calculations, and CASE-based segmentation.

Overall, Part 3 evaluates the student’s ability to design a dimensional model, implement a data warehouse, and execute advanced analytical queries suited for business intelligence environments.