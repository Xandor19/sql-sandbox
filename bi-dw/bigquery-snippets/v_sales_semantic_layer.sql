CREATE VIEW thelook_dw.v_sales_semantic_layer AS (
  SELECT 
    ft_sales.*, 
    dt_customer.* EXCEPT(email), 
    dt_product.* EXCEPT(product_id), 
    dt_ticket_line.* EXCEPT(ticket_line_id), 
    dt_time.* EXCEPT(time_id)
  FROM `thelook_dw.ft_sales` as ft_sales LEFT JOIN
       `thelook_dw.dt_customer` AS dt_customer ON ft_sales.email = dt_customer.email LEFT JOIN
       `thelook_dw.dt_product` AS dt_product ON ft_sales.product_id = dt_product.product_id LEFT JOIN
       `thelook_dw.dt_ticket_line` AS dt_ticket_line ON ft_sales.ticket_line_id = dt_ticket_line.ticket_line_id LEFT JOIN
       `thelook_dw.dt_time` AS dt_time ON ft_sales.time_id = dt_time.time_id
)