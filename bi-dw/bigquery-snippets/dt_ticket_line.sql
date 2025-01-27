CREATE VIEW thelook_dw.dt_ticket_line AS(
  SELECT
    order_items.id AS ticket_line_id,
    orders.order_id AS ticket_id,
    orders.status AS order_status,
    order_items.status AS order_line_status,
    orders.created_at AS order_created_at
  FROM `bigquery-public-data.thelook_ecommerce.order_items` AS order_items INNER JOIN 
       `bigquery-public-data.thelook_ecommerce.orders` AS orders ON order_items.order_id = orders.order_id
)