
CREATE DATABASE IF NOT EXISTS ecom;
USE ecom;

CREATE TABLE IF NOT EXISTS clean_orders (
  order_id VARCHAR(10), order_date DATE, month CHAR(7),
  customer_id VARCHAR(10), product_id VARCHAR(10),
  quantity INT, unit_price_inr DECIMAL(12,2), revenue_inr DECIMAL(14,2),
  first_order_date DATE
);

CREATE TABLE IF NOT EXISTS products (
  product_id VARCHAR(10), product_name VARCHAR(50), category VARCHAR(30)
);



-- Monthly completed revenue (INR)
SELECT month, COUNT(*) AS orders, SUM(revenue_inr) AS revenue_inr,
       ROUND(AVG(revenue_inr)) AS avg_order_value
FROM clean_orders GROUP BY month ORDER BY month;

-- Top 10 products by revenue
SELECT c.product_id, p.product_name, p.category,
       SUM(c.quantity) AS units, SUM(c.revenue_inr) AS revenue_inr
FROM clean_orders c JOIN products p ON p.product_id = c.product_id
GROUP BY c.product_id, p.product_name, p.category
ORDER BY revenue_inr DESC LIMIT 10;

-- New vs repeat customer contribution (within dataset window)
SELECT month,
       CASE WHEN order_date = first_order_date THEN 'new' ELSE 'repeat' END AS customer_type,
       COUNT(*) AS orders, COUNT(DISTINCT customer_id) AS customers,
       SUM(revenue_inr) AS revenue_inr
FROM clean_orders GROUP BY month, customer_type ORDER BY month, customer_type;

-- What changed between months
SELECT product_id,
  SUM(CASE WHEN month='2026-08' THEN revenue_inr ELSE 0 END) AS aug_inr,
  SUM(CASE WHEN month='2026-09' THEN revenue_inr ELSE 0 END) AS sep_inr,
  SUM(CASE WHEN month='2026-09' THEN revenue_inr ELSE 0 END)
 -SUM(CASE WHEN month='2026-08' THEN revenue_inr ELSE 0 END) AS change_inr
FROM clean_orders GROUP BY product_id ORDER BY change_inr;
