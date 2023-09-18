# Week 1 Project Questions

## How many users do we have?

select
  count(distinct user_id)
from
  dbt_bcchapactbluetechcom.stg_postgres__users

      # count(distinct user_id): 130

## On average, how many orders do we receive per hour?

with orders_by_hour as (
    select
      count(distinct order_id)
      , date_part('hour', created_at) as order_hour
from
  dbt_bcchapactbluetechcom.stg_postgres__orders
group by 2)

select
    avg(order_hour) as avg_order_per_hour
from
    orders_by_hour

    #11.5 orders per hour

## On average, how long does an order take from being placed to being delivered?

with order_placement_to_delivery_duration as(
   select
    order_id
    , datediff('day', created_at::timestamp, delivered_at::timestamp) as time_between
from
  dbt_bcchapactbluetechcom.stg_postgres__orders)

select
    avg(time_between)
from
    order_placement_to_delivery_duration

    # ~4 days on average between when an order is placed to when it is delivered

## How many users have only made one purchase? Two purchases? Three+ purchases?
### Note: you should consider a purchase to be a single order. In other words, if a user places one order for 3 products, they are considered to have made 1 purchase.

with order_counts as (select
    distinct users.user_id as users
    , count(distinct orders.order_id) as orders
from
  dbt_bcchapactbluetechcom.stg_postgres__users as users
left join dbt_bcchapactbluetechcom.stg_postgres__orders as orders on orders.user_id = users.user_id
group by 1)

, one_time_purchase as (select
        count(distinct order_counts.users)
    from order_counts
    where order_counts.orders = 1)
, two_time_purchases as (select
        count(distinct order_counts.users)
    from order_counts
    where order_counts.orders = 2)
, three_or_more_time_purchases as (select
        count(distinct order_counts.users)
    from order_counts
    where order_counts.orders >= 3)

select * from
    one_time_purchase 
    --two_time_purchases
    --three_or_more_time_purchases
    # one_time_purchase: 25
    # two_time_purchases: 28
    # three_or_more_time_purchases: 71

## On average, how many unique sessions do we have per hour?


with sessions_by_hour as (
    select
      count(distinct session_id)
      , date_part('hour', created_at) as session_hour
from
  dbt_bcchapactbluetechcom.stg_postgres__events
group by 2)

select
    avg(session_hour) as avg_order_per_hour
from
    sessions_by_hour

    #11.5 hours sessions per hour

