WITH customers_order_payment AS (
  SELECT customers.id AS C_ID
        , DATE_FORMAT(MAX(delivered_at), '%Y-%m-%d') AS MAX_DELIVERED_AT
        , COUNT(DISTINCT orders.id) AS ORDER_CNT
        , SUM(payments.payment_value) AS TOTAL_SUM
  FROM customers
  INNER JOIN orders ON customers.id = orders.customer_id
  INNER JOIN payments ON payments.order_id = orders.id
  GROUP BY C_ID
  ORDER BY C_ID ASC
)
SELECT *
FROM customers_order_payment