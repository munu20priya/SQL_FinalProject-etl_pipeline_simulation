CREATE DATABASE  etl_project;
USE etl_project;

CREATE TABLE stg_customers (
    customer_id INT,
    customer_name VARCHAR(100),
    email VARCHAR(100),
    signup_date VARCHAR(20)
);

CREATE TABLE stg_orders (
    order_id INT,
    customer_id INT,
    product VARCHAR(100),
    amount DECIMAL(10,2),
    order_date VARCHAR(20)
);
