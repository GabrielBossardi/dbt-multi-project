
  
    

  create  table "postgres"."silver"."obt_payment_type_by_other_states__dbt_tmp"
  
  
    as
  
  (
    SELECT *
FROM "postgres"."gold"."obt_payment_type_by_state"
WHERE customer_state != 'SP'
  );
  