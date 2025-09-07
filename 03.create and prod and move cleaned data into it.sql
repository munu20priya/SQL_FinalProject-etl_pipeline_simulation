CREATE TABLE prod_customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL,
    signup_date DATE
);


CREATE TABLE prod_orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    product VARCHAR(50) NOT NULL,
    amount DECIMAL(10,2) DEFAULT 0.00,
    order_date DATE,
    FOREIGN KEY (customer_id) REFERENCES prod_customers(customer_id)
);
 
INSERT INTO prod_customers (customer_id, customer_name, email, signup_date)
WITH ranked_customers AS (
    SELECT *,
           ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY signup_date) AS row_num
    FROM stg_customers
)
SELECT customer_id,
       COALESCE(NULLIF(TRIM(customer_name), ''), 'Unknown'),
       COALESCE(NULLIF(TRIM(email), ''), 'no_email@dummy.com'),
       CASE
         WHEN signup_date LIKE '%/%' THEN STR_TO_DATE(signup_date, '%Y/%m/%d')
         ELSE STR_TO_DATE(signup_date, '%Y-%m-%d')
       END
FROM ranked_customers
WHERE row_num = 1;
INSERT INTO prod_orders (order_id, customer_id, product, amount, order_date)
SELECT order_id,
       customer_id,
       COALESCE(NULLIF(TRIM(product), ''), 'Unknown Product'),
       COALESCE(amount, 0.00),
       CASE
         WHEN order_date LIKE '%/%' THEN STR_TO_DATE(order_date, '%Y/%m/%d')
         ELSE STR_TO_DATE(order_date, '%Y-%m-%d')
       END
FROM stg_orders;

