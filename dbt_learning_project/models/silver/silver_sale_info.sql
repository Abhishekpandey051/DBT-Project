with sales as (
    select
        sales_id,
        gross_amount,
        product_sk,
        customer_sk,
        payment_method,
        {{multiply('quantity', 'unit_price')}} AS cal_grosss_amount
    from {{ ref('bronze_sale') }}
),

product as (
    select
        product_sk,
        category
    from {{ ref('bronze_product') }}
),

customer as (
    select
        customer_sk,
        gender
    from {{ ref('bronze_customer') }}
),

joine_query AS (
select
    sales.sales_id,
    customer.gender,
    product.category,
    sales.payment_method,
    sales.gross_amount,
    sales.cal_grosss_amount
from sales
join product
    on sales.product_sk = product.product_sk
join customer
    on sales.customer_sk = customer.customer_sk
)

SELECT 
   category,
   gender,
   sum(gross_amount) as total_sales
   FROM joine_query
   GROUP BY category, gender
   ORDER BY
    total_sales desc
