SELECT MAX(paid_at) AS final_paid_at
FROM orders
WHERE customer_id = 1