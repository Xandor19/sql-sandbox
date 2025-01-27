CREATE VIEW thelook_dw.dt_time AS(
  SELECT 
    created_at AS time_id,
    CAST(EXTRACT(YEAR FROM created_at) AS STRING) AS year,
    LPAD(CAST(EXTRACT(MONTH FROM created_at) AS STRING), 2, '0') AS month,
    LPAD(CAST(EXTRACT(DAY FROM created_at) AS STRING), 2, '0') AS day,
    CONCAT(
      CAST(EXTRACT(YEAR FROM created_at) AS STRING), 
      "_", 
      LPAD(CAST(EXTRACT(MONTH FROM created_at) AS STRING), 2, '0')) AS yyyy_mm,
    CONCAT(
      CAST(EXTRACT(YEAR FROM created_at) AS STRING), 
      "_", 
      LPAD(CAST(EXTRACT(MONTH FROM created_at) AS STRING), 2, '0'),
      "_",
      LPAD(CAST(EXTRACT(DAY FROM created_at) AS STRING), 2, '0')) AS yyyy_mm_dd
  FROM `bigquery-public-data.thelook_ecommerce.orders`