CREATE VIEW thelook_dw.dt_customer AS(
  WITH singular_users AS(
    SELECT 
      email, 
      first_name, 
      last_name,
      age,
      gender,
      country,
      city,
      traffic_source,
      LAST_VALUE(created_at) OVER(PARTITION BY email ORDER BY id DESC) AS created_at
    FROM `bigquery-public-data.thelook_ecommerce.users`
    QUALIFY ROW_NUMBER() OVER(PARTITION BY email ORDER BY id DESC) = 1
  )

  SELECT 
    email, 
    first_name, 
    last_name, 
    CONCAT(first_name, ", ", last_name) AS full_name,
    age,
    CASE
      WHEN age < 18 THEN "<18"
      WHEN age < 25 THEN ">=18, <25"
      WHEN age < 35 THEN ">=25, <35"
      WHEN age < 60 THEN ">=45, <60"
      ELSE ">=60"
    END AS age_range,
    gender,
    country,
    city,
    traffic_source,
    created_at,
    ROUND(TIMESTAMP_DIFF(current_timestamp(), created_at, DAY) /  365) AS creation_lifespan_years
  FROM singular_users
)