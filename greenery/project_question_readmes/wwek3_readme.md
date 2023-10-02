# Week 3 Project Questions

## Part 1 Create new models to answer the first two questions (answer questions in README file)

### What is our overall conversion rate?

select
count(
distinct (
case
when event_type = 'checkout' then session_id
end
)
) as num_unique_sessions_with_purchase
, count(distinct session_id) as num_unique_sessions,
, num_unique_sessions_with_purchase / num_unique_sessions \* 100 as overall_conversion_rate
from
DEV_DB.DBT_BCCHAPACTBLUETECHCOM.STG_POSTGRES\_\_EVENTS # 62.5% overall conversion rate

### What is our conversion rate by product?

select
product_traffic.name
, product_traffic.product_id
, product_traffic.product_checkout
, count(distinct session_id) as num_unique_sessions
, product_traffic.product_checkout / num_unique_sessions \* 100 as overall_conversion_rate
from
DEV_DB.DBT_BCCHAPACTBLUETECHCOM.STG_POSTGRES\_\_EVENTS as events
left join DEV_DB.DBT_BCCHAPACTBLUETECHCOM.PRODUCT_TRAFFIC as product_traffic on product_traffic.product_id = events.product_id
where product_traffic.product_id is not null
group by 1, 2, 3
order by 1 asc

| NAME                | PRODUCT_ID                           | PRODUCT_CHECKOUT | NUM_UNIQUE_SESSIONS | OVERALL_CONVERSION_RATE |
| ------------------- | ------------------------------------ | ---------------- | ------------------- | ----------------------- |
| Alocasia Polly      | 6f3a3072-a24d-4d11-9cef-25b0b5f8a4af | 21               | 51                  | 41.176500               |
| Aloe Vera           | 615695d3-8ffd-4850-bcf7-944cf6d3685b | 32               | 65                  | 49.230800               |
| Angel Wings Begonia | 58b575f2-2192-4a53-9d21-df9a0c14fc25 | 24               | 61                  | 39.344300               |
| Arrow Head          | 74aeb414-e3dd-4e8a-beef-0fa45225214d | 35               | 63                  | 55.555600               |
| Bamboo              | 689fb64e-a4a2-45c5-b9f2-480c2155624d | 36               | 67                  | 53.731300               |
| Bird of Paradise    | 05df0866-1a66-41d8-9ed7-e2bbcddd6a3d | 27               | 60                  | 45.000000               |
| Birds Nest Fern     | bb19d194-e1bd-4358-819e-cd1f1b401c0c | 33               | 78                  | 42.307700               |
| Boston Fern         | e2e78dfc-f25c-4fec-a002-8e280d61a2f2 | 26               | 63                  | 41.269800               |
| Cactus              | c17e63f7-0d28-4a95-8248-b01ea354840e | 30               | 55                  | 54.545500               |
| Calathea Makoyana   | b86ae24b-6f59-47e8-8adc-b17d88cbd367 | 27               | 53                  | 50.943400               |
| Devil's Ivy         | 35550082-a52d-4301-8f06-05b30f6f3616 | 22               | 45                  | 48.888900               |
| Dragon Tree         | 37e0062f-bd15-4c3e-b272-558a86d90598 | 29               | 62                  | 46.774200               |
| Ficus               | 843b6553-dc6a-4fc4-bceb-02cd39af0168 | 29               | 68                  | 42.647100               |
| Fiddle Leaf Fig     | e706ab70-b396-4d30-a6b2-a1ccf3625b52 | 28               | 56                  | 50.000000               |
| Jade Plant          | a88a23ef-679c-4743-b151-dc7722040d8c | 22               | 46                  | 47.826100               |
| Majesty Palm        | 5ceddd13-cf00-481f-9285-8340ab95d06d | 33               | 67                  | 49.253700               |
| Money Tree          | d3e228db-8ca5-42ad-bb0a-2148e876cc59 | 26               | 56                  | 46.428600               |
| Monstera            | be49171b-9f72-4fc9-bf7a-9a52e259836b | 25               | 49                  | 51.020400               |
| Orchid              | c7050c3b-a898-424d-8d98-ab0aaad7bef4 | 34               | 75                  | 45.333300               |
| Peace Lily          | e5ee99b6-519f-4218-8b41-62f48f59f700 | 27               | 66                  | 40.909100               |
| Philodendron        | 55c6a062-5f4a-4a8b-a8e5-05ea5e6715a3 | 30               | 62                  | 48.387100               |
| Pilea Peperomioides | 5b50b820-1d0a-4231-9422-75e7f6b0cecf | 28               | 59                  | 47.457600               |
| Pink Anthurium      | 80eda933-749d-4fc6-91d5-613d29eb126f | 31               | 74                  | 41.891900               |
| Ponytail Palm       | e18f33a6-b89a-4fbc-82ad-ccba5bb261cc | 28               | 70                  | 40.000000               |
| Pothos              | 4cda01b9-62e2-46c5-830f-b7f262a58fb1 | 21               | 61                  | 34.426200               |
| Rubber Plant        | 579f4cd0-1f45-49d2-af55-9ab2b72c3b35 | 28               | 54                  | 51.851900               |
| Snake Plant         | e8b6528e-a830-4d03-a027-473b411c7f02 | 29               | 73                  | 39.726000               |
| Spider Plant        | 64d39754-03e4-4fa0-b1ea-5f4293315f67 | 28               | 59                  | 47.457600               |
| String of pearls    | fb0e8be7-5ac4-4a76-a1fa-2cc4bf0b2d80 | 39               | 64                  | 60.937500               |
| ZZ Plant            | b66a7143-c18a-43bb-b5dc-06bb5d1d3160 | 34               | 63                  | 53.968300               |

### Why might certain products be converting at higher/lower rates than others?

    # Products with higher rates might be more advertised compared to those with lower rates. Another possibility is that the product themselves might have varying prices, resulting in products with higher prices being purchased at lower rates.

## Part 2 We’re getting really excited about dbt macros after learning more about them and want to apply them to improve our dbt project.

### Create a macro to simplify part of a model(s); 
    # Macro to format percentages.

## Part 3 We’re starting to think about granting permissions to our dbt models in our snowflake database so that other roles can have access to them.
    # models:
        greenery:
            +post-hook:
            - "{{ grant(role='reporting') }}"

## Part 4  After learning about dbt packages, we want to try one out and apply some macros or tests.
    # I installed dbt_utils and used dbt_utils.safe_divide and added it to my `pct_formatter.sql` macro that is referenced in `conversion_rates.sql`.

## Part 5 After improving our project with all the things that we have learned about dbt, we want to show off our work!
![dbt-dag](https://github.com/bcchap-ab/course-dbt/assets/114260865/16b3c2af-561b-41b7-994d-f6091d11d5d6)
