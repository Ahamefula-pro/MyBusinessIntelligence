/*
    Welcome to your first dbt model!
    Did you know that you can also configure models directly within SQL files?
    This will override configurations stated in dbt_project.yml

    Try changing "table" to "view" below
*/

{{ config(materialized='table') }}

WITH loreal_signature_data as (
    SELECT * FROM {{ref('stg_loreal_product_signature')}}
),

loreal_youtube_data AS (
    SELECT * FROM {{ref('stg_loreal_youtube_data')}}
),


-- CUSTOM LOGIC
joined AS (
    SELECT
    yd.*,
    /*yd.date,
    yd.partner,
    yd.advertiser_id,
    yd.signature,*/
    sd.product_brand
    FROM loreal_youtube_data yd 
    RIGHT JOIN loreal_signature_data sd ON  sd.Signature =yd.Signature
            --AND cu.Reporting_Date = wc.Reporting_Date  
),
   

final as(
select 
    *
from joined
)
SELECT * FROM final

/*
    Uncomment the line below to remove records with null `id` values
*/