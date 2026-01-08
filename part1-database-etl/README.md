Part 1 Overview – Database Design and ETL Pipeline

Part 1 focuses on building a complete data ingestion and analytics setup for FlexiMart using CSV data, Python ETL, and a relational database (MySQL/PostgreSQL). The input consists of three raw CSV files related to customers, products, and sales. These files contain multiple data quality issues such as missing fields, inconsistent formats, duplicate records, and incorrect data types. The objective is to create a reliable pipeline that transforms this raw data into clean, structured database tables and supports business reporting needs.

The work is divided into three tasks:

ETL Pipeline Development:
Students must build etl_pipeline.py that performs Extract, Transform, and Load operations. This includes reading CSV files, applying data cleaning rules (handling duplicates, missing values, standardization, surrogate key generation, etc.), and inserting the cleaned records into a predefined normalized database schema. A data_quality_report.txt must be generated to summarize how data issues were handled during ETL.

Database Schema Documentation:
Students must produce schema_documentation.md describing each entity, its purpose, attributes, and relationships, along with a brief normalization explanation to justify why the schema adheres to Third Normal Form (3NF). Sample records must also be included for clarity.

Business Analytics Queries:
Students must write SQL queries in business_queries.sql to answer specific analytical questions involving customer purchase behavior, product sales performance, and monthly trends. These queries evaluate students’ understanding of joins, aggregations, filtering, and window functions.

Overall, Part 1 evaluates the students’ ability to design data pipelines, apply data cleaning strategies, understand database normalization, and produce analytical SQL for real-world business reporting.