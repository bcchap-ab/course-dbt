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
events as (
    select
        *
    from
        {{ ref('stg_postgres__events') }}
),
order_items as (
    select
        *
    from
        {{ ref('stg_postgres__order_items') }}
    
)
select
    product_traffic.name
    , product_traffic.product_id
    , product_traffic.product_checkout
    , product_orders.inventory
    , product_orders.price
    , count(distinct session_id) as num_unique_sessions
    , {{ pct_formatter('product_checkout', 'num_unique_sessions') }} as overall_conversion_rate
from
    DEV_DB.DBT_BCCHAPACTBLUETECHCOM.STG_POSTGRES__EVENTS as events
    left join DEV_DB.DBT_BCCHAPACTBLUETECHCOM.PRODUCT_TRAFFIC as product_traffic on product_traffic.product_id = events.product_id
    left join DEV_DB.DBT_BCCHAPACTBLUETECHCOM.PRODUCT_ORDERS as product_orders on product_orders.name = product_traffic.name
where product_traffic.product_id is not null
group by 1, 2, 3, 4, 5
order by 1 asc
