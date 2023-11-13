WITH payment_value AS (

    SELECT
        order_id,
        payment_type,
        SUM(payment_value) AS total_payment_value
    FROM "postgres"."bronze"."olist_order_payments_dataset"
    GROUP BY 1, 2

),

final AS (

    SELECT
        payment_value.payment_type,
        olist_customers_dataset.customer_state,
        COUNT(DISTINCT payment_value.order_id) AS order_quantity,
        ROUND(AVG(total_payment_value)::numeric, 2) AS avg_payment_value
    FROM payment_value
    INNER JOIN "postgres"."bronze"."olist_orders_dataset" ON
        payment_value.order_id = olist_orders_dataset.order_id
    INNER JOIN "postgres"."bronze"."olist_customers_dataset" ON
        olist_orders_dataset.customer_id = olist_customers_dataset.customer_id
    GROUP BY 1, 2

)

SELECT
    payment_type,
    customer_state,
    order_quantity,
    avg_payment_value
FROM final
ORDER BY 1, 3 DESC