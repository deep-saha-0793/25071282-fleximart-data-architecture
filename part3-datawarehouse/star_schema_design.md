# Part 3 — Data Warehouse Star Schema Design
**Student:** [Deep Saha]  
**Course:** FlexiMart Data Architecture Project

---

## **Section 1: Schema Overview**

### **Fact Table: fact_sales**
- **Grain:** One row per product per order line item
- **Business Process:** Sales transactions

**Measures (Numeric Facts):**
- `quantity_sold` — Units sold
- `unit_price` — Price per unit at sale time
- `discount_amount` — Discount applied
- `total_amount` — Final total (quantity × unit_price - discount)

**Foreign Keys:**
- `date_key` → `dim_date`
- `product_key` → `dim_product`
- `customer_key` → `dim_customer`

---

### **Dimension Table: dim_date**
**Purpose:** Enables time-based analytics  
**Type:** Conformed dimension

**Attributes:**
- `date_key (PK)` — Surrogate, format YYYYMMDD
- `full_date`
- `day_of_week`
- `day_of_month`
- `month`
- `month_name`
- `quarter`
- `year`
- `is_weekend`

---

### **Dimension Table: dim_product**
**Purpose:** Product descriptive attributes for product analytics

**Attributes:**
- `product_key (PK)`
- `product_id` (business key)
- `product_name`
- `category`
- `subcategory`
- `unit_price`

---

### **Dimension Table: dim_customer**
**Purpose:** Customer profiling for segmentation

**Attributes:**
- `customer_key (PK)`
- `customer_id` (business key)
- `customer_name`
- `city`
- `state`
- `customer_segment`

---

## **Section 2: Design Decisions (≈150 words)**

The sales fact table uses a **transaction line-item granularity**, meaning each record represents a single product sold within an order. This granularity is chosen because it preserves the most detailed level of sales activity, enabling advanced analytics such as product‐level profitability, customer segmentation, and time-series trend analysis. Aggregations such as daily, monthly, quarterly, or yearly summaries can easily be computed from this base.

Surrogate keys are used in dimension tables instead of natural keys because natural keys may change over time (e.g., product codes, customer IDs). Surrogate keys ensure stability, performance, and slowly changing dimension management. The chosen schema supports **drill-down** (Year → Quarter → Month → Day) as well as **roll-up** due to the hierarchical attributes in `dim_date`. Similarly, the schema supports slicing by customer segment, product category, and time period, making it suitable for OLAP queries and BI tools.

---

## **Section 3: Sample Data Flow**

**Source Transaction (OLTP):**  
Order #101, Customer "John Doe", Product "Laptop", Qty=2, Price=50000

**Transformed for Data Warehouse:**

`fact_sales` row:
```json
{
  "date_key": 20240115,
  "product_key": 5,
  "customer_key": 12,
  "quantity_sold": 2,
  "unit_price": 50000,
  "total_amount": 100000
}
```

Supporting dimension rows:
```json
dim_date:
{ "date_key": 20240115, "full_date": "2024-01-15", "month": 1, "quarter": "Q1", ... }

dim_product:
{ "product_key": 5, "product_name": "Laptop", "category": "Electronics", ... }

dim_customer:
{ "customer_key": 12, "customer_name": "John Doe", "city": "Mumbai", ... }
```
