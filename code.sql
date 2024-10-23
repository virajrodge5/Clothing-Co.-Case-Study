-- High Level Sales Analysis

-- What was the total quantity sold for all products?
SELECT 
  product.product_name, 
  SUM(sales.qty) AS total_quantity
FROM balanced_tree.sales
INNER JOIN balanced_tree.product_details AS product
	ON sales.prod_id = product.product_id
GROUP BY product.product_name;


-- What is the total generated revenue for all products before discounts?
SELECT 
  product.product_name, 
  SUM(sales.qty) * SUM(sales.price) AS total_revenue
FROM balanced_tree.sales
INNER JOIN balanced_tree.product_details AS product
	ON sales.prod_id = product.product_id
GROUP BY product.product_name;


-- What was the total discount amount for all products?
SELECT 
  product.product_name, 
  SUM(sales.qty * sales.price * sales.discount/100) AS total_discount
FROM balanced_tree.sales
INNER JOIN balanced_tree.product_details AS product
	ON sales.prod_id = product.product_id
GROUP BY product.product_name;


-- Transaction Analysis

-- How many unique transactions were there?
SELECT COUNT(DISTINCT txn_id) AS transaction_count
FROM balanced_tree.sales;


-- What is the average unique products purchased in each transaction?
SELECT ROUND(AVG(total_quantity)) AS avg_unique_products
FROM (
  SELECT 
    txn_id, 
    SUM(qty) AS total_quantity
  FROM balanced_tree.sales
  GROUP BY txn_id
) AS total_quantities;


-- What are the 25th, 50th and 75th percentile values for the revenue per transaction?
WITH revenue_cte AS (
  SELECT 
    txn_id, 
    SUM(price * qty) AS revenue
  FROM balanced_tree.sales
  GROUP BY txn_id
)

SELECT
  PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY revenue) AS median_25th,
    PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY revenue) AS median_50th,
PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY revenue) AS median_75th
FROM revenue_cte;


-- What is the average discount value per transaction?
SELECT ROUND(AVG(discount_amt)) AS avg_discount
FROM (
  SELECT 
	  txn_id,
    SUM(qty * price * discount/100) AS discount_amt
  FROM balanced_tree.sales
  GROUP BY txn_id
) AS discounted_value

  
-- What is the percentage split of all transactions for members vs non-members?
WITH transactions_cte AS (
  SELECT
    member,
    COUNT(DISTINCT txn_id) AS transactions
  FROM balanced_tree.sales
  GROUP BY member
)

SELECT
	member,
  transactions,
  ROUND(100 * transactions
    /(SELECT SUM(transactions) 
      FROM transactions_cte)) AS percentage
FROM transactions_cte
GROUP BY member, transactions;


-- What is the average revenue for member transactions and non-member transactions?
WITH revenue_cte AS (
  SELECT
    member,
  	txn_id,
    SUM(price * qty) AS revenue
  FROM balanced_tree.sales
  GROUP BY member, txn_id
)

SELECT
	member,
  ROUND(AVG(revenue),2) AS avg_revenue
FROM revenue_cte
GROUP BY member;


-- Product Analysis

-- What are the top 3 products by total revenue before discount?
SELECT 
  product.product_id,
  product.product_name, 
  SUM(sales.qty) * SUM(sales.price) AS total_revenue
FROM balanced_tree.sales
INNER JOIN balanced_tree.product_details AS product
	ON sales.prod_id = product.product_id
GROUP BY product.product_id, product.product_name
ORDER BY total_revenue DESC
LIMIT 3;


-- What is the total quantity, revenue and discount for each segment?
SELECT 
  product.segment_id,
  product.segment_name, 
  SUM(sales.qty) AS total_quantity,
  SUM(sales.qty * sales.price) AS total_revenue,
  SUM((sales.qty * sales.price) * sales.discount/100) AS total_discount
FROM balanced_tree.sales
INNER JOIN balanced_tree.product_details AS product
	ON sales.prod_id = product.product_id
GROUP BY product.segment_id, product.segment_name;


-- What is the top selling product for each segment?
WITH top_selling_cte AS ( 
  SELECT 
    product.segment_id,
    product.segment_name, 
    product.product_id,
    product.product_name,
    SUM(sales.qty) AS total_quantity,
    RANK() OVER (
      PARTITION BY segment_id 
      ORDER BY SUM(sales.qty) DESC) AS ranking
  FROM balanced_tree.sales
  INNER JOIN balanced_tree.product_details AS product
    ON sales.prod_id = product.product_id
  GROUP BY 
    product.segment_id, product.segment_name, product.product_id, product.product_name
)

SELECT 
  segment_id,
  segment_name, 
  product_id,
  product_name,
  total_quantity
FROM top_selling_cte
WHERE ranking = 1;


-- What is the total quantity, revenue and discount for each category?
SELECT 
  product.category_id,
  product.category_name, 
  SUM(sales.qty) AS total_quantity,
  SUM(sales.qty * sales.price) AS total_revenue,
  SUM((sales.qty * sales.price) * sales.discount/100) AS total_discount
FROM balanced_tree.sales
INNER JOIN balanced_tree.product_details AS product
	ON sales.prod_id = product.product_id
GROUP BY product.category_id, product.category_name
ORDER BY product.category_id;


-- What is the top selling product for each category?
WITH top_selling_cte AS ( 
  SELECT 
    product.category_id,
    product.category_name, 
    product.product_id,
    product.product_name,
    SUM(sales.qty) AS total_quantity,
    RANK() OVER (
      PARTITION BY product.category_id 
      ORDER BY SUM(sales.qty) DESC) AS ranking
  FROM balanced_tree.sales
  INNER JOIN balanced_tree.product_details AS product
    ON sales.prod_id = product.product_id
  GROUP BY 
    product.category_id, product.category_name, product.product_id, product.product_name
)

SELECT 
  category_id,
  category_name, 
  product_id,
  product_name,
  total_quantity
FROM top_selling_cte
WHERE ranking = 1;
