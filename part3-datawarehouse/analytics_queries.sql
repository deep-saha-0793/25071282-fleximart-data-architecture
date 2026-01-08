-- ===========================================================
-- Query 1: Monthly Sales Drill-Down Analysis
-- Business Scenario:
-- "CEO wants Year → Quarter → Month breakdown for 2024"
-- ===========================================================

SELECT
    d.year,
    d.quarter,
    d.month_name,
    SUM(f.total_amount) AS total_sales,
    SUM(f.quantity_sold) AS total_quantity
FROM fact_sales f
JOIN dim_date d ON f.date_key = d.date_key
WHERE d.year = 2024
GROUP BY d.year, d.quarter, d.month_name, d.month
ORDER BY d.year, d.quarter, d.month;

-- ===========================================================
-- Query 2: Product Performance Analysis (Top 10 Products)
-- Business Scenario:
-- "Identify top 10 products by revenue with % contribution"
-- ===========================================================

WITH product_revenue AS (
    SELECT
        p.product_name,
        p.category,
        SUM(f.quantity_sold) AS units_sold,
        SUM(f.total_amount) AS revenue
    FROM fact_sales f
    JOIN dim_product p ON f.product_key = p.product_key
    GROUP BY p.product_name, p.category
),
total AS (
    SELECT SUM(revenue) AS total_revenue FROM product_revenue
)
SELECT
    pr.product_name,
    pr.category,
    pr.units_sold,
    pr.revenue,
    ROUND((pr.revenue / t.total_revenue) * 100, 2) AS revenue_percentage
FROM product_revenue pr CROSS JOIN total t
ORDER BY pr.revenue DESC
LIMIT 10;

-- ===========================================================
-- Query 3: Customer Segmentation Analysis
-- Business Scenario:
-- "Marketing wants High/Medium/Low value customers"
-- Segmentation:
-- High Value > ₹50,000
-- Medium Value ₹20,000 - ₹50,000
-- Low Value < ₹20,000
-- ===========================================================

WITH customer_spending AS (
    SELECT
        c.customer_key,
        c.customer_name,
        SUM(f.total_amount) AS total_spent
    FROM fact_sales f
    JOIN dim_customer c ON f.customer_key = c.customer_key
    GROUP BY c.customer_key, c.customer_name
),
segmented AS (
    SELECT
        customer_name,
        total_spent,
        CASE
            WHEN total_spent > 50000 THEN 'High Value'
            WHEN total_spent BETWEEN 20000 AND 50000 THEN 'Medium Value'
            ELSE 'Low Value'
        END AS customer_segment
    FROM customer_spending
)
SELECT
    customer_segment,
    COUNT(*) AS customer_count,
    SUM(total_spent) AS total_revenue,
    ROUND(AVG(total_spent),2) AS avg_revenue_per_customer
FROM segmented
GROUP BY customer_segment
ORDER BY total_revenue DESC;
