WITH ranked_customers AS (
    SELECT *,
           ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY signup_date) AS row_num
    FROM stg_customers
)
SELECT customer_id,
       COALESCE(NULLIF(TRIM(customer_name), ''), 'Unknown') AS customer_name,
       COALESCE(NULLIF(TRIM(email), ''), 'no_email@dummy.com') AS email,
       CASE
         WHEN signup_date LIKE '%/%' THEN STR_TO_DATE(signup_date, '%Y/%m/%d')
         ELSE STR_TO_DATE(signup_date, '%Y-%m-%d')
       END AS clean_signup_date
FROM ranked_customers
WHERE row_num = 1;

