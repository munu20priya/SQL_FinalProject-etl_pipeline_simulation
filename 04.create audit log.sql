CREATE TABLE audit_log (
    log_id INT AUTO_INCREMENT PRIMARY KEY,
    table_name VARCHAR(50),
    rows_inserted INT,
    load_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO audit_log (table_name, rows_inserted)
SELECT 'prod_customers', COUNT(*) FROM prod_customers;

INSERT INTO audit_log (table_name, rows_inserted)
SELECT 'prod_orders', COUNT(*) FROM prod_orders;