WITH order_payments AS (
    SELECT
        p.order_id,
        SUM( CASE WHEN p.status='success' THEN p.amount ELSE 0 END ) AS amount
    FROM
        {{ ref('stg_stripe__payments') }} AS p
    GROUP BY ALL
)
SELECT
    o.order_id,
    o.customer_id,
    o.order_date,
    COALESCE(p.amount, 0) AS amount
FROM
    {{ ref('stg_jaffle_shop__orders') }} AS o
LEFT JOIN
    order_payments AS p
        ON o.order_id = p.order_id
{{ limit_data_in_dev(column_name='order_date', dev_days_of_data=1000) }}