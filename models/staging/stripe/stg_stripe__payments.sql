SELECT
    id AS payment_id,
    orderid AS order_id,
    paymentmethod AS payment_method,
    status AS payment_status,
    amount,
    created AS payment_date
FROM
    stripe.payment