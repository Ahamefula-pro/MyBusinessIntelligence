/*
    Welcome to your first dbt model!
    Did you know that you can also configure models directly within SQL files?
    This will override configurations stated in dbt_project.yml

    Try changing "table" to "view" below
*/

{{ config(materialized='table') }}

with source_loreal_product_signature as (

    SELECT * FROM {{source('loreal_bigquerydata','loreal_product_sig')}}

),


-- CUSTOM LOGIC
   

final as(
select 
    TRIM(SPLIT(string_field_0,";")[SAFE_ORDINAL(1)]) AS Signature,
    TRIM(SPLIT(string_field_0,";")[SAFE_ORDINAL(2)]) AS product_brand
from source_loreal_product_signature
)
SELECT * FROM final

/*
    Uncomment the line below to remove records with null `id` values
*/