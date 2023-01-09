
/*
    Welcome to your first dbt model!
    Did you know that you can also configure models directly within SQL files?
    This will override configurations stated in dbt_project.yml

    Try changing "table" to "view" below
*/

{{ config(materialized='table') }}

with source_category as (

    SELECT * FROM {{source('tickets','users')}}

),
final as(
select *
from source_category
)
SELECT * FROM final

/*
    Uncomment the line below to remove records with null `id` values
*/

-- where id is not null
