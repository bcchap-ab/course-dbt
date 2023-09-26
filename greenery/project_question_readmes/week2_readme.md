# Week 2 Project Questions

## Part 1 Models

### What is our user repeat rate?

--repeat rate = users who purchased 2 or more times / users who purchased
with num_of_orders_by_user as (
select
user_id
, count(order_id) as num_of_orders
from
DEV_DB.DBT_BCCHAPACTBLUETECHCOM.STG_POSTGRES\_\_ORDERS
group by
user_id
)
select
count(
distinct case
when num_of_orders >= 2 then user_id -- users who purchase 2 or more times
end
) / count(
distinct case
when num_of_orders > 0 then user_id -- users who purchased at all
end
) \* 100 as repeat_rate
from
num_of_orders_by_user

    #  Repeat rate of ~80%

### What are good indicators of a user who will likely purchase again? What about indicators of users who are likely NOT to purchase again? If you had more data, what features would you want to look into to answer this question?

    # Indicators of users who will likely purchase again:
        * Users associated with multiple events, specifically 'page_view'
        * Users with low shipping cost
        * Users who use promos (assuming they access promo via a platform where they are influenced to purchase)
    # Indicators of users who will not likely purchase again:
        * Users with only one-time events
        * Users with high shipping costs
    # Additional data to answer this question:
        * Returns or cancellations of orders
        * Time spent between 'checkout' event and 'page_view' and 'add_to_cart' events

### Explain the product mart models you added. Why did you organize the models in the way you did?

    # I organized the marts without intermediate models since they were fairly straightfoward and short calculations. Since the idea is for marts to  be surfaced and constructed with business logic to surface in dashboards and applications, simple and easy to follow logic is what I opted for.

![image](https://github.com/bcchap-ab/course-dbt/assets/114260865/831409fc-cb57-46f6-a3d0-36190d6f2996)

## Part 2 Tests

### What assumptions are you making about each model? (i.e. why are you adding each test?)

    # I already included tests in the first week, but I tested primarily for uniqueness and non-null values of primary keys for their respective tables.

### Did you find any “bad” data as you added and ran tests on your models? How did you go about either cleaning the data in the dbt model or adjusting your assumptions/tests?

    # No I didn't find any bad data.


