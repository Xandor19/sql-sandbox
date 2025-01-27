CREATE VIEW thelook_dw.ft_sales AS(
  SELECT 
    order_items.id AS ticket_line_id,
    users.email AS email,
    products.id AS product_id,
    orders.created_at AS time_id,
    TIMESTAMP_DIFF(orders.delivered_at, orders.created_at, DAY) AS days_from_creation_to_delivery,
    TIMESTAMP_DIFF(orders.shipped_at, orders.created_at, DAY) AS days_from_creation_to_shipment,
    TIMESTAMP_DIFF(orders.delivered_at, orders.shipped_at, DAY) AS days_from_shipment_to_deliver,
    1 AS total_products,
    products.retail_price AS gross_sales,
    CASE
      WHEN order_items.status IN ('Complete', 'Shipped', 'Processing') THEN order_items.sale_price
      ELSE 0 END 
    AS net_sales,
    products.retail_price - order_items.sale_price AS total_discount
  FROM `bigquery-public-data.thelook_ecommerce.products` AS products LEFT JOIN
       `bigquery-public-data.thelook_ecommerce.order_items` AS order_items ON products.id = order_items.id LEFT JOIN 
       `bigquery-public-data.thelook_ecommerce.orders` AS orders ON order_items.order_id = orders.order_id LEFT JOIN
       `bigquery-public-data.thelook_ecommerce.users` AS users ON orders.user_id = users.id
)