-- When you trigger the command 'dbt run', it will execute the scripts in the project
---- The default behavior is to create a view and run the whole project
---- If you want to create a table instead of a view, use the 'config' statement shown below
---- If you want to run only a specific script, trigger the command 'dbt run --select <script_name>'

{{
    config(
        materialized='table'
    )
}}

WITH customers_orders AS (
    SELECT
        customer_id,
        MIN(order_date) AS first_order_date,
        MAX(order_date) AS most_recent_order_date,
        COUNT(order_id) AS number_of_orders
    FROM
        {{ ref('stg_jaffle_shop__orders') }}
    GROUP BY
        user_id
)
SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    co.first_order_date,
    co.most_recent_order_date,
    COALESCE(co.number_of_orders, 0) AS number_of_orders
FROM
    {{ ref('stg_jaffle_shop__customers') }} AS c
LEFT JOIN
    customers_orders AS co
        ON co.customer_id = c.id