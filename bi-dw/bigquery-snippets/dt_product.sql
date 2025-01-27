CREATE VIEW thelook_dw.dt_product AS(
  SELECT id AS product_id, name, category, brand FROM `bigquery-public-data.thelook_ecommerce.products`
)