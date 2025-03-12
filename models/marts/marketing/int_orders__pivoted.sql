-- Jinja >> lists, dicts, if, for
---- {% : start the Jinja statement logic
------ {%- : start the Jinja statement logic trimming whitespace before it
---- %} : end the Jinja statement logic
------ -%} : end the Jinja statement logic trimming whitespace after it
---- {% end<statement> %} : end statement execution
---- {{  }} : call a Jinja value
---- {# ... #} : comment

{%- set payment_methods = ['bank_transfer', 'coupon', 'credit_card', 'gift_card'] -%}

WITH payments AS (
    SELECT * FROM {{ ref('stg_stripe__payments') }}
)
, pivoted AS (
    SELECT
        order_id,
        {% for payment_method in payment_methods -%}

        SUM( CASE WHEN payment_method = '{{ payment_method }}' THEN amount ELSE 0 END ) AS {{payment_method}}_amount

        {%- if not loop.last -%}
        ,
        {% endif %}
        {%- endfor %}
    FROM
        payments
    WHERE
        status = 'success'
    GROUP BY ALL
)
SELECT * FROM pivoted