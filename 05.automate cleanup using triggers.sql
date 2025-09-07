DELIMITER $$

CREATE TRIGGER before_insert_customer
BEFORE INSERT ON prod_customers
FOR EACH ROW
BEGIN
    IF NEW.customer_name IS NULL OR NEW.customer_name = '' THEN
        SET NEW.customer_name = 'Unknown';
    END IF;
    IF NEW.email IS NULL OR NEW.email = '' THEN
        SET NEW.email = 'no_email@dummy.com';
    END IF;
END $$

CREATE TRIGGER after_insert_order
AFTER INSERT ON prod_orders
FOR EACH ROW
BEGIN
    INSERT INTO audit_log (table_name, rows_inserted)
    VALUES ('prod_orders', 1);
END $$

DELIMITER ;
