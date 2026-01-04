-- row check
SELECT COUNT(*) FROM final_analysis_data;

-- Null/missing values 
SELECT
  SUM(order_id IS NULL) AS null_orders,
  SUM(profit IS NULL) AS null_profit,
  SUM(discount IS NULL) AS null_discount
FROM final_analysis_data;

-- Profit margin sanity
SELECT *
FROM final_analysis_data
WHERE profit_margin > 1 OR profit_margin < -1;

-- EDA
-- overall performance
SELECT
  SUM(sales) AS total_sales,
  SUM(profit) AS total_profit,
  ROUND(AVG(profit_margin), 2) AS avg_margin
FROM final_analysis_data;

-- loss analysis

SELECT
  is_loss,
  COUNT(*) AS orders,
  ROUND(SUM(profit), 2) AS total_profit
FROM final_analysis_data
GROUP BY is_loss;

-- discount impact

SELECT
  discount_bucket,
  COUNT(*) AS orders,
  ROUND(AVG(profit_margin), 2) AS avg_margin
FROM final_analysis_data
GROUP BY discount_bucket
ORDER BY avg_margin;

-- Business Question

-- Do higher discounts lead to more loss-making orders?
SELECT
    discount_bucket,
    COUNT(*) AS total_orders,
    ROUND(SUM(profit), 2) AS total_profit,
    ROUND(AVG(profit_margin), 3) AS avg_profit_margin
FROM final_analysis_data
GROUP BY discount_bucket
ORDER BY avg_profit_margin;

-- What proportion of orders are loss-making?

SELECT
    is_loss,
    COUNT(*) AS order_count,
    ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (), 2) AS percentage
FROM final_analysis_data
GROUP BY is_loss;

-- Which product categories generate the highest and lowest profits?
SELECT
    category,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit,
    ROUND(AVG(profit_margin), 3) AS avg_profit_margin
FROM final_analysis_data
GROUP BY category
ORDER BY total_profit DESC;



-- Which regions are underperforming in terms of profit?
SELECT
    region,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit,
    ROUND(AVG(profit_margin), 3) AS avg_profit_margin
FROM final_analysis_data
GROUP BY region
ORDER BY total_profit;


-- How do discounts affect profitability across different product categories?
SELECT
    category,
    discount_bucket,
    COUNT(*) AS total_orders,
    ROUND(SUM(profit), 2) AS total_profit
FROM final_analysis_data
GROUP BY category, discount_bucket
ORDER BY category, total_profit;

-- How do sales and profits vary month-over-month?
SELECT
    order_year,
    order_month,
    order_month_name,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit
FROM final_analysis_data
GROUP BY order_year, order_month, order_month_name
ORDER BY order_year, order_month;

-- Which products contribute the most to losses?

SELECT
    product_name,
    category,
    ROUND(SUM(profit), 2) AS total_profit
FROM final_analysis_data
GROUP BY product_name, category
HAVING total_profit < 0
ORDER BY total_profit;

