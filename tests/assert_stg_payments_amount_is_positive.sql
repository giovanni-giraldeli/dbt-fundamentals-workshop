-- Refunds have a negative amount, so the total amount should always be >= 0.
-- Therefore return records where this isn't true to make the test fail.

WITH payments AS (
    SELECT * FROM {{ ref('stg_stripe__payments') }}
)
SELECT
    order_id,
    SUM(amount) AS total_amount
FROM
    payments
GROUP BY
    order_id
HAVING
    total_amount < 0