{{
  config(
    materialized='table'
  )
}}

with products as (
    select
        *
    from
        {{ ref('stg_postgres__products') }}
),
order_items as (
    select
        *
    from
        {{ ref('stg_postgres__events') }}
)
select 
    products.name
    , sum(case when events.event_type = 'page_view' then 1 else 0 end) as product_page_views
    , sum(case when events.event_type = 'add_to_cart' then 1 else 0 end) as product_add_to_cart
    , sum(case when events.event_type = 'checkout' then 1 else 0 end) as product_checkout
from products
left join events on events.product_id = products.product_id
group by 1