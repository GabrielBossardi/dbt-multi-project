SELECT *
FROM {{ ref('obt_payment_type_by_state') }}
WHERE customer_state != 'SP'
