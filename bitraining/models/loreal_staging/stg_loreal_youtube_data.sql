
/*
    Welcome to your first dbt model!
    Did you know that you can also configure models directly within SQL files?
    This will override configurations stated in dbt_project.yml

    Try changing "table" to "view" below
*/

{{ config(materialized='table') }}

with source_loreal_youtube_data as (

    SELECT * FROM {{source('loreal_bigquerydata','loreal_youtube_data')}}

),
final as(
select *,
TRIM(SPLIT(insertion_order,"_")[SAFE_ORDINAL(1)]) AS Signature
from source_loreal_youtube_data
)
SELECT * FROM final

/*
    Uncomment the line below to remove records with null `id` values
*/