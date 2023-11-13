
  
    

  create  table "postgres"."silver_sp"."obt_payment_type_by_sp_state__dbt_tmp"
  
  
    as
  
  (
    SELECT *
FROM "postgres"."gold"."obt_payment_type_by_state"
WHERE customer_state = 'SP'
  );
  