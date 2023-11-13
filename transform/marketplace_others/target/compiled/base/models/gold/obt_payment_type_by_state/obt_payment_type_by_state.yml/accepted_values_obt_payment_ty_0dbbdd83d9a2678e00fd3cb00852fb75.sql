
    
    

with all_values as (

    select
        payment_type as value_field,
        count(*) as n_records

    from "postgres"."gold"."obt_payment_type_by_state"
    group by payment_type

)

select *
from all_values
where value_field not in (
    'boleto','debit_card','voucher','credit_card','not_defined'
)


