WITH grouped_data AS (SELECT 
  country,
  ROUND(AVG(age)) AS avg_age,
  SUM(CASE WHEN gender = 'M' THEN 1 ELSE 0 END) - SUM(CASE WHEN gender = 'F' THEN 1 ELSE 0 END) AS male_female_diff
FROM `bigquery-public-data.thelook_ecommerce.users`
GROUP BY country)

SELECT
  country,
  avg_age AS age,
  CASE WHEN male_female_diff < 0 THEN male_female_diff * -1 ELSE male_female_diff END AS gender_difference,
  CASE WHEN male_female_diff > 0 THEN 'M' ELSE 'F' END AS majority
FROM grouped_data
ORDER BY majority, gender_difference DESC