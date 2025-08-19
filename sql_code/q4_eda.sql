SELECT SUM(payments.payment_value) AS sum_sales
FROM orders
INNER JOIN payments ON orders.id = payments.order_id
WHERE customer_id = 1