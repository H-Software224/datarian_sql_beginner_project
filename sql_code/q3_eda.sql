SELECT COUNT(DISTINCT id) AS order_cnt
FROM orders
WHERE customer_id = 1