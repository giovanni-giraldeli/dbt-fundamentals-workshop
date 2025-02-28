-- When you trigger the command 'dbt run', it will execute the scripts in the project
---- The default behavior is to create a view and run the whole project
---- If you want to create a table instead of a view, use the 'config' statement shown below
---- If you want to run only a specific script, trigger the command 'dbt run --select <script_name>'

/* This is already being configured more broadly for the folder in the "dbt_project.yml"
{{
    config(
        materialized='table'
    )
}}
*/

WITH customers_orders AS (
    SELECT
        customer_id,
        MIN(order_date) AS first_order_date,
        MAX(order_date) AS most_recent_order_date,
        COUNT(order_id) AS number_of_orders,
        SUM(amount) AS lifetime_value
    FROM
        {{ ref('fct_orders') }}
    GROUP BY
        customer_id
)
SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    co.first_order_date,
    co.most_recent_order_date,
    COALESCE(co.number_of_orders, 0) AS number_of_orders,
    COALESCE(co.lifetime_value, 0) AS lifetime_value
FROM
    {{ ref('stg_jaffle_shop__customers') }} AS c
LEFT JOIN
    customers_orders AS co
        ON co.customer_id = c.customer_id