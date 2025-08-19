SELECT customers.id AS customers_id
      , customers.grades
      , DATE_FORMAT(customers.created_at, '%Y-%m-%d') AS customers_created_at
      , orders.id AS orders_id
      , orders.restaurant_id AS orders_restaurant_id
      , orders.order_type 
      , DATE_FORMAT(orders.paid_at, '%Y-%m-%d') AS customers_paid_at
      , DATE_FORMAT(orders.approved_at, '%Y-%m-%d') AS customers_approved_at
      , DATE_FORMAT(orders.delivered_at, '%Y-%m-%d') AS customers_delivered_at
      , payments.id AS payments_id
      , payments.payment_type
      , payments.payment_value
      , DATE_FORMAT(payments.paid_at, '%Y-%m-%d') AS payments_paid_at
FROM customers
INNER JOIN orders ON customers.id = orders.customer_id
INNER JOIN payments ON orders.id = payments.order_id
ORDER BY customers.id ASC